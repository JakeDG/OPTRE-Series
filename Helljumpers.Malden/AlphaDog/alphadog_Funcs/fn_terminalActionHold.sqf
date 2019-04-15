/*
    Filename: fn_terminalActionHold.sqf
    Author: AlphaDog
    
    Description:
	Adds hold action to a data terminal to download intel from it. Option to have the terminal close after use and when action is interrupted.
	NOTE: Will be called on server!!!
   
    Parameter(s):
	0: Object  - The terminal to have the action applied to it.
	1: String - Custom action name.
	2: (Optional) String - Text displayed while doing the action.
	3: (Optional) String - Text displayed when action is done.
	4: (Optional) String - Text displayed when action is interrupted.
	5: (Optional) Boolean - Close the terminal after it's been hacked. Default - true
	6: (Optional) Boolean - Close the terminal when hold action is interrupted. Default - true
	7: (Optional) Number - Time in seconds it takes to action to complete. Default - 10 seconds
	
   Example:
   [terminal, "Some Custom Name", "downloading", "finished", "interrupted", false, false, 12] call AD_fnc_terminalActionHold;
*/

if (!isServer) exitwith {};

private ["_terminal", "_actionText", "_textTick", "_textDone", "_textInt", "_closeOnUse", "_closeOnInt", "_actionTime"];

params [["_terminal", objNull, [objNull], 1], ["_actionText", "", [""], 1], ["_textTick", "", [""], 1], ["_textDone", "", [""], 1], ["_textInt", "", [""], 1], ["_closeOnUse", true, [true], [0,1]], ["_closeOnInt", true, [true], [0,1]], ["_actionTime", 10, [999], [0,1]]];

if (!(_terminal isKindOf "Land_DataTerminal_01_F")) exitwith {["ERROR: %1 must be a data terminal", _terminal] call BIS_fnc_error; false};

if (_actionText == "") exitwith {["ERROR: Action text is empty!"] call BIS_fnc_error; false};
//if (_text == "" || _textTick == "" || _textDone == "" || _textInt == "") exitwith {["ERROR: Action text is empty!"] call BIS_fnc_error; false};

// Set custom name in text
_actionText = format ["<t color='#D22E2E'>%1</t>", _actionText];

// Create hack hold action for every connected client
[
	_terminal,                                                                           // Object the action is attached to
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
		_close = _this select 3 select 3;
		
		[_target, _id] remoteExec ["BIS_fnc_holdActionRemove", [0,-2] select (isMultiplayer && isDedicated), _target ];
		
		if (_text != "") then 
		{
			hint parseText format ["<t size='1.5' font='PuristaBold' color='#2EFE2E'>%1</t>", _text];
		};
		
		playSound "hint";
		
		// Set hack variable to false
		_target setVariable ["isTermComp", true, true];
		
		if (_close) then 
		{
			[_target, 0] call BIS_fnc_dataTerminalAnimate;
		};
	},                                                									
	{	// Code executed on interrupted
		_target = _this select 0;	
		_text = _this select 3 select 2;
		_close = _this select 3 select 4;
		
		if (_text != "") then
		{
			hint parseText format ["<t size='1.5' font='PuristaBold' color='#D22E2E'>%1</t>", _text];
		};
		playSound "Simulation_Fatal";
		
		if (_close) then 
		{
			[_target, 0] call BIS_fnc_dataTerminalAnimate;
		};
	},                                                                 
	[_textTick, _textDone, _textInt, _closeOnUse, _closeOnInt],                                                 // Arguments passed to the scripts as _this select 3
	_actionTime,                                                                            // Action duration [s]
	10,                                                                                  // Priority
	true,                                                                                // Remove on completion
	false                                                                                // Show in unconscious state 
] remoteExec ["BIS_fnc_holdActionAdd",[0,-2] select (isMultiplayer && isDedicated), _terminal];

true
