// --------------------------------
// Sonic Doom 2
// --------------------------------

dofile("LUA_SCHS.lua") // A_RadarLook action (used for SD2 enemies)
dofile("SD2Freeslots.lua") // Freeslots for SD2 enemies
dofile("SD2MiscObjects.lua") // SD2 puff and smoke
dofile("SD2Functions.lua") // Global functions for SD2 enemies
dofile("SD2Actions.lua") // Global actions for SD2 enemies
dofile("SD2Grounder.lua") // Grounder and variants
dofile("SD2Coconuts.lua") // Coconuts
dofile("SD2OVABots.lua") // OVA bot and variants
dofile("SD2PseudoFlicky.lua") // Pseudo-Flicky
dofile("SD2BuzzBomber.lua") // Buzz Bomber
dofile("SD2PsuedoTails.lua") // Pseudo-Tails
dofile("SD2PseudoKnuckles.lua") // Pseudo-Knuckles
dofile("SD2PseudoSuper.lua") // Pseudo-Super
dofile("SD2MetalSonic.lua") // Metal Sonic
dofile("SD2RedMetalSonic.lua") // Red Metal Sonic
dofile("SD2Eggman.lua") // Eggmancubus
dofile("SD2BlackEggman.lua") // Black Eggman
dofile("LUA_SBOM") // Egg Bomb (replacement for the explosive barrels in Doom
dofile("SD2PlayerThink.lua") // Singleplayer Ringslinger

// --------------------------------
// Monitors
// --------------------------------

//Shields
dofile("LUA_TPTY")
dofile("LUA_FSHL")
dofile("LUA_OPTY")
dofile("LUA_OARM")
dofile("LUA_OFRC")
dofile("LUA_SHLD")
dofile("LUA_FSRF")
dofile("LUA_IFSH")


// TGF

dofile("TGFMonitors/LUA_TBOX") // TGF Box Commonalities
dofile("TGFMonitors/LUA_TBXR") // Ring Box and Power-up
dofile("TGFMonitors/LUA_TBXS") // Sneakers Box and Power-up
dofile("TGFMonitors/LUA_TBXI") // Invincibility Box and Power-up
dofile("TGFMonitors/LUA_TBX1") // 1-up Box
dofile("TGFMonitors/LUA_TBXB") // Shield Box
dofile("TGFMonitors/LUA_TBXT") // Time Power-up

// Demo

dofile("DemoMonitors/LUA_DBOX") // Demo Box Commonalities
dofile("DemoMonitors/LUA_DBXR") // Ring Boxes
dofile("DemoMonitors/LUA_DBXS") // Sneakers Box
dofile("DemoMonitors/LUA_DBXI") // Incinvibility Box
dofile("DemoMonitors/LUA_DBX1") // 1-up Box
dofile("DemoMonitors/LUA_DXS2") // Shield Box Commonalities
dofile("DemoMonitors/LUA_DBXB") // Basic Shield Box
dofile("DemoMonitors/LUA_DBXG") // Elemental/Water Shield Box
dofile("DemoMonitors/LUA_DBXY") // Attraction Shield Box
dofile("DemoMonitors/LUA_DBXK") // Armageddon Shield Box

// Final Demo / 2.0

dofile("FinalDemoMonitors/LUA_FBOX") // Final Demo Box Commonalities
dofile("FinalDemoMonitors/LUA_FBXR") // Ring Boxes
dofile("FinalDemoMonitors/LUA_FBXS") // Sneakers Box
dofile("FinalDemoMonitors/LUA_FBXI") // Invincibility Box
dofile("FinalDemoMonitors/LUA_FBX1") // 1-up Box
dofile("FinalDemoMonitors/LUA_FBXB") // Blue Shield Box
dofile("FinalDemoMonitors/LUA_FBXG") // Green Shield Box
dofile("FinalDemoMonitors/LUA_FBXK") // Black Shield Box
dofile("FinalDemoMonitors/LUA_FBXF") // Red Shield Box
dofile("FinalDemoMonitors/LUA_FBXY") // Yellow Shield Box
dofile("FinalDemoMonitors/LUA_FBXW") // White Shield Box
dofile("FinalDemoMonitors/LUA_FBXM") // Miscellaneous Commonalities
dofile("FinalDemoMonitors/LUA_FBXE") // Eggman Box
dofile("FinalDemoMonitors/LUA_FBXU") // Gravity Boots Box
dofile("FinalDemoMonitors/LUA_FBXQ") // Mystery Box
dofile("FinalDemoMonitors/LUA_FBXT") // Teleporter Box
dofile("FinalDemoMonitors/LUA_FBXC") // Recycler Box

