//--------------------------------------------------------------------------------
// macComputeDatasetSublayout
//
// FunctionMacro that is to generate a sublayout (can be returned as either a string representative of a RECORD definition or an empty dataset) of a dataset by a given field list. 
// Data type of each field is abstracted from the dataset by using TYPEOF.
//
//   Ds                 : The dataset to abstract sublayout from  
//   FieldList          : The fields in the dataset, a comma-delimited string.
//   Prefix             : a string to be prepended to each field in output sublayout;
//                        If omitted or is empty, next parameter NewFieldList will be used in the output sublayout;
//                        If has a nonempty string value, the next parameter NewFieldList will not be used no matter it's empty or not.
//   NewFieldList       : The new field names in output sublayout, a comma-delimited string. 
//                        If Prefix has a nonempty string value, this parameter will not be used no matter it's empty or not.
//                        IF Prefix is empty and NewFieldList is also empty, each sublayout field will be assumed to have the same name as in the dataset.
//   ReturnAsDataset :    TRUE - the layout is returned as an empty dataset; 
//                        FALSE - the layout is returned as a string representative of a RECORD definition, can use #EXPAND to convert it to RECORD data type. 
//
//--------------------------------------------------------------------------------

EXPORT macComputeDatasetSublayout(Ds, FieldList, Prefix = '\'\'', NewFieldList = '\'\'', ReturnAsDataset = FALSE) := FUNCTIONMACRO

IMPORT STD;

#IF(TRIM(FieldList, ALL) <> '')  

  #UNIQUENAME(C)
  #UNIQUENAME(I)
  #UNIQUENAME(SublayoutStr)
  #SET(C, STD.Str.CountWords(FieldList, ','))
  #SET(I, 1)
  #SET(SublayoutStr, '')
	
  #LOOP
    #IF(%I% > %C%)
			#BREAK
    #END
    
    #IF(TRIM(Prefix, ALL) = '')
      #APPEND(SublayoutStr, 
        'TYPEOF(' + TRIM(#TEXT(Ds), ALL) + '.' + TRIM(STD.Str.Extract(FieldList, %I%), ALL) + ') ' +
        IF(TRIM(STD.Str.Extract(NewFieldList, %I%), ALL) <> '', TRIM(STD.Str.Extract(NewFieldList, %I%), ALL), TRIM(STD.Str.Extract(FieldList, %I%), ALL)) +
        ' := ' +
        TRIM(#TEXT(Ds), ALL) + '.' + TRIM(STD.Str.Extract(FieldList, %I%), ALL)
      )
    #ELSE
      #APPEND(SublayoutStr, 
        'TYPEOF(' + TRIM(#TEXT(Ds), ALL) + '.' + TRIM(STD.Str.Extract(FieldList, %I%), ALL) + ') ' +
        TRIM(Prefix, ALL) + TRIM(STD.Str.Extract(FieldList, %I%), ALL) + 
        ' := ' +
        TRIM(#TEXT(Ds), ALL) + '.' + TRIM(STD.Str.Extract(FieldList, %I%), ALL)
      )
    #END
    
    #IF(%I% < %C%)
      #APPEND(SublayoutStr, ', ')
    #END
 
    #SET(I ,%I% + 1)
  #END
    
  LOCAL SublayoutString := '{' + %'SublayoutStr'% + '}';
  
  #IF(ReturnAsDataset)
    LOCAL Sublayout := #EXPAND(SublayoutString);   
    RETURN DATASET([], Sublayout);
  #ELSE  
    RETURN SublayoutString;
  #END
  
#ELSE
  RETURN '';    
#END
ENDMACRO;