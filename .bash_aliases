#!/bin/bash

# hack to make aliases work after commands
alias sudo='sudo '
alias yt-dlp='yt-dlp '

# internal function to add help message
function helptext () {
[[ "$2" ]] || set -- "$1" 'Usage: helptext "$1" TEXT
Add a help text to a command.'
[[ "$1" == @(-h|--h|-help|--help|-\?|--\?|/\?) ]] && echo "$2" || return 1
}
#For copying:
#helptext "$1" 'Usage: ' && return
#Style guide:
#helptext "$1" 'Usage: command [-OPTION...] INFILE [OPTIONAL_FILE] THUMB... OUTFILE
#Do X to a Y and generate a Z.
#
#If Y does not work, you may try to add ß.' && return

#
# yt-dlp
#

# yt-dlp aliases
alias dl='yt-dlp -o "%(title)s.%(ext)s" --console-title --embed-metadata --parse-metadata "webpage_url:(?s)(?P<meta_composer>.+)" --parse-metadata "webpage_url:(?s)(?P<meta_subtitle>.+)" '
alias dlmp4='dldatefix -f "bv*[ext=mp4]+ba[ext*=4]/b[ext=mp4]/bv*+ba/b" '
alias dlmp3='dl -f "ba[ext=mp3]/ba" -x --audio-format mp3 --extractor-args "soundcloud:formats=http_mp3"'
alias dlmp3mus='dlmp3 --embed-thumbnail --parse-metadata "%(playlist_autonumber|)s:(?P<meta_track>.+)" --parse-metadata "%(album_artist,artist,creator,uploader)s:(?P<meta_album_artist>.+)" '
alias dlaudio='dl -f ba '
alias dlaudiomus='dlaudio --parse-metadata "%(playlist_autonumber|)s:(?P<meta_track>.+)" --parse-metadata "%(album_artist,artist,creator,uploader)s:(?P<meta_album_artist>.+)" '
alias dlf='dlmp4HD withsubs -af "bv*[ext=mp4]+ba[ext*=4]/b[ext=mp4]/bv*+ba/bv*/ba[ext=mp3]/ba/b" --embed-thumbnail --embed-chapters --parse-metadata "description:(?P<meta_comment>.+)" '
alias dla='dlaa --extractor-args "youtube:max_comments=1000,all,all,100;comment_sort=top" '
alias dlaa='dlf -R "infinite" --fragment-retries "infinite" --download-archive videos.txt --write-comments -o "infojson:Jsons/%(title)s" -o "pl_infojson:Jsons/%(title)s" '
alias dlamus='dlaamus --extractor-args "youtube:max_comments=1000,all,all,100;comment_sort=top" '
alias dlaamus='dlmp3mus -R "infinite" --fragment-retries "infinite" --download-archive audios.txt --write-comments -o "infojson:Jsons/%(title)s" -o "pl_infojson:Jsons/%(title)s" '
alias dlcomm='yt-dlp --write-comments -o "Jsons/%(title)s_$(date '+%Y_%m_%d_%H։%M։%S')" --skip-download '
alias dlsmall='dl -f b -S +size,+br,+res,+fps '
alias dl3gp='dl -f "bv*[ext=3gp]" '
alias dlHD='dlsize 1080 -af "b[format_id$=-hd]" '
alias dlSD='dlsize 1080 -af "b[format_id!$=-hd][url~='\'^https?:\\/\\/[\\w.]*steam[\\w.]*\\.com\\/.*\'']" '
alias dlmp4HD='dlmp4size 1080 -af "b[format_id$=-hd][ext=mp4]" '
alias dlmp4SD='dlmp4size 1080 -af "b[format_id!$=-hd][ext=mp4][url~='\'^https\?:\\/\\/[\\w.]*steam[\\w.]*\\.com\\/.*\'']" ' 

# Has only proven to work on mp4 files so far, mp3s don't have that problem in the first place.
alias dldatefix='dl --parse-metadata "%(release_year,upload_date).4s:(?P<meta_date>.+)" '

