;Juego de la pelotita magica de 3 niveles

; Segmento de pila
pila segment stack
    db 64 dup('stack')
pila ends
; Fin de segmento de pila

; Segmento de datos
data segment
    eleccionJugador db ?   ; Almacena la eleccion del jugador
    vasoPelotita db ?      ; Almacena la posicion aleatoria de la pelotita
    intentos db 2       ; Cantidad de intentos permitidos
    msgVaso db 'La pelotita estaba en el vaso: $'
    msgVasoNum db '0', 10, 13, '$'  ; Almacena el numero del vaso 

    ; Mensajes Nivel 1 
    mensajeInicio db 10,13, 'Se ha guardado la pelota. Elige en que vaso esta la pelotita 1, 2 o 3: $'
    mensajeGanar db 10,13, '�Felicidades, has ganado! $'
    mensajePerder db 10,13, 'Perdiste, suerte para la proxima. $'
    mensajeIntento db 10,13, 'Intentalo de nuevo: $'
    mensajeError db 10,13, 'Entrada invalida. Solo puedes elegir entre 1, 2 o 3. $'
    mensajePresionarEnter db 10,13, 'Este es un juego de la pelotita magica, son tres niveles y cada nivel 2 oportuniades para adivinar, Suerte!!!:D Presiona Enter para empezar... $'
    
    mensajeVVV db 'V  V  V', 10, 13, '$'    
    mensajeVoV db 'V  o  V', 10, 13, '$'    
    mensajeVVo db 'V  V  o', 10, 13, '$'   
    mensajeoVV db 'o  V  V', 10, 13, '$'   

    ; Mensajes Nivel 2 
    mensajeInicioNivel2 db 10,13, 'Bienvenido al segundo nivel.  Elige en que vaso esta la pelotita 1, 2 , 3 o 4: $'
    mensajeGanarNivel2 db 10,13, '�Felicidades, has ganado el segundo nivel! $'
    mensajePerderNivel2 db 10,13, 'Perdiste en el segundo nivel, suerte para la proxima. $'
    mensajeIntentoNivel2 db 10,13, 'Intentalo de nuevo nivel 2: $'
    mensajeErrorNivel2 db 10,13, 'Entrada invalida. Solo puedes elegir entre 1, 2, 3 o 4. $'
    
    mensajeVVVV db 'V  V  V  V', 10, 13, '$'   
    mensajeVoVVV db 'V  o  V  V', 10, 13, '$'   
    mensajeVVVoV db 'V  V  V  o', 10, 13, '$'   
    mensajeVVoVV db 'V  V  o  V', 10, 13, '$'   
    mensajeoVVVV db 'o  V  V  V', 10, 13, '$' 

    ; Mensajes Nivel 3 
    mensajeInicioNivel3 db 10,13, 'Bienvenido al tercer nivel. Elige en que vaso esta la pelotita 1, 2 , 3 , 4 o 5: $'
    mensajeGanarNivel3 db 10,13, '�Felicidades, has ganado el tercer nivel! $'
    mensajePerderNivel3 db 10,13, 'Perdiste en el tercer nivel, suerte para la proxima. $'
    mensajeIntentoNivel3 db 10,13, 'Intentalo de nuevo nivel 3: $'
    mensajeErrorNivel3 db 10,13, 'Entrada invalida. Solo puedes elegir entre 1, 2, 3, 4 o 5. $'
    
    mensajeVVVVV db 'V  V  V  V  V', 10, 13, '$'   
    mensajeVoVVVV db 'V  o  V  V  V', 10, 13, '$'   
    mensajeVVVVoV db 'V  V  V  V  o', 10, 13, '$'   
    mensajeVVVoVV db 'V  V  V  o  V', 10, 13, '$'   
    mensajeVVoVVV db 'V  V  o  V  V', 10, 13, '$'   
    mensajeoVVVVV db 'o  V  V  V  V', 10, 13, '$'  
data ends

; Segmento de codigo
code segment
principal proc far
    assume cs:code, ds:data, ss:pila
    push ds
    push 0

    ; Inicializa los segmentos de datos
    mov ax, data
    mov ds, ax

   
    mov ah, 09
    lea dx, mensajePresionarEnter
    int 21h

    ; Esperar a que se inicie con enter
