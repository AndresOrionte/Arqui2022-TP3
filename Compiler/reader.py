def divide_into_registers(data):
    registers = [data[i:i + 8] for i in range(0, 520, 8)]
    return registers

def print_registers(registers):
    register_names = ['PC', 'R0', 'R1', 'R2', 'R3', 'R4', 'R5', 'R6', 'R7', 'R8', 'R9', 'R10', 'R11', 'R12', 'R13', 'R14', 'R15', 'R16', 'R17', 'R18', 'R19', 'R20', 'R21', 'R22', 'R23', 'R24', 'R25', 'R26', 'R27', 'R28', 'R29', 'R30', 'R31',
                      'M0', 'M1', 'M2', 'M3', 'M4', 'M5', 'M6', 'M7', 'M8', 'M9', 'M10', 'M11', 'M12', 'M13', 'M14', 'M15', 'M16', 'M17', 'M18', 'M19', 'M20', 'M21', 'M22', 'M23', 'M24', 'M25', 'M26', 'M27', 'M28', 'M29', 'M30', 'M31']
    
    for i, value in enumerate(registers):
        if (i%5==0):
            print("\n")
        print(f"{register_names[i]}: {value}",end=" ")

def write_registers(registers, file):
    register_names = ['PC', 'R0', 'R1', 'R2', 'R3', 'R4', 'R5', 'R6', 'R7', 'R8', 'R9', 'R10', 'R11', 'R12', 'R13', 'R14', 'R15', 'R16', 'R17', 'R18', 'R19', 'R20', 'R21', 'R22', 'R23', 'R24', 'R25', 'R26', 'R27', 'R28', 'R29', 'R30', 'R31',
                      'M0', 'M1', 'M2', 'M3', 'M4', 'M5', 'M6', 'M7', 'M8', 'M9', 'M10', 'M11', 'M12', 'M13', 'M14', 'M15', 'M16', 'M17', 'M18', 'M19', 'M20', 'M21', 'M22', 'M23', 'M24', 'M25', 'M26', 'M27', 'M28', 'M29', 'M30', 'M31']
    
    for i, value in enumerate(registers):
        if (i%5==0):
            file.write("\n")
        cadena = ""+ register_names[i]+ " "+ value + " "
        file.write(cadena)

def main():
    #user_input = input("Ingrese 520 caracteres en formato hexadecimal: ")

    try:
        cap_file = open("Compiler\RT_Capture.txt", encoding='utf-8')
        capture = cap_file.read()
    finally:
        cap_file.close()

    if len(capture) != 520:
        print("Error: Debe ingresar exactamente 520 caracteres en formato hexadecimal.")
        return
    
    registers = divide_into_registers(capture)
    #print_registers(registers)

    cap_file.close()


    trad_file = open("Compiler\Formateo.txt", "w")

    write_registers(registers, trad_file)

    trad_file.close()

if __name__ == "__main__":
    main()
    
# INSTRUCCIONES: compilarlo, y luego te va a pedir los 520 caracteres
# EJ DE 520 CARACTERES
# 234a1b6c3d7e9f0a2534b6c3d7e9f0a2534b6c3d234a1b6c3d7e7e9f0a2534b6c3d7e9f0a2534b6c3d7e9f0a2534b6c3d7e9f0a2534b6c3d7e9f0a2534b6c3d7e9f0a2534b6c3d7e9f0a2534b6c3d7e9f0a2534b6c3d7e9f0a2534b6c3d7e9f0a2534b6c3d7e9f0a2534b6c3d7e9f0a2534b6c3d7e9f0a2534b6c3d7e9f0a2534b6c3d7e9f0a2534b6c3d7e9f0a2534b6c3d7e9f0a2534b6c3d7e9f0a2534b6c3d7e9f0a2534b6c3d7e9f0a2534b6c3d7e9f0a2534b6c3d7e9f0a2534b6c3d7e9f0a2534b6c3d7e9f0a2534b6c3d7e9f0a2534b6c3d7e9f0a2534b6c3d7e9f0a2534b6c3d7e9f0a2534b6c3d7e9f0a2534b6c3d7e9f0a2534b6c3d7e9f0a2534b6c34b6c