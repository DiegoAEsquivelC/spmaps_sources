#include maps\_anim;
#include maps\_stealth_logic;
#include maps\_utility;
#include common_scripts\utility;
#include maps\_utility_code;
#include maps\_helicopter_ai;
#include maps\_helicopter_globals;
#include maps\_vehicle_aianim;
#include maps\_vehicle;
#include maps\_hud_util;
#using_animtree( "vehicles" );
#using_animtree("generic_human");
main()
{
	maps\_mi17_noai::main("vehicle_mi17_woodland");
    maps\_load::main();
	maps\_nightvision::main();
    thread weapons_plr_setup();
    thread loadscreen();
    thread ai_allies_setup();
}
ai_allies_setup()
{
maddox = getent ("maddox" , "targetname");
    maddox stalingradspawn();
        wait 0.05;
            level.maddox = get_living_ai("maddox" , "script_noteworthy");
            level.maddox.name = "Diaz";
            level.maddox thread magic_bullet_shield();
}
weapons_plr_setup()
{
 level.player takeallweapons();
 level.player freezecontrols( true );
 level.player setviewmodel("viewhands_op_force");
 level.player giveWeapon("usp_silencer");
 level.player givemaxammo("usp_silencer");
 level.player giveWeapon( "m14_scoped_silencer_woodland_1" );
 level.player givemaxammo( "m14_scoped_silencer_woodland_1" );
 level.player switchtoweapon( "m14_scoped_silencer_woodland_1" );
 level.player disableweapons();
}
loadscreen()
{
	
	cinematicingamesync("sniperescape_fade");

	wait 4;

	set_vision_set( "grayscale" );

	saveGame( "levelstart", &"AUTOSAVE_LEVELSTART", "whatever", true );	
	introblack = newHudElem();
	introblack.x = 0;
	introblack.y = 0;
	introblack.horzAlign = "fullscreen";
	introblack.vertAlign = "fullscreen";
	introblack.foreground = true;
	introblack setShader("black", 640, 480);
	

	wait 3;

	introtime = newHudElem();
	introtime.x = 0;
	introtime.y = 0;
	introtime.alignX = "center";
	introtime.alignY = "middle";
	introtime.horzAlign = "center";
	introtime.vertAlign = "middle";
	introtime.sort = 1;
	introtime.foreground = true;
	introtime setText( &"SEWERS_A_10_YEARS_AGO" );
	introtime.fontScale = 1.6;
	introtime.color = (0.8, 1.0, 0.8);
	introtime.font = "objective";
	introtime.glowColor = (0.3, 0.6, 0.3);
	introtime.glowAlpha = 1;
	introtime SetPulseFX( 30, 2000, 700 );//something, decay start, decay duration

	wait 8;

	lines = [];
	lines[ lines.size ] = &"SEWERS_A_LINE1";
	lines[ lines.size ] = &"SEWERS_A_LINE2";
	lines[ lines.size ] = &"SEWERS_A_LINE3";
	lines[ lines.size ] = &"SEWERS_A_LINE4";

	maps\_introscreen::introscreen_feed_lines( lines );
		
	wait 1;
	
	// Fade out black
	introblack fadeOverTime(2.35); 
	introblack.alpha = 0;

	wait .25;
	
	set_vision_set( "airplane", 2 );

	wait( .25 );
	 // Do final notify when player controls have been restored	
	level notify("introscreen_complete");
	level.player freezeControls( false );
	level.player enableweapons();
	
	wait( .5 );
	
	setsaveddvar( "compass", 1 );
	SetSavedDvar( "ammoCounterHide", "0" );
	SetSavedDvar( "hud_showStance", 1 );
	autosave_by_name("introscreen_complete");
	thread ammocrate();
}
ammocrate()
{
	ammo_crate = getent ("ammo_crate" , "targetname");
	newHudElem(&"SEWERS_A_AMMO_CRATE_TEXT");
	level.player takeallweapons();
	level.player givemaxammo("");
	wait 1;
	level.player enableweapons();
}