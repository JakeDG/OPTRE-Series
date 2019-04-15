/*
    Filename: fn_clientLoaded.sqf
    Author: AlphaDog
    
    Description:
	Assigns the player object a variable to be used to indicate that the player is done loading. (Use in initPlayerLocal.sqf)
   
    Parameter(s):
    0: Object - A player object
   
   Example:
   [player] call AD_fnc_clientLoaded;
*/

private _unit = param [0, objNull, [objNull], 1];

if (isNull _unit) exitWith {["ERROR: Oject does not exist!"] call BIS_fnc_error; false};
if (!isPlayer _unit && hasInterface) exitWith {["ERROR: Oject is not a player!"] call BIS_fnc_error; false};

_unit setVariable ["isClientLoaded", true, true];

true

