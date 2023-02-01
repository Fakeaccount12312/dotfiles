# hack to make aliases work after commands
alias sudo='sudo '
alias yt-dlp='yt-dlp '


# yt-dlp
# yt-dlp aliases
alias dl='yt-dlp namefix --console-title --embed-metadata --parse-metadata "webpage_url:(?s)(?P<meta_composer>.+)" --parse-metadata "webpage_url:(?s)(?P<meta_subtitle>.+)" '
alias dlmp4='dl -f "bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4] / bv*+ba/b" '
alias dlmp3='dl -f ba[ext=mp3]/ba -x --audio-format mp3 '
alias dlmp3mus='dlmp3 --embed-thumbnail --parse-metadata "%(playlist_autonumber|)s:(?P<meta_track>.+)" --parse-metadata "%(artist,creator,uploader)s:(?P<meta_album_artist>.+)" '
alias dlaudio='dl -f ba '
alias dlaudiomus='dl -f ba[ext=m4a]/ba[ext=mp3]/ba --embed-thumbnail --parse-metadata "%(playlist_autonumber|)s:(?P<meta_track>.+)" --parse-metadata "%(artist,creator,uploader)s:(?P<meta_album_artist>.+)" '
alias dla='dlmp4 withsubs -R infinite --download-archive videos.txt --write-comments --extractor-args "youtube:max_comments=1000,all,all,100;comment_sort=top"  --embed-thumbnail --embed-chapters --parse-metadata "description:(?P<meta_comment>.+)" '
alias dlaa='dlmp4 withsubs -R infinite --download-archive videos.txt --write-comments --embed-thumbnail --embed-chapters --parse-metadata "description:(?P<meta_comment>.+)" '
alias dlsmall='dl -f b -S +size,+br,+res,+fps ' 

function dlsize () {
dl -f "bv*[height<=$1]+ba/ b[height<=$1]" ${*:2} 
}
function dlmp4size () {
dl -f "bv*[ext=mp4][height<=$1]+ba[ext=m4a]/ b[ext=mp4][height<=$1]/ bv[height<=$1]*+ba/ b[height<=$1]" ${*:2} 
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
git diff -b "$@" | 'C:\Users\stefa\.scripts\diff-so-fancy\diff-so-fancy' 
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
function concat() {
FILE=$(mktemp ./TEMPFILE_XXXXXX.txt)
trap 'trap - ERR EXIT RETURN SIGINT && rm $FILE' ERR EXIT RETURN SIGINT
for i in "${@:1:$#-1}"
do
echo file \'"$i"\' >> "$FILE"
done
sleep 10
ffmpeg -f concat -safe 0 -i $FILE -c copy "${@: -1}" 
}

#File system stuff

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

alias e='explorer .'

alias catt='echo && cat '

#For writing in nano, -$ enables wrapping, -w disables inserting these breaks into the file, -a wraps only at blanks instead of splitting words,-m enables using the mouse, -E -T 4 converts tabs to 4 spaces
alias write='nano -\$awmE -T 4'

#List 10 biggest files
alias ducks='du -ksh * | sort -rn | head -n10'
alias ducksa='du -ksh * | sort -rn'

#Create copy of a website
alias dlwebsite='wget -m -k -E -p -e robots=off '

#Download a resource
alias dlfile='curl -OJ '

alias refresh='source ~/.bashrc'

#
#More youtube utils
#

# Search on youtube, print title and return url in $TMP
function yts () {
TMP=$(yt-dlp ytsearch1:"$*" --get-title --get-id --no-warnings)
echo "$TMP" | sed -n 1p
TMP=$(echo "$TMP" | sed -n 2p)
}

# Search on youtube, show 8 results and let the user choose one, then return url in $TMP
function ytsl () {
RESULTS=$(mktemp)
trap 'trap - ERR EXIT RETURN SIGINT && rm $RESULTS' ERR EXIT RETURN SIGINT
yt-dlp ytsearch8:"$*" --get-title --get-id --no-warnings | tee $RESULTS | sed -u '2~2d' | nl -w1 -s' '
read OPTION
TMP=$(sed -n "$(($OPTION*2))p" < $RESULTS)
}

#Get the content of the temp variable
alias tmp='$TMP'


#Abstract function: Use dl to download into temp and view using the program given in the first argument
function tempdl () {
FILE=$(mktemp)
trap 'trap - ERR EXIT RETURN SIGINT && rm $FILE.*' ERR EXIT RETURN SIGINT
dlsize 720 -o "$FILE.%(ext)s" -q --progress "${*:2}"
eval $1 "$FILE.*"
}

#Abstract function: Combine tempdl and yts
function tempyt () {
yts "${*:2}"
tempdl $1 $TMP
}

#Abstract function: Combine tempdl and ytsl
function tempytl () {
ytsl "${*:2}"
tempdl $1 $TMP
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