# Internal helper function to recognise -af options passed in higher level commands and add them after the other options
function parse_additional_formats () {
additional_formats=
i=1
while [[ $i -lt $# && ${!i} != "--" ]]; do
    if [[ ${!i} == "-af" ]]; then
        additional_formats+="/ ${*:i+1:1}"
        set - "${@:1:i-1}" "${@:i+2}"
    else
        ((i++))
    fi
done
commands=("$@")
}

function dlsize () {
helptext "$1" 'Usage: dlsize HEIGHT URL...
Download a video at the specified size.' && return
parse_additional_formats "$@"
set - "${commands[@]}"
dl -f "bv*[height<=$1]+ba/ b[height<=$1] $additional_formats" "${@:2}"
}
# This trick includes both mp4 and m4a audio files, while excluding webm which can't be merged with mp4.
function dlmp4size () {
helptext "$1" 'Usage: dlmp4size HEIGHT URL...
Download a video at the specified size as mp4.' && return
parse_additional_formats "$@"
set - "${commands[@]}"
dldatefix -f "bv*[ext=mp4][height<=$1]+ba[ext*=4]/ b[ext=mp4][height<=$1]/ bv[height<=$1]*+ba/ b[height<=$1] ${additional_formats}" "${@:2}"
}
function dlyt () {
yts "$@"
[[ $TMPVALUE ]] && dlf $TMPVALUE
}
function dlytl () {
ytsl "$@"
[[ $TMPVALUE ]] && dlf $TMPVALUE
}
function dlytm () {
yts "$@"
[[ $TMPVALUE ]] && dlmp3mus $TMPVALUE
}
function dlytml () {
ytsl "$@"
[[ $TMPVALUE ]] && dlmp3mus $TMPVALUE
}

# yt-dlp argument shortcuts
alias withcookies='--cookies-from-browser firefox '
alias withsubs='--write-subs --write-auto-subs --embed-subs --compat-options no-keep-subs '
alias withsubslangs='--write-subs --write-auto-subs --embed-subs --compat-options no-keep-subs --sub-langs * '
alias withthumb='--embed-thumbnail '
alias withchapters='--embed-chapters '
alias withsponsor='--sponsorblock-mark all '

# also notice the config in /appdata/roaming/yt-dlp/config.txt

function pingt () {
[[ $* ]] || set - 8.8.8.8
ping -t "$@"
}

alias dlimg='gallery-dl '
alias dlimga='gallery-dl --cookies-from-browser Firefox --download-archive images.txt '

alias dlpage='wget -m -k -E -p -e robots=off '

alias dlpagea='wayback_machine_downloader '

alias dlfile='curl -OJ '

function pupgrade () {
[[ $* ]] || set - pip
python.exe -m pip install --upgrade "$@"
}

alias pupcheck='python.exe -m pip install --upgrade pip yt-dlp gallery-dl'

#
# git aliases
#

# main aliases
alias ginit='git init'
alias gs='git status --short'
alias gss='git status'
alias ga='git add'
alias gaa='git add -A'
alias gac='git add -u'
function gcom () {
echo -n "Commit message: "
read -r message
git commit -m "$message" "$@"
}
function gcoma () {
echo -n "Commit message: "
read -r message
git commit -a -m "$message" "$@"
}
function gcomerge () {
echo -n "Commit message: "
read -r message
git commit --amend -m "$message" "$@"
}
alias glog='git log --graph --pretty=format:"%C(yellow)%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'

#branch aliases
alias gb='git branch'
alias gq='git switch'
alias gmerge='git merge'
alias gd='git diff --compact-summary -b --abbrev=0'
alias gds='gd --staged'
function gdd () { 
git diff -b "$@" | diff-so-fancy
}
alias gdds='gdd --staged'
alias gddd='git diff -b --abbrev=0'
alias gddds='gddd --staged'
alias gbd='git branch -d'

#remote aliases
alias gclone='git clone'
alias gremote='git remote add'
alias gf='git fetch'
alias pull='git fetch -q && git pull '
alias push='git push '

#history aliases
alias gshow='git show'
alias gtag='git tag'
alias grev='git revert -m 1 HEAD'

#other
alias gh='git --help '
alias guser='git config user.name'
alias gmail='git config user.email'


#Ffmpeg
alias ftmpreg='ffmpeg '
alias ffmpreg='ffmpeg '
alias ftmpeg='ffmpeg '
alias ffmpeg='ffmpeg -hide_banner '

#Ffprobe
alias ffprobe='ffprobe -hide_banner '

# Function to concatenate media files.
# The files are copied via ffmpeg to a temp directory, preprocessing them (otherwise it does not work),
# a hashmap makes sure no unneccesary duplicate copies are created if the same video is used multiple times,
# and in the order they were supplied added to a temporary list file that is required by the concat command.
function concat () {
helptext "$1" 'Usage: concat INFILE... OUTFILE
Concatenate media files.' && return
FOLDER=$(mktemp -d ./TEMPFOLDER_XXXXXX) &&
trap 'trap - ERR EXIT RETURN SIGINT && rm -rf $FOLDER' ERR EXIT RETURN SIGINT &&
declare -A FILES &&
for i in "${@:1:$#-1}"; do
    if [[ -v FILES[$i] ]]; then
        FILE="${FILES[$i]}"
    else
        FILE=$(mktemp -u "XXXXXX.${i##*.}") &&
        ffmpeg -i "$i" -c copy "$FOLDER/$FILE" &&
        FILES[$i]=$FILE
    fi &&
    echo "file '$FILE'" >> "$FOLDER/list.txt" || break
done &&
ffmpeg -f concat -safe 0 -i "$FOLDER/list.txt" -c copy "${@: -1}" 
}

# Adds thumbnail in file2 to file1 and outputs to file3
function addthumb () {
helptext "$1" 'Usage: addthumb INFILE THUMB OUTFILE
Add a thumbnail to a media file.' && return
ffmpeg -i "$1" -i "$2" -c copy -map 0 -map 1 -disposition:v:1 attached_pic "$3"
}

#
#File system stuff
#

alias u='cd ..'
alias uu='cd ../..'
alias uuu='cd ../../..'

alias ul='u && l '
alias uul='uu && l '
alias uuul='uuu && l '

alias ls='ls -x -p --color=always --group-directories-first -I{NTUSER.*,ntuser.*} '
alias l='echo && ls '
alias la='l -A '
# Alternatives with more info:
alias ll='ls -o --block-size=MB --time-style="+%x" | sed -E "s/^.(.{4}).{5} \S* \S*/ \1/" '
alias lm='ls -o --block-size=M --time-style="+%b %Y" | sed -E "s/^.(.{4}).{5} \S* \S*/ \1/" '
alias lb='l -1hsS --file-type | sed "/[\/@]/d; s/^/ /; 1! s/^\s*\S\+/& /" '

function cl () {
cd "$1" && l "${@:2}"
}

#Internal helper function to select a line in TMPVALUE from a number of lines
function sline () {
helptext "$1" 'Usage: sline [|| return $?]
Select a line from multiple in $TMPVALUE.' && return
([[ -z $TMPVALUE ]] || [[ $(echo "$TMPVALUE" | wc -l) == 1 ]]) && return
echo "$TMPVALUE" | nl -w1 -s ' '
read OPTION
[[ -z $OPTION ]] && return 4
if [[ $OPTION == +([0-9]) ]] && (( OPTION > 0 && OPTION <= $(echo "$TMPVALUE" | wc -l) ))
then
    TMPVALUE="$(echo "$TMPVALUE" | sed -n "$OPTION p")"
else
    TMPVALUE="$(echo "$TMPVALUE" | sed -n "/$OPTION/Ip")"
    sline
fi
}

#Removes colour escape codes from output
function decolourise () {
helptext "$1" 'Remove colour escape codes.' && return
sed 's/\x1B\[[0-9;]\{1,\}[A-Za-z]//g'
}

# Search for and open a folder#
function cs () {
[[ $* ]] && i="$*" || read -p "    " i
[[ $i ]] || i="."
TMPVALUE="$(ls -1A | sed -n "/\/$/p" | sed -n "/$i/Ip")"
sline || return $?
[[ -z $TMPVALUE ]] && echo "No folder found" && return
echo "$TMPVALUE"
cd "$(echo "$TMPVALUE" | decolourise)"
}

function csl () {
cs "$@" && l
}

#Search for files
function s () {
[[ $* ]] && i="$*" || read -p "    " i
[[ $i ]] || i="."
ls -1hsS -A | sed -n "1d; /$i/Ip"
}

#Recursive search
function rs () {
TMPVALUE="$(s "$@")"
sline || return $?
[[ -z $TMPVALUE ]] && echo "No file found" && return
echo "$TMPVALUE"
}

#Open the explorer in the current directory
function e () {
[[ $* ]] || set - .
if [[ $OSTYPE == "msys" || $OSTYPE == "cygwin" ]]
then
    explorer "$(toWin "$*" | sed "s/\\\\$//")" # explorer can't handle folders with spaces ening in \
else
    dolphin "$(toUn "$*")"
fi
}

#Open a file
function o () {
[[ $* ]] || return
if [[ $OSTYPE == "msys" || $OSTYPE == "cygwin" ]]
then
    explorer "$(toWin "$*" | sed "s/\\\\$//")" # explorer can't handle folders with spaces ening in \
else
    xdg-open "$(toUn "$*")"
fi
}

#Search for and open a file
function os () {
rs "$@" || return $?
o "$(echo "$TMPVALUE" | sed -E "s/^\s*\S+\s+//" | decolourise)"
}

alias q='exit '
alias quit='exit '
alias x='exit '

alias catt='echo && cat '

#For writing in nano, -$ enables wrapping, -w disables inserting these breaks into the file, -a wraps only at blanks instead of splitting words
alias write='nano -\$aw '

#List 10 biggest files
alias ducks='ducksa | head -n10'
alias ducksa='echo && du -ksh * | sort -rh'

#
# Other aliases
#

#Console utility
alias edit='nano '
alias editalias='nano ~/.bash_aliases '
alias editnano='nano ~/.nanorc '
alias refresh='source ~/.bashrc'
#Note: Sometimes you have to close+open the shell again for it to work too

#For keeping track of commands used in creating an archive
function addcommand () {
helptext "$1" 'Usage: COMMAND && addcommand or addcommand
Log the last used command in used_commands.txt.' && return
#check if called in the same line or a separate command
if (history 1 | grep -Exq " +[0-9]+ +addcommand")
then
    history 2 | sed -E "2d; s/^ +[0-9]+ +//" >> used_commands.txt
else
    history 1 | sed -E "s/^ +[0-9]+ +//;s/;?&?&? ?addcommand$//" >> used_commands.txt
fi
}
alias addcomm='addcommand'

#
#More youtube utils
#

# Search on youtube, print title and return url in $TMPVALUE
function yts () {
[[ $* ]] || return
TMPVALUE=$(yt-dlp ytsearch1:"$*" --get-title --get-id --no-warnings)
echo "$TMPVALUE" | sed -n 1p
TMPVALUE=$(echo "$TMPVALUE" | sed -n 2p)
}

OPTIONS=8

# Search on youtube, show 8 or more results and let the user choose one, then return url in $TMPVALUE
function ytsl () {
[[ $* ]] || return
RESULTS=$(mktemp)
trap 'trap - ERR EXIT RETURN SIGINT && OPTIONS=8 && rm -f $RESULTS' ERR EXIT RETURN SIGINT
#Oneliner: Get the data from youtube, dump into $Results for later, remove every 3rd line and therefore the IDs, put () around every second line (durations), join every second line with the previous one, add line numbers. -u to do this while the stream being is generated. --flat-playlist bc otherwise it does a request for every single result.
yt-dlp ytsearch$OPTIONS:"$*" --print title --print duration_string --print id --no-warnings --flat-playlist | tee "$RESULTS" | sed -u '3~3d; 2~3{s/\(.*\)/(\1)/}' | sed -u '$!N;s/\n/ /'  | nl -w1 -s' '
read OPTION
#About double the amount of options if nothing is selected but something searched, raise it to that number if the selection is outside the range, yield the option's ID if it isn't and stop, exit on a 0 or most letters. Recursively calls itself to provide more options. The trap resets the amount of options to 8 again afterwards.
if [[ -z $OPTION ]]
then
    #Have it progress 8 > 20 > 50 > 100 > 200 > ...
    if (( OPTIONS < 50 ))
    then
        OPTIONS=$(( OPTIONS*5/2 ))
    else
        OPTIONS=$(( OPTIONS*2 ))
    fi
    ytsl "$@"
elif (( OPTION > OPTIONS ))
then
    OPTIONS=$OPTION
    ytsl "$@"
elif (( OPTION > 0 ))
then
    TMPVALUE=$(sed -n "$((OPTION*3))p" < "$RESULTS")
else
    TMPVALUE=
fi
}

#Set/echo the tmp variable
function tmp () {
[[ $* ]] && TMPVALUE="$*" || echo "$TMPVALUE"
}

#Abstract function: Uses yt-dlp command given in the first argument to download into temp and opens it using the program given in the second argument.
#Make sure $TMPDIR is set to the right absolute path when problems opening the file occur.
function tempdl () {
(( ${#*} < 3 )) && echo "No url selected" && return
FILE=$(mktemp)
#Not too proud of this one, but my music player throws an error on startup which deletes the file before it can use it. So now mp3 files don't get deleted from temp at all anymore. Windows should clean that up though.
trap 'trap - EXIT RETURN SIGINT && rm -f $(echo $FILE.* | grep -v mp3)' EXIT RETURN SIGINT
eval "$1" -o "\"$FILE.%(ext)s\"" -q --no-warnings --progress "${*:3}"
eval "$2" "\"$(optToWin "$FILE".*)\""
}

#Abstract function: Combine tempdl and yts
function tempyt () {
yts "${*:3}"
[[ $TMPVALUE ]] && tempdl "$1" "$2" -- $TMPVALUE
}

#Abstract function: Combine tempdl and ytsl
function tempytl () {
ytsl "${*:3}"
[[ $TMPVALUE ]] && tempdl "$1" "$2" -- $TMPVALUE
}

#Use dl to download into temp and view
alias opendl='tempdl dlHD vlc -af "bv*+ba/b" '
#Do the same, but search it on youtube before
alias openyt='tempyt dlHD vlc '
#Do the same and let the user choose between the first 8 search results
alias openytl='tempytl dlHD vlc '

#And the same thing again for music
alias opendlm='tempdl dlmp3mus o '
alias openytm='tempyt dlmp3mus o '
alias openytlm='tempytl dlmp3mus o '


#
##
##Experimental (only works on some systems):
##
#


#
#To view media in terminal
#

#Get fps and pass it to mplayer, framedrop cuz its too slow
function catvid () {
helptext "$1" 'Usage: catvid FILE...
Play a video in terminal.

Use catvidfps to manually adjust the fps if autodetection does not work.
Works better on Windows if conhost.exe is replaced with the newer version from the Windows Terminal project.' && return
FPS=$(ffprobe -v 0 -of csv=p=0 -select_streams v:0 -show_entries stream=r_frame_rate "$@")
catvidfps $FPS "$@"
}
#If autodetection doesn't work
function catvidfps () {
helptext "$1" 'Usage: catvidfps FPS FILE...
Play a video in terminal at the given fps.' && return
mplayer -really-quiet -vo caca -framedrop -fps "$@"
}

# Note: If the video and audio are desynced, try setting Computer\HKEY_CURRENT_USER\Console\UseDx to 1, then st font size to 10. Enables emoji support, but decreases font size and readability.

#Use dl to download into temp and view
alias catdl='tempdl dlSD catvid -af "bv*+ba/b" '
#Do the same and search it on youtube
alias catyt='tempyt dlSD catvid '
#Do the same and let the user choose between the first 8 search results
alias catytl='tempytl dlSD catvid '


#
#OS compatibility functions
#

#Convert Unix path to Windows path
function toWin () {
echo "$@" | sed -E 's_^/(\w)(/|$|:/?)|^(\w):/?\\?_\1\3:\\_; s_/_\\_g'
}
#Convert Windows Path to Unix path
function toUn () {
echo "$@" | sed -E "s_^/(\w)(/|$|:/?)|^(\w):/?\\\\?_/\1\3/_; s_\\\\_/_g"
}
#Convert Unix path to Windows path if the OS is Windows
function optToWin () {
[[ $OSTYPE == "msys" || $OSTYPE == "cygwin" ]] && toWin "$@" || echo "$@"
}
