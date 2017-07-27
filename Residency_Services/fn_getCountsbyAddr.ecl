IMPORT batchShare, Residency_Services, ut;

EXPORT fn_getCountsbyAddr(DATASET(Residency_Services.Layouts.Int_Service_output_addr) ServiceIn, 
                          DATASET(Residency_Services.Layouts.IntermediateData) BatchIn) := FUNCTION

	rec_temp   := RECORD
	 Residency_Services.Layouts.Int_Service_output_addr;
	 STRING1  foundIn :='';
	 STRING1  Expired :='';
	END;
	
	screc := PROJECT(DEDUP(SORT(BatchIn,acctno,seq,did,prim_range,prim_name,addr_suffix,z5,
	                                    st,county_name),
	                       acctno,seq,did,prim_range,prim_name,addr_suffix,z5,st,county_name),
									 Residency_Services.Layouts.Int_Service_output_addr); 

	rec_temp tf_isatAddr(ServiceIn l, screc r) := TRANSFORM
		SELF.seq := l.seq;
		SELF.did := l.did;
		SELF.County_name := r.county_name;
		SELF.St          := r.st;              
		SELF.foundIn := IF(l.prim_range =r.prim_range AND
											l.prim_name =r.prim_name AND 
											l.addr_suffix = r.addr_suffix AND
											l.postdir = r.postdir AND
											ut.NNEQ(l.sec_range, r.sec_range) AND
											l.z5 = r.z5 AND
											l.county_name = r.county_name AND
											l.st = r.st,
											'Y','N');
	end;

	trecs := JOIN(ServiceIn,screc, 
								  LEFT.seq = RIGHT.seq AND 
								  LEFT.prim_range =RIGHT.prim_range AND 
								  LEFT.prim_name =RIGHT.prim_name AND 
								  LEFT.addr_suffix = RIGHT.addr_suffix AND 
								  LEFT.postdir = RIGHT.postdir AND
								  ut.NNEQ(LEFT.sec_range, RIGHT.sec_range) AND
								  LEFT.z5 = RIGHT.z5 , 
								tf_isatAddr(LEFT, RIGHT), 
								LEFT OUTER,KEEP(1));

	rec_xtab := RECORD
	 trecs.seq;
	 trecs.did;
	 INTEGER in_cnt  := COUNT(GROUP,trecs.foundIn = 'Y');
	 INTEGER out_cnt := COUNT(GROUP,trecs.foundIn = 'N');
	END;

	xtab_recs := TABLE(trecs,rec_xtab, seq, did, FEW);

	foundrecs := JOIN(BatchIn, xtab_recs,
									    LEFT.seq =	RIGHT.seq,
									  TRANSFORM(Residency_Services.Layouts.IntermediateData,
										  SELF.Veh_in_cnt  := RIGHT.in_cnt,
											SELF.Veh_out_cnt := RIGHT.out_cnt,
											SELF := LEFT),
										LEFT OUTER);
														
	// OUTPUT(trecs,     NAMED('trecs'),extend);																										
	// OUTPUT(xtab_recs, NAMED('xtab_recs'),extend);																										
	// OUTPUT(foundrecs, NAMED('foundrecs'),extend);		
																	
  RETURN foundrecs;

END;