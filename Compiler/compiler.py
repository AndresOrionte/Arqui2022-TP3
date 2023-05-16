# La sintaxis de una operacion seria la siguiente: 
# Nombre de la operación + reg destino + reg1 + reg2 / inmediato.
#
# Cuando sea un inmediato, se indica con un # precedente

#ChatGPT code, review:
class AssemblerTranslator:
    def __init__(self):
        self.instructions = {
            'ADD': '0000',
            'SUB': '0001',
            'MOV': '0010',
            # Add more instructions as needed
        }
    
    def translate_to_binary(self, assembly_code):
        lines = assembly_code.split('\n')
        binary_code = []
        
        for line in lines:
            parts = line.split()
            opcode = self.instructions.get(parts[0], '')
            
            if not opcode:
                raise ValueError('Invalid instruction: {}'.format(parts[0]))
            
            binary_instruction = opcode
            
            if len(parts) > 1:
                for operand in parts[1:]:
                    binary_instruction += format(int(operand), '016b')
            
            binary_code.append(binary_instruction)
        
        return '\n'.join(binary_code)


# Example usage
translator = AssemblerTranslator()
assembly_code = '''ADD 26 25 100
SUB 10 15 50
MOV 5 12'''
binary_code = translator.translate_to_binary(assembly_code)
print(binary_code)