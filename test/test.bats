#! /usr/bin/env bats
S='#{?#{==:#S,0},⓪,}#{?#{==:#S,1},①,}#{?#{==:#S,2},②,}#{?#{==:#S,3},③,}#{?#{==:#S,4},④,}#{?#{==:#S,5},⑤,}#{?#{==:#S,6},⑥,}#{?#{==:#S,7},⑦,}#{?#{==:#S,8},⑧,}#{?#{==:#S,9},⑨,}'
I='#{?#{==:#I,0},⓪,}#{?#{==:#I,1},①,}#{?#{==:#I,2},②,}#{?#{==:#I,3},③,}#{?#{==:#I,4},④,}#{?#{==:#I,5},⑤,}#{?#{==:#I,6},⑥,}#{?#{==:#I,7},⑦,}#{?#{==:#I,8},⑧,}#{?#{==:#I,9},⑨,}'
setup() {
	load /usr/lib/bats-support/load.bash
	load /usr/lib/bats-assert/load.bash
	cd "$(dirname "$BATS_TEST_FILENAME")/.." || exit
}

# work on tmux 3.3a and failed on tmux 3.2a
@test digit {
	run ./digit.tmux
	assert [ "$(tmux show-options -gv set-titles-string)" != "$S:$I" ]
	assert [ "$(tmux show-options -gv status-left)" != "$S" ]
	assert [ "$(tmux show-options -gv status-right)" != "$S" ]
	assert [ "$(tmux show-options -gv window-status-current-format)" != "$I" ]
	assert [ "$(tmux show-options -gv window-status-format)" != "$I" ]
}
