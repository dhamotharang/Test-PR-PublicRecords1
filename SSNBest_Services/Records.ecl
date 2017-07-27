IMPORT SSNBest_Services,AutoKeyI,BatchShare;
EXPORT Records(DATASET(SSNBest_Services.Layouts.Batch_temp) ds_in_batch, SSNBest_Services.IParams.BatchParams in_mod) := FUNCTION

  //record that have a valid minimal input criteria
	valid_records := ds_in_batch(error_code=0);
	//only sends in records with valid input criteria
	allRecsWithDIDs := BatchShare.MAC_Get_Scored_DIDs(valid_records,in_mod,usePhone:=TRUE);

	with_bestSSNs := SSNBest_Services.Functions.fetchSSNs(allRecsWithDIDs,in_mod);

	results := JOIN(ds_in_batch,with_bestSSNs,
	            //in order to maintain the sorting, at this point, the acctno contains the seq number
							(UNSIGNED)LEFT.acctno = (UNSIGNED)RIGHT.acctno,
							 TRANSFORM(SSNBest_Services.Layouts.Batch_out
								 ,SELF.acctno := LEFT.orig_acctno //restore original acctno
								 ,SELF.error_code :=
									 MAP(LEFT.error_code  = AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT 
																					=> AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT
											,RIGHT.error_code = AutoKeyI.errorcodes._codes.NO_RECORDS         
																					=> AutoKeyI.errorcodes._codes.NO_RECORDS // if record suppressed due to restrictions
											,RIGHT.out_did    = 0                                             
																					=> AutoKeyI.errorcodes._codes.LEXID_FAIL // if lexID scored < 80
											,0);
								 ,SELF.error_desc := AutoKeyI.errorcodes._msgs(SELF.error_code)
								 ,SELF:=RIGHT)
							 ,LEFT OUTER
							 ,LIMIT(0),KEEP(SSNBest_Services.Constants.MaxResults));

	RETURN results;
END;