// Fixes the problem where the drop pods get stuck underground when it lands

// Wait until at least one member of phoenix team is on the ground
//waitUntil {sleep 1.0; {istouchingGround (objectParent _x)} count units phoenix > 0};
waitUntil {sleep 1.0; !isNil "introDone" && ({getPosATL objectParent _x select 2 < 2} count units phoenix > 0)};
	
// Wait a little bit for everyone to land
{
	[_x] spawn 
	{
		_unit = _this select 0;
		sleep 10.0;
			
		// Check if unit Z axis position is negative
		if (((getPosATL _unit) select 2) < -0.1) then 
		{
			(objectParent _unit) setPosATL [(getPosATL _unit) select 0, (getPosATL _unit) select 1, 0];
			sleep 1.0;
			unassignVehicle _unit;
			sleep 0.25;
				
			// Kick AI out of pod fix (v1.02)
			if (!isPlayer _unit) then 
			{
				_unit action ["getOut",  (objectParent _unit)];
			};
		};
		sleep 6.0;
			
		// Check if unit is AI and stuck in pod for some reason
		if (((typeOf objectParent _unit) == "OPTRE_HEV") && !isPlayer _unit) then
		{
			unassignVehicle _unit;
			sleep 1.0;
			_unit setPosATL [((getPosATL _unit) select 0) - 5, (getPosATL _unit) select 1, 0];
		
			// Damage is disabled in the pods so it will be deactivated once the AI are teleported out
			if (isDamageAllowed _unit) then 
			{
				[_unit, true] remoteExec ["allowDamage", groupOwner phoenix];
				
				// Add event handler to unit just in case locality changes (Needs further testing)
				_unit addEventHandler [
										"Local", 
										{
											params ["_entity", "_isLocal"];
											
											_entity = _this select 0;
											_isLocal = _this select 1;
												
											if (_isLocal) then 
											{ 
												_entity allowDamage false; 
											};
										}	
									];
			};
		};
	};
} forEach units phoenix;