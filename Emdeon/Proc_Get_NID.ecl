IMPORT lib_fileservices, _control, lib_stringlib, _Validate, NID, did_add, ut, Address, emdeon;

trimUpper(STRING s) := FUNCTION
			RETURN TRIM(stringlib.StringToUppercase(s),LEFT,RIGHT);
			END;  

EXPORT Proc_Get_NID	:= MODULE

	EXPORT C_records(DATASET(emdeon.Layouts.Base.C_record)	pBaseFile) := FUNCTION

		expand_C_rec_layout	:= RECORD
			UNSIGNED8			unique_id :=0;
			UNSIGNED4			name_type :=0;
			emdeon.Layouts.base.c_record;
			emdeon.Layouts.base.clean_name clean_name;
			STRING35		append_prep_name;
			UNSIGNED1	zero	:= 0;
		END;

		//expand layout for normalize/denormalize cleaned names
		expand_C_rec_layout expand_rec(pBaseFile L) := TRANSFORM
			SELF := L;
			SELF := [];
		END;

		temp_base_recs := PROJECT(pBaseFile,expand_rec(LEFT));	

		//assign a unique_id for normalize/denormalize
		ut.MAC_Sequence_Records(temp_base_recs,unique_id,temp_base_seq);

		expand_C_rec_layout tNormalizeName(temp_base_seq L, UNSIGNED cnt) := TRANSFORM   
			SELF.unique_id						 		:= l.unique_id;
			SELF.name_type			 					:= cnt;
			SELF.Append_Prep_Name					:= CHOOSE(cnt,L.billing_name2,L.referring_name2,L.attending_name2);
			SELF := L;
			SELF := [];
		END;

		//normalize the records to populate the name information for all names
		dNamePrep	:= NORMALIZE(temp_base_seq,3,tNormalizeName(LEFT,counter));

		HasName	:=	TRIM(dNamePrep.Append_Prep_Name,LEFT,RIGHT)    != '' ;

		dWith_name				:= dNamePrep(HasName);
		dWithout_name	    := dNamePrep(not(HasName));

		NID.Mac_CleanFullNames(dWith_name,   cleanNames
														, Append_Prep_Name
														, includeInRepository:=FALSE, normalizeDualNames:=TRUE);

		setValidSuffix:=['JR','SR','I','II','III','IV','V','VI','VII','VIII','IX'];
		STRING fGetSuffix(STRING SuffixIn)	:=		MAP(SuffixIn = '1' => 'I'
																							,SuffixIn IN ['2','ND'] => 'II'
																							,SuffixIn IN ['3','RD'] => 'III'
																							,SuffixIn = '4' => 'IV'
																							,SuffixIn = '5' => 'V'
																							,SuffixIn = '6' => 'VI'
																							,SuffixIn = '7' => 'VII'
																							,SuffixIn = '8' => 'VIII'
																							,SuffixIn = '9' => 'IX'
																							,SuffixIn IN setValidSuffix => SuffixIn
																							,'');

		expand_C_rec_layout tr(cleanNames L) := TRANSFORM
			SELF.clean_name.title 							:= IF(l.nameType='P' AND L.cln_title IN ['MR','MS'], L.cln_title, '');
			SELF.clean_name.fname 							:= IF(l.nameType='P',L.cln_fname,'');
			SELF.clean_name.mname 							:= IF(l.nameType='P',L.cln_mname,'');
			SELF.clean_name.lname 							:= IF(l.nameType='P',L.cln_lname,'');
			SELF.clean_name.name_suffix 				:= IF(l.nameType='P',fGetSuffix(L.cln_suffix),'');
			SELF            	:= L;
		END;
		dNameAppended	:= PROJECT(cleanNames,tr(LEFT));

	  all_name := DISTRIBUTE(dNameAppended + dWithout_name, HASH(unique_id));

	  //denormalize the records 
		temp_base_seq denormNID(temp_base_seq l, all_name r) := TRANSFORM			
				SELF.clean_company_billing1										:= ut.CleanCompany(l.billing_name1);
				SELF.clean_company_referring1									:= ut.CleanCompany(l.referring_name1);
				SELF.clean_company_attending1									:= ut.CleanCompany(l.attending_name1);
				SELF.clean_company_facility1									:= ut.CleanCompany(l.facility_name1);
				SELF.clean_company_facility2									:= ut.CleanCompany(l.facility_name2);
				SELF.clean_billing_name2_title 								:= IF(r.name_type = 1 ,r.clean_name.title, 							l.clean_billing_name2_title);
				SELF.clean_billing_name2_fname								:= IF(r.name_type = 1	,r.clean_name.fname, 							l.clean_billing_name2_fname);
				SELF.clean_billing_name2_mname								:= IF(r.name_type = 1	,r.Clean_name.mname, 							l.clean_billing_name2_mname);
				SELF.clean_billing_name2_lname								:= IF(r.name_type = 1	,r.Clean_name.lname, 							l.clean_billing_name2_lname);
				SELF.clean_billing_name2_name_suffix					:= IF(r.name_type = 1	,r.Clean_name.name_suffix,				l.clean_billing_name2_name_suffix);
				SELF.clean_billing_name2_name_type						:= IF(r.name_type = 1	,r.Clean_name.name_type,					l.clean_billing_name2_name_type);
				SELF.clean_billing_name2_nid									:= IF(r.name_type = 1	,r.Clean_name.nid,								l.clean_billing_name2_nid);			
				SELF.clean_referring_name2_title 							:= IF(r.name_type = 2, r.clean_name.title, 							l.clean_referring_name2_title);
				SELF.clean_referring_name2_fname							:= IF(r.name_type = 2	,r.clean_name.fname, 							l.clean_referring_name2_fname);
				SELF.clean_referring_name2_mname							:= IF(r.name_type = 2	,r.Clean_name.mname, 							l.clean_referring_name2_mname);
				SELF.clean_referring_name2_lname							:= IF(r.name_type = 2	,r.Clean_name.lname, 							l.clean_referring_name2_lname);
				SELF.clean_referring_name2_name_suffix				:= IF(r.name_type = 2	,r.Clean_name.name_suffix,				l.clean_referring_name2_name_suffix);
				SELF.clean_referring_name2_name_type					:= IF(r.name_type = 2	,r.Clean_name.name_type,					l.clean_referring_name2_name_type);
				SELF.clean_referring_name2_nid								:= IF(r.name_type = 2	,r.Clean_name.nid,								l.clean_referring_name2_nid);
				SELF.clean_attending_name2_title 							:= IF(r.name_type = 3 ,r.clean_name.title, 							l.clean_attending_name2_title);
				SELF.clean_attending_name2_fname							:= IF(r.name_type = 3	,r.clean_name.fname, 							l.clean_attending_name2_fname);
				SELF.clean_attending_name2_mname							:= IF(r.name_type = 3	,r.Clean_name.mname, 							l.clean_attending_name2_mname);
				SELF.clean_attending_name2_lname							:= IF(r.name_type = 3	,r.Clean_name.lname, 							l.clean_attending_name2_lname);
				SELF.clean_attending_name2_name_suffix				:= IF(r.name_type = 3	,r.Clean_name.name_suffix,				l.clean_attending_name2_name_suffix);
				SELF.clean_attending_name2_name_type					:= IF(r.name_type = 3	,r.Clean_name.name_type,					l.clean_attending_name2_name_type);
				SELF.clean_attending_name2_nid								:= IF(r.name_type = 3	,r.Clean_name.nid,								l.clean_attending_name2_nid);			
				SELF            := l;
		END;

	  denormRecs :=  DENORMALIZE(temp_base_seq,all_name,
								  LEFT.unique_id = RIGHT.unique_id,
								  denormNID(LEFT,RIGHT), LOCAL);

		final_file	:= PROJECT(denormRecs, emdeon.layouts.base.c_record); 
		RETURN final_file;
	END;

	EXPORT D_records(DATASET(emdeon.Layouts.Base.D_record)	pBaseFile) := FUNCTION

		expand_D_rec_layout	:= RECORD
			UNSIGNED8			unique_id :=0;
			UNSIGNED4			name_type :=0;
			emdeon.Layouts.base.D_record;
			emdeon.Layouts.base.clean_name clean_name;
			STRING20		append_fname;
			STRING20		append_mname;
			STRING20		append_lname;
			STRING20		append_suffix	:= '';
			UNSIGNED1	zero	:= 0;
		END;

		//expand the layout for normalize/denormalize name fields
		expand_D_rec_layout expand_rec(pBaseFile L) := TRANSFORM
			SELF := L;
			SELF := [];
		END;

		temp_base_recs := PROJECT(pBaseFile,expand_rec(LEFT));		

		//assign a unique_id for normalize/denormalize
		ut.MAC_Sequence_Records(temp_base_recs,unique_id,temp_base_seq);

		expand_D_rec_layout tNormalizeName(temp_base_seq L, UNSIGNED cnt) := TRANSFORM   
			SELF.unique_id				:= l.unique_id;
			SELF.name_type				:= cnt;
			SELF.append_fname			:= CHOOSE(cnt,L.supervising_prov_first_name,	L.operating_prov_first_name,	L.other_operating_prov_first_name);
			SELF.append_mname			:= CHOOSE(cnt,L.supervising_prov_middle_name,	L.operating_prov_middle_name,	L.other_operating_prov_middle_name);
			SELF.append_lname			:= CHOOSE(cnt,L.supervising_prov_last_name,		L.operating_prov_last_name,		L.other_operating_prov_last_name);
			SELF := L;
			SELF := [];
		END;

		//normalize the records to populate the name information for all names
		dNamePrep	:= NORMALIZE(temp_base_seq,3,tNormalizeName(LEFT,counter));

		HasName	:=	(TRIM(dNamePrep.Append_lname,LEFT,RIGHT)!= '' AND TRIM(dNamePrep.append_fname,LEFT,RIGHT)!= '');

		dWith_name				:= dNamePrep(HasName);
		dWithout_name	    := dNamePrep(not(HasName));

		NID.Mac_CleanParsedNames(dWith_name, cleanNames
														, firstname:=append_fname,middlename:=append_mname,lastname:=append_lname, namesuffix:=append_suffix
														, includeInRepository:=FALSE, normalizeDualNames:=FALSE
													);	

		setValidSuffix:=['JR','SR','I','II','III','IV','V','VI','VII','VIII','IX'];
		STRING fGetSuffix(STRING SuffixIn)	:=		MAP(SuffixIn = '1' => 'I'
																							,SuffixIn IN ['2','ND'] => 'II'
																							,SuffixIn IN ['3','RD'] => 'III'
																							,SuffixIn = '4' => 'IV'
																							,SuffixIn = '5' => 'V'
																							,SuffixIn = '6' => 'VI'
																							,SuffixIn = '7' => 'VII'
																							,SuffixIn = '8' => 'VIII'
																							,SuffixIn = '9' => 'IX'
																							,SuffixIn IN setValidSuffix => SuffixIn
																							,'');

		expand_D_rec_layout tr(cleanNames L) := TRANSFORM
			SELF.clean_name.title 							:= IF(l.nameType='P' AND L.cln_title IN ['MR','MS'], L.cln_title, '');
			SELF.clean_name.fname 							:= IF(l.nameType='P',L.cln_fname,'');
			SELF.clean_name.mname 							:= IF(l.nameType='P',L.cln_mname,'');
			SELF.clean_name.lname 							:= IF(l.nameType='P',L.cln_lname,'');
			SELF.clean_name.name_suffix 				:= IF(l.nameType='P',fGetSuffix(L.cln_suffix),'');
			SELF            	:= L;
		END;
		dNameAppended	:= PROJECT(cleanNames,tr(LEFT));

		all_together	:= DISTRIBUTE(dNameAppended + dWithout_name, HASH(unique_id));

	  //denormalize the records 
		temp_base_seq denormNID(temp_base_seq l, all_together r) := TRANSFORM			
				SELF.clean_company_supervising							:= ut.CleanCompany(l.supervising_prov_org_name);
				SELF.clean_company_operating								:= ut.CleanCompany(l.operating_prov_org_name);
				SELF.clean_company_other_operating					:= ut.CleanCompany(l.other_operating_prov_org_name);
				SELF.clean_company_pay_to_plan_name					:= ut.CleanCompany(l.pay_to_plan_name);
				SELF.clean_supervising_prov_title 					:= IF(r.name_type = 1 ,r.clean_name.title, 							l.clean_supervising_prov_title);
				SELF.clean_supervising_prov_fname						:= IF(r.name_type = 1	,r.clean_name.fname, 							l.clean_supervising_prov_fname);
				SELF.clean_supervising_prov_mname						:= IF(r.name_type = 1	,r.Clean_name.mname, 							l.clean_supervising_prov_mname);
				SELF.clean_supervising_prov_lname						:= IF(r.name_type = 1	,r.Clean_name.lname, 							l.clean_supervising_prov_lname);
				SELF.clean_supervising_prov_name_suffix			:= IF(r.name_type = 1	,r.Clean_name.name_suffix,				l.clean_supervising_prov_name_suffix);
				SELF.clean_supervising_prov_name_type				:= IF(r.name_type = 1	,r.Clean_name.name_type,					l.clean_supervising_prov_name_type);
				SELF.clean_supervising_prov_nid							:= IF(r.name_type = 1	,r.Clean_name.nid,								l.clean_supervising_prov_nid);			
				SELF.clean_operating_prov_title 						:= IF(r.name_type = 2, r.clean_name.title, 							l.clean_operating_prov_title);
				SELF.clean_operating_prov_fname							:= IF(r.name_type = 2	,r.clean_name.fname, 							l.clean_operating_prov_fname);
				SELF.clean_operating_prov_mname							:= IF(r.name_type = 2	,r.Clean_name.mname, 							l.clean_operating_prov_mname);
				SELF.clean_operating_prov_lname							:= IF(r.name_type = 2	,r.Clean_name.lname, 							l.clean_operating_prov_lname);
				SELF.clean_operating_prov_name_suffix				:= IF(r.name_type = 2	,r.Clean_name.name_suffix,				l.clean_operating_prov_name_suffix);
				SELF.clean_operating_prov_name_type					:= IF(r.name_type = 2	,r.Clean_name.name_type,					l.clean_operating_prov_name_type);
				SELF.clean_operating_prov_nid								:= IF(r.name_type = 2	,r.Clean_name.nid,								l.clean_operating_prov_nid);
				SELF.clean_other_operating_prov_title 			:= IF(r.name_type = 3 ,r.clean_name.title, 							l.clean_other_operating_prov_title);
				SELF.clean_other_operating_prov_fname				:= IF(r.name_type = 3	,r.clean_name.fname, 							l.clean_other_operating_prov_fname);
				SELF.clean_other_operating_prov_mname				:= IF(r.name_type = 3	,r.Clean_name.mname, 							l.clean_other_operating_prov_mname);
				SELF.clean_other_operating_prov_lname				:= IF(r.name_type = 3	,r.Clean_name.lname, 							l.clean_other_operating_prov_lname);
				SELF.clean_other_operating_prov_name_suffix	:= IF(r.name_type = 3	,r.Clean_name.name_suffix,				l.clean_other_operating_prov_name_suffix);
				SELF.clean_other_operating_prov_name_type		:= IF(r.name_type = 3	,r.Clean_name.name_type,					l.clean_other_operating_prov_name_type);
				SELF.clean_other_operating_prov_nid					:= IF(r.name_type = 3	,r.Clean_name.nid,								l.clean_other_operating_prov_nid);			
				SELF            := l;
		END;

	  denormRecs :=  DENORMALIZE(temp_base_seq,all_together,
								  LEFT.unique_id = RIGHT.unique_id,
								  denormNID(LEFT,RIGHT),LOCAL);

		final_file	:= PROJECT(denormRecs, emdeon.layouts.base.d_record);
		RETURN final_file;
	END;

END;
	   