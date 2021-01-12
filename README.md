# go-create-project

Creates a basic GO project based on structure suggested at https://github.com/golang-standards/project-layout, providing a simple Makefile, a GO program and test samples. Very basic sample!

```bash
Syntax: go-create-project.sh <project-name> <github-user> [-f]
- <project-name>: the name you want give to your project
- <github-user>: your user in github. Will be used to `go mod init`.
- [-f]: Optional flag meaning full structure. Will include all folders suggested at [project-layout](https://github.com/golang-standards/project-layout), otherwise a minimum structure will be created containing only build, pkg and test folders.

    example 1 : go-create-project.sh my-go-project
    example 2 : go-create-project.sh my-go-project -f
```
