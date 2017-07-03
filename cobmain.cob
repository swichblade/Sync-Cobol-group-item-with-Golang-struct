       IDENTIFICATION DIVISION.
       PROGRAM-ID. cobmain.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 TESTJSON.
          03 PERSON occurs 3 times.
             05 NAME PIC X(100).
             05 AGE  PIC 9(3).
             05 BIRTH  PIC X(20).
             05 LUCKY-NUMBERS PIC 9(4) OCCURS 5 TIMES.

       01 RANDOMDATA.
           03 RANDOMGROUP OCCURS 1000.
             05 IDENT PIC 9(04) COMP-5.
             05 FIRSTNAME  PIC X(60).
             05 LASTNAME  PIC X(60).
             05 EMAIL  PIC X(100).
             05 GENDER  PIC X(20).

       01 I PIC 9(04) COMP-5.

       PROCEDURE DIVISION.
       
       display "Filling group array with values in Cobol"
       display "========================================" 
       initialize PERSON(1) 
       move "Marcus Sundberg" to name(1).
       move 29 to age(1).
       move "25th mars" to birth(1).
       move 1 to lucky-numbers(1,1).
       move 2 to lucky-numbers(1,2).
       move 3 to lucky-numbers(1,3).
       move 4 to lucky-numbers(1,4).
       move 5 to lucky-numbers(1,5).


       
       initialize PERSON(2) 
       move "Barry Cuda" to name(2).
       move 12 to age(2).
       move "28th mars" to birth(2).
       move 1 to lucky-numbers(2,1).
       move 2 to lucky-numbers(2,2).
       move 3 to lucky-numbers(2,3).
       move 4 to lucky-numbers(2,4).
       move 5 to lucky-numbers(2,5).


       

       initialize PERSON(3) 
       move "Sam o. Raj" to name(3).
       move 23 to age(3).
       move "24th November" to birth(3).
       move 1 to lucky-numbers(3,1).
       move 2 to lucky-numbers(3,2).
       move 3 to lucky-numbers(3,3).
       move 4 to lucky-numbers(3,4).
       move 5 to lucky-numbers(3,5).


**********************************
**********DEMO 1******************

       display "Sync with Golang"
       display "================"
       perform sendToGolangStruct.


       display "Clear Cobol group array"
       display "=======================" 
       initialize person(1).
       initialize person(2).
       initialize person(3).


**********************************
**********DEMO 2******************

       display "Get values from Golang."
       display "======================="
       perform getGolangStructValues.

       display "Print struct as json"
       display "===================="


       call "PrintStructAsJson" 
       end-call.

       display "Print values in Cobol"
       display "====================="
       display person(1).
       display person(2).
       display person(3).

**********************************
**********DEMO 3******************
       call "LoadJsonData"
       end-call.
       
       MOVE ZERO TO I
       PERFORM UNTIL I = 1000
          INITIALIZE RANDOMGROUP(I)
          ADD 1 TO I
          DISPLAY I
          CALL "GetRandomFromStruct"	USING BY VALUE I
                                       	BY REFERENCE IDENT(I)
             				BY REFERENCE FIRSTNAME(I)
             				BY REFERENCE LASTNAME(I)
             				BY REFERENCE EMAIL(I)
             				BY REFERENCE GENDER(I)  
          END-CALL
          DISPLAY IDENT(I)
          DISPLAY FIRSTNAME(I)
          DISPLAY LASTNAME(I)
          DISPLAY EMAIL(I)
          DISPLAY GENDER(I) 
       END-PERFORM.
 
       stop run.

******************Program End*************************''


       getGolangStructValues section.

       MOVE ZERO TO I
       PERFORM UNTIL I = 3 
          ADD 1 TO I 
          call "reset_TestJson_Lucky_numbers"
          end-call

          call "Set_TestJson_Lucky_numbers_index"
                        using by value I           
          end-call

          call "Get_TestJson_Lucky_numbers" 
                       using by value 1
          returning lucky-numbers(I,1)
          end-call
          call "Get_TestJson_Lucky_numbers" 
                       using by value 2
          returning lucky-numbers(I,2) 
          end-call
          call "Get_TestJson_Lucky_numbers" 
                       using by value 3 
          returning lucky-numbers(I,3)
          end-call
          call "Get_TestJson_Lucky_numbers" 
                       using by value 4 
          returning lucky-numbers(I,4)
          end-call
          call "Get_TestJson_Lucky_numbers" 
                       using by value 5 
          returning lucky-numbers(I,5)
          end-call


          call "GetTestJson" 
                       using by value I
                             by reference name(I)
                             by reference age(I)
                             by reference birth(I) 
          end-call

       END-PERFORM

      
       exit section.


       sendToGolangStruct section.


   
       MOVE ZERO TO I
       PERFORM UNTIL I = 3 
          ADD 1 TO I    
          INITIALIZE PERSON(I)
          call "reset_TestJson_Lucky_numbers"
          end-call

          call "insert_TestJson_Lucky_numbers" 
                       using by value lucky-numbers(I,1) 
          end-call
          call "insert_TestJson_Lucky_numbers" 
                       using by value lucky-numbers(I,2) 
          end-call
          call "insert_TestJson_Lucky_numbers" 
                       using by value lucky-numbers(I,3) 
          end-call
          call "insert_TestJson_Lucky_numbers" 
                       using by value lucky-numbers(I,4) 
          end-call
          call "insert_TestJson_Lucky_numbers" 
                       using by value lucky-numbers(I,5) 
          end-call

          call "AppendTestJson" 
                       using by reference name(I)
                             by value age(I)
                             by reference birth(I) 
          end-call
       
       END-PERFORM 



       exit section.

