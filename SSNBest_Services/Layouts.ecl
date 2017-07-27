IMPORT BatchShare,Header;
EXPORT Layouts := MODULE

	EXPORT Batch_in := RECORD
		BatchShare.Layouts.ShareAcct;
		BatchShare.Layouts.ShareDid;
		BatchShare.Layouts.SharePII;
		BatchShare.Layouts.SharePhone;
		BatchShare.Layouts.ShareName;
		BatchShare.Layouts.ShareAddress;
	END;

	EXPORT Batch_temp := RECORD(Batch_in)
		string20	orig_acctno 	:= ''; // [internal]
		Batchshare.Layouts.ShareErrors;
	END;

	EXPORT Batch_out := RECORD
	  BatchShare.Layouts.ShareAcct;
		UNSIGNED8 error_code:=0;
		STRING100	error_desc:='';
		UNSIGNED6	out_did;
		STRING9   best_ssn;
		TYPEOF(Header.layout_AllPossibleSSNs._src_rec.dt_first_seen) dt_first_seen;
		TYPEOF(Header.layout_AllPossibleSSNs._src_rec.dt_last_seen)  dt_last_seen;
		STRING1  poss_shared_ssn;
		TYPEOF(Header.layout_AllPossibleSSNs._subject_rec.other_cnt) other_cnt;
		STRING4 hri_code_1:='';
		STRING100 hri_desc_1:='';
		STRING4 hri_code_2:='';
		STRING100 hri_desc_2:='';
		STRING4 hri_code_3:='';
		STRING100 hri_desc_3:='';
		STRING4 hri_code_4:='';
		STRING100 hri_desc_4:='';
		STRING4 hri_code_5:='';
		STRING100 hri_desc_5:='';
		STRING4 hri_code_6:='';
		STRING100 hri_desc_6:='';
		STRING1 bureau_only_ssn;
	END;
	
	EXPORT KEY_full := RECORD 
		Header.layout_AllPossibleSSNs._main;
		BOOLEAN SSN_Already_found:=FALSE; //this will be set to TRUE if the SSN found in the SSN_BEST key
											                //with a confidence of 1 is = to the SSN found by the ADL_BEST logic
														          //and restrictions will not be applied on those since they have already been applied in ADL_Best
	END;		
		
	EXPORT KEY_subjNorm := RECORD //did,ssn,score,confidence,other_cnt,ssn_ind,[srcs],SSN_Already_found
		UNSIGNED6 did;
		RECORDOF(Header.layout_AllPossibleSSNs._subject_rec) AND NOT [_ssndata,other];
		STRING1 ssn_ind;
		BOOLEAN SSN_Already_found:=FALSE;
		DATASET(Header.layout_AllPossibleSSNs._src_rec) srcs;
	END;

	EXPORT KEY_subjSrcNorm := RECORD //did,ssn,score,confidence,other_cnt,ssn_ind,src,dt_first_seen,dt_last_seen,SSN_Already_found
		RECORDOF(KEY_subjNorm) AND NOT [srcs];
		RECORDOF(Header.layout_AllPossibleSSNs._src_rec) AND NOT [src_rank,ispriortodob];
	END;

END;