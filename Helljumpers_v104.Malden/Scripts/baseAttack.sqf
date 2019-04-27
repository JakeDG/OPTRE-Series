// Creates the reinforcements that attack the base

if (!isServer) exitWith {};

/* Create vehicles with crews */
// Create lead attack vehicles
_attVeh1 = [getMarkerPos "attVeh1_Spawn", 10, "OPTRE_M12_LRV_ins", east] call bis_fnc_spawnvehicle;
sleep 0.5;
_attVeh2 = [getMarkerPos "attVeh2_Spawn", 67, "OPTRE_M12_LRV_ins", east] call bis_fnc_spawnvehicle;
sleep 0.5;

/* Spawn infantry */
// 1st group of soldiers
_attGrp1 = [getMarkerPos "attGrp1_Spawn", east, (configfile >> "CfgGroups" >> "East" >> "OPTRE_Ins" >> "Infantry_ER" >> "OPTRE_Ins_ER_Inf_MSquad"),[],[],[],[],[],325] call BIS_fnc_spawnGroup;
sleep 0.5;

// Second group of soldiers
_attGrp2 = [getMarkerPos "attGrp2_Spawn", east, (configfile >> "CfgGroups" >> "East" >> "OPTRE_Ins" >> "Infantry_ER" >> "OPTRE_Ins_ER_Inf_MSquad"),[],[],[],[],[],37] call BIS_fnc_spawnGroup;

// Third group of soldiers
_attGrp3 = [getMarkerPos "attGrp3_Spawn", east, (configfile >> "CfgGroups" >> "East" >> "OPTRE_Ins" >> "Infantry_ER" >> "OPTRE_Ins_ER_Inf_MSquad"),[],[],[],[],[],161] call BIS_fnc_spawnGroup;

// Fourth group of soldiers
_attGrp4 = [getMarkerPos "attGrp2_Spawn", east, (configfile >> "CfgGroups" >> "East" >> "OPTRE_Ins" >> "Infantry_ER" >> "OPTRE_Ins_ER_Inf_MSquad"),[],[],[],[],[],161] call BIS_fnc_spawnGroup;

/* Create waypoints for all units */
// First attack vehicle
_attVeh1Wp1 = (_attVeh1 select 2) addWaypoint [getMarkerPos "attVeh1Wp_1", 0]; // 1st waypoint
[(_attVeh1 select 2), 2] setWaypointBehaviour "AWARE";
_attVeh1Wp1 setWaypointType "MOVE";
_attVeh1Wp1 setWaypointSpeed "NORMAL";

_attVeh1Wp2 = (_attVeh1 select 2) addWaypoint [getMarkerPos "attVeh1Wp_2", 1]; // 2nd waypoint

_attVeh1Wp3 = (_attVeh1 select 2) addWaypoint [getMarkerPos "attVeh1Wp_3", 2]; // 3rd waypoint
_attVeh1Wp3 setWaypointType "SAD";

// Second attack vehicle
_attVeh2Wp1 = (_attVeh2 select 2) addWaypoint [getMarkerPos "attVeh2Wp_1", 0]; // 1st waypoint
[(_attVeh2 select 2), 2] setWaypointBehaviour "AWARE";
_attVeh2Wp1 setWaypointType "MOVE";
_attVeh2Wp1 setWaypointSpeed "NORMAL";

_attVeh2Wp2 = (_attVeh2 select 2) addWaypoint [getMarkerPos "attVeh2Wp_2", 1]; // 2nd waypoint
_attVeh2Wp2 setWaypointType "SAD";

/* Create waypoints for infantry */
// First infantry group
_attGrp1Wp1 = _attGrp1 addWaypoint [getMarkerPos "attVeh1Wp_2", 0]; // 1st waypoint
[_attGrp1, 2] setWaypointBehaviour "AWARE";
_attGrp1Wp1 setWaypointType "MOVE";
_attGrp1Wp1 setWaypointSpeed "NORMAL";

_attGrp1Wp2 = _attGrp1 addWaypoint [getMarkerPos "attVeh1Wp_3", 1]; // 2nd waypoint
_attGrp1Wp2 setWaypointType "SAD";

// Second infantry group
_attGrp2Wp1 = _attGrp2 addWaypoint [getMarkerPos "attGrp2Wp_1", 0]; // 1st waypoint
[_attGrp2, 2] setWaypointBehaviour "AWARE";
_attGrp2Wp1 setWaypointType "MOVE";
_attGrp2Wp1 setWaypointSpeed "NORMAL";

_attGrp2Wp2 = _attGrp2 addWaypoint [getMarkerPos "attVeh1Wp_3", 1]; // 2nd waypoint
_attGrp2Wp2 setWaypointType "SAD";

// Third infantry group
_attGrp3Wp1 = _attGrp3 addWaypoint [getMarkerPos "attGrp3Wp_1", 0]; // 1st waypoint
[_attGrp3, 2] setWaypointBehaviour "AWARE";
_attGrp3Wp1 setWaypointType "MOVE";
_attGrp3Wp1 setWaypointSpeed "NORMAL";

_attGrp3Wp2 = _attGrp3 addWaypoint [getMarkerPos "attVeh1Wp_3", 1]; // 2nd waypoint
_attGrp3Wp2 setWaypointType "SAD";

// Forth infantry group
_attGrp4Wp1 = _attGrp4 addWaypoint [getMarkerPos "attGrp2Wp_1", 0]; // 1st waypoint
[_attGrp4, 2] setWaypointBehaviour "AWARE";
_attGrp4Wp1 setWaypointType "MOVE";
_attGrp4Wp1 setWaypointSpeed "NORMAL";

_attGrp4Wp2 = _attGrp4 addWaypoint [getMarkerPos "attVeh1Wp_3", 1]; // 2nd waypoint
_attGrp4Wp2 setWaypointType "SAD";
