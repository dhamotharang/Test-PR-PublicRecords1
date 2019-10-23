//This macro join to a key and allows for mini batch join when the input dataset is greater than a certain threshold
//The user should ALWAYS take care of sorting/deduping prior to calling this macro as appropriate
EXPORT macJoinKey(dIn, key, keyedJoinString, miniBatchJoinString, 
  UseIndexThreshold=10000000, joinType = '\'Inner\'', 
  //If KeepOption is true then AtmostOption must be false
  //The user can only select one of these options otherwise neither will be applied
  KeepOption = false, KeepValue = 1, AtmostOption = false, AtmostValue = 100,
  //Hash is only applied for the keyed (small) join
  HashOption = false,
  //Many is only applied for the mini batch (large) join
  ManyOption = false,
	//Option to keep the input dataset over the index dataset
	//this option is useful in cases when the field used to JOIN on the index side 
	//as the same name as a field in the input dataset that is not used in the JOIN
	//For instance if joining on DID2 = s_did with the header key when the input dataset as
	//a field called DID if this option is false then the DID field would take the value of DID2
	//having this option set to true would ensure that DID keeps its value
	//Be careful using this option in cases where you are making multiple JOINs to the same index.
	PreferInputDataset = false) := FUNCTIONMACRO
  
  LOCAL dSmallJoin := JOIN(dIn, key, 
    #EXPAND(keyedJoinString),
		#IF((BOOLEAN)PreferInputDataset)
			TRANSFORM({RECORDOF(LEFT), RECORDOF(RIGHT)},
				SELF := LEFT,
				SELF := RIGHT),
		#ELSE
			TRANSFORM({RECORDOF(RIGHT), RECORDOF(LEFT)}, 
				SELF := RIGHT,
				SELF := LEFT), 
		#END
    KEYED,
    #IF((BOOLEAN)HashOption)
      HASH,
    #END
    #IF((BOOLEAN)KeepOption AND NOT(BOOLEAN)AtmostOption)
      KEEP((INTEGER)KeepValue),
    #END
    #IF((BOOLEAN)AtmostOption AND NOT(BOOLEAN)KeepOption)
      ATMOST((INTEGER)AtmostValue),
    #END
    #EXPAND(joinType));
    
  LOCAL dLargeJoin := JOIN(PULL(key), dIn, 
    #EXPAND(miniBatchJoinString),
		#IF((BOOLEAN)PreferInputDataset)
			TRANSFORM({RECORDOF(RIGHT), RECORDOF(LEFT)}, 
				SELF := RIGHT,
				SELF := LEFT), 
		#ELSE
			TRANSFORM({RECORDOF(LEFT), RECORDOF(RIGHT)}, 
				SELF := LEFT,
				SELF := RIGHT), 
		#END
    SMART, 
    #IF((BOOLEAN)ManyOption)
      MANY, 
    #END
    #IF((BOOLEAN)KeepOption AND NOT(BOOLEAN)AtmostOption)
      KEEP((INTEGER)KeepValue),
    #END
    #IF((BOOLEAN)AtmostOption AND NOT(BOOLEAN)KeepOption)
      ATMOST((INTEGER)AtmostValue),
    #END
    #EXPAND(joinType));
  
  LOCAL dJoin := IF(COUNT(dIn) > (INTEGER)UseIndexThreshold, dLargeJoin, dSmallJoin);
  RETURN dJoin;
ENDMACRO;
