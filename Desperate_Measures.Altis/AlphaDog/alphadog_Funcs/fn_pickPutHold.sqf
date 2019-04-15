 /*
    Filename: fn_pickPutHold.sqf
    Author: AlphaDog
    
    Description:
	Adds hold action to an object to simulate picking up intel, placing a tracker, etc.
	NOTE: Will be called on server!!!
   
    Parameter(s):
    0: Object  - The object to have the action applied to it.
    1: String - Custom action name.
    2: Number - Time for action to be completed
    3: Bool - Play animation when action is completed.
   
   Example:
   [object, "Some Custom Name", 5, true] call AD_fnc_pickPutHold;
*/

if (!isServer) exitwith {};

private["_obj", "_text", "_actionTime", "_playAnim", "_actionText"];
	
params [["_obj", objNull, [objNull], 1], ["_text", "", [""], 1], ["_actionTime", 2, [999], [0,1]], ["_playAnim", false, [true], [0,1]]];

if (isNull _obj) exitwith {["ERROR: Oject does not exist!"] call BIS_fnc_error; false};
if (_text == "") exitwith {["ERROR: Action text is empty!"] call BIS_fnc_error; false};

// Set custom name in text
_actionText = format ["<t color='#D22E2E'>%1</t>", _text];

// Track object value
_obj setVariable ["isPickPut_H", false, true];

[
	_obj,                                                                           	// Object the action is attached to
	_actionText,                                                                       	// Title of the action
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",                      			// Idle icon shown on screen
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",                     			 // Progress icon shown on screen
	"(_target distance _this < 3)",                                      // Condition for the action to be shown
	"((_caller distance _target < 3) && (!isNull _caller))",                                      // Condition for the action to progress
	{},                                                                                  // Code executed when action starts
	{},                                                                                  // Code executed on every progress tick
	{
		_target = _this select 0;
		_caller = _this select 1;
		_id = _this select 2;
		_animate = _this select 3 select 0;

		[_target, _id] remoteExec ["BIS_fnc_holdActionRemove", [0,-2] select (isMultiplayer && isDedicated), _target ];
		
		if (_animate) then
		{
			_unitPos = switch (toUpper (stance _caller)) do
						{
								case "STAND": {"erc"};
								case "CROUCH": {"knl"};
								case "PRONE": {"pne"};
							};

			_weaponType = switch (toLower (currentWeapon _caller)) do
						{
							case (toLower (primaryWeapon _caller)): {"rfl"};
							case (toLower (handgunWeapon _caller)): {"pst"};
							default {"non"};
						};
						
			// Ensure appropriate animation plays depending on stance and weapon
			_anim = format ["AmovP%1MstpSrasW%2Dnon_AinvP%1MstpSrasW%2Dnon_Putdown", _unitPos, _weaponType];
			_caller playMove _anim;
			sleep 1.5;
		};
		
		// Set variable to true
		_target setVariable ["isPickPut_H", true, true];
	},                                                									// Code executed on completion
	{},                                                                                  // Code executed on interrupted
	[_playAnim],                                                                           // Arguments passed to the scripts as _this select 3
	_actionTime,                                                                           // Action duration [s]
	10,                                                                                  // Priority
	true,                                                                                // Remove on completion
	false                                                                                // Show in unconscious state 
] remoteExec ["BIS_fnc_holdActionAdd",[0,-2] select (isMultiplayer && isDedicated),_obj];    

true