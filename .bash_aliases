# hack to make aliases work after commands
alias sudo='sudo '
alias yt-dlp='yt-dlp '

#
# yt-dlp
#

# yt-dlp aliases
alias dl='yt-dlp namefix --console-title --embed-metadata --parse-metadata "webpage_url:(?s)(?P<meta_composer>.+)" --parse-metadata "webpage_url:(?s)(?P<meta_subtitle>.+)" '
alias dlmp4='dl -f "bv*[ext=mp4]+ba[ext*=4]/b[ext=mp4]/bv*+ba/b" '
alias dlmp3='dl -f "ba[ext=mp3]/ba" -x --audio-format mp3 '
alias dlmp3mus='dlmp3 --embed-thumbnail --parse-metadata "%(playlist_autonumber|)s:(?P<meta_track>.+)" --parse-metadata "%(artist,creator,uploader)s:(?P<meta_album_artist>.+)" '
alias dlaudio='dl -f ba '
alias dlaudiomus='dlaudio --embed-thumbnail --parse-metadata "%(playlist_autonumber|)s:(?P<meta_track>.+)" --parse-metadata "%(artist,creator,uploader)s:(?P<meta_album_artist>.+)" '
alias dlf='dlmp4 withsubs --embed-thumbnail --embed-chapters --parse-metadata "description:(?P<meta_comment>.+)" '
alias dla='dlaa --extractor-args "youtube:max_comments=1000,all,all,100;comment_sort=top" '
alias dlaa='dlf -R infinite --download-archive videos.txt --write-comments -o "infojson:Jsons/%(title)s" -o "pl_infojson:Jsons/%(title)s"'
alias dlsmall='dl -f b -S +size,+br,+res,+fps '
alias dl3gp='dl -f "bv*[ext=3gp]" ' 

function dlsize () {
dl -f "bv*[height<=$1]+ba/ b[height<=$1]" ${*:2} 
}
function dlmp4size () {
dl -f "bv*[ext=mp4][height<=$1]+ba[ext*=4]/ b[ext=mp4][height<=$1]/ bv[height<=$1]*+ba/ b[height<=$1]" ${*:2} 
}
function dlyt () {
dl ytsearch:\""$*"\" 
}
function dlytmp4 () {
dlmp4 ytsearch:\""$*"\"
}
function dlytmp3 () {
dlmp3 ytsearch:\""$*"\"
}

# yt-dlp argument shortcuts
alias withcookies='--cookies-from-browser firefox '
alias withsubs='--write-subs --write-auto-subs --embed-subs --compat-options no-keep-subs '
alias withsubslangs='--write-subs --write-auto-subs --embed-subs --compat-options no-keep-subs --sub-langs '
alias withthumb='--embed-thumbnail '
alias withchapters='--embed-chapters '
alias withsponsor='--sponsorblock-mark all '
alias namefix='-o "%(title)s.%(ext)s" '

# also notice the config in /appdata/roaming/yt-dlp/config.txt

alias pingt='ping 8.8.8.8'

alias dlimg='gallery-dl '

alias dlpagea='wayback_machine_downloader '

alias dlpage='wget -m -k -E -p -e robots=off '

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
git diff -b "$@" | 'C:\Users\stefa\bin\diff-so-fancy\diff-so-fancy' 
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

function concat() {
FILE=$(mktemp ./TEMPFILE_XXXXXX.txt)
trap 'trap - ERR EXIT RETURN SIGINT && rm $FILE' ERR EXIT RETURN SIGINT
for i in "${@:1:$#-1}"
do
echo file \'"$i"\' >> "$FILE"
done
ffmpeg -f concat -safe 0 -i $FILE -c copy "${@: -1}" 
}

#
#File system stuff
#

alias u='cd ..'
alias uu='cd ../..'
alias uuu='cd ../../..'

alias ul='u && echo && ls'
alias uul='uu && echo && ls'
alias uuul='uuu && echo && ls'

function cl () {
cd "$*"
echo
ls
}

alias ls='ls -A '
alias l='echo && ls -A '
#Search for files
alias s='ls -A | grep -i '

#Open the explorer here
alias e='explorer .'
#Open a file
function o () {
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]
then
    explorer "$(toWin "$*")"
else
    xdg-open "$*"
fi
}
#Search for and open a file
function os () {
TMPVALUE="$(s "$*")"
if [[ -z "$TMPVALUE" ]]
then
    echo "No file found"
elif [[ $(echo "$TMPVALUE" | wc -l) == "1" ]]
then
    o "$TMPVALUE"
else
    echo "$TMPVALUE" | nl -w1 -s ' ' 
    read OPTION
    if (($OPTION > 0 && $OPTION <= $(echo "$TMPVALUE" | wc -l)))
    then
        o $(echo "$TMPVALUE" | sed -n "${OPTION}"p)
    else
        echo "Invalid number" 1>&2
    fi
fi
}
 
