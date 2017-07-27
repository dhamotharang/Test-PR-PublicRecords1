EXPORT ManipulateRPN := MODULE
	emptyWL := SET(DATASET([], {Types.WordStr w}), w) : GLOBAL;

	EXPORT chopOffTerms(DATASET(Layout_Search_RPN_Set) rpnSet) := FUNCTION
		Layout_Search_RPN_Set emptyTerms(Layout_Search_RPN_Set l) := TRANSFORM
			Layout_RPN_Oprnd blankTerm(Layout_RPN_Oprnd input) := TRANSFORM
				SELF.terms := emptyWL;
				SELF := input;
			END;

			SELF.inputs := PROJECT(l.inputs, blankTerm(LEFT));
			SELF := l;
		END;

		RETURN PROJECT(rpnSet, emptyTerms(LEFT));
	END;
	
	EXPORT Layout_Expanded_List := RECORD
		UNSIGNED4			nominalCount;
		UNSIGNED4			suffixCount;
		Types.NominalList					nominals{MAXCOUNT(Limits.Max_LocalWild)};
		Types.NominalSuffixList		suffixes{MAXCOUNT(Limits.Max_LocalWild)};
	END;
	
	EXPORT localExpand(Filename_Info info,
										DATASET(Layout_Search_RPN_Set) rpnSet) := FUNCTION
										
	  // Dictionary Flag
	  Boolean UseNew := EXISTS(CHOOSEN(Indx_LocalDict(info),1));
	
		Layout_Expanded_List expandWildCards(Layout_Search_RPN_Set l) := TRANSFORM
			BOOLEAN getOp := l.opCode=Map_Search_Operands.code_GET;
			BOOLEAN deferred := l.inputs[1].deferWildCard;
			w2 := Wild_Lookup2(info, l.inputs[1].searchArg);
		  Get_Suffix_List := w2.Get_Suffix_List;
		  Get_Nominal_List := w2.Get_Nominal_List;			
			SELF.nominalCount:= IF(getOp AND deferred, COUNT(Get_Nominal_List),0);
			SELF.suffixCount := IF(getOp AND deferred, COUNT(Get_Suffix_List),0);
			SELF.nominals := IF(getOp AND deferred, Get_Nominal_List, []);
			SELF.suffixes := IF(getOp AND deferred, Get_Suffix_List, []);
		END;
		RETURN PROJECT(rpnSet, expandWildCards(LEFT));
	END;
		
END;