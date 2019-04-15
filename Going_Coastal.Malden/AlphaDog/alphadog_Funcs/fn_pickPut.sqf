 /*
    Filename: fn_pickPut.sqf
    Author: AlphaDog
    
    Description:
	Adds action to an object to simulate picking up intel, placing a tracker, etc.
	NOTE: Will be called on server!!!
   
    Parameter(s):
    0: Object  - The object to have the action applied to it.
    1: String - Custom action name.
   
   Example:
   [object, "Some Custom Name"] call AD_fnc_pickPut;
*/

if (!isServer) exitwith {};

private["_obj", "_text", "_actionText"];
params [["_obj", objNull, [objNull], 1], ["_text", "", [""], 1]];

if (isNull _obj) exitwith {["ERROR: Oject does not exist!"] call BIS_fnc_error; false};
if (_text == "") exitwith {["ERROR: Action text is empty!"] call BIS_fnc_error; false};

// Set custom name in text
_actionText = format ["<t color='#D22E2E'>%1</t>", _text];

// Add action to object for all players and JIPs
[_obj, 
	[ 	
		_actionText,
		{	
			_target = _this select 0;
			_caller = _this select 1;
			_id = _this select 2;

			if (!isNull _caller) then
			{
				[_target, _id] remoteExec ["removeAction",[0,-2] select (isMultiplayer && isDedicated),true];

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
				sleep 1.25;

				// Set object variable to false
				_target setVariable ["isPickPut", true, true];
			};
		},
		"",
		10,
		true,
		true,
		"",
		"((_target distance _this < 3) && (alive _target))"
	] 
] remoteExec [ "addAction", [0,-2] select (isMultiplayer && isDedicated), true ];

// Track object value
_unit setVariable ["isPickPut", false, true];

true