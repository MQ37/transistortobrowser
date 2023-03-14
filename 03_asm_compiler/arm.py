from enum import Enum


class Cond(Enum):
    EQ = 0
    NE = 1
    HSCS = 2
    LOCC = 3
    MI = 4
    PL = 5
    VS = 6
    VC = 7
    HI = 8
    LS = 9
    GE = 10
    LT = 11
    GT = 12
    LE = 13
    AL = 14
    NV = 15

class DataOp(Enum):
    AND = 0
    EOR = 1
    SUB = 2
    RSB = 3
    ADD = 4
    ADC = 5
    SBC = 6
    RSC = 7
    TST = 8
    TEQ = 9
    CMP = 10
    CMN = 11
    ORR = 12
    MOV = 13
    BIC = 14
    MVN = 15

