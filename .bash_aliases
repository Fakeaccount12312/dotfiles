# hack to make aliases work after commands
alias sudo='sudo '
alias yt-dlp='yt-dlp '

#
# yt-dlp
#

# yt-dlp aliases
alias dl='yt-dlp -o "%(title)s.%(ext)s" --console-title --embed-metadata --parse-metadata "webpage_url:(?s)(?P<meta_composer>.+)" --parse-metadata "webpage_url:(?s)(?P<meta_subtitle>.+)" '
alias dlmp4='dldatefix -f "bv*[ext=mp4]+ba[ext*=4]/b[ext=mp4]/bv*+ba/b" '
alias dlmp3='dl -f "ba[ext=mp3]/ba" -x --audio-format mp3 '
alias dlmp3mus='dlmp3 --embed-thumbnail --parse-metadata "%(playlist_autonumber|)s:(?P<meta_track>.+)" --parse-metadata "%(album_artist,artist,creator,uploader)s:(?P<meta_album_artist>.+)" '
alias dlaudio='dl -f ba '
alias dlaudiomus='dlaudio --parse-metadata "%(playlist_autonumber|)s:(?P<meta_track>.+)" --parse-metadata "%(album_artist,artist,creator,uploader)s:(?P<meta_album_artist>.+)" '
alias dlf='dlmp4HD withsubs --embed-thumbnail --embed-chapters --parse-metadata "description:(?P<meta_comment>.+)" '
alias dla='dlaa --extractor-args "youtube:max_comments=1000,all,all,100;comment_sort=top" '
alias dlaa='dlf -R "infinite" --fragment-retries "infinite" --download-archive videos.txt --write-comments -o "infojson:Jsons/%(title)s" -o "pl_infojson:Jsons/%(title)s" '
alias dlcomm='yt-dlp --write-comments -o "infojson:Jsons/%(title)s" -o "pl_infojson:Jsons/%(title)s" --skip-download ' 
alias dlsmall='dl -f b -S +size,+br,+res,+fps '
alias dl3gp='dl -f "bv*[ext=3gp]" '
alias dlHD='dlsize 1080 -f "b[format_id$=-hd]" '
alias dlSD='dlsize 1080 -f "b[format_id!$=-hd][url~='\'^https?:\\/\\/[\\w.]*steam[\\w.]*\\.com\\/.*\'']" '
alias dlmp4HD='dlmp4size 1080 -f "b[format_id$=-hd][ext=mp4]" '
alias dlmp4SD='dlmp4size 1080 -f "b[format_id!$=-hd][ext=mp4][url~='\'^https?:\\/\\/[\\w.]*steam[\\w.]*\\.com\\/.*\'']" ' 

# Has only proven to work on mp4 files so far, mp3s don't have that problem in the first place.
alias dldatefix='dl --parse-metadata "%(release_year,upload_date).4s:(?P<meta_date>.+)" '

# Internal helper function to recognise -f options passed in higher level commands and add them after the other options
function parse_additional_formats () {
additional_formats=
arg=1
while [ "${!arg}" == "-f" ]||[ "${!arg}" == "--format" ]; do
    (( arg++ ))
    additional_formats+="/ ${!arg}"
    (( arg++ ))
done
}

function dlsize () {
parse_additional_formats ${*:2}
dl -f "bv*[height<=$1]+ba/ b[height<=$1] ${additional_formats}" ${*:arg+1} 
}
# This trick includes both mp4 and m4a audio files, while excluding webm which can't be merged with mp4.
function dlmp4size () {
parse_additional_formats ${*:2}
dldatefix -f "bv*[ext=mp4][height<=$1]+ba[ext*=4]/ b[ext=mp4][height<=$1]/ bv[height<=$1]*+ba/ b[height<=$1] ${additional_formats}" ${*:arg+1}
}
function dlyt () {
yts "$@"
[ -z $TMPVALUE ] || dlf $TMPVALUE
}
function dlytl () {
ytsl "$@"
[[ -z $TMPVALUE ]] || dlf $TMPVALUE
}
function dlytmp3 () {
yts "$@"
[[ -z $TMPVALUE ]] || dlmp3mus $TMPVALUE
}
function dlytmp3l () {
ytsl "$@"
[[ -z $TMPVALUE ]] || dlmp3mus $TMPVALUE
}

