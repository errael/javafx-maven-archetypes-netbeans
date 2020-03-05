#!/bin/bash

set -e

if [[ -z "$JDK8"  || ! -f "$JDK8/bin/java" && ! -f "$JDK8/bin/java.exe" ]]; then
  echo Specify JDK8 property to point to JDK 8 installation: $JDK8
  exit 1
fi

if [[ -z "$JDK11"  || ! -f "$JDK11/bin/java" && ! -f "$JDK11/bin/java.exe" ]]; then
  echo Specify JDK11 property to point to JDK 11 installation: $JDK11
  exit 2
fi

ARCH_VERSION=$(mvn help:evaluate -Dexpression=project.version -q -DforceStdout)

: ${MAVEN_REPO:=$HOME/.m2/repository}
echo "Removing local catalog for javafx archetypes version: $ARCH_VERSION"
rm -rf $MAVEN_REPO/com/raelity/jfx/*archetype*/$ARCH_VERSION

echo "Installing local catalog for javafx archetypes version: $ARCH_VERSION"
JAVA_HOME=$JDK8 mvn -q install
echo "Installation of local catalog successful."
rm -rf target
mkdir -p target
cd target

function setupExit() {
    sed -i -e 's/stage.show();/stage.show();System.exit(0);/g' $1
}

function generate() {
    if [ -z "$1" ] || [ -z "$2" ]; then
       echo "Expecting 2 arguments"
       exit 3
    fi
    mkdir -p $2 && cd $2
    echo Generating $1 with javafx-version=$2
    mvn -q archetype:generate \
        -DarchetypeCatalog=local \
        -DinteractiveMode=false \
        -DarchetypeGroupId=com.raelity.jfx \
        -DarchetypeArtifactId=$1 \
        -DarchetypeVersion=$ARCH_VERSION \
        -DgroupId=com.raelity.jfx.demo \
        -DartifactId=test-$1 \
        -Dversion=1.0-SNAPSHOT \
        -Djavafx-version=$2
    setupExit test-$1/src/main/java/com/raelity/jfx/demo/App.java

    if [[ ! -f test-$1/nbactions.xml ]]; then
        echo File $2/test-$1/nbactions.xml does not exist
        exit 3
    fi

    if [ $2 != 11 ]; then
      echo "  Launching on JDK8"
      JAVA_HOME=$JDK8 mvn -q -f test-$1/ clean package javafx:run
    else
      echo "  Launching on JDK8 and expecting failure"
      (JAVA_HOME=$JDK8 mvn -q -f test-$1 clean package javafx:run && exit 3) || echo Previous failure is expected
    fi

    echo "  Launching on JDK11"
    JAVA_HOME=$JDK11 mvn -q -f test-$1/ clean package javafx:run
    cd ..
}

generate javafx-archetype-simple-netbeans 1.8
generate javafx-archetype-simple-netbeans 8
generate javafx-archetype-simple-netbeans 11
generate javafx-archetype-fxml-netbeans 1.8
generate javafx-archetype-fxml-netbeans 8
generate javafx-archetype-fxml-netbeans 11
