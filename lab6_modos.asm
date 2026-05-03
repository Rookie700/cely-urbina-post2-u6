; lab6_modos.asm - Demostración de modos de direccionamiento x86
; Compilar: nasm -f bin lab6_modos.asm -o lab6_modos.com

org 100h

jmp inicio

; --- ESTRUCTURA DE DATOS ---
array       dw 10, 20, 30, 40, 50   ; Array de 5 enteros (16 bits)
nota1       dw 85                   ; Campo 1 de "struct"
nota2       dw 73                   ; Campo 2 de "struct"
promedio    dw 0                    ; Campo 3 para resultado
var_x       dw 0FFFFh               ; Variable simple

inicio:
    ; --- MODO 1: INMEDIATO (Valor en la instrucción) ---
    mov ax, 100         ; El valor 100 (64h) está en el código
    mov bx, 0A5h        ; Constante hexadecimal

    ; --- MODO 2: DIRECTO (Dirección fija) ---
    mov ax, [var_x]     ; AX = Contenido de la dirección var_x
    mov bx, [array]     ; BX = 10 (primer elemento del array)

    ; --- MODO 3: INDIRECTO POR REGISTRO (Punteros) ---
    mov si, nota1       ; SI apunta a la dirección de nota1
    mov ax, [si]        ; AX = 85 (vía puntero SI)
    mov si, nota2       ; SI apunta a nota2
    mov bx, [si]        ; BX = 73 (vía puntero SI)
    
    ; Cálculo de promedio usando punteros
    add ax, bx          ; AX = 85 + 73 = 158
    shr ax, 1           ; AX = 79 (división por 2)
    mov si, promedio
    mov [si], ax        ; Escribe 79 en memoria vía puntero

    ; --- MODO 4: INDEXADO (Base + Índice) ---
    ; Suma del array: AX = acumulador, BX = base, SI = índice
    xor ax, ax          ; Limpiar acumulador
    mov bx, array       ; BX = dirección base
    mov cx, 5           ; Contador
    xor si, si          ; SI = 0 (índice inicial)

.bucle_array:
    add ax, [bx + si]   ; Dirección Efectiva = BX + SI
    add si, 2           ; Siguiente word (2 bytes)
    loop .bucle_array   ; Al final AX = 150 (96h)

    int 20h             ; Fin del programa