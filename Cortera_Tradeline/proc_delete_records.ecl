IMPORT Std, VersionControl;
EXPORT proc_delete_records(string8 													pVersion   			 = '',
													 boolean													pDeltaBuild 		 = false,
													 DATASET($.Layout_Delete) 				deletes     		 = $.Files().Input.Tradeline_Dels.Using,
													 DATASET($.Layout_Tradeline_base) DeltaTradelines  = $.Ingest().AllRecords_notag,
													 DATASET($.Layout_Tradeline_base) PrevTradelines 	 = $.Files().Base.Tradeline.Qa)
													  
:= FUNCTION
		
		BuildType := if(pDeltaBuild, 1, 2);
		d 		 		:= DISTRIBUTE(deletes, hash32(ACCOUNT_KEY, AR_DATE));
		t_curr 		:= DISTRIBUTE(DeltaTradelines(status<>'D'), hash32(ACCOUNT_KEY, AR_DATE));
		t_prev 		:= DISTRIBUTE(PrevTradelines(status<>'D'), hash32(ACCOUNT_KEY, AR_DATE));
		//t 		 := if (pDeltaBuild, t_curr,	t_curr());
		
		//t := DISTRIBUTE(PrevTradelines(status<>'D'), hash32(ACCOUNT_KEY, AR_DATE));
		integer4 deldate := (integer4)pVersion;
		
		//*** Processing deletes on Delta/incremental build
		//*** Staus field is not set to "D" for delta incremnal runs.
		DeltaJ  := JOIN(t_curr, d, left.ACCOUNT_KEY=right.ACCOUNT_KEY and left.AR_DATE=right.AR_DATE,
										TRANSFORM($.Layout_Tradeline_base,
															//self.status 								 := IF(left.ACCOUNT_KEY=right.ACCOUNT_KEY and left.AR_DATE=right.AR_DATE, 'D', left.status);
															self.deletion_date 					 := IF(left.ACCOUNT_KEY=right.ACCOUNT_KEY and left.AR_DATE=right.AR_DATE, deldate, left.deletion_date);
															self.dt_vendor_last_reported := IF(left.ACCOUNT_KEY=right.ACCOUNT_KEY and left.AR_DATE=right.AR_DATE, deldate, left.dt_vendor_last_reported);
															self.dt_effective_last			 := IF(left.ACCOUNT_KEY=right.ACCOUNT_KEY and left.AR_DATE=right.AR_DATE, deldate, 0);
															self 												 := left;),
													LEFT OUTER, LOCAL);
									
		DeltaJ2 := JOIN(t_prev, d, left.ACCOUNT_KEY=right.ACCOUNT_KEY and left.AR_DATE=right.AR_DATE,
										TRANSFORM($.Layout_Tradeline_Base,
															//self.status										:= IF(left.ACCOUNT_KEY=right.ACCOUNT_KEY and left.AR_DATE=right.AR_DATE, 'D', left.status);
															self.deletion_date						:= IF(left.ACCOUNT_KEY=right.ACCOUNT_KEY and left.AR_DATE=right.AR_DATE, deldate, left.deletion_date);
															self.dt_vendor_last_reported	:= IF(left.ACCOUNT_KEY=right.ACCOUNT_KEY and left.AR_DATE=right.AR_DATE, deldate, left.dt_vendor_last_reported);
															self.dt_effective_first				:= left.filedate;
															self.dt_effective_last				:= IF(left.ACCOUNT_KEY=right.ACCOUNT_KEY and left.AR_DATE=right.AR_DATE, deldate, 0);
															self.delta_ind								:= 1;
															self 													:= left;),
										LOOKUP, LOCAL);
										
		//output(choosen(DeltaJ, 500), named('DeltaJ'));
		//output(count(DeltaJ), named('DeltaJ_Cnt'));
		
		//output(t_curr(status='D'), named('t_curr_status_d'));
		
		//output(DeltaJ2, named('DeltaJ2'));
		//output(count(DeltaJ2), named('DeltaJ2_Cnt'));
		
							
		DeltaOutRecs := DeltaJ + t_curr(status='D') + DeltaJ2;
		
		//*** Processing deletes on Full build.
		FullJ := JOIN(t_curr, d, left.ACCOUNT_KEY=right.ACCOUNT_KEY and left.AR_DATE=right.AR_DATE,
									TRANSFORM($.Layout_Tradeline_base,
											self.status 								 := IF(left.ACCOUNT_KEY=right.ACCOUNT_KEY and left.AR_DATE=right.AR_DATE, 'D', left.status);
											self.deletion_date 					 := IF(left.ACCOUNT_KEY=right.ACCOUNT_KEY and left.AR_DATE=right.AR_DATE, deldate, left.deletion_date);
											self.dt_vendor_last_reported := IF(left.ACCOUNT_KEY=right.ACCOUNT_KEY and left.AR_DATE=right.AR_DATE, deldate, left.dt_vendor_last_reported);
											self 												 := left;),
									LEFT OUTER, LOCAL);
		
		//output(FullJ, named('FullJ'));
		//output(count(FullJ), named('FullJ_Cnt'));
		
		FullOutRecs := FullJ + t_curr(status='D');

		OutRecs := if (BuildType = Cortera_Tradeline._Flags.BuildType.DeltaBuild,
									 DeltaOutRecs,
									 FullOutRecs
									);
						
		return OutRecs;
END;
