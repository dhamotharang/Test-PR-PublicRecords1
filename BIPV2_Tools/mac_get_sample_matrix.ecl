EXPORT mac_get_sample_matrix(

   pdataset  
  ,pcount_cnp_names_field = 'count_cnp_names'  
  ,pcount_feins_field     = 'count_feins'
  ,pNumSamples            = '20' 

) := 
functionmacro

  ds_samples := choosesets(pdataset
    ,pcount_cnp_names_field = 1               and pcount_feins_field = 1 => pNumSamples
    ,pcount_cnp_names_field = 2               and pcount_feins_field = 1 => pNumSamples
    ,pcount_cnp_names_field = 3               and pcount_feins_field = 1 => pNumSamples
    ,pcount_cnp_names_field = 4               and pcount_feins_field = 1 => pNumSamples
    ,pcount_cnp_names_field = 5               and pcount_feins_field = 1 => pNumSamples
    ,pcount_cnp_names_field between 6  and 10 and pcount_feins_field = 1 => pNumSamples
    ,pcount_cnp_names_field between 11 and 15 and pcount_feins_field = 1 => pNumSamples
    ,pcount_cnp_names_field > 15              and pcount_feins_field = 1 => pNumSamples
  
    ,pcount_cnp_names_field = 1               and pcount_feins_field = 2 => pNumSamples
    ,pcount_cnp_names_field = 2               and pcount_feins_field = 2 => pNumSamples
    ,pcount_cnp_names_field = 3               and pcount_feins_field = 2 => pNumSamples
    ,pcount_cnp_names_field = 4               and pcount_feins_field = 2 => pNumSamples
    ,pcount_cnp_names_field = 5               and pcount_feins_field = 2 => pNumSamples
    ,pcount_cnp_names_field between 6  and 10 and pcount_feins_field = 2 => pNumSamples
    ,pcount_cnp_names_field between 11 and 15 and pcount_feins_field = 2 => pNumSamples
    ,pcount_cnp_names_field > 15              and pcount_feins_field = 2 => pNumSamples
    
    ,pcount_cnp_names_field = 1               and pcount_feins_field = 3 => pNumSamples
    ,pcount_cnp_names_field = 2               and pcount_feins_field = 3 => pNumSamples
    ,pcount_cnp_names_field = 3               and pcount_feins_field = 3 => pNumSamples
    ,pcount_cnp_names_field = 4               and pcount_feins_field = 3 => pNumSamples
    ,pcount_cnp_names_field = 5               and pcount_feins_field = 3 => pNumSamples
    ,pcount_cnp_names_field between 6  and 10 and pcount_feins_field = 3 => pNumSamples
    ,pcount_cnp_names_field between 11 and 15 and pcount_feins_field = 3 => pNumSamples
    ,pcount_cnp_names_field > 15              and pcount_feins_field = 3 => pNumSamples
  
    ,pcount_cnp_names_field = 1               and pcount_feins_field = 4 => pNumSamples
    ,pcount_cnp_names_field = 2               and pcount_feins_field = 4 => pNumSamples
    ,pcount_cnp_names_field = 3               and pcount_feins_field = 4 => pNumSamples
    ,pcount_cnp_names_field = 4               and pcount_feins_field = 4 => pNumSamples
    ,pcount_cnp_names_field = 5               and pcount_feins_field = 4 => pNumSamples
    ,pcount_cnp_names_field between 6  and 10 and pcount_feins_field = 4 => pNumSamples
    ,pcount_cnp_names_field between 11 and 15 and pcount_feins_field = 4 => pNumSamples
    ,pcount_cnp_names_field > 15              and pcount_feins_field = 4 => pNumSamples

    ,pcount_cnp_names_field = 1               and pcount_feins_field = 5 => pNumSamples
    ,pcount_cnp_names_field = 2               and pcount_feins_field = 5 => pNumSamples
    ,pcount_cnp_names_field = 3               and pcount_feins_field = 5 => pNumSamples
    ,pcount_cnp_names_field = 4               and pcount_feins_field = 5 => pNumSamples
    ,pcount_cnp_names_field = 5               and pcount_feins_field = 5 => pNumSamples
    ,pcount_cnp_names_field between 6  and 10 and pcount_feins_field = 5 => pNumSamples
    ,pcount_cnp_names_field between 11 and 15 and pcount_feins_field = 5 => pNumSamples
    ,pcount_cnp_names_field > 15              and pcount_feins_field = 5 => pNumSamples

    ,pcount_cnp_names_field = 1               and pcount_feins_field between 6 and 10 => pNumSamples
    ,pcount_cnp_names_field = 2               and pcount_feins_field between 6 and 10 => pNumSamples
    ,pcount_cnp_names_field = 3               and pcount_feins_field between 6 and 10 => pNumSamples
    ,pcount_cnp_names_field = 4               and pcount_feins_field between 6 and 10 => pNumSamples
    ,pcount_cnp_names_field = 5               and pcount_feins_field between 6 and 10 => pNumSamples
    ,pcount_cnp_names_field between 6  and 10 and pcount_feins_field between 6 and 10 => pNumSamples
    ,pcount_cnp_names_field between 11 and 15 and pcount_feins_field between 6 and 10 => pNumSamples
    ,pcount_cnp_names_field > 15              and pcount_feins_field between 6 and 10 => pNumSamples

    ,pcount_cnp_names_field = 1               and pcount_feins_field between 11 and 15 => pNumSamples
    ,pcount_cnp_names_field = 2               and pcount_feins_field between 11 and 15 => pNumSamples
    ,pcount_cnp_names_field = 3               and pcount_feins_field between 11 and 15 => pNumSamples
    ,pcount_cnp_names_field = 4               and pcount_feins_field between 11 and 15 => pNumSamples
    ,pcount_cnp_names_field = 5               and pcount_feins_field between 11 and 15 => pNumSamples
    ,pcount_cnp_names_field between 6  and 10 and pcount_feins_field between 11 and 15 => pNumSamples
    ,pcount_cnp_names_field between 11 and 15 and pcount_feins_field between 11 and 15 => pNumSamples
    ,pcount_cnp_names_field > 15              and pcount_feins_field between 11 and 15 => pNumSamples

    ,pcount_cnp_names_field = 1               and pcount_feins_field > 15 => pNumSamples
    ,pcount_cnp_names_field = 2               and pcount_feins_field > 15 => pNumSamples
    ,pcount_cnp_names_field = 3               and pcount_feins_field > 15 => pNumSamples
    ,pcount_cnp_names_field = 4               and pcount_feins_field > 15 => pNumSamples
    ,pcount_cnp_names_field = 5               and pcount_feins_field > 15 => pNumSamples
    ,pcount_cnp_names_field between 6  and 10 and pcount_feins_field > 15 => pNumSamples
    ,pcount_cnp_names_field between 11 and 15 and pcount_feins_field > 15 => pNumSamples
    ,pcount_cnp_names_field > 15              and pcount_feins_field > 15 => pNumSamples
  );
  
  return project(ds_samples,transform(recordof(left)
    ,self.cnt_cnp_names     := if(counter = 1 ,left.cnt_cnp_names    ,'') 
    ,self.cnt_feins         := if(counter = 1 ,left.cnt_feins        ,'')
    ,self.pct_bow_mismatch  := if(counter = 1 ,left.pct_bow_mismatch ,'')
    ,self.seq               := if(counter = 1 ,left.seq              ,'')
    ,self                   := left
  ));
endmacro;
