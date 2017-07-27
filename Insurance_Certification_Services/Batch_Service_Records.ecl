IMPORT Autokey_batch, AutoStandardI, BatchServices, AutokeyB2, Doxie, ut, Insurance_Certification, Workers_Compensation;

// Local layouts.
ic_rec_keybuild_plus_acctno := RECORD
	STRING2 key_source			:= 'ic';
	STRING20 acctno         := '0';
	STRING8  lookup_type    := 'autokey';
	UNSIGNED2 penalty_value :=  0;
	Insurance_Certification.Layouts_certification.KeyBuild;
	STRING205 dba_name 			:= '';
END;

wc_rec_keybuild_plus_acctno := RECORD
  STRING2 key_source			:= 'wc';
	STRING20 acctno         := '0';
	STRING8  lookup_type    := '';
	UNSIGNED2 penalty_value :=  0;
	Workers_Compensation.layouts.KeyBuild;
END;

batch_out_plus := RECORD
  STRING2 key_source;
	STRING8  lookup_type    := '';
	UNSIGNED2 penalty_value :=  0;
	Insurance_Certification_Services.layouts_batch.Batch_out;
END;

get_penalty_value(Insurance_Certification_Services.layouts_batch.Batch_in le, batch_out_plus ri) :=
	FUNCTION

		mod_input_address := MODULE(ut.mod_penalize.IGenericAddress)
			EXPORT prim_range  := le.prim_range;  
			EXPORT predir      := le.predir;      
			EXPORT prim_name   := le.prim_name;  
			EXPORT addr_suffix := le.addr_suffix;
			EXPORT postdir     := le.postdir;     
			EXPORT sec_range   := le.sec_range;   
			EXPORT p_city_name := le.p_city_name; 
			EXPORT st          := le.st;          
			EXPORT z5          := le.z5;          
		END;
		
		mod_matched_bus_address := MODULE(ut.mod_penalize.IGenericAddress)
			EXPORT prim_range  := ri.Business_addr_prim_range;  
			EXPORT predir      := ri.Business_addr_predir;      
			EXPORT prim_name   := ri.Business_addr_prim_name;  
			EXPORT addr_suffix := ri.Business_addr_addr_suffix;
			EXPORT postdir     := ri.Business_addr_postdir;     
			EXPORT sec_range   := ri.Business_addr_sec_range;   
			EXPORT p_city_name := ri.Business_addr_p_city_name; 
			EXPORT st          := ri.Business_addr_st;          
			EXPORT z5          := ri.Business_addr_zip;          
		END;

		mod_input_name := MODULE(ut.mod_penalize.IGenericPersonName)
			EXPORT STRING name_last   := le.name_last;
			EXPORT STRING name_first  := le.name_first;
			EXPORT STRING name_middle := le.name_middle;
		END;
		
		mod_matched_own_name := MODULE(ut.mod_penalize.IGenericPersonName)
			EXPORT STRING name_last   := ri.Business_Owner_Last_Name;
			EXPORT STRING name_first  := ri.Business_Owner_First_Name;
			EXPORT STRING name_middle := ri.Business_Owner_Middle_Name;
		END;
	
		penalized_companyname := ut.mod_penalize.company_name(le.comp_name, ri.Business_Name);
		penalized_address := ut.mod_penalize.address(mod_input_address, mod_matched_bus_address);
		penalized_personname := ut.mod_penalize.person_name(mod_input_name, mod_matched_own_name);
		
		RETURN penalized_companyname + penalized_address + penalized_personname;
	END;

