// Presently supports filtering and simple linear scoring
// * 1.0
// > 8.2
// <> -10
EXPORT MOD_ScoreField(STRING P) := MODULE
  IMPORT SALT38;
	SHARED Op1 := SALT38.GetNthWord(P,1);
	SHARED HasScore := Op1 = '*';
	SHARED REAL8 ScoreMul := IF ( HasScore, (REAL8)SALT38.GetNthWord(P,2), 0 );
  SHARED Op := ENUM(None=0,Eq,Gt,Ge,Lt,Le,ne,grp,e1,e2);
	SHARED Ops := IF ( HasScore, SALT38.GetNthWord(P,3), Op1 );
	SHARED VS := TRIM(IF ( HasScore, SALT38.GetRangeOfWords(P,4,SALT38.WordCount(P)),P[LENGTH(Ops)+2..] ));
	SHARED REAL8 V := (REAL8)VS;
	SHARED OpCode := CASE(Ops,''=>Op.None,'='=>Op.Eq,'>'=>Op.Gt,'>='=>Op.Ge,'<'=>Op.lt,'<='=>Op.le,'<>'=>Op.ne,'!='=>Op.ne
	                          ,'&'=>Op.grp,'e1'=>Op.e1,'e2'=>Op.e2,Op.None);
	EXPORT FilterR(REAL8 Fld) := CASE(OpCode,Op.Eq=>Fld=V,
																					Op.Gt=>Fld>V,
																					Op.Ge=>Fld>=V,
																					Op.Lt=>Fld<V,
																					Op.Le=>Fld<=V,
																					Op.ne=>Fld<>V,
																						Op.e1=>SALT38.WithinEditN((STRING)Fld,VS,1),
																						Op.e2=>SALT38.WithinEditN((STRING)Fld,VS,2),
																					true);
	EXPORT FilterS(SALT38.StrType Fld) := CASE(OpCode,Op.Eq=>Fld=VS,
																						Op.Gt=>Fld>VS,
																						Op.Ge=>Fld>=VS,
																						Op.Lt=>Fld<VS,
																						Op.Le=>Fld<=VS,
																						Op.ne=>Fld<>VS,
																						Op.e1=>SALT38.WithinEditN(Fld,VS,1),
																						Op.e2=>SALT38.WithinEditN(Fld,VS,2),
																						true);
	EXPORT ScoreR(REAL8 Fld) := IF(HasScore,ScoreMul*Fld,0);
	EXPORT HasGroup := OpCode = Op.Grp;
	EXPORT GroupVal(SALT38.StrType Fld) := IF ( OpCode = Op.Grp, '|'+Fld, '' );
  END;
