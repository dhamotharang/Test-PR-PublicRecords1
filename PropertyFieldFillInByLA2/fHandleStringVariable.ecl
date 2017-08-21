EXPORT fHandleStringVariable( FilteredPropertyPairs, distance, DistanceType, a_Variable, b_Variable, a_VariableBit, a_Variable_ftype, b_cleanaid ) := FUNCTIONMACRO

recordof(FilteredPropertyPairs) calcNumeratorOfLA(recordof(FilteredPropertyPairs) ds) := TRANSFORM
// recordof(FilteredPropertyPairs) calcNumeratorOfLA(recordof(FilteredPropertyPairs) l, recordof(FilteredPropertyPairs) r) := TRANSFORM
   self.a_Variable := if (ds.a_Variable > 0, ds.a_Variable, 
													if(ds.a_Variable = 0 and ds.b_Variable > 0, ds.b_Variable,
																ds.a_Variable));
   self.a_VariableBit := if (ds.a_VariableBit = 1, ds.a_VariableBit, 
															if(ds.a_VariableBit = 0 and ds.b_Variable > 0, 1,
																 ds.a_VariableBit));
   self.a_Variable_ftype := IF(DistanceType='adaptive', 'LA1', '');
	 self.match_id := if (ds.a_Variable > 0, 0, 
																	if(ds.a_Variable = 0 and ds.b_Variable > 0, ds.b_cleanaid,
																			0)); 
   self := ds;
END;

dsFilteredPropertyPairs := PROJECT(FilteredPropertyPairs, calcNumeratorOfLA(LEFT));
// LACalculatedVariablesCodeDS :=   
 // dedup(
				// sort(
							// distribute(
													// rollup(FilteredPropertyPairs,
																// (left.geolink=right.geolink) and (left.a_cleanaid=right.a_cleanaid)
																// ,calcNumeratorOfLA(LEFT,RIGHT)
																// ,local
													// )
														// ,hash64(a_cleanaid)
							// )
								// ,a_cleanaid,distance
								// ,local
				// )
                // ,a_cleanaid
                // ,local
     // );     
   



LACalculatedVariablesCodeDS :=
          dedup(
                sort(
                     distribute(dsFilteredPropertyPairs,hash64(a_cleanaid))
                     ,a_cleanaid,distance
                     ,local
                )
                ,a_cleanaid
                ,local
           );
  
return LACalculatedVariablesCodeDS;
ENDMACRO;      
