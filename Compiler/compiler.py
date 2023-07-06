# La sintaxis de una operacion seria la siguiente: 
# Nombre de la operación + reg destino + reg1 + reg2 / inmediato.
import re

class AssemblerTranslator:

    def tokenizer(self, program_asm):
        lines = program_asm.readlines()
        tokens = []
        regex_format = (r'(?m)(\w+)\s+(-{0,1}\w+)\s*,\s*(-{0,1}\w+)\s*,\s*(-{0,1}\w+)\s*$'
                            + r'|(?m)(\w+)\s+(-{0,1}\w+)\s*,\s*(-{0,1}\w+)\s*$'
                            + r'|(?m)(\w+)\s+(-{0,1}\w+)\s*$') 

        # Parseo las lineas, remuevo trailing y spliteo en tokens
        for raw_line in lines:
            line = raw_line.replace('\n', '')
            tokens.append(list(filter(None, re.split(string=line, pattern=regex_format))))

        return tokens
    
    # Convierte registros o numeros enteros, a string binario
    def to_binary(self, str, n_bits):
        bin_str = ''

        matches = re.search('R{0,1}(-{0,1}\d+)', str)
        if matches == None:
            return "No matching regex condition"

        num = int(matches[1])

        if num < 0:
            bin_str = format(num & 0xffffffff, '32b')
        else:
            bin_str = '{:032b}'.format(num)

        return bin_str[32-n_bits:]
    
    
    def set_opcode(self, inst, opcode):
        return opcode + inst[6:]
    
    # Instrucciones Jump tienen 26b de destino
    def set_dest_jump(self, inst, dest):
        dest = self.to_binary(dest, 26)
        return inst[0:6] + dest
    
    # Instrucciones Jump tienen 16b de destino
    def set_dest_branch(self, inst, dest):
        dest = self.to_binary(dest, 16)
        return inst[0:16] + dest
    
    def set_rs(self, inst, rs):
        rs = self.to_binary(rs, 5)
        return inst[0:6] + rs + inst[11:]
    
    def set_rt(self, inst, rt):
        rt = self.to_binary(rt, 5)
        return inst[0:11] + rt + inst[16:]
    
    def set_rd(self, inst, rd):
        rd = self.to_binary(rd, 5)
        return inst[0:16] + rd + inst[21:]
    
    # Offset o Inmediato, sirve para cualquiera de los 2
    def set_inmed(self, inst, inmed):
        inmed = self.to_binary(inmed, 16)
        return inst[0:16] + inmed

    def instruction_generator(self, token):
        inst_bin = "00000000000000000000000000000000"
        i_name = token[0]
        if i_name == "SLL":
            inst_bin = self.set_opcode(inst_bin, "011100")
            inst_bin = self.set_rt(inst_bin, token[1])
            inst_bin = self.set_rs(inst_bin, token[2])
            inst_bin = self.set_inmed(inst_bin, token[3])
        elif i_name == "SRL":
            inst_bin = self.set_opcode(inst_bin, "011010")
            inst_bin = self.set_rt(inst_bin, token[1])
            inst_bin = self.set_rs(inst_bin, token[2])
            inst_bin = self.set_inmed(inst_bin, token[3])
        elif i_name == "SRA":
            inst_bin = self.set_opcode(inst_bin, "011001")
            inst_bin = self.set_rt(inst_bin, token[1])
            inst_bin = self.set_rs(inst_bin, token[2])
            inst_bin = self.set_inmed(inst_bin, token[3])
        elif i_name == "SLLV":
            inst_bin = self.set_opcode(inst_bin, "001100")
            inst_bin = self.set_rd(inst_bin, token[1])
            inst_bin = self.set_rs(inst_bin, token[2])
            inst_bin = self.set_rt(inst_bin, token[3])
        elif i_name == "SRLV":
            inst_bin = self.set_opcode(inst_bin, "001010")            
            inst_bin = self.set_rd(inst_bin, token[1])
            inst_bin = self.set_rs(inst_bin, token[2])
            inst_bin = self.set_rt(inst_bin, token[3])
        elif i_name == "SRAV":
            inst_bin = self.set_opcode(inst_bin, "001001")
            inst_bin = self.set_rd(inst_bin, token[1])
            inst_bin = self.set_rs(inst_bin, token[2])
            inst_bin = self.set_rt(inst_bin, token[3])
        elif i_name == "ADDU":
            inst_bin = self.set_opcode(inst_bin, "000001")
            inst_bin = self.set_rd(inst_bin, token[1])
            inst_bin = self.set_rs(inst_bin, token[2])
            inst_bin = self.set_rt(inst_bin, token[3])
        elif i_name == "SUBU":
            inst_bin = self.set_opcode(inst_bin, "000010")
            inst_bin = self.set_rd(inst_bin, token[1])
            inst_bin = self.set_rs(inst_bin, token[2])
            inst_bin = self.set_rt(inst_bin, token[3])
        elif i_name == "AND":
            inst_bin = self.set_opcode(inst_bin, "000011")
            inst_bin = self.set_rd(inst_bin, token[1])
            inst_bin = self.set_rs(inst_bin, token[2])
            inst_bin = self.set_rt(inst_bin, token[3])
        elif i_name == "OR":
            inst_bin = self.set_opcode(inst_bin, "000100")
            inst_bin = self.set_rd(inst_bin, token[1])
            inst_bin = self.set_rs(inst_bin, token[2])
            inst_bin = self.set_rt(inst_bin, token[3])
        elif i_name == "XOR":
            inst_bin = self.set_opcode(inst_bin, "000101")
            inst_bin = self.set_rd(inst_bin, token[1])
            inst_bin = self.set_rs(inst_bin, token[2])
            inst_bin = self.set_rt(inst_bin, token[3])
        elif i_name == "NOR":
            inst_bin = self.set_opcode(inst_bin, "000110")
            inst_bin = self.set_rd(inst_bin, token[1])
            inst_bin = self.set_rs(inst_bin, token[2])
            inst_bin = self.set_rt(inst_bin, token[3])
        elif i_name == "SLT":
            inst_bin = self.set_opcode(inst_bin, "001000")
            inst_bin = self.set_rd(inst_bin, token[1])
            inst_bin = self.set_rs(inst_bin, token[2])
            inst_bin = self.set_rt(inst_bin, token[3])
        elif i_name == "LB":
            inst_bin = self.set_opcode(inst_bin, "100000")
            inst_bin = self.set_rt(inst_bin, token[1])
            inst_bin = self.set_rs(inst_bin, token[2])      #Base del offset, igual para todos los LOAD y STORE
            inst_bin = self.set_inmed(inst_bin, token[3])
        elif i_name == "LH":
            inst_bin = self.set_opcode(inst_bin, "100010")
            inst_bin = self.set_rt(inst_bin, token[1])
            inst_bin = self.set_rs(inst_bin, token[2])
            inst_bin = self.set_inmed(inst_bin, token[3])
        elif i_name == "LW":
            inst_bin = self.set_opcode(inst_bin, "100100")
            inst_bin = self.set_rt(inst_bin, token[1])
            inst_bin = self.set_rs(inst_bin, token[2])
            inst_bin = self.set_inmed(inst_bin, token[3])
        elif i_name == "LHU":
            inst_bin = self.set_opcode(inst_bin, "100011")
            inst_bin = self.set_rt(inst_bin, token[1])
            inst_bin = self.set_rs(inst_bin, token[2])
            inst_bin = self.set_inmed(inst_bin, token[3])
        elif i_name == "LBU":
            inst_bin = self.set_opcode(inst_bin, "100001")
            inst_bin = self.set_rt(inst_bin, token[1])
            inst_bin = self.set_rs(inst_bin, token[2])
            inst_bin = self.set_inmed(inst_bin, token[3])
        elif i_name == "SB":
            inst_bin = self.set_opcode(inst_bin, "101001")
            inst_bin = self.set_rt(inst_bin, token[1])
            inst_bin = self.set_rs(inst_bin, token[2])
            inst_bin = self.set_inmed(inst_bin, token[3])
        elif i_name == "SH":
            inst_bin = self.set_opcode(inst_bin, "101010")
            inst_bin = self.set_rt(inst_bin, token[1])
            inst_bin = self.set_rs(inst_bin, token[2])
            inst_bin = self.set_inmed(inst_bin, token[3])
        elif i_name == "SW":
            inst_bin = self.set_opcode(inst_bin, "101100")
            inst_bin = self.set_rt(inst_bin, token[1])
            inst_bin = self.set_rs(inst_bin, token[2])
            inst_bin = self.set_inmed(inst_bin, token[3])

        elif i_name == "ADDI":
            inst_bin = self.set_opcode(inst_bin, "010001")
            inst_bin = self.set_rt(inst_bin, token[1])
            inst_bin = self.set_rs(inst_bin, token[2])
            inst_bin = self.set_inmed(inst_bin, token[3])
        elif i_name == "SUBI":
            inst_bin = self.set_opcode(inst_bin, "010010")
            inst_bin = self.set_rt(inst_bin, token[1])
            inst_bin = self.set_rs(inst_bin, token[2])
            inst_bin = self.set_inmed(inst_bin, token[3])
        elif i_name == "ANDI":
            inst_bin = self.set_opcode(inst_bin, "010011")
            inst_bin = self.set_rt(inst_bin, token[1])
            inst_bin = self.set_rs(inst_bin, token[2])
            inst_bin = self.set_inmed(inst_bin, token[3])
        elif i_name == "ORI":
            inst_bin = self.set_opcode(inst_bin, "010100")
            inst_bin = self.set_rt(inst_bin, token[1])
            inst_bin = self.set_rs(inst_bin, token[2])
            inst_bin = self.set_inmed(inst_bin, token[3])
        elif i_name == "XORI":
            inst_bin = self.set_opcode(inst_bin, "010101")
            inst_bin = self.set_rt(inst_bin, token[1])
            inst_bin = self.set_rs(inst_bin, token[2])
            inst_bin = self.set_inmed(inst_bin, token[3])
        elif i_name == "LUI":
            inst_bin = self.set_opcode(inst_bin, "010111")
            inst_bin = self.set_rt(inst_bin, token[1])
            inst_bin = self.set_inmed(inst_bin, token[2])
            
        elif i_name == "SLTI":
            inst_bin = self.set_opcode(inst_bin, "011000")
            inst_bin = self.set_rt(inst_bin, token[1])
            inst_bin = self.set_rs(inst_bin, token[2])
            inst_bin = self.set_inmed(inst_bin, token[3])
        elif i_name == "BEQ":
            inst_bin = self.set_opcode(inst_bin, "110100")
            inst_bin = self.set_dest_branch(inst_bin, token[1])
            inst_bin = self.set_rs(inst_bin, token[2])
            inst_bin = self.set_rt(inst_bin, token[3])
        elif i_name == "BNE":
            inst_bin = self.set_opcode(inst_bin, "110101")
            inst_bin = self.set_dest_branch(inst_bin, token[1])
            inst_bin = self.set_rs(inst_bin, token[2])
            inst_bin = self.set_rt(inst_bin, token[3])
        elif i_name == "J":
            inst_bin = self.set_opcode(inst_bin, "110000")
            inst_bin = self.set_dest_jump(inst_bin, token[1])
        elif i_name == "JAL":
            inst_bin = self.set_opcode(inst_bin, "110001")
            inst_bin = self.set_dest_jump(inst_bin, token[1])
        elif i_name == "JR":
            inst_bin = self.set_opcode(inst_bin, "110010")
            inst_bin = self.set_rs(inst_bin, token[1])
        elif i_name == "JALR":
            inst_bin = self.set_opcode(inst_bin, "110011")
            inst_bin = self.set_rd(inst_bin, token[1])
            inst_bin = self.set_rs(inst_bin, token[2])
        elif i_name == "NOP":
            inst_bin = "00000000000000000000000000000000"
        elif i_name == "HALT":
            inst_bin = "11111111111111111111111111111111"
            
        else:
            print(i_name, ": Not recognized instruction")
            
        return inst_bin
    
    
