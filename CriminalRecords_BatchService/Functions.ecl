import AutokeyB2_batch;
export Functions := MODULE
 
	//get acctno by auto keys which don't have any results or too many result back
  EXPORT get_ak_nr(DATASET(AutokeyB2_batch.Layouts.rec_output_IDs_batch) ak_nr) := FUNCTION
				
		CriminalRecords_BatchService.Layouts.batch_out xfm_ak_recs(recordof(ak_nr) L , DATASET(recordof(ak_nr)) R) :=TRANSFORM
				cur := if (count(R)>1,R(search_status=AutokeyB2_batch.Constants.FAILED_TOO_MANY_MATCHES)
														 ,R(search_status =AutokeyB2_batch.Constants.FAILED_NO_MATCHES));
														 
				SELF.too_many_flag:= if(cur[1].search_Status
													 =AutokeyB2_batch.Constants.FAILED_TOO_MANY_MATCHES
													 ,'Y',if(cur[1].search_Status
																	 =AutokeyB2_batch.Constants.FAILED_NO_MATCHES
																	 ,'N',''));
				SELF := cur[1];
				SELF.too_many_code:= (string3) cur[1].search_status;
				SELF := [];
		END;
		ak_r := ak_nr(search_status=0);
		ak_nr1 := JOIN(ak_nr(Search_Status>0),ak_r
									 ,LEFT.acctno = RIGHT.acctno
									 , LEFT ONLY);

									 
		ak_nr_out := ROLLUP(GROUP(SORT(ak_nr1,acctno),acctno),group,xfm_ak_recs(LEFT,rows(LEFT)));
		RETURN ak_nr_out;
	END;
 
 
END;