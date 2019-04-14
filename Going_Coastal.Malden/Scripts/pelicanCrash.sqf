// This script will create the pelican crash over La Pessangne

if (!isServer) exitWith {};

// Create Pelican crew and vehicle
_pelCrew = createGroup west;
sleep 1.0;
_pel = [getMarkerPos "pelSpawnMkr", 240, "OPTRE_Pelican_unarmed", _pelCrew] call bis_fnc_spawnVehicle;
crashPel = (_pel select 0);
crashPel allowDamage false;
{
	_x allowDamage false; 
	_x setCaptive true;
} forEach (_pel select 1);

[crashPel] execVM "Scripts\flightPath.sqf";
sleep 1.0;

// Run script to move pelican through unitCapture
waitUntil {sleep 1.0; (crashPel distance2D getMarkerPos "townMkr") < 500};

// AA missile shoots down pelican
// Create mock anti-air
_pos = [aa_1,250,direction aa_1 - 45 + random 90] call bis_fnc_relPos;
_pos set [2,(getPosATL aa_1 select 2) max 50];
_aa = createVehicle ["B_SAM_System_03_F",_pos,[],300,"none"];
_aa setVehicleAmmo 0.25; // Only give it one shot

// Create mock anti-air crew
_aaCrew = createAgent ["i_soldier_f",_pos,[],0,"none"];
_aaCrew moveInGunner _aa;

// Setup anti-air
_aa hideObjectGlobal true;
_aa setPos _pos;
_aa setDir ([_aa,crashPel] call bis_fnc_dirTo);

// Create event handler for when the aa missile is fired from the anti-air
_aa addEventHandler [
	"fired",
	{
		// When the missile hits (or misses) the pelican will catch fire and crash land
		_this spawn 
		{
			_aa = _this select 0;
			_missile = _this select 6;
			
			// Delete mock anti-air and anti-air crew
			{
				moveOut _x; 
				deleteVehicle _x;
			} forEach crew _aa;

			deleteVehicle _aa;
			
			// Wait until the missile either hits the pelican or just barely misses it
			waitUntil {isNull _missile || _missile distance crashPel < 201};
			sleep 0.75;

			// Missile most likely missed the pelican, so trigger an explosion on the pelican to compensate
			if (!isNull _missile) then 
			{
				// Create explosion effect
				"M_Titan_AA" createVehicle getPosATL crashPel;
			};
			
			// Set pelican's right thruster on fire
			_smoke_1 = "test_EmptyObjectForSmoke" createVehicle [0,0,0];
			_smoke_2 = "test_EmptyObjectForSmoke" createVehicle [0,0,0];
			_fire_1 = "test_EmptyObjectForFireBig" createVehicle [0,0,0];
			{_x attachTo [crashPel,[4.25,4.5,0]];} forEach [_smoke_1,_smoke_2,_fire_1];
			sleep 1.25;
			
			// Cancel mock extract task
			["extMockTask", "canceled"] call FHQ_fnc_ttSetTaskState;
			deleteMarker "extMockMkr_1";
			sleep 0.5;
			
			// Pelican speaks
			[
				[
					"Kilo 2-2",
					"Mayday, mayday, Kilo 2-2 is hit! I repeat, Kilo 2-2 is hit! I've lost the right thruster!",
					10,
					"RadioAmbient2"
				], AD_fnc_subtitle
			] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
			sleep 12.0;			

			[
				[
					"Kilo 2-2",
					"This is Kilo 2-2, I've lost all power! We're going down hard!",
					10,
					"RadioAmbient6"
				], AD_fnc_subtitle
			] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
		};
	}
];

_aa fireAtTarget [crashPel,"weapon_mim145Launcher"]; // Fire aa missile from mock anti-air

waitUntil {crashPel getVariable "crashDone"}; // Wait until the pelican's unitPlay function has finished

// delete the fire from the pelican, the pelican's crew, and the pelican itself 
{deleteVehicle _x;} forEach attachedObjects crashPel;
{deleteVehicle _x;} forEach (crew crashPel);
deleteVehicle crashPel;
crashPel = nil; // Nullify the global variable to save a little memory

// Reveal hidden crash site objects
[] spawn 
{
	{
		_x hideObjectGlobal false; 
		sleep 0.25;
	} forEach (getMarkerPos "crashSiteMkr" nearObjects ["All", 45]);
};

// Set pelican on fire
[getPosATL crashPelFire_1, "FIRE_VBIG"] call TP_fnc_createFireEffect;
[getPosATL crashPelFire_2, "FIRE_MEDIUM"] call TP_fnc_createFireEffect;