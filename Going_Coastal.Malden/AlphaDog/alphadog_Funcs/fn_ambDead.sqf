/*
    Filename: fn_ambDead.sqf
    Author: AlphaDog
    
    Description:
	Create an ambient dead body
   
    Parameter(s):
	0: Object - The unit that becomes an ambient dead body.
	1: String - The animation that the dead body plays. 
	2: (Optional) Boolean - Clear units inventory except clothes, helmets, etc.
	3: (Optional) Boolean - Spawn blood on units position - Default: false
   
   Example:
   [this, "LAY_SIDE_1", true, false] call AD_fnc_ambDead;
*/

private["_unit", "_anim", "_remGear", "_blood", "_inval"];

params [["_unit", objNull, [objNull], 1], ["_anim", "", [""], 1], ["_remGear", false, [true], [0,1]], ["_blood", false, [true], [0,1]]];

// EXAMPLE: [this, "LAY_SIDE_1", true] call AD_fnc_ambDead;

_inval = false;

if (isNull _unit) exitWith {["ERROR: The unit doesn't exist!"] call BIS_fnc_error; false};
if !(_unit isKindOf "man") exitWith {["ERROR: The unit isn't a type of man"] call BIS_fnc_error; false};

if (_remGear) then // Remove weapons, mags, and items from unit (leaving worn gear untouched)
{
	removeAllWeapons _unit; 
	{_unit removeMagazineGlobal _x;} foreach (magazines _unit);
	{_unit unassignItem _x; _unit removeItem _x;} foreach (assignedItems _unit);
};

_unit setCaptive true;
_unit disableAI "ANIM";
_unit disableAI "MOVE";
	
switch (toUpper(_anim)) do 
{	
	case "SIT_1": 
	{	
		[_unit] spawn
		{	
			(_this select 0) switchMove "KIA_commander_sdv"; // Can only be used on flat level areas
			sleep 5.0;
			(_this select 0) enableSimulation false;
		};
	};
	
	case "SIT_2": 
	{	
		[_unit] spawn
		{	
			(_this select 0) switchMove "KIA_passenger_flatground"; // Can only be used on flat level areas
			sleep 5.0;
			(_this select 0) enableSimulation false;
		};
	};
	
	case "SIT_3": 
	{	
		[_unit] spawn
		{	
			(_this select 0) switchMove "Acts_SittingWounded_out"; // Can only be used on flat level areas
			sleep 5.0;
			(_this select 0) enableSimulation false;
		};
	};
	
	case "LAY_STOMACH_1": 
	{
		[_unit] spawn
		{	
			(_this select 0) switchMove "KIA_passenger_boat_holdright"; // Can only be used on flat level areas
			sleep 5.0;
			(_this select 0) enableSimulation false;
		};
	};
	
	case "LAY_STOMACH_2": 
	{
		[_unit] spawn
		{	
			(_this select 0) switchMove "DeadState"; // Can only be used on flat level areas
			sleep 5.0;
			(_this select 0) enableSimulation false;
		};
	};
	
	case "LAY_SIDE_1":
	{	
		[_unit] spawn
		{	
			(_this select 0) switchMove "KIA_driver_boat01"; // Can only be used on flat level areas
			sleep 5.0;
			(_this select 0) enableSimulation false;
		};
	};
	
	case "LAY_SIDE_2":
	{
		[_unit] spawn
		{	
			(_this select 0) switchMove "KIA_gunner_standup01"; // Can only be used on flat level areas
			sleep 5.0;
			(_this select 0) enableSimulation false;
		};
	};
		
	case "LAY_BACK": 
	{
		[_unit] spawn
		{	
			(_this select 0) switchMove "Static_Dead"; // Can only be used on flat level areas
			sleep 5.0;
			(_this select 0) enableSimulation false;
		};
	};
	
	default
	{
		_inval = true;
		if (_inval) exitwith {["ERROR: Animation %1 is invalid", _anim] call BIS_fnc_error; false};
	};
};

_unit setDamage 1;

if (_blood) then
{
	_bloodSpot = createSimpleObject ["a3\characters_f\blood_splash.p3d", getPosWorld _unit]; 
	_bloodSpot setDir (random 360);
};
true 