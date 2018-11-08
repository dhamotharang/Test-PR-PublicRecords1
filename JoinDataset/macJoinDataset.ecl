EXPORT macJoinDataset(dIn1, dIn2, joinString, joinType, fieldString = '\'\'', KeepOption = false, KeepValue = 1, Prefix ='\'\'') := FUNCTIONMACRO

IMPORT STD, hipie_ecl;

#IF(TRIM(fieldString, ALL) <> '')

  LOCAL SublayoutStr := hipie_ecl.macComputeDatasetSublayout(dIn2, fieldString, Prefix);
  LOCAL TransformStr := hipie_ecl.macComputeTransformStatements(fieldString, Prefix);  

  LOCAL Sublayout := #EXPAND(SublayoutStr);
  LOCAL OutRec := RECORD
    RECORDOF(dIn1);
    Sublayout;
  END;
  
  LOCAL dOut := JOIN(dIn1, dIn2,
    #EXPAND(joinString),
    TRANSFORM(OutRec,
      #EXPAND(TransformStr)
      SELF := LEFT;
      SELF := RIGHT;
		),
    #EXPAND(joinType)
    ,HASH
    #IF((BOOLEAN)KeepOption)
      ,KEEP((INTEGER)KeepValue)
    #END
	);

	RETURN dOut;
  
#ELSE

  LOCAL dOut := JOIN(dIn1, dIn2,
    #EXPAND(joinString),
    TRANSFORM(RECORDOF(dIn1),
      SELF := LEFT;
      SELF := RIGHT;
		),
    #EXPAND(joinType)
    ,HASH
    #IF((BOOLEAN)KeepOption)
      ,KEEP((INTEGER)KeepValue)
    #END
	);

	RETURN dOut;
#END  
ENDMACRO;