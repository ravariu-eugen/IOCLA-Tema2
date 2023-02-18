section .data
    extern len_cheie, len_haystack

section .text
    global columnar_transposition

;; void columnar_transposition(int key[], char *haystack, char *ciphertext);
columnar_transposition:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha 

    mov edi, [ebp + 8]   ;key
    mov esi, [ebp + 12]  ;haystack
    mov ebx, [ebp + 16]  ;ciphertext
    ;; DO NOT MODIFY

    ;; TODO: Implment columnar_transposition
    ;; FREESTYLE STARTS HERE
    mov ecx, [len_cheie]
    key_loop:
        mov eax, [edi]  ; citim coloana care trebuie parcursa
        col_loop:
            xor edx, edx
            mov dl, byte[esi + eax] ; citim byte-ul din haystack
            mov byte[ebx], dl       ; il scriem in ciphertext
            inc ebx
            add eax, [len_cheie]    ; trecem la pozitia urmatoare
            cmp eax, [len_haystack] ; daca iesim din sir, terminam parcurgerea coloanei
            jb col_loop 
        add edi, 4  ; trecem la urmatorul element din key
        loop key_loop
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY