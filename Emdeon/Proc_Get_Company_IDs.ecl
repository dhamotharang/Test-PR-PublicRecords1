IMPORT lib_fileservices, _control, lib_STRINGlib, _Validate, did_add, ut, business_header_ss, business_header,
Health_Facility_Services, HealthCareFacility, BIPV2_Company_Names, Emdeon ;

// #STORED('did_add_force','thor'); // remove or set to 'roxi' to put recs through roxi

TrimUpper(STRING s) := FUNCTION
			RETURN TRIM(Stringlib.StringToUppercase(s),LEFT,RIGHT);
			END;  
	
EXPORT Proc_Get_Company_IDs 	:= MODULE

	EXPORT C_records(DATASET(Emdeon.Layouts.Base.C_record)	pBaseFile) := FUNCTION

		expand_C_rec_layout	:= record
			UNSIGNED8			unique_id :=0;
			UNSIGNED4			company_type :=0;
			Emdeon.Layouts.base.c_record;
			STRING35			clean_company_name	:= '';
			STRING10			clean_prim_range	:= '';
			STRING2 			clean_predir	:= '';
			STRING28 			clean_prim_name	:= '';
			STRING4 			clean_addr_suffix	:= '';
			STRING2 			clean_postdir	:= '';
			STRING10 			clean_unit_desig	:= '';
			STRING8 			clean_sec_range	:= '';
			STRING25 			clean_p_city_name	:= '';
			STRING2 			clean_st	:= '';
			STRING5 			clean_zip	:= '';
			UNSIGNED6			bdid	:= 0;
			UNSIGNED1			bdid_score	:= 0;
			STRING10			npi	:= '';
			UNSIGNED8	 		lnpid	:= 0;		
			UNSIGNED1			zero	:= 0;
		END;
		
		//PROJECT out to temporary layout to capture IDs when records are normalized - will be denormalized, too
		temp_base_recs := PROJECT(pBaseFile,expand_C_rec_layout);		
		
		//assign a unique_id for NORMALIZE/DENORMALIZE
		ut.MAC_Sequence_Records(temp_base_recs,unique_id,temp_base_seq);

		expand_C_rec_layout tNormalizeCompany(temp_base_seq L, UNSIGNED cnt) := TRANSFORM   
			SELF.unique_id						:= l.unique_id;
			SELF.company_type					:= cnt;
			SELF.clean_company_name		:= CHOOSE(cnt,L.clean_company_billing1,L.clean_company_referring1,
																					L.clean_company_attending1,L.clean_company_facility1);
			SELF.clean_prim_range			:= CHOOSE(cnt,L.clean_billing_prim_range,L.clean_billing_prim_range,
																					L.clean_billing_prim_range,L.clean_facility_prim_range);
			SELF.clean_prim_name			:= CHOOSE(cnt,L.clean_billing_prim_name,L.clean_billing_prim_name,
																					L.clean_billing_prim_name,L.clean_facility_prim_name);
			SELF.clean_zip						:= CHOOSE(cnt,L.clean_billing_zip,L.clean_billing_zip,
																					L.clean_billing_zip,L.clean_facility_zip);
			SELF.clean_sec_range			:= CHOOSE(cnt,L.clean_billing_sec_range,L.clean_billing_sec_range,
																					L.clean_billing_sec_range,L.clean_facility_sec_range);
			SELF.clean_st							:= CHOOSE(cnt,L.clean_billing_st,L.clean_billing_st,
																					L.clean_billing_st,L.clean_facility_st);
			SELF.npi									:= CHOOSE(cnt,L.billing_npi,L.referring_npi,L.attending_npi,'');
			SELF := L;
			SELF := [];
		END;
   
		//NORMALIZE the records to populate the bdid for all companies
		dBdidPrep	:= NORMALIZE(temp_base_seq,4,tNormalizeCompany(LEFT,counter));
   
		HasName	:=	TRIM(dBdidPrep.clean_company_name,LEFT,RIGHT)    != '' ;
										
		dWith_name				:= dBdidPrep(HasName);
		dWithout_name	    := dBdidPrep(not(HasName));
			
		//BDID
		matchset 	:= ['A'];
		Business_Header_SS.MAC_Add_BDID_FLEX(
			dWith_name
			,matchset
			,clean_company_name
			,clean_prim_range
			,clean_prim_name
			,clean_zip
			,clean_sec_range
			,clean_st
			,foo
			,foo
			,bdid
			,expand_c_rec_layout 
			,TRUE
			,bdid_score
			,dBdidAppended
			,
			,
			,
			,BIPV2.xlink_version_set
			,
			,
			,clean_p_city_name
			,
			,
			,
			,
			,src
			,
			,
			);
		
		//get lnpid
		Health_Facility_Services.mac_get_best_lnpid_on_thor(
			dBdidAppended
			,lnpid
			,clean_company_name
			,clean_prim_range
			,clean_prim_name
			,clean_sec_range
			,clean_p_city_name
			,clean_st
			,clean_zip
			,//Input_TAX_ID = ''
			,//Input_FEIN = ''
			,//Input_PHONE = ''
			,//Input_FAX = ''
			,//Input_LIC_STATE = ''
			,//Input_C_LIC_NBR = ''
			,//Input_DEA_NUMBER = ''
			,//Input_VENDOR_ID = ''
			,npi
			,//Input_CLIA_NUMBER = ''
			,//Input_MEDICARE_FACILITY_NUMBER = ''
			,//Input_MEDICAID_NUMBER = ''
			,//Input_NCPDP_NUMBER = ''
			,//Input_Taxonomy = ''
			,bdid
			,//Input_SRC = ''
			,//Input_SOURCE_RID = ''
			,result
			,FALSE
			,30); 
	   
		 all_together	:= DISTRIBUTE(result + dWithout_name, HASH(unique_id));
		 
	  //DENORMALIZE the records 
		temp_base_seq denormBdid(temp_base_seq l, all_together r) := TRANSFORM			
				SELF.billing1_bdid 						:= IF(r.company_type = 1 	,r.bdid,	l.billing1_bdid);
				SELF.referring1_bdid					:= IF(r.company_type = 2	,r.bdid, 	l.referring1_bdid);
				SELF.attending1_bdid					:= IF(r.company_type = 3	,r.bdid, 	l.attending1_bdid);
				SELF.facility1_bdid						:= IF(r.company_type = 4	,r.bdid, 	l.facility1_bdid);
				SELF.billing1_bdid_score 			:= IF(r.company_type = 1 	,r.bdid_score,	l.billing1_bdid_score);
				SELF.referring1_bdid_score		:= IF(r.company_type = 2	,r.bdid_score, 	l.referring1_bdid_score);
				SELF.attending1_bdid_score		:= IF(r.company_type = 3	,r.bdid_score, 	l.attending1_bdid_score);
				SELF.facility1_bdid_score			:= IF(r.company_type = 4	,r.bdid_score, 	l.facility1_bdid_score);
				SELF.billing1_lnpid						:= IF(r.company_type = 1	,r.lnpid,	l.billing1_lnpid);
				SELF.referring1_lnpid					:= IF(r.company_type = 2	,r.lnpid, l.referring1_lnpid);
				SELF.attending1_lnpid					:= IF(r.company_type = 3	,r.lnpid, l.attending1_lnpid);
				SELF.facility1_lnpid					:= IF(r.company_type = 4  ,r.lnpid, l.facility1_lnpid);
				SELF            := l;
		END;
	   
	  denormRecs :=  DENORMALIZE(temp_base_seq,all_together,
								  LEFT.unique_id = RIGHT.unique_id,
								  denormBdid(LEFT,RIGHT), LOCAL);
								         
		final_file	:= PROJECT(denormRecs, Emdeon.layouts.base.c_record);
		RETURN final_file;
	END;
	
	EXPORT D_records(DATASET(Emdeon.Layouts.Base.D_record)	pBaseFile) := FUNCTION

		expand_D_rec_layout	:= record
			UNSIGNED8			unique_id :=0;
			UNSIGNED4			company_type :=0;
			Emdeon.Layouts.base.D_record;
			STRING35			clean_company_name	:= '';
			STRING10			clean_prim_range	:= '';
			STRING2 			clean_predir	:= '';
			STRING28 			clean_prim_name	:= '';
			STRING4 			clean_addr_suffix	:= '';
			STRING2 			clean_postdir	:= '';
			STRING10 			clean_unit_desig	:= '';
			STRING8 			clean_sec_range	:= '';
			STRING25 			clean_p_city_name	:= '';
			STRING2 			clean_st	:= '';
			STRING5 			clean_zip	:= '';
			UNSIGNED6			bdid	:= 0;
			UNSIGNED1			bdid_score	:= 0;
			STRING10			npi	:= '';
			STRING20			state_lic	:= '';			
			UNSIGNED8	 		lnpid	:= 0;		
			UNSIGNED1			zero	:= 0;
		END;
		
		//PROJECT out to temporary layout to capture IDs when records are normalized - will be denormalized, too
		temp_base_recs := PROJECT(pBaseFile,expand_D_rec_layout);		
		
		//assign a unique_id for NORMALIZE/DENORMALIZE
		ut.MAC_Sequence_Records(temp_base_recs,unique_id,temp_base_seq);
		
		expand_D_rec_layout tNormalizeCompany(temp_base_seq L, UNSIGNED cnt) := TRANSFORM   
			SELF.unique_id						:= l.unique_id;
			SELF.company_type					:= cnt;
			SELF.clean_company_name		:= CHOOSE(cnt,L.clean_company_supervising,L.clean_company_operating,
																					L.clean_company_other_operating,L.clean_company_pay_to_plan_name);
			SELF.clean_prim_range			:= CHOOSE(cnt,L.clean_pay_to_prim_range,L.clean_pay_to_prim_range,
																					L.clean_pay_to_prim_range,L.clean_pay_to_plan_prim_range);
			SELF.clean_prim_name			:= CHOOSE(cnt,L.clean_pay_to_prim_name,L.clean_pay_to_prim_name,
																					L.clean_pay_to_prim_name,L.clean_pay_to_plan_prim_name);
			SELF.clean_zip						:= CHOOSE(cnt,L.clean_pay_to_zip,L.clean_pay_to_zip,
																					L.clean_pay_to_zip,L.clean_pay_to_plan_zip);
			SELF.clean_sec_range			:= CHOOSE(cnt,L.clean_pay_to_sec_range,L.clean_pay_to_sec_range,
																					L.clean_pay_to_sec_range,L.clean_pay_to_plan_sec_range);
			SELF.clean_st							:= CHOOSE(cnt,L.clean_pay_to_st,L.clean_pay_to_st,
																					L.clean_pay_to_st,L.clean_pay_to_plan_st);
			SELF.npi									:= CHOOSE(cnt,L.supervising_prov_npi,L.operating_prov_npi,L.other_operating_prov_npi,'');
			SELF.state_lic						:= CHOOSE(cnt,L.supervising_prov_state_lic,L.operating_prov_state_lic,L.other_operating_prov_state_lic,'');
			SELF := L;
			SELF := [];
		END;
   
		//NORMALIZE the records to populate the bdid for all companies
		dBdidPrep	:= NORMALIZE(temp_base_seq,4,tNormalizeCompany(LEFT,counter));
   
		HasName	:=	TRIM(dBdidPrep.clean_company_name,LEFT,RIGHT)    != '' ;
										
		dWith_name				:= dBdidPrep(HasName);
		dWithout_name	    := dBdidPrep(not(HasName));
			
		//BDID
		matchset 	:= ['A'];
		Business_Header_SS.MAC_Add_BDID_FLEX(
			dWith_name
			,matchset
			,clean_company_name
			,clean_prim_range
			,clean_prim_name
			,clean_zip
			,clean_sec_range
			,clean_st
			,foo
			,foo
			,bdid
			,expand_d_rec_layout 
			,TRUE
			,bdid_score
			,dBdidAppended
			,
			,
			,
			,BIPV2.xlink_version_set
			,
			,
			,clean_p_city_name
			,
			,
			,
			,
			,src
			,
			,
			);
				
		//get lnpid
		Health_Facility_Services.mac_get_best_lnpid_on_thor(
			dBdidAppended
			,lnpid
			,clean_company_name
			,clean_prim_range
			,clean_prim_name
			,clean_sec_range
			,clean_p_city_name
			,clean_st
			,clean_zip
			,//Input_TAX_ID = ''
			,//Input_FEIN = ''
			,//Input_PHONE = ''
			,//Input_FAX = ''
			,//Input_LIC_STATE = ''
			,state_lic
			,//Input_DEA_NUMBER = ''
			,//Input_VENDOR_ID = ''
			,npi
			,//Input_CLIA_NUMBER = ''
			,//Input_MEDICARE_FACILITY_NUMBER = ''
			,//Input_MEDICAID_NUMBER = ''
			,//Input_NCPDP_NUMBER = ''
			,//Input_Taxonomy = ''
			,bdid
			,//Input_SRC = ''
			,//Input_SOURCE_RID = ''
			,result
			,FALSE
			,30); 
			
			all_together	:= DISTRIBUTE(result + dWithout_name, HASH(unique_id));
	   		   
	  //DENORMALIZE the records 
		temp_base_seq denormBdid(temp_base_seq l, all_together r) := TRANSFORM			
				SELF.supervising_org_bdid 					:= IF(r.company_type = 1 	,r.bdid,	l.supervising_org_bdid);
				SELF.operating_org_bdid							:= IF(r.company_type = 2	,r.bdid, 	l.operating_org_bdid);
				SELF.other_operating_org_bdid				:= IF(r.company_type = 3	,r.bdid, 	l.other_operating_org_bdid);
				SELF.pay_to_plan_bdid								:= IF(r.company_type = 4	,r.bdid, 	l.pay_to_plan_bdid);
				SELF.supervising_org_bdid_score 		:= IF(r.company_type = 1 	,r.bdid_score,	l.supervising_org_bdid_score);
				SELF.operating_org_bdid_score				:= IF(r.company_type = 2	,r.bdid_score, 	l.operating_org_bdid_score);
				SELF.other_operating_org_bdid_score	:= IF(r.company_type = 3	,r.bdid_score, 	l.other_operating_org_bdid_score);
				SELF.pay_to_plan_bdid_score					:= IF(r.company_type = 4	,r.bdid_score, 	l.pay_to_plan_bdid_score);
				SELF.supervising_org_lnpid					:= IF(r.company_type = 1	,r.lnpid,	l.supervising_org_lnpid);
				SELF.operating_org_lnpid						:= IF(r.company_type = 2	,r.lnpid, l.operating_org_lnpid);
				SELF.other_operating_org_lnpid			:= IF(r.company_type = 3	,r.lnpid, l.other_operating_org_lnpid);
				SELF.pay_to_plan_lnpid							:= IF(r.company_type = 4  ,r.lnpid, l.pay_to_plan_lnpid);
				SELF            := l;
		END;
	   
	  denormRecs :=  DENORMALIZE(temp_base_seq,all_together,
								  LEFT.unique_id = RIGHT.unique_id,
								  denormBdid(LEFT,RIGHT), LOCAL);
								         
		final_file	:= PROJECT(denormRecs, Emdeon.layouts.base.d_record);
		RETURN final_file;
	END;
END;
