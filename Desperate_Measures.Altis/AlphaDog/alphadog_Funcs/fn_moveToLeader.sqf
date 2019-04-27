/*
    Filename: fn_moveToLeader.sqf
    Author: AlphaDog
    
    Description:
	Moves a unit to a safe position near it's group leader. If the leader is in a vehicle with an open position then the unit will be moved inside the leader's vehicle. If the unit is the leader of the squad then the function returns an empty array.
   
    Parameter(s):
    0: Object  - The unit that is going to be moved to it's leader
	1: (Optional) Number  - The min distance the unit can be placed from the leader. (Default: 1)
	2: (Optional) Number  - The max distance the unit can be placed from the leader. (Default: 75)
	
   Returns: Array [x,y] - the position the unit was moved to
   
   Example:
   [player, 5, 100] call AD_fnc_animHeliDoors;
*/

private["_unit", "_leader", "_minDist","_maxDist","_leader","_leaderVeh","_movePos"];
	
params [["_unit", objNull, [objNull], 1],["_minDist", 1, [999], [0,1]],["_maxDist", 75, [999], [0,1]]];

if (isNull _unit || !alive _unit) exitwith {["ERROR: Unit does not exist or the unit is dead!"] call BIS_fnc_error; false};
if (leader _unit == objNull) exitwith {["ERROR: Leader of the unit is dead"] call BIS_fnc_error; false};

_leader = leader _unit;
_leaderVeh = vehicle _leader;
_movePos = [];

// Move to squad leader
if (_leader != _unit) then 
{
	if (_leaderVeh != _leader) then // Squad leader is in a vehicle
	{
		if (((_leaderVeh emptyPositions "cargo") > 0) || ((_leaderVeh emptyPositions "gunner") > 0) || ((_leaderVeh emptyPositions "commander") > 0) || ((_leaderVeh emptyPositions "driver") > 0)) then 
		{
			_unit moveInAny _leaderVeh; // Move player into any open position in the leaders vehicle
		}
		else	// squad leaders vehicle is full
		{
			_movePos = [_leader, _minDist, _maxDist, 3, 0, 10, 0, [], [getPos _leader, getPos _leader]] call BIS_fnc_findSafePos; // Find safe position near squad leader
			_unit setPos _movePos;
		};
	}
	else // Squad leader is on foot
	{
		_movePos = [_leader, _minDist, _maxDist, 3, 0, 10, 0, [], [getPos _leader, getPos _leader]] call BIS_fnc_findSafePos; // Find safe position near squad leader
		_unit setPos _movePos;
	};
};

_movePos = getPos _unit;
_movePos 