;; defining constants, you can use these as immediate values in your code
CACHE_LINES  EQU 100
CACHE_LINE_SIZE EQU 8
OFFSET_BITS  EQU 3
TAG_BITS EQU 29 ; 32 - OFSSET_BITS


section .text
    global load
    extern printf

;; void load(char* reg, char** tags, char cache[CACHE_LINES][CACHE_LINE_SIZE], char* address, int to_replace);
load:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; address of reg
    mov ebx, [ebp + 12] ; tags
    mov ecx, [ebp + 16] ; cache
    mov edx, [ebp + 20] ; address
    mov edi, [ebp + 24] ; to_replace (index of the cache line that needs to be replaced in case of a cache MISS)
    ;; DO NOT MODIFY

    ;; TODO: Implment load
    ;; FREESTYLE STARTS HERE
    shr edx, OFFSET_BITS ;obtinem tag-ul
    
    xor edi, edi        ; EDI va reprezenta linia din cache in care se afla octetul de la address
                        ; parcurgem vectorul de tags cu edi pt a gasi 
                        ; linia pe care se afla tag-ul adresei date
    tag_search:         ; cautam tag-ul in tags
        cmp [ebx + CACHE_LINE_SIZE * edi], edx
        je  set_reg     ; daca il gasim, luam din cache valoarea de la linia EDI
        inc edi
        cmp edi, CACHE_LINES
        jne tag_search  ; daca EDI e mai mare decat CACHE_LINES, inseamna ca tag-ul cerut nu exista
        
    mov edi, [ebp + 24] ; daca nu gasim un tag in tags, vom pune in cache 
                        ; octetul si grupul de 8 bytes in care este pe linia to_replace 
    mov [ebx + CACHE_LINE_SIZE * edi], edx ; punem tagul adresei in tags la linia to_replace
    lea ebx, [ecx + CACHE_LINE_SIZE * edi] ; adresa liniei de index to_replace din cache
    shl edx, OFFSET_BITS    ; transformam tag-ul in adresa
    mov esi, [edx]          ; punem primii 4 octeti in cache
    mov dword[ebx], esi
    mov esi, [edx + 4]      ; punem ultimii 4 octeti in cache
    mov dword[ebx + 4], esi
    shr edx, OFFSET_BITS    ; transformam adresa inapoi in tag
    
set_reg:
    lea ebx, [ecx + CACHE_LINE_SIZE*edi] ; adresa liniei cu octetul cerut din cache
    mov esi, [ebp + 20]
    shl edx, OFFSET_BITS    ; transformam tag-ul in adresa
    sub esi, edx            ; offsetul in linie
    mov dl, byte[ebx + esi] ; citim din cache octetul cerut
    mov byte[eax], dl       ; il scriem in "registru"
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY


