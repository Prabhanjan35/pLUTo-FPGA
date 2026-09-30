def decode_e4m3(val_8bit):
    sign = (val_8bit >> 7) & 0x01
    exp = (val_8bit >> 3) & 0x0F
    mant = val_8bit & 0x07
    if exp == 0 and mant == 0:
        return 0.0
    if exp == 0:
        val = (mant / 8.0) * (2 ** (1 - 7))
    else:
        val = (1.0 + mant / 8.0) * (2 ** (exp - 7))
    return -val if sign else val

with open("e4m3_mult_table.mem", "w") as f:
    for op_a in range(256):
        val_a = decode_e4m3(op_a)
        for op_b in range(256):
            val_b = decode_e4m3(op_b)
            product = val_a * val_b
            raw_16bit = int(product) & 0xFFFF
            f.write(f"{raw_16bit:04X}\n")

print("Generated e4m3_mult_table.mem with 65,536 entries.")
