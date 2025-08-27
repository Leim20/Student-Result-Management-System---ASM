.MODEL SMALL
.STACK 100h
.386         ; Add this line for 386 instructions support

.DATA
    ; Your data declarations remain the same
    password_filename   db 'PASSWD.TXT',0      
    temp_hash          db 32 DUP(0)           
    file_hash          db 32 DUP(0)           
    default_password   db 'admin123',0        
    hash_salt          db 'SECURE_SALT_2024',0

    passwd_file_header  db 'PWDFILE_V1.0',0   ; ????
    user_count         db 1                   ; ????
    admin_username     db 'admin',0,0,0,0,0,0,0,0,0,0  ; ????15????
    
; File and enhanced features (ADD THESE FIRST)
    filename            db 'STUDENTS.DAT',0
    file_handle         dw 0
    hashed_password     db 20 DUP(0)
    stored_hash         db 0A7h,0B2h,0C1h,0D4h,0E5h,0F6h,0A7h,0B8h,0
    
    color_attr          db 0Fh
    ascii_welcome       db 10,13,'    ? ? ? WELCOME TO STUDENT SYSTEM ? ? ?',10,13,'$'
    
    ; ASCII Art
    ascii_art_header    db 10,13,'     *** STUDENT MANAGEMENT SYSTEM ***',10,13,'$'
    ascii_art_line1     db '    ????????????????????????????????????????',10,13,'$'
    ascii_art_line2     db '    ?        WELCOME TO OUR SYSTEM        ?',10,13,'$'
    ascii_art_line3     db '    ????????????????????????????????????????',10,13,'$'

    ; Enhanced title with colors and ASCII
    enhanced_title      db 10,13
                        db '    ????????????????????????????????????????',10,13
                        db '    ?     STUDENT RESULT MANAGEMENT       ?',10,13
                        db '    ?             SYSTEM v2.0             ?',10,13
                        db '    ????????????????????????????????????????',10,13,'$'
        


    ; Messages and Prompts
    title_msg           db 10,13,'========================================',10,13
                        db '    STUDENT RESULT MANAGEMENT SYSTEM    ',10,13
                        db '========================================',10,13,'$'
    login_msg           db 10,13,'                LOGIN REQUIRED             ',10,13
                        db '--------------------------------------',10,13,'$'
    username_prompt     db 10,13,'Username: $'
    password_prompt     db 10,13,'Password: $'

    ; Input Buffers
    username_buffer     db 20 DUP(0)
    password_buffer     db 20 DUP(0)

    ; Credentials
    valid_username      db 'admin',0
    valid_password      db 'admin123',0

    ; Status Messages
    success_msg         db 10,13,10,13,'Login Successful!',10,13
                        db 'Welcome to Student Result Management System',10,13,'$'
    error_msg           db 10,13,'Error: Invalid username or password!',10,13
                        db 'Please try again.',10,13,'$'
    retry_msg           db 10,13,'Press any key to retry or ESC to exit...$'

    ; Main Menu (Updated)
    menu_msg            db 10,13,10,13,'========== MAIN MENU ==========',10,13
                    db '0. Setup/Change Subject Names',10,13
                    db '1. Add Student Result',10,13
                    db '2. View Student Results',10,13
                    db '3. Update Student Result',10,13
                    db '4. Delete Student Result',10,13
                    db '5. Exit System',10,13
                    db '6. Change Password',10,13
                    db '7. Export to Text File',10,13
                    db '8. Calculate Student Fees',10,13
                    db 'Select option (0-8): $'

    ; Login Control
    attempt_count       db 0
    max_attempts        db 3
    newline             db 10,13,'$'
    
    ; Feature Placeholders
    feature_msg3        db 10,13,'Feature: Update Student Result (Under Development)',10,13
                        db 'Press any key to continue...$'
    feature_msg4        db 10,13,'Feature: Delete Student Result (Under Development)',10,13
                        db 'Press any key to continue...$'

    ; ===== Student Data Structures (Updated) =====
    MAX_STUDENTS        EQU 10
    MAX_SUBJECTS        EQU 5
    SUBJECT_NAME_LEN    EQU 20  ; ??????????
    student_count       db 0
    
    ; Student Info
    student_ids         db MAX_STUDENTS * 10 DUP('$')
    student_names       db MAX_STUDENTS * 30 DUP('$')
    
    ; ?????????
    student_programs    db MAX_STUDENTS DUP(0)  ; 1=Foundation, 2=Diploma, 3=Degree, 4=Master
    student_levels      db MAX_STUDENTS DUP(0)  ; 1, 2, 3, 4
    student_years       db MAX_STUDENTS DUP(0)  ; ???? 24 ?? 2024?
    student_intakes     db MAX_STUDENTS DUP(0)  ; 1=Jan, 2=May, 3=Sep
    student_semesters   db MAX_STUDENTS DUP(0)  ; 1, 2, 3
    
    ; ??????
    program_menu_msg    db 10,13,10,13,'========== SELECT PROGRAM ==========',10,13
                        db '1. Foundation',10,13
                        db '2. Diploma',10,13
                        db '3. Degree',10,13
                        db '4. Master',10,13
                        db 'Select program (1-4): $'
    
    ; ????
    level_menu_msg      db 10,13,10,13,'========== SELECT LEVEL ==========',10,13
                        db '1. Level 1',10,13
                        db '2. Level 2',10,13
                        db '3. Level 3',10,13
                        db '4. Level 4',10,13
                        db 'Select level (1-4): $'
    
    ; ????
    year_prompt_msg     db 10,13,'Enter year (e.g., 24 for 2024): $'
    
    ; ??????
    intake_menu_msg     db 10,13,10,13,'========== SELECT INTAKE ==========',10,13
                        db '1. January',10,13
                        db '2. May',10,13
                        db '3. September',10,13
                        db 'Select intake (1-3): $'
    
    ; ????
    semester_menu_msg   db 10,13,10,13,'========== SELECT SEMESTER ==========',10,13
                        db '1. Semester 1',10,13
                        db '2. Semester 2',10,13
                        db '3. Semester 3',10,13
                        db 'Select semester (1-3): $'
    
    ; ?????????
    view_filter_msg     db 10,13,'========== FILTER RESULTS ==========',10,13
                        db 'Please select criteria to view results:',10,13,'$'
    
    ; ??????????
    program_names       db 'Foundation$'
                        db 'Diploma   $'
                        db 'Degree    $'
                        db 'Master    $'
    
    ; ??????
    intake_names        db 'January $'
                        db 'May     $'
                        db 'September$'
    
    ; ??????
    filter_program      db 0
    filter_level        db 0
    filter_year         db 0
    filter_intake       db 0
    filter_semester     db 0
    
    ; ?????????
    matched_students    db MAX_STUDENTS DUP(255)  ; 255 ????
    matched_count       db 0
    current_match_idx   db 0  ; ???????????
    
    ; ?????
    no_match_msg        db 10,13,'No students found matching the selected criteria!',10,13,'$'
    
    ; ??????
    filter_display_msg  db 10,13,'Current Filter: Program: $'
    level_label2        db ', Level: $'
    year_label2         db ', Year: 20$'
    intake_label2       db ', Intake: $'
    semester_label2     db ', Semester: $'
    
    ; Subject Names - ?????????
    ; ?????20????5???
    subject_names       db MAX_SUBJECTS * SUBJECT_NAME_LEN DUP('$')
    subjects_set        db 0  ; ?????????
    
    ; ????????
    setup_subjects_msg    db 10,13,10,13,'========== SUBJECT SETUP ==========',10,13
                          db 'Please enter names for 5 subjects:',10,13,'$'
    enter_subject_msg     db 10,13,'Enter name for Subject #'
    subject_num_char      db '1'    ; ?????? '1'
                          db ': $'
    subjects_saved_msg    db 10,13,10,13,'Subjects saved successfully!',10,13,'$'
    setup_required_msg    db 10,13,'Please set up subjects first!',10,13,'$'
    
    ; Student Results
    student_scores        db MAX_STUDENTS * MAX_SUBJECTS DUP(0)
    student_grades        db MAX_STUDENTS * MAX_SUBJECTS DUP(' ')
    student_averages      db MAX_STUDENTS DUP(0)
    student_overall_grades db MAX_STUDENTS DUP(' ')
    
    ; Input/Display Prompts for Student
    enter_id_msg        db 10,13,'Enter Student ID (max 9 chars): $'
    enter_name_msg      db 10,13,'Enter Student Name: $'
    enter_scores_msg    db 10,13,10,13,'Enter scores for the following subjects:',10,13,'$'
    enter_score_msg     db ' - Enter score (0-100): $'
    score_prompt1       db 10,13,'Enter score for '
    score_prompt2       db ' (0-100): $'
    
    ; Result Display Labels
    result_header       db 10,13,10,13,'========== STUDENT RESULT ==========',10,13,'$'
    id_label            db 'ID: $'
    name_label          db 10,13,'Name: $'
    scores_header       db 10,13,10,13,'Subject Scores:',10,13,'$'
    score_display       db ' - Score: $'
    grade_display       db ', Grade: $'
    avg_label           db 10,13,10,13,'Average Score: $'
    overall_label       db 10,13,'Overall Grade: $'
    
    ; General Messages
    saved_msg           db 10,13,10,13,'Student result saved successfully!',10,13,'$'
    max_msg             db 10,13,'Maximum students reached!',10,13,'$'
    press_key_msg       db 'Press any key to continue...$'
    press_key_fees      db 10,13,'Press any key to view fees... $'
    
    ; Temporary Variables
    num_buffer          db 4 DUP(0)
    temp_score          db 0
    temp_sum            dw 0
    current_subject     db 0
    current_student     db 0
    
    ; View Results Messages
    view_header         db 10,13,'========== ALL STUDENT RESULTS ==========',10,13,'$'
    no_records_msg      db 10,13,'No student records found!',10,13,'$'
    student_sep         db 10,13,'----------------------------------------',10,13,'$'
    student_num_msg     db 10,13,'Student #$'
    total_students      db 10,13,10,13,'Total Students: $'
    
    ; Navigation Messages
    of_msg              db ' of $'
    navigation_help     db 10,13,10,13,'========================================',10,13
                        db 'Navigation Options:',10,13
                        db 'N = Next Student    P = Previous Student',10,13  
                        db 'Q = Quit to Menu    ESC = Exit',10,13
                        db '========================================',10,13
                        db 'Enter your choice: $'
                        
    ; Update-related messages
    update_filter_msg       db 10,13,'========== SELECT STUDENT TO UPDATE ==========',10,13
                            db 'Please select criteria to find the student:',10,13,'$'

    select_student_header   db 10,13,'========== SELECT STUDENT ==========',10,13,'$'
    select_prompt_msg       db 10,13,'Showing student $'
    select_options_msg      db 10,13,10,13,'Options:',10,13
                            db 'S = Select this student',10,13
                            db 'N = Next student',10,13
                            db 'P = Previous student',10,13
                            db 'Q = Quit/Cancel',10,13
                            db 'Enter choice: $'

    update_confirm_header   db 10,13,'========== UPDATE CONFIRMATION ==========',10,13
                            db 'Student to update:',10,13,'$'
    current_scores_header   db 10,13,10,13,'Current Scores:',10,13,'$'
    update_confirm_prompt   db 10,13,10,13,'Do you want to update this student? (Y/N): $'

    update_menu_header      db 10,13,'========== UPDATE MENU ==========',10,13,'$'
    updating_student_msg    db 'Updating Student ID: $'
    update_menu_options     db 10,13,10,13,'Update Options:',10,13
                            db '1. Update Single Subject Score',10,13
                            db '2. Update All Subject Scores',10,13
                            db '3. Update Student Information',10,13
                            db '4. Back to Main Menu',10,13
                            db 'Select option (1-4): $'

    select_subject_header   db 10,13,'========== SELECT SUBJECT ==========',10,13,'$'
    dot_space_msg          db '. $'
    select_subject_prompt  db 10,13,'Select subject (1-5): $'
    current_score_msg      db 10,13,'Current score for $'
    colon_space_msg        db ': $'
    new_score_prompt       db 10,13,'Enter new score (0-100): $'
    score_updated_msg      db 10,13,'Score updated successfully!',10,13,'$'
    invalid_option_msg     db 10,13,'Invalid option! Please try again.',10,13,'$'

    update_all_header      db 10,13,'========== UPDATE ALL SCORES ==========',10,13
                           db 'Enter new scores for all subjects:',10,13,'$'
    current_score_bracket  db ' (current: $'
    all_scores_updated_msg db 'All scores updated successfully!',10,13,'$'

    update_info_header     db 10,13,'========== UPDATE STUDENT INFO ==========',10,13,'$'
    current_id_msg         db 10,13,'Current ID: $'
    current_name_msg       db 10,13,'Current Name: $'
    new_id_prompt          db 10,13,10,13,'Enter new Student ID: $'
    new_name_prompt        db 10,13,'Enter new Student Name: $'
    info_updated_msg       db 10,13,'Student information updated successfully!',10,13,'$'

    ; Additional variable
    update_student_idx     db 0  ; Index of student being updated
    
    
    ; Delete-related messages
    delete_filter_msg       db 10,13,'========== SELECT STUDENT TO DELETE ==========',10,13
                            db 'Please select criteria to find the student:',10,13,'$'

    select_delete_header    db 10,13,'========== SELECT STUDENT TO DELETE ==========',10,13,'$'

    delete_select_options   db 10,13,10,13,'WARNING: This will permanently delete the student record!',10,13
                            db 'Options:',10,13
                            db 'D = DELETE this student',10,13
                            db 'N = Next student',10,13
                            db 'P = Previous student',10,13
                            db 'Q = Quit/Cancel',10,13
                            db 'Enter choice: $'

    delete_confirm_header   db 10,13,'========== DELETE CONFIRMATION ==========',10,13
                            db 'WARNING: You are about to DELETE this student:',10,13,'$'

    delete_warning_msg      db 10,13,10,13,'*** WARNING ***',10,13
                            db 'This action will PERMANENTLY DELETE this student record!',10,13
                            db 'This action CANNOT be undone!',10,13,'$'

    delete_confirm_prompt   db 10,13,'Are you sure you want to delete this student? (Y/N): $'

    delete_final_confirm    db 10,13,'FINAL CONFIRMATION: Type Y to permanently delete: $'

    delete_success_msg      db 'Student record has been successfully deleted!',10,13,'$'

    remaining_students_msg  db 10,13,'Remaining students in system: $'

    ; Additional variable
    delete_student_idx      db 0  ; Index of student being deleted
    
        
    new_password_prompt     db 10,13,'Enter new password: $'
    confirm_password_prompt db 10,13,'Confirm new password: $'
    password_changed_msg    db 10,13,'Password changed successfully!',10,13,'$'
    invalid_current_password_msg db 10,13,'Current password is incorrect!',10,13,'$'
    password_mismatch_msg   db 10,13,'Passwords do not match!',10,13,'$'
    logout_after_change_msg db 10,13,'You will now be logged out to test the new password.',10,13
                            db 'Press any key to return to login screen...$'
    temp_password_buffer    db 20 DUP(0)

    
        ; Text export related
    text_filename       db 'STUDENTS.TXT',0
    text_buffer         db 80 DUP(0)
    crlf                db 13,10,'$'
    export_header       db 'STUDENT RESULT MANAGEMENT SYSTEM - EXPORT',13,10
                        db '==========================================',13,10,'$'
    export_success      db 10,13,'Data exported successfully to STUDENTS.TXT!',10,13,'$'
    
    
    
  ; String data terminated with 0 for our custom print procedure
border_top      db 10,13,201  ; ?
                db 205,205,205,205,205,205,205,205,205,205  ; ??????????
                db 205,205,205,205,205,205,205,205,205,205  ; ??????????
                db 205,205,205,205,205,205,205,205,205,205  ; ??????????
                db 205,205,205,205,205,205,205,205,205,205  ; ??????????
                db 205,205,205,205,205,205                  ; ??????
                db 187,0  ; ?

    success_line    db 10,13,186,'      ',254,' DATA SAVED SUCCESSFULLY! ',254,'      ',186,0
    empty_line      db 10,13,186,'                                              ',186,0

    good_text1      db 10,13,186,'      ',219,219,219,219,219,219,'  ',219,219,219,219,219,219,'  ',219,219,219,219,219,219,'  ',219,219,219,219,219,219,'      ',186,0
    good_text2      db 10,13,186,'     ',219,219,'    ',219,219,219,219,'    ',219,219,219,219,'    ',219,219,219,219,'    ',219,219,'     ',186,0
    good_text3      db 10,13,186,'     ',219,219,'      ',219,219,'    ',219,219,219,219,'    ',219,219,219,219,'    ',219,219,'     ',186,0
    good_text4      db 10,13,186,'     ',219,219,'  ',219,219,219,219,219,'    ',219,219,219,219,'    ',219,219,219,219,'    ',219,219,'     ',186,0
    good_text5      db 10,13,186,'     ',219,219,'    ',219,219,219,219,'    ',219,219,219,219,'    ',219,219,219,219,'    ',219,219,'     ',186,0
    good_text6      db 10,13,186,'      ',219,219,219,219,219,219,'  ',219,219,219,219,219,219,'  ',219,219,219,219,219,219,'  ',219,219,219,219,219,219,'      ',186,0

    bye_text1       db 10,13,186,'                                              ',186,0
    bye_text2       db 10,13,186,'          ',219,219,219,219,219,219,'  ',219,219,'   ',219,219,' ',219,219,219,219,219,219,219,'          ',186,0
    bye_text3       db 10,13,186,'          ',219,219,'   ',219,219,' ',219,219,'  ',219,219,'  ',219,219,'               ',186,0
    bye_text4       db 10,13,186,'          ',219,219,219,219,219,219,'   ',219,219,219,219,'   ',219,219,219,219,219,'            ',186,0
    bye_text5       db 10,13,186,'          ',219,219,'   ',219,219,'   ',219,219,'    ',219,219,'               ',186,0
    bye_text6       db 10,13,186,'          ',219,219,219,219,219,219,'    ',219,219,'    ',219,219,219,219,219,219,219,'          ',186,0

    decoration      db 10,13,186,'                                              ',186,0
    decoration2     db 10,13,186,'          ',4,' ',4,' ',4,' ',4,' ',4,' ',4,' ',4,' ',4,' ',4,' ',4,' ',4,'           ',186,0

    thank_you1      db 10,13,186,'                                              ',186,0
    thank_you2      db 10,13,186,'    Thank you for using our application!      ',186,0
    thank_you3      db 10,13,186,'          Have a wonderful day! ',1,'             ',186,0
    thank_you4      db 10,13,186,'                                              ',186,0

    border_bottom   db 10,13,200  ; ?
                    db 205,205,205,205,205,205,205,205,205,205  ; ??????????
                    db 205,205,205,205,205,205,205,205,205,205  ; ??????????
                    db 205,205,205,205,205,205,205,205,205,205  ; ??????????
                    db 205,205,205,205,205,205,205,205,205,205  ; ??????????
                    db 205,205,205,205,205,205                  ; ??????
                    db 188,0  ; ?

    ; Fee structures (scaled by 100 for decimals, e.g., 125050 = RM1250.50)
    base_fees DD 100000, 150000, 200000, 250000  ; Foundation, Diploma, Degree, Master
    library_fee DW 8525     ; RM85.25
    lab_fee DW 15075        ; RM150.75
    scholarship_amount DW 30000  ; RM300.00
    total_fee DD 0          ; Calculated total fee (32-bit)
    scholarship_applied DD 0
    
    ; Fee display messages
    fees_header DB 10,13,'--- FEES INFORMATION ---',10,13,'$'
    tuition_label DB 'Tuition Fee: RM$'
    library_label DB 10,13,'Library Fee: RM$'
    lab_label DB 10,13,'Laboratory Fee: RM$'
    scholarship_label DB 10,13,'Academic Scholarship Applied$'
    total_label DB 10,13,'Total Fee: RM$'
    minus_sign DB '-RM$'
    zero_fee DB 'RM0.00',10,13,'$'
    decimal_point DB '.$'

percent_0 DB ' (0%): $'
percent_15 DB ' (15%): $'
percent_30 DB ' (30%): $'
colon_space DB ': $'

.CODE
MAIN PROC
    MOV AX, SEG _DATA   ; Use SEG _DATA instead of @DATA
    MOV DS, AX
    MOV ES, AX
    
    ; Set initial colors
    CALL SET_SCREEN_COLOR
    CALL CLEAR_SCREEN
    
    ; Display enhanced title with ASCII art
    CALL DISPLAY_ENHANCED_TITLE
    
    ; Try to load existing data
    CALL LOAD_FROM_FILE

MAIN_LOGIN:
    CALL LOGIN_PROC
    CMP AL, 1
    JNE EXIT_PROGRAM    ; Exit if login failed
    
main_menu:
    CALL SHOW_MAIN_MENU
    CMP AL, 1
    JE EXIT_PROGRAM
    CMP AL, 2              ; Check if logout was requested (password change)
    JE MAIN_LOGIN          ; Jump back to login if password was changed
    JMP main_menu          ; Continue showing menu

EXIT_PROGRAM:
    MOV AH, 4Ch
    INT 21h
MAIN ENDP

; ========== LOGIN PROCEDURE ==========
LOGIN_PROC PROC
    ; Reset attempt counter
    MOV attempt_count, 0
    
    ; Clear screen and show title
    CALL CLEAR_SCREEN
    LEA DX, title_msg
    MOV AH, 09h
    INT 21h

LOGIN_LOOP_PROC:
    MOV AL, attempt_count
    CMP AL, max_attempts
    JGE LOGIN_FAILED

    CALL CLEAR_BUFFERS
    LEA DX, login_msg
    MOV AH, 09h
    INT 21h

    LEA DX, username_prompt
    MOV AH, 09h
    INT 21h
    LEA DX, username_buffer
    CALL GET_INPUT

    LEA DX, password_prompt
    MOV AH, 09h
    INT 21h
    LEA DX, password_buffer
    CALL GET_PASSWORD

    CALL VALIDATE_LOGIN
    CMP AL, 1
    JE LOGIN_SUCCESS_PROC

    INC attempt_count
    LEA DX, error_msg
    MOV AH, 09h
    INT 21h
    
    MOV AL, attempt_count
    CMP AL, max_attempts
    JGE LOGIN_FAILED

    LEA DX, retry_msg
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    CMP AL, 27
    JE LOGIN_FAILED
    
    CALL CLEAR_SCREEN
    LEA DX, title_msg
    MOV AH, 09h
    INT 21h
    JMP LOGIN_LOOP_PROC

