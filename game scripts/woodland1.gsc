#include maps\_anim;
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
	
	maps\_load::main();
	

		thread player_setup();
		thread Introscreen();
		miscprecache();
}
miscprecache()
{
		precachestring( &"WOODLAND1_WEAPON_M200" );
	precachestring( &"WOODLAND1_PLAYER_DETECTED_1" );
	precachestring( &"WOODLAND1_LINE1" );
	precachestring( &"WOODLAND1_LINE2" );
	precachestring( &"WOODLAND1_LINE3" );
	precachestring( &"WOODLAND1_LINE4" );
	precachestring( &"WOODLAND1_LEFTMISSIONAREA_1" );
}
player_setup()
{
	level.player takeallweapons();
	level.player freezecontrols ( true );
	level.player setviewmodel ( "viewhands_op_force" );
	level.player giveWeapon ( "intervention_silencer_mp" ); //use whatever gun you want
	level.player givemaxammo ( "intervention_silencer_mp" ); //same
	level.player giveWeapon ( "p226_silencer" ); //use whatever gun you want
	level.player givemaxammo ( "p226_silencer" );
	level.player disableweapons();
}
Introscreen()
{
	lines = [];
	lines[ lines.size ] = &"WOODLAND1_LINE1";
	lines[ lines.size ] = &"WOODLAND1_LINE2";
	lines[ lines.size ] = &"WOODLAND1_LINE3";
	lines[ lines.size ] = &"WOODLAND1_LINE4";
	fade_time = ( 5 );
	time = ( 1 );
	maps\_introscreen::introscreen_feed_lines( lines );
	maps\_introscreen::introscreen_generic_fade_in( "black", time, fade_time );
	
	level notify( "introscreen_complete" );
	level.player freezecontrols ( false );
	level.player enableweapons();
	    thread ai_allies_setup();
}
ai_allies_setup()
{
diaz = getent ("diaz" , "targetname");
    	diaz stalingradspawn();
        wait 0.05;
            level.diaz = get_living_ai("agentdiaz" , "script_noteworthy");
            level.diaz.name = "Diaz";
            level.diaz thread magic_bullet_shield();
			thread outofmap_failure1();
}
outofmap_failure1()
{
	trigg_leftmissionarea = getent("trigg_leftmissionarea","targetname");
	trigg_leftmissionarea waittill("trigger");
	setDvar( "ui_deadquote" , &"WOODLAND1_LEFTMISSIONAREA_1" );
	maps\_utility::missionFailedWrapper();
}