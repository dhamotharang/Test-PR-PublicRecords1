// mac_fillinSpecificEmptyVariables.ecl
import PropertyFieldFillinByLA2;
/*
  Inputs to this macro are:
   1. PropertyVariablesDS, with a layout of PropertyFieldFillinByLA2.layout_PropertyFillInVariables.
   2. indata, with a layout of PropertyFieldFillinByLA2.layout_PropertyPairs.
   3. DistanceType, which is either 'adaptive' or 'euclidean'
   4. Variable, which one of the variables that can be filled in, i.e. AssessedAmount or Baths or Bedrooms or BuildingAge or BuildingArea or Rooms or Stories
   5. a_Variable, where 'Variable' is the same as 4, above. This is the 'a' Variable field of the PropertyPairs dataset.
   6. b_Variable, where 'Variable' is the same as 4, above. This is the 'b' Variable field of the PropertyPairs dataset.
   7. a_VariableBit, where 'Variable' is the same as 4, above. This is the 'a' VariableBit field of the PropertyPairs dataset.
   8. b_VariableBit, where 'Variable' is the same as 4, above. This is the 'b' VariableBit field of the PropertyPairs dataset.
   9. a_Variable_ftype, where 'Variable' is the same as 4, above. This is the 'a' Variable_ftype field of the PropertyPairs dataset.
   A. b_Variable_ftype, where 'Variable' is the same as 4, above. This is the 'b' Variable_ftype field of the PropertyPairs dataset.
   B. outdata,  the output file with a layout of PropertyFieldFillinByLA2.layout_PropertyFillInVariables.
   C. outdataname. The name of the output dataset. This is used in a persist attached to the outputted dataset.

  This macro fills a specified field with the Local Average if the field in a record needs it and there
  is enough (10) 'b' records that are similar enough to 'a'.
  
  1st. We filter the inputted PropertyPairs dataset. Records passed thru will be records where:
       1. a_VariableBit=0, meaning a_Variable doesn't have a value.
       2. and b_VariableBit=1, meaning b_Variable does have a value.
       3. if distance is adaptive then distance must be less than 2.5
       4. if distance is euclidean then neither a_Variable nor b_Variable can ready be filled by 'LA1', i.e.on input.
  2nd. We sort so all 'b's of a given 'a' are ordered by their distance to 'a' which means
       the best 'b' is 1st.
  3rd. We sequence the 'b's and eliminate any past the 10th.
  4rd. We set TenthLowestDist (the distance of the last 'b') and n_bPropertiesByA (the number of 'b's we have)
  5th. We calculate the local average of a close 'b's and place it in a_Variable
  Last We put the resulting dataset into the output form, layout_PropertyFillInVariables
       
  USAGE EXAMPLE
  
  PropertyFieldFillinByLA2.mac_FillinSpecificEmptyVariable(PropertyVariablesDS,PropertyPairsDS, 'adaptive', Bedrooms, a_Bedrooms, b_Bedrooms, a_BedroomsBit, b_BedRoomsBit,a_Bedrooms_ftype,b_Bedrooms_ftype, Bedrooms_outdata, 'Bedrooms_outdata' );
*/
EXPORT 
  mac_FillinSpecificEmptyVariable_tim_20131105( 
                                  PropertyVariablesDS
                                  , indata
                                  , DistanceType
                                  , distance
                                  , Variable
                                  , VariableBit
                                  , Variable_ftype
                                  , a_Variable
                                  , b_Variable
                                  , a_VariableBit
                                  , b_VariableBit
                                  , a_Variable_ftype
                                  , b_Variable_ftype
																	, VariableType
																	, b_cleanaid
                                  , outdata
                                  , outdataname
                                 ) := MACRO
/*
  This function returns either true or false which is used in filtering the PropertyPairsDS to
  remove records that can't be used during the calculation of the average.
*/
#uniquename(PreFilterForFillin)
boolean %PreFilterForFillin%( 
                          string DistanceType
                          , unsigned a_VariableBit
                          , unsigned b_VariableBit
                          , string3 a_Variable_ftype
                          , string3 b_Variable_ftype
                          , real distance 
													, string4 VariableType
													, unsigned b_cleanaid
													) := FUNCTION
                          
   boolean b1 := (a_VariableBit=0 ) and ( b_VariableBit=1 );
   boolean b2 :=
       IF( ( DistanceType='euclidean' ) and ((a_Variable_ftype='LA1') or (b_Variable_ftype='LA1'))
             ,false
             ,true
       );
      
return b1 and b2;
END;
#uniquename(sequencePropertyPairs)
recordof(indata) %sequencePropertyPairs%(recordof(indata) l, recordof(indata) r) := TRANSFORM
  self.b_seqno :=
     IF( (l.geolink=r.geolink) and (l.a_cleanaid=r.a_cleanaid)
				, IF( VariableType = 'numr' and	l.b_seqno < 10
             , l.b_seqno + 1
						 ,IF(VariableType = 'char' and	l.b_seqno < 100
							, l.b_seqno + 1
             , skip
          ))
        , 1
     );
  self := r;
