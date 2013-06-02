#!/bin/bash
gnome-terminal --tab -e "grunt watch:karma" --tab -e "grunt watch:coffee" --tab -e "grunt watch:coffeeTest" --tab -e "grunt karma" 