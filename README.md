# Sync-Cobol-group-item-with-Golang-struct
Functions to show easy syncing between Cobol group items and Golang structs

$ export COB_PRE_LOAD=functions
$ go build -buildmode=c-shared -o functions.so functions.go
$ cobc -x cobmain.cob
$ ./cobmain 
