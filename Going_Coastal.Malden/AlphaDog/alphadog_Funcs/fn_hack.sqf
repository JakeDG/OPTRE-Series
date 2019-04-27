 /*
    Filename: fn_hack.sqf
    Author: AlphaDog
    
    Description:
	Adds hold action to an object to simulate hacking something.
	NOTE: Will be called on server!!!
   
    Parameter(s):
    0: Object - The object to have the action applied to it.
    1: String - Custom action name.
    2: (Optional) String - Text displayed while doing the action.
    3: (Optional) String - Text displayed when action is done.
    4: (Optional) String - Text displayed when action is interrupted.
    5: (Optional) Number - Time it takes to hack - default: 10 seconds
   
   Example:
   [object, "Some Custom Name", "downloading", "finished", "interrupted", 12] call AD_fnc_hack;
*/

if (!isServer) exitwith {};

private ["_obj", "_actionText", "_textTick", "_textDone", "_textInt", "_actionTime"];

params [["_obj", objNull, [objNull], 1], ["_actionText", "", [""], 1], ["_textTick", "", [""], 1], ["_textDone", "", [""], 1], ["_textInt", "", [""], 1], ["_actionTime", 10, [999], [0,1]]];
	
if (isNull _obj) exitwith {["ERROR: Oject does not exist!"] call BIS_fnc_error; false};
if (_actionText == "") exitwith {["ERROR: Action text is empty!"] call BIS_fnc_error; false};

// Track object value
_obj setVariable ["isHacked", false, true];

// Set custom name in text
_actionText = format ["<t color='#D22E2E'>%1</t>", _actionText];

// Create hack hold action for every connected client
[
	_obj,                                                                           // Object the action is attached to
	_actionText,                                                                       	// Title of the action
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",                      			// Idle icon shown on screen
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",                     			 // Progress icon shown on screen
	"((_target distance _this < 3) && (alive _target))",                                      	// Condition for the action to be shown
	"((_caller distance _target < 3) && (alive _target) && (!isNull _this))",                   	// Condition for the action to progress
	{	 // Code executed when action starts
		_target = _this select 0;
		[_target, 3] call BIS_fnc_dataTerminalAnimate;
	},                                                            						
	{	// Code executed on every progress tick
		_text = _this select 3 select 0;
		if (_text != "") then 
		{
			hint parseText format ["<t size='1.5' font='PuristaSemiBold' color='#FFFFFF'>%1</t>", _text];
		};
	},
	{	// Code executed on completion																				
		_target = _this select 0;
		_id = _this select 2;
		_text = _this select 3 select 1;
		
		[_target, _id] remoteExec ["BIS_fnc_holdActionRemove", [0,-2] select (isMultiplayer && isDedicated), _target ];
		
		if (_text != "") then 
		{
			hint parseText format ["<t size='1.5' font='PuristaBold' color='#2EFE2E'>%1</t>", _text];
		};
		
		playSound "hint";
		
		// Set hack variable to true
		_target setVariable ["isHacked", true, true];
		
	},                                                									
	{	// Code executed on interrupted
		_target = _this select 0;	
		_text = _this select 3 select 2;
		
		if (_text != "") then
		{
			hint parseText format ["<t size='1.5' font='PuristaBold' color='#D22E2E'>%1</t>", _text];
		};
		playSound "Simulation_Fatal";
	},                                                                 
	[_textTick, _textDone, _textInt],                                                 // Arguments passed to the scripts as _this select 3
	_actionTime,                                                                            // Action duration [s]
	10,                                                                                  // Priority
	true,                                                                                // Remove on completion
	false                                                                                // Show in unconscious state 
] remoteExec ["BIS_fnc_holdActionAdd",[0,-2] select (isMultiplayer && isDedicated), _obj];

true