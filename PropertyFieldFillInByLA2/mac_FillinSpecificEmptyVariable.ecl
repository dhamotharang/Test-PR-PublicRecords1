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
  mac_FillinSpecificEmptyVariable( 
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
                          , real distance ) := FUNCTION
                          
   boolean b1 := ( a_VariableBit=0 ) and ( b_VariableBit=1 );
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
        , IF( l.b_seqno < 10
             , l.b_seqno + 1
             , skip
          )
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

/*
*/
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
                                                            , a_VariableBit, b_VariableBit
                                                            , a_Variable_ftype
                                                            , b_Variable_ftype
                                                            , distance
                                                           )
                                              )
                                              , hash64(geolink,a_cleanaid)
                                   )
                                  ,geolink,a_cleanaid, distance
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
#IF ( set_debug >= 2 )
#uniquename(FilteredBeforeFilename)
// %FilteredBeforeFilename% := '~thumphrey::'+pversion+'::temp::'+DistanceType+'_'+outdataname+'_FilteredBefore';
%FilteredBeforeFilename% := '~thor_data400::temp::PropertyFieldFillinByLA2::FilteredBefore_'+outdataname;
output(%FilterBeforeFillin_PropertyPairsDS%,,%FilteredBeforeFilename%,OVERWRITE);
#END

#uniquename(debug_calcNumeratorOfLA)
recordof(indata) %debug_calcNumeratorOfLA%(recordof(indata) l, recordof(indata) r) := TRANSFORM
   current_sum := 
      IF( r.b_seqno=1
          , 0
          , l.a_Variable
      );
      
   r_wgt := 1/(r.distance+0.001);
   self.a_VariableBit := 1;
   self.a_Variable_ftype := IF(DistanceType='adaptive', 'LA1', 'LA2');
   self.a_Variable := current_sum + (r_wgt * r.b_Variable);
   self.total_wgt := 
      IF( r.b_seqno=1
          , r_wgt
          , l.total_wgt + r_wgt
      );
   self := r;
END;
#uniquename(calcNumeratorOfLA)
recordof(indata) %calcNumeratorOfLA%(recordof(indata) l, recordof(indata) r) := TRANSFORM
      
   l_wgt := 1/(l.distance+0.001);
   current_sum := 
      IF( l.b_seqno=1
          , l_wgt * l.b_Variable
          , l.a_Variable
      );
      
   r_wgt := 1/(r.distance+0.001);
   self.a_Variable := current_sum + (r_wgt * r.b_Variable);
   self.total_wgt := 
      IF( l.b_seqno=1
          , l_wgt+r_wgt
          , l.total_wgt + r_wgt
      );
   self.a_VariableBit := 1;
   self.a_Variable_ftype := IF(DistanceType='adaptive', 'LA1', 'LA2');
   self := r;
END;
#uniquename(divideByTotalWgt)
recordof(indata) %divideByTotalWgt%(recordof(indata) r) := TRANSFORM
  self.a_Variable := r.a_Variable/r.total_wgt;
  self := r;
END;
#uniquename(debug_LACalculatedVariablesDS)
%debug_LACalculatedVariablesDS% :=
    iterate(
           %FilterBeforeFillin_PropertyPairsDS%( n_bPropertiesByA >= 10 )
           ,%debug_calcNumeratorOfLA%(LEFT,RIGHT)
           ,local
    );
#IF ( set_debug >= 2 )
#uniquename(debug_LACalculatedVariablesDS_file)
// %debug_LACalculatedVariablesDS_file% := '~thumphrey::'+pversion+'::temp::'+DistanceType+'_'+outdataname+'_debug_LACalculatedVariablesDS_';
%debug_LACalculatedVariablesDS_file% := '~thor_data400::temp::PropertyFieldFillinByLA2::debug_LACalculatedVariablesDS_'+outdataname;
output(%debug_LACalculatedVariablesDS%,,%debug_LACalculatedVariablesDS_file%,OVERWRITE);
#END

#uniquename(LACalculatedVariablesDS)
%LACalculatedVariablesDS% :=
   project(
           dedup(
                sort(
                     distribute(
                                rollup(
                                       %FilterBeforeFillin_PropertyPairsDS%( n_bPropertiesByA >= 10 ) // Remove any records with less than 10 'b's.
                                       ,(left.geolink=right.geolink) and (left.a_cleanaid=right.a_cleanaid)
                                       ,%calcNumeratorOfLA%(LEFT,RIGHT)
                                       ,local
                                )
                                ,hash64(a_cleanaid)
                     )
                     ,a_cleanaid,-total_wgt
                     ,local
                )
                ,a_cleanaid
                ,local
           )
           ,%divideByTotalWgt%(LEFT)
   );
#IF ( set_debug >= 2 )
#uniquename(JustBeforeFinalOutput)
// %JustBeforeFinalOutput% := '~thumphrey::'+pversion+'::temp::'+DistanceType+'_'+outdataname+'_BeforeFinalOutput';
%JustBeforeFinalOutput% := '~thor_data400::temp::PropertyFieldFillinByLA2::'+pversion+'::temp::'+DistanceType+'_'+outdataname+'_BeforeFinalOutput';
output(%LACalculatedVariablesDS%,,%JustBeforeFinalOutput%,OVERWRITE);
#END

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
   self := l;
END;
outdata := 
   join(distribute(PropertyVariablesDS,hash64(cleanaid))
        ,%LACalculatedVariablesDS%
        ,(left.cleanaid=right.a_cleanaid)
        ,%fillinEmptyVariablesInPropertyFillInVariables%(LEFT,RIGHT)
        ,local
   );
#IF ( set_debug >= 2 )
#uniquename(persistfilename)
// %persistfilename% := '~thumphrey::'+pversion+'::temp::'+DistanceType+'_'+outdataname;
%persistfilename% := '~thor_data400::temp::PropertyFieldFillinByLA2::'+pversion+'::temp::'+DistanceType+'_'+outdataname;
output(outdata,,%persistfilename%,OVERWRITE);
#END
ENDMACRO;