# Abro el archivo, lo tokenizo, y a estos tokens los traduzco a binario.
# El resultado se muestra por consola, tratar de implementar un .txt
binary_code = ""
asm_tokens = []
asm = AssemblerTranslator()

try:
    asm_file = open("./Compiler/program.asm", encoding='utf-8')
    asm_tokens = asm.tokenizer(asm_file)
finally:
    asm_file.close()


# En decimal
try:
    d_file = open("./Compiler/decimal_code.txt", "w")
    print(len(asm_tokens), end=' ')                     #PC
    for inst in asm_tokens:
        binary_code = asm.instruction_generator(inst)
        for i in range(0, len(binary_code), 8):
            d_chunk = binary_code[i:i+8]
            decimal_value = str(int(d_chunk, 2))
            d_file.write(decimal_value + ' ')           #ESCRIBO EN EL ARCHIVO EL VALOR EN DECIMAL, SEPARADO POR ESPACIO PARA QUE QUEDE EN LA MISMA LINEA
            print(decimal_value, end=' ')
finally:
    d_file.close()

# # En binario
# try:
#     bin_file = open("./Compiler/binary_code.txt", "w")
#     for inst in asm_tokens:
#         binary_code = asm.instruction_generator(inst)
#         bin_file.write(binary_code)
#         for i in range(0, len(binary_code), 8):
#             binary_chunk = binary_code[i:i+8]
#             print(binary_chunk)
# finally:
#     bin_file.close()
 
# # En hexa
# hex_code = ""
# try:
#     hex_file = open("./Compiler/hex_code.txt", "w")
#     hex_file.write(str(len(asm_tokens)) + '\n')
#     print(len(asm_tokens))
#     for inst in asm_tokens:
#         binary_code = asm.instruction_generator(inst)
#         hex_code = hex(int(binary_code, 2))[2:].zfill(len(binary_code) // 4)
#         hex_file.write(hex_code + '\n')
#         print("Hexa:", hex_code)
# finally:
#     hex_file.close()