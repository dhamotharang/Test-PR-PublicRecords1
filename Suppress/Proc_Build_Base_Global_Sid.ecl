IMPORT PromoteSupers;
// This attribute builds 2 base files -
//  - one to track history of exemption records extracted from Oribt
//  - the other tracks the global_sid set created from exemption records extracted from Orbit.
EXPORT Proc_Build_Base_Global_Sid(STRING pVersion) := FUNCTION

	// New input files 
    ds_exemptions_pr			:= $.Files.Exemptions.Input_PR;
	ds_exemptions_ins		    := $.Files.Exemptions.Input_Ins;
	ds_exemptions_hc			:= $.Files.Exemptions.Input_HC;

	//assign domain id  and *** patch professional data flag ***
	ds_exemptions_pr_domain_id	:= PROJECT(ds_exemptions_pr,
	                                       TRANSFORM($.Layout_Exemptions_Base,SELF.domain_id:=$.Constants.Exemptions().Domain_Id_PR,SELF:=LEFT,SELF:=[]));
	ds_exemptions_ins_domain_id	:= PROJECT(ds_exemptions_ins,
	                                       TRANSFORM($.Layout_Exemptions_Base,SELF.domain_id:=$.Constants.Exemptions().Domain_Id_Ins,SELF:=LEFT,SELF:=[]));
	ds_exemptions_hc_domain_id	:= PROJECT(ds_exemptions_hc,
	                                       TRANSFORM($.Layout_Exemptions_Base,SELF.domain_id:=$.Constants.Exemptions().Domain_Id_HC,SELF:=LEFT,SELF:=[]));
	ds_exemptions_all			:= ds_exemptions_pr_domain_id + ds_exemptions_ins_domain_id + ds_exemptions_hc_domain_id;

	$.Layout_Exemptions_Base tx_exemptions_pre($.Layout_Exemptions_Base L) := TRANSFORM
		SELF.dt_vendor_first_reported 	:= (UNSIGNED4) pVersion[1..8];
		SELF.dt_vendor_last_reported 	:= (UNSIGNED4) pVersion[1..8];
		SELF.process_date				:= (UNSIGNED4) thorlib.WUID()[2..9];
		// SELF.professional_flag			:= IF(L.professional_flag='','N',L.professional_flag);
		// SELF.professional_flag			:= IF(REGEXFIND('CAT9',L.category),'Y','N');
		SELF.professional_flag			:= IF(REGEXFIND('PROFF',L.opt_out_category),'Y','N');   // See Jira ORBITV3-4252
		SELF 							:= L;
	END;

	//Exlcude records with 0 global_sid which can come from empty input lines
	ds_exemptions_new			:= PROJECT(ds_exemptions_all(global_sid<>0),tx_exemptions_pre(LEFT));

	//Existing exemption base file
	dCurrBase_exemptions		:= $.Files.Exemptions.Basefile;
		
	// Use SALT generated Ingest function to create new base file
	// These fields together uniquely identify a record - lexid, state_act 
	dNewBase_Exemptions_0		:= Ingest_Exemptions(FALSE,,dCurrBase_exemptions,ds_exemptions_new).AllRecords;
	doStats_Exemptions			:= Ingest_Exemptions(FALSE,,dCurrBase_exemptions,ds_exemptions_new).DoStats;
	vStats_Exemptions			:= Ingest_Exemptions(FALSE,,dCurrBase_exemptions,ds_exemptions_new).ValidityStats;
	stdStats_Exemptions			:= OUTPUT(Ingest_Exemptions(FALSE,,dCurrBase_exemptions,ds_exemptions_new).StandardStats(), ALL, NAMED('StandardStats'));

	Suppress.Layout_Exemptions_Base  tx_exemptions_post(dNewBase_Exemptions_0 L) := TRANSFORM
		SELF.history_flag				:= IF(L.__Tpe=Ingest_Exemptions().RecordType.Old,'H','');
		SELF							:= L;
	END;
	
	dNewBase_Exemptions			:= PROJECT(dNewBase_Exemptions_0, tx_exemptions_post(LEFT));

	//Create exemption base file	
	PromoteSupers.Mac_SF_BuildProcess(dNewBase_Exemptions,$.Filenames().Exemptions.base,build_base_exemptions,,,true);
		
	//Populate Global_Sid set for PR, HC, and Insurance
	vendor_date					:= (UNSIGNED4) pVersion;
	p_date						:= (UNSIGNED4) thorlib.WUID()[2..9];
	// Indication of “Contains Professional Information and not consumer only information will be available at 
	// the Privacy Item Entity and the Privacy Act Entity
	globalsid_pr_npd			:= suppress.fExtractGlobalSids(suppress.Constants.Exemptions().Domain_Id_PR,'N');
	globalsid_pr_pd				:= suppress.fExtractGlobalSids(suppress.Constants.Exemptions().Domain_Id_PR,'Y');
    globalsid_hc				:= suppress.fExtractGlobalSids(suppress.Constants.Exemptions().Domain_Id_HC);
    globalsid_ins				:= suppress.fExtractGlobalSids(suppress.Constants.Exemptions().Domain_Id_INS);
	ds_global_sid_new			:= DATASET(
									//For now insurance will use PR key and we will use hardcoded global_sid seg
									[{vendor_date,vendor_date,p_date,'',Suppress.Constants.Exemptions().Domain_Id_PR,'N',globalsid_pr_npd+globalsid_ins,0},
									 {vendor_date,vendor_date,p_date,'',Suppress.Constants.Exemptions().Domain_Id_PR,'Y',globalsid_pr_pd+globalsid_ins,0},
									// [{vendor_date,vendor_date,p_date,'',Suppress.Constants.Exemptions().Domain_Id_PR,'N',Suppress.Constants.OptOut().CACCPA_Global_Sid,0},
									//  {vendor_date,vendor_date,p_date,'',Suppress.Constants.Exemptions().Domain_Id_PR,'Y',Suppress.Constants.OptOut().CACCPA_Global_Sid,0},
									 {vendor_date,vendor_date,p_date,'',Suppress.Constants.Exemptions().Domain_Id_HC,'Y',globalsid_hc,0},
									 {vendor_date,vendor_date,p_date,'',Suppress.Constants.Exemptions().Domain_Id_INS,'N',globalsid_ins,0}],
									Suppress.Layout_Global_Sid_Base);	

	//Existing exemption base file
	dCurrBase_global_sid		:= $.Files.Global_Sid.Basefile;
		
	// Use SALT generated Ingest function to create new base file
	// These fields together uniquely identify a record - lexid, state_act 
	dNewBase_Global_Sid_0		:= $.Ingest_Global_Sid(FALSE,,dCurrBase_global_sid,ds_global_sid_new).AllRecords;
	doStats_Global_Sid			:= $.Ingest_Global_Sid(FALSE,,dCurrBase_global_sid,ds_global_sid_new).DoStats;
	vStats_Global_Sid			:= $.Ingest_Global_Sid(FALSE,,dCurrBase_global_sid,ds_global_sid_new).ValidityStats;
	stdStats_Global_Sid			:= OUTPUT($.Ingest_Global_Sid(FALSE,,dCurrBase_global_sid,ds_global_sid_new).StandardStats(), ALL, NAMED('StandardStats_Global_Sid'));

	Suppress.Layout_Global_Sid_Base  tx_global_sid_post(dNewBase_Global_Sid_0 L) := TRANSFORM
		SELF.history_flag				:= IF(L.__Tpe=Ingest_Global_Sid().RecordType.Old,'H','');
		SELF							:= L;
	END;
	
	dNewBase_Global_Sid			:= PROJECT(dNewBase_Global_Sid_0, tx_global_sid_post(LEFT));

	//Create exemption base file	
	PromoteSupers.Mac_SF_BuildProcess(dNewBase_Global_Sid,$.Filenames().Global_Sid.base,build_base_global_sid,,,true);

	RETURN SEQUENTIAL(
					// Build Exemptions base file
					build_base_exemptions;
					doStats_Exemptions;
					vStats_Exemptions;
					stdStats_Exemptions;
					//Build Global SID set base file
					build_base_global_sid;
					doStats_Global_Sid;
					vStats_Global_Sid;
					stdStats_Global_Sid;
					);
END;					