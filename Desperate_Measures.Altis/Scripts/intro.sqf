// Creates the intro

if (isMultiplayer) then 
{
	500 cutText ["", "BLACK FADED", 999];
	500 cutText ["Server Loading...", "BLACK FADED", 999];
	0 fadeSound 0;
	0 fadeMusic 0;
	enableRadio false;
	enableEnvironment false;	
	clearRadio;
	waitUntil {sleep 1; !isNil "serverLoaded"};
	500 cutText ["Server Loaded", "BLACK FADED", 999];
}
else
{
	500 cutText ["", "BLACK FADED", 999];
	500 cutText ["Mission Loading...", "BLACK FADED", 999];
	0 fadeSound 0;
	0 fadeMusic 0;
	enableRadio false;
	enableEnvironment false;	
	clearRadio;
	waitUntil {sleep 1; !isNil "serverLoaded"};
	500 cutText ["Mission Loaded", "BLACK FADED", 999];
};

sleep 1.0;
500 cutText ["", "BLACK FADED", 999];
0 fadeMusic 1; // Fade music back in
sleep 4.0;
playMusic "Desperate"; // Play intro music
["<t  size = '1.0'>A few hours after the attack...</t>", safeZoneX+0, safeZoneY+safeZoneH-0.9, 4, 4, 0, 600] spawn BIS_fnc_dynamicText;
sleep 10.0;

["<t size='1.0' color='#2B7ADA'>AlphaDog Presents...</t>", safeZoneX+0.1, safeZoneY+safeZoneH-0.9, 4, 4, 0, 600] spawn BIS_fnc_dynamicText;
sleep 10.0;

["<t  size = '3.0' shadow = '0' color='#2B7ADA'>Desperate </t><t  size = '3.0' shadow = '0'>Measures</t>", safeZoneX+0.45,safeZoneY+safeZoneH-0.9, 8, 7, 0, 600] spawn BIS_fnc_dynamicText;
sleep 5.0;
10 fadeSound 1; // Fade sound back in
500 cutText ["", "BLACK IN", 15];
enableRadio true;
enableEnvironment true;
enableSentences true;

sleep 15.0;
_date = [] call AD_fnc_getDate;
_time = [] call AD_fnc_getTime;
_text = 
	[ 
		["Phoenix Team","<t color='#2B7ADA' font='PuristaBold'>%1</t><br/>",8], 
		["Kavala Airspace","<t font='PuristaMedium'>%1</t><br/>",8],
		[_time + " Hours","<t font='PuristaMedium'>%1</t><br/>",8],		
		[_date,"<t font='PuristaMedium'>%1</t><br/>",20] 
	]; 
[_text,-safezoneX,safeZoneY+safeZoneH-0.4,"<t align='center'>%1</t>"] spawn BIS_fnc_typeText;

introDone = true;
publicVariable "introDone";

