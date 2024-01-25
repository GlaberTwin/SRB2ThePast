--- Sonic Robo Blast 2 - Retro Monitors Binary Guide ---

At the time of writing this, Zone Builder can not handle UDMF-specific edtior 
keys yet. In the meantime, this guide should be helpful in figuring out how to 
set up these monitors in Binary levels.

-- 2.1 Monitors --

** Thing Type Numbers **

480 - Super Ring (10 Rings)
481 - CTF Team Ring Monitor (Red)
482 - CTF Team Ring Monitor (Blue)
483 - Super Sneakers
484 - Invincibility
485 - Extra Life
486 - Attraction Shield
487 - Force Shield
488 - Armageddon Shield
489 - Whirlwind Shield
490 - Elemental Shield
491 - Pity Shield
492 - Eggman
493 - Gravity Boots
494 - Mystery Monitor
495 - Teleporter
496 - Recycler
497 - Score (1,000 Points)
498 - Score (10,000 Points)

** Flags **

Extra - Disables spawning the 2.1 shield
Special - Sets the "respawn behavior" of the monitor to "Random (Strong)"
Ambush - Sets the "respawn behavior" of the monitor to "Random (Weak)"

-- Final Demo/2.0 Monitors --

** Thing Type Numbers **

462 - Super Ring (10 Rings)
463 - Silver Ring (25 Rings)
464 - 2.0 CTF Team Ring Monitor (Red)
465 - 2.0 CTF Team Ring Monitor (Blue)
466 - Super Sneakers
467 - Invincibility
468 - Extra Life
469 - Blue Shield
470 - Green Shield
471 - Black Shield
472 - Red Shield
473 - Yellow (Attraction) Shield
474 - White (Whirlwind) Shield
475 - Eggman
476 - 2.0 Gravity Boots
477 - Mystery Monitor
478 - Teleporter
479 - 2.0 Recycler

** Flags **

Extra - Disables spawning the era-appropriate shield (only used by the shield monitors)
Special - Sets the "respawn behavior" of the monitor to "Random (Strong)"
Ambush - Sets the "respawn behavior" of the monitor to "Random (Weak)" for 2.0 monitors and "Random" for pre-2.0 monitors
Parameter - Sets the era of the monitor
	- 0 is "2.0"
	- 1 is "1.09-1.09.4
	- 2 is "1.08"
	- 3 is "2K3-1.04"
	- For more information on what these eras do, please look at README.txt

-- XMAS-Demo 4.35 Monitors --

** Thing Type Numbers **

453 - Super Ring (10 Rings)
454 - Silver Ring (25 Rings)
455 - Super Sneakers
456 - Invincibility
457 - Extra Life
458 - "Basic" Shield
459 - "Elemental" Shield
460 - Attraction Shield
461 - Armageddon Shield

** Flags **

Extra - Disables spawning the era-appropriate shield (only used by the shield monitors)
Parameter - Sets the era of the monitor
	- 0 is "Demo 2-4.35" (shields are drawn on top of the player)
	- 1 is "XMAS-Demo 1" (shields are drawn below the player)

-- TGF Monitors/Power-Ups --

** Thing Type Numbers **

510 - Super Ring (10 Rings)
511 - Super Sneakers
512 - Extra Life
513 - "Basic" Shield
514 - Super Ring (5 Rings) (Power-Up)
515 - Super Sneakers (Power-Up)
516 - Invincibility (Power-Up)
517 - Time Bonus (Power-Up)

** Flags **

Special (Monitors Only) - Spawns a big explosion when the monitor is destroyed
Ambush (Power-Ups Only) - Makes the power-up float in the air