LOGIN_SUCCESS_PROC:
    LEA DX, success_msg
    MOV AH, 09h
    INT 21h
    MOV AH, 00h
    INT 16h
    MOV AL, 1    ; Return success
    RET

LOGIN_FAILED:
    MOV AL, 0    ; Return failure
    RET
    
LOGIN_PROC ENDP


; ========== UTILITY PROCEDURES ==========

CLEAR_BUFFERS PROC
    PUSH AX CX DI
    CLD
    LEA DI, username_buffer
    MOV CX, 20
    MOV AL, 0
    REP STOSB
    LEA DI, password_buffer
    MOV CX, 20
    MOV AL, 0
    REP STOSB
    POP DI CX AX
    RET
CLEAR_BUFFERS ENDP

CLEAR_PASSWORD_BUFFERS PROC
    PUSH AX CX DI
    CLD
    ; Clear password_buffer
    LEA DI, password_buffer
    MOV CX, 20
    MOV AL, 0
    REP STOSB
    ; Clear temp_password_buffer
    LEA DI, temp_password_buffer
    MOV CX, 20
    MOV AL, 0
    REP STOSB
    POP DI CX AX
    RET
CLEAR_PASSWORD_BUFFERS ENDP

CLEAR_SCREEN PROC
    PUSH AX BX CX DX
    MOV AH, 06h
    MOV AL, 0
    MOV BH, 07h
    MOV CH, 0
    MOV CL, 0
    MOV DH, 24
    MOV DL, 79
    INT 10h
    MOV AH, 02h
    MOV BH, 0
    MOV DH, 0
    MOV DL, 0
    INT 10h
    POP DX CX BX AX
    RET
CLEAR_SCREEN ENDP

GET_INPUT PROC
    PUSH AX BX CX DX
    MOV BX, DX
    MOV CX, 0
GI_LOOP:
    MOV AH, 01h
    INT 21h
    CMP AL, 13
    JE GI_DONE
    CMP AL, 8
    JE GI_BACKSPACE
    CMP CX, 19
    JGE GI_LOOP
    MOV [BX], AL
    INC BX
    INC CX
    JMP GI_LOOP
GI_BACKSPACE:
    CMP CX, 0
    JE GI_LOOP
    DEC BX
    DEC CX
    MOV BYTE PTR [BX], 0
    MOV AH, 02h
    MOV DL, 08h
    INT 21h
    MOV DL, ' '
    INT 21h
    MOV DL, 08h
    INT 21h
    JMP GI_LOOP
GI_DONE:
    MOV BYTE PTR [BX], '$'
    POP DX CX BX AX
    RET
GET_INPUT ENDP

GET_PASSWORD PROC
    PUSH AX BX CX DX
    MOV BX, DX
    MOV CX, 0
GP_LOOP:
    MOV AH, 08h
    INT 21h
    CMP AL, 13
    JE GP_DONE
    CMP AL, 8
    JE GP_BACK
    CMP CX, 19
    JGE GP_LOOP
    MOV [BX], AL
    INC BX
    INC CX
    MOV AH, 02h
    MOV DL, '*'
    INT 21h
    JMP GP_LOOP
GP_BACK:
    CMP CX, 0
    JE GP_LOOP
    DEC BX
    DEC CX
    MOV BYTE PTR [BX], 0
    MOV AH, 02h
    MOV DL, 08h
    INT 21h
    MOV DL, ' '
    INT 21h
    MOV DL, 08h
    INT 21h
    JMP GP_LOOP
GP_DONE:
    MOV BYTE PTR [BX], '$'
    POP DX CX BX AX
    RET
GET_PASSWORD ENDP

VALIDATE_LOGIN PROC
    PUSH SI DI BX CX DX
    
    ; ?????
    LEA SI, username_buffer
    LEA DI, valid_username
    CALL COMPARE_STRINGS
    CMP AL, 1
    JNE VL_INVALID
    
    ; ?????????hash
    CALL LOAD_PASSWORD_HASH
    CMP AL, 0
    JE VL_CREATE_NEW_HASH  ; ??????????
    
    JMP VL_VERIFY_HASH
    
VL_CREATE_NEW_HASH:
    ; ????????????
    LEA SI, default_password
    CALL CREATE_PASSWORD_FILE
    CALL LOAD_PASSWORD_HASH  ; ????
    
VL_VERIFY_HASH:
    ; Hash???????
    CALL HASH_USER_PASSWORD
    
    ; ??hash
    LEA SI, hashed_password
    LEA DI, file_hash
    CALL COMPARE_HASH_BYTES
    CMP AL, 1
    JNE VL_INVALID
    
    MOV AL, 1
    JMP VL_DONE
    
VL_INVALID:
    MOV AL, 0
VL_DONE:
    POP DX CX BX DI SI
    RET
VALIDATE_LOGIN ENDP

COMPARE_STRINGS PROC
    PUSH SI DI BX CX
    MOV CX, 0  ; Character counter
CS_LOOP:
    MOV AL, [SI]
    MOV BL, [DI]
    
    ; Check if we've reached the end of first string
    CMP AL, '$'
    JE CS_FIRST_END
    CMP AL, 0
    JE CS_FIRST_END
    
    ; Check if we've reached the end of second string
    CMP BL, '$'
    JE CS_SECOND_END
    CMP BL, 0
    JE CS_SECOND_END
    
    ; Compare current characters
    CMP AL, BL
    JNE CS_NOT_EQUAL
    
    ; Move to next character
    INC SI
    INC DI
    INC CX
    
    ; Safety check - don't compare more than 19 characters
    CMP CX, 19
    JL CS_LOOP
    JMP CS_EQUAL  ; If we got here, strings are equal up to 19 chars
    
CS_FIRST_END:
    ; First string ended, check if second string also ended
    CMP BL, '$'
    JE CS_EQUAL
    CMP BL, 0
    JE CS_EQUAL
    JMP CS_NOT_EQUAL
    
CS_SECOND_END:
    ; Second string ended, check if first string also ended
    CMP AL, '$'
    JE CS_EQUAL
    CMP AL, 0
    JE CS_EQUAL
    JMP CS_NOT_EQUAL
    
CS_NOT_EQUAL:
    MOV AL, 0
    JMP CS_DONE
    
CS_EQUAL:
    MOV AL, 1
    
CS_DONE:
    POP CX BX DI SI
    RET
COMPARE_STRINGS ENDP

SIMPLE_PASSWORD_COMPARE PROC
    PUSH SI DI BX CX
    MOV CX, 0  ; Character counter
SPC_LOOP:
    MOV AL, [SI]
    MOV BL, [DI]
    
    ; Check if both reached end ($ or null)
    CMP AL, '$'
    JE SPC_CHECK_SECOND
    CMP AL, 0
    JE SPC_CHECK_SECOND
    
    ; Check if second string ended but first didn't
    CMP BL, '$'
    JE SPC_NOT_EQUAL
    CMP BL, 0
    JE SPC_NOT_EQUAL
    
    ; Compare characters
    CMP AL, BL
    JNE SPC_NOT_EQUAL
    
    ; Move to next character
    INC SI
    INC DI
    INC CX
    
    ; Safety limit
    CMP CX, 19
    JL SPC_LOOP
    JMP SPC_EQUAL
    
SPC_CHECK_SECOND:
    ; First string ended, check if second also ended
    CMP BL, '$'
    JE SPC_EQUAL
    CMP BL, 0
    JE SPC_EQUAL
    JMP SPC_NOT_EQUAL
    
SPC_NOT_EQUAL:
    MOV AL, 0
    JMP SPC_DONE
    
SPC_EQUAL:
    MOV AL, 1
    
SPC_DONE:
    POP CX BX DI SI
    RET
SIMPLE_PASSWORD_COMPARE ENDP

CREATE_PASSWORD_FILE PROC
    PUSH AX BX CX DX SI DI  ; Note: SI is passed with pointer to new password
    
    ; Create file
    MOV AH, 3Ch
    MOV CX, 0
    LEA DX, password_filename
    INT 21h
    JC CPF_ERROR
    MOV file_handle, AX
    
    ; Write header
    MOV AH, 40h
    MOV BX, file_handle
    MOV CX, 16  ; Header length? Adjust if needed
    LEA DX, passwd_file_header
    INT 21h
    
    ; Write user count
    MOV AH, 40h
    MOV BX, file_handle
    MOV CX, 1
    LEA DX, user_count
    INT 21h
    
    ; Write admin username
    MOV AH, 40h
    MOV BX, file_handle
    MOV CX, 15
    LEA DX, admin_username
    INT 21h
    
    ; Copy the passed new password (from SI) to password_buffer
    LEA DI, password_buffer
    CALL COPY_STRING_TO_BUFFER  ; Copies from SI to DI
    
    ; Hash the new password
    CALL HASH_USER_PASSWORD
    
    ; Write hash
    MOV AH, 40h
    MOV BX, file_handle
    MOV CX, 32
    LEA DX, hashed_password
    INT 21h
    
    ; Close file
    MOV AH, 3Eh
    MOV BX, file_handle
    INT 21h
    
CPF_ERROR:
    POP DI SI DX CX BX AX
    RET
CREATE_PASSWORD_FILE ENDP

; 5. ???????hash
LOAD_PASSWORD_HASH PROC
    PUSH BX CX DX SI DI
    
    ; ??????
    MOV AH, 3Dh
    MOV AL, 0  ; ??
    LEA DX, password_filename
    INT 21h
    JC LPH_FILE_NOT_FOUND
    MOV file_handle, AX
    
    ; ??????16???? + 1????? + 15????? = 32???
    MOV AH, 42h  ; ??????
    MOV AL, 0    ; ?????
    MOV BX, file_handle
    MOV CX, 0
    MOV DX, 32   ; ??32??
    INT 21h
    
    ; ??hash
    MOV AH, 3Fh
    MOV BX, file_handle
    MOV CX, 32
    LEA DX, file_hash
    INT 21h
    
    ; ????
    MOV AH, 3Eh
    MOV BX, file_handle
    INT 21h
    
    MOV AL, 1  ; ??
    JMP LPH_DONE
    
LPH_FILE_NOT_FOUND:
    MOV AL, 0  ; ??
    
LPH_DONE:
    POP DI SI DX CX BX
    RET
LOAD_PASSWORD_HASH ENDP

; 6. ???Hash???????
HASH_USER_PASSWORD PROC
    PUSH AX BX CX SI DI
    
    ; ??hash???
    LEA DI, hashed_password
    MOV CX, 32
    MOV AL, 0
    REP STOSB
    
    ; ??????hash
    LEA SI, password_buffer
    LEA DI, temp_hash
    MOV CX, 0
    
HUP_ROUND1:
    MOV AL, [SI]
    CMP AL, '$'
    JE HUP_ROUND2_PREP
    CMP AL, 0
    JE HUP_ROUND2_PREP
    
    ; ??hash
    MOV BL, CL
    AND BL, 0Fh  ; BL = position % 16
    LEA BX, hash_salt
    ADD BL, [BX]  ; ??????
    XOR AL, BL
    
    ; ????
    ROL AL, 3
    ADD AL, CL
    XOR AL, 0A7h
    ROR AL, 1
    
    MOV [DI], AL
    INC SI
    INC DI
    INC CX
    CMP CX, 31
    JL HUP_ROUND1
    
HUP_ROUND2_PREP:
    ; ??????hash
    LEA SI, temp_hash
    LEA DI, hashed_password
    MOV CX, 16
    
HUP_ROUND2:
    MOV AL, [SI]
    MOV BL, [SI+16]  ; ????
    XOR AL, BL
    SHL AL, 1
    XOR AL, CL
    ROR AL, 2
    MOV [DI], AL
    
    INC SI
    INC DI
    LOOP HUP_ROUND2
    
    POP DI SI CX BX AX
    RET
HASH_USER_PASSWORD ENDP

; 7. ???hash??
COMPARE_HASH_BYTES PROC
    PUSH SI DI CX
    
    MOV CX, 16  ; ??16??
CHB_LOOP:
    MOV AL, [SI]
    CMP AL, [DI]
    JNE CHB_NOT_EQUAL
    INC SI
    INC DI
    LOOP CHB_LOOP
    
    MOV AL, 1  ; ??
    JMP CHB_DONE
    
CHB_NOT_EQUAL:
    MOV AL, 0  ; ???
    
CHB_DONE:
    POP CX DI SI
    RET
COMPARE_HASH_BYTES ENDP

; 8. ??????????
COPY_STRING_TO_BUFFER PROC
    PUSH AX SI DI CX
    
    MOV CX, 0
CSTB_LOOP:
    MOV AL, [SI]
    CMP AL, 0
    JE CSTB_DONE
    MOV [DI], AL
    INC SI
    INC DI
    INC CX
    CMP CX, 19
    JL CSTB_LOOP
    
CSTB_DONE:
    MOV BYTE PTR [DI], '$'
    POP CX DI SI AX
    RET
COPY_STRING_TO_BUFFER ENDP

; 9. ?????????
CHANGE_PASSWORD PROC
    PUSH AX BX CX DX SI DI
    
    ; Clear screen and show change password header
    CALL CLEAR_SCREEN
    LEA DX, newline
    MOV AH, 09h
    INT 21h
    LEA DX, newline
    MOV AH, 09h
    INT 21h
    
    ; Clear password buffers first
    CALL CLEAR_PASSWORD_BUFFERS
    
    ; Enter new password
    LEA DX, new_password_prompt
    MOV AH, 09h
    INT 21h
    
    LEA DX, password_buffer
    CALL GET_PASSWORD
    
    ; Confirm password
    LEA DX, confirm_password_prompt
    MOV AH, 09h
    INT 21h
    
    LEA DX, temp_password_buffer
    CALL GET_PASSWORD
    
    ; Compare passwords
    LEA SI, password_buffer
    LEA DI, temp_password_buffer
    CALL SIMPLE_PASSWORD_COMPARE
    CMP AL, 1
    JNE CP_MISMATCH
    
    ; Create new password file
    LEA SI, password_buffer
    CALL CREATE_PASSWORD_FILE
    
    LEA DX, password_changed_msg
    MOV AH, 09h
    INT 21h
    
    ; Show logout message
    LEA DX, logout_after_change_msg
    MOV AH, 09h
    INT 21h
    
    ; Wait for key press
    MOV AH, 01h
    INT 21h
    
    ; Restore registers and set return value for success
    POP DI SI DX CX BX AX
    MOV AL, 2  ; Success - request logout
    RET
    
CP_MISMATCH:
    LEA DX, password_mismatch_msg
    MOV AH, 09h
    INT 21h
    
    ; Restore registers and set return value for failure
    POP DI SI DX CX BX AX
    MOV AL, 0  ; Failure
    RET
CHANGE_PASSWORD ENDP


SHOW_MAIN_MENU PROC

    ; Set menu color
    MOV color_attr, 0Eh  ; Yellow on black
    CALL SET_TEXT_ATTRIBUTES
    
    CALL CLEAR_SCREEN
    LEA DX, ascii_welcome
    MOV AH, 09h
    INT 21h
    
    ; Reset color
    MOV color_attr, 0Fh
    CALL SET_TEXT_ATTRIBUTES
    
    LEA DX, menu_msg
    MOV AH, 09h
    INT 21h    

SMM_LOOP:
    CALL CLEAR_SCREEN
    LEA DX, menu_msg
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    
    ; Use direct comparisons and near jumps
    CMP AL, '0'
    JNE SMM_CHECK_1
    JMP SMM_OPT0
    
SMM_CHECK_1:
    CMP AL, '1'
    JNE SMM_CHECK_2
    JMP SMM_OPT1
    
SMM_CHECK_2:
    CMP AL, '2'
    JNE SMM_CHECK_3
    JMP SMM_OPT2
    
SMM_CHECK_3:
    CMP AL, '3'
    JNE SMM_CHECK_4
    JMP SMM_OPT3
    
SMM_CHECK_4:
    CMP AL, '4'
    JNE SMM_CHECK_5
    JMP SMM_OPT4
    
SMM_CHECK_5:
    CMP AL, '5'
    JNE SMM_CHECK_6    ; Changed from JNE SMM_INVALID
    JMP SMM_OPT5
    
SMM_CHECK_6:
    CMP AL, '6'
    JNE SMM_CHECK_7
    JMP SMM_OPT6        ; Added jump to option 6
    
SMM_CHECK_7:
    CMP AL, '7'
    JNE SMM_CHECK_8
    JMP SMM_OPT7        ; Added jump to option 7
    
SMM_CHECK_8:
    CMP AL, '8'
    JNE SMM_INVALID
    JMP SMM_OPT8        ; Added jump to option 8
    
SMM_INVALID:
    JMP SMM_LOOP

SMM_OPT0:
    CALL CLEAR_SCREEN
    CALL SETUP_SUBJECTS
    LEA DX, newline
    MOV AH, 09h
    INT 21h
    LEA DX, press_key_msg
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    JMP SMM_LOOP

SMM_OPT1:
    CMP subjects_set, 0
    JNE SMM_OPT1_CONTINUE
    CALL CLEAR_SCREEN
    LEA DX, setup_required_msg
    MOV AH, 09h
    INT 21h
    LEA DX, press_key_msg
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    JMP SMM_LOOP
SMM_OPT1_CONTINUE:
    CALL CLEAR_SCREEN
    CALL ADD_STUDENT_RESULT
    LEA DX, newline
    MOV AH, 09h
    INT 21h
    LEA DX, press_key_msg
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    JMP SMM_LOOP

SMM_OPT2:
    CMP subjects_set, 0
    JNE SMM_OPT2_CONTINUE
    CALL CLEAR_SCREEN
    LEA DX, setup_required_msg
    MOV AH, 09h
    INT 21h
    LEA DX, press_key_msg
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    JMP SMM_LOOP
SMM_OPT2_CONTINUE:
    CALL CLEAR_SCREEN
    CALL VIEW_STUDENT_RESULTS
    LEA DX, newline
    MOV AH, 09h
    INT 21h
    LEA DX, press_key_msg
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    JMP SMM_LOOP

SMM_OPT3:
    CMP subjects_set, 0
    JNE SMM_OPT3_CONTINUE
    CALL CLEAR_SCREEN
    LEA DX, setup_required_msg
    MOV AH, 09h
    INT 21h
    LEA DX, press_key_msg
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    JMP SMM_LOOP
SMM_OPT3_CONTINUE:
    CALL CLEAR_SCREEN
    CALL UPDATE_STUDENT_RESULT
    LEA DX, newline
    MOV AH, 09h
    INT 21h
    LEA DX, press_key_msg
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    JMP SMM_LOOP
    
SMM_OPT4:
    CMP subjects_set, 0
    JNE SMM_OPT4_CONTINUE
    CALL CLEAR_SCREEN
    LEA DX, setup_required_msg
    MOV AH, 09h
    INT 21h
    LEA DX, press_key_msg
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    JMP SMM_LOOP
SMM_OPT4_CONTINUE:
    CALL CLEAR_SCREEN
    CALL DELETE_STUDENT_RESULT
    LEA DX, newline
    MOV AH, 09h
    INT 21h
    LEA DX, press_key_msg
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    JMP SMM_LOOP
    
SMM_OPT5:
    ; Save data before exit
    CALL SAVE_TO_FILE
    
    ; Display colorful goodbye message (Correct Method)
    CALL display_goodbye
    
    MOV AL, 1  ; Set AL to 1 to indicate exit
    RET
    
SMM_OPT6:      ; Change password option
    CALL CHANGE_PASSWORD
    CMP AL, 2  ; Check if logout is required
    JE SMM_LOGOUT  ; Jump to logout if password was changed
    
    ; If password change failed, continue in menu
    LEA DX, press_key_msg
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    JMP SMM_LOOP

SMM_LOGOUT:
    ; Display logout message
    MOV AH, 09h
    LEA DX, logout_after_change_msg
    INT 21h
    
    ; Wait for key press
    MOV AH, 00h
    INT 16h
    
    ; Clear screen for fresh login
    CALL CLEAR_SCREEN
    
    ; We need to exit the current procedure stack and return to MAIN
    ; Set AL to 2 to indicate logout/password change
    MOV AL, 2
    RET    ; This will return to SHOW_MAIN_MENU caller (which is MAIN)

SMM_OPT7:      ; Add this new option handler
    CALL CLEAR_SCREEN
    CALL EXPORT_TO_TEXT
    LEA DX, press_key_msg
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    JMP SMM_LOOP
    
SMM_OPT8:      ; Calculate fees option
    CMP subjects_set, 0
    JNE SMM_OPT8_CONTINUE
    CALL CLEAR_SCREEN
    LEA DX, setup_required_msg
    MOV AH, 09h
    INT 21h
    LEA DX, press_key_msg
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    JMP SMM_LOOP
SMM_OPT8_CONTINUE:
    CALL CLEAR_SCREEN
    CALL CALCULATE_STUDENT_FEES
    LEA DX, press_key_msg
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    JMP SMM_LOOP
    
SHOW_MAIN_MENU ENDP

; ========== SUBJECT SETUP PROCEDURE ==========
SETUP_SUBJECTS PROC
    PUSH AX BX CX DX SI DI
    
    LEA DX, setup_subjects_msg
    MOV AH, 09h
    INT 21h
    
    MOV CX, 0
    
SS_LOOP:
    ; ???????
    MOV AL, CL
    ADD AL, '1'
    MOV subject_num_char, AL
    
    ; ????????
    LEA DX, enter_subject_msg
    MOV AH, 09h
    INT 21h
    
    ; ??????
    MOV AX, CX
    MOV BL, SUBJECT_NAME_LEN
    MUL BL
    LEA DI, subject_names
    ADD DI, AX
    
    ; ?????
    PUSH CX
    PUSH DI
    MOV CX, SUBJECT_NAME_LEN
SS_CLEAR:
    MOV BYTE PTR [DI], '$'
    INC DI
    LOOP SS_CLEAR
    POP DI
    POP CX
    
    ; ????
    MOV DX, DI
    PUSH CX
    CALL GET_SUBJECT_INPUT
    POP CX
    
    ; ?????
    INC CX
    CMP CX, MAX_SUBJECTS
    JL SS_LOOP
    
    MOV subjects_set, 1
    
    LEA DX, subjects_saved_msg
    MOV AH, 09h
    INT 21h
    
    POP DI SI DX CX BX AX
    RET
