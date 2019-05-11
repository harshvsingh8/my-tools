ADB=$ANDROID_HOME/platform-tools/adb
HC=$ANDROID_HOME/platform-tools/hprof-conv 
$ADB shell rm -f /data/local/tmp/kaizala.hprof
echo "Requesting heap dump for Kaizala process"
$ADB shell am dumpheap com.microsoft.mobile.polymer.dev1 /data/local/tmp/kaizala.hprof
echo "Waiting for heap collection"
sleep 5
$ADB pull /data/local/tmp/kaizala.hprof  ~/.tmp.hprof
echo "Convering heap dump format for MAT profiler"
$HC ~/.tmp.hprof ${2:-'./kaizala.hprof'}
rm -f ~/.tmp.hprof 
echo "The heap profile is pulled at" ${2:-'./kaizala.hprof'}
