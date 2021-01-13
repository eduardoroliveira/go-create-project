#!/bin/bash

# Creates a basic GO project based on structure suggested at https://github.com/golang-standards/project-layout

small(){
    echo "" > LICENSE.md
    echo "" > README.md
    echo "" > .gitignore
    
    mkdir build
    mkdir -p pkg/dumb
}

createMakeFile(){
    echo ".DEFAULT_GOAL := default" > Makefile
    echo "" >> Makefile
    echo "fmt:" >> Makefile
    echo "	@cd pkg && go fmt github.com/$2/$1/..." >> Makefile
    echo "" >> Makefile
    echo "test:" >> Makefile
    echo "	@cd pkg && go test github.com/$2/$1/..." >> Makefile
    echo "" >> Makefile
    echo "build:" >> Makefile
    echo "	@cd pkg && go build github.com/$2/$1/..." >> Makefile
    echo "" >> Makefile
    echo "default: fmt test build" >> Makefile
    echo "	@echo \"Formatted and built\"" >> Makefile
}

createExample(){
    echo "package dumb" >  pkg/dumb/dumb.go
    echo "" >>  pkg/dumb/dumb.go
    echo "// Dumb just a dumb example" >>  pkg/dumb/dumb.go
    echo "func Dumb() string {" >>  pkg/dumb/dumb.go
    echo "    return \"Hello work!\"" >>  pkg/dumb/dumb.go
    echo "}" >>  pkg/dumb/dumb.go
}

createTestExample(){
    echo "package dumb" >  pkg/dumb/dumb_test.go
    echo "" >>  pkg/dumb/dumb_test.go
    echo "import (" >>  pkg/dumb/dumb_test.go
    echo "    \"testing\"" >>  pkg/dumb/dumb_test.go
    echo ")" >>  pkg/dumb/dumb_test.go
    echo "" >>  pkg/dumb/dumb_test.go
    echo "func TestDumbFunc(t *testing.T) {" >>  pkg/dumb/dumb_test.go
    echo "    df := Dumb()" >>  pkg/dumb/dumb_test.go
    echo "" >>  pkg/dumb/dumb_test.go
    echo "    if df == \"\" {" >>  pkg/dumb/dumb_test.go
    echo "        t.Error(\"The result should not be empty\")" >>  pkg/dumb/dumb_test.go
    echo "    }" >>  pkg/dumb/dumb_test.go
    echo "" >>  pkg/dumb/dumb_test.go
    echo "    if df != \"Hello work!\" {" >>  pkg/dumb/dumb_test.go
    echo "        t.Errorf(\"Expected [Hello work!] and received [%v]\", df)" >>  pkg/dumb/dumb_test.go
    echo "    }" >>  pkg/dumb/dumb_test.go
    echo "}" >>  pkg/dumb/dumb_test.go
}

full(){
    echo "" > LICENSE.md
    echo "" > README.md
    echo "" > .gitignore

    mkdir assets
    mkdir build
    mkdir cmd
    mkdir configs
    mkdir deployments
    mkdir docs
    mkdir examples
    mkdir githooks
    mkdir init
    mkdir internal
    mkdir -p pkg/dumb
    mkdir scripts
    mkdir test
    mkdir third_party
    mkdir tools
    mkdir vendor
    mkdir web
    mkdir website
}

if [[ "$2" == "" ]]; then
   echo "Syntax: go-create-project.sh <project-name> <github-user> [-f]"
   echo "- <project-name>: the name you want give to your project"
   echo "- <github-user>: your user in github. Will be used to \`go mod init\`."
   echo "- [-f]: Optional flag meaning full structure. Will include all folders suggested at https://github.com/golang-standards/project-layout, otherwise a minimum structure will be created containing only build, pkg and test folders. "
   echo ""
   echo "    example 1 : go-create-project.sh my-go-project"
   echo "    example 2 : go-create-project.sh my-go-project -f"
   exit 1
fi

if [[ -e "$1" ]]; then
    echo "The project $1 already exists"
    exit 1
fi

mkdir $1
cd $1

if [[ "$3" != "" && "$3" == "-f" ]]; then
    full
else
    small $
fi

createExample
createTestExample
createMakeFile $1 $2
cd pkg && go mod init github.com/$2/$1