// 2.1

dofile("2.1Monitors/LUA_2BOX") // 2.1 Box Commonalities
dofile("2.1Monitors/LUA_2BY2") // Yellow Icon Commonalities
dofile("2.1Monitors/LUA_2BXR") // Ring Boxes
dofile("2.1Monitors/LUA_2BXS") // Sneakers Box
dofile("2.1Monitors/LUA_2BI2") // Rainbow Icon Commonaltities
dofile("2.1Monitors/LUA_2BXI") // Invincibility Box
dofile("2.1Monitors/LUA_2BXP") // Score Boxes
dofile("2.1Monitors/LUA_2BX1") // 1-up Box
dofile("2.1Monitors/LUA_2BXY") // Attraction Shield Box
dofile("2.1Monitors/LUA_2BB2") // Blue Icon Commonalities
dofile("2.1Monitors/LUA_2BXB") // Force Shield Box
dofile("2.1Monitors/LUA_2BK2") // Red Icon Commonalities
dofile("2.1Monitors/LUA_2BXK") // Armageddon Shield Box
dofile("2.1Monitors/LUA_2BW2") // White Icon Commonalities
dofile("2.1Monitors/LUA_2BXW") // Whirlwind Shield Box
dofile("2.1Monitors/LUA_2BXF") // Elemental Shield Box
dofile("2.1Monitors/LUA_2BG2") // Green Icon Commonalities
dofile("2.1Monitors/LUA_2BXG") // Pity Shield Box
dofile("2.1Monitors/LUA_2BXM") // Miscellaneous Box Commonalities
dofile("2.1Monitors/LUA_2BXE") // Eggman Box
dofile("2.1Monitors/LUA_2BXU") // Gravity Boots Box
dofile("2.1Monitors/LUA_2BXQ") // Mystery Box
dofile("2.1Monitors/LUA_2BXT") // Teleporter Box
dofile("2.1Monitors/LUA_2BXC") // Recycler Box

// --------------------------------
// Enemies
// --------------------------------

// Common

//dofile("Common/LUA_COMN") // Invisible Sprite (not needed since SPR_NULL exists)
dofile("Common/LUA_RBLT") // Retro Jett-Bullet
dofile("Common/LUA_RBMB") // Retro Jett-Bomb
//dofile("Common/LUA_9MIS") // XMAS Missile (not needed since LUA_OMIS is the same thing)
dofile("Common/LUA_JETF") // Glaber's Jetfumes
dofile("Common/LUA_CCOM") // A_CrawlaCommanderThink ported from pre-2.2

dofile("Tech Ghost/LUA_GHOS") // Halloween Tech Ghost

dofile("SRB1 Badnicks/LUA_SRBA") // SRB1 Crawla
dofile("SRB1 Badnicks/LUA_SRBB") // SRB1 Guard Robo
dofile("SRB1 Badnicks/LUA_SRBC") // SRB1 Pyrin
dofile("SRB1 Badnicks/LUA_SRBD") // SRB1 HotRobo
dofile("SRB1 Badnicks/LUA_SRBE") // SRB1 Pogminz
dofile("SRB1 Badnicks/LUA_SRBF") // SRB1 Pog-GX2
dofile("SRB1 Badnicks/LUA_SRBG") // SRB1 Pyrex
dofile("SRB1 Badnicks/LUA_SRBH") // SRB1 Turret
dofile("SRB1 Badnicks/LUA_SRBI") // SRB1 SWAT Bot
dofile("SRB1 Badnicks/LUA_SRBJ") // SRB1 SpyBot 2000
dofile("SRB1 Badnicks/LUA_SRBK") // SRB1 Buzz Bomber
dofile("SRB1 Badnicks/LUA_SRBL") // SRB1 RBZ Spike
dofile("SRB1 Badnicks/LUA_SRBN") // SRB1 Super SWAT Bot
dofile("SRB1 Badnicks/LUA_SRBO") // SRB1 Genrex

dofile("TGF Blue Crawla/LUA_TGCW") // TGF Blue Crawla
dofile("TGF Red Crawla/LUA_TGRC") // TGF Red Crawla
dofile("Blue Crawla FD/LUA_BCRW") // Final Demo Blue Crawla
dofile("Red Crawla FD/LUA_RCRW") // Final Demo Red Crawla
dofile("Blue Crawla 2.0/LUA_BCW2") // 2.0 Blue Crawla
dofile("Red Crawla 2.0/LUA_RCW2") // 2.0 Red Crawla
dofile("SDURF/LUA_SDUR") // Pre-2.0 SDURF
dofile("SDURF 2.0/LUA_SDU2") // 2.0 SDURF

