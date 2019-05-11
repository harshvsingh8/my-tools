ADB=$ANDROID_HOME/platform-tools/adb
HC=$ANDROID_HOME/platform-tools/hprof-conv 

waitForFile() {
    # wait for file to stabalize at a size above 0
    local lastSize=0
    local matchCount=0
    while [ ${matchCount} -lt 3 ] ;
    do
        if [[ ${lastSize} -gt 0 && $(fileSize) = ${lastSize} ]] ;
            then
            let "matchCount+=1"
            echo "match ${matchCount}"
        else
            matchCount=0
            lastSize=$(fileSize)
            echo "Dumping file...current size = ${lastSize}"
        fi
        sleep 0.5
    done
    echo "Heap Dump Complete, file size = ${lastSize}"
}

fileSize() {
    local size=$(echo $(adb shell "ls -s /data/local/tmp/kaizala.hprof") | cut -f1 -d' ')
    echo $size
}


$ADB shell rm -f /data/local/tmp/kaizala.hprof
echo "Requesting heap dump for Kaizala process"
$ADB shell am dumpheap com.microsoft.mobile.polymer.dev1 /data/local/tmp/kaizala.hprof
echo "Waiting for heap collection"
waitForFile
$ADB pull /data/local/tmp/kaizala.hprof  ~/.tmp.hprof
echo "Convering heap dump format for MAT profiler"
$HC ~/.tmp.hprof ${2:-'./kaizala.hprof'}
rm -f ~/.tmp.hprof 
echo "The heap profile is pulled at" ${2:-'./kaizala.hprof'}
