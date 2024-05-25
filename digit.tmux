#!/usr/bin/env bash
# shellcheck disable=SC2155
interpolation=(
	"#S"
	"#I"
)

#digits=(⓪ ① ② ③ ④ ⑤ ⑥ ⑦ ⑧ ⑨ ⑩ ⑪ ⑫ ⑬ ⑭ ⑮ ⑯ ⑰ ⑱ ⑲ ⑳)
#digits=(0 󰲠 󰲢 󰲤 󰲦 󰲨 󰲪 󰲬 󰲮 󰲰)
#digits=(󰼎 󰼏 󰼐 󰼑 󰼒 󰼓 󰼔 󰼕 󰼖 󰼗)
digits=(󰎢 󰎥 󰎨 󰎫 󰎲 󰎯 󰎴 󰎷 󰎺 󰎽)
#digits=(󰎡 󰎤 󰎧 󰎪 󰎭 󰎱 󰎳 󰎶 󰎹 󰎼)
#digits=(󰎣 󰎦 󰎩 󰎬 󰎮 󰎰 󰎵 󰎸 󰎻 󰎾)
#digits=( 󰬺 󰬻 󰬼 󰬽 󰬾 󰬿 󰭀 󰭁 󰭂)

get_command() {
	for i in {0..20}; do
		echo -n "#{?#{==:#$1,$i},${digits[i]},}"
	done
}

commands=(
	"$(get_command S)"
	"$(get_command I)"
)

get_tmux_option() {
	local option=$1
	local default_value=$2
	local option_value=$(tmux show-option -gqv "$option")
	if [ -z "$option_value" ]; then
		echo "$default_value"
	else
		echo "$option_value"
	fi
}

set_tmux_option() {
	local option="$1"
	local value="$2"
	tmux set-option -gq "$option" "$value"
}

do_interpolation() {
	local all_interpolated="$1"
	for ((i = 0; i < ${#commands[@]}; i++)); do
		all_interpolated=${all_interpolated//${interpolation[$i]}/${commands[$i]}}
	done
	echo "$all_interpolated"
}

update_tmux_option() {
	local option="$1"
	local option_value="$(get_tmux_option "$option")"
	local new_option_value="$(do_interpolation "$option_value")"
	set_tmux_option "$option" "$new_option_value"
}

main() {
	update_tmux_option set-titles-string
	update_tmux_option status-left
	update_tmux_option status-right
	update_tmux_option window-status-current-format
	update_tmux_option window-status-format
}
main
