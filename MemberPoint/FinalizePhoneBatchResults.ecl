
EXPORT FinalizePhoneBatchResults(infile, outlayout, UsePremiumSource_A=FALSE, scoreModel='\'\'', MaxPhoneCount=3) := FUNCTIONMACRO
	
	IMPORT MDR,progressive_phone,Royalty,Phone_Shell;

	//get the running version of waterfall phones / Contact plus
	pHF         := progressive_phone.HelperFunctions;
	PPC         := progressive_phone.Constants;
	version     := pHF.FN_GetVersion(scoreModel, UsePremiumSource_A);
	v_enum      := PPC.Running_Version;

	outlayout into_out(infile l, integer i) := TRANSFORM
		// Add royalty_type field for batch. Batch is not yet able to handle Royalty_Set.
		SELF.royalty_type := map( l.subj_phone_type_new = MDR.sourceTools.src_Equifax  => Royalty.Constants.RoyaltyType.EFX_DATA_MART,
                    	    	   l.vendor IN Royalty.Constants.LastResortRoyalty => Royalty.Constants.RoyaltyType.LAST_RESORT,
                   		     	   l.royalty_type);
    	SELF := l;
	END;

	f_out_post_score_threshold_filter := infile((INTEGER)phone_score >= Phone_Shell.Constants.Default_PhoneScore);
	//filter output per maxPhoneCount
	f_out_post_maxPhoneCount_filter := TOPN(GROUP(SORT(UNGROUP(f_out_post_score_threshold_filter), acctno, -(INTEGER)phone_score, -subj_date_last, subj_phone10, subj_date_first),acctno),
													MaxPhoneCount, acctno, -(INTEGER)phone_score, -subj_date_last, subj_phone10, subj_date_first);

	outfile := if(version = v_enum.CP_V3, PROJECT(f_out_post_maxPhoneCount_filter, into_out(LEFT,counter)),
                               		      PROJECT(GROUP(UNGROUP(infile),acctno), into_out(LEFT,counter)));

	RETURN outfile;
ENDMACRO;