alias x='exit '

alias catt='echo && cat '

#For writing in nano, -$ enables wrapping, -w disables inserting these breaks into the file, -a wraps only at blanks instead of splitting words
alias write='nano -\$aw'

#List 10 biggest files
alias ducks='du -ksh * | sort -rh | head -n10'
alias ducksa='du -ksh * | sort -rh'

#Create copy of a website
alias dlwebsite='wget -m -k -E -p -e robots=off '

#Download a resource
alias dlfile='curl -OJ '

alias editalias='nano ~/.bash_aliases '
alias refresh='source ~/.bashrc'

#
#More youtube utils
#

# Search on youtube, print title and return url in $TMPVALUE
function yts () {
TMPVALUE=$(yt-dlp ytsearch1:"$*" --get-title --get-id --no-warnings)
echo "$TMPVALUE" | sed -n 1p
TMPVALUE=$(echo "$TMPVALUE" | sed -n 2p)
}

# Search on youtube, show 8 results and let the user choose one, then return url in $TMPVALUE
function ytsl () {
RESULTS=$(mktemp)
trap 'trap - ERR EXIT RETURN SIGINT && rm $RESULTS' ERR EXIT RETURN SIGINT
#Oneliner: Get the data from youtube, dump into $Results for later, remove every 3rd line and therefore the IDs, put () around every second line (durations), join every second line with the previous one, add line numbers. -u to do this while the stream being is generated.
yt-dlp ytsearch8:"$*" --print title --print duration_string --print id --no-warnings | tee $RESULTS | sed -u '3~3d' |sed -u '2~2{s/\(.*\)/(\1)/}' | sed -u '$!N;s/\n/ /'  | nl -w1 -s' '
read OPTION
if (( OPTION > 0 && OPTION < 9 ))
then
    TMPVALUE=$(sed -n "$(($OPTION*3))p" < $RESULTS)
else
    echo "Invalid number" 1>&2
    TMPVALUE=""
fi
}

#Get the content of the temp variable
alias tmp='echo $TMPVALUE'


#Abstract function: Use dl to download into temp and open using the program given in the first argument.
#Make sure $TMPDIR is set to the right absolute path when problems opening the file occur.
function tempdl () {
if [[ -z "$TMPVALUE" ]]
then
    echo "No url selected"
else
    FILE=$(mktemp)
    trap 'trap - ERR EXIT RETURN SIGINT && rm $FILE.*' ERR EXIT RETURN SIGINT
    dlsize 1080 -o "$FILE.%(ext)s" -q --progress "${*:2}"
    eval $1 \"$(optToWin $FILE.*)\"
fi
}

#Abstract function: Combine tempdl and yts
function tempyt () {
yts "${*:2}"
tempdl $1 $TMPVALUE
}

#Abstract function: Combine tempdl and ytsl
function tempytl () {
ytsl "${*:2}"
tempdl $1 $TMPVALUE
}


#Use dl to download into temp and view
alias opendl='tempdl vlc '
#Do the same and search it on youtube
alias openyt='tempyt vlc '
#Do the same and let the user choose between the first 8 search results
alias openytl='tempytl vlc '


#
##
##Experimental (only works on some systems):
##
#


#
#To view media in terminal
#

#Get fps and pass it to mplayer, framedrop cuz ist too slow
function catvid () {
FPS=$(ffprobe -v 0 -of csv=p=0 -select_streams v:0 -show_entries stream=r_frame_rate "$*")
mplayer -really-quiet -vo caca -framedrop -fps $FPS "$*"
}
#If autodetection doesn't work
alias catvidfps='mplayer -really-quiet -vo caca -framedrop -fps'

#Use dl to download into temp and view
alias catdl='tempdl catvid '
#Do the same and search it on youtube
alias catyt='tempyt catvid '
#Do the same and let the user choose between the first 8 search results
alias catytl='tempytl catvid '


#
#OS compatibility functions
#

#Convert Unix path to Windows path
function toWin () {
echo "$*" | sed -e 's/^\/\([a-zA-Z]\)\//\1:\\/' -e 's/\//\\/g'
}
#Convert Windows Path to Unix path
function toUn () {
echo "$*" | sed -e 's/^\([a-zA-Z]\):\\/\/\1\//' -e 's/\\/\//g'
}
#Convert Unix path to Windows path if the OS is Windows
function optToWin () {
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]
then
    toWin "$*"
else
    echo "$*"
fi
}
