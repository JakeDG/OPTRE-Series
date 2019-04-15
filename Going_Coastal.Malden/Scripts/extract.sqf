// A Pelican is sent to extract Phoenix and the HVT

if (!isServer) exitWith {};

// Create Pelican crew and vehicle
_extCrew = createGroup west;
sleep 1.0;
_extVeh = [getMarkerPos "pelSpawnMkr", 240, "OPTRE_Pelican_armed", _extCrew] call bis_fnc_spawnvehicle;
_extPel = (_extVeh select 0);

// Set Marker and LZ
_extMkr = createMarker ["extMkr", (getPos extLZ)];
_extMkr setMarkerText "Extraction";
_extMkr setMarkerColor "ColorBlufor";
_extMkr setMarkerType "hd_pickup";

// Create extraction task
[phoenix, ["extTask", "<marker name='extMkr'>Extract</marker> from the area via <font color='#469CED'>Kilo 3-1's Pelican</font>", "Extract with HVT","Extract", _extPel, "assigned"]] call FHQ_fnc_ttAddTasks;

// Create constant check to see if extract pelican is dead
[_extPel] spawn
{
	waitUntil{sleep 1.0; !alive (_this select 0)};
	
	["Command", "Kilo 3-1 is down! Mission failed!", 10] call AD_fnc_subtitle;
	sleep 5.0;
	["End_PelCrewDead",false,true,true] call BIS_fnc_endMission;
};

_extCrew allowFleeing 0;
_extCrew setBehaviour "CARELESS";
vehControl action ["CollisionLightOff", _extPel];
sleep 1.0;

// Create a green smoke and marker at extraction point
[_extPel] spawn 
{
	waitUntil {((_this select 0) distance extLZ) < 250};
	
	while {({(_x in (_this select 0))} count units phoenix != {alive _x} count units phoenix)} do 
	{
		"SmokeShellGreen" createVehicle (getPos extLZ);
		sleep 25;
	};
};

// Waypoints to extraction
_wp1 = _extCrew addWaypoint [(getMarkerPos "extWp_1"), 0];
[_extCrew, 0] setWaypointBehaviour "CARELESS";
_wp1 setWaypointType "MOVE";
_wp1 setWaypointSpeed "NORMAL";
	
_wp2 = _extCrew addWaypoint [(getMarkerPos "extWp_2"), 1];
_wp2 setWaypointType "MOVE";

_wp3 = _extCrew addWaypoint [(getMarkerPos "extWp_3"), 2];
_wp3 setWaypointType "MOVE";

_wp4 = _extCrew addWaypoint [(getPos extLZ), 3];
_wp4 setWaypointType "MOVE";
_wp4 setWaypointStatements ["true", "vehicle this land 'get in'"];
_wp4 setWaypointSpeed "LIMITED";

_wp5 = _extCrew addWaypoint [(getPos extLZ), 4];
_wp5 setWaypointType "MOVE";
_wp5 setWaypointStatements ["{(_x in vehicle this)} count units phoenix == {alive _x} count units phoenix", ""];

// Wait until Pelican has landed
waitUntil {sleep 1.0; getPosATL _extPel select 2 < 2};

// Open cargo doors
_extPel animate ["cargoDoor_1",1]; 
_extPel animate ["cargoDoor_2",1];

// Pelican message
[["RadioAmbient2"],AD_fnc_soundAmp] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
["Kilo 3-1", "Phoenix, I've touched down. Let's get you guys home. Load the HVT and jump in when you're ready.", 10] call AD_fnc_subtitle;
[
	[
		"Kilo 3-1",
		"Phoenix, I've touched down. Let's get you guys home. Load the HVT and jump in when you're ready.",
		10,
		"RadioAmbient2"
	], AD_fnc_subtitle
] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];

// Wait until everyone is in Pelican 
waitUntil {sleep 1.0; ({(_x in _extPel)} count units phoenix == {alive _x} count units phoenix) };

// Play music
"Lone_Wolf" remoteExec ["playMusic",[0,-2] select (isMultiplayer && isDedicated)];

// Lock the heli doors
[_extPel,true] remoteExec ["lock", [0,-2] select (isMultiplayer && isDedicated), true];
sleep 1.0;

// Pelican message
[["RadioAmbient6"],AD_fnc_soundAmp] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
["Kilo 3-1", "Alright, we're outta' here. Command, this is Kilo 3-1, Phoenix and the HVT are aboard. We are RTB, out.", 10] call AD_fnc_subtitle;

// Create final waypoint
_wp6 = _extCrew addWaypoint [(getMarkerPos "pelSpawnMkr"), 6];
_wp6 setWaypointType "MOVE";
_wp6 setWaypointSpeed "NORMAL";

// Complete officer protection task as well as prim tasks and extract task

["officerAliveTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
sleep 3.0;
["extTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
sleep 5.0;
["primTasks", "succeeded"] call FHQ_fnc_ttSetTaskState;

[15, 0.25] remoteExec ["fadeSound", [0,-2] select (isMultiplayer && isDedicated)];
sleep 10.0;

[] remoteExec ["AD_fnc_thanks", [0,-2] select (isMultiplayer && isDedicated)];
sleep 20;

activateKey "MissionCompleted";
sleep 1.0;
["End_Win",true,true,false] remoteExec ["BIS_fnc_endMission"];
