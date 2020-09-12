#!/bin/bash
rsync -avr --progress /app/Configs/ /Configs/
rsync -avr --progress /app/Mods/ /Mods/
rsync -avr --progress /conf.d/* /Configs/
rsync -avr --progress /mod.d/* /Mods/
