

section .text
    global rotp

;; void rotp(char *ciphertext, char *plaintext, char *key, int len);
rotp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; ciphertext
    mov     esi, [ebp + 12] ; plaintext
    mov     edi, [ebp + 16] ; key
    mov     ecx, [ebp + 20] ; len
    ;; DO NOT MODIFY

    ;; TODO: Implment rotp
    ;; FREESTYLE STARTS HERE
    xor     ebx,ebx ; folosim ebx pentru a parcurge sirul plaintext de la inceput
                    ; ecx e folosit pentru a parcurge sirul key de la inceput
    xor_loop:
        mov     al, byte[esi + ebx]
        mov     ah, byte[edi + ecx - 1]
        xor     al, ah
        mov     byte[edx + ebx], al ; punem in ciphertext octetul incifrat

        inc     ebx
        loop xor_loop

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY