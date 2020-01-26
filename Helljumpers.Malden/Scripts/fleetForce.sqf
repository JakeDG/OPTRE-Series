// Creates the fleet that flys in over the old base at the end of the mission

// Spawn Pelicans
_pel1 = [[6848.15,13676,300], 180, "OPTRE_Pelican_armed", west] call bis_fnc_spawnvehicle;
[(_pel1 select 0), ["colormarine",1], true] call BIS_fnc_initVehicle;
//(_pel1 select 0) setCaptive true;
sleep 0.5;

_pel2 = [[6140.13,13941.1,300], 180, "OPTRE_Pelican_armed", west] call bis_fnc_spawnvehicle;
[(_pel2 select 0), ["colormarine",1], true] call BIS_fnc_initVehicle;
//(_pel2 select 0) setCaptive true;
sleep 0.5;

// Set waypoints
_pel1Wp1 = (_pel1 select 2) addWaypoint [(getMarkerPos "pel1WpMkr"), 0]; // Pelican 1 waypoints
_pel1Wp1 setWaypointType "HOLD";

_pel2Wp1 = (_pel2 select 2) addWaypoint [(getMarkerPos "pel2WpMkr"), 0]; // Pelican 2 waypoints
_pel2Wp1 setWaypointType "HOLD";

// Create frigates -- Frigates removed in OPTRE v0.20
/*
_ship1 = "OPTRE_Frigate_Paris_Class" createVehicle [6752.89,12805.3,500];
_ship1 setDir 0;
sleep 1.0;

_ship2 = "OPTRE_Frigate_Charon_Class" createVehicle [6000.84,12816.6,500];
_ship2 setDir 0;

// Move frigates
_moveDone1 = [_ship1] spawn 
		{
			_ship1 = _this select 0;
			for "_i" from 0 to 2400 do 
			{ 
				_ship1 setPosASL [(getPosASL _ship1) select 0, ((getPosATL _ship1) select 1) -1, 500]; 
				sleep 0.01;
			};
		}; 
		
/* [_ship1] spawn 
{
	_ship1 = _this select 0;
	for "_i" from 0 to 3800 do 
	{ 
		_shipPos = _ship1 modelToWorld [0,-1,0]; 
		_relPos = AGLToASL [_shipPos select 0, _shipPos select 1, 500]; 
		_ship1 setPosASL _relPos; 
		sleep 0.01;
	};
};  */
/*
_moveDone2 = [_ship2] spawn 
{
	_ship2 = _this select 0;
	for "_i" from 0 to 2100 do 
	{ 
		_ship2 setPosASL [(getPosASL _ship2) select 0, ((getPosATL _ship2) select 1) -1, 600]; 
		sleep 0.01;
	};
};*/
sleep 50;

// Make enemy AI surrender
[] spawn
{
	{
		if (side _x == east && alive _x) then
		{
			if (!isNull objectParent _x) then // Unit is in a vehicle 
			{
				[_x] spawn 
				{
					_unit = _this select 0;
					
					// Force out of vehicle
					_unit leaveVehicle (vehicle _unit);
					{doGetOut _x;} forEach units (group _unit);
					
					waitUntil {sleep 0.25; (vehicle _unit == _unit)};
					removeAllWeapons _unit;
					_unit playMoveNow "AmovPercMstpSsurWnonDnon";
					_unit setCaptive true;
					_unit disableAI "ANIM";
					sleep 0.25;
				};
			}
			else
			{
				removeAllWeapons _x;
				_x playMoveNow "AmovPercMstpSsurWnonDnon";
				_x setCaptive true;
				_x disableAI "ANIM";
			};
		};
		
		sleep 0.5;
		
	} forEach allUnits;
};

// Objectives complete
["defendTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
sleep 3.0;
["primTasks", "succeeded"] call FHQ_fnc_ttSetTaskState;
sleep 3.0;

// Command message
		[
			[
				"Command",
				"Gentlemen, sorry we're late. Excellent job holding the base. We'll take it from here. Command out.",
				10,
				"RadioAmbient6"
			], AD_fnc_subtitle
		] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
sleep 12.0;

[] remoteExec ["AD_fnc_thanks", [0,-2] select (isMultiplayer && isDedicated)];
sleep 17.0;

// Complete mission
activateKey "MissionCompleted";
["End_Win",true,true,false] remoteExec ["BIS_fnc_endMission"];