dofile("TGF Gunner/LUA_GFGN") // TGF Gunner
dofile("TGF Bomber/LUA_GFBM") // TGF Bomber
dofile("Jetty-syn bomber/LUA_RJTB") // Pre-2.2 Jetty-Syn Gunner
dofile("Jetty-syn gunner/LUA_RJTG") // Pre-2.2 Jetty-Syn Bomber

dofile("Crawla Commander FD/LUA_OCOM") // Final Demo Crawla Commander
dofile("Crawla Comander 2.0/LUA_2COM") // 2.0 Crawla Commander
dofile("Springshells/LUA_SSHL") // Pre-2.2 Springshells
dofile("Buzzes/LUA_BUZZ") // Pre-2.2 Buzzes
dofile("Bubble Buzz/LUA_BBUZ") // Bubble Buzz
dofile("Autoturet/LUA_TURT") // Pre-2.2 Autoturret
dofile("tgfdeeton/LUA_TDTN") // TGF Deton

dofile("TGF Skim/LUA_TSKM") // TGF Skim
dofile("Old Skim/LUA_SKIM") // Pre-2.0 Skim
dofile("fishbot/LUA_TFSH") // TGF Fishbot
dofile("Mines/LUA_MINE") // Pre-2.2 Mine

dofile("2.0 Robohood/LUA_RBHD") // Pre-2.2 Robohood
dofile("Egg Guard 2.1/LUA_EGRD") // Pre-2.2 Egg Guard
dofile("Castlebot Facestabber/LUA_CBF2") // Pre-2.2 CastleBot FaceStabber

dofile("TGF Minus/LUA_TMIN") // TGF Minus
dofile("User Minus/LUA_UMIN") // User Minus
dofile("Minus 2.0/LUA_MNUS") // Pre-2.2 Minus
dofile("Drillakilla/LUA_TDRL") // Drillakilla
dofile("2.0 Snapper/LUA_SNAP") // Pre-2.2 Snapper
dofile("BASH/LUA_BASH") // Pre-2.2 BASH

dofile("Rockbot/LUA_RKBT") // Rockbot
dofile("Old Fireball/LUA_OPUM") // Pre-2.2 Puma (Fireball)
dofile("UNIDUS/LUA_OUNI") // Pre-2.2 Unidus

dofile("2.0 Sharp/LUA_SHRP") // Sharp
dofile("2.0 Snailer/LUA_SNAL") // Pre-2.2 Snailer
dofile("Dev Turret/LUA_DTUR") // Pre-Final Demo Pop-up Turret
dofile("FD Popup turret/LUA_PTUR") // Final Demo Pop-up Turret
dofile("EggHead/LUA_EHED") // Egg Head

// --------------------------------
// Miscellanous
// --------------------------------

-- dofile("_lib.lua") //needed for object replacement aparently
dofile("old_spec_and_nights.lua") //Old Special stages and Nights stuff. Allows for more special stages.
dofile("LUA_EMRG") // Emergency Holo-Springs
dofile("LUA_HUBS") // Exit system
dofile("LUA_HALO") // Pre-Final Demo water colormap emulation
dofile("LUA_MACH") // Final Demo Ringslinger
dofile("LUA_ADVE") // Final Demo Adventure Mode
dofile("Palettes/LUA_LEGP") // Legacy Palettes
dofile("Palettes/21Skincolors.lua") // 2.1 palettes
dofile("Palettes/20Skincolors.lua") // 2.0 palettes
dofile("Palettes/Pre20Skincolors.lua") // final demo and below palettes
dofile("LUA_RING") // Anti-Ring-Eating Lava
dofile("LUA_LMON") // Demo 3 Mega Man's lemon shooter
dofile("LUA_DNDN") // Plasma Drone floor check action
dofile("LUA_7BSS") // Various actions for bosses
dofile("LUA_SSFX") // Special Stage Fix (I don't know if this is still needed)
dofile("LUA_TKNS") // Final Demo Token
dofile("LUA_SIGN") // Old Signpost
dofile("LUA_GAME") // Camera Stand (used for Grand Credits)
dofile("LUA_PRTI") // Particle spawner (used for SD2 Black Eggman)
dofile("LUA_SILR") // Modern Silver Ring Box
dofile("LUA_CAPS") // Game Gear-styled capsule (Used for TGF Greenflower Boss)
dofile("LUA_NSTP") // Nospin teleporter
dofile("LUA_LMTL") // Loser Metal Sonic
dofile("TGF Minecart/LUA_TCRT") // TGF mine Cart
dofile("L_CircuitExitLevelFix_V1.2.lua") //circuit hotfix
dofile("SpecialFX/LUA_XSTP") // Special Effects for foot steps

