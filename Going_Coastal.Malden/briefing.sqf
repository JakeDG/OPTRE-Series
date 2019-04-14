// Phoenix Team's Objectives
[ phoenix, 
	
	/***** Primary objectives *****/
	["primTasks", "These are your primary objectives. In order to finish the mission, all of these tasks must be completed.", "Primary Objectives", ""],   
    
	// Highway parent task
	[["highwayTasks", "primTasks"], "Secure key locations along Highway-99. Clear all insurgent forces from each location.", "Secure Highway-99", "", "", "assigned", "ATTACK"],
	
	// Lavalle Hamlet objective
	[["lavalleTask", "highwayTasks"], "Secure the Hamlet of Lavalle.", "Secure Lavalle", "",getMarkerPos "lavalleMkr", "created", "TARGET"],
	
	// T-junction objective
	[["tJuncTask", "highwayTasks"], "Secure the T-Junction.", "Secure T-Junction", "",getMarkerPos "tJuncMkr", "created", "TARGET"],
	
	// Farm objective
	[["farmTask", "highwayTasks"], "Secure the Farm.", "Secure Farm", "",getMarkerPos "farmMkr", "created", "TARGET"],
	
	/****** Secondary objectives ******/
	["secTasks", "These are your secondary objectives. These objectives are optional and are not required to complete the main mission.","Secondary Objectives", ""],
	
	// Hamlet side task
	[["hamletTask", "secTasks"], "Stuff stuff stuff", "Hamlet Obj Title", "", getMarkerPos "sideHamletMkr", "created", "CAR"],
	
	// Forward outpost side task
	[["obvPostTask", "secTasks"], "Stuff stuff stuff", "Search Outpost", "", getMarkerPos "obvPostMkr", "created", "SEARCH"]
	
] call FHQ_fnc_ttAddTasks;