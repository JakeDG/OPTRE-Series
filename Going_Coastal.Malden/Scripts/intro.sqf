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

//playMusic ["Traffic_Jam",1]; // Play intro music
playMusic ["OPTRE_Music_Introductions",38];
["<t  size = '1.0'>Six days after the drop...</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.85, 6, 4, 0, 200] spawn BIS_fnc_dynamicText;
sleep 13.0;

["<t size='1.0' color='#469CED'>AlphaDog Presents...</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.85, 5, 4, 0, 200] spawn BIS_fnc_dynamicText;
sleep 12.0;

["<t  size = '3.0' shadow = '0' color='#469CED'>OPTRE: </t><t  size = '3.0' shadow = '0'>Going Coastal</t>", safeZoneX+0.45,safeZoneY+safeZoneH-0.9, 8, 7, 0, 200] spawn BIS_fnc_dynamicText;
sleep 7.0;

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
		["Highway-99","<t font='PuristaMedium'>%1</t><br/>",8],
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