// --------------------------------
// Bosses
// --------------------------------

// Commonalities

dofile("LUA_CMMN") // Retro Bosses Commonalities
dofile("LUA_OMCE") // Pre-2.2 Maces and Chains
dofile("LUA_OJTF") // Old Jet Fumes

// TGF Bosses

dofile("Plasma Drone/LUA_PDRN") // Plasma Drone
dofile("Fan-a-tic/LUA_FATC") // Fan-a/tic

// Egg Mobile

dofile("LUA_EMCM") // Egg Mobile Commonalities
dofile("LUA_20EM") // 2.0 Egg Mobile
dofile("LUA_21EM") // 2.1 Egg Mobile
//dofile("LUA_FDEC.txt") // Final Demo Egg Mobile's Spikeball Shield (Not needed since the functionality has been merged into the Final Demo Egg Mobile)
dofile("LUA_FDEG") // Final Demo Egg Mobile
dofile("LUA_OMIS") // XMAS Missile
dofile("LUA_D4EG") //  Pre-Final Demo Egg Mobile

// Egg Slimer

dofile("LUA_ENCM") // Egg Slimer Commonalities
dofile("LUA_20EN") // 2.0 Egg Slimer
dofile("LUA_21EN") // 2.1 Egg Slimer
dofile("LUA_FDEN") // Final Demo Egg Slimer

// Sea Egg

dofile("LUA_EOCM") // Sea Egg Commonalities
dofile("LUA_20EO") // 2.0 Sea Egg
dofile("LUA_21EO") // 2.1 Sea Egg

// Eggscalibur

dofile("LUA_21EP") // 2.1 Eggscalibur (Old Egg Colosseum)

// Metal Sonic

dofile("LUA_21MS") // 2.1 Metal Sonic

// Brak Eggman

dofile("LUA_BECM") // Brak Eggman Commonalities
dofile("LUA_20BE") // 2.0 Brak Eggman
dofile("LUA_21BE") // 2.1 Brak Eggman
dofile("LUA_OFIR") // Pre-2.2 Fire

dofile("LUA_UNSD") // Unsolid enemies (Please load this after every other enemy in the mod)

// --------------------------------
//text boxes
// --------------------------------
if CFTextBoxes then
    error("A version of Clone Fighter's Text Boxes is already loaded. Please restart the game without it!\nSRB2 The Past uses a modified version of the library.", -1)
    return
end

-- load the library
dofile("TextboxLibrary.lua")

-- load Everything Else
dofile("Dialogues/DialogSetup.lua")
-- Hubs
dofile("Dialogues/Hubs/NiGHTSHub.lua")
dofile("Dialogues/Hubs/DevHub.lua")
dofile("Dialogues/Hubs/UnlockHub.lua")
dofile("Dialogues/Hubs/ERZHub.lua")
-- Metal's Challenge
dofile("Dialogues/Metal's Challenge/MetalsChallenge.lua")
dofile("Dialogues/Metal's Challenge/Tantrum.lua")
dofile("Dialogues/Metal's Challenge/Victory.lua")
-- Museum
dofile("Dialogues/Museum/MuseumXmas.lua")
dofile("Dialogues/Museum/MuseumBadniks.lua")
dofile("Dialogues/Museum/MuseumHidden.lua")
dofile("Dialogues/Museum/TrueEnding.lua") -- It's... technically in the museum, I guess? It *takes place* there at least

-- SRB2TP - TPEra init.lua
-- Copy the below chunk of code into SRB2TP's init.lua
-- Where exactly it should go, I'm still not sure of yet
dofile("TPEra/TPEra.Defines.lua")
--dofile("TPEra/TPEraWeaponRings.lua")
--dofile("TPEra/TPEraShields.lua")
dofile("TPEra/TPEra.Main.lua")
dofile("TPEra/TPEra.Tweaks.lua")
dofile("TPEra/TPEra.Rings.lua")
dofile("TPEra/TPEra.Springs.lua")
dofile("TPEra/TPEra.StarPosts.lua")