SETUP_SUBJECTS ENDP

GET_SUBJECT_INPUT PROC
    PUSH AX BX CX DX
    MOV BX, DX
    MOV CX, 0
GSI_LOOP:
    MOV AH, 01h
    INT 21h
    CMP AL, 13
    JE GSI_DONE
    CMP AL, 8
    JE GSI_BACKSPACE
    CMP CX, SUBJECT_NAME_LEN-1
    JGE GSI_LOOP
    MOV [BX], AL
    INC BX
    INC CX
    JMP GSI_LOOP
GSI_BACKSPACE:
    CMP CX, 0
    JE GSI_LOOP
    DEC BX
    DEC CX
    MOV BYTE PTR [BX], '$'
    MOV AH, 02h
    MOV DL, 08h
    INT 21h
    MOV DL, ' '
    INT 21h
    MOV DL, 08h
    INT 21h
    JMP GSI_LOOP
GSI_DONE:
    MOV BYTE PTR [BX], '$'
    POP DX CX BX AX
    RET
GET_SUBJECT_INPUT ENDP

; ========== STUDENT FEATURE PROCEDURES ==========

ADD_STUDENT_RESULT PROC
    PUSH AX BX CX DX SI DI

    MOV AL, student_count
    CMP AL, MAX_STUDENTS
    JL ASR_CONTINUE
    JMP ASR_MAX

ASR_CONTINUE:
    ; Clear screen and get student classification details
    CALL CLEAR_SCREEN
    CALL GET_PROGRAM_SELECTION
    CALL GET_LEVEL_SELECTION
    CALL GET_YEAR_INPUT
    CALL GET_INTAKE_SELECTION
    CALL GET_SEMESTER_SELECTION

    ; Store classification details for the current student
    MOV BL, student_count
    MOV BH, 0

    LEA SI, student_programs
    ADD SI, BX
    MOV AL, filter_program
    MOV [SI], AL

    LEA SI, student_levels
    ADD SI, BX
    MOV AL, filter_level
    MOV [SI], AL

    LEA SI, student_years
    ADD SI, BX
    MOV AL, filter_year
    MOV [SI], AL

    LEA SI, student_intakes
    ADD SI, BX
    MOV AL, filter_intake
    MOV [SI], AL

    LEA SI, student_semesters
    ADD SI, BX
    MOV AL, filter_semester
    MOV [SI], AL

    ; Clear screen for input
    CALL CLEAR_SCREEN

    ; Display current filter (classification)
    CALL DISPLAY_CURRENT_FILTER

    ; Get student ID input
    LEA DX, enter_id_msg
    MOV AH, 09h
    INT 21h
    MOV AL, student_count
    MOV AH, 0
    MOV CL, 10
    MUL CL
    LEA DI, student_ids
    ADD DI, AX
    MOV DX, DI
    CALL GET_INPUT

    ; Get student name input
    LEA DX, enter_name_msg
    MOV AH, 09h
    INT 21h
    MOV AL, student_count
    MOV AH, 0
    MOV CL, 30
    MUL CL
    LEA DI, student_names
    ADD DI, AX
    MOV DX, DI
    CALL GET_INPUT

    ; Prompt for scores
    LEA DX, enter_scores_msg
    MOV AH, 09h
    INT 21h

    MOV temp_sum, 0
    MOV current_subject, 0

    ; Input all subject scores
    CALL INPUT_ALL_SCORES

    ; Calculate and store average score
    MOV AX, temp_sum
    MOV CL, MAX_SUBJECTS
    MOV CH, 0
    DIV CL
    MOV BL, student_count
    MOV BH, 0
    LEA SI, student_averages
    ADD SI, BX
    MOV [SI], AL

    ; Calculate and store overall grade
    MOV temp_score, AL
    CALL CALCULATE_GRADE
    LEA SI, student_overall_grades
    ADD SI, BX
    MOV [SI], AL

    ; Clear screen and display the student's full result
    CALL CLEAR_SCREEN
    CALL DISPLAY_STUDENT_RESULT


    ; Display saved message and increment student count
    LEA DX, saved_msg
    MOV AH, 09h
    INT 21h
    INC student_count
    CALL SAVE_TO_FILE    ; Auto-save after adding student
    JMP ASR_DONE

ASR_MAX:
    ; Display message if maximum students reached
    LEA DX, max_msg
    MOV AH, 09h
    INT 21h

ASR_DONE:
    POP DI SI DX CX BX AX
    RET
ADD_STUDENT_RESULT ENDP


VIEW_STUDENT_RESULTS PROC
    PUSH AX BX CX DX SI DI
    
    ; Check if there are any student records
    MOV AL, student_count
    CMP AL, 0
    JNE VSR_HAS_RECORDS
    
    ; No records found
    LEA DX, no_records_msg
    MOV AH, 09h
    INT 21h
    JMP VSR_DONE
    
VSR_HAS_RECORDS:
    ; Get filter criteria
    CALL CLEAR_SCREEN
    LEA DX, view_filter_msg
    MOV AH, 09h
    INT 21h
    
    CALL GET_PROGRAM_SELECTION
    CALL GET_LEVEL_SELECTION
    CALL GET_YEAR_INPUT
    CALL GET_INTAKE_SELECTION
    CALL GET_SEMESTER_SELECTION
    
    ; Find matching students
    CALL FIND_MATCHING_STUDENTS
    
    ; Check if any matches were found
    MOV AL, matched_count
    CMP AL, 0
    JNE VSR_HAS_MATCHES
    
    CALL CLEAR_SCREEN
    LEA DX, no_match_msg
    MOV AH, 09h
    INT 21h
    JMP VSR_DONE
    
VSR_HAS_MATCHES:
    MOV current_match_idx, 0
    
VSR_NAVIGATION_LOOP:
    CALL CLEAR_SCREEN
    
    ; Display header and filter criteria
    LEA DX, view_header
    MOV AH, 09h
    INT 21h
    
    CALL DISPLAY_CURRENT_FILTER
    
    ; Display current student number (in the matched list)
    LEA DX, student_num_msg
    MOV AH, 09h
    INT 21h
    MOV AL, current_match_idx
    INC AL
    MOV AH, 0
    CALL DISPLAY_NUMBER
    
    LEA DX, of_msg
    MOV AH, 09h
    INT 21h
    
    MOV AL, matched_count
    MOV AH, 0
    CALL DISPLAY_NUMBER
    
    LEA DX, student_sep
    MOV AH, 09h
    INT 21h
    
    ; Get the actual student index from the matched_students array
    LEA SI, matched_students
    MOV BL, current_match_idx
    MOV BH, 0
    ADD SI, BX
    MOV BL, [SI] ; BL = actual student index
    
    ; Display student information (using BL as the index)
    LEA DX, id_label
    MOV AH, 09h
    INT 21h
    MOV AL, BL ; Use BL (actual student index)
    MOV AH, 0
    MOV CL, 10
    MUL CL
    LEA SI, student_ids
    ADD SI, AX
    MOV DX, SI
    MOV AH, 09h
    INT 21h
    
    LEA DX, name_label
    MOV AH, 09h
    INT 21h
    MOV AL, BL ; Use BL (actual student index)
    MOV AH, 0
    MOV CL, 30
    MUL CL
    LEA SI, student_names
    ADD SI, AX
    MOV DX, SI
    MOV AH, 09h
    INT 21h
    
    ; Display classification information for the current student being viewed
    LEA DX, newline
    MOV AH, 09h
    INT 21h
    LEA DX, filter_display_msg ; Re-using for general display, but showing actual student data
    MOV AH, 09h
    INT 21h

    MOV AL, BL ; Use BL (actual student index)
    MOV AH, 0
    MOV BX, AX ; BX now holds student index
    
    LEA SI, student_programs
    ADD SI, BX
    MOV AL, [SI]
    CALL DISPLAY_PROGRAM_NAME ; AL is already 1-based for this call, but the procedure will adjust
    
    LEA DX, level_label2
    MOV AH, 09h
    INT 21h
    LEA SI, student_levels
    ADD SI, BX
    MOV AL, [SI]
    MOV AH, 0
    CALL DISPLAY_NUMBER

    LEA DX, year_label2
    MOV AH, 09h
    INT 21h
    LEA SI, student_years
    ADD SI, BX
    MOV AL, [SI]
    MOV AH, 0
    CALL DISPLAY_NUMBER

    LEA DX, intake_label2
    MOV AH, 09h
    INT 21h
    LEA SI, student_intakes
    ADD SI, BX
    MOV AL, [SI]
    CALL DISPLAY_INTAKE_NAME ; AL is already 1-based for this call, but the procedure will adjust

    LEA DX, semester_label2
    MOV AH, 09h
    INT 21h
    LEA SI, student_semesters
    ADD SI, BX
    MOV AL, [SI]
    MOV AH, 0
    CALL DISPLAY_NUMBER

    LEA DX, scores_header
    MOV AH, 09h
    INT 21h
    
    MOV current_subject, 0
    
VSR_SUBJ_LOOP:
    LEA DX, newline
    MOV AH, 09h
    INT 21h
    
    ; ?? DISPLAY_SUBJECT_NAME
    MOV AL, current_subject ; ??????? AL
    CALL DISPLAY_SUBJECT_NAME
    
    MOV AL, BL ; Use BL (actual student index)
    MOV AH, 0
    MOV BH, MAX_SUBJECTS
    MUL BH
    ADD AL, current_subject
    MOV AH, 0
    MOV DI, AX
    
    LEA DX, score_display
    MOV AH, 09h
    INT 21h
    LEA SI, student_scores
    ADD SI, DI
    MOV AL, [SI]
    MOV AH, 0
    CALL DISPLAY_NUMBER

    LEA DX, grade_display
    MOV AH, 09h
    INT 21h
    LEA SI, student_grades
    ADD SI, DI
    MOV DL, [SI]
    MOV AH, 02h
    INT 21h
    INC current_subject
    MOV AL, current_subject
    CMP AL, MAX_SUBJECTS
    JL VSR_SUBJ_LOOP
    
VSR_SUBJ_DONE:
    LEA DX, avg_label
    MOV AH, 09h
    INT 21h
    MOV AL, BL ; Use BL (actual student index)
    MOV AH, 0
    LEA SI, student_averages
    ADD SI, AX
    MOV AL, [SI]
    MOV AH, 0
    CALL DISPLAY_NUMBER
    
    LEA DX, overall_label
    MOV AH, 09h
    INT 21h
    LEA SI, student_overall_grades
    MOV AL, BL
    MOV AH, 0
    ADD SI, AX
    MOV DL, [SI]
    LEA SI, student_averages
    ADD SI, AX
    MOV CL, [SI]
    
    ; Check if grade is A (green blinking) or average < 50 (red blinking)
    CMP DL, 'A'
    JE VSR_GREEN_BLINK
    CMP CL, 50
    JB VSR_RED_BLINK
    
    ; Normal display for other grades
    MOV AH, 02h
    INT 21h
    JMP VSR_GRADE_DONE
    
VSR_GREEN_BLINK:
    ; Display the grade in green first
    MOV AH, 09h
    MOV AL, DL
    MOV BH, 0
    MOV BL, 0Ah         ; Green color
    MOV CX, 1
    INT 10h
    
VSR_RED_BLINK:
    ; For low average, display in red (no blinking for now)
    MOV AH, 09h
    MOV AL, DL
    MOV BH, 0
    MOV BL, 0Ch         ; Red color
    MOV CX, 1
    INT 10h
VSR_GRADE_DONE:
    ; Pause before displaying fees
    LEA DX, press_key_fees  ; Assuming you define this string: press_key_fees DB 10,13,'Press any key to view fees... $'
    MOV AH, 09h
    INT 21h
    
    ; Check average score for smiling emoji line blinking
    PUSH BX              ; Save student index before blinking
    CMP CL, 90           ; Compare average with 90
    JA VSR_HIGH_ACHIEVER ; Jump if average > 90
    
    ; Average <= 90: Red blinking smiling line
    MOV BL, 0Ch          ; Red color attribute
    CALL BLINK_SMILING_EMOJI_LINE
    JMP VSR_BLINK_DONE
    
VSR_HIGH_ACHIEVER:
    ; Average > 90: Green blinking smiling line  
    MOV BL, 02h          ; Green color attribute
    CALL BLINK_SMILING_EMOJI_LINE
    
VSR_BLINK_DONE:
    POP BX               ; Restore student index for fee calculation
VSR_CONTINUE_AFTER_KEY:

    ; Optional: Clear screen after pause (uncomment if desired)
    ; MOV AH, 06h
    ; MOV AL, 0
    ; MOV BH, 07h  ; White on black
    ; MOV CX, 0
    ; MOV DH, 24
    ; MOV DL, 79
    ; INT 10h
    ; New: Calculate and display fees
    CALL CALCULATE_FEE   ; BL has student index
    CALL DISPLAY_FEES
    
    ; Navigation logic (for the matched list)
    LEA DX, navigation_help
    MOV AH, 09h
    INT 21h
    
    MOV AH, 01h
    INT 21h
    
    CMP AL, 'n'
    JE VSR_NEXT_MATCH
    CMP AL, 'N'
    JE VSR_NEXT_MATCH
    CMP AL, 'p'
    JE VSR_PREV_MATCH
    CMP AL, 'P'
    JE VSR_PREV_MATCH
    CMP AL, 'q'
    JE VSR_QUIT
    CMP AL, 'Q'
    JE VSR_QUIT
    CMP AL, 27
    JE VSR_QUIT
    
    JMP VSR_NAVIGATION_LOOP
    
VSR_NEXT_MATCH:
    MOV AL, current_match_idx
    INC AL
    CMP AL, matched_count
    JL VSR_NEXT_OK
    MOV AL, 0 ; Wrap around to the first matched student
VSR_NEXT_OK:
    MOV current_match_idx, AL
    JMP VSR_NAVIGATION_LOOP
    
VSR_PREV_MATCH:
    MOV AL, current_match_idx
    CMP AL, 0
    JG VSR_PREV_OK
    MOV AL, matched_count
    DEC AL ; Wrap around to the last matched student
    JMP VSR_PREV_SET
VSR_PREV_OK:
    DEC AL
VSR_PREV_SET:
    MOV current_match_idx, AL
    JMP VSR_NAVIGATION_LOOP
    
VSR_QUIT:
VSR_DONE:
    POP DI SI DX CX BX AX
    RET
VIEW_STUDENT_RESULTS ENDP


INPUT_ALL_SCORES PROC
    PUSH AX BX CX DX SI
    
INPUT_SCORE_LOOP:
    LEA DX, score_prompt1
    MOV AH, 09h
    INT 21h
    
    ; ????????????
    MOV AL, current_subject ; ??????? AL
    CALL DISPLAY_SUBJECT_NAME
    
    LEA DX, score_prompt2
    MOV AH, 09h
    INT 21h
    
    CALL GET_NUMERIC_INPUT
    MOV temp_score, AL
    
    MOV AL, student_count
    MOV AH, 0
    MOV BL, MAX_SUBJECTS
    MUL BL
    ADD AL, current_subject
    MOV AH, 0  
    MOV BX, AX
    
    LEA SI, student_scores
    ADD SI, BX
    MOV AL, temp_score
    MOV [SI], AL
    
    MOV AH, 0
    ADD temp_sum, AX
    
    CALL CALCULATE_GRADE
    LEA SI, student_grades
    ADD SI, BX
    MOV [SI], AL
    
    ; Increment subject counter and check if done
    INC current_subject
    MOV AL, current_subject
    CMP AL, MAX_SUBJECTS
    JL INPUT_SCORE_LOOP
    
    POP SI DX CX BX AX
    RET
INPUT_ALL_SCORES ENDP

GET_NUMERIC_INPUT PROC
    PUSH BX CX DX
    
    LEA BX, num_buffer
    MOV CX, 4
GNI_CLEAR:
    MOV BYTE PTR [BX], 0
    INC BX
    LOOP GNI_CLEAR
    
    LEA BX, num_buffer
    MOV CX, 0
GNI_LOOP:
    MOV AH, 01h
    INT 21h
    CMP AL, 13
    JE GNI_CONVERT
    CMP AL, 8
    JE GNI_BACKSPACE ; Handle backspace for numeric input
    CMP AL, '0'
    JL GNI_LOOP
    CMP AL, '9'
    JG GNI_LOOP
    CMP CX, 3
    JGE GNI_LOOP
    MOV [BX], AL
    INC BX
    INC CX
    JMP GNI_LOOP
    
GNI_BACKSPACE: ; New backspace handling for numeric input
    CMP CX, 0
    JE GNI_LOOP
    DEC BX
    DEC CX
    MOV BYTE PTR [BX], 0
    MOV AH, 02h
    MOV DL, 08h
    INT 21h
    MOV DL, ' '
    INT 21h
    MOV DL, 08h
    INT 21h
    JMP GNI_LOOP
    
GNI_CONVERT:
    LEA BX, num_buffer
    MOV AL, 0
    MOV DL, 10
    
GNI_CONV_LOOP:
    MOV CL, [BX]
    CMP CL, 0
    JE GNI_DONE
    
    SUB CL, '0'
    MUL DL
    ADD AL, CL
    
    INC BX
    JMP GNI_CONV_LOOP
    
GNI_DONE:
    CMP AL, 100
    JLE GNI_VALID
    MOV AL, 100
GNI_VALID:
    POP DX CX BX
    RET
GET_NUMERIC_INPUT ENDP


CALCULATE_GRADE PROC
    MOV AL, temp_score
    CMP AL, 90
    JGE CG_A
    CMP AL, 80
    JGE CG_B
    CMP AL, 70
    JGE CG_C
    CMP AL, 60
    JGE CG_D
    MOV AL, 'F'
    JMP CG_DONE
CG_A:
    MOV AL, 'A'
    JMP CG_DONE
CG_B:
    MOV AL, 'B'
    JMP CG_DONE
CG_C:
    MOV AL, 'C'
    JMP CG_DONE
CG_D:
    MOV AL, 'D'
CG_DONE:
    RET
CALCULATE_GRADE ENDP

DISPLAY_NUMBER PROC
    PUSH AX BX CX DX
    MOV CX, 0
    MOV BX, 10
DN_LOOP:
    MOV DX, 0
    DIV BX
    PUSH DX
    INC CX
    CMP AX, 0
    JNE DN_LOOP
DN_PRINT:
    POP DX
    ADD DL, '0'
    MOV AH, 02h
    INT 21h
    LOOP DN_PRINT
DN_DONE:
    POP DX CX BX AX
    RET
DISPLAY_NUMBER ENDP

DISPLAY_STUDENT_RESULT PROC
    PUSH AX BX CX DX SI DI

    MOV BL, student_count

    LEA DX, result_header
    MOV AH, 09h
    INT 21h

    LEA DX, id_label
    MOV AH, 09h
    INT 21h
    MOV AL, BL
    MOV AH, 0
    MOV CL, 10
    MUL CL
    LEA SI, student_ids
    ADD SI, AX
    MOV DX, SI
    MOV AH, 09h
    INT 21h

    LEA DX, name_label
    MOV AH, 09h
    INT 21h
    MOV AL, BL
    MOV AH, 0
    MOV CL, 30
    MUL CL
    LEA SI, student_names
    ADD SI, AX
    MOV DX, SI
    MOV AH, 09h
    INT 21h

    ; Display classification information
    LEA DX, newline
    MOV AH, 09h
    INT 21h
    LEA DX, filter_display_msg ; Re-using for general display
    MOV AH, 09h
    INT 21h

    MOV AL, student_count
    MOV AH, 0
    MOV BX, AX ; BX now holds student index

    LEA SI, student_programs
    ADD SI, BX
    MOV AL, [SI]
    CALL DISPLAY_PROGRAM_NAME ; AL is already 1-based for this call, but the procedure will adjust

    LEA DX, level_label2
    MOV AH, 09h
    INT 21h
    LEA SI, student_levels
    ADD SI, BX
    MOV AL, [SI]
    MOV AH, 0
    CALL DISPLAY_NUMBER

    LEA DX, year_label2
    MOV AH, 09h
    INT 21h
    LEA SI, student_years
    ADD SI, BX
    MOV AL, [SI]
    MOV AH, 0
    CALL DISPLAY_NUMBER

    LEA DX, intake_label2
    MOV AH, 09h
    INT 21h
    LEA SI, student_intakes
    ADD SI, BX
    MOV AL, [SI]
    CALL DISPLAY_INTAKE_NAME ; AL is already 1-based for this call, but the procedure will adjust

    LEA DX, semester_label2
    MOV AH, 09h
    INT 21h
    LEA SI, student_semesters
    ADD SI, BX
    MOV AL, [SI]
    MOV AH, 0
    CALL DISPLAY_NUMBER

    LEA DX, scores_header
    MOV AH, 09h
    INT 21h

    MOV current_subject, 0

DSR_SUBJ_LOOP:
    LEA DX, newline
    MOV AH, 09h
    INT 21h

    ; ?? DISPLAY_SUBJECT_NAME
    MOV AL, current_subject ; ??????? AL
    CALL DISPLAY_SUBJECT_NAME

    MOV AL, student_count
    MOV AH, 0
    MOV BH, MAX_SUBJECTS
    MUL BH
    ADD AL, current_subject
    MOV AH, 0
    MOV BX, AX

    LEA DX, score_display
    MOV AH, 09h
    INT 21h
    LEA SI, student_scores
    ADD SI, BX
    MOV AL, [SI]
    MOV AH, 0
    CALL DISPLAY_NUMBER

    LEA DX, grade_display
    MOV AH, 09h
    INT 21h
    LEA SI, student_grades
    ADD SI, BX
    MOV DL, [SI]
    MOV AH, 02h
    INT 21h

    INC current_subject
    MOV AL, current_subject
    CMP AL, MAX_SUBJECTS
    JL DSR_SUBJ_LOOP

    LEA DX, avg_label
    MOV AH, 09h
    INT 21h
    MOV BL, student_count
    MOV BH, 0
    LEA SI, student_averages
    ADD SI, BX
    MOV AL, [SI]
    MOV AH, 0
    CALL DISPLAY_NUMBER

    LEA DX, overall_label
    MOV AH, 09h
    INT 21h
    ; Get overall grade and average
    LEA SI, student_overall_grades
    ADD SI, BX
    MOV DL, [SI]     ; DL = grade char
    LEA SI, student_averages
    ADD SI, BX
    MOV CL, [SI]     ; CL = average score
    ; Check if grade is A (green blinking) or average < 50 (red blinking)
    CMP DL, 'A'
    JE DG_GREEN_BLINK
    CMP CL, 50
    JB DG_RED_BLINK
    
    ; Normal display for other grades
    MOV AH, 02h
    INT 21h
    JMP DG_GRADE_DONE
    
