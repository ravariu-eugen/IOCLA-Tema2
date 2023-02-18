; This is your structure
struc  my_date
    .day: resw 1
    .month: resw 1
    .year: resd 1
endstruc

section .text
    global ages
; void ages(int len, struct my_date* present, struct my_date* dates, int* all_ages);
ages:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; present
    mov     edi, [ebp + 16] ; dates
    mov     ecx, [ebp + 20] ; all_ages
    ;; DO NOT MODIFY

    ;; TODO: Implement ages
    ;; FREESTYLE STARTS HERE
    age_loop:
    
        mov     eax, dword[esi + my_date.year]  ; calculam diferenta dintre anul curent
        sub     eax, dword[edi + my_date.year]  ; si anul nasterii
        je      add_age                         ; daca e egala cu zero, o scriem in vector
        jg      age_above_zero                  ; daca e mai mare ca zero, 
                                                ; verificam diferenta dintre luni
    age_below_zero:                             ; daca e mai mica ca zero, o aducem la 0 
        xor     eax, eax                        ; si o scriem in vector
        jmp     add_age 
    age_above_zero: 
        mov     bx,  word[esi + my_date.month]  ; calculam diferenta dintre luna curenta
        sub     bx,  word[edi + my_date.month]  ; si luna nasterii
        jg      add_age                         
        jl      dec_year    
        mov     bx,  word[esi + my_date.day]    ; calculam diferenta dintre ziua curenta
        sub     bx,  word[edi + my_date.day]    ; si ziua nasterii
        jge     add_age
    
    dec_year:   ; decremetam valoarea varstei 
        dec     eax
    
    add_age:    ; adaugam varsta in vector
        mov     dword[ecx], eax
        add     ecx, 4
        add     edi, 8
        dec     edx
        jnz     age_loop
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
