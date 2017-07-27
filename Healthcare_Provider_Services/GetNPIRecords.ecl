import CLIA, BatchServices, Autokey_batch, NPPES, AutokeyB2;
EXPORT GetNPIRecords (DATASET	(Healthcare_Provider_Services.NPI_Layouts.batch_in) batch_in, CLIA_Interfaces.clia_config in_mod) := FUNCTION

		ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
			export workHard        := TRUE; // for Autokey_batch.Fetch_Address_Batch to run at all.
			export useAllLookups   := TRUE; // for Autokey_batch.Fetch_SSN_Batch to run SSN2 key. SSN key is empty.
			export isTestHarness   := FALSE;
			export PenaltThreshold := in_mod.penalty_threshold;
			export skip_set        := NPPES.Constants().ak_skipSet;
		END;
		
		ds_fids := Autokey_batch.get_fids(project(batch_in(npinumber = ''),Autokey_batch.Layouts.rec_inBatchMaster), NPPES.Constants().str_autokeyname, ak_config_data);
		
		ak_dataset := dataset ([],layouts.id);
		
		nppes_key := NPPES.Key_NPPES_Payload;
		
		ds_recs := join(ds_fids,nppes_key,
										keyed(LEFT.id=right.fakeid),
										transform(Healthcare_Provider_Services.NPI_Layouts.batch_out_penalty, self := LEFT; self := right; self := []),
										keep(Constants.MAX_RECS_ON_JOIN));

		ds_rec_w_input := JOIN (ds_recs,batch_in(npinumber = ''),LEFT.acctno=right.acctno,transform(Healthcare_Provider_Services.NPI_Layouts.batch_out_penalty, self := right; self := LEFT;));
		
		ds_npi	:=	JOIN (batch_in(NPINumber <> ''), NPPES.Key_NPPES_npi, LEFT.NPINumber = right.npi,
														transform(Healthcare_Provider_Services.NPI_Layouts.batch_out_penalty, self := LEFT; self := right; self := []),
														limit(Healthcare_Provider_Services.Constants.MAX_RECS_ON_JOIN));
	
		s_ds_npi := dedup (sort (ds_npi,acctno,-process_date),acctno);
		
		rec_penalty := Healthcare_Provider_Services.Functions.apply_penalty_nppes_batch (ds_rec_w_input);
	
		Apply_Penaly_DS := rec_penalty (record_penalty < ak_config_data.PenaltThreshold);

		S_Apply_Penaly_DS := dedup(sort (Apply_Penaly_DS,acctno,-process_date,record_penalty),acctno);
		
		ds_result := S_Apply_Penaly_DS + s_ds_npi;
		
		Healthcare_Provider_Services.NPI_Layouts.batch_out createResult (Healthcare_Provider_Services.NPI_Layouts.batch_in l, 					Healthcare_Provider_Services.NPI_Layouts.batch_out_penalty r) := transform 
			self := L;
			self := R;
		end;
		
		Add_Nohit_Result := JOIN (batch_in,ds_result,LEFT.acctno=RIGHT.acctno,createResult(LEFT,RIGHT), LEFT outer);
		
		Healthcare_Provider_Services.NPI_Layouts.T_Batch_Out convertBatchOut (Healthcare_Provider_Services.NPI_Layouts.batch_out l) := transform
			self.t	:=	dataset ([{l.healthcare_provider_taxonomy_code_1,l.provider_license_number_1,l.provider_license_number_state_code_1,l.healthcare_provider_primary_taxonomy_switch_1,1},
													 {l.healthcare_provider_taxonomy_code_2,l.provider_license_number_2,l.provider_license_number_state_code_2,l.healthcare_provider_primary_taxonomy_switch_2,2},
													 {l.healthcare_provider_taxonomy_code_3,l.provider_license_number_3,l.provider_license_number_state_code_3,l.healthcare_provider_primary_taxonomy_switch_3,3},
													 {l.healthcare_provider_taxonomy_code_4,l.provider_license_number_4,l.provider_license_number_state_code_4,l.healthcare_provider_primary_taxonomy_switch_4,4},
													 {l.healthcare_provider_taxonomy_code_5,l.provider_license_number_5,l.provider_license_number_state_code_5,l.healthcare_provider_primary_taxonomy_switch_5,5},
													 {l.healthcare_provider_taxonomy_code_6,l.provider_license_number_6,l.provider_license_number_state_code_6,l.healthcare_provider_primary_taxonomy_switch_6,6},
													 {l.healthcare_provider_taxonomy_code_7,l.provider_license_number_7,l.provider_license_number_state_code_7,l.healthcare_provider_primary_taxonomy_switch_7,7},
													 {l.healthcare_provider_taxonomy_code_8,l.provider_license_number_8,l.provider_license_number_state_code_8,l.healthcare_provider_primary_taxonomy_switch_8,8},
													 {l.healthcare_provider_taxonomy_code_9,l.provider_license_number_9,l.provider_license_number_state_code_9,l.healthcare_provider_primary_taxonomy_switch_9,9},
													 {l.healthcare_provider_taxonomy_code_10,l.provider_license_number_10,l.provider_license_number_state_code_10,l.healthcare_provider_primary_taxonomy_switch_10,10},
													 {l.healthcare_provider_taxonomy_code_11,l.provider_license_number_11,l.provider_license_number_state_code_11,l.healthcare_provider_primary_taxonomy_switch_11,11},
													 {l.healthcare_provider_taxonomy_code_12,l.provider_license_number_12,l.provider_license_number_state_code_12,l.healthcare_provider_primary_taxonomy_switch_12,12},
													 {l.healthcare_provider_taxonomy_code_13,l.provider_license_number_13,l.provider_license_number_state_code_13,l.healthcare_provider_primary_taxonomy_switch_13,13},
													 {l.healthcare_provider_taxonomy_code_14,l.provider_license_number_14,l.provider_license_number_state_code_14,l.healthcare_provider_primary_taxonomy_switch_14,14},
													 {l.healthcare_provider_taxonomy_code_15,l.provider_license_number_15,l.provider_license_number_state_code_15,l.healthcare_provider_primary_taxonomy_switch_15,15}],													 
														Healthcare_Provider_Services.NPI_Layouts.taxnomy);
			self.p	:=	dataset ([{l.other_provider_identifier_1,l.other_provider_identifier_type_code_1,l.other_provider_identifier_state_1,l.other_provider_identifier_issuer_1},
														{l.other_provider_identifier_2,l.other_provider_identifier_type_code_2,l.other_provider_identifier_state_2,l.other_provider_identifier_issuer_2},
														{l.other_provider_identifier_3,l.other_provider_identifier_type_code_3,l.other_provider_identifier_state_3,l.other_provider_identifier_issuer_3}
														],Healthcare_Provider_Services.NPI_Layouts.otherp);
			self.pid	:=	dataset ([{l.other_pid_issuer_desc_1},{l.other_pid_issuer_desc_2},{l.other_pid_issuer_desc_3}
														],Healthcare_Provider_Services.NPI_Layouts.pid_desc);
			ta				:=	dataset ([{l.taxonomy_desc1,l.healthcare_provider_primary_taxonomy_switch_1,l.healthcare_provider_taxonomy_code_1},{l.taxonomy_desc2,l.healthcare_provider_primary_taxonomy_switch_2,l.healthcare_provider_taxonomy_code_2},{l.taxonomy_desc3,l.healthcare_provider_primary_taxonomy_switch_3,l.healthcare_provider_taxonomy_code_3},{l.taxonomy_desc4,l.healthcare_provider_primary_taxonomy_switch_4,l.healthcare_provider_taxonomy_code_4},{l.taxonomy_desc5,l.healthcare_provider_primary_taxonomy_switch_5,l.healthcare_provider_taxonomy_code_5},
															{l.taxonomy_desc6,l.healthcare_provider_primary_taxonomy_switch_6,l.healthcare_provider_taxonomy_code_6},{l.taxonomy_desc7,l.healthcare_provider_primary_taxonomy_switch_7,l.healthcare_provider_taxonomy_code_7},{l.taxonomy_desc8,l.healthcare_provider_primary_taxonomy_switch_8,l.healthcare_provider_taxonomy_code_8},{l.taxonomy_desc9,l.healthcare_provider_primary_taxonomy_switch_9,l.healthcare_provider_taxonomy_code_9},{l.taxonomy_desc10,l.healthcare_provider_primary_taxonomy_switch_10,l.healthcare_provider_taxonomy_code_10},
															{l.taxonomy_desc11,l.healthcare_provider_primary_taxonomy_switch_11,l.healthcare_provider_taxonomy_code_11},{l.taxonomy_desc12,l.healthcare_provider_primary_taxonomy_switch_12,l.healthcare_provider_taxonomy_code_12},{l.taxonomy_desc13,l.healthcare_provider_primary_taxonomy_switch_13,l.healthcare_provider_taxonomy_code_13},{l.taxonomy_desc14,l.healthcare_provider_primary_taxonomy_switch_14,l.healthcare_provider_taxonomy_code_14},{l.taxonomy_desc15,l.healthcare_provider_primary_taxonomy_switch_15,l.healthcare_provider_taxonomy_code_15}
															],Healthcare_Provider_Services.NPI_Layouts.tax_desc);
		  ta_1 			:=	ta (healthcare_provider_primary_taxonomy_switch = 'Y');
			ta_o			:=	dedup(sort (ta (healthcare_provider_primary_taxonomy_switch <> 'Y' and taxonomy_desc <> '' and healthcare_provider_taxonomy_code <> ''),healthcare_provider_taxonomy_code,taxonomy_desc),healthcare_provider_taxonomy_code,taxonomy_desc);
			self.ta		:=	ta_1 + ta_o;
			self := l;
			self := [];
		end;
		
		result_ds := PROJECT (Add_Nohit_Result,convertBatchOut (LEFT));
		
		verifyTaxonomy(String inputStr, Healthcare_Provider_Services.NPI_Layouts.NPI_Batch_Out recs) := FUNCTION
			inputStrExists := inputStr<> '';
			inputStrMatched := inputStr = recs.taxonomy_code_1 or inputStr = recs.taxonomy_code_2 or 
									 inputStr = recs.taxonomy_code_3 or inputStr = recs.taxonomy_code_4 or 
									 inputStr = recs.taxonomy_code_5 or inputStr = recs.taxonomy_code_6 or 
									 inputStr = recs.taxonomy_code_7 or inputStr = recs.taxonomy_code_8 or 
									 inputStr = recs.taxonomy_code_9 or inputStr = recs.taxonomy_code_10 or 
									 inputStr = recs.taxonomy_code_11 or inputStr = recs.taxonomy_code_12 or 
									 inputStr = recs.taxonomy_code_13 or inputStr = recs.taxonomy_code_14 or 
									 inputStr = recs.taxonomy_code_15;
			RETURN inputStrExists and inputStrMatched;
		END;
		
		Healthcare_Provider_Services.NPI_Layouts.NPI_Batch_Out getCurrent (Healthcare_Provider_Services.NPI_Layouts.T_Batch_Out L) := TRANSFORM
			SELF.provider_license_number_1 						:= 	L.T(healthcare_provider_primary_taxonomy_switch = 'Y') [1].provider_license_number;
			SELF.provider_license_number_state_code_1	:=	L.T(healthcare_provider_primary_taxonomy_switch = 'Y') [1].provider_license_number_state_code;
			SELF.primary_taxonomy_code								:=	L.T(healthcare_provider_primary_taxonomy_switch = 'Y') [1].healthcare_provider_taxonomy_code;
			integer f_cnt															:=	L.T(healthcare_provider_primary_taxonomy_switch = 'Y') [1].cnt;															
			
			SELF.provider_license_number_2 						:=	L.T(healthcare_provider_primary_taxonomy_switch = 'N') [1].provider_license_number;
			SELF.provider_license_number_state_code_2	:=	L.T(healthcare_provider_primary_taxonomy_switch = 'N') [1].provider_license_number_state_code;
			integer s_cnt															:=	L.T(healthcare_provider_primary_taxonomy_switch = 'Y') [1].cnt;															

			SELF.provider_license_number_3 						:= 	L.T(healthcare_provider_primary_taxonomy_switch = 'N') [2].provider_license_number;
			SELF.provider_license_number_state_code_3	:=	L.T(healthcare_provider_primary_taxonomy_switch = 'N') [2].provider_license_number_state_code;
			integer t_cnt															:=	L.T(healthcare_provider_primary_taxonomy_switch = 'Y') [2].cnt;															

			SELF.other_provider_identifier_state_1		:=	L.P [1].other_provider_identifier_state;
			SELF.other_provider_identifier_1					:=	L.P [1].other_provider_identifier;	

			SELF.other_provider_identifier_state_2		:=	L.P [2].other_provider_identifier_state;
			SELF.other_provider_identifier_2					:=	L.P [2].other_provider_identifier;	

			SELF.other_provider_identifier_state_3		:=	L.P [3].other_provider_identifier_state;
			SELF.other_provider_identifier_3					:=	L.P [3].other_provider_identifier;	
			
			primary_description												:=	L.ta (healthcare_provider_primary_taxonomy_switch = 'Y')[1].taxonomy_desc;
			SELF.primary_taxonomy_description					:=	primary_description;
			SELF.taxonomy_desc2												:=	L.ta (healthcare_provider_primary_taxonomy_switch <> 'Y') [1].taxonomy_desc;
			SELF.taxonomy_desc3												:=	L.ta (healthcare_provider_primary_taxonomy_switch <> 'Y') [2].taxonomy_desc;

			SELF.healthcare_provider_taxonomy_code_2	:=	L.ta(healthcare_provider_primary_taxonomy_switch <> 'Y') [1].healthcare_provider_taxonomy_code;
			SELF.healthcare_provider_taxonomy_code_3	:=	L.ta(healthcare_provider_primary_taxonomy_switch <> 'Y') [2].healthcare_provider_taxonomy_code;
			
			SELF.other_pid_issuer_desc_1							:=	L.pid [1].other_pid_issuer_desc;
			SELF.other_pid_issuer_desc_2							:=	L.pid [2].other_pid_issuer_desc;
			SELF.other_pid_issuer_desc_3							:=	L.pid [3].other_pid_issuer_desc;
			//Add output of all Taxonomy codes
			self.TaxonomyVerified := false;
			self.Taxonomy1Verified := false;
			self.Taxonomy2Verified := false;
			self.Taxonomy3Verified := false;
			self.Taxonomy4Verified := false;
			self.Taxonomy5Verified := false;
			self.taxonomy_code_1 := l.ta[1].healthcare_provider_taxonomy_code;
			self.taxonomy_desc_1 := l.ta[1].taxonomy_desc;
			self.taxonomy_code_2 := l.ta[2].healthcare_provider_taxonomy_code;
			self.taxonomy_desc_2 := l.ta[2].taxonomy_desc;
			self.taxonomy_code_3 := l.ta[3].healthcare_provider_taxonomy_code;
			self.taxonomy_desc_3 := l.ta[3].taxonomy_desc;
			self.taxonomy_code_4 := l.ta[4].healthcare_provider_taxonomy_code;
			self.taxonomy_desc_4 := l.ta[4].taxonomy_desc;
			self.taxonomy_code_5 := l.ta[5].healthcare_provider_taxonomy_code;
			self.taxonomy_desc_5 := l.ta[5].taxonomy_desc;
			self.taxonomy_code_6 := l.ta[6].healthcare_provider_taxonomy_code;
			self.taxonomy_desc_6 := l.ta[6].taxonomy_desc;
			self.taxonomy_code_7 := l.ta[7].healthcare_provider_taxonomy_code;
			self.taxonomy_desc_7 := l.ta[7].taxonomy_desc;
			self.taxonomy_code_8 := l.ta[8].healthcare_provider_taxonomy_code;
			self.taxonomy_desc_8 := l.ta[8].taxonomy_desc;
			self.taxonomy_code_9 := l.ta[9].healthcare_provider_taxonomy_code;
			self.taxonomy_desc_9 := l.ta[9].taxonomy_desc;
			self.taxonomy_code_10 := l.ta[10].healthcare_provider_taxonomy_code;
			self.taxonomy_desc_10 := l.ta[10].taxonomy_desc;
			self.taxonomy_code_11 := l.ta[11].healthcare_provider_taxonomy_code;
			self.taxonomy_desc_11 := l.ta[11].taxonomy_desc;
			self.taxonomy_code_12 := l.ta[12].healthcare_provider_taxonomy_code;
			self.taxonomy_desc_12 := l.ta[12].taxonomy_desc;
			self.taxonomy_code_13 := l.ta[13].healthcare_provider_taxonomy_code;
			self.taxonomy_desc_13 := l.ta[13].taxonomy_desc;
			self.taxonomy_code_14 := l.ta[14].healthcare_provider_taxonomy_code;
			self.taxonomy_desc_14 := l.ta[14].taxonomy_desc;
			self.taxonomy_code_15 := l.ta[15].healthcare_provider_taxonomy_code;
			self.taxonomy_desc_15 := l.ta[15].taxonomy_desc;
			SELF := L;
			SELF := [];
		END;
		
		GetDesc := PROJECT (result_ds,getCurrent (left));
		
		Final_Result := SORT (GetDesc,ACCTNO);

		Final_Result_with_Flags := join (batch_in,Final_Result,left.acctno=right.acctno,
																transform(Healthcare_Provider_Services.NPI_Layouts.NPI_Batch_Out,
																					taxonomyVerified1 := verifyTaxonomy(left.Taxonomy1,right);
																					taxonomyVerified2 := verifyTaxonomy(left.Taxonomy2,right);
																					taxonomyVerified3 := verifyTaxonomy(left.Taxonomy3,right);
																					taxonomyVerified4 := verifyTaxonomy(left.Taxonomy4,right);
																					taxonomyVerified5 := verifyTaxonomy(left.Taxonomy5,right);
																					self.TaxonomyVerified := taxonomyVerified1 or taxonomyVerified2 or taxonomyVerified3 or taxonomyVerified4 or taxonomyVerified5;
																					self.Taxonomy1Verified := taxonomyVerified1;
																					self.Taxonomy2Verified := taxonomyVerified2;
																					self.Taxonomy3Verified := taxonomyVerified3;
																					self.Taxonomy4Verified := taxonomyVerified4;
																					self.Taxonomy5Verified := taxonomyVerified5;
																					self := right;));
/*
*/		
		// output (ds_fids,named('ds_fids'));
		// output (ds_recs,named('ds_recs'));
		// output (ds_rec_w_input,named('ds_rec_w_input'));
		// output (ds_npi,named('ds_npi'));
		// output (rec_penalty,named('rec_penalty'));
		// output (Apply_Penaly_DS,named('Apply_Penaly_DS'));
		// output (Add_Nohit_Result,named('Add_Nohit_Result'));
    
		RETURN Final_Result_with_Flags;
END;
