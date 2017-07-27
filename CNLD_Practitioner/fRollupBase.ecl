import ut;

export fRollupBase(dataset(CNLD_Practitioner.Layouts.Keybuild) pDataset) := function

   dDataset_sort := sort(pDataset ,except dt_first_seen                
																					,dt_last_seen                 
																					,local
													);	
   
   CNLD_Practitioner.Layouts.Keybuild RollupUpdate(CNLD_Practitioner.Layouts.Keybuild l, CNLD_Practitioner.Layouts.Keybuild r) := transform
      self.dt_first_seen                  := ut.EarliestDate(
                                                             ut.EarliestDate(l.dt_first_seen,	r.dt_first_seen)
                                                            ,ut.EarliestDate(l.dt_last_seen,	r.dt_last_seen)
																														);
      self.dt_last_seen                   := ut.LatestDate(l.dt_last_seen,r.dt_last_seen);
      self := l;
   end;
	 
   dDataset_rollup := rollup( dDataset_sort
                              ,RollupUpdate(left, right)
                              ,except 
                               dt_first_seen                
                               ,dt_last_seen                 
                               ,local
                              );
															
   return dDataset_rollup;
end;
