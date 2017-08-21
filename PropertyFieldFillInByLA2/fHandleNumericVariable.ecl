EXPORT fHandleNumericVariable( FilteredPropertyPairs, distance, DistanceType, a_Variable, b_Variable, a_VariableBit, a_Variable_ftype ) := FUNCTIONMACRO

recordof(FilteredPropertyPairs) calcNumeratorOfLA(recordof(FilteredPropertyPairs) l, recordof(FilteredPropertyPairs) r) := TRANSFORM
      
   l_wgt := 1/(l.distance+0.001);
   current_sum := 
      IF( l.b_seqno=1 
          , l.b_Variable * l_wgt 
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

recordof(FilteredPropertyPairs) divideByTotalWgt(recordof(FilteredPropertyPairs) r) := TRANSFORM
  self.a_Variable := r.a_Variable/r.total_wgt;
  self := r;
END;

LACalculatedVariablesNumericDS :=
   project(
           dedup(
                sort(
                     distribute(
                                rollup(
                                       FilteredPropertyPairs
                                       ,(left.geolink=right.geolink) and (left.a_cleanaid=right.a_cleanaid)
                                       ,calcNumeratorOfLA(LEFT,RIGHT)
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
           ,divideByTotalWgt(LEFT)
   );
                
                return LACalculatedVariablesNumericDS;

ENDMACRO;      
