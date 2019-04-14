 /*
    Filename: fn_hack.sqf
    Author: AlphaDog
    
    Description:
	Adds hold action to an object to simulate hacking something.
	NOTE: Will be called on server!!!
   
    Parameter(s):
    0: Object - The object to have the action applied to it.
    1: String - Custom action name.
    2: (Optional) Number - Time it takes to hack
   
   Example:
   [object, "Some Custom Name", 15] call AD_fnc_hack;
*/

if (!isServer) exitwith {};

private["_obj", "_text", "_hackTime", "_actionText"];

params [["_obj", objNull, [objNull], 1], ["_text", "", [""], 1], ["_hackTime", 10, [999], [0,1]]];
	
if (isNull _obj) exitwith {["ERROR: Oject does not exist!"] call BIS_fnc_error; false};
if (_text == "") exitwith {["ERROR: Action text is empty!"] call BIS_fnc_error; false};

// Track object value
_obj setVariable ["isHacked", false, true];

// Set custom name in text
_actionText = format ["<t color='#D22E2E'>%1</t>", _text];

// Create hack hold action for every connected client
[
	_obj,                                                                           		// Object the action is attached to
	_actionText,                                                                       	// Title of the action
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",                      			// Idle icon shown on screen
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",                     			 // Progress icon shown on screen
	"((_target distance _this < 3) && (alive _target))",                                      	// Condition for the action to be shown
	"((_caller distance _target < 3) && (alive _target) && (!isNull _this))",                   	// Condition for the action to progress
	{},                                                            						 // Code executed when action starts
	{																					// Code executed on every progress tick
		hint parseText "<t size='1.5' font='PuristaSemiBold' color='#FFFFFF'>Hacking...</t>"; 					
	},
	{																					// Code executed on completion
		_target = _this select 0;
		_id = _this select 2;
		
		playSound "hint";
		
		[_target, _id] remoteExec ["BIS_fnc_holdActionRemove", [0,-2] select (isMultiplayer && isDedicated), _target ];
		
		hint parseText "<t size='1.5' font='PuristaBold' color='#2EFE2E'>Hack Complete!</t>"; 

		// Set hack variable to false
		_target setVariable ["isHacked", true, true];
	},                                                									
	{																					// Code executed on interrupted
		hint parseText "<t size='1.5' font='PuristaBold' color='#D22E2E'>Hack Aborted!</t>";
		playSound "Simulation_Fatal";
	},                                                                 
	[],                                                                         	 // Arguments passed to the scripts as _this select 3
	_hackTime,                                                                            // Action duration [s]
	10,                                                                                  // Priority
	true,                                                                                // Remove on completion
	false                                                                                // Show in unconscious state 
] remoteExec ["BIS_fnc_holdActionAdd",[0,-2] select (isMultiplayer && isDedicated), _obj];

true 