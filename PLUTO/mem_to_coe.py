with open("C:/Xilinx/pLUTo/e4m3_mult_table.mem", "r") as mem_file:
    # Filter out empty lines or comments
    lines = [line.strip() for line in mem_file if line.strip() and not line.startswith("//")]

with open("C:/Xilinx/pLUTo/e4m3_mult_table.coe", "w") as coe_file:
    coe_file.write("memory_initialization_radix=16;\n")
    coe_file.write("memory_initialization_vector=\n")
    coe_file.write(",\n".join(lines) + ";\n")

print("Successfully converted .mem to .coe!")
