package main
import (
    "encoding/json"
    "fmt"
    "io/ioutil"
    "os"
)

//#include <stdlib.h>
//#include <string.h>
//#include <stdio.h>
import "C"

type TestJson struct {
	Name	string      `json:"name"` 
	Age	int         `json:"age"`   
	Birth	string      `json:"birth"`   
	Lucky_numbers []int `json:"lucky_numbers"`
}
var TestJson_Lucky_numbers []int
var TestJson_body []TestJson

type RandomData struct {
	ID int `json:"id"`
	FirstName string `json:"first_name"`
	LastName string `json:"last_name"`
	Email string `json:"email"`
	Gender string `json:"gender"`
}

var c []RandomData

//export reset_TestJson_Lucky_numbers
func reset_TestJson_Lucky_numbers(){
   TestJson_Lucky_numbers = nil
}

//export insert_TestJson_Lucky_numbers
func insert_TestJson_Lucky_numbers(value int){
   TestJson_Lucky_numbers = append(TestJson_Lucky_numbers,value)
   fmt.Println(TestJson_Lucky_numbers)
}

//export AppendTestJson
func AppendTestJson(name *C.char,age C.int, birth *C.char){
   t := int(age)
   tmp := TestJson{C.GoStringN(name, 100),t,C.GoStringN(birth, 20),TestJson_Lucky_numbers}
   TestJson_body = append(TestJson_body,tmp)
   fmt.Println(TestJson_body)

}

//export PrintStructAsJson
func PrintStructAsJson(){
   tmp := &TestJson_body
    tmp2, _ := json.Marshal(tmp)
    fmt.Println(string(tmp2))

}

//export Set_TestJson_Lucky_numbers_index
func Set_TestJson_Lucky_numbers_index(index int){
     TestJson_Lucky_numbers = TestJson_body[index-1].Lucky_numbers
}

//export Get_TestJson_Lucky_numbers
func Get_TestJson_Lucky_numbers(index int) C.int{
     return C.int(TestJson_Lucky_numbers[index-1])
}

//export GetTestJson
func GetTestJson(index int,name *C.char, age *C.int, birth *C.char){
     tmp := TestJson_body[index-1]
     *age = C.int(tmp.Age)
     C.strcpy(name,C.CString(tmp.Name))
     C.strcpy(birth,C.CString(tmp.Birth))
     fmt.Println(tmp)
}

//export LoadJsonData
func LoadJsonData() {
    raw, err := ioutil.ReadFile("./random.json")
    if err != nil {
        fmt.Println(err.Error())
        os.Exit(1)
    }


    json.Unmarshal(raw, &c)
    fmt.Println(toJson(c)) 
}

func (p RandomData) toString() string {
    return toJson(p)
}

func toJson(p interface{}) string {
    bytes, err := json.Marshal(p)
    if err != nil {
        fmt.Println(err.Error())
        os.Exit(1)
    }

    return string(bytes)
}


//export GetRandomFromStruct
func GetRandomFromStruct(index int,id *C.int, first_name *C.char, last_name *C.char, email *C.char, gender *C.char){
     tmp := c[index-1]
     *id = C.int(tmp.ID)
     C.strcpy(first_name,C.CString(tmp.FirstName))
     C.strcpy(last_name,C.CString(tmp.LastName))
     C.strcpy(email,C.CString(tmp.Email))
     C.strcpy(gender,C.CString(tmp.Gender))
     fmt.Println(tmp)
}

func main() {}
