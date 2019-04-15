// Phoenix Team's Objectives
[ phoenix, 
	
	["primTasks", "These are your primary objectives. In order to finish the mission, all of these tasks must be completed.", "Primary Objectives", ""],   
    
	[["beachTask", "primTasks"], "<img image='images\beach.jpg' width='370' height='208'/><br/><br/><font color='#469CED'>Assist the Marines</font> with securing the <marker name='beachMkr'>beach</marker> by clearing out the <font color='#469CED'>insurgents defending it</font>. Any enemy personnel in the <font color='#469CED'>bunkers</font> are a priority!", "Secure the Beach", "",getMarkerPos "beachMkr", "assigned", "attack"]
	
] call FHQ_fnc_ttAddTasks;

// Phoenix team's briefing
[ phoenix,

	// MISSION BRIEF *********************************************************************
	["Situation", "<img image='images\beachView.jpg' width='370' height='208'/><br/><br/>This morning at 0600 hours, we launched our offensive from the <marker name='hqMkr'>Island of Mooray</marker> with the goal of taking the <font color='#469CED'>Island of Malden</font> from the <font color='#469CED'>URF (United Rebel Front)</font>. Our initial plan was to first take <marker name='airbaseMkr'>Malden's airbase</marker>, but things have become complicated. At 0609 hours our Marine assault force was <font color='#469CED'>ambushed by innies</font> from an <marker name='baseMkr'>old UNSC base</marker> that intel said was vacant of enemy personnel several nights before the invasion. The innies somehow <font color='#469CED'>reactivated</font> the base's old <font color='#469CED'>automated anti-air defense systems</font>, as well as the <font color='#469CED'>orbital defense guns</font>. They also removed the IFF protocols from those defenses. This forced the Marines to land on the <marker name='beachMkr'>beach</marker> or get shot down like many were at the time. Now, they are <font color='#469CED'>pinned down</font> from machine gun fire from innies who have occupied some <font color='#469CED'>old bunkers</font> overlooking the <marker name='beachMkr'>beach</marker>. Because of the orbital and anti-air defenses, we cannot reinforce the Marines. However, we can <font color='#469CED'>orbital drop</font> your team into the combat zone out of range of the orbital defenses. Those <font color='#469CED'>Marines will die</font> without your help. Your priority is to <font color='#469CED'>get them off that beach</font>! Godspeed gentlemen!"],

	["Mission", "<font color='#469CED'>Help the Marines</font> advance up the <marker name='beachMkr'>beach</marker> by clearing out the <font color='#469CED'>bunkers</font> and any infantry defending it. After that is done, we will <font color='#469CED'>contact</font> you for <font color='#469CED'>further instruction</font>."],  
	
	["Supports", "Luckily, a <font color='#469CED'>mortar</font> team, callsign <font color='#469CED'>Longshot</font>, survived the initial ambush and have <font color='#469CED'>established a position</font> on the <marker name='mortarMkr'>peninsula</marker> behind the front lines. They've reported that they recovered enough ammunition for approximately <font color='#469CED'>six</font> fire missions. <font color='#469CED'>Use them wisely</font>!"],
	
	["Signal", "<font color='#469CED'>Phoenix</font> - Your team<br/><br/><font color='#469CED'>Command</font> - HQ"],
	
	["Beach Intel", "<font color='#469CED'>The Marines</font> have reported that they set up some <font color='#469CED'>supplies</font> behind a <font color='#469CED'>downed Pelican</font> near the <marker name='lhouseMkr'>lighthouse</marker> for themselves and your team. They have also reported that there are <font color='#469CED'>multiple abandoned UNSC vehicles</font> on the <marker name='beachMkr'>beach</marker> including a <font color='#469CED'>disabled APC</font> that still has a <font color='#469CED'>functional turret</font>. They said that the APC is <font color='#469CED'>somewhere on the east side</font> of the <marker name='beachMkr'>beach</marker> among the carnage."],
	
	["New Team Members", "<font color='#469CED'>Five men</font> is not enough for this kind of combat. Therefore, we have assigned <font color='#469CED'>three</font> more ODST members to your team. A <font color='#469CED'>marksmen</font>, a <font color='#469CED'>demolitions expert</font>, and a <font color='#469CED'>grenadier</font>, who go by the names, <font color='#469CED'>Frost</font>, <font color='#469CED'>Thanos</font>, and <font color='#469CED'>Nomad</font>, respectively. These guys should greatly <font color='#469CED'>increase</font> your team's <font color='#469CED'>combat effectiveness</font> during this mission."],
	
	["Team Abilities", " - The members of Phoenix Team are equipped with ODST armor that can <font color='#469CED'>take 30% more damage</font> than standard marine armor.<br/><br/>- They can also carry <font color='#469CED'>15% more gear</font> than the standard soldier because of their extreme conditioning."],

	// CREDITS **************************************************************************
	["Credits", "Developer", "<font color='#469CED' size='20'>Mission Developer:</font><br/>AlphaDog"],    
	
	["Credits", "Testing/Feedback", "<font color='#469CED' size='20'>Mission Testers:</font><br/>Andrew M.<br/><br/>Thanks for the feedback"],
	
	["Credits", "Music", "<font color='#469CED' size='20'>Music Credits:</font><br/><font color='#469CED'>Halo Theme</font> by Martin O'Donnell and Michael Salvatori<br/><font color='#469CED'>Lone Wolf</font> by Martin O'Donnell and Michael Salvatori<br/>Various songs from <font color='#469CED'>Arma 3's Soundtrack</font> by BIS<br/>Various songs from <font color='#469CED'>OPTRE's Soundtrack</font> by Article 2 Studios."],
	
	["Credits", "Title Image", "<font color='#469CED' size='20'>Title Image:</font><br/>The background of the title image is the <font color='#469CED'>Halo 3: ODST</font> coverart created by Bungie"],
	
	["Credits", "Special Thanks", "<font color='#469CED' size='20'>Thank You:</font><br/><font color='#469CED'>Varanon</font> for FHQ Tasktracker (Great tool for making multiplayer compatible tasks)<br/><font color='#469CED'>Revo</font> for 3den Enhanced (Excellent improvements to the 3D editor)<br/><font color='#469CED'>Psycho</font> for his excellent revive script.<br/><br/><font color='#469CED' size='15'>A big thanks to the OPTRE Developers</font><font size='15'> for their continued dedication and hard work making the amazing Operation: Trebuchet mod.</font>"],
	
	// HEV TELEPORT REMINDER *****************************************************************
	["Important!!!", "Drop Pod Teleport", "If your <font color='#469CED'>drop pod</font> happens to <font color='#469CED'>land underground</font> at the beginning do not fret! I have <font color='#469CED'>implemented a fix</font> for that issue. Wait about <font color='#469CED'>10 seconds</font> and your pod will be <font color='#469CED'>repositioned</font> at ground level. This will also <font color='#469CED'>work with AI</font> as well. The <font color='#469CED'>only downside</font> to this is that at least one team member has to land above the ground. During testing, it <font color='#469CED'>never happened</font> where the <font color='#469CED'>entire team</font> landed underground, so it is probably a <font color='#469CED'>very rare</font> case.<br/><br/>I <font color='#469CED'>apologize</font> if this breaks your <font color='#469CED'>immersion</font>. I tried my best to find a <font color='#469CED'>workaround</font> for this issue, but to <font color='#469CED'>no avail</font>. Perhaps it is something to do with the OPTRE mod or maybe it is something to do with me, but I <font color='#469CED'>do not know</font>."]
	
] call FHQ_fnc_ttAddBriefing;