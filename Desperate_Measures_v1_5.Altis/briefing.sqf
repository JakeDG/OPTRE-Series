// Phoenix Team's Objectives
[ phoenix, 
	
	["primTasks", "These are your primary objectives. In order to finish the mission, all of these tasks must be completed.", "Primary Objectives", ""],   
    
	[["clearTask_1", "primTasks"], "Clear the <marker name='factoryMkr'>Traxus factory</marker> of insurrectionists.", "Retake Traxus Factory", "",getMarkerPos "factoryMkr", "assigned", "attack"],
	
	[["bombTask", "primTasks"], "Locate and diffuse of all insurrectionist explosive devices in the <marker name='factoryMkr'>Traxus factory</marker>.","Defuse Bombs","","","interact"]
	
] call FHQ_fnc_ttAddTasks;

// Phoenix team's briefing
[ phoenix,

	// MISSION BRIEF *********************************************************************
	["Situation", "Hours ago, a significant force of insurgents raided a <marker name='factoryMkr'>Traxus factory</marker> northeast of Kavala, killing many of the guards and personel. The <marker name='policeMkr'>local police response team</marker> was ambushed by a suicide <font color='#469CED'>car bomb</font> while en-route to the factory as the attack was taking place. This allowed the Innies to setup shop and get hunkered down. We believe they intend to <font color='#469CED'>hold the factory long enough to place explosives</font> and escape back into the woods. We can't let this happen as that factory provides a significant amount of arms to the <font color='#469CED'>UNSC fleet in New Mombasa</font>.<br/><br/>The reason we're sending you in is because we sent in some marines earlier. However, they were shot down before they could even land at the factory. You <font color='#469CED'>ODSTs are our last desperate measures.</font> Get it done!"],
	
	["Mission", "You are to <font color='#469CED'>neutralize all insurgents</font> as well as <font color='#469CED'>disarm all bombs</font> at the <marker name = 'factoryMkr'>Traxus factory</marker>.<br/><br/>Be advised that there is an <marker name='overWatchMkr'>overwatch position</marker> located to the southwest of the factory. Use it to your advantage."],  
	
	["Supports", "<font color='#469CED'>No support could be granted at this time.</font>"],
	
	["Signal", "<font color='#469CED'>Phoenix</font> - Your team<br/><br/><font color='#469CED'>Command</font> - HQ"],
	
	["Bombs", "Scouts have reported that the Innies are <font color='#469CED'>using the ordnance from the factory</font> to make bombs. They believe the bombs are <font color='#469CED'>placed in the major buidlings of the complex</font>, but are not entirely sure. If you find any of these bombs, make sure to <font color='#469CED'>disarm them immediately</font>."],
	
	["Team Abilities", " - The members of Phoenix Team are equipped with ODST armor that can <font color='#469CED'>take 30% more damage</font> than standard marine armor.<br/><br/>- They can also carry <font color='#469CED'>15% more gear</font> than the standard soldier because of their extreme conditioning."],

	// CREDITS **************************************************************************
	["Credits", "Developer", "<font color='#469CED' size='20'>Mission Developer:</font><br/>AlphaDog"],    
	
	["Credits", "Testing/Feedback", "<font color='#469CED' size='20'>Mission Testers:</font><br/>Andrew M.<br/>Garrett S.<br/>Thanks for the feedback guys!"],
	
	["Credits", "Music", "<font color='#469CED' size='20'>Music Credits:</font><br/><font color='#469CED'>Note</font> - The intro song is a combination of the following two songs:<br/><font color='#469CED'>The Menagerie</font> by Martin O'Donnell and Michael Salvatori<br/><font color='#469CED'>Skyline </font> by Martin O'Donnell and Michael Salvatori<br/><br/><font color='#469CED'>Overture </font> by Martin O'Donnell<br/><font color='#469CED'>Lone Wolf</font> by Martin O'Donnell and Michael Salvatori"],
	
	["Credits", "Title Image", "<font color='#469CED' size='20'>Title Image:</font><br/>The background of the title image is the <font color='#469CED'>Halo 3: ODST</font> coverart created by Bungie"],
	
	["Credits", "Special Thanks", "<font color='#469CED' size='20'>Thank You:</font><br/><font color='#469CED'>Varanon</font> for FHQ Tasktracker (Great tool for making multiplayer compatible tasks)<br/><font color='#469CED'>Revo</font> for 3den Enhanced (Excellent improvements to the 3D editor)<br/><font color='#469CED'>Psycho</font> for his excellent revive script<br/><font color='#469CED'>Chopper</font> for patching the mission file to be able to work with OPTRE v0.17!<br/><br/><font color='#469CED' size='15'>A big thanks to the OPTRE Developers</font><font size='15'> for their continued dedication and hard work making the amazing Operation: Trebuchet mod.</font>"]
	
	//["Error Message", "Error Message", "If you get an error message about ACE at the start of this mission, then do not worry about it. It is a harmless bug caused by the OPTRE Mod."]
	
] call FHQ_fnc_ttAddBriefing;