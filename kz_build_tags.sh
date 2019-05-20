rm -f $SRC_ROOT/../kaizala.tags
alias ctags="`brew --prefix`/bin/ctags"
ctags --recurse=yes --exclude=.git --exclude=log --exclude=boost --exclude=node_modules --exclude=kaenv -e --links=no -o $SRC_ROOT/../kaizala.tags $SRC_ROOT/Shared/kaizalaS/sharedLogic $SRC_ROOT/Shared/kaizalaS/sharednative/internal $SRC_ROOT/Shared/kaizalaS/app/android/jni $SRC_ROOT/Platform $SRC_ROOT/Android/React/src/com $SRC_ROOT/Android/app/src/com $SRC_ROOT/Android/shared/Common/src $SRC_ROOT/Automation
