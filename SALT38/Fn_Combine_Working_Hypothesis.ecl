export Fn_Combine_Working_Hypothesis(dataset(layout_classify_working_hypothesis) wh) := FUNCTION
	Layout_Classify_Token TakeN(wh LE,unsigned C) := TRANSFORM
	  SELF := le.Possibles[c];
	END;	
	DS := NORMALIZE(wh,COUNT(LEFT.Possibles),TakeN(LEFT,COUNTER)); // Pull out all the token classifications
  R := RECORD
	  DS.TokenType;
		UNSIGNED2 SPC := MAX(GROUP,DS.Spc); // Could be better ways to produce combined specificity
		UNSIGNED Len := COUNT(GROUP); // This tells us how many tokens were classified for a given tokentype
	END;
	T := TABLE(DS,R,TokenType,FEW)(Len=COUNT(WH)); // Filter removes tokentypes that cannot match every token
	Layout_Classify_Hypothesis Into(T le) := TRANSFORM
			SELF.Confirmed := FALSE;
	  	SELF.StartPos := 1; // All that is supported for this type
			SELF := LE;
	END;
	RETURN PROJECT(T,Into(LEFT));
  END;
