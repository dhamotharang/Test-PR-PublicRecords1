EXPORT macAppendConsolidatedBipIds(dIn, 
  UltID1, OrgID1, SeleID1, ProxID1, PowID1, empID1 = '', dotID1 = '', Score1, Weight1,
  UltID2, OrgID2, SeleID2, ProxID2, PowID2, empID2 = '', dotID2 = '', Score2, Weight2, 
  UltID3 = '', OrgID3 = '', SeleID3 = '', ProxID3 = '', PowID3 = '', empID3 = '', dotID3 = '', Score3 = '', Weight3 = '',
  UltID4 = '', OrgID4 = '', SeleID4 = '', ProxID4 = '', PowID4 = '', empID4 = '', dotID4 = '', Score4 = '', Weight4 = '',
  appendPrefix = '\'\'') := FUNCTIONMACRO
  
  LOCAL rOut := RECORD
    RECORDOF(dIn);
    UNSIGNED6 #EXPAND(appendPrefix + 'UltID');
    UNSIGNED6 #EXPAND(appendPrefix + 'OrgID');
    UNSIGNED6 #EXPAND(appendPrefix + 'SeleID');
    UNSIGNED6 #EXPAND(appendPrefix + 'ProxID');
    UNSIGNED6 #EXPAND(appendPrefix + 'PowID');
    UNSIGNED6 #EXPAND(appendPrefix + 'EmpID');
    UNSIGNED6 #EXPAND(appendPrefix + 'DotID');
    UNSIGNED #EXPAND(appendPrefix + 'Score');
    UNSIGNED #EXPAND(appendPrefix + 'Weight');
  END;
  
  LOCAL dOut := PROJECT(dIn,
	TRANSFORM(rOut,
    HighestWeight := MAX((UNSIGNED)LEFT.Weight1,(UNSIGNED)LEFT.Weight2
      #IF(#TEXT(Weight3)!=''),(UNSIGNED)LEFT.Weight3 #END
      #IF(#TEXT(Weight4)!=''),(UNSIGNED)LEFT.Weight4 #END);
    HighestScore := MAX((UNSIGNED)LEFT.Score1,(UNSIGNED)LEFT.Score2
      #IF(#TEXT(Score3)!=''),(UNSIGNED)LEFT.Score3 #END
      #IF(#TEXT(Score4)!=''),(UNSIGNED)LEFT.Score4 #END);
    UseSet1 := LEFT.Weight1 = HighestWeight AND (LEFT.Score1=HighestScore OR LEFT.Score1>=75);
    UseSet2 := LEFT.Weight2 = HighestWeight AND (LEFT.Score2=HighestScore OR LEFT.Score2>=75);
    UseSet3 := #IF(#TEXT(Weight3)!='' AND #TEXT(Score3)!='') LEFT.Weight3 = HighestWeight AND (LEFT.Score3=HighestScore OR LEFT.Score3>=75) #ELSE FALSE #END;
		SELF.#EXPAND(appendPrefix + 'UltID') := MAP(UseSet1 => (UNSIGNED)LEFT.UltID1, 
      UseSet2 => (UNSIGNED)LEFT.UltID2, 
      #IF(#TEXT(UltID3)!='') UseSet3 => (UNSIGNED)LEFT.UltID3,  #END 
      #IF(#TEXT(UltID4) != '') (UNSIGNED)LEFT.UltID4 #ELSE 0 #END),
		SELF.#EXPAND(appendPrefix + 'OrgID') := MAP(UseSet1 => (UNSIGNED)LEFT.OrgID1, 
      UseSet2 => (UNSIGNED)LEFT.OrgID2, 
      #IF(#TEXT(OrgID3)!='') UseSet3 => (UNSIGNED)LEFT.OrgID3, #END 
      #IF(#TEXT(OrgID4) != '') (UNSIGNED)LEFT.OrgID4 #ELSE 0 #END),
		SELF.#EXPAND(appendPrefix + 'SeleID') := MAP(UseSet1 => (UNSIGNED)LEFT.SeleID1, 
      UseSet2 => (UNSIGNED)LEFT.SeleID2, 
      #IF(#TEXT(SeleID3)!='') UseSet3 => (UNSIGNED)LEFT.SeleID3, #END 
      #IF(#TEXT(SeleID4) != '') (UNSIGNED)LEFT.SeleID4 #ELSE 0 #END),
		SELF.#EXPAND(appendPrefix + 'ProxID') := MAP(UseSet1 => (UNSIGNED)LEFT.ProxID1, 
      UseSet2 => (UNSIGNED)LEFT.ProxID2, 
      #IF(#TEXT(ProxID3)!='') UseSet3 => (UNSIGNED)LEFT.ProxID3, #END
      #IF(#TEXT(ProxID4) != '') (UNSIGNED)LEFT.ProxID4 #ELSE 0 #END),
		SELF.#EXPAND(appendPrefix + 'PowID') := MAP(UseSet1 => (UNSIGNED)LEFT.PowID1, 
      UseSet2 => (UNSIGNED)LEFT.PowID2, 
      #IF(#TEXT(PowID3)!='') UseSet3 => (UNSIGNED)LEFT.PowID3, #END 
      #IF(#TEXT(PowID4) != '') (UNSIGNED)LEFT.PowID4 #ELSE 0 #END),
		SELF.#EXPAND(appendPrefix + 'EmpID') := #IF(#TEXT(EmpID1)!='' OR #TEXT(EmpID2)!='') 
      MAP(#IF(#TEXT(EmpID1)!='') UseSet1 => (UNSIGNED)LEFT.EmpID1, #END 
      #IF(#TEXT(EmpID2)!='') UseSet2 => (UNSIGNED)LEFT.EmpID2, #END 
      #IF(#TEXT(EmpID3)!='') UseSet3 => (UNSIGNED)LEFT.EmpID3, #END
      #IF(#TEXT(EmpID4) != '') (UNSIGNED)LEFT.EmpID4 #ELSE 0 #END) 
      #ELSE 0 #END,
		SELF.#EXPAND(appendPrefix + 'DotID') := #IF(#TEXT(DotID1)!='' OR #TEXT(DotID2)!='') 
      MAP(#IF(#TEXT(DotID1)!='') UseSet1 => (UNSIGNED)LEFT.DotID1, #END 
      #IF(#TEXT(DotID2)!='') UseSet2 => (UNSIGNED)LEFT.DotID2, #END 
      #IF(#TEXT(DotID3)!='') UseSet3 => (UNSIGNED)LEFT.DotID3, #END 
      #IF(#TEXT(DotID4) != '') (UNSIGNED)LEFT.DotID4 #ELSE 0 #END) 
      #ELSE 0 #END,
    SELF.#EXPAND(appendPrefix + 'Score') := MAP(UseSet1 => (UNSIGNED)LEFT.Score1,
      UseSet2 => (UNSIGNED)LEFT.Score2,
      #IF(#TEXT(Score3)!='') UseSet3 => (UNSIGNED)LEFT.Score3, #END
      #IF(#TEXT(Score4)!='') (UNSIGNED)LEFT.Score4 #ELSE 0 #END),
    SELF.#EXPAND(appendPrefix + 'Weight') := MAP(UseSet1 => (UNSIGNED)LEFT.Weight1,
      UseSet2 => (UNSIGNED)LEFT.Weight2,
      #IF(#TEXT(Weight3)!='') UseSet3 => (UNSIGNED)LEFT.Weight3, #END
      #IF(#TEXT(Weight4)!='') (UNSIGNED)LEFT.Weight4 #ELSE 0 #END),
		SELF 	:= LEFT));
  RETURN dOut;
  
ENDMACRO;