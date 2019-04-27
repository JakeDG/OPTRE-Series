// Creates the intro

if (isMultiplayer) then 
{
	100 cutText ["", "BLACK FADED", 999];
	100 cutText ["Server Loading...", "BLACK FADED", 999];
	0 fadeSound 0;
	0 fadeMusic 0;
	enableRadio false;
	enableEnvironment false;	
	clearRadio;
	waitUntil {sleep 1; !isNil "serverLoaded"};
	100 cutText ["Server Loaded", "BLACK FADED", 999];
}
else
{
	100 cutText ["", "BLACK FADED", 999];
	100 cutText ["Mission Loading...", "BLACK FADED", 999];
	0 fadeSound 0;
	0 fadeMusic 0;
	enableRadio false;
	enableEnvironment false;	
	clearRadio;
	waitUntil {sleep 1; !isNil "serverLoaded"};
	100 cutText ["Mission Loaded", "BLACK FADED", 999];
};
100 cutText ["", "BLACK FADED", 999];	
sleep 1.0;
0 fadeMusic 1; // Fade music back in
sleep 4.0;

playMusic "Halo_Theme"; // Play intro music

101 cutText ["<t size='3.0' font='EtelkaMonospacePro'>Feet first into hell</t>", "BLACK", 3.0,true,true];
sleep 9.0;
101 cutFadeOut 1.0;
sleep 4.5;

101 cutText ["<t size='3.0' color='#469CED' font='EtelkaMonospacePro'>AlphaDog presents</t>", "BLACK", 2.0,true,true];
sleep 7.0;
101 cutFadeOut 1.0;
sleep 3.0;

101 cutText ["<t size='5.0' shadow='0' color='#469CED' font='EtelkaMonospacePro'>OPTRE:<br/></t><t size='5.0' shadow='0' font='EtelkaMonospacePro'>Helljumpers</t>", "BLACK", 3.0,true,true];
sleep 7.0;
101 cutFadeOut 5.0;

100 cutText ["", "BLACK IN", 15];
15 fadeSound 1; // Fade sound back in
enableRadio true;
enableEnvironment true;
enableSentences true;

sleep 15.0;

_date = [] call AD_fnc_getDate;
_time = [] call AD_fnc_getTime;
_text = 
	[ 
		["Phoenix Team","<t color='#469CED' font='PuristaBold'>%1</t><br/>",8], 
		["North Malden Beachhead","<t font='PuristaMedium'>%1</t><br/>",8],
		[_time + " Hours","<t font='PuristaMedium'>%1</t><br/>",8],		
		[_date,"<t font='PuristaMedium'>%1</t><br/>",20] 
	]; 
[_text,-safezoneX,safeZoneY+safeZoneH-0.4,"<t align='center'>%1</t>"] spawn BIS_fnc_typeText;

introDone = true;
publicVariable "introDone";

if (("Music" call BIS_fnc_getParamValue) == 1) then 
{
	waitUntil{sleep 1.0; !isNil "dedicatedMusic"};
	if (dedicatedMusic && ((["primTasks"] call FHQ_fnc_ttGetTaskState) != "completed")) then // Only works on dedicated servers
	{
		ehID = addMusicEventHandler [
									"MusicStop", 
									{
										[] spawn
										{
											sleep 5.0;
											playMusic (selectRandom trackList);;
										};
									}
								];
	};
};