esperar_enter:
    mov ah, 01
    int 21h
    cmp al, 13   ; Verificar si es Enter
    jne esperar_enter

    ;Niveles 1, 2 y 3
    
   
    call nivel_1

   
    call nivel_2

    call nivel_3

fin:
    ; Finalizar el programa
    mov ah, 4Ch
    int 21h

principal endp  
 
 ; parte del nivel 1
nivel_1 proc
   
    mov intentos, 2

    ; posicion aleatoria entre 1, 2 , 3
generar_aleatorio_nivel1:
    mov ah, 2Ch               ; Obtener hora del sistema
    int 21h
    mov al, dl                ; Usar los centisegundos para obtener la base del numero
    add al, dh                ; Sumar los segundos para mayor variabilidad
    xor ah, ah
    div byte ptr 3            ; Dividir entre 3 para obtener un residuo entre 0 y 2
    add al, 1                 ; Ajustar para que sea 1, 2 o 3
    mov vasoPelotita, al      ; Almacenar la posicion de la pelota

  
    mov ah, 09
    lea dx, mensajeVVV
    int 21h

   ; remplaza el vaso
    mov al, vasoPelotita
    cmp al, 1
    je mostrar_oVV           
    cmp al, 2
    je mostrar_VoV          
    cmp al, 3
    je mostrar_VVo           

mostrar_oVV:
    mov ah, 09
    lea dx, mensajeoVV
    int 21h
    jmp pausa

mostrar_VoV:
    mov ah, 09
    lea dx, mensajeVoV
    int 21h
    jmp pausa

mostrar_VVo:
    mov ah, 09
    lea dx, mensajeVVo
    int 21h
    jmp pausa

pausa:
    ; Pausa de 3 segundos 
    mov ax, 8600h            ; Pausar
    mov cx, 0                ; Numero alto de milisegundos
    mov dx, 3000             ; 3000 ms 
    int 15h                  ; Llamada a la interrupcion

    ; Limpiar pantalla 
    mov ah, 06h        
    mov al, 0          ; Limpiar toda la pantalla
    mov bh, 07h        ; el blanco va encima del negro
    mov cx, 0          ; 
    mov dx, 184Fh      ; 
    int 10h            ; Interrupcion de video

    ; Restaurar VVV
    mov ah, 09
    lea dx, mensajeVVV
    int 21h

    ; Mostrar mensaje 
    mov ah, 09
    lea dx, mensajeInicio
    int 21h

