// Creates the enemy force that attacks the pelican crash site

if (!isServer) exitWith {};

hint "assault has started";

// Create attack direction markers
_attMkr_1 = createMarker ["attackMkr_1", [2483.47,4873.63]]; 
_attMkr_1 setMarkerType "mil_arrow"; 
_attMkr_1 setMarkerColor "ColorOPFOR"; 
_attMkr_1 setMarkerDir 84.0;

_attMkr_2 = createMarker ["attackMkr_2", [2830.94,4683.91]]; 
_attMkr_2 setMarkerType "mil_arrow"; 
_attMkr_2 setMarkerColor "ColorOPFOR"; 
_attMkr_2 setMarkerDir 0.0;

_attMkr_3 = createMarker ["attackMkr_3", [3162.97,4831.32]]; 
_attMkr_3 setMarkerType "mil_arrow"; 
_attMkr_3 setMarkerColor "ColorOPFOR"; 
_attMkr_3 setMarkerDir 285;

// Spawn four squads of infantry (URF and Insurgents) 
// 1st group of soldiers
_attGrp_1 = [getMarkerPos "attGrpSpawn_1", east, (configfile >> "CfgGroups" >> "East" >> "OPTRE_Ins" >> "Infantry_ER" >> "OPTRE_Ins_ER_Inf_Patrol"),[],[],[],[],[],85] call BIS_fnc_spawnGroup;

// Second group of soldiers
_attGrp_2 = [getMarkerPos "attGrpSpawn_2", east, (configfile >> "CfgGroups" >> "East" >> "OPTRE_Ins" >> "Infantry_ER" >> "OPTRE_Ins_ER_Inf_Patrol"),[],[],[],[],[],0] call BIS_fnc_spawnGroup;

// Third group of soldiers
_attGrp_3 = [getMarkerPos "attGrpSpawn_3", east, (configfile >> "CfgGroups" >> "East" >> "OPTRE_Ins" >> "Infantry_ER" >> "OPTRE_Ins_ER_Inf_Patrol"),[],[],[],[],[],0] call BIS_fnc_spawnGroup;

// Fourth group of soldiers
_attGrp_4 = [getMarkerPos "attGrpSpawn_4", east, (configfile >> "CfgGroups" >> "East" >> "OPTRE_Ins" >> "Infantry_ER" >> "OPTRE_Ins_ER_Inf_Patrol"),[],[],[],[],[],325] call BIS_fnc_spawnGroup;

// Fifth group of soldiers
_attGrp_5 = [getMarkerPos "attGrpSpawn_5", east, (configfile >> "CfgGroups" >> "East" >> "OPTRE_Ins" >> "Infantry_ER" >> "OPTRE_Ins_ER_Inf_Patrol"),[],[],[],[],[],275] call BIS_fnc_spawnGroup;

// Make all groups unable to flee and set attack point for all groups
{
	_x allowFleeing 0; 
	_x move getMarkerPos "crashSiteMkr";
} forEach [_attGrp_1,_attGrp_2,_attGrp_3,_attGrp_4,_attGrp_5];

// Create constant check to see if all attacking groups have been killed. Check at interval of 10s to improve performance.
waitUntil 
{
	sleep 10.0; 
	{alive _x} count ((units _attGrp_1) + (units _attGrp_2) + (units _attGrp_3) + (units _attGrp_4) + (units _attGrp_5)) == 0
};

hint "EVERYONE's DEAD";

// delete assault markers
{deleteMarker _x} forEach ["attackMkr_1","attackMkr_2","attackMkr_3"];