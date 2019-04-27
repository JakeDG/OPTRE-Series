/*
    Filename: fn_animHeliDoors.sqf
    Author: AlphaDog
    
    Description:
	Opens or closes Ghosthawk side doors.
   
    Parameter(s):
    0: Object  - The helicopter whose doors you wish to animate.
    1: String - Door animation. Can be "OPEN" or "CLOSE".
   
   Example:
   [this, "OPEN"] call AD_fnc_animHeliDoors;
*/

private["_heli","_doorState"];
	
params [["_heli", objNull, [objNull], 1], ["_doorState", "", [""], 1]];

_heliType = typeOf _heli;
_heliTypes = ["B_Heli_Transport_01_F","B_CTRG_Heli_Transport_01_sand_F","B_Heli_Transport_01_camo_F"];

if (!(_heliType in _heliTypes)) exitwith {["ERROR: Vehicle must be a type of Ghosthawk."] call BIS_fnc_error; false};

toUpper(_doorState);

if ((_doorState != "OPEN") && (_doorState != "CLOSE")) exitwith {["ERROR: Invalid door state! State must be OPEN or CLOSE."] call BIS_fnc_error; false};
 

switch (toUpper(_doorState)) do 
{
	case "OPEN": 
	{
		_heli animateDoor ['door_R', 1]; 
		_heli animateDoor ['door_L', 1];
	};
	case "CLOSE":
	{
		_heli animateDoor ['door_R', 0]; 
		_heli animateDoor ['door_L', 0];
	};
};

true 