# Laboratorio: Modos de Direccionamiento (Unidad 6 - Parte 2)
**Estudiante:** [Tu Apellido]  
**Carrera:** Ingeniería de Sistemas  
**Materia:** Arquitectura de Computadores  

## 1. Introducción
Este laboratorio tiene como objetivo implementar y verificar mediante depuración técnica los cuatro modos de direccionamiento principales de la arquitectura x86:
*   **Inmediato:** El dato forma parte de la instrucción.
*   **Directo:** La dirección de memoria es fija y está en el código.
*   **Indirecto por Registro:** Se accede a la memoria mediante un puntero (registro).
*   **Indexado:** Cálculo de dirección mediante Base + Índice + Desplazamiento[cite: 2].

---

## 2. Resumen de Modos de Direccionamiento Observados

| Modo de Direccionamiento | Fórmula de Dirección Efectiva | Instrucción Implementada | Valor/Resultado en DEBUG |
| :--- | :--- | :--- | :--- |
| **Inmediato** | Operando = Valor constante | `MOV AX, 100` | `AX = 0064h`[cite: 2] |
| **Directo** | EA = [Desplazamiento] | `MOV AX, [var_x]` | `AX = FFFFh`[cite: 2] |
| **Indirecto** | EA = [Registro] | `MOV AX, [SI]` | `AX = 0055h` (85d)[cite: 2] |
| **Indexado** | EA = [Base + Índice] | `ADD AX, [BX + SI]` | `AX = 0096h` (150d)[cite: 2] |

---

## 3. Evidencias de Checkpoints

### Checkpoint 1: Volcado de Memoria (Dump)
Se verificó la disposición de los datos en el segmento de datos (`DS`). En el volcado hexadecimal se identificaron los valores del array (Little-endian) y las notas del estudiante[cite: 2].
*   **Comando:** `D DS:100`
![Memory Dump](capturas/checkpoint1_dump.png)

### Checkpoint 2: Trazado del Modo Indirecto
Usando el comando `T` (Trace) en DEBUG, se documentó el comportamiento de los registros al usar `SI` como puntero[cite: 2]:
1.  `MOV SI, nota1`: El registro `SI` recibe la dirección efectiva de la variable[cite: 2].
2.  `MOV AX, [SI]`: El registro `AX` se carga con el valor `0055h` (85 decimal)[cite: 2].
![Indirect Trace](capturas/checkpoint2_trace.png)

### Checkpoint 3: Suma de Array y Recorrido Inverso
Se validó que el acumulador `AX` contiene `0096h` (150 decimal) tras sumar los 5 elementos del array mediante direccionamiento indexado[cite: 2].
*   **Extensión:** Se implementó una variante del bucle que recorre el array en orden inverso, inicializando `SI` en `8` y aplicando `SUB SI, 2` en cada iteración[cite: 2].
![Final Result](capturas/checkpoint3_final.png)

---

## 4. Conclusiones Técnicas
*   **Modo Inmediato:** Es el más rápido ya que no requiere acceso a la memoria de datos, el valor se lee junto con la instrucción en el segmento de código[cite: 2].
*   **Punteros:** El direccionamiento indirecto por registro es la base de los punteros en lenguajes de alto nivel; permite que una misma instrucción procese diferentes datos cambiando solo el valor del registro[cite: 2].
*   **Eficiencia:** El modo indexado es ideal para estructuras de datos complejas (arrays y structs), permitiendo recorrer colecciones de forma dinámica mediante el registro índice[cite: 2].
