import struct
from arm import Cond, DataOp


def getb(bits, s, e):
    return (bits >> s) & ((1 << (e-s+1)) - 1)

def printb(b, lz=32):
    s = format(b, f"0{lz}b")
    print(s)

def getcond(ins):
    insc = getb(ins, 28, 31)
    for cond in Cond:
        if cond.value == insc:
            return cond

def getdataopcode(ins):
    opcode = getb(ins, 21, 24)
    for op in DataOp:
        if op.value == opcode:
            return op

def decode(ins):
    cond = getcond(ins)
    print("cond", cond)

    # Data processing ins
    if getb(ins, 26, 27) == 0:
        imm = getb(ins, 25, 25)
        opcode = getdataopcode(ins)
        setcond = getb(ins, 20, 20)
        # first operand
        rn = getb(ins, 16, 19)
        # destination
        rd = getb(ins, 12, 15)
        # second operand
        operand  = getb(ins, 0, 11)
        print("opcode", opcode)
        print("imm", imm)
        print("Rn", rn)
        print("Rd", rd)
        print("Operand2", operand)

# Read .bin
with open("main.bin", "rb") as fd:
    data = fd.read()
print(data)

# Fetch instructions
base = 0
step = 4
while base < len(data):
    insb = data[base:base+step]

    ins = struct.unpack("<I", insb)[0]
    printb(ins)

    # Decode
    decode(ins)

    base += step

