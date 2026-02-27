sketchybar	--add	item weather right \
            --set	weather \
                    	icon= \
                    	icon.color=0xfff5bde6 \
                        icon.font="FantasqueSansMono Nerd Font:Bold:15.0" \
                        label.font="FantasqueSansMono Nerd Font:Bold:15.0" \
                    	update_freq=1800 \
                        script="$PLUGIN_DIR/weather.sh" \
            --subscribe weather system_woke