DG_GREEN_BLINK:
    ; Display the grade in green first
    MOV AH, 09h
    MOV AL, DL
    MOV BH, 0
    MOV BL, 0Ah         ; Green color
    MOV CX, 1
    INT 10h
    JMP DG_GRADE_DONE
    
DG_RED_BLINK:
    ; For low average, display in red (no blinking for now)
    MOV AH, 09h
    MOV AL, DL
    MOV BH, 0
    MOV BL, 0Ch         ; Red color
    MOV CX, 1
    INT 10h
DG_GRADE_DONE:

    ; Pause before displaying fees
    LEA DX, press_key_fees  ; Assuming you define this string: press_key_fees DB 10,13,'Press any key to view fees... $'
    MOV AH, 09h
    INT 21h
    
    ; Check average score for smiling emoji line blinking
    PUSH BX              ; Save student index before blinking
    CMP CL, 90           ; Compare average with 90
    JA DG_HIGH_ACHIEVER  ; Jump if average > 90
    
    ; Average <= 90: Red blinking smiling line
    MOV BL, 0Ch          ; Red color attribute
    CALL BLINK_SMILING_EMOJI_LINE
    JMP DG_BLINK_DONE
    
DG_HIGH_ACHIEVER:
    ; Average > 90: Green blinking smiling line  
    MOV BL, 02h          ; Green color attribute
    CALL BLINK_SMILING_EMOJI_LINE
    
DG_BLINK_DONE:
    POP BX               ; Restore student index for fee calculation
DG_CONTINUE_AFTER_KEY:

    ; Optional: Clear screen after pause (uncomment if desired)
    ; MOV AH, 06h
    ; MOV AL, 0
    ; MOV BH, 07h  ; White on black
    ; MOV CX, 0
    ; MOV DH, 24
    ; MOV DL, 79
    ; INT 10h

    ; New: Calculate and display fees
    CALL CALCULATE_FEE   ; BL has student index
    CALL DISPLAY_FEES

    POP DI SI DX CX BX AX
    RET
DISPLAY_STUDENT_RESULT ENDP


; Displays the subject name based on the 0-based index in AL
DISPLAY_SUBJECT_NAME PROC
    PUSH AX BX CX DX SI
    
    ; Calculate the address of the subject name
    MOV AH, 0
    MOV BL, SUBJECT_NAME_LEN
    MUL BL
    LEA SI, subject_names
    ADD SI, AX
    
    ; Display the subject name
    MOV DX, SI
    MOV AH, 09h
    INT 21h
    
    POP SI DX CX BX AX
    RET
DISPLAY_SUBJECT_NAME ENDP

; ========== GET CLASSIFICATION INFORMATION PROCEDURES ==========

; Gets program selection from user (1-4)
GET_PROGRAM_SELECTION PROC
    PUSH AX DX
    
GPS_LOOP:
    LEA DX, program_menu_msg
    MOV AH, 09h
    INT 21h
    
    MOV AH, 01h
    INT 21h
    
    CMP AL, '1'
    JL GPS_LOOP
    CMP AL, '4'
    JG GPS_LOOP
    
    SUB AL, '0'
    MOV filter_program, AL  ; Save the selection
    
    POP DX AX
    RET
GET_PROGRAM_SELECTION ENDP

; Gets level selection from user (1-4)
GET_LEVEL_SELECTION PROC
    PUSH AX DX
    
GLS_LOOP:
    LEA DX, level_menu_msg
    MOV AH, 09h
    INT 21h
    
    MOV AH, 01h
    INT 21h
    
    CMP AL, '1'
    JL GLS_LOOP
    CMP AL, '4'
    JG GLS_LOOP
    
    SUB AL, '0'
    MOV filter_level, AL
    
    POP DX AX
    RET
GET_LEVEL_SELECTION ENDP

; Gets year input from user (e.g., 24 for 2024)
GET_YEAR_INPUT PROC
    PUSH AX BX CX DX
    
    LEA DX, year_prompt_msg
    MOV AH, 09h
    INT 21h
    
    ; Use simplified two-digit year input
    CALL GET_TWO_DIGIT_NUMBER
    MOV filter_year, AL
    
    POP DX CX BX AX
    RET
GET_YEAR_INPUT ENDP

; Gets a two-digit number from user
GET_TWO_DIGIT_NUMBER PROC
    PUSH BX CX DX
    
    ; First digit
    MOV AH, 01h
    INT 21h
    CMP AL, '0'
    JL GTD_ERROR
    CMP AL, '9'
    JG GTD_ERROR
    SUB AL, '0'
    MOV BL, 10
    MUL BL
    MOV BL, AL
    
    ; Second digit
    MOV AH, 01h
    INT 21h
    CMP AL, '0'
    JL GTD_ERROR
    CMP AL, '9'
    JG GTD_ERROR
    SUB AL, '0'
    ADD AL, BL
    JMP GTD_DONE
    
GTD_ERROR:
    MOV AL, 24  ; Default value
    
GTD_DONE:
    POP DX CX BX
    RET
GET_TWO_DIGIT_NUMBER ENDP

; Gets intake selection from user (1-3)
GET_INTAKE_SELECTION PROC
    PUSH AX DX
    
GIS_LOOP:
    LEA DX, intake_menu_msg
    MOV AH, 09h
    INT 21h
    
    MOV AH, 01h
    INT 21h
    
    CMP AL, '1'
    JL GIS_LOOP
    CMP AL, '3'
    JG GIS_LOOP
    
    SUB AL, '0'
    MOV filter_intake, AL
    
    POP DX AX
    RET
GET_INTAKE_SELECTION ENDP

; Gets semester selection from user (1-3)
GET_SEMESTER_SELECTION PROC
    PUSH AX DX
    
GSS_LOOP:
    LEA DX, semester_menu_msg
    MOV AH, 09h
    INT 21h
    
    MOV AH, 01h
    INT 21h
    
    CMP AL, '1'
    JL GSS_LOOP
    CMP AL, '3'
    JG GSS_LOOP
    
    SUB AL, '0'
    MOV filter_semester, AL
    
    POP DX AX
    RET
GET_SEMESTER_SELECTION ENDP

; ========== DISPLAY CLASSIFICATION NAMES PROCEDURES ==========

; Displays the program name based on the 1-based index in AL
DISPLAY_PROGRAM_NAME PROC
    PUSH AX BX DX SI
    
    ; Convert 1-based index to 0-based
    DEC AL
    
    ; Calculate offset into program_names
    MOV AH, 0
    MOV BL, 10 ; Each program name is 10 bytes long
    MUL BL
    LEA SI, program_names
    ADD SI, AX
    
    ; Display the program name
    MOV DX, SI
    MOV AH, 09h
    INT 21h
    
    POP SI DX BX AX
    RET
DISPLAY_PROGRAM_NAME ENDP

; Displays the intake name based on the 1-based index in AL
DISPLAY_INTAKE_NAME PROC
    PUSH AX BX DX SI
    
    ; Convert 1-based index to 0-based
    DEC AL
    
    ; Calculate offset into intake_names
    MOV AH, 0
    MOV BL, 10 ; Each intake name is 10 bytes long
    MUL BL
    LEA SI, intake_names
    ADD SI, AX
    
    ; Display the intake name
    MOV DX, SI
    MOV AH, 09h
    INT 21h
    
    POP SI DX BX AX
    RET
DISPLAY_INTAKE_NAME ENDP

; ========== FIND MATCHING STUDENTS PROCEDURE ==========
FIND_MATCHING_STUDENTS PROC
    PUSH AX BX CX SI DI
    
    ; Clear the matched list
    MOV matched_count, 0
    LEA DI, matched_students
    MOV CX, MAX_STUDENTS
    MOV AL, 255 ; Mark as invalid
    REP STOSB
    
    ; Iterate through all students
    MOV CX, 0 ; Student index
    MOV BL, 0 ; Matched count
    
FMS_LOOP:
    MOV AL, CL
    CMP AL, student_count
    JGE FMS_DONE
    
    ; Check program type
    LEA SI, student_programs
    ADD SI, CX
    MOV AL, [SI]
    CMP AL, filter_program
    JNE FMS_NEXT
    
    ; Check level
    LEA SI, student_levels
    ADD SI, CX
    MOV AL, [SI]
    CMP AL, filter_level
    JNE FMS_NEXT
    
    ; Check year
    LEA SI, student_years
    ADD SI, CX
    MOV AL, [SI]
    CMP AL, filter_year
    JNE FMS_NEXT
    
    ; Check intake
    LEA SI, student_intakes
    ADD SI, CX
    MOV AL, [SI]
    CMP AL, filter_intake
    JNE FMS_NEXT
    
    ; Check semester
    LEA SI, student_semesters
    ADD SI, CX
    MOV AL, [SI]
    CMP AL, filter_semester
    JNE FMS_NEXT
    
    ; Match found, add to list
    LEA SI, matched_students
    MOV AL, BL
    MOV AH, 0
    ADD SI, AX
    MOV [SI], CL ; Store student index
    INC BL
    
FMS_NEXT:
    INC CX
    JMP FMS_LOOP
    
FMS_DONE:
    MOV matched_count, BL
    MOV current_match_idx, 0
    
    POP DI SI CX BX AX
    RET
FIND_MATCHING_STUDENTS ENDP

; ========== DISPLAY CURRENT FILTER PROCEDURE ==========
DISPLAY_CURRENT_FILTER PROC
    PUSH AX BX DX SI
    
    LEA DX, filter_display_msg
    MOV AH, 09h
    INT 21h
    
    ; Display program type
    MOV AL, filter_program
    CALL DISPLAY_PROGRAM_NAME ; DISPLAY_PROGRAM_NAME already handles 1-based to 0-based conversion
    
    ; Display level
    LEA DX, level_label2
    MOV AH, 09h
    INT 21h
    MOV AL, filter_level
    MOV AH, 0 ; Clear AH for DISPLAY_NUMBER
    CALL DISPLAY_NUMBER
    
    ; Display year
    LEA DX, year_label2
    MOV AH, 09h
    INT 21h
    MOV AL, filter_year
    MOV AH, 0 ; Clear AH for DISPLAY_NUMBER
    CALL DISPLAY_NUMBER
    
    ; Display intake
    LEA DX, intake_label2
    MOV AH, 09h
    INT 21h
    MOV AL, filter_intake
    CALL DISPLAY_INTAKE_NAME ; DISPLAY_INTAKE_NAME already handles 1-based to 0-based conversion
    
    ; Display semester
    LEA DX, semester_label2
    MOV AH, 09h
    INT 21h
    MOV AL, filter_semester
    MOV AH, 0 ; Clear AH for DISPLAY_NUMBER
    CALL DISPLAY_NUMBER
    
    LEA DX, newline
    MOV AH, 09h
    INT 21h
    
    POP SI DX BX AX
    RET
DISPLAY_CURRENT_FILTER ENDP


; ========== UPDATE STUDENT RESULT PROCEDURE ==========

UPDATE_STUDENT_RESULT PROC
    PUSH AX BX CX DX SI DI
    
    ; Check if there are any student records
    MOV AL, student_count
    CMP AL, 0
    JNE USR_HAS_RECORDS
    
    ; No records found
    LEA DX, no_records_msg
    MOV AH, 09h
    INT 21h
    JMP USR_DONE
    
USR_HAS_RECORDS:
    ; Get filter criteria to find students
    CALL CLEAR_SCREEN
    LEA DX, update_filter_msg
    MOV AH, 09h
    INT 21h
    
    CALL GET_PROGRAM_SELECTION
    CALL GET_LEVEL_SELECTION
    CALL GET_YEAR_INPUT
    CALL GET_INTAKE_SELECTION
    CALL GET_SEMESTER_SELECTION
    
    ; Find matching students
    CALL FIND_MATCHING_STUDENTS
    
    ; Check if any matches were found
    MOV AL, matched_count
    CMP AL, 0
    JNE USR_HAS_MATCHES
    
    CALL CLEAR_SCREEN
    LEA DX, no_match_msg
    MOV AH, 09h
    INT 21h
    JMP USR_DONE
    
USR_HAS_MATCHES:
    ; If only one match, select it automatically
    MOV AL, matched_count
    CMP AL, 1
    JE USR_SINGLE_MATCH
    
    ; Multiple matches - let user select
    CALL SELECT_STUDENT_FROM_MATCHES
    CMP AL, 255  ; User cancelled selection
    JE USR_DONE
    MOV update_student_idx, AL
    JMP USR_PROCEED_UPDATE
    
USR_SINGLE_MATCH:
    ; Get the student index from matched_students[0]
    LEA SI, matched_students
    MOV AL, [SI]
    MOV update_student_idx, AL
    
USR_PROCEED_UPDATE:
    ; Display current student info and get confirmation
    CALL DISPLAY_UPDATE_CONFIRMATION
    CMP AL, 0  ; User cancelled
    JE USR_DONE
    
    ; Show update menu
    CALL SHOW_UPDATE_MENU
    
USR_DONE:
    POP DI SI DX CX BX AX
    RET
UPDATE_STUDENT_RESULT ENDP

; ========== SELECT STUDENT FROM MATCHES ==========
SELECT_STUDENT_FROM_MATCHES PROC
    PUSH BX CX DX SI DI
    
    MOV current_match_idx, 0
    
SSM_DISPLAY_LOOP:
    CALL CLEAR_SCREEN
    LEA DX, select_student_header
    MOV AH, 09h
    INT 21h
    
    ; Display filter criteria
    CALL DISPLAY_CURRENT_FILTER
    
    ; Show current selection
    LEA DX, select_prompt_msg
    MOV AH, 09h
    INT 21h
    MOV AL, current_match_idx
    INC AL
    MOV AH, 0
    CALL DISPLAY_NUMBER
    
    LEA DX, of_msg
    MOV AH, 09h
    INT 21h
    MOV AL, matched_count
    MOV AH, 0
    CALL DISPLAY_NUMBER
    
    LEA DX, student_sep
    MOV AH, 09h
    INT 21h
    
    ; Get actual student index
    LEA SI, matched_students
    MOV BL, current_match_idx
    MOV BH, 0
    ADD SI, BX
    MOV BL, [SI]  ; BL = actual student index
    
    ; Display student basic info
    LEA DX, id_label
    MOV AH, 09h
    INT 21h
    MOV AL, BL
    MOV AH, 0
    MOV CL, 10
    MUL CL
    LEA SI, student_ids
    ADD SI, AX
    MOV DX, SI
    MOV AH, 09h
    INT 21h
    
    LEA DX, name_label
    MOV AH, 09h
    INT 21h
    MOV AL, BL
    MOV AH, 0
    MOV CL, 30
    MUL CL
    LEA SI, student_names
    ADD SI, AX
    MOV DX, SI
    MOV AH, 09h
    INT 21h
    
    ; Show selection options
    LEA DX, select_options_msg
    MOV AH, 09h
    INT 21h
    
    MOV AH, 01h
    INT 21h
    
    CMP AL, 'S'
    JE SSM_SELECT
    CMP AL, 's'
    JE SSM_SELECT
    CMP AL, 'N'
    JE SSM_NEXT
    CMP AL, 'n'
    JE SSM_NEXT
    CMP AL, 'P'
    JE SSM_PREV
    CMP AL, 'p'
    JE SSM_PREV
    CMP AL, 'Q'
    JE SSM_QUIT
    CMP AL, 'q'
    JE SSM_QUIT
    CMP AL, 27  ; ESC
    JE SSM_QUIT
    
    JMP SSM_DISPLAY_LOOP
    
SSM_SELECT:
    ; Return the actual student index
    LEA SI, matched_students
    MOV BL, current_match_idx
    MOV BH, 0
    ADD SI, BX
    MOV AL, [SI]
    JMP SSM_DONE
    
SSM_NEXT:
    MOV AL, current_match_idx
    INC AL
    CMP AL, matched_count
    JL SSM_NEXT_OK
    MOV AL, 0
SSM_NEXT_OK:
    MOV current_match_idx, AL
    JMP SSM_DISPLAY_LOOP
    
SSM_PREV:
    MOV AL, current_match_idx
    CMP AL, 0
    JG SSM_PREV_OK
    MOV AL, matched_count
    DEC AL
    JMP SSM_PREV_SET
SSM_PREV_OK:
    DEC AL
SSM_PREV_SET:
    MOV current_match_idx, AL
    JMP SSM_DISPLAY_LOOP
    
SSM_QUIT:
    MOV AL, 255  ; Cancel signal
    
SSM_DONE:
    POP DI SI DX CX BX
    RET
SELECT_STUDENT_FROM_MATCHES ENDP

; ========== DISPLAY UPDATE CONFIRMATION ==========
DISPLAY_UPDATE_CONFIRMATION PROC
    PUSH BX CX DX SI DI
    
    CALL CLEAR_SCREEN
    LEA DX, update_confirm_header
    MOV AH, 09h
    INT 21h
    
    ; Get student index
    MOV BL, update_student_idx
    MOV BH, 0
    
    ; Display student info
    LEA DX, id_label
    MOV AH, 09h
    INT 21h
    MOV AL, BL
    MOV AH, 0
    MOV CL, 10
    MUL CL
    LEA SI, student_ids
    ADD SI, AX
    MOV DX, SI
    MOV AH, 09h
    INT 21h
    
    LEA DX, name_label
    MOV AH, 09h
    INT 21h
    MOV AL, BL
    MOV AH, 0
    MOV CL, 30
    MUL CL
    LEA SI, student_names
    ADD SI, AX
    MOV DX, SI
    MOV AH, 09h
    INT 21h
    
    ; Display current scores
    LEA DX, current_scores_header
    MOV AH, 09h
    INT 21h
    
    MOV current_subject, 0
    
DUC_SCORE_LOOP:
    LEA DX, newline
    MOV AH, 09h
    INT 21h
    
    MOV AL, current_subject
    CALL DISPLAY_SUBJECT_NAME
    
    MOV AL, BL  ; Student index
    MOV AH, 0
    MOV CL, MAX_SUBJECTS
    MUL CL
    ADD AL, current_subject
    MOV AH, 0
    MOV DI, AX
    
    LEA DX, score_display
    MOV AH, 09h
    INT 21h
    LEA SI, student_scores
    ADD SI, DI
    MOV AL, [SI]
    MOV AH, 0
    CALL DISPLAY_NUMBER
    
    LEA DX, grade_display
    MOV AH, 09h
    INT 21h
    LEA SI, student_grades
    ADD SI, DI
    MOV DL, [SI]
    MOV AH, 02h
    INT 21h
    
    INC current_subject
    MOV AL, current_subject
    CMP AL, MAX_SUBJECTS
    JL DUC_SCORE_LOOP
    
    ; Show average
    LEA DX, avg_label
    MOV AH, 09h
    INT 21h
    MOV AL, BL
    MOV AH, 0
    LEA SI, student_averages
    ADD SI, AX
    MOV AL, [SI]
    MOV AH, 0
    CALL DISPLAY_NUMBER
    
    LEA DX, overall_label
    MOV AH, 09h
    INT 21h
    
    ; Get overall grade and average
    LEA SI, student_overall_grades
    MOV AL, BL
    MOV AH, 0
    ADD SI, AX
    MOV DL, [SI]     ; DL = grade char
    
    LEA SI, student_averages
    MOV AL, BL
    MOV AH, 0
    ADD SI, AX
    MOV CL, [SI]     ; CL = average score
    
    ; Determine if blinking needed
    MOV AL, 0        ; Default: no blink
    CMP DL, 'A'
    JNE UC_CHECK_LOW
    MOV CH, 8Ah      ; Blinking bright green (1000 1010b: blink=1, fg=10 green, bg=0 black)
    MOV AL, 1        ; Enable blink
    JMP UC_DISPLAY_GRADE

UC_CHECK_LOW:
    CMP CL, 50
    JGE UC_NORMAL_DISPLAY
    MOV CH, 8Ch      ; Blinking bright red (1000 1100b: blink=1, fg=12 red, bg=0 black)
    MOV AL, 1        ; Enable blink
    JMP UC_DISPLAY_GRADE

UC_NORMAL_DISPLAY:
    MOV AH, 02h      ; Normal display without blink
    INT 21h
    JMP UC_GRADE_DONE

UC_DISPLAY_GRADE:
    PUSH BX
    CALL TOGGLE_BLINK  ; Enable/disable blink (AL=1 or 0)
    MOV BL, CH         ; BL = attribute
    MOV BH, 0          ; Page 0
    MOV AH, 09h        ; AH=09h (write char with attribute)
    MOV AL, DL         ; AL = char to display
    MOV CX, 1          ; One char
    INT 10h
    MOV AL, 0          ; Disable blink after display
    CALL TOGGLE_BLINK
    POP BX

UC_GRADE_DONE:
    
    ; Confirmation prompt
    LEA DX, update_confirm_prompt
    MOV AH, 09h
    INT 21h
    
    MOV AH, 01h
    INT 21h
    
    CMP AL, 'Y'
    JE DUC_CONFIRM
    CMP AL, 'y'
    JE DUC_CONFIRM
    MOV AL, 0  ; Cancel
    JMP DUC_DONE
    
DUC_CONFIRM:
    MOV AL, 1  ; Proceed
    
DUC_DONE:
    POP DI SI DX CX BX
    RET
DISPLAY_UPDATE_CONFIRMATION ENDP

; ========== SHOW UPDATE MENU ==========
SHOW_UPDATE_MENU PROC
    PUSH AX BX CX DX SI DI
    
SUM_LOOP:
    CALL CLEAR_SCREEN
    LEA DX, update_menu_header
    MOV AH, 09h
    INT 21h
    
    ; Show student info briefly
    MOV BL, update_student_idx
    LEA DX, updating_student_msg
    MOV AH, 09h
    INT 21h
    MOV AL, BL
    MOV AH, 0
    MOV CL, 10
    MUL CL
    LEA SI, student_ids
    ADD SI, AX
    MOV DX, SI
    MOV AH, 09h
    INT 21h
    
    LEA DX, update_menu_options
    MOV AH, 09h
    INT 21h
    
    MOV AH, 01h
    INT 21h
    
    CMP AL, '1'
    JE SUM_UPDATE_SINGLE
    CMP AL, '2'
    JE SUM_UPDATE_ALL
    CMP AL, '3'
    JE SUM_UPDATE_INFO
    CMP AL, '4'
    JE SUM_BACK
    
    JMP SUM_LOOP
    
