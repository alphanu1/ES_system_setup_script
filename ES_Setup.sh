#!/bin/bash

while :
do

	echo "$STR"
	echo -e "\033[32mPlease type the console short name from the following list. Followed by [ENTER] or pres [ctrl+c] to quit.\n\033[0m
3do | amiga | amstradcpc | apple2 | art | atari2600 | atari5200 \n
atari7800 | atari800 | atarijaguar | atarijaguarcd | atarist | atarifalcon\n
atarixe | c64 | colecovision | dreamcast | amstradcpc | fba | gamegear | gb | gba | gbc \n
gc | genesis | intellivision | macintosh | mame | mastersystem | megadrive | n64 \n
neogeo | nes | ngp | ngpc | pc | pcengine | ports | psx | scummvm | sega32x \n
segacd | snes | zmachine | zxspectrum
\n\n\033[32mThese are case sensitive.\033[0m"

	echo "$STR"
	read core

	echo -e "\033[32mPlease type the rom path. Please note this will be case sensitive. Followed by [ENTER]\033[0m"
	echo "$STR"
	read rom_path
	echo "$STR"

	case $core in 
		nes)
			ext=".7z .fds .nes .zip"
			console_name="Nintendo Entertainment System"
			core_name="fceum_libretro.so" 
			;;
		snes)
			ext=".7z .bin .bs .fig .mgd .sfc .smc .swc .zip"
			console_name="Super Nintendo Entertainment System"
			core_name="bsnes_balanced_libretro.so" 
			;;
		genesis)
			ext="7z .bin .gen .md .sg .smd .zip"
			console_name="Sega Genesis"
			core_name="genesis_plus_gx_libretro.so" 
			;;
		megadrive)
			ext="7z .bin .gen .md .sg .smd .zip"
			console_name="Sega Genesis"
			core_name="genesis_plus_gx_libretro.so" 
			;;
		psx)
			ext=".cue .cbn .chd .img .iso .m3u .mdf .pbp .toc .z .znx"
			console_name="Sony Playstation"
			core_name="beetle_psx_libretro.so" 
			;;
		dreamcast)
			ext=".cdi .chd .gdi"
			console_name="Sega Dreamcast"
			core_name="reicast_libretro.so" 
			;;
		mame)
			ext=".zip"
			console_name="Multi Arcade Machine Emulator"
			core_name="mame_libretro.so" 
			;;
		*)
	esac
		
	xmls="\t<system>\n\t\t<name>"$core"</name>\n\t\t<fullname>"$console_name"</fullname>\n\t\t<path>"$rom_path"</path>\n\t\t<extension>"$ext"</extension>\n\t\t<command>retroarch -L ~/.config/retroarch/cores/"$core_name" %ROM%</command>\n\t\t<platform>"$core"</platform>\n\t\t<theme>"$core"</theme>\n\t</system>\n</systemList>"
	echo "$STR"
	echo -e $xmls
	echo "$STR"
	echo -e "\033[32Please Press [ENTER] to confirm the new system to add or [ctrl+c] to cancel.\033[0m"
	read -p ""
	echo "$STR"

	sudo sed -i "s:</systemList>:$xmls:g" ~/.emulationstation/es_systems.cfg
	
done
