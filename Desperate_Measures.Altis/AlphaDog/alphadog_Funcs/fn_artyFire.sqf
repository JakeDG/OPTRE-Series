// This function will force the artillery to fire at a game logic at random intervals
// NOTE: Will be called on server!!!

/*
    Filename: fn_clientLoaded.sqf
    Author: AlphaDog
    
    Description:
	Forces an artillery vehicle to fire at a game logic at random intervals. Will be called on server!
   
    Parameter(s):
    0: Object - An artillery vehicle
	1: Object - A game logic object
	
	Example:
	[arty, logic1, "marker"] call AD_fnc_artyFire;
*/

if (!isServer) exitWith {};

private["_arty", "_logic", "_marker", "_artyType", "_artyTypes"];
	
params [["_arty", objNull, [objNull], 1], ["_logic", objNull, [objNull], 1], ["_marker", "", [""], [0,1]]];

_artyType = typeOf _arty;
//_artyTypes = ["B_MBT_01_mlrs_F","B_MBT_01_arty_F","O_MBT_02_arty_F"];
//if (!(_artyType in _artyTypes)) exitWith {["ERROR: %1 must be type of artillery vehicle", _arty] call BIS_fnc_error; false};

if (!(_logic isKindOf "Logic")) exitWith {["ERROR: %1 must be a game logic", _logic] call BIS_fnc_error; false};

// Make artillery face gun at target (target's height needs to be adjusted for the arty gun angle to change)
_arty doWatch (getPosATL _logic);
_arty doTarget _logic;

// MLRS system
if (_artyType == "B_MBT_01_mlrs_F" || _artyType == "I_Truck_02_MRL_F") then
{
	[_arty, _logic, _marker] spawn
	{	
		_artillery = _this select 0;
		_logic = _this select 1;
		_marker = _this select 2;
		
		if (_marker == "") exitWith {["ERROR: Marker field is blank. A marker is needed for MLRS Artillery."] call BIS_fnc_error; false};
		
		_pos = markerPos _marker;
		
		sleep 10.0;
		
		while {alive _artillery && alive gunner _artillery} do
		{
			_shots = floor(random 8);
			_artillery commandArtilleryFire [_pos, "12Rnd_230mm_rockets", _shots];
			_artillery setVehicleAmmo 1;
			_rndTime = [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75] call BIS_fnc_selectRandom;
			sleep _rndTime;
		};
	};	
}
else // Normal artillery
{
	[_arty, _logic] spawn
	{
		_artillery = _this select 0;
		_logic = _this select 1;
		
		sleep 10.0;
		
		while {alive _artillery && alive gunner _artillery} do 
		{
			_logic action ["useWeapon", _artillery, gunner _artillery, 1]; // Force artillery to fire
			sleep 1.0;
			_artillery setVehicleAmmo 1;
			_rndTime = [15, 20, 25, 30, 35, 40, 45, 50, 55, 60] call BIS_fnc_selectRandom;
			sleep _rndTime;
		};
	};
};

true 