###
# some bash library helpers
# @author Wyntau Lau https://github.com/Wyntau/dotfiles
###

# Colors
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"


reset=$'\e[0m'
orange=$'\e[38;5;202m'
white=$'\e[1;37m'
blue=$'\e[38;5;26m'
azure=$'\e[1m\e[34m'

# Colors
# Big TBD

dot_color_none="\033[0m"
dot_color_reset=$'\e[0m'
dot_color_dark=$'\e[0;30m'
dot_color_dark_light=$'\e[1;30m'
dot_color_red=$'\e[0;31m'
dot_color_red_light=$'\e[1;31m'
dot_color_green=$'\e[0;32m'
dot_color_green_light=$'\e[1;32m'
dot_color_yellow=$'\e[0;33m'
dot_color_yellow_light=$'\e[1;33m'
dot_color_orange=$'\e[38;5;209m'
dot_color_blue=$'\e[0;34m'
dot_color_blue_light=$'\e[1;34m'
dot_color_purple_light=$'\e[1;35m'
dot_color_cyan=$'\e[0;36m'
dot_color_cyan_light=$'\e[1;36m'
dot_color_gray=$'\e[0;37m'
dot_color_gray_dark=$'\e[0;30m'
dot_color_gray_light=$'\e[1;37m'

dot_color_azure=$'\x1b[38;2;40;204;249m'
dot_color_light_gray=$'\x1b[38;2;168;181;191m'
dot_color_gray_dark=$'\x1b[38;2;100;100;123m'
dot_color_purple=$'\e[0;35m'


# Basics setup

function msg() {
  printf '%b\n' "$*$dot_color_none" >&2
}

function listelement() {
  printf '    %b\n' "$*$dot_color_none" >&2
}

function prompt() {
  printf '\n%b' "$dot_color_purple[+] $*$dot_color_none "
}

function step() {
  msg "\n$dot_color_yellow[→] $*"
}

function info() {
  msg "$dot_color_azure[>] $*"
}

function list() {
  listelement "→ $*"
}

function skip() {
  msg "$dot_color_gray_dark[»] $*"
}

function success() {
  msg "$dot_color_green[✓] $*"
}

function error() {
  msg "$dot_color_red_light[✗] $*"
}

function warning() {
  msg "$dot_color_orange[!] $*"
}




step "This is a test"
info "This is a test"
success "This is a test"
error "This is a test"
warning "This is a test"
skip "This is a test"