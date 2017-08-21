IMPORT Header, ut, Data_Services, Compliance;

rec_PHdr_extract := Compliance.Layout_PHDR_extract_V2;
	
EXPORT fn_PHDR_extract_addLNDMF(DATASET(rec_PHdr_extract) file_extract, eval_case = '') := 
	FUNCTION
		
		LNDMF_base := Header.File_DID_Death_MasterV3_ssa;
		LNDMF := LNDMF_base;
		
		rec_PHdr_extract	xfmGetLNDMF(file_extract LE, LNDMF RI) :=
			TRANSFORM
//May get back multiple 'DE' joined
//because 'DE' represents both SSA unrestricted and the "old" States
				self.DOD_from_LNDMF := MAP(LE.DOD_from_LNDMF <> '' => LE.DOD_from_LNDMF	//already have D$
												  				 ,(LE.did = (unsigned6) RI.did)
																		AND (LE.src = RI.src)
																		AND ((LE.dt_first_seen = (unsigned3) RI.dod8[1..6]) OR LE.dt_last_seen = (unsigned3) RI.dod8[1..6])
																			=> RI.dod8
																	 ,'');
				self.src_from_LNDMF := RI.src;
				self.rec_src_from_LNDMF := RI.death_rec_src;
				
				self := LE;
				self := RI;
			END;

		rs_GetLNDMF := JOIN(SORT(file_extract, did, src, dt_first_seen, skew(1.0))
											  ,SORT(LNDMF, did, src, dod8, skew(1.0))
												,(left.did = (unsigned6) right.did)
													AND (left.src = right.src)
													AND left.dt_first_seen = (unsigned3) right.dod8[1..6]
												,xfmGetLNDMF(LEFT,RIGHT)
												,LEFT OUTER
												,skew(1.0)
												);
		
		RETURN rs_GetLNDMF;
	END;
	