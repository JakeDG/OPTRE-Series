// Heli extract Phoenix Team
if (!isServer) exitWith {};

// Create extraction group and heli
_extCrew = createGroup west;
sleep 1.0;
_extVeh = [getMarkerPos "heliSpawnMkr", 270, "OPTRE_UNSC_falcon", _extCrew] call bis_fnc_spawnvehicle;
_extHeli = (_extVeh select 0);

_extCrew allowFleeing 0;
_extCrew setBehaviour "CARELESS";
vehControl action ["CollisionLightOff", _extHeli];
sleep 1.0;

// Waypoints to extraction
_wp1 = _extCrew addWaypoint [(getMarkerPos "extWp1"), 0];
[_extCrew, 0] setWaypointBehaviour "CARELESS";
_wp1 setWaypointType "MOVE";
_wp1 setWaypointSpeed "NORMAL";

_wp1 = _extCrew addWaypoint [(getMarkerPos "extWp2"), 1];
_wp1 setWaypointType "MOVE";
_wp1 setWaypointSpeed "NORMAL";

_wp2 = _extCrew addWaypoint [(getPos extLZ), 2];
_wp2 setWaypointType "MOVE";
_wp2 setWaypointStatements ["true", "vehicle this land 'get in'"];
_wp2 setWaypointSpeed "LIMITED";

_wp3 = _extCrew addWaypoint [(getPos extLZ), 3];
_wp3 setWaypointType "MOVE";
_wp3 setWaypointStatements ["{(_x in vehicle this)} count units phoenix == {alive _x} count units phoenix", ""];

//waitUntil {sleep 1.0; {!(_x in _extHeli)} count units phoenix == {alive _x} count units phoenix};

// Create final waypoint
_wp4 = _extCrew addWaypoint [(getMarkerPos "heliExitMkr"), 4];
_wp4 setWaypointType "MOVE";
_wp4 setWaypointSpeed "NORMAL";

// Extracted, end mission
[_extHeli] spawn
{
	_extHeli = _this select 0;
	
	waitUntil {sleep 1.0; ({(_x in _extHeli)} count units phoenix == {alive _x} count units phoenix) || !alive _extHeli || !alive driver _extHeli};
	
	if (alive _extHeli) then // Heli is alive
	{
		["extTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
		
		// Delete the music event handler
		if (("Music" call BIS_fnc_getParamValue) == 1) then 
		{
			if (isDedicated) then
			{
				[["MusicStop", ehID]] remoteExec ["removeMusicEventHandler",-2,true]; // Remove everyones music event handlers
			}
			else
			{
				removeMusicEventHandler ["MusicStop", ehID]; // remove player host music event handler
			};
		};
		
		// Start end music
		[1,0] remoteExec ["fadeMusic", [0,-2] select (isMultiplayer && isDedicated)];
		//[10,0.35] remoteExec ["fadeSound", [0,-2] select (isMultiplayer && isDedicated)];
		sleep 1.0;
		"LoneWolf" remoteExec ["playMusic",[0,-2] select (isMultiplayer && isDedicated)];
		[10,1] remoteExec ["fadeMusic", [0,-2] select (isMultiplayer && isDedicated)];
		sleep 3.0;
		
		[] remoteExec ["AD_fnc_thanks", [0,-2] select (isMultiplayer && isDedicated)];
		sleep 35.0;
		
		activateKey "MissionCompleted";
		sleep 1.0;
		["End_Win",true,true,false] remoteExec ["BIS_fnc_endMission"];
	}
	else // Heli is dead or heli pilot is dead
	{
		// Fail extract task
		["extTask", "failed"] call FHQ_fnc_ttSetTaskState;
		
		// Command messege
		[
			["Command","Kilo 1-3 is down! We can't risk sending in more birds. Phoenix, you are to leave the area any way you can! Command out.",10.0,"RadioAmbient2"], AD_fnc_subtitle
		] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
		sleep 8.0;
		
		// Create area markers
		"|extMkr_1|[5405.56,17913.1]|Empty|ELLIPSE|[1000,1000]|0|FDiagonal|colorOPFOR|1" call BIS_fnc_stringToMarker;
		"|extMkr_2|[5405.56,17913.1]|Empty|ELLIPSE|[1000,1000]|0|Border|colorOPFOR|1" call BIS_fnc_stringToMarker;
		
		// Delete original extract markers
		deleteMarker "extMkr";

		// Assign new alt extraction
		[phoenix, ["extAltTask", "Leave the area by any means necessary", "Leave the Area", "", getMarkerPos "extMkr", "assigned"]] call FHQ_fnc_ttAddTasks;
		
		// Enable alternative extrction
		altExtract = true;
		
		[] spawn 
		{
			waitUntil {sleep 1.0; !isNil "extracted"};
			
			// Complete objective
			["extAltTask", "Completed"] call FHQ_fnc_ttSetTaskState;
			
			// Start end music
			[1,0] remoteExec ["fadeMusic", [0,-2] select (isMultiplayer && isDedicated)];
			//[10,0.35] remoteExec ["fadeSound", [0,-2] select (isMultiplayer && isDedicated)];
			sleep 1.0;
			"LoneWolf" remoteExec ["playMusic",[0,-2] select (isMultiplayer && isDedicated)];
			[10,1] remoteExec ["fadeMusic", [0,-2] select (isMultiplayer && isDedicated)];
			sleep 3.0;
			
			[] remoteExec ["AD_fnc_thanks", [0,-2] select (isMultiplayer && isDedicated)];
			sleep 35.0;
			
			activateKey "MissionCompleted";
			sleep 1.0;
			["End_Win",true,true,false] remoteExec ["BIS_fnc_endMission"];
		};
	};
};

