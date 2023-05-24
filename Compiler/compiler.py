# La sintaxis de una operacion seria la siguiente: 
# Nombre de la operación + reg destino + reg1 + reg2 / inmediato.
#
# Cuando sea un inmediato, se indica con un # precedente
import re

class AssemblerTranslator:

    def tokenizer(self, program_asm):
        lines = program_asm.readlines()
        tokens = []
        # regex_format = (r'(?m)(\w+)\s+(-{0,1}\w+)\s*,\s*(-{0,1}\w+)\s*,\s*(-{0,1}\w+)\s*$'              # 
        #                     + r'|(?m)(\w+)\s+(-{0,1}\w+)\s*,\s*(-{0,1}\w+)\s*\(\s*(-{0,1}\w+)\)\s*$'
        #                     + r'|(?m)(\w+)\s+(-{0,1}\w+)\s*,\s*(-{0,1}\w+)\s*$'
        #                     + r'|(?m)(\w+)\s+(-{0,1}\w+)\s*$') 
        regex_format = (r'(\w+)\s+(-{0,1}\w+)\s*,\s*(-{0,1}\w+)\s*$')

        # Parseo las lineas, remuevo trailing y 
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
        return opcode + inst[6:31]
    
    def set_dest(self, inst, dest):
        dest = self.to_binary(dest, 5)
        return inst[0:6] + dest + inst[11:31]
    
    # Instrucciones Jump tienen 26b de destino
    def set_dest_jump(self, inst, dest):
        dest = self.to_binary(dest, 26)
        return inst[0:6] + dest
    
    # Instrucciones Jump tienen 16b de destino
    def set_dest_branch(self, inst, dest):
        dest = self.to_binary(dest, 16)
        return inst[0:6] + dest + inst[21:31]
    
    def set_reg1(self, inst, reg1):
        reg1 = self.to_binary(reg1, 5)
        return inst[0:11] + reg1 + inst[16:31]
    
    def set_reg2(self, inst, reg2):
        reg2 = self.to_binary(reg2, 5)
        return inst[0:16] + reg2 + inst[21:31]
    
    # Offset o Inmediato, sirve para cualquiera de los 2
    def set_inmed(self, inst, inmed):
        inmed = self.to_binary(inmed, 16)
        return inst[0:16] + inmed

    def instruction_generator(self, token):
        inst_bin = "00000000000000000000000000000000"
        i_name = token[0]
        if i_name == "SLL":
            inst_bin = self.set_opcode(inst_bin, "011100")

        elif i_name == "SRL":
            inst_bin = self.set_opcode(inst_bin, "011010")

        elif i_name == "SRA":
            inst_bin = self.set_opcode(inst_bin, "011001")

        elif i_name == "SLLV":
            inst_bin = self.set_opcode(inst_bin, "001100")

        elif i_name == "SRLV":
            inst_bin = self.set_opcode(inst_bin, "001010")            

        elif i_name == "SRAV":
            inst_bin = self.set_opcode(inst_bin, "001001")

        elif i_name == "ADDU":
            inst_bin = self.set_opcode(inst_bin, "000001")
            inst_bin = self.set_dest(inst_bin, token[1])
            inst_bin = self.set_reg1(inst_bin, token[2])
            inst_bin = self.set_reg2(inst_bin, token[3])
        elif i_name == "SUBU":
            inst_bin = self.set_opcode(inst_bin, "000010")
            inst_bin = self.set_dest(inst_bin, token[1])
            inst_bin = self.set_reg1(inst_bin, token[2])
            inst_bin = self.set_reg2(inst_bin, token[3])
        elif i_name == "AND":
            inst_bin = self.set_opcode(inst_bin, "000011")
            inst_bin = self.set_dest(inst_bin, token[1])
            inst_bin = self.set_reg1(inst_bin, token[2])
            inst_bin = self.set_reg2(inst_bin, token[3])
        elif i_name == "OR":
            inst_bin = self.set_opcode(inst_bin, "000100")
            inst_bin = self.set_dest(inst_bin, token[1])
            inst_bin = self.set_reg1(inst_bin, token[2])
            inst_bin = self.set_reg2(inst_bin, token[3])
        elif i_name == "XOR":
            inst_bin = self.set_opcode(inst_bin, "000101")
            inst_bin = self.set_dest(inst_bin, token[1])
            inst_bin = self.set_reg1(inst_bin, token[2])
            inst_bin = self.set_reg2(inst_bin, token[3])
        elif i_name == "NOR":
            inst_bin = self.set_opcode(inst_bin, "000110")
            inst_bin = self.set_dest(inst_bin, token[1])
            inst_bin = self.set_reg1(inst_bin, token[2])
            inst_bin = self.set_reg2(inst_bin, token[3])
        elif i_name == "SLT":
            inst_bin = self.set_opcode(inst_bin, "001000")

        elif i_name == "LB":
            inst_bin = self.set_opcode(inst_bin, "100000")

        elif i_name == "LH":
            inst_bin = self.set_opcode(inst_bin, "100010")

        elif i_name == "LW":
            inst_bin = self.set_opcode(inst_bin, "100100")

        elif i_name == "LHU":
            inst_bin = self.set_opcode(inst_bin, "100011")

        elif i_name == "LBU":
            inst_bin = self.set_opcode(inst_bin, "100001")

        elif i_name == "SB":
            inst_bin = self.set_opcode(inst_bin, "101001")

        elif i_name == "SH":
            inst_bin = self.set_opcode(inst_bin, "101010")

        elif i_name == "SW":
            inst_bin = self.set_opcode(inst_bin, "101100")
            inst_bin = self.set_reg1(inst_bin, token[1])
            inst_bin = self.set_reg2(inst_bin, token[2])
            inst_bin = self.set_inmed(inst_bin, token[3])

        elif i_name == "ADDI":
            inst_bin = self.set_opcode(inst_bin, "010001")

        elif i_name == "SUBI":
            inst_bin = self.set_opcode(inst_bin, "010010")

        elif i_name == "ANDI":
            inst_bin = self.set_opcode(inst_bin, "010011")

        elif i_name == "ORI":
            inst_bin = self.set_opcode(inst_bin, "010100")

        elif i_name == "XORI":
            inst_bin = self.set_opcode(inst_bin, "010101")

        elif i_name == "LUI":
            inst_bin = self.set_opcode(inst_bin, "010111")
            inst_bin = self.set_dest(inst_bin, token[1])
            inst_bin = self.set_inmed(inst_bin, token[2])
            

        elif i_name == "SLTI":
            inst_bin = self.set_opcode(inst_bin, "011000")

        elif i_name == "BEQ":
            inst_bin = self.set_opcode(inst_bin, "110100")

        elif i_name == "BNE":
            inst_bin = self.set_opcode(inst_bin, "110101")

        elif i_name == "J":
            inst_bin = self.set_opcode(inst_bin, "110000")

        elif i_name == "JAL":
            inst_bin = self.set_opcode(inst_bin, "110001")

        elif i_name == "JR":
            inst_bin = self.set_opcode(inst_bin, "110010")

        elif i_name == "JALR":
            inst_bin = self.set_opcode(inst_bin, "110011")

        elif i_name == "NOP":
            inst_bin = "00000000000000000000000000000000"
            
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

# En binario
for inst in asm_tokens:
    binary_code = (asm.instruction_generator(inst))
    print(binary_code)
    
# TODO: En hexadecimal