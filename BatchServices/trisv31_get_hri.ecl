	import BatchDatasets,risk_indicators,riskwise, Std;

	export trisv31_get_hri(dataset(BatchServices.TaxRefundISv3_BatchService_Layouts.rec_batch_in_wdid) ds_withDid ,
												 BatchServices.TaxRefundISv3_BatchService_Interfaces.Input args_in)  := function


	 in_mod := module(project(args_in,BatchDatasets.IParams.BatchParams,opt))
					export unsigned1 DPPA_Purpose := args_in.DPPAPurpose;
					export unsigned1 GLB_Purpose := args_in.GLBPurpose;
					export string Model_in := '';
					export string DataRestriction := args_in.DataRestriction;
					export string DataPermission := args_in.DataPermission;
					export boolean ExactSSNMatch := true;
					export boolean IncludeAllRiskIndicators := true;
			end;
			
			
	IIDBatchIn := project(ds_withDid, transform(BatchDatasets.Layouts.layout_batch_in_waddr_status,
				self := left,
				self := [] ));
					
	dsIID := BatchDatasets.fetch_InstantID_recs(IIDBatchIn,in_mod);
		 
	unsigned1 NumReturnCodes := risk_indicators.iid_constants.DefaultNumCodes;
	boolean IsInstantID := true;
	unsigned1 IIDVersion := 1;	
	reasoncode_settings := dataset([{IsInstantID, IIDVersion}],riskwise.layouts.reasoncode_settings);
			
	SET OF STRING2 ACCEPTABLE_HRI_CODES := Std.Str.SplitWords(args_in.AllHRICodes,',');
	
	rec_tris := record
		STRING30	acctno;
		string4 hri_1_code;
		string100 hri_1_desc1;
		string4 hri_2_code;
		string100 hri_2_desc2;
		string4 hri_3_code;
		string4 hri_4_code;
	end;
		
	rec_tris into_final(BatchDatasets.Layouts.layout_batch_in_waddr_status le, Risk_Indicators.Layout_Output ri) := transform
				
		reasonCodes := risk_indicators.reasonCodes(ri, NumReturnCodes, reasoncode_settings);
		
		// **** TRIS v3.2 Enhancement project : Applying sorting as per requirement 3.1.3.8.
		reasonCodesSorted := SORT(reasonCodes, -(hri = '71'),-(hri = 'MO'),-(hri = 'IS'),-(hri = '72'),-(hri = 'RS'),
																					 -(hri = '03'),-(hri = 'QE'),-(hri = 'BO'),-(hri = 'QA'),-(hri = 'QD'),
																					 -(hri = '11'),-(hri = '14'),-(hri = 'S2'),-(hri = 'S1'),-(hri = 'S5'));
		filt := reasonCodesSorted(hri In ACCEPTABLE_HRI_CODES);
		self.acctno       := le.acctno;
		self.hri_1_code   := filt[1].hri;
		self.hri_1_desc1  := filt[1].desc;
		self.hri_2_code   := filt[2].hri;
		self.hri_2_desc2  := filt[2].desc;
	  self.hri_3_code   := filt[3].hri;
	  self.hri_4_code   := filt[4].hri;
	end;

	ds_iid_recs := 
				join(
					IIDBatchIn, dsIID, 
					(unsigned4)left.acctno = right.seq, 
					into_final(left,right), 
					left outer, limit(0), keep(1)
				);
				
	return ds_iid_recs;
end;

