
/*
IMPORT PRTE2_Phonesplus_Ins;
// Test the cell phones numbers
PhoneGenerator := PRTE2_Phonesplus_Ins.U_Alaska_Phones('Y','9072000010');
ph1 := PhoneGenerator.String10NextPhone('');
ph2 := PhoneGenerator.String10NextPhone('9072009998');
ph3 := PhoneGenerator.String10NextPhone('9072009999');
OUTPUT(ph1);
OUTPUT(ph2);
OUTPUT(ph3);

// Test the Land Lines
PhoneGenerator := PRTE2_Phonesplus_Ins.U_Alaska_Phones('N','907212');
ph1 := PhoneGenerator.String10NextPhone('');
ph2 := PhoneGenerator.String10NextPhone('9072129998');
ph3 := PhoneGenerator.String10NextPhone('9072129999');
OUTPUT(ph1);
OUTPUT(ph2);
OUTPUT(ph3);
*/

// ----------------------------------------------------------------------------------------------------

CellPhonesSet := ['907-200','907-209','907-223','907-227','907-229','907-230','907-232','907-240','907-242','907-244'];
LandLinesSet 	:= ['907-212','907-220','907-221','907-222','907-224','907-225','907-226','907-228','907-233','907-234'];
NumMin := '0000';

EXPORT U_Alaska_Phones(STRING cellYN='Y', STRING baseExtension='907200') := MODULE

		SHARED PhonRec := RECORD
			STRING ac := '';
			STRING ex := '';
			STRING num := '';
		END;

		SHARED nextCellBool := cellYN='Y';

		//-------------------------------------------------------
		// Find a string inside a set and return it's ordinal position
		SHARED FindSetPos(STRING FindStr, SET OF STRING s) := FUNCTION
				 ds := DATASET(s,{STRING val});
				 PosDS := PROJECT(ds,TRANSFORM({UNSIGNED2 Pos,ds},SELF.Pos := IF(LEFT.val = FindStr,COUNTER,SKIP),SELF := LEFT));
				 FoundPos := PosDS[1].Pos;
				 RETURN FoundPos;
		END;
		//------------------------------------------			
		
		SHARED addOne4 (STRING n) := INTFORMAT( ((INTEGER) n + 1), 4,1);
		SHARED nextNum4 (STRING n) := FUNCTION
			nTmp := IF(n = '9999', NumMin, addOne4(n));
			RETURN nTmp;
		END;
		//------------------------------------------

		//-------------------------------------------------------
		SHARED nextCellExt(STRING n) := FUNCTION
			idx := FindSetPos(n,CellPhonesSet);
			idxerr := idx=0 OR idx > COUNT(CellPhonesSet);
			RETURN IF(idxerr,'***-***', CellPhonesSet[idx+1]);
		END;
		SHARED nextLandExt(STRING n) := FUNCTION
			idx := FindSetPos(n,LandLinesSet);
			RETURN LandLinesSet[idx+1];
		END;
		SHARED nextExt (STRING n) := FUNCTION
			RETURN IF(nextCellBool, nextCellExt(n), nextLandExt(n));
		END;	
		//-------------------------------------------------------

		//-------------------------------------------------------
		SHARED NextCTPhone(STRING ac, STRING ex, STRING num) := FUNCTION
				NumNext := nextNum4(num);
				ExtNext := IF(NumNext = NumMin, nextExt(ac+'-'+ex), ac+'-'+ex);
				acn := extNext[1..3];
				exn := extNext[5..7];
				RETURN [acn,exn,NumNext];
		END;

		//------------------------------------------
		EXPORT getNextCTPhone(STRING ac, STRING ex, STRING num) := FUNCTION
				RETURN NextCTPhone(ac,ex,num);			
		END;

		//------------------------------------------
		EXPORT NextPhoneAsSet(STRING ac='', STRING ex='', STRING num='') := FUNCTION
			SET OF STRING ans := getNextCTPhone(ac,ex,num);
			RETURN ans;
		END;

		//------------------------------------------
		EXPORT FormattedNextPhone(STRING ac='', STRING ex='', STRING num='') := FUNCTION
			SET OF STRING ans := getNextCTPhone(ac,ex,num);
			RETURN ans[1]+'-'+ans[2]+'-'+ans[3];
		END;

		baseSize := LENGTH(baseExtension);
		baseNumber := IF(	baseSize=6, baseExtension+NumMin, baseExtension);
		
		//------------------------------------------
		EXPORT String10NextPhone(STRING inPh = baseNumber) := FUNCTION
			inPh2 := IF(inPh = '',baseNumber, inPh);
			ac := inPh2[1..3];
			ex := inPh2[4..6];
			num := inPh2[7..10];
			SET OF STRING ans := getNextCTPhone(ac,ex,num);
			RETURN ans[1]+ans[2]+ans[3];
		END;
		//------------------------------------------


END;