// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
/*QUAKED actor_ally_diaz (0.0 0.25 1.0) (-16 -16 0) (16 16 72) SPAWNER FORCESPAWN UNDELETABLE ENEMYINFO
defaultmdl="body_complete_sp_usmc_ghillie_price"
"count" -- max AI to ever spawn from this spawner
SPAWNER -- makes this a spawner instead of a guy
FORCESPAWN -- will try to delete an AI if spawning fails from too many AI
UNDELETABLE -- this AI (or AI spawned from here) cannot be deleted to make room for FORCESPAWN guys
ENEMYINFO -- this AI when spawned will get a snapshot of perfect info about all enemies
*/
main()
{
	self.animTree = "";
	self.team = "allies";
	self.type = "human";
	self.accuracy = 1;
	self.health = 100;
	self.weapon = "m4_silencer_diaz";
	self.secondaryweapon = "";
	self.sidearm = "usp_silencer";
	self.grenadeWeapon = "fraggrenade";
	self.grenadeAmmo = 5;

	self setEngagementMinDist( 256.000000, 0.000000 );
	self setEngagementMaxDist( 768.000000, 1024.000000 );

	character\american_diaz_m4_ghillie::main();
}

spawner()
{
	self setspawnerteam("allies");
}

precache()
{
	character\american_diaz_m4_ghillie::precache();

	precacheItem("m4_silencer_diaz");
	precacheItem("usp_silencer");
	precacheItem("fraggrenade");
}
