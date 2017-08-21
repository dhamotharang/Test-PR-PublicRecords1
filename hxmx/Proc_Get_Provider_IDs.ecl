IMPORT lib_fileservices, _control, lib_stringlib, _Validate, did_add, ut, business_header_ss, business_header, Health_Provider_Services, hxmx  ;

// #stored('did_add_force','thor'); // remove or set to 'roxi' to put recs through roxi

trimUpper(STRING s) := FUNCTION
			RETURN TRIM(stringlib.StringToUppercase(s),LEFT,RIGHT);
			END;  

EXPORT Proc_Get_Provider_IDs	:= MODULE

	EXPORT hx_records(DATASET(hxmx.Layouts.Base.hx_record)	pBaseFile) := FUNCTION

		expand_hx_rec_layout	:= RECORD
			UNSIGNED8			unique_id :=0;
			UNSIGNED4			prov_type :=0;
			hxmx.Layouts.base.hx_record;
			STRING20			clean_fname := '';
			STRING20 			clean_mname	:= '';
			STRING20 			clean_lname	:= '';
			STRING5  			clean_name_suffix	:= '';
			STRING35			orig_full_name	:= '';	
			UNSIGNED4			best_dob	:= 0;
			STRING9				best_ssn	:= '';
			STRING10			hxmx_id	:= '';
			UNSIGNED6			bdid	:= 0;
			UNSIGNED1			bdid_score	:= 0;
			UNSIGNED6			did	:= 0;
			UNSIGNED1			did_score		:= 0;
			UNSIGNED8	 		lnpid	:= 0;		
		END;

		//project out to temporary layout to capture IDs when records are normalized - will be denormalized, too
		temp_base_recs := PROJECT(pBaseFile,expand_hx_rec_layout);		

		//assign a unique_id for normalize/denormalize
		ut.MAC_Sequence_Records(temp_base_recs,unique_id,temp_base_seq);

		expand_hx_rec_layout tNormalizeProv(temp_base_seq L, UNSIGNED cnt) := TRANSFORM   
			SELF.unique_id						:= l.unique_id;
			SELF.prov_type						:= cnt;
			SELF.clean_fname					:= CHOOSE(cnt,L.clean_attending_prov_fname,L.clean_operating_prov_fname,L.clean_other_prov1_fname,L.clean_other_prov2_fname);
			SELF.clean_mname					:= CHOOSE(cnt,L.clean_attending_prov_mname,L.clean_operating_prov_mname,L.clean_other_prov1_mname,L.clean_other_prov2_mname);
			SELF.clean_lname					:= CHOOSE(cnt,L.clean_attending_prov_lname,L.clean_operating_prov_lname,L.clean_other_prov1_lname,L.clean_other_prov2_lname);
			SELF.clean_name_suffix		:= CHOOSE(cnt,L.clean_attending_prov_name_suffix,L.clean_operating_prov_name_suffix,L.clean_other_prov1_name_suffix,L.clean_other_prov2_name_suffix);
			SELF.orig_full_name				:= CHOOSE(cnt,L.attend_prov_name,L.operating_prov_name,L.other_prov_name1,L.other_prov_name2);
			SELF.hxmx_id							:= CHOOSE(cnt,L.attend_prov_id,L.operating_prov_id,L.other_prov_id1,L.other_prov_id2);
			SELF := L;
			SELF := [];
		END;

		//normalize the records to populate the did for all providers
		dDidPrep	:= NORMALIZE(temp_base_seq,4,tNormalizeProv(LEFT,counter));

		HasName	:=	((TRIM(dDidPrep.clean_lname,LEFT,RIGHT) != '')	AND (TRIM(dDidPrep.clean_fname,LEFT,RIGHT)	!= ''));

		dWith_name				:= dDidPrep(HasName);
		dWithout_name	    := dDidPrep(not(HasName));

		//DID
		//we only have the billing address, but trying to push all individuals through DID with that address, expecting low results for referring and attending
		matchset := ['A'];
		did_add.MAC_Match_Flex
			(dWith_name, matchset,					
			foo, foo, clean_fname, clean_mname, clean_lname, clean_name_suffix, 
			clean_billing_prim_range, clean_billing_prim_name, clean_billing_sec_range, clean_billing_zip, clean_billing_st, '', 
			DID, expand_hx_rec_layout, TRUE, did_score,
			75, d_did);

		did_add.MAC_Add_SSN_By_DID(d_did,did,best_ssn,d_ssn,FALSE);
		did_add.MAC_Add_DOB_By_DID(d_ssn,did,best_dob,d_dob,FALSE);

		//BDID
		//might get some bdids...
		bdid_matchset := ['A'];
		Business_Header_SS.MAC_Add_BDID_Flex
			(
			d_dob
			,bdid_matchset
			,orig_full_name
			,clean_billing_prim_range
			,clean_billing_prim_name
			,clean_billing_zip
			,clean_billing_sec_range
			,clean_billing_st
			,foo
			,foo
			,bdid
			,expand_hx_rec_layout
			,TRUE
			,bdid_score
			,d_bdid
			,
			,
			,
			,BIPV2.xlink_version_set
			,
			,
			,clean_billing_p_city_name
			,clean_fname
			,clean_mname
			,clean_lname
			,best_ssn
			,//src
			,
			,
			);

		Health_Provider_Services.mac_get_best_lnpid_on_thor (
			d_bdid
			,lnpid
			,clean_fname
			,clean_mname
			,clean_lname
			,clean_name_suffix
			,//GENDER
			,clean_billing_prim_range
			,clean_billing_prim_name
			,clean_billing_sec_range
			,clean_billing_p_city_name
			,clean_billing_st
			,clean_billing_zip
			,best_ssn
			,best_dob
			,
			,
			,//LIC_Num_in
			,//TAX_ID
			,//DEA_NUM
			,hxmx_id//vendor_id
			,//npi
			,//UPIN
			,did
			,bdid
			,//SRC
			,//SOURCE_RID
			,result,FALSE,38
			);

		all_together	:= DISTRIBUTE(result + dWithout_name, HASH(unique_id));

	  //denormalize the records 
		temp_base_seq denormGiant(temp_base_seq l, all_together r) := TRANSFORM			
				SELF.attending_prov_bdid 				:= IF(r.prov_type = 1	,r.bdid,			l.attending_prov_bdid);
				SELF.operating_prov_bdid				:= IF(r.prov_type = 2	,r.bdid, 			l.operating_prov_bdid);
				SELF.other_prov1_bdid						:= IF(r.prov_type = 3	,r.bdid, 			l.other_prov1_bdid);
				SELF.other_prov2_bdid						:= IF(r.prov_type = 4 ,r.bdid,			l.other_prov2_bdid);
				SELF.attending_prov_bdid_score	:= IF(r.prov_type = 1	,r.bdid_score,l.attending_prov_bdid_score);
				SELF.operating_prov_bdid_score	:= IF(r.prov_type = 2	,r.bdid_score,l.operating_prov_bdid_score);
				SELF.other_prov1_bdid_score			:= IF(r.prov_type = 3	,r.bdid_score,l.other_prov1_bdid_score);
				SELF.other_prov2_bdid_score			:= IF(r.prov_type = 4 ,r.bdid_score,l.other_prov2_bdid_score);
				SELF.attending_prov_did 				:= IF(r.prov_type = 1	,r.did,				l.attending_prov_did);
				SELF.operating_prov_did					:= IF(r.prov_type = 2	,r.did, 			l.operating_prov_did);
				SELF.other_prov1_did						:= IF(r.prov_type = 3	,r.did, 			l.other_prov1_did);
				SELF.other_prov2_did						:= IF(r.prov_type = 4 ,r.did,				l.other_prov2_did);
				SELF.attending_prov_did_score 	:= IF(r.prov_type = 1	,r.did_score,	l.attending_prov_did_score);
				SELF.operating_prov_did_score		:= IF(r.prov_type = 2	,r.did_score, l.operating_prov_did_score);
				SELF.other_prov1_did_score			:= IF(r.prov_type = 3	,r.did_score, l.other_prov1_did_score);		
				SELF.other_prov2_did_score			:= IF(r.prov_type = 4 ,r.did_score,	l.other_prov2_did_score);
				SELF.attending_prov_lnpid				:= IF(r.prov_type = 1 ,r.lnpid,			l.attending_prov_lnpid);
				SELF.operating_prov_lnpid				:= IF(r.prov_type = 2 ,r.lnpid,			l.operating_prov_lnpid);
				SELF.other_prov1_lnpid					:= IF(r.prov_type = 3 ,r.lnpid,			l.other_prov1_lnpid);
				SELF.other_prov2_lnpid					:= IF(r.prov_type = 4 ,r.lnpid,			l.other_prov2_lnpid);
				SELF.attending_prov_best_dob		:= IF(r.prov_type = 1 ,r.best_dob,	l.attending_prov_best_dob);
				SELF.operating_prov_best_dob		:= IF(r.prov_type = 2 ,r.best_dob,	l.operating_prov_best_dob);
				SELF.other_prov1_best_dob				:= IF(r.prov_type = 3 ,r.best_dob,	l.other_prov1_best_dob);
				SELF.other_prov2_best_dob				:= IF(r.prov_type = 4 ,r.best_dob,	l.other_prov2_best_dob);
				SELF.attending_prov_best_ssn		:= IF(r.prov_type = 1 ,r.best_ssn,	l.attending_prov_best_ssn);
				SELF.operating_prov_best_ssn		:= IF(r.prov_type = 2 ,r.best_ssn,	l.operating_prov_best_ssn);
				SELF.other_prov1_best_ssn				:= IF(r.prov_type = 3 ,r.best_ssn,	l.other_prov1_best_ssn);
				SELF.other_prov2_best_ssn				:= IF(r.prov_type = 4 ,r.best_ssn,	l.other_prov2_best_ssn);
				SELF            := l;
		END;

	  denormRecs :=  DENORMALIZE(temp_base_seq,all_together,
								  LEFT.unique_id = RIGHT.unique_id,
								  denormGiant(LEFT,RIGHT),LOCAL);

		final_file	:= PROJECT(denormRecs, hxmx.layouts.base.hx_record);
		RETURN final_file;
	END;

	EXPORT mx_records(DATASET(hxmx.Layouts.Base.mx_record)	pBaseFile) := FUNCTION

		expand_mx_rec_layout	:= RECORD
			UNSIGNED8			unique_id :=0;
			UNSIGNED4			prov_type :=0;
			hxmx.Layouts.base.mx_record;
			STRING20			clean_fname	:= '';
			STRING20 			clean_mname	:= '';
			STRING20 			clean_lname	:= '';
			STRING5  			clean_name_suffix	:= '';
			STRING65			prep_full_name	:= '';
			STRING10			prim_range	:= '';
			STRING28			prim_name		:= '';
			STRING5				zip	:= '';
			STRING8				sec_range	:= '';
			STRING2				st	:= '';
			STRING25			p_city_name	:= '';
			UNSIGNED4			best_dob	:= 0;
			STRING9				best_ssn	:= '';
			STRING10			npi	:= '';
			STRING20			state_lic	:= '';
			STRING6				upin	:= '';
			STRING10			tax_id	:= '';
			UNSIGNED6			bdid	:= 0;
			UNSIGNED1			bdid_score	:= 0;
			UNSIGNED6			did	:= 0;
			UNSIGNED1			did_score		:= 0;
			UNSIGNED8	 		lnpid	:= 0;		
		END;

		//project out to temporary layout to capture IDs when records are normalized - will be denormalized, too
		temp_base_recs := PROJECT(pBaseFile,expand_mx_rec_layout);		

		//assign a unique_id for normalize/denormalize
		ut.MAC_Sequence_Records(temp_base_recs,unique_id,temp_base_seq);

		expand_mx_rec_layout tNormalizeProv(temp_base_seq L, UNSIGNED cnt) := TRANSFORM   
			SELF.unique_id						:= l.unique_id;
			SELF.prov_type						:= cnt;
			SELF.clean_fname					:= CHOOSE(cnt,L.clean_billing_fname,L.clean_emt_paramedic_fname,L.clean_ordering_prov_fname,L.clean_pay_to_fname,L.clean_purch_service_fname,
																							L.clean_ref_prov_fname,L.clean_render_prov_fname,L.clean_serv_line_ref_prov_fname,L.clean_serv_line_render_prov_fname,
																							L.clean_serv_line_supervising_prov_fname,L.clean_supervising_prov_fname);
			SELF.clean_mname					:= CHOOSE(cnt,L.clean_billing_mname,L.clean_emt_paramedic_mname,L.clean_ordering_prov_mname,L.clean_pay_to_mname,L.clean_purch_service_mname,
																							L.clean_ref_prov_mname,L.clean_render_prov_mname,L.clean_serv_line_ref_prov_mname,L.clean_serv_line_render_prov_mname,
																							L.clean_serv_line_supervising_prov_mname,L.clean_supervising_prov_mname);
			SELF.clean_lname					:= CHOOSE(cnt,L.clean_billing_lname,L.clean_emt_paramedic_lname,L.clean_ordering_prov_lname,L.clean_pay_to_lname,L.clean_purch_service_lname,
																							L.clean_ref_prov_lname,L.clean_render_prov_lname,L.clean_serv_line_ref_prov_lname,L.clean_serv_line_render_prov_lname,
																							L.clean_serv_line_supervising_prov_lname,L.clean_supervising_prov_lname);
			SELF.clean_name_suffix		:= CHOOSE(cnt,L.clean_billing_name_suffix,L.clean_emt_paramedic_name_suffix,L.clean_ordering_prov_name_suffix,L.clean_purch_service_name_suffix,
																							L.clean_ref_prov_name_suffix,L.clean_render_prov_name_suffix,L.clean_serv_line_ref_prov_name_suffix,L.clean_serv_line_render_prov_name_suffix,
																							L.clean_serv_line_supervising_prov_name_suffix,L.clean_supervising_prov_name_suffix);
			pre_prep_full_name				:= CHOOSE(cnt,L.clean_billing_fname + IF(l.clean_billing_mname <> '', ' ' + l.clean_billing_mname + ' ', ' ')
																						+ L.clean_billing_lname,
																							L.clean_emt_paramedic_fname   + IF(l.clean_emt_paramedic_mname <> '', ' ' + l.clean_emt_paramedic_mname + ' ', ' ')
																						+ L.clean_emt_paramedic_lname,
																							L.clean_ordering_prov_fname + IF(l.clean_ordering_prov_mname<>'',' '+l.clean_ordering_prov_mname+' ',' ')
																						+ L.clean_ordering_prov_lname,
																							L.clean_pay_to_fname 		+ IF(L.clean_pay_to_mname<>'',' '+L.clean_pay_to_mname+' ', ' ')
																						+ L.clean_pay_to_lname,
																							L.clean_purch_service_fname 		+ IF(L.clean_purch_service_mname<>'',' '+L.clean_purch_service_mname+' ', ' ')
																						+ L.clean_purch_service_lname,
																							L.clean_ref_prov_fname 		+ IF(L.clean_ref_prov_mname<>'',' '+L.clean_ref_prov_mname+' ', ' ')
																						+ L.clean_ref_prov_lname,
																							L.clean_render_prov_fname 		+ IF(L.clean_render_prov_mname<>'',' '+L.clean_render_prov_mname+' ', ' ')
																						+ L.clean_render_prov_lname,
																							L.clean_serv_line_ref_prov_fname 		+ IF(L.clean_serv_line_ref_prov_mname<>'',' '+L.clean_serv_line_ref_prov_mname+' ', ' ')
																						+ L.clean_serv_line_ref_prov_lname,
																							L.clean_serv_line_render_prov_fname 		+ IF(L.clean_serv_line_render_prov_mname<>'',' '+L.clean_serv_line_render_prov_mname+' ', ' ')
																						+ L.clean_serv_line_render_prov_lname,
																							L.clean_serv_line_supervising_prov_fname 		+ IF(L.clean_serv_line_supervising_prov_mname<>'',' '+L.clean_serv_line_supervising_prov_mname+' ', ' ')
																						+ L.clean_serv_line_supervising_prov_lname,
																							L.clean_supervising_prov_fname 		+ IF(L.clean_supervising_prov_mname<>'',' '+L.clean_supervising_prov_mname+' ', ' ')
																						+ L.clean_supervising_prov_lname);																					
			SELF.prep_full_name				:= Stringlib.StringCleanSpaces(pre_prep_full_name);
			SELF.npi									:= CHOOSE(cnt,L.billing_npi,'',L.ordering_prov_npi,L.pay_to_npi,L.purch_service_npi,L.ref_prov_npi,L.render_prov_npi,
																							L.serv_line_ref_prov_npi,L.serv_line_render_prov_npi,L.serv_line_supervising_prov_npi,L.supervising_prov_npi);
			SELF.state_lic						:= CHOOSE(cnt,L.billing_state_lic,'','','','','','','','','','');
			SELF.upin									:= CHOOSE(cnt,L.billing_upin,'',L.ordering_prov_upin,'','',L.ref_prov_upin,'',L.serv_line_ref_prov_upin,L.serv_line_render_prov_upin,
																							L.serv_line_supervising_prov_upin,'');
			SELF.tax_id								:= CHOOSE(cnt,L.billing_tax_id,'','',L.pay_to_tax_id,L.purch_service_prov_tax_id,L.ref_prov_tax_id,L.render_prov_tax_id,'',L.serv_line_render_prov_tax_id,
																							'',L.supervising_prov_tax_id);
			SELF.prim_range						:= CHOOSE(cnt,L.clean_billing_prim_range,L.clean_billing_prim_range,L.clean_ordering_prov_prim_range,L.clean_pay_to_prim_range,L.clean_purch_service_prim_range,
																							L.clean_billing_prim_range,L.clean_billing_prim_range,L.clean_serv_line_fac_prim_range,L.clean_serv_line_fac_prim_range,L.clean_billing_prim_range);
			SELF.prim_name						:= CHOOSE(cnt,L.clean_billing_prim_name,L.clean_billing_prim_name,L.clean_ordering_prov_prim_name,L.clean_pay_to_prim_name,L.clean_purch_service_prim_name,
																							L.clean_billing_prim_name,L.clean_billing_prim_name,L.clean_serv_line_fac_prim_name,L.clean_serv_line_fac_prim_name,L.clean_billing_prim_name);
			SELF.zip									:= CHOOSE(cnt,L.clean_billing_zip,L.clean_billing_zip,L.clean_ordering_prov_zip,L.clean_pay_to_zip,L.clean_purch_service_zip,
																							L.clean_billing_zip,L.clean_billing_zip,L.clean_serv_line_fac_zip,L.clean_serv_line_fac_zip,L.clean_billing_zip);
			SELF.sec_range						:= CHOOSE(cnt,L.clean_billing_sec_range,L.clean_billing_sec_range,L.clean_ordering_prov_sec_range,L.clean_pay_to_sec_range,L.clean_purch_service_sec_range,
																							L.clean_billing_sec_range,L.clean_billing_sec_range,L.clean_serv_line_fac_sec_range,L.clean_billing_sec_range);
			SELF.st										:= CHOOSE(cnt,L.clean_billing_st,L.clean_billing_st,L.clean_ordering_prov_st,L.clean_pay_to_st,L.clean_purch_service_st,
																							L.clean_billing_st,L.clean_billing_st,L.clean_serv_line_fac_st,L.clean_serv_line_fac_st,L.clean_billing_st);
			SELF.p_city_name					:= CHOOSE(cnt,L.clean_billing_p_city_name,L.clean_billing_p_city_name,L.clean_ordering_prov_p_city_name,L.clean_pay_to_p_city_name,L.clean_purch_service_p_city_name,
																							L.clean_billing_p_city_name,L.clean_billing_p_city_name,L.clean_serv_line_fac_p_city_name,L.clean_serv_line_fac_p_city_name,L.clean_billing_p_city_name);
			SELF := L;
			SELF := [];
		END;

		//normalize the records to populate the did for all providers
		dDidPrep	:= NORMALIZE(temp_base_seq,11,tNormalizeProv(LEFT,counter));

		HasName	:=	((TRIM(dDidPrep.clean_lname,LEFT,RIGHT) != '')	AND (TRIM(dDidPrep.clean_fname,LEFT,RIGHT)	!= ''));

		dWith_name				:= dDidPrep(HasName);
		dWithout_name	    := dDidPrep(not(HasName));

		//DID
		//we don't have addresses for all providers - using billing for non service-line related providers, and service facility for all service line related providers
		matchset := ['A'];
		did_add.MAC_Match_Flex
			(dWith_name, matchset,					
			foo, foo, clean_fname, clean_mname, clean_lname, clean_name_suffix, 
			prim_range, prim_name, sec_range, zip, st, '', 
			DID, expand_mx_rec_layout, TRUE, did_score,
			75, d_did);

		did_add.MAC_Add_SSN_By_DID(d_did,did,best_ssn,d_ssn,FALSE);
		did_add.MAC_Add_DOB_By_DID(d_ssn,did,best_dob,d_dob,FALSE);

		//BDID
		//might get some bdids...
		bdid_matchset := ['A'];
		Business_Header_SS.MAC_Add_BDID_Flex
			(
			d_dob
			,bdid_matchset
			,prep_full_name
			,prim_range
			,prim_name
			,zip
			,sec_range
			,st
			,foo
			,foo
			,bdid
			,expand_mx_rec_layout
			,TRUE
			,bdid_score
			,d_bdid
			,
			,
			,
			,BIPV2.xlink_version_set
			,
			,
			,p_city_name
			,clean_fname
			,clean_mname
			,clean_lname
			,best_ssn
			,//src
			,
			,
			);

		Health_Provider_Services.mac_get_best_lnpid_on_thor (
			d_bdid
			,lnpid
			,clean_fname
			,clean_mname
			,clean_lname
			,clean_name_suffix
			,//GENDER
			,prim_range
			,prim_name
			,sec_range
			,p_city_name
			,st
			,zip
			,best_ssn
			,best_dob
			,
			,
			,state_lic
			,tax_id
			,//DEA_NUM
			,//group_key
			,npi
			,upin
			,did
			,bdid
			,//SRC
			,//SOURCE_RID
			,result,FALSE,38
			);

		all_together	:= DISTRIBUTE(result + dWithout_name, HASH(unique_id));

	  //denormalize the records 
		temp_base_seq denormGiant(temp_base_seq l, all_together r) := TRANSFORM			
				SELF.billing_bdid 													:= IF(r.prov_type = 1	,r.bdid,			l.billing_bdid);
				SELF.emt_paramedic_bdid											:= IF(r.prov_type = 2	,r.bdid, 			l.emt_paramedic_bdid);
				SELF.ordering_prov_bdid											:= IF(r.prov_type = 3	,r.bdid, 			l.ordering_prov_bdid);
				SELF.pay_to_bdid														:= IF(r.prov_type = 4 ,r.bdid,			l.pay_to_bdid);				
				SELF.purch_service_bdid 										:= IF(r.prov_type = 5	,r.bdid,			l.purch_service_bdid);
				SELF.ref_prov_bdid													:= IF(r.prov_type = 6	,r.bdid, 			l.ref_prov_bdid);
				SELF.render_prov_bdid												:= IF(r.prov_type = 7	,r.bdid, 			l.render_prov_bdid);
				SELF.serv_line_ref_prov_bdid								:= IF(r.prov_type = 8 ,r.bdid,			l.serv_line_ref_prov_bdid);
				SELF.serv_line_render_prov_bdid							:= IF(r.prov_type = 9	,r.bdid,			l.serv_line_render_prov_bdid);			
				SELF.serv_line_supervising_prov_bdid				:= IF(r.prov_type = 10,r.bdid, 			l.serv_line_supervising_prov_bdid);
				SELF.supervising_prov_bdid									:= IF(r.prov_type = 11,r.bdid, 			l.supervising_prov_bdid);
				SELF.billing_bdid_score 										:= IF(r.prov_type = 1	,r.bdid_score,l.billing_bdid_score);
				SELF.emt_paramedic_bdid_score								:= IF(r.prov_type = 2	,r.bdid_score,l.emt_paramedic_bdid_score);
				SELF.ordering_prov_bdid_score								:= IF(r.prov_type = 3	,r.bdid_score,l.ordering_prov_bdid_score);
				SELF.pay_to_bdid_score											:= IF(r.prov_type = 4 ,r.bdid_score,l.pay_to_bdid_score);				
				SELF.purch_service_bdid_score								:= IF(r.prov_type = 5 ,r.bdid_score,l.purch_service_bdid_score);			
				SELF.ref_prov_bdid_score										:= IF(r.prov_type = 6 ,r.bdid_score,l.ref_prov_bdid_score);		
				SELF.render_prov_bdid_score									:= IF(r.prov_type = 7 ,r.bdid_score,l.render_prov_bdid_score);		
				SELF.serv_line_ref_prov_bdid_score					:= IF(r.prov_type = 8 ,r.bdid_score,l.serv_line_ref_prov_bdid_score);			
				SELF.serv_line_render_prov_bdid_score				:= IF(r.prov_type = 9 ,r.bdid_score,l.serv_line_render_prov_bdid_score);		
				SELF.serv_line_supervising_prov_bdid_score	:= IF(r.prov_type = 10 ,r.bdid_score,l.serv_line_supervising_prov_bdid_score);
				SELF.supervising_prov_bdid_score						:= IF(r.prov_type = 11 ,r.bdid_score,l.supervising_prov_bdid_score);
				SELF.billing_did 														:= IF(r.prov_type = 1	,r.did,				l.billing_did);
				SELF.emt_paramedic_did											:= IF(r.prov_type = 2	,r.did, 			l.emt_paramedic_did);
				SELF.ordering_prov_did											:= IF(r.prov_type = 3	,r.did, 			l.ordering_prov_did);
				SELF.pay_to_did															:= IF(r.prov_type = 4 ,r.did,				l.pay_to_did);			
				SELF.purch_service_did											:= IF(r.prov_type = 5 ,r.did,				l.purch_service_did);
				SELF.ref_prov_did														:= IF(r.prov_type = 6 ,r.did,				l.ref_prov_did);		
				SELF.render_prov_did												:= IF(r.prov_type = 7 ,r.did,				l.render_prov_did);		
				SELF.serv_line_ref_prov_did									:= IF(r.prov_type = 8 ,r.did,				l.serv_line_ref_prov_did);
				SELF.serv_line_render_prov_did							:= IF(r.prov_type = 9 ,r.did,				l.serv_line_render_prov_did);
				SELF.serv_line_supervising_prov_did					:= IF(r.prov_type = 10 ,r.did,			l.serv_line_supervising_prov_did);
				SELF.supervising_prov_did										:= IF(r.prov_type = 11 ,r.did,			l.supervising_prov_did);
				SELF.billing_did_score							 				:= IF(r.prov_type = 1	,r.did_score,	l.billing_did_score);
				SELF.emt_paramedic_did_score								:= IF(r.prov_type = 2	,r.did_score, l.emt_paramedic_did_score);
				SELF.ordering_prov_did_score								:= IF(r.prov_type = 3	,r.did_score, l.ordering_prov_did_score);		
				SELF.pay_to_did_score												:= IF(r.prov_type = 4 ,r.did_score,	l.pay_to_did_score);	
				SELF.purch_service_did_score								:= IF(r.prov_type = 5 ,r.did_score,	l.purch_service_did_score);
				SELF.ref_prov_did_score											:= IF(r.prov_type = 6 ,r.did_score,	l.ref_prov_did_score);		
				SELF.render_prov_did_score									:= IF(r.prov_type = 7 ,r.did_score,	l.render_prov_did_score);			
				SELF.serv_line_ref_prov_did_score						:= IF(r.prov_type = 8 ,r.did_score,	l.serv_line_ref_prov_did_score);		
				SELF.serv_line_render_prov_did_score				:= IF(r.prov_type = 9 ,r.did_score,	l.serv_line_render_prov_did_score);
				SELF.serv_line_supervising_prov_did_score		:= IF(r.prov_type = 10 ,r.did_score,	l.serv_line_supervising_prov_did_score);
				SELF.supervising_prov_did_score							:= IF(r.prov_type = 11 ,r.did_score,	l.supervising_prov_did_score);
				SELF.billing_lnpid													:= IF(r.prov_type = 1 ,r.lnpid,			l.billing_lnpid);
				SELF.emt_paramedic_lnpid										:= IF(r.prov_type = 2 ,r.lnpid,			l.emt_paramedic_lnpid);
				SELF.ordering_prov_lnpid										:= IF(r.prov_type = 3 ,r.lnpid,			l.ordering_prov_lnpid);
				SELF.pay_to_lnpid														:= IF(r.prov_type = 4 ,r.lnpid,			l.pay_to_lnpid);	
				SELF.purch_service_lnpid										:= IF(r.prov_type = 5 ,r.lnpid,			l.purch_service_lnpid);
				SELF.ref_prov_lnpid													:= IF(r.prov_type = 6 ,r.lnpid,			l.ref_prov_lnpid);			
				SELF.render_prov_lnpid											:= IF(r.prov_type = 7 ,r.lnpid,			l.render_prov_lnpid);			
				SELF.serv_line_ref_prov_lnpid								:= IF(r.prov_type = 8 ,r.lnpid,			l.serv_line_ref_prov_lnpid);	
				SELF.serv_line_render_prov_lnpid						:= IF(r.prov_type = 9 ,r.lnpid,			l.serv_line_render_prov_lnpid);
				SELF.serv_line_supervising_prov_lnpid				:= IF(r.prov_type = 10 ,r.lnpid,			l.serv_line_supervising_prov_lnpid);
				SELF.supervising_prov_lnpid									:= IF(r.prov_type = 11 ,r.lnpid,			l.supervising_prov_lnpid);
				SELF.billing_best_dob												:= IF(r.prov_type = 1 ,r.best_dob,	l.billing_best_dob);
				SELF.emt_paramedic_best_dob									:= IF(r.prov_type = 2 ,r.best_dob,	l.emt_paramedic_best_dob);
				SELF.ordering_prov_best_dob									:= IF(r.prov_type = 3 ,r.best_dob,	l.ordering_prov_best_dob);
				SELF.pay_to_best_dob												:= IF(r.prov_type = 4 ,r.best_dob,	l.pay_to_best_dob);
				SELF.purch_service_best_dob									:= IF(r.prov_type = 5 ,r.best_dob,	l.purch_service_best_dob);
				SELF.ref_prov_best_dob											:= IF(r.prov_type = 6 ,r.best_dob,	l.ref_prov_best_dob);			
				SELF.render_prov_best_dob										:= IF(r.prov_type = 7 ,r.best_dob,	l.render_prov_best_dob);			
				SELF.serv_line_ref_prov_best_dob						:= IF(r.prov_type = 8 ,r.best_dob,	l.serv_line_ref_prov_best_dob);			
				SELF.serv_line_render_prov_best_dob					:= IF(r.prov_type = 9 ,r.best_dob,	l.serv_line_render_prov_best_dob);
				SELF.serv_line_supervising_prov_best_dob		:= IF(r.prov_type = 10 ,r.best_dob,	l.serv_line_supervising_prov_best_dob);
				SELF.supervising_prov_best_dob							:= IF(r.prov_type = 11 ,r.best_dob,	l.supervising_prov_best_dob);
				SELF.billing_best_ssn												:= IF(r.prov_type = 1 ,r.best_ssn,	l.billing_best_ssn);
				SELF.emt_paramedic_best_ssn									:= IF(r.prov_type = 2 ,r.best_ssn,	l.emt_paramedic_best_ssn);
				SELF.ordering_prov_best_ssn									:= IF(r.prov_type = 3 ,r.best_ssn,	l.ordering_prov_best_ssn);
				SELF.pay_to_best_ssn												:= IF(r.prov_type = 4 ,r.best_ssn,	l.pay_to_best_ssn);
				SELF.purch_service_best_ssn									:= IF(r.prov_type = 5 ,r.best_ssn,	l.purch_service_best_ssn);
				SELF.ref_prov_best_ssn											:= IF(r.prov_type = 6 ,r.best_ssn,	l.ref_prov_best_ssn);		
				SELF.render_prov_best_ssn										:= IF(r.prov_type = 7 ,r.best_ssn,	l.render_prov_best_ssn);		
				SELF.serv_line_ref_prov_best_ssn						:= IF(r.prov_type = 8 ,r.best_ssn,	l.serv_line_ref_prov_best_ssn);	
				SELF.serv_line_render_prov_best_ssn					:= IF(r.prov_type = 9 ,r.best_ssn,	l.serv_line_render_prov_best_ssn);
				SELF.serv_line_supervising_prov_best_ssn		:= IF(r.prov_type = 10 ,r.best_ssn,	l.serv_line_supervising_prov_best_ssn);
				SELF.supervising_prov_best_ssn							:= IF(r.prov_type = 11 ,r.best_ssn,	l.supervising_prov_best_ssn);
				SELF            := l;
		END;

	  denormRecs :=  DENORMALIZE(temp_base_seq,all_together,
								  LEFT.unique_id = RIGHT.unique_id,
								  denormGiant(LEFT,RIGHT),LOCAL);

		final_file	:= PROJECT(denormRecs, hxmx.layouts.base.mx_record);
		RETURN final_file;
	END;

END;