# yt-dlp argument shortcuts
alias withcookies='--cookies-from-browser firefox '
alias withsubs='--write-subs --write-auto-subs --embed-subs --compat-options no-keep-subs '
alias withsubslangs='--write-subs --write-auto-subs --embed-subs --compat-options no-keep-subs --sub-langs *'
alias withthumb='--embed-thumbnail '
alias withchapters='--embed-chapters '
alias withsponsor='--sponsorblock-mark all '

# also notice the config in /appdata/roaming/yt-dlp/config.txt

alias pingt='ping 8.8.8.8'

alias dlimg='gallery-dl '
alias dlimga='gallery-dl --cookies-from-browser Firefox --download-archive images.txt '

alias dlpage='wget -m -k -E -p -e robots=off '

alias dlpagea='wayback_machine_downloader '

alias dlfile='curl -OJ '

alias pupgrade='pip install --upgrade '

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
FOLDER=$(mktemp -d ./TEMPFOLDER_XXXXXX) &&
trap 'trap - ERR EXIT RETURN SIGINT && rm -rf $FOLDER' ERR EXIT RETURN SIGINT &&
declare -A FILES &&
for i in "${@:1:$#-1}"; do
    if [[ -v "FILES[$i]" ]]; then
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

#
#File system stuff
#

alias u='cd ..'
alias uu='cd ../..'
alias uuu='cd ../../..'

alias ul='u && l '
alias uul='uu && l '
alias uuul='uuu && l '

function cl () {
cd "$@" && l
}


alias ls='ls -x -p --color=always --group-directories-first -I{NTUSER.*,ntuser.*} '
alias l='echo && ls '
alias la='l -A '
# Alternatives with more info:
alias ll='ls -o --block-size=MB --time-style="+%x" | sed -E "s/^.(.{4}).{5} \S* \S*/ \1/" '
alias lm='ls -o --block-size=M --time-style="+%b %Y" | sed -E "s/^.(.{4}).{5} \S* \S*/ \1/" '
alias lb='l -1hsS --file-type | sed "/[\/@]/d;s/^/ /;1! s/^\s*\S\+/& /" '
#Search for files
function s () {
if [[ -z "$@" ]]; then
    read -r -p "    " input
else
    input="$*"
fi
if [[ -z $input ]]; then
     ls
else
    echo && ls -1hsS -A | sed -En "/$input/p"
fi
}

#Open the explorer in the current directory
function e () {
[[ -z "$@" ]] && path="." || path="$*"
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]
then
    explorer "$(toWin $path)"
else
    dolphin "$(toUn $path)"
fi
}

#Open a file
function o () {
[[ -z "$@" ]] && return
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]
then
    explorer "$(toWin $@)"
else
    xdg-open "$(toUn $@)"
fi
}

#Search for and open a file
function os () {
TMPVALUE="$(s "$@" | sed '1d')"
if [[ -z "$TMPVALUE" ]]
then
    echo "No file found"
elif [[ $(echo "$TMPVALUE" | wc -l) == "1" ]]
then
    o $(echo "$TMPVALUE" | sed -E "s/^\s*\S+\s+//")
else
    echo "$TMPVALUE" | nl -w1 -s ' ' 
    read OPTION
    if (($OPTION > 0 && $OPTION <= $(echo "$TMPVALUE" | wc -l)))
    then
        o $(echo "$TMPVALUE" | sed -En "$OPTION s/^\s*\S+\s+//p")
    fi
fi
}
 
alias q='exit '
alias x='exit '

alias catt='echo && cat '

#For writing in nano, -$ enables wrapping, -w disables inserting these breaks into the file, -a wraps only at blanks instead of splitting words
alias write='nano -\$aw'

#List 10 biggest files
alias ducks='du -ksh * | sort -rh | head -n10'
alias ducksa='du -ksh * | sort -rh'

alias edit='nano '
alias editalias='nano ~/.bash_aliases '
alias editnano='nano ~/.nanorc '
alias refresh='source ~/.bashrc'
#Note: Sometimes you have to close+open the shell again for it to work too

#
#More youtube utils
#

