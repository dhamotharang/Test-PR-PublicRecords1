IMPORT Std, VersionControl;
EXPORT proc_delete_records(string8 													pVersion   			 = '',
													 boolean													pDeltaBuild 		 = false,
													 DATASET($.Layout_Delete) 				deletes     		 = $.Files().Input.Tradeline_Dels.Using,
													 DATASET($.Layout_Tradeline_base) DeltaTradelines  = $.Ingest().AllRecords_notag,
													 DATASET($.Layout_Tradeline_base) PrevTradelines 	 = $.Files().Base.Tradeline.Qa)
													  
:= FUNCTION
		
		BuildType 	:= if(pDeltaBuild, 1, 2);
		d 		 			:= DISTRIBUTE(deletes, hash32(ACCOUNT_KEY, AR_DATE));
		t_curr 			:= DISTRIBUTE(DeltaTradelines(status<>'D'), hash32(ACCOUNT_KEY, AR_DATE));
		t_curr_dels := DeltaTradelines(status='D');
		t_prev 			:= DISTRIBUTE(PrevTradelines(status<>'D'), hash32(ACCOUNT_KEY, AR_DATE));
		
		integer4 deldate := (integer4)pVersion;
		
		//*** Processing deletes on Delta/incremental build
		//*** Status field is not set to "D" in delta incremental runs.
		DeltaJ  := JOIN(t_curr, d, left.ACCOUNT_KEY=right.ACCOUNT_KEY and left.AR_DATE=right.AR_DATE,
										TRANSFORM($.Layout_Tradeline_base,
															//self.status 								 := IF(left.ACCOUNT_KEY=right.ACCOUNT_KEY and left.AR_DATE=right.AR_DATE, 'D', left.status);
															self.deletion_date 					 := IF(left.ACCOUNT_KEY=right.ACCOUNT_KEY and left.AR_DATE=right.AR_DATE, deldate, left.deletion_date);
															self.dt_vendor_last_reported := IF(left.ACCOUNT_KEY=right.ACCOUNT_KEY and left.AR_DATE=right.AR_DATE, deldate, left.dt_vendor_last_reported);
															self.dt_effective_last			 := IF(left.ACCOUNT_KEY=right.ACCOUNT_KEY and left.AR_DATE=right.AR_DATE, deldate, 0);
															self.delta_ind							 := IF(left.ACCOUNT_KEY=right.ACCOUNT_KEY and left.AR_DATE=right.AR_DATE, 3, 1);
															self 												 := left;),
													LEFT OUTER, LOCAL);
									
		DeltaJ2 := JOIN(t_prev, d, left.ACCOUNT_KEY=right.ACCOUNT_KEY and left.AR_DATE=right.AR_DATE,
										TRANSFORM($.Layout_Tradeline_Base,
															//self.status										:= IF(left.ACCOUNT_KEY=right.ACCOUNT_KEY and left.AR_DATE=right.AR_DATE, 'D', left.status);
															self.deletion_date						:= IF(left.ACCOUNT_KEY=right.ACCOUNT_KEY and left.AR_DATE=right.AR_DATE, deldate, left.deletion_date);
															self.dt_vendor_last_reported	:= IF(left.ACCOUNT_KEY=right.ACCOUNT_KEY and left.AR_DATE=right.AR_DATE, deldate, left.dt_vendor_last_reported);
															self.dt_effective_first				:= IF(left.ACCOUNT_KEY=right.ACCOUNT_KEY and left.AR_DATE=right.AR_DATE, deldate, left.dt_effective_first);
															self.dt_effective_last				:= IF(left.ACCOUNT_KEY=right.ACCOUNT_KEY and left.AR_DATE=right.AR_DATE, deldate, 0);
															self.delta_ind								:= 3;
															self 													:= left;),
										LOOKUP, LOCAL);
		
		DeltaOutRecs := DeltaJ + t_curr_dels + DeltaJ2;
		
		//*** Processing deletes on Full build.
		FullJ := JOIN(t_curr, d, left.ACCOUNT_KEY=right.ACCOUNT_KEY and left.AR_DATE=right.AR_DATE,
									TRANSFORM($.Layout_Tradeline_base,
											self.status 								 := IF(left.ACCOUNT_KEY=right.ACCOUNT_KEY and left.AR_DATE=right.AR_DATE, 'D', left.status);
											self.deletion_date 					 := IF(left.ACCOUNT_KEY=right.ACCOUNT_KEY and left.AR_DATE=right.AR_DATE, deldate, left.deletion_date);
											self.dt_vendor_last_reported := IF(left.ACCOUNT_KEY=right.ACCOUNT_KEY and left.AR_DATE=right.AR_DATE, deldate, left.dt_vendor_last_reported);
											self 												 := left;),
									LEFT OUTER, LOCAL);
		
		FullOutRecs := FullJ + t_curr_dels;
		
		OutRecs := if (BuildType = Cortera_Tradeline._Flags.BuildType.DeltaBuild,
									 DeltaOutRecs,
									 FullOutRecs
									);
						
		return OutRecs;
END;