SUM_UPDATE_SINGLE:
    CALL UPDATE_SINGLE_SUBJECT
    JMP SUM_LOOP
    
SUM_UPDATE_ALL:
    CALL UPDATE_ALL_SUBJECTS
    JMP SUM_LOOP
    
SUM_UPDATE_INFO:
    CALL UPDATE_STUDENT_INFO
    JMP SUM_LOOP
    
SUM_BACK:
    JMP SUM_DONE
    
SUM_DONE:
    POP DI SI DX CX BX AX
    RET
SHOW_UPDATE_MENU ENDP

; ========== UPDATE SINGLE SUBJECT ==========
UPDATE_SINGLE_SUBJECT PROC
    PUSH AX BX CX DX SI DI
    
    CALL CLEAR_SCREEN
    LEA DX, select_subject_header
    MOV AH, 09h
    INT 21h
    
    ; Display subjects with numbers
    MOV CX, 0
    
USS_DISPLAY_SUBJECTS:
    MOV AL, CL
    INC AL
    MOV AH, 0
    CALL DISPLAY_NUMBER
    
    LEA DX, dot_space_msg
    MOV AH, 09h
    INT 21h
    
    MOV AL, CL
    CALL DISPLAY_SUBJECT_NAME
    
    LEA DX, newline
    MOV AH, 09h
    INT 21h
    
    INC CX
    CMP CX, MAX_SUBJECTS
    JL USS_DISPLAY_SUBJECTS
    
    LEA DX, select_subject_prompt
    MOV AH, 09h
    INT 21h
    
    MOV AH, 01h
    INT 21h
    
    CMP AL, '1'
    JL USS_INVALID
    CMP AL, '5'
    JG USS_INVALID
    
    SUB AL, '1'  ; Convert to 0-based index
    MOV current_subject, AL
    
    ; Show current score
    LEA DX, current_score_msg
    MOV AH, 09h
    INT 21h
    
    MOV AL, current_subject
    CALL DISPLAY_SUBJECT_NAME
    
    LEA DX, colon_space_msg
    MOV AH, 09h
    INT 21h
    
    ; Calculate score index
    MOV AL, update_student_idx
    MOV AH, 0
    MOV BL, MAX_SUBJECTS
    MUL BL
    ADD AL, current_subject
    MOV AH, 0
    MOV BX, AX
    
    LEA SI, student_scores
    ADD SI, BX
    MOV AL, [SI]
    MOV AH, 0
    CALL DISPLAY_NUMBER
    
    ; Get new score
    LEA DX, new_score_prompt
    MOV AH, 09h
    INT 21h
    
    CALL GET_NUMERIC_INPUT
    MOV temp_score, AL
    
    ; Update the score
    MOV [SI], AL
    
    ; Recalculate grade for this subject
    CALL CALCULATE_GRADE
    LEA SI, student_grades
    ADD SI, BX
    MOV [SI], AL
    
    ; Recalculate average and overall grade
    CALL RECALCULATE_STUDENT_AVERAGE
    
    LEA DX, score_updated_msg
    MOV AH, 09h
    INT 21h
    
    LEA DX, press_key_msg
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    
    JMP USS_DONE
    
USS_INVALID:
    LEA DX, invalid_option_msg
    MOV AH, 09h
    INT 21h
    LEA DX, press_key_msg
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    
USS_DONE:
    POP DI SI DX CX BX AX
    RET
UPDATE_SINGLE_SUBJECT ENDP

; ========== UPDATE ALL SUBJECTS ==========
UPDATE_ALL_SUBJECTS PROC
    PUSH AX BX CX DX SI DI
    
    CALL CLEAR_SCREEN
    LEA DX, update_all_header
    MOV AH, 09h
    INT 21h
    
    MOV temp_sum, 0
    MOV current_subject, 0
    
UAS_LOOP:
    ; Display current subject
    LEA DX, score_prompt1
    MOV AH, 09h
    INT 21h
    
    MOV AL, current_subject
    CALL DISPLAY_SUBJECT_NAME
    
    ; Show current score
    LEA DX, current_score_bracket
    MOV AH, 09h
    INT 21h
    
    ; Calculate current score index
    MOV AL, update_student_idx
    MOV AH, 0
    MOV BL, MAX_SUBJECTS
    MUL BL
    ADD AL, current_subject
    MOV AH, 0
    MOV BX, AX
    
    LEA SI, student_scores
    ADD SI, BX
    MOV AL, [SI]
    MOV AH, 0
    CALL DISPLAY_NUMBER
    
    LEA DX, score_prompt2
    MOV AH, 09h
    INT 21h
    
    CALL GET_NUMERIC_INPUT
    MOV temp_score, AL
    
    ; Update score
    MOV [SI], AL
    
    ; Add to sum for average calculation
    MOV AH, 0
    ADD temp_sum, AX
    
    ; Update grade
    CALL CALCULATE_GRADE
    LEA SI, student_grades
    ADD SI, BX
    MOV [SI], AL
    
    INC current_subject
    MOV AL, current_subject
    CMP AL, MAX_SUBJECTS
    JL UAS_LOOP
    
    ; Update average
    MOV AX, temp_sum
    MOV CL, MAX_SUBJECTS
    MOV CH, 0
    DIV CL
    MOV BL, update_student_idx
    MOV BH, 0
    LEA SI, student_averages
    ADD SI, BX
    MOV [SI], AL
    
    ; Update overall grade
    MOV temp_score, AL
    CALL CALCULATE_GRADE
    LEA SI, student_overall_grades
    ADD SI, BX
    MOV [SI], AL
    
    CALL CLEAR_SCREEN
    LEA DX, all_scores_updated_msg
    MOV AH, 09h
    INT 21h
    
    LEA DX, press_key_msg
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    
    POP DI SI DX CX BX AX
    RET
UPDATE_ALL_SUBJECTS ENDP

; ========== UPDATE STUDENT INFO ==========
UPDATE_STUDENT_INFO PROC
    PUSH AX BX CX DX SI DI
    
    CALL CLEAR_SCREEN
    LEA DX, update_info_header
    MOV AH, 09h
    INT 21h
    
    ; Show current info
    MOV BL, update_student_idx
    
    LEA DX, current_id_msg
    MOV AH, 09h
    INT 21h
    MOV AL, BL
    MOV AH, 0
    MOV CL, 10
    MUL CL
    LEA SI, student_ids
    ADD SI, AX
    MOV DX, SI
    MOV AH, 09h
    INT 21h
    
    LEA DX, current_name_msg
    MOV AH, 09h
    INT 21h
    MOV AL, BL
    MOV AH, 0
    MOV CL, 30
    MUL CL
    LEA SI, student_names
    ADD SI, AX
    MOV DX, SI
    MOV AH, 09h
    INT 21h
    
    ; Update ID
    LEA DX, new_id_prompt
    MOV AH, 09h
    INT 21h
    MOV AL, BL
    MOV AH, 0
    MOV CL, 10
    MUL CL
    LEA DI, student_ids
    ADD DI, AX
    MOV DX, DI
    CALL GET_INPUT
    
    ; Update Name
    LEA DX, new_name_prompt
    MOV AH, 09h
    INT 21h
    MOV AL, BL
    MOV AH, 0
    MOV CL, 30
    MUL CL
    LEA DI, student_names
    ADD DI, AX
    MOV DX, DI
    CALL GET_INPUT
    
    LEA DX, info_updated_msg
    MOV AH, 09h
    INT 21h
    
    LEA DX, press_key_msg
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    
    POP DI SI DX CX BX AX
    RET
UPDATE_STUDENT_INFO ENDP

; ========== RECALCULATE STUDENT AVERAGE ==========
RECALCULATE_STUDENT_AVERAGE PROC
    PUSH AX BX CX DX SI DI
    
    MOV BL, update_student_idx
    MOV BH, 0
    
    ; Calculate sum of all scores
    MOV temp_sum, 0
    MOV CX, 0
    
RSA_LOOP:
    MOV AL, BL
    MOV AH, 0
    MOV DL, MAX_SUBJECTS
    MUL DL
    ADD AL, CL
    MOV AH, 0
    MOV DI, AX
    
    LEA SI, student_scores
    ADD SI, DI
    MOV AL, [SI]
    MOV AH, 0
    ADD temp_sum, AX
    
    INC CX
    CMP CX, MAX_SUBJECTS
    JL RSA_LOOP
    
    ; Calculate average
    MOV AX, temp_sum
    MOV CL, MAX_SUBJECTS
    MOV CH, 0
    DIV CL
    
    ; Update average
    LEA SI, student_averages
    ADD SI, BX
    MOV [SI], AL
    
    ; Update overall grade
    MOV temp_score, AL
    CALL CALCULATE_GRADE
    LEA SI, student_overall_grades
    ADD SI, BX
    MOV [SI], AL
    
    POP DI SI DX CX BX AX
    RET
RECALCULATE_STUDENT_AVERAGE ENDP


; ========== DELETE STUDENT RESULT PROCEDURE ==========

DELETE_STUDENT_RESULT PROC
    PUSH AX BX CX DX SI DI
    
    ; Check if there are any student records
    MOV AL, student_count
    CMP AL, 0
    JNE DSR_HAS_RECORDS
    
    ; No records found
    LEA DX, no_records_msg
    MOV AH, 09h
    INT 21h
    JMP DSR_DONE
    
DSR_HAS_RECORDS:
    ; Get filter criteria to find students
    CALL CLEAR_SCREEN
    LEA DX, delete_filter_msg
    MOV AH, 09h
    INT 21h
    
    CALL GET_PROGRAM_SELECTION
    CALL GET_LEVEL_SELECTION
    CALL GET_YEAR_INPUT
    CALL GET_INTAKE_SELECTION
    CALL GET_SEMESTER_SELECTION
    
    ; Find matching students
    CALL FIND_MATCHING_STUDENTS
    
    ; Check if any matches were found
    MOV AL, matched_count
    CMP AL, 0
    JNE DSR_HAS_MATCHES
    
    CALL CLEAR_SCREEN
    LEA DX, no_match_msg
    MOV AH, 09h
    INT 21h
    JMP DSR_DONE
    
DSR_HAS_MATCHES:
    ; If only one match, select it automatically
    MOV AL, matched_count
    CMP AL, 1
    JE DSR_SINGLE_MATCH
    
    ; Multiple matches - let user select
    CALL SELECT_STUDENT_FOR_DELETE
    CMP AL, 255  ; User cancelled selection
    JE DSR_DONE
    MOV delete_student_idx, AL
    JMP DSR_PROCEED_DELETE
    
DSR_SINGLE_MATCH:
    ; Get the student index from matched_students[0]
    LEA SI, matched_students
    MOV AL, [SI]
    MOV delete_student_idx, AL
    
DSR_PROCEED_DELETE:
    ; Display current student info and get confirmation
    CALL DISPLAY_DELETE_CONFIRMATION
    CMP AL, 0  ; User cancelled
    JE DSR_DONE
    
    ; Perform the deletion
    CALL PERFORM_STUDENT_DELETION
    
DSR_DONE:
    POP DI SI DX CX BX AX
    RET
DELETE_STUDENT_RESULT ENDP

; ========== SELECT STUDENT FOR DELETE ==========
SELECT_STUDENT_FOR_DELETE PROC
    PUSH BX CX DX SI DI
    
    MOV current_match_idx, 0
    
SSD_DISPLAY_LOOP:
    CALL CLEAR_SCREEN
    LEA DX, select_delete_header
    MOV AH, 09h
    INT 21h
    
    ; Display filter criteria
    CALL DISPLAY_CURRENT_FILTER
    
    ; Show current selection
    LEA DX, select_prompt_msg
    MOV AH, 09h
    INT 21h
    MOV AL, current_match_idx
    INC AL
    MOV AH, 0
    CALL DISPLAY_NUMBER
    
    LEA DX, of_msg
    MOV AH, 09h
    INT 21h
    MOV AL, matched_count
    MOV AH, 0
    CALL DISPLAY_NUMBER
    
    LEA DX, student_sep
    MOV AH, 09h
    INT 21h
    
    ; Get actual student index
    LEA SI, matched_students
    MOV BL, current_match_idx
    MOV BH, 0
    ADD SI, BX
    MOV BL, [SI]  ; BL = actual student index
    
    ; Display student basic info
    LEA DX, id_label
    MOV AH, 09h
    INT 21h
    MOV AL, BL
    MOV AH, 0
    MOV CL, 10
    MUL CL
    LEA SI, student_ids
    ADD SI, AX
    MOV DX, SI
    MOV AH, 09h
    INT 21h
    
    LEA DX, name_label
    MOV AH, 09h
    INT 21h
    MOV AL, BL
    MOV AH, 0
    MOV CL, 30
    MUL CL
    LEA SI, student_names
    ADD SI, AX
    MOV DX, SI
    MOV AH, 09h
    INT 21h
    
    ; Display current scores summary
    LEA DX, avg_label
    MOV AH, 09h
    INT 21h
    MOV AL, BL
    MOV AH, 0
    LEA SI, student_averages
    ADD SI, AX
    MOV AL, [SI]
    MOV AH, 0
    CALL DISPLAY_NUMBER
    
    LEA DX, overall_label
    MOV AH, 09h
    INT 21h
    LEA SI, student_overall_grades
    MOV AL, BL
    MOV AH, 0
    ADD SI, AX
    MOV DL, [SI]
    MOV AH, 02h
    INT 21h
    
    ; Show selection options for delete
    LEA DX, delete_select_options
    MOV AH, 09h
    INT 21h
    
    MOV AH, 01h
    INT 21h
    
    CMP AL, 'D'
    JE SSD_SELECT
    CMP AL, 'd'
    JE SSD_SELECT
    CMP AL, 'N'
    JE SSD_NEXT
    CMP AL, 'n'
    JE SSD_NEXT
    CMP AL, 'P'
    JE SSD_PREV
    CMP AL, 'p'
    JE SSD_PREV
    CMP AL, 'Q'
    JE SSD_QUIT
    CMP AL, 'q'
    JE SSD_QUIT
    CMP AL, 27  ; ESC
    JE SSD_QUIT
    
    JMP SSD_DISPLAY_LOOP
    
SSD_SELECT:
    ; Return the actual student index
    LEA SI, matched_students
    MOV BL, current_match_idx
    MOV BH, 0
    ADD SI, BX
    MOV AL, [SI]
    JMP SSD_DONE
    
SSD_NEXT:
    MOV AL, current_match_idx
    INC AL
    CMP AL, matched_count
    JL SSD_NEXT_OK
    MOV AL, 0
SSD_NEXT_OK:
    MOV current_match_idx, AL
    JMP SSD_DISPLAY_LOOP
    
SSD_PREV:
    MOV AL, current_match_idx
    CMP AL, 0
    JG SSD_PREV_OK
    MOV AL, matched_count
    DEC AL
    JMP SSD_PREV_SET
SSD_PREV_OK:
    DEC AL
SSD_PREV_SET:
    MOV current_match_idx, AL
    JMP SSD_DISPLAY_LOOP
    
SSD_QUIT:
    MOV AL, 255  ; Cancel signal
    
SSD_DONE:
    POP DI SI DX CX BX
    RET
SELECT_STUDENT_FOR_DELETE ENDP

; ========== DISPLAY DELETE CONFIRMATION ==========
DISPLAY_DELETE_CONFIRMATION PROC
    PUSH BX CX DX SI DI
    
    CALL CLEAR_SCREEN
    LEA DX, delete_confirm_header
    MOV AH, 09h
    INT 21h
    
    ; Get student index
    MOV BL, delete_student_idx
    MOV BH, 0
    
    ; Display student info
    LEA DX, id_label
    MOV AH, 09h
    INT 21h
    MOV AL, BL
    MOV AH, 0
    MOV CL, 10
    MUL CL
    LEA SI, student_ids
    ADD SI, AX
    MOV DX, SI
    MOV AH, 09h
    INT 21h
    
    LEA DX, name_label
    MOV AH, 09h
    INT 21h
    MOV AL, BL
    MOV AH, 0
    MOV CL, 30
    MUL CL
    LEA SI, student_names
    ADD SI, AX
    MOV DX, SI
    MOV AH, 09h
    INT 21h
    
    ; Display classification info
    LEA DX, newline
    MOV AH, 09h
    INT 21h
    LEA DX, filter_display_msg
    MOV AH, 09h
    INT 21h

    MOV AL, BL
    MOV AH, 0
    MOV BX, AX ; BX now holds student index
    
    LEA SI, student_programs
    ADD SI, BX
    MOV AL, [SI]
    CALL DISPLAY_PROGRAM_NAME
    
    LEA DX, level_label2
    MOV AH, 09h
    INT 21h
    LEA SI, student_levels
    ADD SI, BX
    MOV AL, [SI]
    MOV AH, 0
    CALL DISPLAY_NUMBER

    LEA DX, year_label2
    MOV AH, 09h
    INT 21h
    LEA SI, student_years
    ADD SI, BX
    MOV AL, [SI]
    MOV AH, 0
    CALL DISPLAY_NUMBER

    LEA DX, intake_label2
    MOV AH, 09h
    INT 21h
    LEA SI, student_intakes
    ADD SI, BX
    MOV AL, [SI]
    CALL DISPLAY_INTAKE_NAME

    LEA DX, semester_label2
    MOV AH, 09h
    INT 21h
    LEA SI, student_semesters
    ADD SI, BX
    MOV AL, [SI]
    MOV AH, 0
    CALL DISPLAY_NUMBER
    
    ; Display current scores summary
    LEA DX, current_scores_header
    MOV AH, 09h
    INT 21h
    
    MOV current_subject, 0
    
DDC_SCORE_LOOP:
    LEA DX, newline
    MOV AH, 09h
    INT 21h
    
    MOV AL, current_subject
    CALL DISPLAY_SUBJECT_NAME
    
    MOV AL, BL  ; Student index
    MOV AH, 0
    MOV CL, MAX_SUBJECTS
    MUL CL
    ADD AL, current_subject
    MOV AH, 0
    MOV DI, AX
    
    LEA DX, score_display
    MOV AH, 09h
    INT 21h
    LEA SI, student_scores
    ADD SI, DI
    MOV AL, [SI]
    MOV AH, 0
    CALL DISPLAY_NUMBER
    
    LEA DX, grade_display
    MOV AH, 09h
    INT 21h
    LEA SI, student_grades
    ADD SI, DI
    MOV DL, [SI]
    MOV AH, 02h
    INT 21h
    
    INC current_subject
    MOV AL, current_subject
    CMP AL, MAX_SUBJECTS
    JL DDC_SCORE_LOOP
    
    ; Show average and overall grade
    LEA DX, avg_label
    MOV AH, 09h
    INT 21h
    MOV AL, BL
    MOV AH, 0
    LEA SI, student_averages
    ADD SI, AX
    MOV AL, [SI]
    MOV AH, 0
    CALL DISPLAY_NUMBER
    
    LEA DX, overall_label
    MOV AH, 09h
    INT 21h
    LEA SI, student_overall_grades
    MOV AL, BL
    MOV AH, 0
    ADD SI, AX
    MOV DL, [SI]
    MOV AH, 02h
    INT 21h
    
    ; Warning and confirmation prompt
    LEA DX, delete_warning_msg
    MOV AH, 09h
    INT 21h
    
    LEA DX, delete_confirm_prompt
    MOV AH, 09h
    INT 21h
    
    MOV AH, 01h
    INT 21h
    
    CMP AL, 'Y'
    JE DDC_CONFIRM
    CMP AL, 'y'
    JE DDC_CONFIRM
    MOV AL, 0  ; Cancel
    JMP DDC_DONE
    
DDC_CONFIRM:
    ; Double confirmation
    LEA DX, delete_final_confirm
    MOV AH, 09h
    INT 21h
    
    MOV AH, 01h
    INT 21h
    
    CMP AL, 'Y'
    JE DDC_FINAL_CONFIRM
    CMP AL, 'y'
    JE DDC_FINAL_CONFIRM
    MOV AL, 0  ; Cancel
    JMP DDC_DONE
    
DDC_FINAL_CONFIRM:
    MOV AL, 1  ; Proceed with deletion
    
DDC_DONE:
    POP DI SI DX CX BX
    RET
DISPLAY_DELETE_CONFIRMATION ENDP

; ========== PERFORM STUDENT DELETION ==========
PERFORM_STUDENT_DELETION PROC
    PUSH AX BX CX DX SI DI
    
    MOV BL, delete_student_idx
    MOV BH, 0
    
    ; Check if this is the last student
    MOV AL, student_count
    CMP AL, 1
    JE PSD_LAST_STUDENT
    
    ; Check if deleting the last student in array
    MOV AL, BL
    MOV CL, student_count
    DEC CL
    CMP AL, CL
    JE PSD_DELETE_LAST
    
    ; Need to shift all students after this one
    CALL SHIFT_STUDENTS_LEFT
    JMP PSD_FINISH
    
PSD_DELETE_LAST:
    ; Just clear the last student's data
    CALL CLEAR_STUDENT_DATA
    JMP PSD_FINISH
    
PSD_LAST_STUDENT:
    ; Clear the only student's data
    CALL CLEAR_STUDENT_DATA
    
PSD_FINISH:
    ; Decrease student count
    DEC student_count
    
    ; Show success message
    CALL CLEAR_SCREEN
    LEA DX, delete_success_msg
    MOV AH, 09h
    INT 21h
    
    ; Show updated count
    LEA DX, remaining_students_msg
    MOV AH, 09h
    INT 21h
    MOV AL, student_count
    MOV AH, 0
    CALL DISPLAY_NUMBER
    
    LEA DX, press_key_msg
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    
    POP DI SI DX CX BX AX
    RET
PERFORM_STUDENT_DELETION ENDP

; ========== SHIFT STUDENTS LEFT ==========
SHIFT_STUDENTS_LEFT PROC
    PUSH AX BX CX DX SI DI
    
    MOV BL, delete_student_idx
    MOV BH, 0
    MOV CL, student_count
    
SSL_LOOP:
    ; Check if we've reached the end
    MOV AL, BL
    INC AL
    CMP AL, CL
    JGE SSL_DONE
    
    ; Copy student data in blocks to reduce code size
    CALL COPY_STUDENT_DATA
    
    ; Move to next student
    INC BL
    JMP SSL_LOOP
    