END;
#uniquename(fillTenthLowestDist)
recordof(indata) %fillTenthLowestDist%(recordof(indata) l, recordof(indata) r) := TRANSFORM
  self.TenthLowestDist :=
		 IF( (l.geolink=r.geolink) and (l.a_cleanaid=r.a_cleanaid)
        , l.TenthLowestDist
        , r.distance
     );
  self.n_bPropertiesByA :=
     IF( (l.geolink=r.geolink) and (l.a_cleanaid=r.a_cleanaid)
		    , l.n_bPropertiesByA
        , r.b_seqno
     );
  self := r;
END;


#uniquename(FilterBeforeFillin_PropertyPairsDS)
%FilterBeforeFillin_PropertyPairsDS% := 
   sort(
        iterate(
                sort(
                     iterate(
                             sort(
                                  distribute(
                                             indata( %PreFilterForFillin%
                                                           (
                                                            DistanceType
                                                            , a_VariableBit
																														, b_VariableBit
                                                            , a_Variable_ftype
                                                            , b_Variable_ftype
                                                            , distance
																														, VariableType
																														, b_cleanaid
                                                           )
                                              )
                                              , hash64(geolink,a_cleanaid)
                                   )
                                  ,geolink,a_cleanaid, distance,VariableType
                                  ,local
                             )
                             , %sequencePropertyPairs%(LEFT,RIGHT)
                             , local
                     )
                     ,geolink,a_cleanaid,-b_seqno
                     ,local
                )
                ,%fillTenthLowestDist%(LEFT,RIGHT)
                ,local
        )
        ,geolink,a_cleanaid, b_seqno
        ,local
   );
	 
// #IF ( set_debug >= 2 )
// #uniquename(FilteredBeforeFilename)
// %FilteredBeforeFilename% := '~thor_data400::temp::PropertyFieldFillinByLA2::FilteredBefore_'+outdataname;
// output(%FilterBeforeFillin_PropertyPairsDS%,,%FilteredBeforeFilename%,OVERWRITE);
// #END


#uniquename(LACalculatedVariablesDS)
%LACalculatedVariablesDS% :=
   #IF (VariableType='numr')
      PropertyFieldFillinByLA2.fHandleNumericVariable(%FilterBeforeFillin_PropertyPairsDS%(n_bPropertiesByA >= 10 and a_Variable = 0 and b_seqno <= 10), distance, DistanceType, a_Variable, b_Variable, a_VariableBit, a_Variable_ftype);
   #ELSE
      PropertyFieldFillinByLA2.fHandleStringVariable(%FilterBeforeFillin_PropertyPairsDS%( n_bPropertiesByA >= 1), distance, DistanceType, a_Variable, b_Variable, a_VariableBit, a_Variable_ftype, b_cleanaid);
   #END

// #IF ( set_debug >= 2 )
// #uniquename(debug_LACalculatedVariablesDS_file)
// %debug_LACalculatedVariablesDS_file% := '~thor_data400::temp::PropertyFieldFillinByLA2::debug_LACalculatedVariablesDS';
// output(%LACalculatedVariablesDS%,,%debug_LACalculatedVariablesDS_file%,OVERWRITE);
// #END
	 


#uniquename(fillinEmptyVariablesInPropertyFillInVariables)
recordof(PropertyVariablesDS) %fillinEmptyVariablesInPropertyFillInVariables%(recordof(PropertyVariablesDS) l, recordof(indata) r) := TRANSFORM
   self.Variable :=
     IF( r.a_Variable_ftype=''
         , l.Variable
         , r.a_Variable
     );
   self.VariableBit :=
     IF( r.a_Variable_ftype=''
         , l.VariableBit
         , r.a_VariableBit
     );
   self.Variable_ftype :=
     IF( r.a_Variable_ftype=''
         , l.Variable_ftype
         , r.a_Variable_ftype
     );
	 self.b_cleanaid := 
	 IF( r.a_Variable_ftype=''
        , l.b_cleanaid
        , r.b_cleanaid
     );
	 // self.adistance := 
	 // IF( r.a_Variable_ftype=''
         // , l.adistance
         // , r.adistance
     // );
   self := l;
END;
outdata := 
   join(distribute(PropertyVariablesDS,hash64(cleanaid))
        ,%LACalculatedVariablesDS%
        ,(left.cleanaid=right.a_cleanaid)
        ,%fillinEmptyVariablesInPropertyFillInVariables%(LEFT,RIGHT)
        ,local
   );

// #IF ( set_debug >= 2 )
// #uniquename(debug_LACalculatedVariablesDS_file)
// %debug_LACalculatedVariablesDS_file% := '~thor_data400::temp::PropertyFieldFillinByLA2::debug_LACalculatedVariablesDS_'+outdataname;
// output(%LACalculatedVariablesDS%,,%debug_LACalculatedVariablesDS_file%,OVERWRITE);
// #END
	 
	 
// #IF ( set_debug >= 2 )
// #uniquename(persistfilename)
// %persistfilename% := '~thumphrey::'+pversion+'::temp::'+DistanceType+'_'+outdataname;
// %persistfilename% := '~thor_data400::temp::PropertyFieldFillinByLA2::'+pversion+'::'+DistanceType+'_'+outdataname;
// output(outdata,,%persistfilename%,OVERWRITE);
// #END
ENDMACRO;

