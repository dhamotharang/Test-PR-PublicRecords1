IMPORT Residency_Services, ut;

EXPORT fn_getPropertyCounts(DATASET(Residency_Services.Layouts.Prop_Service_output) ds_prop_recs, 
                            DATASET(Residency_Services.Layouts.IntermediateData) ds_prop_cnts
													 ) := FUNCTION

  // Check for matches between input prop_recs (potentially with homestead=Y/N) and in_counts ds
	// to set homestead related fields as needed.
	ds_prop_cnts_out  := JOIN(ds_prop_cnts, ds_prop_recs,
										           LEFT.acctno = RIGHT.acctno AND
															 LEFT.seq    =	RIGHT.seq,  // match to the correct address(seq)
										         TRANSFORM(Residency_Services.Layouts.IntermediateData,
													     SELF.Property_Homestead := RIGHT.homestead,
											         SELF.Homestead_in_cnt   := IF(RIGHT.homestead = 'Y', 1,0),
											         SELF := LEFT),
										         LEFT OUTER);

   //OUTPUT(ds_prop_cnts_out,   NAMED('fgpc_ds_prop_cnts_out'));

	RETURN ds_prop_cnts_out;

END;