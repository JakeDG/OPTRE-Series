/*
    Filename: fn_hostage.sqf
    Author: AlphaDog
    
    Description:
	Makes the unit a hostage with an action to free them. Plays animations for being held captive and being released. Disables AI movement and animation. Option to add custom text to action and disable AI movement and animation.
	NOTE: Will be called on server!!!
   
    Parameter(s):
    0: Object  - The unit that has the action applied to them.
    1: (Optional) String - Custom action text.
   
   Example:
   [this, "Some Custom Name"] call AD_fnc_hostage;
*/

if (!isServer) exitwith {};

private["_unit", "_text", "_actionText"];
	
params [["_unit", objNull, [objNull], 1], ["_text", "", [""], [0,1]]];

if (!(_unit isKindOf "man")) exitwith {["ERROR: %1 must be type of man", _unit] call BIS_fnc_error; false};

// Set custom name in text
if (_text == "") then 
{
	_actionText = "Release <t color='#D22E2E'>Captive</t>";
}
else
{
	_actionText = format ["Release <t color='#D22E2E'>%1</t>", _text];
};

// Switch to captured animation
[_unit, "Acts_AidlPsitMstpSsurWnonDnon03"] remoteExec ["switchMove", [0,-2] select (isMultiplayer && isDedicated), _unit ];

// Track if unit is captured or not
_unit setVariable ["isHostage", true, true];

[
	_unit,                                                                           	// Object the action is attached to
	_actionText,                                                                       	// Title of the action
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa",                      			// Idle icon shown on screen
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa",                     			 // Progress icon shown on screen
	"((_target distance _this < 3) && (alive _target))",                                      	// Condition for the action to be shown
	"((_caller distance _target < 3) && (alive _target) && (!isNull _caller))",                    // Condition for the action to progress
	{},                                                                                  // Code executed when action starts
	{},                                                                                  // Code executed on every progress tick
	{
		_target = _this select 0;
		_id = _this select 2;
			
		[_target, _id] remoteExec ["BIS_fnc_holdActionRemove", [0,-2] select (isMultiplayer && isDedicated), _target ];
		[_target, "Acts_AidlPsitMstpSsurWnonDnon_out"] remoteExec ["playMoveNow", [0,-2] select (isMultiplayer && isDedicated), _target ];
			
		// Set hostage variable to false
		_target setVariable ["isHostage", false, true];
	},                                                									// Code executed on completion
	{},                                                                                  // Code executed on interrupted
	[],                                                                           // Arguments passed to the scripts as _this select 3
	5,                                                                                  	// Action duration [s]
	10,                                                                                  // Priority
	true,                                                                                // Remove on completion
	false                                                                                // Show in unconscious state 
] remoteExec ["BIS_fnc_holdActionAdd",[0,-2] select (isMultiplayer && isDedicated),_unit];    

true