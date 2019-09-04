IMPORT lib_fileservices, _control, lib_stringlib, _Validate, did_add, ut, business_header_ss, business_header, Health_Facility_Services, HealthCareFacility, hxmx, BIPV2_Company_Names ;

// #stored('did_add_force','thor'); // remove or set to 'roxi' to put recs through roxi

trimUpper(STRING s) := FUNCTION
			RETURN TRIM(stringlib.StringToUppercase(s),LEFT,RIGHT);
			END;  

EXPORT Proc_Get_Company_IDs 	:= MODULE

	EXPORT hx_records(DATASET(hxmx.Layouts.Base.hx_record)	pBaseFile) := FUNCTION

   	expand_hx_rec_layout	:= RECORD
			hxmx.Layouts.base.hx_record;
			UNSIGNED8	 		lnpid	:= 0;		
		END;

		//project out to temporary layout to capture IDs when records are normalized - will be denormalized, too
		dBdidPrep := PROJECT(pBaseFile,expand_hx_rec_layout);		

		HasName	:=	TRIM(dBdidPrep.clean_billing_company_name,LEFT,RIGHT)    != '' ;

		dWith_name				:= dBdidPrep(HasName);
		dWithout_name	    := dBdidPrep(not(HasName));

		//BDID
		matchset 	:= ['A'];
		Business_Header_SS.MAC_Add_BDID_FLEX(
			dWith_name
			,matchset
			,clean_billing_company_name
			,clean_billing_prim_range
			,clean_billing_prim_name
			,clean_billing_zip
			,clean_billing_sec_range
			,clean_billing_st
			,foo
			,foo
			,billing_bdid
			,expand_hx_rec_layout 
			,TRUE
			,billing_bdid_score
			,dBdidAppended
			,
			,
			,
			,BIPV2.xlink_version_set
			,
			,
			,clean_billing_p_city_name
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
			,clean_billing_company_name
			,clean_billing_prim_range
			,clean_billing_prim_name
			,clean_billing_sec_range
			,clean_billing_p_city_name
			,clean_billing_st
			,clean_billing_zip
			,billing_tax_id
			,//Input_FEIN = ''
			,//Input_PHONE = ''
			,//Input_FAX = ''
			,//Input_LIC_STATE = ''
			,//Input_C_LIC_NBR = ''
			,//Input_DEA_NUMBER = ''
			,//Input_VENDOR_ID = ''
			,billing_npi
			,//Input_CLIA_NUMBER = ''
			,//Input_MEDICARE_FACILITY_NUMBER = ''
			,//Input_MEDICAID_NUMBER = ''
			,//Input_NCPDP_NUMBER = ''
			,//Input_Taxonomy = ''
			,billing_bdid
			,//Input_SRC = ''
			,//Input_SOURCE_RID = ''
			,result
			,FALSE
			,30); 

		expand_hx_rec_layout	move_lnpid(result L)	:= TRANSFORM
			SELF.billing_lnpid	:= l.lnpid;
			SELF	:= L;
		END;

		result2	:= PROJECT(result, move_lnpid(LEFT));

		 all_together	:= result2 + dWithout_name;

		RETURN PROJECT(all_together, layouts.base.hx_record);
	END;

	EXPORT mx_records(DATASET(hxmx.Layouts.Base.mx_record)	pBaseFile) := FUNCTION

		expand_mx_rec_layout	:= RECORD
			UNSIGNED8			unique_id :=0;
			UNSIGNED4			company_type :=0;
			hxmx.Layouts.base.mx_record;
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
		END;

		//project out to temporary layout to capture IDs when records are normalized - will be denormalized, too
		temp_base_recs := PROJECT(pBaseFile,expand_mx_rec_layout);		

		//assign a unique_id for normalize/denormalize
		ut.MAC_Sequence_Records(temp_base_recs,unique_id,temp_base_seq);

		expand_mx_rec_layout tNormalizeCompany(temp_base_seq L, UNSIGNED cnt) := TRANSFORM   
			SELF.unique_id						:= l.unique_id;
			SELF.company_type					:= cnt;
			SELF.clean_company_name		:= CHOOSE(cnt,L.clean_billing_company_name,L.clean_facility_lab_name,L.clean_serv_line_fac_company_name);
			SELF.clean_prim_range			:= CHOOSE(cnt,L.clean_billing_prim_range,L.clean_facility_lab_prim_range,L.clean_serv_line_fac_prim_range);
			SELF.clean_prim_name			:= CHOOSE(cnt,L.clean_billing_prim_name,L.clean_facility_lab_prim_name,L.clean_serv_line_fac_prim_name);
			SELF.clean_zip						:= CHOOSE(cnt,L.clean_billing_zip,L.clean_facility_lab_zip,L.clean_serv_line_fac_zip);
			SELF.clean_sec_range			:= CHOOSE(cnt,L.clean_billing_sec_range,L.clean_facility_lab_sec_range,L.clean_serv_line_fac_sec_range);
			SELF.clean_st							:= CHOOSE(cnt,L.clean_billing_st,L.clean_facility_lab_st,L.clean_serv_line_fac_st);
			SELF.npi									:= CHOOSE(cnt,L.billing_npi,L.facility_lab_npi,L.serv_line_fac_npi);
			SELF := L;
			SELF := [];
		END;

		//normalize the records to populate the bdid for all companies
		dBdidPrep	:= NORMALIZE(temp_base_seq,3,tNormalizeCompany(LEFT,counter));

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
			,expand_mx_rec_layout 
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

	  //denormalize the records 
		temp_base_seq denormBdid(temp_base_seq l, all_together r) := TRANSFORM			
				SELF.billing_company_bdid 						:= IF(r.company_type = 1 	,r.bdid,	l.billing_company_bdid);
				SELF.facility_lab_company_bdid				:= IF(r.company_type = 2  ,r.bdid,  l.facility_lab_company_bdid);
				SELF.serv_line_fac_bdid								:= IF(r.company_type = 3	,r.bdid, 	l.serv_line_fac_bdid);
				SELF.billing_company_bdid_score 			:= IF(r.company_type = 1 	,r.bdid_score,	l.billing_company_bdid_score);
				SELF.facility_lab_company_bdid_score	:= IF(r.company_type = 2  ,r.bdid_score,  l.facility_lab_company_bdid_score);
				SELF.serv_line_fac_bdid_score					:= IF(r.company_type = 3	,r.bdid_score, 	l.serv_line_fac_bdid_score);
				SELF.billing_company_lnpid						:= IF(r.company_type = 1	,r.lnpid,	l.billing_company_lnpid);
				SELF.facility_lab_company_lnpid				:= IF(r.company_type = 2  ,r.lnpid, L.facility_lab_company_lnpid);
				SELF.serv_line_fac_lnpid							:= IF(r.company_type = 3	,r.lnpid, l.serv_line_fac_lnpid);
				SELF            := l;
		END;

	  denormRecs :=  DENORMALIZE(temp_base_seq,all_together,
								  LEFT.unique_id = RIGHT.unique_id,
								  denormBdid(LEFT,RIGHT),LOCAL);

		final_file	:= PROJECT(denormRecs, hxmx.layouts.base.mx_record);
		RETURN final_file;
	END;
END;