EXPORT Batch_Service_records( DATASET(Insurance_Certification_Services.layouts_batch.Batch_in) ds_batch_in_parm = DATASET([], Insurance_Certification_Services.layouts_batch.Batch_in) ) :=
		FUNCTION
		
		UNSIGNED8 MaxResultsPerAcct := 1000 : STORED('max_results_per_acct');
		
		Insurance_Certification_Services.layouts_batch.Batch_in capitalize_input(Insurance_Certification_Services.layouts_batch.Batch_in l) := TRANSFORM
			SELF.name_first  := StringLib.StringToUpperCase(l.name_first);
			SELF.name_middle := StringLib.StringToUpperCase(l.name_middle);
			SELF.name_last   := StringLib.StringToUpperCase(l.name_last);
			SELF.name_suffix := StringLib.StringToUpperCase(l.name_suffix);
			SELF.prim_range  := StringLib.StringToUpperCase(l.prim_range);	
			SELF.predir      := StringLib.StringToUpperCase(l.predir);	
			SELF.prim_name   := StringLib.StringToUpperCase(l.prim_name);	
			SELF.addr_suffix := StringLib.StringToUpperCase(l.addr_suffix);	
			SELF.postdir     := StringLib.StringToUpperCase(l.postdir);	
			SELF.unit_desig  := StringLib.StringToUpperCase(l.unit_desig);	
			SELF.sec_range   := StringLib.StringToUpperCase(l.sec_range);	
			SELF.p_city_name := StringLib.StringToUpperCase(l.p_city_name);	
			SELF.st          := StringLib.StringToUpperCase(l.st);	
			SELF.comp_name   := StringLib.StringToUpperCase(l.comp_name);
			SELF             := l;
		END;

		// 1. Do project with  transform to convert any lower case input to upper case.
		// ds_batch_in := project(ds_batch_in_parm,BatchServices.transforms.xfm_capitalize_input(LEFT));
    ds_batch_in := PROJECT(ds_batch_in_parm,capitalize_input(LEFT));
			
		// 2. Define values for obtaining autokeys and payloads.	
		// constants  := constants();
		SHARED ic_ak_keyname := Insurance_Certification.constants().ak_qa_keyname;
		SHARED ic_ak_dataset := Insurance_Certification.constants().ak_dataset;
		SHARED ic_ak_typeStr := Insurance_Certification.constants().ak_typeStr;
		SHARED wc_ak_keyname := Workers_Compensation.constants().ak_qa_keyname;
		SHARED wc_ak_dataset := Workers_Compensation.constants().ak_dataset;
		SHARED wc_ak_typeStr := Workers_Compensation.constants().ak_typeStr;
				
		// 3a. Configure Insurance Cert autokey search.		
		ic_ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
			EXPORT workHard        := TRUE; 
			EXPORT useAllLookups   := TRUE; 
			EXPORT PenaltThreshold := 20;
			EXPORT skip_set        := Insurance_Certification.constants().ak_skipSet;
		END;
		
		// 3b. Configure Workers Comp autokey search.		
		wc_ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
			EXPORT workHard        := TRUE; 
			EXPORT useAllLookups   := TRUE; 
			EXPORT PenaltThreshold := 20;
			EXPORT skip_set        := Workers_Compensation.constants().ak_skipset;
		END;
		
		// 4a. Get autokey 'fake' ids (fids) based on batch input for Insurance Cert.
		SHARED ic_ds_fids := Autokey_batch.get_fids(PROJECT(ds_batch_in,Autokey_batch.Layouts.rec_inBatchMaster), ic_ak_keyname, ic_ak_config_data);
		
		// 4b. Get autokey 'fake' ids (fids) based on batch input for Workers Comp.
		SHARED wc_ds_fids := Autokey_batch.get_fids(PROJECT(ds_batch_in,Autokey_batch.Layouts.rec_inBatchMaster), wc_ak_keyname, wc_ak_config_data);
					
		// 5a. Get Insurance Cert autokey payloads 
		AutokeyB2.mac_get_payload( UNGROUP(ic_ds_fids), ic_ak_keyname, ic_ak_dataset, SHARED ic_by_Autokey, did, bdid, ic_ak_typeStr )
		
		// 5b. Get Workers Comp autokey payloads.
		AutokeyB2.mac_get_payload( UNGROUP(wc_ds_fids), wc_ak_keyname, wc_ak_dataset, SHARED wc_by_Autokey_temp, did, bdid, wc_ak_typeStr )
		wc_by_Autokey := PROJECT(wc_by_Autokey_temp,TRANSFORM(wc_rec_keybuild_plus_acctno,
																													SELF.lookup_type := 'autokey',
																													SELF 						 := LEFT));
																										
		// 6a. Search insurance cert by bdid
		ic_by_BDID := 
			JOIN(
				ds_batch_in(bdid != 0),
				Insurance_Certification.Key_BDID,
				KEYED(LEFT.bdid = RIGHT.bdid),
				TRANSFORM( ic_rec_keybuild_plus_acctno,
					SELF.acctno := LEFT.acctno,
					SELF.lookup_type := 'bdid',
					SELF        := RIGHT
				),
				INNER,
				limit(ut.limits.default, skip)
			);
			
		// 6b. Search workers comp by bdid
		wc_by_BDID := 
			JOIN(
				ds_batch_in(bdid != 0),
				Workers_Compensation.Key_BDID,
				KEYED(LEFT.bdid = RIGHT.bdid),
				TRANSFORM( wc_rec_keybuild_plus_acctno,
					SELF.acctno := LEFT.acctno,
					SELF.lookup_type := 'bdid',
					SELF        := RIGHT
				),
				INNER,
				limit(ut.limits.default, skip)
			);
	
		// 7. Search Insurance Cert by did, note workers Comp doesn't have did key file
		ic_by_DID := 
			JOIN(
				ds_batch_in(did != 0),
				Insurance_Certification.Key_DID,			
				KEYED(LEFT.did = RIGHT.did),
				TRANSFORM( ic_rec_keybuild_plus_acctno,
					SELF.acctno := LEFT.acctno,
					SELF.lookup_type := 'did',
					SELF        := RIGHT
				),
				INNER,
				limit(ut.limits.default, skip)
			);
			
	  // Combine and project the 3 result record sets to a slimed record which will be used to retrieve
		// All the information for a company/person, I.E. business name/owner and policy info. Note, 
		// 'C' contact records are omitted since at the time of developement they were not wanted in 
		// the output.
		ic_by_all := PROJECT(ic_by_Autokey(Norm_Type != 'C'),ic_rec_keybuild_plus_acctno) + 
								 PROJECT(ic_by_BDID(Norm_Type != 'C'),ic_rec_keybuild_plus_acctno) + 
								 PROJECT(ic_by_DID(Norm_Type != 'C'),ic_rec_keybuild_plus_acctno);
	  
		/* There are multiple records for each lninscertrecordid, business, dba and contact information.
       A join against the uniqueCert file will be done to pull all related records and then combined
			 them into one layout. */
		ic_by_unique := JOIN(ic_by_all,Insurance_Certification.Key_UniqueCert,
												 (KEYED(LEFT.LNInsCertRecordID = RIGHT.LNInsCertRecordID)) and
												 (LEFT.unique_id = RIGHT.unique_id) and
												 (RIGHT.Norm_type = 'B' or RIGHT.Norm_type = 'D') ,
												 TRANSFORM(ic_rec_keybuild_plus_acctno,
														SELF.acctno 		 				:= LEFT.acctno,
														SELF.lookup_type 				:= LEFT.lookup_type,
														SELF        		 				:= RIGHT));
												 
		// Sort and keep only one DBA and Bus record, there should only be one in the data but deduping to be safe.
		ic_by_unique_srt := DEDUP(SORT(ic_by_unique,acctno,LNInsCertRecordID,norm_type),acctno,LNInsCertRecordID,norm_type);
		
		// Combine Business (norm_type = B) and dba records (norm_type = D), sorted so "l" contains business record, "r" dba.
		ic_rec_keybuild_plus_acctno roll_bus_dba(recordof(ic_by_unique_srt) l, recordof(ic_by_unique_srt) r) := TRANSFORM
				SELF.dba_name := IF(r.norm_type = 'D',r.Norm_BusinessName,'');
				SELF := l;
		END;
		ic_by_bus_dba := ROLLUP(ic_by_unique_srt,LEFT.LNInsCertRecordID = RIGHT.LNInsCertRecordID,roll_bus_dba(LEFT,RIGHT));


		// For matches with bdids, sort and only keep the most recent one. For ones without bdids dedup on name and address.
		ic_by_all_dedup := DEDUP(SORT(ic_by_bus_dba(bdid != 0),acctno,bdid,-date_lastseen),acctno,bdid) +
		                   DEDUP(SORT(ic_by_bus_dba(bdid = 0),acctno,bdid,-date_lastseen),acctno,norm_businessname,norm_address1,norm_city,norm_state,ALL);
							
		// Transform to convert to batch output with policy info.
		batch_out_plus comb_bus_policy(recordof(ic_by_all_dedup) l, recordof(Insurance_Certification.Key_UniquePol) r) := TRANSFORM
				SELF.SelfInsurance 	:= 'TRUE';
				SELF.Business_Name := l.Norm_BusinessName;
				SELF.Business_DBA_Name := l.dba_name;
				SELF.Business_Owner_First_Name := l.Norm_FirstName;
				SELF.Business_Owner_Middle_Name := l.Norm_Middle;
				SELF.Business_Owner_Last_Name := l.Norm_Last;
				SELF.Business_Owner_Suffix_Name := l.Norm_Suffix;
				SELF.Business_addr_prim_range := l.m_prim_range;
				SELF.Business_addr_predir := l.m_predir;
				SELF.Business_addr_prim_name := l.m_prim_name;
				SELF.Business_addr_addr_suffix := l.m_addr_suffix;
				SELF.Business_addr_postdir := l.m_postdir;
				SELF.Business_addr_unit_desig := l.m_unit_desig;
				SELF.Business_addr_sec_range := l.m_sec_range;
				SELF.Business_addr_p_city_name := l.m_p_city_name;
				SELF.Business_addr_v_city_name := l.m_v_city_name;
				SELF.Business_addr_st := l.m_st;
				SELF.Business_addr_zip := l.m_zip;
					
				// Assign Policy Info
				SELF.Policy_DartID := r.DartID;
				SELF.Policy_InsuranceProvider := r.InsuranceProvider;
				SELF.Policy_PolicyNumber := r.PolicyNumber;
				SELF.Policy_CoverageStartDate := r.CoverageStartDate;
				SELF.Policy_CoverageExpirationDate := r.CoverageExpirationDate;
				SELF.Policy_CoverageWrapUP := r.CoverageWrapUP;
				SELF.Policy_PolicyStatus := r.PolicyStatus;
				SELF.Policy_InsuranceProviderPhone := r.InsuranceProviderPhone;
				SELF.Policy_InsuranceProviderFax := r.InsuranceProviderFax;
				SELF.Policy_CoverageReinstateDate := r.CoverageReinstateDate;
				SELF.Policy_CoverageCancellationDate := r.CoverageCancellationDate;
				SELF.Policy_InsuranceProviderContactDept := r.InsuranceProviderContactDept;
				SELF.Policy_InsuranceType := r.InsuranceType;
				SELF.Policy_CoveragePostedDate := r.CoveragePostedDate;
				SELF.Policy_CoverageAmountFrom := r.CoverageAmountFrom;
				SELF.Policy_CoverageAmountTo := r.CoverageAmountTo;
				SELF.Policy_addr_prim_range := r.m_prim_range;
				SELF.Policy_addr_predir := r.m_predir;
				SELF.Policy_addr_prim_name :=	r.m_prim_name;
				SELF.Policy_addr_addr_suffix := r.m_addr_suffix;
				SELF.Policy_addr_postdir :=	r.m_postdir;
				SELF.Policy_addr_unit_desig := r.m_unit_desig;
				SELF.Policy_addr_sec_range :=	r.m_sec_range;
				SELF.Policy_addr_p_city_name :=	r.m_p_city_name;
				SELF.Policy_addr_v_city_name := r.m_v_city_name;
				SELF.Policy_addr_st := r.m_st;
				SELF.Policy_addr_zip :=	r.m_zip;
				SELF := l;
				SELF := [];
		END;
		
		// Get the policy info and tranform results into batch output layout
		ic_bus_policy := JOIN(ic_by_all_dedup,Insurance_Certification.Key_UniquePol,
													KEYED(LEFT.LNInsCertRecordID = RIGHT.LNInsCertRecordID),
													comb_bus_policy(LEFT,RIGHT)
													,LEFT OUTER);
		
		// Keep only the most recent policy record, active policys contain "ACTIVE' and secondarily on policy start date. 
		ic_bus_policy_dedup := DEDUP(SORT(ic_bus_policy,acctno,bdid,IF(Policy_PolicyStatus != '', 0,1),Policy_PolicyStatus,-Policy_CoverageStartDate,RECORD),
																	acctno,bdid);
		
		batch_out_plus WorkComp_toBatchOut(wc_rec_keybuild_plus_acctno l) := TRANSFORM
				SELF.WorkersCompIns 	:= 									'TRUE';
				SELF.Business_Name :=											l.Description;
				SELF.Business_addr_prim_range :=					l.m_prim_range;	
				SELF.Business_addr_predir :=	      			l.m_predir;	
				SELF.Business_addr_prim_name :=     			l.m_prim_name;	
				SELF.Business_addr_addr_suffix :=   			l.m_addr_suffix;	
				SELF.Business_addr_postdir :=	      			l.m_postdir;
				SELF.Business_addr_unit_desig :=    			l.m_unit_desig;	
				SELF.Business_addr_sec_range :=     			l.m_sec_range;	
				SELF.Business_addr_p_city_name :=   			l.m_p_city_name;	
				SELF.Business_addr_v_city_name :=   			l.m_v_city_name;	
				SELF.Business_addr_st :=	          			l.m_st;		
				SELF.Business_addr_zip :=           			l.m_zip;
				SELF.Workers_Comp_classCode := 						l.classCode;
				SELF.Workers_Comp_Effective_Month_Day :=	l.Effective_Month_Day;
				SELF.Workers_Comp_EffectiveMonth :=				l.EffectiveMonth;
				SELF.Workers_Comp_Effective_Date :=				l.Effective_Date;
				SELF.Workers_Comp_NAICCarrierName :=			l.NAICCarrierName;
				SELF.Workers_Comp_NAICCarrierNumber :=		l.NAICCarrierNumber;
				SELF.Workers_Comp_NAICGroupName :=				l.NAICGroupName;
				SELF.Workers_Comp_NAICGroupNumber :=			l.NAICGroupNumber;
				SELF.Workers_Comp_FEIN :=									l.FEIN;
				SELF.Workers_Comp_PolicySelf :=						l.PolicySelf;
				SELF.Workers_Comp_insured_status :=				l.insured_status;
				SELF := l;
				SELF := [];
		END;

    // Project and union the workers comp record sets to the common layout.		
		wc_by_all := PROJECT(wc_by_Autokey+wc_by_BDID,WorkComp_toBatchOut(LEFT));
	  
		// For matches with bdids, sort and only keep the most recent one. For records without bdids,
		// dedup on business name and address.
		wc_by_all_dedup := DEDUP(SORT(wc_by_all(bdid != 0),acctno,bdid,-date_lastseen),acctno,bdid) +
											 DEDUP(SORT(wc_by_all(bdid = 0),acctno,-date_lastseen),
															acctno,business_name,Business_addr_prim_range,Business_addr_p_city_name,Business_addr_st,Business_addr_st,Business_addr_st,ALL);
		
		// Combine ic and wc records and dedup.
		by_all_dedup := DEDUP(SORT(wc_by_all_dedup+ic_bus_policy_dedup,acctno,bdid,key_source,-date_lastseen),
										ALL,EXCEPT key_source, lookup_type, date_lastseen, date_firstseen);
		
		
		/* There should only be one ic and one wc record per bdid per acct. In cases where both
				records exist the left will always be the ic rec (sorted that way). When both ic/wc records
				exist, the address/business name will come from the ic record. */
		batch_out_plus roll_ic_wc(batch_out_plus l, batch_out_plus r) := TRANSFORM
				SELF.Workers_Comp_classCode 					:= IF(r.key_source = 'wc',r.Workers_Comp_classCode,l.Workers_Comp_classCode);
				SELF.Workers_Comp_Effective_Month_Day := IF(r.key_source = 'wc',r.Workers_Comp_Effective_Month_Day,l.Workers_Comp_Effective_Month_Day);
				SELF.Workers_Comp_EffectiveMonth 		 	:= IF(r.key_source = 'wc',r.Workers_Comp_EffectiveMonth,l.Workers_Comp_EffectiveMonth);
				SELF.Workers_Comp_Effective_Date			:= IF(r.key_source = 'wc',r.Workers_Comp_Effective_Date,l.Workers_Comp_Effective_Date);
				SELF.Workers_Comp_NAICCarrierName 		:= IF(r.key_source = 'wc',r.Workers_Comp_NAICCarrierName,l.Workers_Comp_NAICCarrierName);
				SELF.Workers_Comp_NAICCarrierNumber 	:= IF(r.key_source = 'wc',r.Workers_Comp_NAICCarrierNumber,l.Workers_Comp_NAICCarrierNumber);
				SELF.Workers_Comp_NAICGroupName 			:= IF(r.key_source = 'wc',r.Workers_Comp_NAICGroupName,l.Workers_Comp_NAICGroupName);
				SELF.Workers_Comp_NAICGroupNumber 		:= IF(r.key_source = 'wc',r.Workers_Comp_NAICGroupNumber,l.Workers_Comp_NAICGroupNumber);
				SELF.Workers_Comp_FEIN 							 	:= IF(r.key_source = 'wc',r.Workers_Comp_FEIN,l.Workers_Comp_FEIN);
				SELF.Workers_Comp_PolicySelf 				 	:= IF(r.key_source = 'wc',r.Workers_Comp_PolicySelf,l.Workers_Comp_PolicySelf);
				SELF.WorkersCompIns	 				 					:= IF(r.key_source = 'wc',r.WorkersCompIns,l.WorkersCompIns);	
				SELF := l;
		END;
		
		// Combine insurance cert (ic) and workers comp(wc) data into one matching on bdid	
		by_all_comb := ROLLUP(by_all_dedup(bdid != 0),LEFT.bdid = RIGHT.bdid,roll_ic_wc(LEFT,RIGHT)) + by_all_dedup(bdid = 0);
	
		by_all_penalized := 
			 JOIN(
				ds_batch_in,
				by_all_comb,
				LEFT.acctno = RIGHT.acctno,
				TRANSFORM(batch_out_plus,
					 SELF.penalty_value := get_penalty_value(LEFT,RIGHT),
					 SELF               := RIGHT
				),
				RIGHT OUTER
		);
				
		by_all_sorted := DEDUP(SORT(by_all_penalized(penalty_value <= ic_ak_config_data.PenaltThreshold), acctno, penalty_value, -DateUpdated, -DateAdded),acctno,KEEP MaxResultsPerAcct);
		
		results := PROJECT( by_all_sorted, Insurance_Certification_Services.layouts_batch.Batch_out);
		
		RETURN(results);
END;