repetir_intentos_nivel1:
    ; Obtener la eleccion del jugador
    mov ah, 01
    int 21h
    sub al, 30h       ; Convertir caracter a numero
    mov eleccionJugador, al  ; Almacenar eleccion 

    ; Verificar si que no sea menor o mayor al rango ose 123
    cmp eleccionJugador, 1; error
    jl mensaje_error_nivel1         
    cmp eleccionJugador, 3  ;error
    jg mensaje_error_nivel1        

    ; Comparar 
    mov al, vasoPelotita
    cmp al, eleccionJugador
    je gano_nivel1          ; Si son iguales, el jugador gana

    ; Si no adivina se le quita una vida
    dec intentos
    cmp intentos, 0
    je pierde_nivel1        ; Se terminaron los intentos, pierde :(

    ; Mostrar mensaje de intento fallido y se repite
    mov ah, 09
    lea dx, mensajeIntento
    int 21h
    jmp repetir_intentos_nivel1

mensaje_error_nivel1:
    ; Mostrar mensaje de entrada invalida
    mov ah, 09
    lea dx, mensajeError
    int 21h
    jmp repetir_intentos_nivel1     ; Reintentar

pierde_nivel1:
    ; Mostrar mensaje de perder
    mov ah, 09
    lea dx, mensajePerder
    int 21h

    ; Mostrar en que vaso estaba la pelotita
    mov al, vasoPelotita
    add al, 30h
    mov msgVasoNum, al
    mov ah, 09
    lea dx, msgVaso
    int 21h
    lea dx, msgVasoNum
    int 21h

    ; Terminar el programa si pierde se pierde en el segundo intento
    mov ah, 4Ch
    int 21h

gano_nivel1:
    ; Mostrar mensaje de victoria
    mov ah, 09
    lea dx, mensajeGanar
    int 21h
    ret

nivel_1 endp

; seccion del nivel 2_________________________________________________________________________________
nivel_2 proc
    
    mov intentos, 2

    ; Generar posicion 
generar_aleatorio_nivel2:
    mov ah, 2Ch               
    int 21h
    mov al, dl                
    add al, dh              
    xor ah, ah
    div byte ptr 4            
    add al, 1               
    mov vasoPelotita, al      ; Almacenar la posicion de la pelotita

    ; Mostrar mensaje de los vasos 
    mov ah, 09
    lea dx, mensajeVVVV
    int 21h

    ; Remplazar
    mov al, vasoPelotita
    cmp al, 1
    je mostrar_oVVVV          
    cmp al, 2
    je mostrar_VoVVV           
    cmp al, 3
    je mostrar_VVoVV           
    cmp al, 4
    je mostrar_VVVoV           

mostrar_oVVVV:
    mov ah, 09
    lea dx, mensajeoVVVV
    int 21h
    jmp pausa_nivel2

mostrar_VoVVV:
    mov ah, 09
    lea dx, mensajeVoVVV
    int 21h
    jmp pausa_nivel2

mostrar_VVoVV:
    mov ah, 09
    lea dx, mensajeVVoVV
    int 21h
    jmp pausa_nivel2

mostrar_VVVoV:
    mov ah, 09
    lea dx, mensajeVVVoV
    int 21h
    jmp pausa_nivel2

pausa_nivel2:
    ; Pausa de 3 segundos 
    mov ax, 8600h            ; pausar
    mov cx, 0               
    mov dx, 3000             ; 3000 ms 
    int 15h                  ; Llamada a la interrupcion

    ; Limpiar pantalla 
    mov ah, 06h        
    mov al, 0       ;Limpiar toda la pantalla
    mov bh, 07h      
    mov cx, 0          
    int 10h            ; Interrupcion de video 

    ; Restaurar VVVV
    mov ah, 09
    lea dx, mensajeVVVV
    int 21h

    ; msg de inicio 2 
    mov ah, 09
    lea dx, mensajeInicioNivel2
    int 21h

repetir_intentos_nivel2:
    ; Obtener la eleccion del jugador
    mov ah, 01
    int 21h
    sub al, 30h       ; Convertir el caracter a numero
    mov eleccionJugador, al  ; Almacenar eleccion del jugador

    ; Verificar que no ocupemos otra tecla que no sea 1,2,3,4
    cmp eleccionJugador, 1
    jl mensaje_error_nivel2        
    cmp eleccionJugador, 4
    jg mensaje_error_nivel2        

    ; Comparar la eleccion
    mov al, vasoPelotita
    cmp al, eleccionJugador
    je gano_nivel2          ; Si son iguales, el jugador gana

    ;perdio 
    dec intentos
    cmp intentos, 0
    je pierde_nivel2        ; Se terminaron los intentos, pierde :(

    ; Mostrar mensaje de intento fallido y se repite
    mov ah, 09
    lea dx, mensajeIntentoNivel2
    int 21h
    jmp repetir_intentos_nivel2

mensaje_error_nivel2:
    ; Mostrar mensaje de entrada invalida
    mov ah, 09
    lea dx, mensajeErrorNivel2
    int 21h
    jmp repetir_intentos_nivel2     ; Reintentar

pierde_nivel2:
    ; Mostrar mensaje de perdida
    mov ah, 09
    lea dx, mensajePerderNivel2
    int 21h

    ; Muestra que vaso esta pelotita
    mov al, vasoPelotita
    add al, 30h
    mov msgVasoNum, al
    mov ah, 09
    lea dx, msgVaso
    int 21h
    lea dx, msgVasoNum
    int 21h

   ;termina el programa
    mov ah, 4Ch
    int 21h

gano_nivel2:
    ; Mostrar mensaje que se a ganado 
    mov ah, 09
    lea dx, mensajeGanarNivel2
    int 21h
    ret

nivel_2 endp

; seccion nivel3 ______________________________________________________________
nivel_3 proc
    ; Reiniciar intentos
    mov intentos, 2

    ; Generar posicion
generar_aleatorio_nivel3:
    mov ah, 2Ch               
    int 21h
    mov al, dl                
    add al, dh                
    xor ah, ah
    div byte ptr 5            
    add al, 1                 ; Ajustar para que sea 1, 2, 3, 4 o 5
    mov vasoPelotita, al      ; Almacenar la posicion de la pelotita

    ; Mostrar mensaje de los vasos
    mov ah, 09
    lea dx, mensajeVVVVV
    int 21h

    ; remplazar
    mov al, vasoPelotita
    cmp al, 1
    je mostrar_oVVVVV           
    cmp al, 2
    je mostrar_VoVVVV           
    cmp al, 3
    je mostrar_VVoVVV          
    cmp al, 4
    je mostrar_VVVoVV           
    cmp al, 5
    je mostrar_VVVVoV           

mostrar_oVVVVV:
    mov ah, 09
    lea dx, mensajeoVVVVV
    int 21h
    jmp pausa_nivel3

mostrar_VoVVVV:
    mov ah, 09
    lea dx, mensajeVoVVVV
    int 21h
    jmp pausa_nivel3

mostrar_VVoVVV:
    mov ah, 09
    lea dx, mensajeVVoVVV
    int 21h
    jmp pausa_nivel3

mostrar_VVVoVV:
    mov ah, 09
    lea dx, mensajeVVVoVV
    int 21h
    jmp pausa_nivel3

mostrar_VVVVoV:
    mov ah, 09
    lea dx, mensajeVVVVoV
    int 21h
    jmp pausa_nivel3

pausa_nivel3:
    ; Pausa de 3 segundos 
    mov ax, 8600h            ; pausar
    mov cx, 0                
    mov dx, 3000             ; 3000 ms 
    int 15h                  ; Llamada a la interrupcion

    ; Limpiar pantalla antes de V
    mov ah, 06h       
    mov al, 0          ; Limpiar toda la pantalla
    mov bh, 07h        ; Atributo para que el blanco este arriba del negro
    mov cx, 0          
    mov dx, 184Fh     
    int 10h            ; Interrupci�n de video 

    ; Restaurar VVVVV
    mov ah, 09
    lea dx, mensajeVVVVV
    int 21h

    ; Mostrar inicio nivel 3
    mov ah, 09
    lea dx, mensajeInicioNivel3
    int 21h

repetir_intentos_nivel3:
    ; Obtener la eleccion de jugador
    mov ah, 01
    int 21h
    sub al, 30h       ; Convertir caracter a numero
    mov eleccionJugador, al  ; Almacenar eleccion 

    ; Verificar que no nos pasemos xd 
    cmp eleccionJugador, 1
    jl mensaje_error_nivel3        
    cmp eleccionJugador, 5
    jg mensaje_error_nivel3         

    ; Comparar la eleccion del jugador con la posicion de la pelotita
    mov al, vasoPelotita
    cmp al, eleccionJugador
    je gano_nivel3          ; Si son iguales, el jugador gana

    ; Si no reduce los intentos y verifica si aun queda 
    dec intentos
    cmp intentos, 0
    je pierde_nivel3        ; Se terminaron los intentos, pierde :(

    ; Mostrar mensaje de intento fallido y se repite
    mov ah, 09
    lea dx, mensajeIntentoNivel3
    int 21h
    jmp repetir_intentos_nivel3

mensaje_error_nivel3:
    ; Mostrar mensaje de entrada invalida
    mov ah, 09
    lea dx, mensajeErrorNivel3
    int 21h
    jmp repetir_intentos_nivel3     ; Reintentar

pierde_nivel3:
    ; Mostrar mensaje de perdida
    mov ah, 09
    lea dx, mensajePerderNivel3
    int 21h

    ; Mostrar en que vaso estaba la pelotita
    mov al, vasoPelotita
    add al, 30h
    mov msgVasoNum, al
    mov ah, 09
    lea dx, msgVaso
    int 21h
    lea dx, msgVasoNum
    int 21h

    ; Terminar el programa si pierde en el segundo intento
    mov ah, 4Ch
    int 21h

gano_nivel3:
    ; Mostrar mensaje si ganaste 
    mov ah, 09
    lea dx, mensajeGanarNivel3
    int 21h
    ret

nivel_3 endp

code ends
end principal
