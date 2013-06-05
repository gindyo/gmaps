#!/bin/bash
gnome-terminal --tab -e "grunt watch:karma -f" --tab -e "grunt watch:coffee -f" --tab -e "grunt watch:coffeeTest -f" --tab -e "grunt karma -f" 