 /*
    Filename: fn_soundAmp.sqf
    Author: AlphaDog
    
    Description:
	Amplifies the sound provided as an agrument.
	NOTE: Function should be called locally on client(s)
   
    Parameter(s):
    0: String - Sound to be amplified.
   
   Example:
   ["sound"] call AD_fnc_soundAmp;
*/

private _sound = param [0, "", [""], 1];

if (_sound == "") exitWith {}:

playSound _sound;
playSound _sound;

true