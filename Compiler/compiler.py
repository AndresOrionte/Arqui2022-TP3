# La sintaxis de una operacion seria la siguiente: 
# Nombre de la operación + reg destino + reg1 + reg2 / inmediato.
#
# Cuando sea un inmediato, se indica con un # precedente
import re

class AssemblerTranslator:
    # def __init__(self, program_asm):
    #     self.instructions = {
    #         'ADDU': '000001',
    #         'SUBU': '000010',
    #         'AND': '000011',
    #         'OR': '000100',
    #         'XOR': '000101',
    #         'NOR': '000110',
    #         'SRAV': '001001',
    #         'SRLV': '001010',
    #         'SLLV': '001100',
    #         'SLT': '001000',
    #         'ADDIU': '010001',
    #         'SUBI': '010010',
    #         'ANDI': '010011',
    #         'ORI': '010100',
    #         'XORI': '010101',
    #         'LUI': '010111',
    #         'SRA': '011001',
    #         'SRL': '011010',
    #         'SLL': '011100',
    #         'SLTI': '011000',
    #         'LB': '100000',
    #         'LBU': '100001',
    #         'LH': '100010',
    #         'LHU': '100011',
    #         'LW': '100100',
    #         'SB': '101001',
    #         'SH': '101010',
    #         'SW': '101100',
    #         'J': '110000',
    #         'JAL': '110001',
    #         'JR': '110010',
    #         'JALR': '110011',
    #         'BEQ': '110100',
    #         'BNE': '110101'
    #     }

    def tokenizer(self, program_asm):
        lines = program_asm.readlines()
        tokens = []
        regex_format = (r'(?m)(\w+)\s+(-{0,1}\w+)\s*,\s*(-{0,1}\w+)\s*,\s*(-{0,1}\w+)\s*$'                  #INSTR DEST, R1, R2
                        + r'|(?m)(\w+)\s+(-{0,1}\w+)\s*,\s*(-{0,1}\w+)\s*\(*,\s*#(-{0,1}\w+)\s*$'       #INSTR DEST, R1, #INM
                        + r'|(?m)(\w+)\s+(-{0,1}\w+)\s*$')                                              #JR R2 / J 44

        # Parseo las lineas, remuevo trailing y 
        for raw_line in lines:
            line = raw_line.replace('\n', '')
            tokens.append(list(filter(None, re.split(string=line, pattern=regex_format))))

        return tokens
    
asm_tokens = []
translator = AssemblerTranslator()

try:
    program_asm = open("./Compiler/program.asm", encoding='utf-8')
    asm_tokens = translator.tokenizer(program_asm)
finally:
    program_asm.close()