SSL_DONE:
    ; Clear the last student's data
    MOV BL, CL
    DEC BL
    CALL CLEAR_STUDENT_DATA
    
    POP DI SI DX CX BX AX
    RET
SHIFT_STUDENTS_LEFT ENDP

; New helper procedure to copy student data
COPY_STUDENT_DATA PROC
    PUSH AX BX CX DX SI DI
    
    ; Copy student ID
    MOV AL, BL
    INC AL  ; Source index (next student)
    MOV AH, 0
    MOV DL, 10
    MUL DL
    LEA SI, student_ids
    ADD SI, AX  ; SI points to source ID
    
    MOV AL, BL  ; Destination index
    MOV AH, 0
    MOV DL, 10
    MUL DL
    LEA DI, student_ids
    ADD DI, AX  ; DI points to destination ID
    
    ; Copy 10 bytes for ID
    MOV CX, 10
    REP MOVSB
    
    ; Copy student name
    MOV AL, BL
    INC AL  ; Source index
    MOV AH, 0
    MOV DL, 30
    MUL DL
    LEA SI, student_names
    ADD SI, AX  ; SI points to source name
    
    MOV AL, BL  ; Destination index
    MOV AH, 0
    MOV DL, 30
    MUL DL
    LEA DI, student_names
    ADD DI, AX  ; DI points to destination name
    
    ; Copy 30 bytes for name
    MOV CX, 30
    REP MOVSB
    
    ; Copy classification data
    CALL COPY_CLASSIFICATION_DATA
    
    ; Copy scores and grades
    CALL COPY_SCORES_AND_GRADES
    
    ; Copy averages
    CALL COPY_AVERAGES_DATA
    
    POP DI SI DX CX BX AX
    RET
COPY_STUDENT_DATA ENDP

COPY_CLASSIFICATION_DATA PROC
    PUSH AX DX SI DI
    
    MOV AL, BL
    INC AL
    MOV AH, 0
    LEA SI, student_programs
    ADD SI, AX
    MOV DL, [SI]
    LEA DI, student_programs
    MOV AL, BL
    MOV AH, 0
    ADD DI, AX
    MOV [DI], DL
    
    MOV AL, BL
    INC AL
    MOV AH, 0
    LEA SI, student_levels
    ADD SI, AX
    MOV DL, [SI]
    LEA DI, student_levels
    MOV AL, BL
    MOV AH, 0
    ADD DI, AX
    MOV [DI], DL
    
    MOV AL, BL
    INC AL
    MOV AH, 0
    LEA SI, student_years
    ADD SI, AX
    MOV DL, [SI]
    LEA DI, student_years
    MOV AL, BL
    MOV AH, 0
    ADD DI, AX
    MOV [DI], DL
    
    MOV AL, BL
    INC AL
    MOV AH, 0
    LEA SI, student_intakes
    ADD SI, AX
    MOV DL, [SI]
    LEA DI, student_intakes
    MOV AL, BL
    MOV AH, 0
    ADD DI, AX
    MOV [DI], DL
    
    MOV AL, BL
    INC AL
    MOV AH, 0
    LEA SI, student_semesters
    ADD SI, AX
    MOV DL, [SI]
    LEA DI, student_semesters
    MOV AL, BL
    MOV AH, 0
    ADD DI, AX
    MOV [DI], DL
    
    POP DI SI DX AX
    RET
COPY_CLASSIFICATION_DATA ENDP

COPY_SCORES_AND_GRADES PROC
    PUSH AX CX DX SI DI
    
    MOV CX, 0  ; Subject counter
    
CSG_LOOP:
    ; Calculate source score index
    MOV AL, BL
    INC AL  ; Next student
    MOV AH, 0
    MOV DL, MAX_SUBJECTS
    MUL DL
    ADD AL, CL
    MOV AH, 0
    LEA SI, student_scores
    ADD SI, AX
    MOV DL, [SI]  ; Get source score
    
    ; Calculate destination score index
    MOV AL, BL  ; Current position
    MOV AH, 0
    MOV AL, BL
    MOV AH, 0
    MOV DL, MAX_SUBJECTS
    MUL DL
    ADD AL, CL
    MOV AH, 0
    LEA DI, student_scores
    ADD DI, AX
    MOV [DI], DL  ; Store score
    
    ; Copy grade
    MOV AL, BL
    INC AL
    MOV AH, 0
    MOV DL, MAX_SUBJECTS
    MUL DL
    ADD AL, CL
    MOV AH, 0
    LEA SI, student_grades
    ADD SI, AX
    MOV DL, [SI]  ; Get source grade
    
    MOV AL, BL
    MOV AH, 0
    MOV AL, BL
    MOV AH, 0
    MOV DL, MAX_SUBJECTS
    MUL DL
    ADD AL, CL
    MOV AH, 0
    LEA DI, student_grades
    ADD DI, AX
    MOV [DI], DL  ; Store grade
    
    INC CX
    CMP CX, MAX_SUBJECTS
    JL CSG_LOOP
    
    POP DI SI DX CX AX
    RET
COPY_SCORES_AND_GRADES ENDP

COPY_AVERAGES_DATA PROC
    PUSH AX DX SI DI
    
    ; Copy average
    MOV AL, BL
    INC AL
    MOV AH, 0
    LEA SI, student_averages
    ADD SI, AX
    MOV DL, [SI]
    LEA DI, student_averages
    MOV AL, BL
    MOV AH, 0
    ADD DI, AX
    MOV [DI], DL
    
    ; Copy overall grade
    MOV AL, BL
    INC AL
    MOV AH, 0
    LEA SI, student_overall_grades
    ADD SI, AX
    MOV DL, [SI]
    LEA DI, student_overall_grades
    MOV AL, BL
    MOV AH, 0
    ADD DI, AX
    MOV [DI], DL
    
    POP DI SI DX AX
    RET
COPY_AVERAGES_DATA ENDP

; ========== CLEAR STUDENT DATA ==========
CLEAR_STUDENT_DATA PROC
    PUSH AX BX CX DX SI DI
    
    MOV AL, BL  ; Student index in BL
    MOV AH, 0
    
    ; Clear ID
    MOV DL, 10
    MUL DL
    LEA DI, student_ids
    ADD DI, AX
    MOV CX, 10
    MOV AL, '$'
    REP STOSB
    
    ; Clear name
    MOV AL, BL
    MOV AH, 0
    MOV DL, 30
    MUL DL
    LEA DI, student_names
    ADD DI, AX
    MOV CX, 30
    MOV AL, '$'
    REP STOSB
    
    ; Clear classification data
    MOV AL, BL
    MOV AH, 0
    LEA DI, student_programs
    ADD DI, AX
    MOV BYTE PTR [DI], 0
    
    LEA DI, student_levels
    ADD DI, AX
    MOV BYTE PTR [DI], 0
    
    LEA DI, student_years
    ADD DI, AX
    MOV BYTE PTR [DI], 0
    
    LEA DI, student_intakes
    ADD DI, AX
    MOV BYTE PTR [DI], 0
    
    LEA DI, student_semesters
    ADD DI, AX
    MOV BYTE PTR [DI], 0
    
    ; Clear scores and grades
    PUSH CX
    MOV CX, 0
    
CSD_CLEAR_SCORES:
    MOV AL, BL
    MOV AH, 0
    MOV DL, MAX_SUBJECTS
    MUL DL
    ADD AL, CL
    MOV AH, 0
    
    LEA DI, student_scores
    ADD DI, AX
    MOV BYTE PTR [DI], 0
    
    LEA DI, student_grades
    ADD DI, AX
    MOV BYTE PTR [DI], ' '
    
    INC CX
    CMP CX, MAX_SUBJECTS
    JL CSD_CLEAR_SCORES
    
    POP CX
    
    ; Clear average and overall grade
    MOV AL, BL
    MOV AH, 0
    LEA DI, student_averages
    ADD DI, AX
    MOV BYTE PTR [DI], 0
    
    LEA DI, student_overall_grades
    ADD DI, AX
    MOV BYTE PTR [DI], ' '
    
    POP DI SI DX CX BX AX
    RET
CLEAR_STUDENT_DATA ENDP


; 1. PASSWORD HASHING (Simple XOR hash)
HASH_PASSWORD PROC
    PUSH AX BX CX SI DI
    LEA SI, password_buffer
    LEA DI, hashed_password
    MOV CX, 0
    
HP_LOOP:
    MOV AL, [SI]
    CMP AL, '$'
    JE HP_DONE
    CMP AL, 0
    JE HP_DONE
    
    ; Simple XOR hash with key
    XOR AL, 0A5h    ; Hash key
    ROL AL, 2       ; Rotate left (using rol arithmetic)
    MOV [DI], AL
    
    INC SI
    INC DI
    INC CX
    CMP CX, 19
    JL HP_LOOP
    
HP_DONE:
    MOV BYTE PTR [DI], 0
    POP DI SI CX BX AX
    RET
HASH_PASSWORD ENDP

; 2. FILE OPERATIONS (Save/Load student data)
SAVE_TO_FILE PROC
    PUSH AX BX CX DX SI DI
    
    ; Create/Open file
    MOV AH, 3Ch         ; Create file
    MOV CX, 0           ; Normal file
    LEA DX, filename    ; filename is 'STUDENTS.DAT'
    INT 21h
    JC SF_ERROR
    MOV file_handle, AX
    
    ; Write magic header (for file validation)
    MOV AH, 40h
    MOV BX, file_handle
    MOV CX, 12          ; Write 12 bytes
    LEA DX, passwd_file_header  ; Reuse header or create new one
    INT 21h
    
    ; Write subjects_set flag
    MOV AH, 40h
    MOV BX, file_handle
    MOV CX, 1
    LEA DX, subjects_set
    INT 21h
    
    ; Write subject names if set
    CMP subjects_set, 0
    JE SF_SKIP_SUBJECTS
    MOV AH, 40h
    MOV BX, file_handle
    MOV CX, MAX_SUBJECTS * SUBJECT_NAME_LEN
    LEA DX, subject_names
    INT 21h
    
SF_SKIP_SUBJECTS:
    ; Write student count
    MOV AH, 40h
    MOV BX, file_handle
    MOV CX, 1
    LEA DX, student_count
    INT 21h
    
    ; Write student IDs
    MOV AH, 40h
    MOV BX, file_handle
    MOV CX, MAX_STUDENTS * 10
    LEA DX, student_ids
    INT 21h
    
    ; Write student names
    MOV AH, 40h
    MOV BX, file_handle
    MOV CX, MAX_STUDENTS * 30
    LEA DX, student_names
    INT 21h
    
    ; Write classification data
    MOV AH, 40h
    MOV BX, file_handle
    MOV CX, MAX_STUDENTS
    LEA DX, student_programs
    INT 21h
    
    MOV AH, 40h
    MOV BX, file_handle
    MOV CX, MAX_STUDENTS
    LEA DX, student_levels
    INT 21h
    
    MOV AH, 40h
    MOV BX, file_handle
    MOV CX, MAX_STUDENTS
    LEA DX, student_years
    INT 21h
    
    MOV AH, 40h
    MOV BX, file_handle
    MOV CX, MAX_STUDENTS
    LEA DX, student_intakes
    INT 21h
    
    MOV AH, 40h
    MOV BX, file_handle
    MOV CX, MAX_STUDENTS
    LEA DX, student_semesters
    INT 21h
    
    ; Write scores
    MOV AH, 40h
    MOV BX, file_handle
    MOV CX, MAX_STUDENTS * MAX_SUBJECTS
    LEA DX, student_scores
    INT 21h
    
    ; Write grades
    MOV AH, 40h
    MOV BX, file_handle
    MOV CX, MAX_STUDENTS * MAX_SUBJECTS
    LEA DX, student_grades
    INT 21h
    
    ; Write averages
    MOV AH, 40h
    MOV BX, file_handle
    MOV CX, MAX_STUDENTS
    LEA DX, student_averages
    INT 21h
    
    ; Write overall grades
    MOV AH, 40h
    MOV BX, file_handle
    MOV CX, MAX_STUDENTS
    LEA DX, student_overall_grades
    INT 21h
    
    ; Close file
    MOV AH, 3Eh
    MOV BX, file_handle
    INT 21h
    
SF_ERROR:
    POP DI SI DX CX BX AX
    RET
SAVE_TO_FILE ENDP

LOAD_FROM_FILE PROC
    PUSH AX BX CX DX SI DI
    
    ; Open file
    MOV AH, 3Dh         ; Open file
    MOV AL, 0           ; Read only
    LEA DX, filename
    INT 21h
    JC LF_ERROR         ; File doesn't exist
    MOV file_handle, AX
    
    ; Read and verify header (optional but good practice)
    MOV AH, 3Fh
    MOV BX, file_handle
    MOV CX, 12
    LEA DX, temp_hash   ; Temporary buffer
    INT 21h
    
    ; Read subjects_set flag
    MOV AH, 3Fh
    MOV BX, file_handle
    MOV CX, 1
    LEA DX, subjects_set
    INT 21h
    
    ; Read subject names if set
    CMP subjects_set, 0
    JE LF_SKIP_SUBJECTS
    MOV AH, 3Fh
    MOV BX, file_handle
    MOV CX, MAX_SUBJECTS * SUBJECT_NAME_LEN
    LEA DX, subject_names
    INT 21h
    
LF_SKIP_SUBJECTS:
    ; Read student count
    MOV AH, 3Fh
    MOV BX, file_handle
    MOV CX, 1
    LEA DX, student_count
    INT 21h
    
    ; Read student IDs
    MOV AH, 3Fh
    MOV BX, file_handle
    MOV CX, MAX_STUDENTS * 10
    LEA DX, student_ids
    INT 21h
    
    ; Read student names
    MOV AH, 3Fh
    MOV BX, file_handle
    MOV CX, MAX_STUDENTS * 30
    LEA DX, student_names
    INT 21h
    
    ; Read classification data
    MOV AH, 3Fh
    MOV BX, file_handle
    MOV CX, MAX_STUDENTS
    LEA DX, student_programs
    INT 21h
    
    MOV AH, 3Fh
    MOV BX, file_handle
    MOV CX, MAX_STUDENTS
    LEA DX, student_levels
    INT 21h
    
    MOV AH, 3Fh
    MOV BX, file_handle
    MOV CX, MAX_STUDENTS
    LEA DX, student_years
    INT 21h
    
    MOV AH, 3Fh
    MOV BX, file_handle
    MOV CX, MAX_STUDENTS
    LEA DX, student_intakes
    INT 21h
    
    MOV AH, 3Fh
    MOV BX, file_handle
    MOV CX, MAX_STUDENTS
    LEA DX, student_semesters
    INT 21h
    
    ; Read scores
    MOV AH, 3Fh
    MOV BX, file_handle
    MOV CX, MAX_STUDENTS * MAX_SUBJECTS
    LEA DX, student_scores
    INT 21h
    
    ; Read grades
    MOV AH, 3Fh
    MOV BX, file_handle
    MOV CX, MAX_STUDENTS * MAX_SUBJECTS
    LEA DX, student_grades
    INT 21h
    
    ; Read averages
    MOV AH, 3Fh
    MOV BX, file_handle
    MOV CX, MAX_STUDENTS
    LEA DX, student_averages
    INT 21h
    
    ; Read overall grades
    MOV AH, 3Fh
    MOV BX, file_handle
    MOV CX, MAX_STUDENTS
    LEA DX, student_overall_grades
    INT 21h
    
    ; Close file
    MOV AH, 3Eh
    MOV BX, file_handle
    INT 21h
    
LF_ERROR:
    POP DI SI DX CX BX AX
    RET
LOAD_FROM_FILE ENDP




; 5. BIOS SERVICES (Colors and effects)
SET_COLOR PROC
    PUSH AX BX
    
    ; Set text color
    MOV AH, 09h             ; Write character with attribute
    MOV AL, ' '             ; Character to write
    MOV BH, 0               ; Page number
    MOV BL, color_attr      ; Color attribute
    MOV CX, 1               ; Number of characters
    INT 10h
    
    POP BX AX
    RET
SET_COLOR ENDP

BLINK_TEXT PROC
    PUSH AX BX CX DX
    
    MOV CX, 5               ; Blink 5 times
BT_LOOP:
    ; Set blinking attribute (bit 7 set)
    MOV color_attr, 8Fh     ; Bright white on black, blinking
    CALL SET_COLOR
    
    ; Delay
    CALL DELAY_SHORT
    
    ; Normal attribute
    MOV color_attr, 0Fh     ; Bright white on black, no blink
    CALL SET_COLOR
    
    CALL DELAY_SHORT
    LOOP BT_LOOP
    
    POP DX CX BX AX
    RET
BLINK_TEXT ENDP

DELAY_SHORT PROC
    PUSH AX CX DX
    MOV CX, 0001h           ; High word of delay
    MOV DX, 0000h           ; Low word of delay
    MOV AH, 86h             ; BIOS delay function
    INT 15h
    POP DX CX AX
    RET
DELAY_SHORT ENDP

; 6. ASCII ART
DISPLAY_ASCII_ART PROC
    PUSH AX DX
    
    LEA DX, ascii_art_header
    MOV AH, 09h
    INT 21h
    
    LEA DX, ascii_art_line1
    MOV AH, 09h
    INT 21h
    
    LEA DX, ascii_art_line2
    MOV AH, 09h
    INT 21h
    
    LEA DX, ascii_art_line3
    MOV AH, 09h
    INT 21h
    
    POP DX AX
    RET
DISPLAY_ASCII_ART ENDP


SET_SCREEN_COLOR PROC
    PUSH AX BX
    MOV AH, 06h         ; Scroll up (clear screen)
    MOV AL, 0           ; Clear entire screen
    MOV BH, 1Fh         ; White on blue background
    MOV CH, 0
    MOV CL, 0
    MOV DH, 24
    MOV DL, 79
    INT 10h
    POP BX AX
    RET
SET_SCREEN_COLOR ENDP

SET_TEXT_ATTRIBUTES PROC
    PUSH AX BX CX DX
    MOV AH, 09h
    MOV AL, ' '
    MOV BH, 0
    MOV BL, color_attr
    MOV CX, 1
    INT 10h
    POP DX CX BX AX
    RET
SET_TEXT_ATTRIBUTES ENDP

DISPLAY_ENHANCED_TITLE PROC
    PUSH AX DX
    
    ; Set title color (bright white on blue)
    MOV color_attr, 1Fh
    CALL SET_TEXT_ATTRIBUTES
    
    LEA DX, title_msg
    MOV AH, 09h
    INT 21h
    
    ; Reset color
    MOV color_attr, 0Fh
    CALL SET_TEXT_ATTRIBUTES
    
    POP DX AX
    RET
DISPLAY_ENHANCED_TITLE ENDP


EXPORT_TO_TEXT PROC
    PUSH AX BX CX DX SI DI
    
    ; Create text file
    MOV AH, 3Ch
    MOV CX, 0
    LEA DX, text_filename
    INT 21h
    JC ETT_ERROR
    MOV file_handle, AX
    
    ; Write header
    CALL WRITE_TEXT_LINE_HEADER
    
    ; Check if any students exist
    CMP student_count, 0
    JE ETT_NO_STUDENTS
    
    ; Write each student's data
    MOV current_student, 0
    
ETT_STUDENT_LOOP:
    MOV AL, current_student
    CMP AL, student_count
    JGE ETT_DONE
    
    ; Write separator
    CALL WRITE_SEPARATOR_LINE
    
    ; Write student number
    CALL WRITE_STUDENT_NUMBER
    
    ; Write student ID
    CALL WRITE_STUDENT_ID
    
    ; Write student name
    CALL WRITE_STUDENT_NAME
    
    ; Write classification info
    CALL WRITE_CLASSIFICATION_INFO
    
    ; Write subject scores
    CALL WRITE_SUBJECT_SCORES
    
    ; Write average and grade
    CALL WRITE_AVERAGE_GRADE
    
    INC current_student
    JMP ETT_STUDENT_LOOP
    
ETT_NO_STUDENTS:
    ; Write "no students" message
    LEA SI, no_records_msg
    CALL WRITE_STRING_TO_FILE
    
ETT_DONE:
    ; Close file
    MOV AH, 3Eh
    MOV BX, file_handle
    INT 21h
    
    ; Show success message
    LEA DX, export_success
    MOV AH, 09h
    INT 21h
    JMP ETT_EXIT
    
ETT_ERROR:
    LEA DX, error_msg
    MOV AH, 09h
    INT 21h
    
ETT_EXIT:
    POP DI SI DX CX BX AX
    RET
EXPORT_TO_TEXT ENDP


WRITE_STUDENT_ID PROC
    PUSH AX BX CX DX SI DI
    
    ; Write "ID: "
    LEA DI, text_buffer
    MOV BYTE PTR [DI], 'I'
    INC DI
    MOV BYTE PTR [DI], 'D'
    INC DI
    MOV BYTE PTR [DI], ':'
    INC DI
    MOV BYTE PTR [DI], ' '
    INC DI
    
    ; Get student ID
    MOV AL, current_student
    MOV AH, 0
    MOV CL, 10
    MUL CL
    LEA SI, student_ids
    ADD SI, AX
    
    ; Copy ID
    MOV CX, 0
WSID_COPY:
    MOV AL, [SI]
    CMP AL, '$'
    JE WSID_DONE
    MOV [DI], AL
    INC SI
    INC DI
    INC CX
    CMP CX, 9
    JL WSID_COPY
    
WSID_DONE:
    ; Add newline
    MOV BYTE PTR [DI], 13
    INC DI
    MOV BYTE PTR [DI], 10
    INC DI
    
    ; Calculate length and write
    SUB DI, OFFSET text_buffer
    MOV CX, DI
    MOV AH, 40h
    MOV BX, file_handle
    LEA DX, text_buffer
    INT 21h
    
    POP DI SI DX CX BX AX
    RET
WRITE_STUDENT_ID ENDP

WRITE_SUBJECT_SCORES PROC
    PUSH AX BX CX DX SI DI
    
    ; Write "Scores:" header
    LEA DI, text_buffer
    MOV SI, OFFSET scores_header
    ADD SI, 4  ; Skip formatting
    MOV CX, 15
    REP MOVSB
    
    ; Write to file
    MOV AH, 40h
    MOV BX, file_handle
    LEA DX, text_buffer
    MOV CX, 15
    INT 21h
    
    ; Write each subject score
    MOV current_subject, 0
    
