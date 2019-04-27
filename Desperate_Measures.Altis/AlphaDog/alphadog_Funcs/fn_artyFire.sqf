// This function will force the artillery to fire at a game logic at random intervals
// NOTE: Will be called on server!!!

if (!isServer) exitwith {};

private["_arty", "_logic", "_artyType", "_artyTypes"];
	
params [["_unit", objNull, [objNull], 1], ["_logic", objNull, [objNull], 1]];

_artyType = typeOf _arty;
_artyTypes = ["B_MBT_01_mlrs_F","B_MBT_01_arty_F","O_MBT_02_arty_F"];

if (!(_artyType in _artyTypes)) exitwith {["ERROR: %1 must be type of artillery vehicle", _unit] call BIS_fnc_error; false};

if (!(_logic isKindOf "Logic")) exitwith {["ERROR: %1 must be a game logic", _logic] call BIS_fnc_error; false};

// Make artillery face gun at target (target's height needs to be adjusted for the arty gun angle to change)
_arty doWatch (getPosATL _logic);
_arty doTarget _logic;

if (_artyType == "B_MBT_01_mlrs_F") then
{
	[_arty, _logic] spawn
	{	
		_artillery = _this select 0;
		_logic = _this select 1;
		
		sleep 5.0;
		
		while {alive _artillery} do
		{
			for "_i" from 1 to 3 do
			{
				_logic action ["useWeapon", _artillery, gunner _artillery, 1]; // Force artillery to fire
				sleep 1.5;
			};
			
			_artillery setVehicleAmmo 1;
			_rndTime = [15, 20, 25, 30, 35, 40, 45, 50, 55, 60] call BIS_fnc_selectRandom;
			sleep _rndTime;
		};
	};	
}
else
{
	[_arty, _logic] spawn
	{
		_artillery = _this select 0;
		_logic = _this select 1;
		
		sleep 5.0;
		
		while {alive _artillery} do 
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