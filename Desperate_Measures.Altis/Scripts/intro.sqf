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

sleep 1.0;
100 cutText ["", "BLACK FADED", 999];
0 fadeMusic 1; // Fade music back in
sleep 4.0;
playMusic "Desperate"; // Play intro music

101 cutText ["<t size='3.0' font='EtelkaMonospacePro'>A few hours after the attack</t>", "BLACK", 3.0,true,true];
sleep 6.0;
101 cutFadeOut 1.0;
sleep 4.0;

101 cutText ["<t size='3.0' color='#469CED' font='EtelkaMonospacePro'>AlphaDog presents</t>", "BLACK", 2.0,true,true];
sleep 6.0;
101 cutFadeOut 1.0;
sleep 3.5;

101 cutText ["<t size='5.0' shadow='0' color='#469CED' font='EtelkaMonospacePro'>OPTRE:<br/></t><t size='5.0' shadow='0' font='EtelkaMonospacePro'>Desperate Measures</t>", "BLACK", 3.0,true,true];
sleep 5.0;
101 cutFadeOut 5.0;

10 fadeSound 1; // Fade sound back in
100 cutText ["", "BLACK IN", 15];
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