WSS_LOOP:
    ; Clear buffer
    LEA DI, text_buffer
    MOV CX, 80
    MOV AL, 0
    REP STOSB
    LEA DI, text_buffer
    
    ; Subject name
    MOV AL, current_subject
    MOV AH, 0
    MOV BL, SUBJECT_NAME_LEN
    MUL BL
    LEA SI, subject_names
    ADD SI, AX
    
    ; Copy subject name
    MOV CX, 0
WSS_NAME:
    MOV AL, [SI]
    CMP AL, '$'
    JE WSS_NAME_DONE
    MOV [DI], AL
    INC SI
    INC DI
    INC CX
    CMP CX, SUBJECT_NAME_LEN
    JL WSS_NAME
    
WSS_NAME_DONE:
    ; Add ": "
    MOV BYTE PTR [DI], ':'
    INC DI
    MOV BYTE PTR [DI], ' '
    INC DI
    
    ; Get score
    MOV AL, current_student
    MOV AH, 0
    MOV BL, MAX_SUBJECTS
    MUL BL
    ADD AL, current_subject
    MOV AH, 0
    LEA SI, student_scores
    ADD SI, AX
    MOV AL, [SI]
    
    ; Convert score to ASCII
    MOV AH, 0
    AAM
    MOV BL, AL  ; Save ones
    MOV AL, AH  ; Tens
    AAM
    
    ; Write hundreds (if any)
    CMP AH, 0
    JE WSS_TENS
    ADD AH, '0'
    MOV [DI], AH
    INC DI
    
WSS_TENS:
    ADD AL, '0'
    MOV [DI], AL
    INC DI
    ADD BL, '0'
    MOV [DI], BL
    INC DI
    
    ; Add " Grade: X"
    MOV BYTE PTR [DI], ' '
    INC DI
    MOV BYTE PTR [DI], 'G'
    INC DI
    MOV BYTE PTR [DI], 'r'
    INC DI
    MOV BYTE PTR [DI], 'a'
    INC DI
    MOV BYTE PTR [DI], 'd'
    INC DI
    MOV BYTE PTR [DI], 'e'
    INC DI
    MOV BYTE PTR [DI], ':'
    INC DI
    MOV BYTE PTR [DI], ' '
    INC DI
    
    ; Get grade
    MOV AL, current_student
    MOV AH, 0
    MOV BL, MAX_SUBJECTS
    MUL BL
    ADD AL, current_subject
    MOV AH, 0
    LEA SI, student_grades
    ADD SI, AX
    MOV AL, [SI]
    MOV [DI], AL
    INC DI
    
    ; Add newline
    MOV BYTE PTR [DI], 13
    INC DI
    MOV BYTE PTR [DI], 10
    INC DI
    
    ; Write line
    SUB DI, OFFSET text_buffer
    MOV CX, DI
    MOV AH, 40h
    MOV BX, file_handle
    LEA DX, text_buffer
    INT 21h
    
    ; Next subject
    INC current_subject
    MOV AL, current_subject
    CMP AL, MAX_SUBJECTS
    JL WSS_LOOP
    
    POP DI SI DX CX BX AX
    RET
WRITE_SUBJECT_SCORES ENDP

; Helper procedure to write header
WRITE_TEXT_LINE_HEADER PROC
    PUSH AX BX CX DX SI
    
    ; Write header text
    MOV AH, 40h
    MOV BX, file_handle
    MOV CX, 44  ; Length of header
    LEA DX, export_header
    INT 21h
    
    POP SI DX CX BX AX
    RET
WRITE_TEXT_LINE_HEADER ENDP

; Helper to write string to file
WRITE_STRING_TO_FILE PROC
    PUSH AX BX CX DX SI
    
    ; Count string length
    MOV CX, 0
    PUSH SI
WSF_COUNT:
    MOV AL, [SI]
    CMP AL, '$'
    JE WSF_WRITE
    CMP AL, 0
    JE WSF_WRITE
    INC CX
    INC SI
    JMP WSF_COUNT
    
WSF_WRITE:
    POP SI  ; Restore SI to start of string
    MOV AH, 40h
    MOV BX, file_handle
    MOV DX, SI
    INT 21h
    
    POP SI DX CX BX AX
    RET
WRITE_STRING_TO_FILE ENDP

; Write separator line
WRITE_SEPARATOR_LINE PROC
    PUSH AX BX CX DX
    
    ; Write separator
    MOV AH, 40h
    MOV BX, file_handle
    MOV CX, 42  ; Length includes CR/LF
    LEA DX, student_sep
    INT 21h
    
    POP DX CX BX AX
    RET
WRITE_SEPARATOR_LINE ENDP

; Write student number
WRITE_STUDENT_NUMBER PROC
    PUSH AX BX CX DX SI DI
    
    ; Clear buffer
    LEA DI, text_buffer
    
    ; Write "Student #"
    MOV BYTE PTR [DI], 'S'
    INC DI
    MOV BYTE PTR [DI], 't'
    INC DI
    MOV BYTE PTR [DI], 'u'
    INC DI
    MOV BYTE PTR [DI], 'd'
    INC DI
    MOV BYTE PTR [DI], 'e'
    INC DI
    MOV BYTE PTR [DI], 'n'
    INC DI
    MOV BYTE PTR [DI], 't'
    INC DI
    MOV BYTE PTR [DI], ' '
    INC DI
    MOV BYTE PTR [DI], '#'
    INC DI
    
    ; Convert student number to ASCII
    MOV AL, current_student
    INC AL  ; Make it 1-based
    MOV AH, 0
    AAM     ; Convert to ASCII
    
    CMP AH, 0
    JE WSN_ONES
    ADD AH, '0'
    MOV [DI], AH
    INC DI
    
WSN_ONES:
    ADD AL, '0'
    MOV [DI], AL
    INC DI
    
    ; Add newline
    MOV BYTE PTR [DI], 13
    INC DI
    MOV BYTE PTR [DI], 10
    INC DI
    
    ; Calculate length and write
    SUB DI, OFFSET text_buffer
    MOV CX, DI
    MOV AH, 40h
    MOV BX, file_handle
    LEA DX, text_buffer
    INT 21h
    
    POP DI SI DX CX BX AX
    RET
WRITE_STUDENT_NUMBER ENDP

; Write student name
WRITE_STUDENT_NAME PROC
    PUSH AX BX CX DX SI DI
    
    ; Clear buffer and write "Name: "
    LEA DI, text_buffer
    MOV BYTE PTR [DI], 'N'
    INC DI
    MOV BYTE PTR [DI], 'a'
    INC DI
    MOV BYTE PTR [DI], 'm'
    INC DI
    MOV BYTE PTR [DI], 'e'
    INC DI
    MOV BYTE PTR [DI], ':'
    INC DI
    MOV BYTE PTR [DI], ' '
    INC DI
    
    ; Get student name
    MOV AL, current_student
    MOV AH, 0
    MOV CL, 30
    MUL CL
    LEA SI, student_names
    ADD SI, AX
    
    ; Copy name
    MOV CX, 0
WSN_COPY:
    MOV AL, [SI]
    CMP AL, '$'
    JE WSN_DONE
    MOV [DI], AL
    INC SI
    INC DI
    INC CX
    CMP CX, 29
    JL WSN_COPY
    
WSN_DONE:
    ; Add newline
    MOV BYTE PTR [DI], 13
    INC DI
    MOV BYTE PTR [DI], 10
    INC DI
    
    ; Calculate length and write
    SUB DI, OFFSET text_buffer
    MOV CX, DI
    MOV AH, 40h
    MOV BX, file_handle
    LEA DX, text_buffer
    INT 21h
    
    POP DI SI DX CX BX AX
    RET
WRITE_STUDENT_NAME ENDP

; Write classification info
WRITE_CLASSIFICATION_INFO PROC
    PUSH AX BX CX DX SI DI
    
    ; Get student index
    MOV BL, current_student
    MOV BH, 0
    
    ; Clear and prepare buffer
    LEA DI, text_buffer
    
    ; Write "Program: "
    MOV SI, OFFSET filter_display_msg
    ADD SI, 2  ; Skip CR/LF
    MOV CX, 25
    REP MOVSB
    
    ; Get and write program name
    LEA SI, student_programs
    ADD SI, BX
    MOV AL, [SI]
    PUSH BX
    CALL WRITE_PROGRAM_NAME_TO_BUFFER
    POP BX
    
    ; Add ", Level: "
    MOV BYTE PTR [DI], ','
    INC DI
    MOV BYTE PTR [DI], ' '
    INC DI
    MOV BYTE PTR [DI], 'L'
    INC DI
    MOV BYTE PTR [DI], 'e'
    INC DI
    MOV BYTE PTR [DI], 'v'
    INC DI
    MOV BYTE PTR [DI], 'e'
    INC DI
    MOV BYTE PTR [DI], 'l'
    INC DI
    MOV BYTE PTR [DI], ':'
    INC DI
    MOV BYTE PTR [DI], ' '
    INC DI
    
    ; Write level number
    LEA SI, student_levels
    ADD SI, BX
    MOV AL, [SI]
    ADD AL, '0'
    MOV [DI], AL
    INC DI
    
    ; Continue with year, intake, semester...
    ; Add newline at end
    MOV BYTE PTR [DI], 13
    INC DI
    MOV BYTE PTR [DI], 10
    INC DI
    
    ; Write buffer to file
    SUB DI, OFFSET text_buffer
    MOV CX, DI
    MOV AH, 40h
    MOV BX, file_handle
    LEA DX, text_buffer
    INT 21h
    
    POP DI SI DX CX BX AX
    RET
WRITE_CLASSIFICATION_INFO ENDP

; Helper to write program name to buffer (DI points to buffer)
WRITE_PROGRAM_NAME_TO_BUFFER PROC
    PUSH AX BX CX SI
    
    ; AL contains program index (1-based)
    DEC AL  ; Convert to 0-based
    MOV AH, 0
    MOV BL, 10  ; Each program name is 10 bytes
    MUL BL
    LEA SI, program_names
    ADD SI, AX
    
    ; Copy program name
    MOV CX, 0
WPNB_LOOP:
    MOV AL, [SI]
    CMP AL, '$'
    JE WPNB_DONE
    MOV [DI], AL
    INC SI
    INC DI
    INC CX
    CMP CX, 9
    JL WPNB_LOOP
    
WPNB_DONE:
    POP SI CX BX AX
    RET
WRITE_PROGRAM_NAME_TO_BUFFER ENDP

; Write average and grade
WRITE_AVERAGE_GRADE PROC
    PUSH AX BX CX DX SI DI
    
    ; Clear buffer
    LEA DI, text_buffer
    
    ; Write "Average Score: "
    MOV SI, OFFSET avg_label
    ADD SI, 4  ; Skip formatting
    MOV CX, 15
    REP MOVSB
    
    ; Get average
    MOV AL, current_student
    MOV AH, 0
    LEA SI, student_averages
    ADD SI, AX
    MOV AL, [SI]
    
    ; Convert to ASCII
    MOV AH, 0
    AAM
    MOV BL, AL  ; Save ones
    MOV AL, AH  ; Tens
    
    CMP AL, 0
    JE WAG_ONES
    ADD AL, '0'
    MOV [DI], AL
    INC DI
    
WAG_ONES:
    ADD BL, '0'
    MOV [DI], BL
    INC DI
    
    ; Add newline
    MOV BYTE PTR [DI], 13
    INC DI
    MOV BYTE PTR [DI], 10
    INC DI
    
    ; Write "Overall Grade: "
    MOV SI, OFFSET overall_label
    ADD SI, 2  ; Skip CR/LF
    MOV CX, 15
    REP MOVSB
    
    ; Get grade
    MOV AL, current_student
    MOV AH, 0
    LEA SI, student_overall_grades
    ADD SI, AX
    MOV AL, [SI]
    MOV [DI], AL
    INC DI
    
    ; Add newline
    MOV BYTE PTR [DI], 13
    INC DI
    MOV BYTE PTR [DI], 10
    INC DI
    
    ; Write to file
    SUB DI, OFFSET text_buffer
    MOV CX, DI
    MOV AH, 40h
    MOV BX, file_handle
    LEA DX, text_buffer
    INT 21h
    
    POP DI SI DX CX BX AX
    RET
WRITE_AVERAGE_GRADE ENDP


display_goodbye PROC
    ; Clear screen with dramatic effect
    call ClearScreen
    
    ; Play startup sound sequence
    call PLAY_EXIT_SOUNDS
    
    ; Rainbow border animation - cycle through colors
    mov cx, 3  ; Repeat 3 times for dramatic effect
RAINBOW_BORDER_LOOP:
    push cx
    
    ; Cycle through rainbow colors for border
    mov bl, 0Ch  ; Bright Red
    mov dx, offset border_top
    call PrintStringWithAttribute
    call SHORT_DELAY
    
    mov bl, 0Eh  ; Bright Yellow  
    mov dx, offset border_top
    call PrintStringWithAttribute
    call SHORT_DELAY
    
    mov bl, 0Ah  ; Bright Green
    mov dx, offset border_top
    call PrintStringWithAttribute
    call SHORT_DELAY
    
    mov bl, 0Bh  ; Bright Cyan
    mov dx, offset border_top
    call PrintStringWithAttribute
    call MEDIUM_DELAY
    
    pop cx
    loop RAINBOW_BORDER_LOOP

    ; Display success message with blinking rainbow effect
    mov cx, 5  ; Blink 5 times
SUCCESS_BLINK_LOOP:
    push cx
    mov bl, 8Eh  ; Blinking Bright Yellow
    mov dx, offset success_line
    call PrintStringWithAttribute
    call SHORT_DELAY
    
    mov bl, 8Ch  ; Blinking Bright Red
    mov dx, offset success_line
    call PrintStringWithAttribute
    call SHORT_DELAY
    
    mov bl, 8Ah  ; Blinking Bright Green
    mov dx, offset success_line
    call PrintStringWithAttribute
    call MEDIUM_DELAY
    
    pop cx
    loop SUCCESS_BLINK_LOOP

    ; Display GOOD text with enhanced rainbow blinking
    mov cx, 4  ; Rainbow cycle 4 times
GOOD_RAINBOW_LOOP:
    push cx
    
    ; Bright Green phase
    mov bl, 8Ah  ; Blinking Bright Green
    mov dx, offset good_text1
    call PrintStringWithAttribute
    mov dx, offset good_text2
    call PrintStringWithAttribute
    mov dx, offset good_text3
    call PrintStringWithAttribute
    mov dx, offset good_text4
    call PrintStringWithAttribute
    mov dx, offset good_text5
    call PrintStringWithAttribute
    mov dx, offset good_text6
    call PrintStringWithAttribute
    call SHORT_DELAY
    
    ; Bright Yellow phase
    mov bl, 8Eh  ; Blinking Bright Yellow
    mov dx, offset good_text1
    call PrintStringWithAttribute
    mov dx, offset good_text2
    call PrintStringWithAttribute
    mov dx, offset good_text3
    call PrintStringWithAttribute
    mov dx, offset good_text4
    call PrintStringWithAttribute
    mov dx, offset good_text5
    call PrintStringWithAttribute
    mov dx, offset good_text6
    call PrintStringWithAttribute
    call SHORT_DELAY
    
    ; Bright Cyan phase
    mov bl, 8Bh  ; Blinking Bright Cyan
    mov dx, offset good_text1
    call PrintStringWithAttribute
    mov dx, offset good_text2
    call PrintStringWithAttribute
    mov dx, offset good_text3
    call PrintStringWithAttribute
    mov dx, offset good_text4
    call PrintStringWithAttribute
    mov dx, offset good_text5
    call PrintStringWithAttribute
    mov dx, offset good_text6
    call PrintStringWithAttribute
    call MEDIUM_DELAY
    
    pop cx
    loop GOOD_RAINBOW_LOOP

    ; Display BYE text with dramatic blinking
    mov cx, 6  ; Blink 6 times
BYE_DRAMATIC_LOOP:
    push cx
    
    ; Blinking Bright Red
    mov bl, 8Ch
    mov dx, offset bye_text1
    call PrintStringWithAttribute
    mov dx, offset bye_text2
    call PrintStringWithAttribute
    mov dx, offset bye_text3
    call PrintStringWithAttribute
    mov dx, offset bye_text4
    call PrintStringWithAttribute
    mov dx, offset bye_text5
    call PrintStringWithAttribute
    mov dx, offset bye_text6
    call PrintStringWithAttribute
    call SHORT_DELAY
    
    ; Blinking Bright Magenta
    mov bl, 8Dh
    mov dx, offset bye_text1
    call PrintStringWithAttribute
    mov dx, offset bye_text2
    call PrintStringWithAttribute
    mov dx, offset bye_text3
    call PrintStringWithAttribute
    mov dx, offset bye_text4
    call PrintStringWithAttribute
    mov dx, offset bye_text5
    call PrintStringWithAttribute
    mov dx, offset bye_text6
    call PrintStringWithAttribute
    call SHORT_DELAY
    
    ; Blinking Bright White
    mov bl, 8Fh
    mov dx, offset bye_text1
    call PrintStringWithAttribute
    mov dx, offset bye_text2
    call PrintStringWithAttribute
    mov dx, offset bye_text3
    call PrintStringWithAttribute
    mov dx, offset bye_text4
    call PrintStringWithAttribute
    mov dx, offset bye_text5
    call PrintStringWithAttribute
    mov dx, offset bye_text6
    call PrintStringWithAttribute
    call MEDIUM_DELAY
    
    pop cx
    loop BYE_DRAMATIC_LOOP
    
    ; Display decoration with rainbow cycling
    mov cx, 3
DECORATION_RAINBOW_LOOP:
    push cx
    mov bl, 8Dh  ; Blinking Magenta
    mov dx, offset decoration
    call PrintStringWithAttribute
    mov dx, offset decoration2
    call PrintStringWithAttribute
    call SHORT_DELAY
    
    mov bl, 8Bh  ; Blinking Cyan
    mov dx, offset decoration
    call PrintStringWithAttribute
    mov dx, offset decoration2
    call PrintStringWithAttribute
    call SHORT_DELAY
    
    mov bl, 8Eh  ; Blinking Yellow
    mov dx, offset decoration
    call PrintStringWithAttribute
    mov dx, offset decoration2
    call PrintStringWithAttribute
    call MEDIUM_DELAY
    
    pop cx
    loop DECORATION_RAINBOW_LOOP

    ; Display thank you message with gentle blinking
    mov bl, 0Fh  ; Bright White
    mov dx, offset thank_you1
    call PrintStringWithAttribute
    mov dx, offset thank_you2
    call PrintStringWithAttribute
    mov dx, offset thank_you3
    call PrintStringWithAttribute
    mov dx, offset thank_you4
    call PrintStringWithAttribute
    
    ; Final rainbow border bottom
    mov cx, 2
FINAL_BORDER_LOOP:
    push cx
    mov bl, 0Ch  ; Bright Red
    mov dx, offset border_bottom
    call PrintStringWithAttribute
    call SHORT_DELAY
    
    mov bl, 0Eh  ; Bright Yellow
    mov dx, offset border_bottom
    call PrintStringWithAttribute
    call SHORT_DELAY
    
    mov bl, 0Ah  ; Bright Green
    mov dx, offset border_bottom
    call PrintStringWithAttribute
    call SHORT_DELAY
    
    mov bl, 0Bh  ; Bright Cyan
    mov dx, offset border_bottom
    call PrintStringWithAttribute
    call MEDIUM_DELAY
    
    pop cx
    loop FINAL_BORDER_LOOP
    
    ; Final sound effect
    call PLAY_GOODBYE_SOUNDS

    ret
display_goodbye ENDP

;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
; Helper procedure to print a null-terminated string with a
; specific color attribute.
; Input: DX = offset of string, BL = color attribute
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
PrintStringWithAttribute PROC
    push ax
    push bx
    push cx
    push si
    push di
    
    ; Convert null-terminated string to $-terminated for DOS
    mov si, dx
    mov di, dx
    
    ; Find the null terminator
FindNull:
    lodsb
    cmp al, 0
    jne FindNull
    
    ; Replace null with $
    dec si
    mov byte ptr [si], '$'
    
    ; Print the string using DOS
    mov ah, 09h
    int 21h
    
    ; Restore null terminator
    mov byte ptr [si], 0
    
    pop di
    pop si
    pop cx
    pop bx
    pop ax
    ret
PrintStringWithAttribute ENDP

;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
; Delay procedures for animation effects - Using simple CPU loops
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
SHORT_DELAY PROC
    push ax
    push cx
    
    mov cx, 0FFFFh    ; Short delay loop
SHORT_DELAY_LOOP:
    nop
    nop
    loop SHORT_DELAY_LOOP
    
    pop cx
    pop ax
    ret
SHORT_DELAY ENDP

MEDIUM_DELAY PROC
    push ax
    push cx
    push dx
    
    mov dx, 3         ; Repeat short delay 3 times
MEDIUM_DELAY_OUTER:
    mov cx, 0FFFFh
MEDIUM_DELAY_LOOP:
    nop
    nop
    loop MEDIUM_DELAY_LOOP
    dec dx
    jnz MEDIUM_DELAY_OUTER
    
    pop dx
    pop cx
    pop ax
    ret
MEDIUM_DELAY ENDP

LONG_DELAY PROC
    push ax
    push cx
    push dx
    
    mov dx, 8         ; Repeat short delay 8 times
LONG_DELAY_OUTER:
    mov cx, 0FFFFh
LONG_DELAY_LOOP:
    nop
    nop
    loop LONG_DELAY_LOOP
    dec dx
    jnz LONG_DELAY_OUTER
    
    pop dx
    pop cx
    pop ax
    ret
LONG_DELAY ENDP

; 0.5 second delay procedure for blinking effect
HALF_SECOND_DELAY PROC
    push ax
    push cx
    push dx
    
    mov cx, 0007h     ; High word of delay (approximately 0.5 seconds)
    mov dx, 0A120h    ; Low word of delay 
    mov ah, 86h       ; BIOS delay function
    int 15h           ; Call BIOS delay
    
    pop dx
    pop cx
    pop ax
    ret
HALF_SECOND_DELAY ENDP

; Simple character show/hide blinking - 16-bit DOS compatible
; Input: DL = character to display
CONTINUOUS_BLINK_GREEN_WHITE PROC
    push ax
    push bx
    push cx
    push dx
    
    mov bl, dl          ; Save character in BL
    
