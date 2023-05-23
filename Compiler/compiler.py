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
        regex_format = (r'(?m)(\w+)\s+(-{0,1}\w+)\s*,\s*(-{0,1}\w+)\s*,\s*(-{0,1}\w+)\s*$')

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

    def set_rs(self, inst, rs):
        rs = self.to_binary(rs, 5)
        return inst[0:6] + rs + inst[11:31]

    def set_rt(self, inst, rt):
        rt = self.to_binary(rt, 5)
        return inst[0:11] + rt + inst[16:31]

    def set_rd(self, inst, rd):
        rd = self.to_binary(rd, 5)
        return inst[0:16] + rd + inst[21:31]

    def set_shamt(self, inst, shamt):
        shamt = self.to_binary(shamt, 5)
        return inst[0:21] + shamt + inst[26:31]

    def set_aluop(self, inst, aluop):
        return inst[0:26] + aluop

    def set_offset_immed(self, inst, offset):
        offset = self.to_binary(offset, 16)
        return inst[0:16] + offset

    def set_target(self, inst, target):
        target = self.to_binary(target, 26)
        return inst[0:6] + target
    

    def instruction_generator(self, token):
        inst_bin = "00000000000000000000000000000000"
        i_name = token[0]
        if i_name == "SLL":
            inst_bin = self.set_opcode(inst_bin, "011100")
            inst_bin = self.set_rd(inst_bin, token[1])
            inst_bin = self.set_rt(inst_bin, token[2])
            inst_bin = self.set_shamt(inst_bin, token[3])
        elif i_name == "SRL":
            inst_bin = self.set_opcode(inst_bin, "011010")
            inst_bin = self.set_rd(inst_bin, token[1])
            inst_bin = self.set_rt(inst_bin, token[2])
            inst_bin = self.set_shamt(inst_bin, token[3])
        elif i_name == "SRA":
            inst_bin = self.set_opcode(inst_bin, "011001")
            inst_bin = self.set_rd(inst_bin, token[1])
            inst_bin = self.set_rt(inst_bin, token[2])
            inst_bin = self.set_shamt(inst_bin, token[3])
        elif i_name == "SLLV":
            inst_bin = self.set_opcode(inst_bin, "001100")
            inst_bin = self.set_rd(inst_bin, token[1])
            inst_bin = self.set_rt(inst_bin, token[2])
            inst_bin = self.set_rs(inst_bin, token[3])
        elif i_name == "SRLV":
            inst_bin = self.set_opcode(inst_bin, "001010")            
            inst_bin = self.set_rd(inst_bin, token[1])
            inst_bin = self.set_rt(inst_bin, token[2])
            inst_bin = self.set_rs(inst_bin, token[3])
        elif i_name == "SRAV":
            inst_bin = self.set_opcode(inst_bin, "001001")
            inst_bin = self.set_rd(inst_bin, token[1])
            inst_bin = self.set_rt(inst_bin, token[2])
            inst_bin = self.set_rs(inst_bin, token[3])
        elif i_name == "ADDU":
            inst_bin = self.set_opcode(inst_bin, "000001")
            inst_bin = self.set_rd(inst_bin, token[1])
            inst_bin = self.set_rt(inst_bin, token[3])
            inst_bin = self.set_rs(inst_bin, token[2])
        elif i_name == "SUBU":
            inst_bin = self.set_opcode(inst_bin, "000010")
            inst_bin = self.set_rd(inst_bin, token[1])
            inst_bin = self.set_rt(inst_bin, token[3])
            inst_bin = self.set_rs(inst_bin, token[2])
        elif i_name == "AND":
            inst_bin = self.set_opcode(inst_bin, "000011")
            inst_bin = self.set_rd(inst_bin, token[1])
            inst_bin = self.set_rt(inst_bin, token[2])
            inst_bin = self.set_rs(inst_bin, token[3])
        elif i_name == "OR":
            inst_bin = self.set_opcode(inst_bin, "000100")
            inst_bin = self.set_rd(inst_bin, token[1])
            inst_bin = self.set_rt(inst_bin, token[2])
            inst_bin = self.set_rs(inst_bin, token[3])
        elif i_name == "XOR":
            inst_bin = self.set_opcode(inst_bin, "000101")
            inst_bin = self.set_rd(inst_bin, token[1])
            inst_bin = self.set_rt(inst_bin, token[3])
            inst_bin = self.set_rs(inst_bin, token[2])
        elif i_name == "NOR":
            inst_bin = self.set_opcode(inst_bin, "000110")
            inst_bin = self.set_rd(inst_bin, token[1])
            inst_bin = self.set_rt(inst_bin, token[3])
            inst_bin = self.set_rs(inst_bin, token[2])
        elif i_name == "SLT":
            inst_bin = self.set_opcode(inst_bin, "001000")
            inst_bin = self.set_rd(inst_bin, token[1])
            inst_bin = self.set_rt(inst_bin, token[3])
            inst_bin = self.set_rs(inst_bin, token[2])
        elif i_name == "LB":
            inst_bin = self.set_opcode(inst_bin, "100000")
            inst_bin = self.set_rt(inst_bin, token[1])
            inst_bin = self.set_offset_immed(inst_bin, token[2])
            inst_bin = self.set_rs(inst_bin, token[3])
        elif i_name == "LH":
            inst_bin = self.set_opcode(inst_bin, "100010")
            inst_bin = self.set_rt(inst_bin, token[1])
            inst_bin = self.set_offset_immed(inst_bin, token[2])
            inst_bin = self.set_rs(inst_bin, token[3])
        elif i_name == "LW":
            inst_bin = self.set_opcode(inst_bin, "100100")
            inst_bin = self.set_rt(inst_bin, token[1])
            inst_bin = self.set_offset_immed(inst_bin, token[2])
            inst_bin = self.set_rs(inst_bin, token[3])
        elif i_name == "LHU":
            inst_bin = self.set_opcode(inst_bin, "100011")
            inst_bin = self.set_rt(inst_bin, token[1])
            inst_bin = self.set_offset_immed(inst_bin, token[2])
            inst_bin = self.set_rs(inst_bin, token[3])
        elif i_name == "LBU":
            inst_bin = self.set_opcode(inst_bin, "100001")
            inst_bin = self.set_rt(inst_bin, token[1])
            inst_bin = self.set_offset_immed(inst_bin, token[2])
            inst_bin = self.set_rs(inst_bin, token[3])
        elif i_name == "SB":
            inst_bin = self.set_opcode(inst_bin, "101001")
            inst_bin = self.set_rt(inst_bin, token[1])
            inst_bin = self.set_offset_immed(inst_bin, token[2])
            inst_bin = self.set_rs(inst_bin, token[3])
        elif i_name == "SH":
            inst_bin = self.set_opcode(inst_bin, "101010")
            inst_bin = self.set_rt(inst_bin, token[1])
            inst_bin = self.set_offset_immed(inst_bin, token[2])
            inst_bin = self.set_rs(inst_bin, token[3])
        elif i_name == "SW":
            inst_bin = self.set_opcode(inst_bin, "101100")
            inst_bin = self.set_rt(inst_bin, token[1])
            inst_bin = self.set_offset_immed(inst_bin, token[2])
            inst_bin = self.set_rs(inst_bin, token[3])

        elif i_name == "ADDIU":
            inst_bin = self.set_opcode(inst_bin, "010001")
            inst_bin = self.set_rt(inst_bin, token[1])
            inst_bin = self.set_offset_immed(inst_bin, token[3])
            inst_bin = self.set_rs(inst_bin, token[2])
        elif i_name == "SUBI":
            inst_bin = self.set_opcode(inst_bin, "010010")
            inst_bin = self.set_rt(inst_bin, token[1])
            inst_bin = self.set_offset_immed(inst_bin, token[3])
            inst_bin = self.set_rs(inst_bin, token[2])
        elif i_name == "ANDI":
            inst_bin = self.set_opcode(inst_bin, "010011")
            inst_bin = self.set_rt(inst_bin, token[1])
            inst_bin = self.set_offset_immed(inst_bin, token[3])
            inst_bin = self.set_rs(inst_bin, token[2])
        elif i_name == "ORI":
            inst_bin = self.set_opcode(inst_bin, "010100")
            inst_bin = self.set_rt(inst_bin, token[1])
            inst_bin = self.set_offset_immed(inst_bin, token[3])
            inst_bin = self.set_rs(inst_bin, token[2])
        elif i_name == "XORI":
            inst_bin = self.set_opcode(inst_bin, "010101")
            inst_bin = self.set_rt(inst_bin, token[1])
            inst_bin = self.set_offset_immed(inst_bin, token[3])
            inst_bin = self.set_rs(inst_bin, token[2])
        elif i_name == "LUI":
            inst_bin = self.set_opcode(inst_bin, "010111")
            inst_bin = self.set_rt(inst_bin, token[1])
            inst_bin = self.set_offset_immed(inst_bin, token[2])
        elif i_name == "SLTI":
            inst_bin = self.set_opcode(inst_bin, "011000")
            inst_bin = self.set_rt(inst_bin, token[1])
            inst_bin = self.set_offset_immed(inst_bin, token[3])
            inst_bin = self.set_rs(inst_bin, token[2])
        elif i_name == "BEQ":
            inst_bin = self.set_opcode(inst_bin, "110100")
            inst_bin = self.set_rt(inst_bin, token[1])
            inst_bin = self.set_offset_immed(inst_bin, token[3])
            inst_bin = self.set_rs(inst_bin, token[2])
        elif i_name == "BNE":
            inst_bin = self.set_opcode(inst_bin, "110101")
            inst_bin = self.set_rt(inst_bin, token[1])
            inst_bin = self.set_offset_immed(inst_bin, token[3])
            inst_bin = self.set_rs(inst_bin, token[2])
        elif i_name == "J":
            inst_bin = self.set_opcode(inst_bin, "110000")
            inst_bin = self.set_target(inst_bin, token[1])
        elif i_name == "JAL":
            inst_bin = self.set_opcode(inst_bin, "110001")
            inst_bin = self.set_target(inst_bin, token[1])
        elif i_name == "JR":
            inst_bin = self.set_opcode(inst_bin, "110010")
            inst_bin = self.set_rs(inst_bin, token[1])
        elif i_name == "JALR":
            inst_bin = self.set_opcode(inst_bin, "110011")
            if len(token) > 1:
                inst_bin = self.set_rs(inst_bin, token[2])
                inst_bin = self.set_rd(inst_bin, token[1])
            else:
                inst_bin = self.set_rs(inst_bin, token[1])
                inst_bin = self.set_rd(inst_bin, "31")

        elif i_name == "NOP":
            inst_bin = "00000000000000000000000000000000"
            
        else:
            print(i_name, " Instruccion no reconocida")
            
        return inst_bin
    
binary_code = ""
asm_tokens = []
asm = AssemblerTranslator()

try:
    asm_file = open("./Compiler/program.asm", encoding='utf-8')
    asm_tokens = asm.tokenizer(asm_file)
finally:
    asm_file.close()

for inst in asm_tokens:
    binary_code = (asm.instruction_generator(inst))
    print(binary_code)