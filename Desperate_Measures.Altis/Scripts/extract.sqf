// Heli extract Phoenix Team
if (!isServer) exitWith {};

// Create extraction group and heli
_extCrew = createGroup west;
sleep 1.0;
_extVeh = [getMarkerPos "heliSpawnMkr", 270, "OPTRE_UNSC_falcon", _extCrew] call bis_fnc_spawnvehicle;
_extHeli = (_extVeh select 0);

// Create constant check to see if Heli is dead
[_extHeli] spawn
{
	waitUntil{sleep 1.0; !alive (_this select 0)};

	// Command messege
	[
		["Command","Kilo 1-3 is down! Leave the area any way you can! We'll eventually send someone else to get you. Out.",10.0,"RadioAmbient2"], AD_fnc_subtitle
	] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 5.0;
	
	// Create alternative "leave the area" extraction
	
	
	
};

_extCrew allowFleeing 0;
_extCrew setBehaviour "CARELESS";
vehControl action ["CollisionLightOff", _extHeli];
sleep 1.0;

// Waypoints to extraction
_wp1 = _extCrew addWaypoint [(getMarkerPos "extWp1"), 0];
[_extCrew, 0] setWaypointBehaviour "CARELESS";
_wp1 setWaypointType "MOVE";
_wp1 setWaypointSpeed "NORMAL";

_wp2 = _extCrew addWaypoint [(getPos extLZ), 1];
_wp2 setWaypointType "MOVE";
_wp2 setWaypointStatements ["true", "vehicle this land 'get in'"];
_wp2 setWaypointSpeed "LIMITED";

_wp3 = _extCrew addWaypoint [(getPos extLZ), 2];
_wp3 setWaypointType "MOVE";
_wp3 setWaypointStatements ["{(_x in vehicle this)} count units sabre == {alive _x} count units sabre", ""];

waitUntil {sleep 1.0; {!(_x in insHeli)} count units phoenix == {alive _x} count units phoenix};

// Create final waypoint
_wp4 = _extCrew addWaypoint [(getMarkerPos "heliExitMkr"), 3];
_wp4 setWaypointType "MOVE";
_wp4 setWaypointSpeed "NORMAL";

