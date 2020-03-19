# FXML based JavaFX Maven Archetype

The project is a Maven archetype for creating a fxml based JavaFX application.

### Prerequisites

* JDK 11
* Maven 3


### Create a project from a local repository

Once you have installed the archetype locally, you can use it to create a new project using:

```
mvn archetype:generate \
        -DarchetypeGroupId=com.raelity.jfx \
        -DarchetypeArtifactId=javafx-archetype-fxml-netbeans \
        -DarchetypeVersion=0.0.2-SNAPSHOT \
        -DgroupId=groupid \
        -DartifactId=artifactId \
        -Dversion=version
```

The following properties can be customized while creating the project:

| Property                    | Default Value |
| --------------------------- | ------------- |
| javafx-version              | 13            |
| javafx-maven-plugin-version | 0.0.4         |

For example:

```
mvn archetype:generate \
        -DarchetypeGroupId=com.raelity.jfx \
        -DarchetypeArtifactId=javafx-archetype-fxml-netbeans \
        -DarchetypeVersion=0.0.2-SNAPSHOT \
        -DgroupId=groupid \
        -DartifactId=artifactId \
        -Dversion=version
        -Djavafx-version=12-ea+14
```
