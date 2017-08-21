IMPORT lib_fileservices, _control, lib_STRINGlib, _Validate, did_add, ut, business_header_ss, business_header, Health_Provider_Services, Emdeon  ;

// #STORED('did_add_force','thor'); // remove or set to 'roxi' to put recs through roxi

trimUpper(STRING s) := FUNCTION
			RETURN TRIM(STRINGlib.StringToUppercase(s),LEFT,RIGHT);
			END;  
	
EXPORT Proc_Get_Provider_IDs	:= MODULE

	EXPORT C_records(DATASET(Emdeon.Layouts.Base.C_record)	pBaseFile) := FUNCTION

		expand_C_rec_layout	:= RECORD
			UNSIGNED8			unique_id :=0;
			UNSIGNED4			prov_type :=0;
			Emdeon.Layouts.base.c_record;
			STRING20			clean_fname := '';
			STRING20 			clean_mname	:= '';
			STRING20 			clean_lname	:= '';
			STRING5  			clean_name_suffix	:= '';
			STRING35			orig_full_name	:= '';	
			UNSIGNED4			best_dob	:= 0;
			STRING9				best_ssn	:= '';
			STRING10			npi	:= '';
			UNSIGNED6			bdid	:= 0;
			UNSIGNED1			bdid_score	:= 0;
			UNSIGNED6			did	:= 0;
			UNSIGNED1			did_score		:= 0;
			UNSIGNED8	 		lnpid	:= 0;		
			UNSIGNED1			zero	:= 0;
		END;

		//PROJECT out to temporary layout to capture IDs when records are normalized - will be denormalized, too
		temp_base_recs := PROJECT(pBaseFile,expand_C_rec_layout);		
		
		//assign a unique_id for NORMALIZE/DENORMALIZE
		ut.MAC_Sequence_Records(temp_base_recs,unique_id,temp_base_seq);

		expand_C_rec_layout tNormalizeProv(temp_base_seq L, UNSIGNED cnt) := TRANSFORM   
			SELF.unique_id						:= l.unique_id;
			SELF.prov_type						:= cnt;
			SELF.clean_fname					:= CHOOSE(cnt,L.clean_billing_name2_fname,L.clean_referring_name2_fname,L.clean_attending_name2_fname);
			SELF.clean_mname					:= CHOOSE(cnt,L.clean_billing_name2_mname,L.clean_referring_name2_mname,L.clean_attending_name2_mname);
			SELF.clean_lname					:= CHOOSE(cnt,L.clean_billing_name2_lname,L.clean_referring_name2_lname,L.clean_attending_name2_lname);
			SELF.clean_name_suffix		:= CHOOSE(cnt,L.clean_billing_name2_name_suffix,L.clean_referring_name2_name_suffix,L.clean_attending_name2_name_suffix);
			SELF.orig_full_name				:= CHOOSE(cnt,L.billing_name2,L.referring_name2,L.attending_name2);
			SELF.npi									:= CHOOSE(cnt,L.billing_npi,L.referring_npi,L.attending_npi);
			SELF := L;
			SELF := [];
		END;
   
		//NORMALIZE the records to populate the did for all providers
		dDidPrep	:= NORMALIZE(temp_base_seq,3,tNormalizeProv(LEFT,counter));
   
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
			DID, expand_c_rec_layout, TRUE, did_score,
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
			,expand_c_rec_layout
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
			,//group_key
			,npi
			,//UPIN
			,did
			,bdid
			,//SRC
			,//SOURCE_RID
			,result,FALSE,38
			);
	
		all_together	:= DISTRIBUTE(result + dWithout_name, HASH(unique_id));
		
	  //DENORMALIZE the records 
		temp_base_seq denormGiant(temp_base_seq l, all_together r) := TRANSFORM			
				SELF.billing2_bdid 							:= IF(r.prov_type = 1	,r.bdid,			l.billing2_bdid);
				SELF.referring2_bdid						:= IF(r.prov_type = 2	,r.bdid, 			l.referring2_bdid);
				SELF.attending2_bdid						:= IF(r.prov_type = 3	,r.bdid, 			l.attending2_bdid);
				SELF.billing2_bdid_score 				:= IF(r.prov_type = 1	,r.bdid_score,l.billing2_bdid_score);
				SELF.referring2_bdid_score			:= IF(r.prov_type = 2	,r.bdid_score,l.referring2_bdid_score);
				SELF.attending2_bdid_score			:= IF(r.prov_type = 3	,r.bdid_score,l.attending2_bdid_score);
				SELF.billing_name2_did 					:= IF(r.prov_type = 1	,r.did,				l.billing_name2_did);
				SELF.referring_name2_did				:= IF(r.prov_type = 2	,r.did, 			l.referring_name2_did);
				SELF.attending_name2_did				:= IF(r.prov_type = 3	,r.did, 			l.attending_name2_did);
				SELF.billing_name2_did_score 		:= IF(r.prov_type = 1	,r.did_score,	l.billing_name2_did_score);
				SELF.referring_name2_did_score	:= IF(r.prov_type = 2	,r.did_score, l.referring_name2_did_score);
				SELF.attending_name2_did_score	:= IF(r.prov_type = 3	,r.did_score, l.attending_name2_did_score);		
				SELF.billing2_lnpid							:= IF(r.prov_type = 1 ,r.lnpid,			l.billing2_lnpid);
				SELF.referring2_lnpid						:= IF(r.prov_type = 2 ,r.lnpid,			l.referring2_lnpid);
				SELF.attending2_lnpid						:= IF(r.prov_type = 3 ,r.lnpid,			l.attending2_lnpid);
				SELF.billing_name2_best_dob			:= IF(r.prov_type = 1 ,r.best_dob,	l.billing_name2_best_dob);
				SELF.referring_name2_best_dob		:= IF(r.prov_type = 2 ,r.best_dob,	l.referring_name2_best_dob);
				SELF.attending_name2_best_dob		:= IF(r.prov_type = 3 ,r.best_dob,	l.attending_name2_best_dob);
				SELF.billing_name2_best_ssn			:= IF(r.prov_type = 1 ,r.best_ssn,	l.billing_name2_best_ssn);
				SELF.referring_name2_best_ssn		:= IF(r.prov_type = 2 ,r.best_ssn,	l.referring_name2_best_ssn);
				SELF.attending_name2_best_ssn		:= IF(r.prov_type = 3 ,r.best_ssn,	l.attending_name2_best_ssn);
				SELF            := l;
		END;
	   
	  denormRecs :=  DENORMALIZE(temp_base_seq,all_together,
								  LEFT.unique_id = RIGHT.unique_id,
								  denormGiant(LEFT,RIGHT), LOCAL);
								         
		final_file	:= PROJECT(denormRecs, Emdeon.layouts.base.c_record);
		RETURN final_file;
	END;

	EXPORT D_records(DATASET(Emdeon.Layouts.Base.D_record)	pBaseFile) := FUNCTION

		expand_D_rec_layout	:= RECORD
			UNSIGNED8			unique_id :=0;
			UNSIGNED4			prov_type :=0;
			Emdeon.Layouts.base.d_record;
			STRING20			clean_fname	:= '';
			STRING20 			clean_mname	:= '';
			STRING20 			clean_lname	:= '';
			STRING5  			clean_name_suffix	:= '';
			STRING65			prep_full_name	:= '';
			UNSIGNED4			best_dob	:= 0;
			STRING9				best_ssn	:= '';
			STRING10			npi	:= '';
			STRING20			state_lic	:= '';
			STRING6				upin	:= '';
			UNSIGNED6			bdid	:= 0;
			UNSIGNED1			bdid_score	:= 0;
			UNSIGNED6			did	:= 0;
			UNSIGNED1			did_score		:= 0;
			UNSIGNED8	 		lnpid	:= 0;		
			UNSIGNED1			zero	:= 0;
		END;
		
		//PROJECT out to temporary layout to capture IDs when records are normalized - will be denormalized, too
		temp_base_recs := PROJECT(pBaseFile,expand_D_rec_layout);		
		
		//assign a unique_id for NORMALIZE/DENORMALIZE
		ut.MAC_Sequence_Records(temp_base_recs,unique_id,temp_base_seq);

		expand_D_rec_layout tNormalizeProv(temp_base_seq L, UNSIGNED cnt) := TRANSFORM   
			SELF.unique_id						:= l.unique_id;
			SELF.prov_type						:= cnt;
			SELF.clean_fname					:= CHOOSE(cnt,L.clean_supervising_prov_fname,L.clean_operating_prov_fname,L.clean_other_operating_prov_fname);
			SELF.clean_mname					:= CHOOSE(cnt,L.clean_supervising_prov_mname,L.clean_operating_prov_mname,L.clean_other_operating_prov_mname);
			SELF.clean_lname					:= CHOOSE(cnt,L.clean_supervising_prov_lname,L.clean_operating_prov_lname,L.clean_other_operating_prov_lname);
			SELF.clean_name_suffix		:= CHOOSE(cnt,L.clean_supervising_prov_name_suffix,L.clean_operating_prov_name_suffix,L.clean_other_operating_prov_name_suffix);
			SELF.prep_full_name				:= CHOOSE(cnt,L.clean_supervising_prov_fname + IF(l.clean_supervising_prov_mname <> '', ' ' + l.clean_supervising_prov_mname + ' ', ' ')
																						+ L.clean_supervising_prov_lname,
																						  L.clean_operating_prov_fname   + IF(l.clean_operating_prov_mname <> '', ' ' + l.clean_operating_prov_mname + ' ', ' ')
																						+ L.clean_operating_prov_lname,
																						  L.clean_other_operating_prov_fname + IF(l.clean_other_operating_prov_fname<>'',' '+l.clean_other_operating_prov_mname+' ',' ')
																						+ L.clean_other_operating_prov_lname);
			SELF.npi									:= CHOOSE(cnt,L.supervising_prov_npi,L.operating_prov_npi,L.other_operating_prov_npi);
			SELF.state_lic						:= CHOOSE(cnt,L.supervising_prov_state_lic,L.operating_prov_state_lic,L.other_operating_prov_state_lic);
			SELF.upin									:= CHOOSE(cnt,L.supervising_prov_upin,L.operating_prov_upin,L.other_operating_prov_upin);
			SELF := L;
			SELF := [];
		END;
   
		//NORMALIZE the records to populate the did for all providers
		dDidPrep	:= NORMALIZE(temp_base_seq,3,tNormalizeProv(LEFT,counter));
   
		HasName	:=	((TRIM(dDidPrep.clean_lname,LEFT,RIGHT) != '')	AND (TRIM(dDidPrep.clean_fname,LEFT,RIGHT)	!= ''));
										
		dWith_name				:= dDidPrep(HasName);
		dWithout_name	    := dDidPrep(not(HasName));
   		
		//DID
		//we only have the pay_to address (pay_to_plan would be a company, not using here), but trying to push all individuals through DID with that address
		matchset := ['A'];
		did_add.MAC_Match_Flex
			(dWith_name, matchset,					
			foo, foo, clean_fname, clean_mname, clean_lname, clean_name_suffix, 
			clean_pay_to_prim_range, clean_pay_to_prim_name, clean_pay_to_sec_range, clean_pay_to_zip, clean_pay_to_st, '', 
			DID, expand_d_rec_layout, TRUE, did_score,
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
			,clean_pay_to_prim_range
			,clean_pay_to_prim_name
			,clean_pay_to_zip
			,clean_pay_to_sec_range
			,clean_pay_to_st
			,foo
			,foo
			,bdid
			,expand_d_rec_layout
			,TRUE
			,bdid_score
			,d_bdid
			,
			,
			,
			,BIPV2.xlink_version_set
			,
			,
			,clean_pay_to_p_city_name
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
			,clean_pay_to_prim_range
			,clean_pay_to_prim_name
			,clean_pay_to_sec_range
			,clean_pay_to_p_city_name
			,clean_pay_to_st
			,clean_pay_to_zip
			,best_ssn
			,best_dob
			,
			,
			,state_lic
			,//TAX_ID
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
		
	  //DENORMALIZE the records 
		temp_base_seq denormGiant(temp_base_seq l, all_together r) := TRANSFORM			
				SELF.supervising_prov_bdid 						:= IF(r.prov_type = 1	,r.bdid,			l.supervising_prov_bdid);
				SELF.operating_prov_bdid							:= IF(r.prov_type = 2	,r.bdid, 			l.operating_prov_bdid);
				SELF.other_operating_prov_bdid				:= IF(r.prov_type = 3	,r.bdid, 			l.other_operating_prov_bdid);
				SELF.supervising_prov_bdid_score 			:= IF(r.prov_type = 1	,r.bdid_score,l.supervising_prov_bdid_score);
				SELF.operating_prov_bdid_score				:= IF(r.prov_type = 2	,r.bdid_score,l.operating_prov_bdid_score);
				SELF.other_operating_prov_bdid_score	:= IF(r.prov_type = 3	,r.bdid_score,l.other_operating_prov_bdid_score);
				SELF.supervising_prov_did 						:= IF(r.prov_type = 1	,r.did,				l.supervising_prov_did);
				SELF.operating_prov_did								:= IF(r.prov_type = 2	,r.did, 			l.operating_prov_did);
				SELF.other_operating_prov_did					:= IF(r.prov_type = 3	,r.did, 			l.other_operating_prov_did);
				SELF.supervising_prov_did_score 			:= IF(r.prov_type = 1	,r.did_score,	l.supervising_prov_did_score);
				SELF.operating_prov_did_score					:= IF(r.prov_type = 2	,r.did_score, l.operating_prov_did_score);
				SELF.other_operating_prov_did_score		:= IF(r.prov_type = 3	,r.did_score, l.other_operating_prov_did_score);		
				SELF.supervising_prov_lnpid						:= IF(r.prov_type = 1 ,r.lnpid,			l.supervising_prov_lnpid);
				SELF.operating_prov_lnpid							:= IF(r.prov_type = 2 ,r.lnpid,			l.operating_prov_lnpid);
				SELF.other_operating_prov_lnpid				:= IF(r.prov_type = 3 ,r.lnpid,			l.other_operating_prov_lnpid);
				SELF.supervising_prov_best_dob				:= IF(r.prov_type = 1 ,r.best_dob,	l.supervising_prov_best_dob);
				SELF.operating_prov_best_dob					:= IF(r.prov_type = 2 ,r.best_dob,	l.operating_prov_best_dob);
				SELF.other_operating_prov_best_dob		:= IF(r.prov_type = 3 ,r.best_dob,	l.other_operating_prov_best_dob);
				SELF.supervising_prov_best_ssn				:= IF(r.prov_type = 1 ,r.best_ssn,	l.supervising_prov_best_ssn);
				SELF.operating_prov_best_ssn					:= IF(r.prov_type = 2 ,r.best_ssn,	l.operating_prov_best_ssn);
				SELF.other_operating_prov_best_ssn		:= IF(r.prov_type = 3 ,r.best_ssn,	l.other_operating_prov_best_ssn);
				SELF            := l;
		END;
	   
	  denormRecs :=  DENORMALIZE(temp_base_seq,all_together,
								  LEFT.unique_id = RIGHT.unique_id,
								  denormGiant(LEFT,RIGHT), LOCAL);
								         
		final_file	:= PROJECT(denormRecs, Emdeon.layouts.base.d_record);
		RETURN final_file;
	END;

END;