SHOW_HIDE_LOOP:
    ; Check if key is pressed (non-blocking)
    mov ah, 01h         ; Check keyboard status
    int 16h
    jnz END_SHOW_HIDE   ; If key pressed, exit
    
    ; SHOW: Display the character
    mov ah, 02h         ; DOS write character
    mov dl, bl          ; Character to display
    int 21h
    
    ; Wait - visible phase
    call MEDIUM_DELAY
    
    ; Check if key is pressed
    mov ah, 01h
    int 16h
    jnz END_SHOW_HIDE
    
    ; HIDE: Erase with backspace and space
    mov ah, 02h
    mov dl, 08h         ; Backspace
    int 21h
    mov ah, 02h
    mov dl, 20h         ; Space character
    int 21h
    mov ah, 02h
    mov dl, 08h         ; Backspace again
    int 21h
    
    ; Wait - hidden phase
    call MEDIUM_DELAY
    
    jmp SHOW_HIDE_LOOP
    
END_SHOW_HIDE:
    ; Clear the keystroke from buffer
    mov ah, 00h
    int 16h
    
    ; Make sure character is visible at the end
    mov ah, 02h
    mov dl, bl
    int 21h
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
CONTINUOUS_BLINK_GREEN_WHITE ENDP

; ========== NEW SMILING EMOJI LINE BLINKING PROCEDURE ==========
BLINK_SMILING_EMOJI_LINE PROC
    ; Input: BL = color attribute (02h for green, 0Ch for red)
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push bp
    
    ; Move to next line first
    mov ah, 02h
    mov dl, 13          ; Carriage return first
    int 21h
    mov dl, 10          ; Then line feed
    int 21h
    
    mov ch, bl          ; Save color attribute in CH
    
    ; Get current cursor position for the line
    mov ah, 03h
    mov bh, 0
    int 10h
    mov dh, dh          ; Keep current row
    mov dl, 0           ; Start at column 0
    
EMOJI_BLINK_LOOP:
    ; Check if key is pressed (non-blocking)
    mov ah, 01h         ; Check keyboard status
    int 16h
    jnz EMOJI_END_BLINK ; If key pressed, exit
    
    ; SHOW PHASE: Display all smiling faces in color on same line
    mov ah, 02h         ; Set cursor to start of emoji line
    mov bh, 0
    mov dl, 0           ; Column 0
    int 10h
    
    mov si, 0           ; Counter for characters in line
EMOJI_SHOW_LINE:
    cmp si, 45
    jge EMOJI_SHOW_DONE
    
    ; Display smiling face with color using DOS output
    mov ah, 02h
    mov dl, 01h         ; Smiling face character (☺)
    int 21h
    
    inc si
    jmp EMOJI_SHOW_LINE
    
EMOJI_SHOW_DONE:
    ; Set text color for the line we just printed
    mov ah, 02h         ; Set cursor back to start of emoji line  
    mov bh, 0
    mov dl, 0
    int 10h
    
    ; Re-display with proper color using BIOS
    mov si, 0
EMOJI_COLOR_LINE:
    cmp si, 45
    jge EMOJI_COLOR_DONE
    
    mov ah, 09h         ; Write character with attribute
    mov al, 01h         ; Smiling face character (☺)
    mov bl, ch          ; Color attribute (green=0Ah or red=0Ch)
    mov bh, 0           ; Page 0
    mov cx, 1           ; Write 1 character
    int 10h
    
    ; Move cursor right
    mov ah, 03h         ; Get cursor position
    mov bh, 0
    int 10h
    inc dl
    mov ah, 02h         ; Set cursor position
    mov bh, 0
    int 10h
    
    inc si
    jmp EMOJI_COLOR_LINE
    
EMOJI_COLOR_DONE:
    ; Wait - visible phase
    call MEDIUM_DELAY
    
    ; Check if key is pressed again
    mov ah, 01h
    int 16h
    jnz EMOJI_END_BLINK
    
    ; HIDE PHASE: Replace with spaces (invisible)
    mov ah, 02h         ; Set cursor to start of emoji line
    mov bh, 0
    mov dl, 0           ; Column 0
    int 10h
    
    mov si, 0           ; Counter for characters in line
EMOJI_HIDE_LINE:
    cmp si, 45
    jge EMOJI_HIDE_DONE
    
    ; Display space (erase the emoji)
    mov ah, 02h
    mov dl, 20h         ; Space character
    int 21h
    
    inc si
    jmp EMOJI_HIDE_LINE
    
EMOJI_HIDE_DONE:
    ; Wait - hidden phase
    call MEDIUM_DELAY
    
    jmp EMOJI_BLINK_LOOP
    
EMOJI_END_BLINK:
    ; Clear the keystroke from buffer
    mov ah, 00h
    int 16h
    
    ; Make sure smiling faces are visible at the end with proper color
    mov ah, 02h         ; Set cursor to start of emoji line
    mov bh, 0
    mov dl, 0           ; Column 0
    int 10h
    
    mov si, 0           ; Counter for final display
EMOJI_FINAL_LINE:
    cmp si, 45
    jge EMOJI_FINAL_DONE
    
    ; Display final smiling face with color
    mov ah, 09h         ; Write character with attribute
    mov al, 01h         ; Smiling face character (☺)
    mov bl, ch          ; Original color attribute
    mov bh, 0           ; Page 0
    mov cx, 1           ; Write 1 character
    int 10h
    
    ; Move cursor right
    mov ah, 03h         ; Get cursor position
    mov bh, 0
    int 10h
    inc dl
    mov ah, 02h         ; Set cursor position
    mov bh, 0
    int 10h
    
    inc si
    jmp EMOJI_FINAL_LINE
    
EMOJI_FINAL_DONE:
    ; Reset text attribute to normal white
    mov ah, 09h
    mov al, 20h         ; Space character
    mov bl, 07h         ; Normal white text
    mov bh, 0
    mov cx, 1
    int 10h
    
    ; Move cursor to next line
    mov ah, 02h
    mov dl, 13          ; Carriage return
    int 21h
    mov dl, 10          ; Line feed
    int 21h
    
    pop bp
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
BLINK_SMILING_EMOJI_LINE ENDP


;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
; Simple sound effect procedures for dramatic exit
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
PLAY_EXIT_SOUNDS PROC
    push ax
    
    ; Simple beep using DOS
    mov ah, 02h
    mov dl, 07h      ; Bell character (beep)
    int 21h
    
    call SHORT_DELAY
    
    ; Another beep
    mov ah, 02h
    mov dl, 07h
    int 21h
    
    pop ax
    ret
PLAY_EXIT_SOUNDS ENDP

PLAY_GOODBYE_SOUNDS PROC
    push ax
    push cx
    
    ; Multiple beeps for farewell
    mov cx, 3
GOODBYE_BEEP_LOOP:
    mov ah, 02h
    mov dl, 07h      ; Bell character (beep)
    int 21h
    call SHORT_DELAY
    loop GOODBYE_BEEP_LOOP
    
    pop cx
    pop ax
    ret
PLAY_GOODBYE_SOUNDS ENDP

;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
; Helper procedure to clear the console screen
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
ClearScreen PROC
    mov ah, 00h
    mov al, 03h     ; 80x25 16-color text mode
    int 10h
    ret
ClearScreen ENDP


; ========== FEE CALCULATION PROCEDURES ==========

; Main procedure to calculate fees for selected student
CALCULATE_STUDENT_FEES PROC
    PUSH AX BX CX DX SI DI
    
    ; Check if there are any student records
    MOV AL, student_count
    CMP AL, 0
    JNE CSF_HAS_RECORDS
    
    ; No records found
    LEA DX, no_records_msg
    MOV AH, 09h
    INT 21h
    JMP CSF_DONE
    
CSF_HAS_RECORDS:
    ; Get filter criteria to find students
    LEA DX, view_filter_msg
    MOV AH, 09h
    INT 21h
    
    CALL GET_PROGRAM_SELECTION
    CALL GET_LEVEL_SELECTION
    CALL GET_YEAR_INPUT
    CALL GET_INTAKE_SELECTION
    CALL GET_SEMESTER_SELECTION
    
    ; Find matching students
    CALL FIND_MATCHING_STUDENTS
    
    ; Check if any matches were found
    MOV AL, matched_count
    CMP AL, 0
    JNE CSF_HAS_MATCHES
    
    CALL CLEAR_SCREEN
    LEA DX, no_match_msg
    MOV AH, 09h
    INT 21h
    JMP CSF_DONE
    
CSF_HAS_MATCHES:
    ; If only one match, select it automatically
    MOV AL, matched_count
    CMP AL, 1
    JE CSF_SINGLE_MATCH
    
    ; Multiple matches - let user select
    CALL SELECT_STUDENT_FOR_FEES
    CMP AL, 255  ; User cancelled selection
    JE CSF_DONE
    MOV BL, AL
    JMP CSF_CALCULATE
    
CSF_SINGLE_MATCH:
    ; Get the student index from matched_students[0]
    LEA SI, matched_students
    MOV BL, [SI]
    
CSF_CALCULATE:
    ; Calculate and display fees for student in BL
    CALL CALCULATE_FEE
    CALL CLEAR_SCREEN
    CALL DISPLAY_STUDENT_FEES
    
CSF_DONE:
    POP DI SI DX CX BX AX
    RET
CALCULATE_STUDENT_FEES ENDP

; Select student for fee calculation
SELECT_STUDENT_FOR_FEES PROC
    PUSH BX CX DX SI DI
    
    MOV current_match_idx, 0
    
SSF_DISPLAY_LOOP:
    CALL CLEAR_SCREEN
    LEA DX, select_student_header
    MOV AH, 09h
    INT 21h
    
    ; Display filter criteria
    CALL DISPLAY_CURRENT_FILTER
    
    ; Show current selection
    LEA DX, select_prompt_msg
    MOV AH, 09h
    INT 21h
    MOV AL, current_match_idx
    INC AL
    MOV AH, 0
    CALL DISPLAY_NUMBER
    
    LEA DX, of_msg
    MOV AH, 09h
    INT 21h
    MOV AL, matched_count
    MOV AH, 0
    CALL DISPLAY_NUMBER
    
    LEA DX, student_sep
    MOV AH, 09h
    INT 21h
    
    ; Get actual student index
    LEA SI, matched_students
    MOV BL, current_match_idx
    MOV BH, 0
    ADD SI, BX
    MOV BL, [SI]  ; BL = actual student index
    
    ; Display student basic info
    LEA DX, id_label
    MOV AH, 09h
    INT 21h
    MOV AL, BL
    MOV AH, 0
    MOV CL, 10
    MUL CL
    LEA SI, student_ids
    ADD SI, AX
    MOV DX, SI
    MOV AH, 09h
    INT 21h
    
    LEA DX, name_label
    MOV AH, 09h
    INT 21h
    MOV AL, BL
    MOV AH, 0
    MOV CL, 30
    MUL CL
    LEA SI, student_names
    ADD SI, AX
    MOV DX, SI
    MOV AH, 09h
    INT 21h
    
    ; Show selection options
    LEA DX, select_options_msg
    MOV AH, 09h
    INT 21h
    
    MOV AH, 01h
    INT 21h
    
    CMP AL, 'S'
    JE SSF_SELECT
    CMP AL, 's'
    JE SSF_SELECT
    CMP AL, 'N'
    JE SSF_NEXT
    CMP AL, 'n'
    JE SSF_NEXT
    CMP AL, 'P'
    JE SSF_PREV
    CMP AL, 'p'
    JE SSF_PREV
    CMP AL, 'Q'
    JE SSF_QUIT
    CMP AL, 'q'
    JE SSF_QUIT
    CMP AL, 27  ; ESC
    JE SSF_QUIT
    
    JMP SSF_DISPLAY_LOOP
    
SSF_SELECT:
    ; Return the actual student index
    LEA SI, matched_students
    MOV BL, current_match_idx
    MOV BH, 0
    ADD SI, BX
    MOV AL, [SI]
    JMP SSF_DONE
    
SSF_NEXT:
    MOV AL, current_match_idx
    INC AL
    CMP AL, matched_count
    JL SSF_NEXT_OK
    MOV AL, 0
SSF_NEXT_OK:
    MOV current_match_idx, AL
    JMP SSF_DISPLAY_LOOP
    
SSF_PREV:
    MOV AL, current_match_idx
    CMP AL, 0
    JG SSF_PREV_OK
    MOV AL, matched_count
    DEC AL
    JMP SSF_PREV_SET
SSF_PREV_OK:
    DEC AL
SSF_PREV_SET:
    MOV current_match_idx, AL
    JMP SSF_DISPLAY_LOOP
    
SSF_QUIT:
    MOV AL, 255  ; Cancel signal
    
SSF_DONE:
    POP DI SI DX CX BX
    RET
SELECT_STUDENT_FOR_FEES ENDP

; Calculates fee for a student (BL = student index)
CALCULATE_FEE PROC
    PUSH BX CX SI DI
    ; Get program type (1-4, 0-based)
    LEA SI, student_programs
    MOV AL, BL
    MOV AH, 0
    ADD SI, AX
    MOV AL, [SI]
    DEC AL
    MOV AH, 0
    SHL AX, 2  ; *4 for DD index
    LEA SI, base_fees
    ADD SI, AX
    MOV DI, SI  ; Save pointer to base_fee
    ; Use average-based scholarship determination (more reliable)
    LEA SI, student_averages
    MOV AL, BL
    MOV AH, 0
    ADD SI, AX
    MOV AL, [SI]  ; AL = average score
    
    ; Set scholarship_applied to 0
    MOV WORD PTR [scholarship_applied], 0
    MOV WORD PTR [scholarship_applied+2], 0
    
    ; Check average for scholarship eligibility (90+ = A = 30%, 80+ = B = 15%)
    CMP AL, 90       ; Average 90+ gets Grade A (30% scholarship)
    JGE GRADE_A_SCHOLARSHIP
    CMP AL, 80       ; Average 80+ gets Grade B (15% scholarship)  
    JGE GRADE_B_SCHOLARSHIP
    JMP ADD_FEES     ; Average below 80 gets no scholarship
    
GRADE_A_SCHOLARSHIP:
    MOV BX, 30      ; 30% discount for grade A
    JMP CALC_SCH
    
GRADE_B_SCHOLARSHIP:
    MOV BX, 15      ; 15% discount for grade B
    JMP CALC_SCH
CALC_SCH:
    MOV AX, [DI]     ; Load base low (e.g., 200050 for RM2000.50)
    MOV DX, [DI+2]   ; Load base high (usually 0)
    PUSH BX
    MOV CX, 100      ; Divisor for percentage
    MOV BX, CX       ; BX = 100
    DIV BX           ; AX = integer part (2000), DX = MOD remainder (50)
    POP BX           ; Restore percentage (15 or 30)
    PUSH DX          ; Save MOD remainder
    MUL BX           ; AX = integer * percentage (2000 * 15 = 30000)
    MOV SI, AX       ; Save integer scholarship
    POP AX           ; AX = remainder (50)
    MUL BX           ; AX = remainder * percentage (50 * 15 = 750)
    MOV BX, 100
    DIV BX           ; AX = fractional scholarship (750 / 100 = 7), DX = new remainder (50)
    ADD SI, AX       ; Add fractional to integer (30000 + 7 = 30007, representing RM300.07)
    ; Demonstrate SHR: For example, quick divide of fractional by 2 if needed (demo only)
    MOV AX, SI
    SHR AX, 1        ; SHR demo: AX = SI / 2
    SHL AX, 1        ; Restore original
    MOV WORD PTR [scholarship_applied], AX
    MOV WORD PTR [scholarship_applied+2], 0  ; Assuming no overflow
ADD_FEES:
    MOV AX, [DI]
    MOV DX, [DI+2]
    ADD AX, library_fee
    ADC DX, 0
    ADD AX, lab_fee
    ADC DX, 0
    SUB AX, WORD PTR [scholarship_applied]
    SBB DX, WORD PTR [scholarship_applied+2]
    MOV WORD PTR [total_fee], AX
    MOV WORD PTR [total_fee+2], DX
    POP DI SI CX BX
    RET
CALCULATE_FEE ENDP

; Displays fees for student (BL = student index)
DISPLAY_STUDENT_FEES PROC
    PUSH AX BX CX DX SI
    
    ; Display student info first
    LEA DX, result_header
    MOV AH, 09h
    INT 21h
    
    ; Display student ID and name
    LEA DX, id_label
    MOV AH, 09h
    INT 21h
    MOV AL, BL
    MOV AH, 0
    MOV CL, 10
    MUL CL
    LEA SI, student_ids
    ADD SI, AX
    MOV DX, SI
    MOV AH, 09h
    INT 21h
    
    LEA DX, name_label
    MOV AH, 09h
    INT 21h
    MOV AL, BL
    MOV AH, 0
    MOV CL, 30
    MUL CL
    LEA SI, student_names
    ADD SI, AX
    MOV DX, SI
    MOV AH, 09h
    INT 21h
    
    ; Display fees
    CALL DISPLAY_FEES
    
    POP SI DX CX BX AX
    RET
DISPLAY_STUDENT_FEES ENDP

; Displays fees (assumes total_fee is calculated, and other fees are static for display)
DISPLAY_FEES PROC
    PUSH AX BX CX DX

    LEA DX, fees_header
    MOV AH, 09h
    INT 21h

    LEA DX, tuition_label
    MOV AH, 09h
    INT 21h
    ; Tuition = total + scholarship_applied - library - lab
    MOV AX, WORD PTR [total_fee]
    MOV DX, WORD PTR [total_fee+2]
    SUB AX, library_fee
    SBB DX, 0
    SUB AX, lab_fee
    SBB DX, 0
    ADD AX, WORD PTR [scholarship_applied]
    ADC DX, WORD PTR [scholarship_applied+2]
    CALL DISPLAY_DECIMAL

    LEA DX, library_label
    MOV AH, 09h
    INT 21h
    MOV AX, library_fee
    MOV DX, 0
    CALL DISPLAY_DECIMAL

    LEA DX, lab_label
    MOV AH, 09h
    INT 21h
    MOV AX, lab_fee
    MOV DX, 0
    CALL DISPLAY_DECIMAL

    ; Determine percentage based on average score (same logic as calculation)
    LEA SI, student_averages
    MOV AL, BL
    MOV AH, 0
    ADD SI, AX
    MOV AL, [SI]  ; AL = average score

    LEA DX, scholarship_label
    MOV AH, 09h
    INT 21h

    CMP AL, 90       ; Average 90+ gets 30% scholarship
    JGE DISPLAY_THIRTY_PERCENT
    CMP AL, 80       ; Average 80+ gets 15% scholarship
    JGE DISPLAY_FIFTEEN_PERCENT
    LEA DX, percent_0    ; Average below 80 gets 0%
    JMP PRINT_PERCENT
DISPLAY_FIFTEEN_PERCENT:
    LEA DX, percent_15
    JMP PRINT_PERCENT
DISPLAY_THIRTY_PERCENT:
    LEA DX, percent_30
    JMP PRINT_PERCENT
ZERO_PERCENT:
    LEA DX, percent_0
PRINT_PERCENT:
    MOV AH, 09h
    INT 21h

    CMP WORD PTR [scholarship_applied+2], 0
    JNZ IS_APPLIED
    CMP WORD PTR [scholarship_applied], 0
    JZ NO_SCH_DISP
IS_APPLIED:
    LEA DX, minus_sign
    MOV AH, 09h
    INT 21h
    MOV AX, WORD PTR [scholarship_applied]
    MOV DX, WORD PTR [scholarship_applied+2]
    CALL DISPLAY_DECIMAL
    JMP DISP_TOTAL
NO_SCH_DISP:
    LEA DX, zero_fee
    MOV AH, 09h
    INT 21h

DISP_TOTAL:
    LEA DX, total_label
    MOV AH, 09h
    INT 21h
    MOV AX, WORD PTR [total_fee]
    MOV DX, WORD PTR [total_fee+2]
    CALL DISPLAY_DECIMAL

    POP DX CX BX AX
    RET
DISPLAY_FEES ENDP

; Displays DX:AX as RMxxx.xx (scaled by 100)
DISPLAY_DECIMAL PROC
    PUSH BX CX DX AX
    MOV BX, 100
    DIV BX           ; Divide DX:AX by 100, AX=quotient (integer), DX=remainder (decimal)
    CALL DISPLAY_NUMBER  ; Display integer AX
    MOV CX, DX       ; Save remainder
    LEA DX, decimal_point
    MOV AH, 09h
    INT 21h
    MOV AX, CX       ; Restore remainder
    CALL DISPLAY_TWO_DIGITS
    POP AX DX CX BX
    RET
DISPLAY_DECIMAL ENDP

; Display two digits (for decimal part)
DISPLAY_TWO_DIGITS PROC
    PUSH AX BX DX
    MOV BL, 10
    MOV AH, 0
    DIV BL       ; AL = tens, AH = ones
    MOV CL, AH   ; Save ones digit
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 02h
    INT 21h      ; Display tens
    MOV AL, CL   ; Restore ones
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 02h
    INT 21h      ; Display ones
    POP DX BX AX
    RET
DISPLAY_TWO_DIGITS ENDP

ENABLE_BLINK PROC
    MOV AX, 1003h  ; BIOS function to toggle intensity/blinking
    MOV BX, 0      ; 0 = enable intensity, 1 = enable blinking (but often reversed)
    INT 10h
    RET
ENABLE_BLINK ENDP

SET_TEXT_COLOR PROC
    ; AL = color attribute
    MOV BH, 0      ; Display page 0
    MOV BL, AL     ; Attribute in BL
    MOV AX, 0920h  ; Write char with attribute (space to set attribute)
    MOV CX, 1      ; One character
    INT 10h
    RET
SET_TEXT_COLOR ENDP

DISPLAY_BLINKING_CHAR PROC
    ; DL = char to display
    ; BL = color attribute (with blink bit)
    MOV BH, 0      ; Page 0
    MOV AH, 09h        ; Function: Write character with attribute
    MOV AL, DL         ; Character to display
    MOV CX, 1      ; One char
    INT 10h
    RET
DISPLAY_BLINKING_CHAR ENDP

TOGGLE_BLINK PROC
    MOV AX, 1003h  ; BIOS function to toggle intensity/blinking
    MOV BX, 0
    CMP AL, 1
    JNE TB_SET
    MOV BX, 1      ; 1 = enable blinking (background 0-7)
TB_SET:
    INT 10h
    RET
TOGGLE_BLINK ENDP
END MAIN