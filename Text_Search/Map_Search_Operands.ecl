// A collection of equates and mapping functions
export Map_Search_Operands := MODULE
	EXPORT Types.OpCode code_GET		:=   4;
	EXPORT Types.OpCode code_AND 		:=   8;
	EXPORT Types.OpCode	code_OR			:=  12;
	EXPORT Types.OpCode code_WSEG		:=  16;
	EXPORT Types.OpCode code_PRE		:=  20;
	EXPORT Types.OpCode code_W			:=  24;
	EXPORT Types.OpCode code_PHRASE :=  28;
	EXPORT Types.OpCode code_ANDNOT :=  32;
	EXPORT Types.OpCode code_NOTWSEG:=	36;
	EXPORT Types.Opcode code_NOTW		:=	40;
	EXPORT Types.Opcode code_NOTPRE	:=	44;
	EXPORT Types.Opcode code_BUTNOT	:=	48;
	EXPORT Types.Opcode code_ATL		:=	52;
	EXPORT Types.Opcode code_RNGGET :=  56;
	EXPORT Types.Opcode code_FOCGET :=  60;
	EXPORT Types.Opcode code_ANDOR	:=	64;			// A ANDOR B  -> A OR (A AND B) -> LEFT OUTER
	EXPORT Types.Opcode code_ANY2		:=	68;			// 2 of N
	EXPORT Types.Opcode code_ALLBUT1:=  72;			// N-1 of N
	EXPORT Types.Opcode code_HALF		:=	76;
	EXPORT Types.Opcode code_GETFLD	:=	80;

	EXPORT Types.OpCode lookupCode(STRING opr) := CASE(opr,
							'GET       '		=> code_GET,
							'AND       '		=> code_AND,
							'ANDNOT    '		=> code_ANDNOT,
							'OR        '		=> code_OR,
							'+         '		=> code_PHRASE,
							'W/        '		=> code_W,
							'PRE/      '		=> code_PRE,
							'W/SEG     '		=> code_WSEG,
							'NOTW/SEG  '		=> code_NOTWSEG,
							'NOTW/     '		=> CODE_NOTW,
							'NOTPRE/   '		=> CODE_NOTPRE,
							'BUTNOT    '		=> CODE_BUTNOT,
							'ATL/      '		=> CODE_ATL,
							'AOR       '    => code_ANDOR,
							'ANY2			 '		=> code_ANY2,
							'ALLBUT1	 '		=> code_ALLBUT1,
							'HALF			 '		=> code_HALF,
							'GETFLD		 '		=> code_GETFLD,
							code_WSEG);

END;