	import BatchDatasets, BatchShare, risk_indicators, riskwise, Std;

	export trisv31_get_hri(
     dataset(BatchServices.TaxRefundISv3_BatchService_Layouts.rec_batch_in_wdid) ds_withDid,
		 BatchServices.TaxRefundISv3_BatchService_Interfaces.Input args_in,
     dataset(BatchServices.TaxRefundISv3_BatchService_Layouts.rec_fp_res_slim) ds_fp_res_in
  )  := function


	 in_mod := module(project(args_in,BatchShare.IParam.BatchParams,opt))
					export unsigned1 DPPA_Purpose := args_in.DPPAPurpose;
					export unsigned1 GLB_Purpose := args_in.GLBPurpose;
					export string DataRestriction := args_in.DataRestriction;
					export string DataPermission := args_in.DataPermission;
			end;
			
			
	ds_IID_BatchIn := project(ds_withDid, transform(BatchDatasets.Layouts.layout_batch_in_waddr_status,
				self := left,
				self := [] ));
					
	ds_IID_res := BatchDatasets.fetch_InstantID_recs(ds_IID_BatchIn,in_mod);
		 
	unsigned1 NumReturnCodes := 12; //doubled for RQ-13836 fix to get more HRI codes
	boolean IsInstantID := true;
	unsigned1 IIDVersion := 1;	
	reasoncode_settings := dataset([{IsInstantID, IIDVersion}],riskwise.layouts.reasoncode_settings);
			
	SET OF STRING2 ACCEPTABLE_HRI_CODES := Std.Str.SplitWords(args_in.AllHRICodes,',');
	
	rec_tris := record
		STRING30	acctno;
		string4   hri_1_code;
		string100 hri_1_desc1;
		string4   hri_2_code;
		string100 hri_2_desc2;
		string4   hri_3_code;
		string4   hri_4_code;
	end;
		
  // NOTE: For bug RQ-13836, found out that risk_indicators.reasonCodes DOES NOT handle 
  // all of the new FP3 HRI codes requested in the v3.2 enhancements req 3.1.3.8;   
  // of which those codes are: BO, QA, QD, QE, S1, S2 or S5, but it does handle new code MO.  
  // Those new codes are handled by Models.fraudpoint3_reasons, but the input to that is not
  // the same as the input to risk_indicators.reasonCodes.
  // However those FP3 HRI codes do come out of the FraudPoint output as reason1-6 fields, so
  // they wll be additionally handled below.
  //  
  // First project the instant ID output using risk_indicators.reasonCodes to get 
  // a child dataset of hri (codes) & descriptions
	rec_hri_child := record
		STRING30	acctno;
    dataset(risk_indicators.Layout_Desc) hri_children;
  end;
	
  ds_iid_wHRI := project(ds_IID_res, 
                         transform(rec_hri_child,
                           self.acctno := (string30)left.seq;
                           self.hri_children := risk_indicators.reasonCodes(left, 
                                                                            NumReturnCodes, 
                                                                            reasoncode_settings);
                        ));

  // normalize the (up to 12) hri child ds recs out of ds_iid_wHRI
  rec_acctno_hri := record
		STRING30	acctno;
		string4   hri;
		string100 desc;
  end;    

  rec_acctno_hri tf_norm_iid(
	    rec_hri_child L, integer C) := transform
		    self.acctno := L.acctno;   
        self.hri    := choose(C,L.hri_children[C].hri);
        self.desc   := choose(C,L.hri_children[C].desc);
	end;

  ds_iid_wHRI_norm := normalize(ds_iid_wHRI, 
                                count(left.hri_children),
                                tf_norm_iid(left,counter));

  // normalize the 6 reason* (hri code) fields out of the passed in FraudPoint results
  rec_acctno_hri tf_norm_fp(
	    BatchServices.TaxRefundISv3_BatchService_Layouts.rec_fp_res_slim L, 
      integer C) := transform
		    self.acctno := L.acctno;   
        self.hri    := choose(C,L.reason1,L.reason2,L.reason3,L.reason4,L.reason5,L.reason6);
        self.desc   := [];  //FP does not output hri descs, so we'll get these later
	end;

  ds_fp_res_in_norm := normalize(ds_fp_res_in, 6, tf_norm_fp(left,counter));

  // concatenate the 2 normed datasets together keeping only non-blank codes
  // and then filter to only keep the TRISv3.2 acceptable codes
  ds_norm_concat  := ds_iid_wHRI_norm(hri != '') + ds_fp_res_in_norm(hri != '');
	
	//TRISv3.2.1 req 4.1.4 - Remove 'S5' from acceptable HRI coder
	//This needs to be removed explicitly because we might get this code passed in by the batch process
  ds_norm_cc_filt := ds_norm_concat(hri IN ACCEPTABLE_HRI_CODES AND hri != 'S5');
  
  // sort (TRISv3.2 alt sort order) & dedup to eliminate any duplicate hri codes
  ds_hri_sort_dd := dedup(sort(ds_norm_cc_filt,
                               acctno,
                               -(hri = '71'),-(hri = 'MO'),-(hri = 'IS'),-(hri = '72'),
                               -(hri = 'RS'),-(hri = '03'),-(hri = 'QE'),-(hri = 'BO'),
                               -(hri = 'QA'),-(hri = 'QD'),-(hri = '11'),-(hri = '14'),
                               -(hri = 'S2'),-(hri = 'S1'),
                               -desc),
                          acctno, hri);

  // Do a group rollup to return top 4 hris and top 2 descs (filling in any blank ones)
 	rec_tris tf_2final(rec_acctno_hri L, dataset(rec_acctno_hri) R) := transform
		self.acctno      := L.acctno;
		self.hri_1_code  := R[1].hri;
		self.hri_1_desc1 := if(R[1].desc != '', R[1].desc,risk_indicators.getHRIDesc(R[1].hri));
		self.hri_2_code  := R[2].hri;
		self.hri_2_desc2 := if(R[2].hri != '',
                           if(R[2].desc != '', R[2].desc,risk_indicators.getHRIDesc(R[2].hri)),
                           '');
	  self.hri_3_code  := R[3].hri;
	  self.hri_4_code  := R[4].hri;
	end;

	ds_hri_top4 := rollup(group(ds_hri_sort_dd,acctno),
                        group,
                        tf_2final(left,rows(left)));
	
  // *--- DEBUG outputs ---* //
  //output(ds_withDid,        named('ds_withDid'));
  //output(ds_fp_res_in,      named('ds_fp_res_in'));
	//output(ds_IID_BatchIn,    named('ds_IID_BatchIn'));
  //output(ds_IID_res,        named('ds_IID_res'));
  //output(ds_iid_wHRI,       named('ds_iid_wHRI'));
  //output(ds_iid_wHRI_norm,  named('ds_iid_wHRI_norm'));
  //output(ds_fp_res_in_norm, named('ds_fp_res_in_norm'));
  //output(ds_norm_concat,    named('ds_norm_concat'));
  //output(ds_norm_cc_filt,   named('ds_norm_cc_filt'));
  //output(ds_hri_sort_dd,    named('ds_hri_sort_dd'));
  //output(ds_hri_top4,       named('ds_hri_top4'));
				
	return ds_hri_top4;
end;
