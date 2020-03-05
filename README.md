# Maven Archetypes for JavaFX

Maven archetypes for creating different types of JavaFX application.

[![Maven Central](https://img.shields.io/maven-central/v/com.raelity.jfx/javafx-maven-archetypes-netbeans.svg?color=%234DC71F)](https://search.maven.org/#search|ga|1|com.raelity.jfx.javafx-maven-archetypes-netbeans)
[![BSD-3 license](https://img.shields.io/badge/license-BSD--3-%230778B9.svg)](https://opensource.org/licenses/BSD-3-Clause)

The project is a multi-module Maven project. Each module contains an archetype for creating a JavaFX application.

All projects created via the archetype(s) make use of the [JavaFX Maven plugin](https://github.com/openjfx/javafx-maven-plugin)
for compiling and running the JavaFX application. This fork modifies the archetypes by adding a debug execution and an nbactions.xml to hook up the NetBeans run/debug actions.

### Prerequisites

* JDK 11
* Maven 3

### Install archetype locally

To install all the archetypes in your local repository execute the following commands:

```
git clone https://github.com/errael/javafx-maven-archetypes-netbeans.git
cd javafx-maven-archetypes
mvn clean install
```

This will install all the javafx archetypes in your local repository.

If you wish to install just one of the archetypes, you can add the name of the project by using `-pl`:

```
mvn clean install -pl javafx-archetype-simple-netbeans
```

For more information on how to create a project from a local repository, please refer to
individual module's README.