# Search on youtube, print title and return url in $TMPVALUE
function yts () {
[[ -z "$@" ]] && return
TMPVALUE=$(yt-dlp ytsearch1:"$*" --get-title --get-id --no-warnings)
echo "$TMPVALUE" | sed -n 1p
TMPVALUE=$(echo "$TMPVALUE" | sed -n 2p)
}

OPTIONS="8"

# Search on youtube, show 8 or more results and let the user choose one, then return url in $TMPVALUE
function ytsl () {
[[ -z "$@" ]] && return
RESULTS=$(mktemp)
trap 'trap - ERR EXIT RETURN SIGINT && OPTIONS="8" && rm -f $RESULTS' ERR EXIT RETURN SIGINT
#Oneliner: Get the data from youtube, dump into $Results for later, remove every 3rd line and therefore the IDs, put () around every second line (durations), join every second line with the previous one, add line numbers. -u to do this while the stream being is generated.
yt-dlp ytsearch$OPTIONS:"$*" --print title --print duration_string --print id --no-warnings | tee $RESULTS | sed -u '3~3d' |sed -u '2~2{s/\(.*\)/(\1)/}' | sed -u '$!N;s/\n/ /'  | nl -w1 -s' '
read OPTION
#About double the amount of options if nothing is selected but something searched, raise it to that number if the selection is outside the range, yield the option's ID if it isn't and stop, exit with a 0 or most letters. Recursively calls itself to provide more options. The trap resets the amount of options to 8 again afterwards.
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
    TMPVALUE=$(sed -n "$(($OPTION*3))p" < $RESULTS)
else
    TMPVALUE=""
fi
}

#Set/echo the tmp variable
function tmp () {
[[ -z "$@" ]] && echo "$TMPVALUE" && return
TMPVALUE="$@"
}

#Abstract function: Uses yt-dlp command given in the first argument to download into temp and opens it using the program given in the second argument.
#Make sure $TMPDIR is set to the right absolute path when problems opening the file occur.
function tempdl () {
[[ -z "$3" ]] && echo "No url selected" && return
FILE=$(mktemp)
#Not too proud of this one, but my music player throws an error on startup which deletes the file before it can use it. So now mp3 files don't get deleted from temp at all anymore. Windows should clean that up though.
trap 'trap - EXIT RETURN SIGINT && rm -f $(echo $FILE.* | grep -v mp3)' EXIT RETURN SIGINT
eval $1 "${*:3}" -o "\"$FILE.%(ext)s\"" -q --no-warnings --progress 
eval $2 \"$(optToWin $FILE.*)\"
}

#Abstract function: Combine tempdl and yts
function tempyt () {
yts "${*:3}"
[[ -z $TMPVALUE ]] || tempdl $1 $2 $TMPVALUE
}

#Abstract function: Combine tempdl and ytsl
function tempytl () {
ytsl "${*:3}"
[[ -z $TMPVALUE ]] || tempdl $1 $2 $TMPVALUE
}

#Use dl to download into temp and view
alias opendl='tempdl dlHD vlc -f "bv*+ba/b"'
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
FPS=$(ffprobe -v 0 -of csv=p=0 -select_streams v:0 -show_entries stream=r_frame_rate "$@")
mplayer -really-quiet -vo caca -framedrop -fps $FPS "$@"
}
#If autodetection doesn't work
alias catvidfps='mplayer -really-quiet -vo caca -framedrop -fps'

#Use dl to download into temp and view
alias catdl='tempdl dlSD catvid -f "bv*+ba/b" '
#Do the same and search it on youtube
alias catyt='tempyt dlSD catvid '
#Do the same and let the user choose between the first 8 search results
alias catytl='tempytl dlSD catvid '


#
#OS compatibility functions
#

#Convert Unix path to Windows path
function toWin () {
echo "$@" | sed -E 's_^/(\w)(/|$|:/?)|^(\w):/?_\1\3:\\\\_; s_/_\\\\_g'
}
#Convert Windows Path to Unix path
function toUn () {
echo "$@" | sed -E "s_^/(\w)(/|$|:/?)|^(\w):/?_/\1\3/_; s_\\\\_/_g"
}
#Convert Unix path to Windows path if the OS is Windows
function optToWin () {
[[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]] && toWin "$@" || echo "$@"
}
