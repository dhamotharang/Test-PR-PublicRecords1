// Presently supports filtering and simple linear scoring
// * 1.0
// > 8.2
// <> -10
EXPORT MOD_ScoreField(STRING P) := MODULE
  IMPORT SALT25;
  SHARED Op := ENUM(None=0,Eq,Gt,Ge,Lt,Le,ne,Mul);
	SHARED VS := SALT25.GetNthWord(P,2);
	SHARED REAL8 V := (REAL8)VS;
	Ops := SALT25.GetNthWord(P,1);
	SHARED OpCode := CASE(Ops,''=>Op.None,'='=>Op.Eq,'>'=>Op.Gt,'>='=>Op.Ge,'<'=>Op.lt,'<='=>Op.le,'<>'=>Op.ne,'!='=>Op.ne,'*'=>Op.mul,Op.None);
	EXPORT FilterR(REAL8 Fld) := CASE(OpCode,Op.Eq=>Fld=V,
																					Op.Gt=>Fld>V,
																					Op.Ge=>Fld>=V,
																					Op.Lt=>Fld<V,
																					Op.Le=>Fld<=V,
																					Op.ne=>Fld<>V,
																					true);
	EXPORT FilterS(STRING Fld) := CASE(OpCode,Op.Eq=>Fld=VS,
																						Op.Gt=>Fld>VS,
																						Op.Ge=>Fld>=VS,
																						Op.Lt=>Fld<VS,
																						Op.Le=>Fld<=VS,
																						Op.ne=>Fld<>VS,
																						true);
	EXPORT ScoreR(REAL8 Fld) := IF(OpCode=Op.Mul,V*Fld,0);
  END;
