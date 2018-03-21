#!/bin/sh

# Switch JDK versions for terminal (c) 2016, Paul Hammant
function switchjdk {

    quiet=0
    zulu=0

    # A string with command options
    options=$@

    # An array with all the arguments
    arguments=($options)

    # Loop index
    index=0

    for argument in $options
    do
        case $argument in
            -q) quiet=1 ;;
            --quiet) quiet=1 ;;
            zulu) zulu=1 ;;
            (*) ver="$(echo $argument | sed 's/^1\.//')" ;;
         esac
    done

    if [ "$ver" -eq "$ver" ] 2>/dev/null; then
        err=""
        if [ $ver -lt 5 ] || [ $ver -gt 11 ]
        then
            err="JDK version should be between 5 and 11 (or 1.5 and 1.11)"
        fi
    else
        err="JDK version should be a number, was: $ver"
    fi

    if [ ! -z "$err" ]
    then
        echo 'Usage: switchjdk [--quiet|-q] [zulu] 4|5|6|7|8|9|10|11'
        echo "$err"
        return 1
    fi

    if [ $zulu -eq "1" ]; then
        pfx="zulu"
    else
        pfx="jdk"
    fi

    jdk=""

    if [ "$ver" -gt 8 ] || [ $zulu -eq "1" ] ; then
        jdk="$(find /Library/Java/JavaVirtualMachines -name "${pfx}-${ver}*" | sort -r | head -n 1)/Contents/"
        if [ "$jdk" = "/Contents/" ] ; then
            echo "Requested JDK not found in expected location. Perhaps it is not installed."
            return 1
        fi
    else
        if [ "$ver" -gt 6 ] ; then
            choices="$(find /Library/Java/JavaVirtualMachines -name "jdk1.${ver}*")"
            threeDigitMinorVersion=$(echo "$choices" | grep -E "_[0-9]{3}\.jdk" | wc -l | sed 's/ //g')
            if [ "$threeDigitMinorVersion" -gt 0 ] ; then
              # drop _01.jdk through _99.jdk
              choices=$(echo "$choices" | grep -E "_[0-9]{3}\.jdk")
            fi
            jdk="$(echo "$choices" | sort -r | head -n 1)/Contents/"
            if [ "$jdk" = "/Contents/" ] ; then
                echo "Requested JDK not found in expected location. Perhaps it is not installed."
                return 1
            fi
        else
            jdk="$(find /System/Library/Frameworks/JavaVM.framework/Versions -name "1.${ver}*" | sort -r | head -n 1)/"
            if [ "$jdk" = "/" ] ; then
                echo "Requested JDK not found in expected location. Perhaps it is not installed."
                return 1
            fi
            possiblyLinkedinToDiffJvm="$(ls -al $jdk | sed 's/^.*-> //' | perl -ne 'print $1 if /.*\/1\.([0-9]*).*/')"
            if [ "$possiblyLinkedinToDiffJvm" -ne "$ver" ] ; then
                echo "Requested JDK is not really installed. It is symlinked to JDK 1.$possiblyLinkedinToDiffJvm"
                return 1
            fi
        fi
    fi
    # sed chokes on newlines in the \n style, so give it a real newline.
    NL='
'

    # for development purposes:
    # echo "jdk: ${jdk}"

    # Set JAVA_HOME env var
    eval "export JAVA_HOME=${jdk}Home"

    # Maven has a place where its JDK can be set.
    touch ~/.mavenrc
    mavenrc=$(cat ~/.mavenrc | sed '/Java.*\/Home/d')
    echo "export JAVA_HOME=${jdk}Home$NL$mavenrc" > ~/.mavenrc

    # Set PATH env var
    path=$(echo "$PATH" | sed "s/:/\\$NL/g" | sed '/Java.*\/Home\/bin/d' | tr '\n' ':' | sed s'/.$//')

    eval "export PATH=${jdk}Home/bin:$path"

    # Check Java version. 5-8 and zulu varients, first
    javaVersion="$(java -version 2>&1 | grep -E '^java|openjdk version*' | sed 's/\"1\.//' | sed 's/java//' | sed 's/openjdk//' | sed 's/version//' | sed 's/\"//g' | xargs | cut -d' ' -f1 | cut -d'.' -f1)"

    if [ "$javaVersion" != "$ver" ] ; then
        echo "Requested JDK is not really installed. Was seemingly OK, up until getting 'java -version' to report the version installed."
        return 1
    fi

    # Check Javac version
    javacVersion="$(javac -version 2>&1 | grep '^javac *' | sed 's/ 1\./ /' | cut -d' ' -f2 | cut -d'.' -f1)"
    if [ "$javacVersion" != "$ver" ] ; then
        echo "Requested JDK is not really installed. Was seemingly OK, up until getting 'javac -version' to report the version installed."
        return 1
    fi

    # satisfy end user that something was done
    if [ $quiet -eq "0" ]
    then
        echo $(echo "$pfx" | tr '[z]' '[Z]') "1.$ver: JAVA_HOME and PATH changed for this terminal (and subprocesses)."
    fi

    return 0
}

# for development purposes:
# switchjdk $1
