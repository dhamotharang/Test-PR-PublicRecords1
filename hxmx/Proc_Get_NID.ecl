IMPORT lib_fileservices, _control, lib_stringlib, _Validate, NID, did_add, ut, address, hxmx;

trimUpper(STRING s) := FUNCTION
			RETURN TRIM(stringlib.StringToUppercase(s),LEFT,RIGHT);
			END;  

EXPORT Proc_Get_NID	:= MODULE

	EXPORT hx_records(DATASET(hxmx.Layouts.Base.hx_record)	pBaseFile) := FUNCTION

		expand_hx_rec_layout	:= RECORD
			UNSIGNED8			unique_id :=0;
			UNSIGNED4			name_type :=0;
			hxmx.Layouts.base.hx_record;
			hxmx.Layouts.base.clean_name clean_name;
			STRING35		append_prep_name;
		END;

		//expand layout for normalize/denormalize cleaned names
		expand_hx_rec_layout expand_rec(pBaseFile L) := TRANSFORM
			SELF := L;
			SELF := [];
		END;

		temp_base_recs := PROJECT(pBaseFile,expand_rec(LEFT));	

		//assign a unique_id for normalize/denormalize
		ut.MAC_Sequence_Records(temp_base_recs,unique_id,temp_base_seq);

		expand_hx_rec_layout tNormalizeName(temp_base_seq L, UNSIGNED cnt) := TRANSFORM   
			SELF.unique_id						 		:= l.unique_id;
			SELF.name_type			 					:= cnt;
			SELF.Append_Prep_Name					:= CHOOSE(cnt,L.attend_prov_name,L.operating_prov_name,L.other_prov_name1,L.other_prov_name2);
			SELF := L;
			SELF := [];
		END;

		//normalize the records to populate the name information for all names
		dNamePrep	:= NORMALIZE(temp_base_seq,4,tNormalizeName(LEFT,counter));

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

		expand_hx_rec_layout tr(cleanNames L) := TRANSFORM
			SELF.clean_name.title 							:= IF(l.nameType='P' AND L.cln_title IN ['MR','MS'], L.cln_title, '');
			SELF.clean_name.fname 							:= IF(l.nameType='P' AND ut.isNumeric(L.cln_fname) = FALSE ,L.cln_fname,'');
			SELF.clean_name.mname 							:= IF(l.nameType='P' AND ut.isNumeric(L.cln_mname) = FALSE ,L.cln_mname,'');
			SELF.clean_name.lname 							:= IF(l.nameType='P' AND ut.isNumeric(L.cln_lname) = FALSE ,L.cln_lname,'');
			SELF.clean_name.name_suffix 				:= IF(l.nameType='P',fGetSuffix(L.cln_suffix),'');
			SELF            	:= L;
		END;
		dNameAppended	:= PROJECT(cleanNames,tr(LEFT));
		ut.mac_flipnames(dNameAppended,clean_name.fname,clean_name.mname,clean_name.lname,dNameFlipped);

	  all_name := DISTRIBUTE(dNameFlipped + dWithout_name, HASH(unique_id));

	  //denormalize the records 
		temp_base_seq denormNID(temp_base_seq l, all_name r) := TRANSFORM			
				SELF.clean_billing_company_name					:= ut.CleanCompany(l.billing_org_name);
				SELF.clean_attending_prov_title 				:= IF(r.name_type = 1 ,r.clean_name.title, 							l.clean_attending_prov_title);
				SELF.clean_attending_prov_fname					:= IF(r.name_type = 1	,r.clean_name.fname, 							l.clean_attending_prov_fname);
				SELF.clean_attending_prov_mname					:= IF(r.name_type = 1	,r.Clean_name.mname, 							l.clean_attending_prov_mname);
				SELF.clean_attending_prov_lname					:= IF(r.name_type = 1	,r.Clean_name.lname, 							l.clean_attending_prov_lname);
				SELF.clean_attending_prov_name_suffix		:= IF(r.name_type = 1	,r.Clean_name.name_suffix,				l.clean_attending_prov_name_suffix);
				SELF.clean_attending_prov_name_type			:= IF(r.name_type = 1	,r.Clean_name.name_type,					l.clean_attending_prov_name_type);
				SELF.clean_attending_prov_nid						:= IF(r.name_type = 1	,r.Clean_name.nid,								l.clean_attending_prov_nid);			
				SELF.clean_operating_prov_title 				:= IF(r.name_type = 2, r.clean_name.title, 							l.clean_operating_prov_title);
				SELF.clean_operating_prov_fname					:= IF(r.name_type = 2	,r.clean_name.fname, 							l.clean_operating_prov_fname);
				SELF.clean_operating_prov_mname					:= IF(r.name_type = 2	,r.Clean_name.mname, 							l.clean_operating_prov_mname);
				SELF.clean_operating_prov_lname					:= IF(r.name_type = 2	,r.Clean_name.lname, 							l.clean_operating_prov_lname);
				SELF.clean_operating_prov_name_suffix		:= IF(r.name_type = 2	,r.Clean_name.name_suffix,				l.clean_operating_prov_name_suffix);
				SELF.clean_operating_prov_name_type			:= IF(r.name_type = 2	,r.Clean_name.name_type,					l.clean_operating_prov_name_type);
				SELF.clean_operating_prov_nid						:= IF(r.name_type = 2	,r.Clean_name.nid,								l.clean_operating_prov_nid);
				SELF.clean_other_prov1_title 						:= IF(r.name_type = 3 ,r.clean_name.title, 							l.clean_other_prov1_title);
				SELF.clean_other_prov1_fname						:= IF(r.name_type = 3	,r.clean_name.fname, 							l.clean_other_prov1_fname);
				SELF.clean_other_prov1_mname						:= IF(r.name_type = 3	,r.Clean_name.mname, 							l.clean_other_prov1_mname);
				SELF.clean_other_prov1_lname						:= IF(r.name_type = 3	,r.Clean_name.lname, 							l.clean_other_prov1_lname);
				SELF.clean_other_prov1_name_suffix			:= IF(r.name_type = 3	,r.Clean_name.name_suffix,				l.clean_other_prov1_name_suffix);
				SELF.clean_other_prov1_name_type				:= IF(r.name_type = 3	,r.Clean_name.name_type,					l.clean_other_prov1_name_type);
				SELF.clean_other_prov1_nid							:= IF(r.name_type = 3	,r.Clean_name.nid,								l.clean_other_prov1_nid);			
				SELF.clean_other_prov2_title 						:= IF(r.name_type = 4, r.clean_name.title, 							l.clean_other_prov2_title);
				SELF.clean_other_prov2_fname						:= IF(r.name_type = 4	,r.clean_name.fname, 							l.clean_other_prov2_fname);
				SELF.clean_other_prov2_mname						:= IF(r.name_type = 4	,r.Clean_name.mname, 							l.clean_other_prov2_mname);
				SELF.clean_other_prov2_lname						:= IF(r.name_type = 4	,r.Clean_name.lname, 							l.clean_other_prov2_lname);
				SELF.clean_other_prov2_name_suffix			:= IF(r.name_type = 4	,r.Clean_name.name_suffix,				l.clean_other_prov2_name_suffix);
				SELF.clean_other_prov2_name_type				:= IF(r.name_type = 4	,r.Clean_name.name_type,					l.clean_other_prov2_name_type);
				SELF.clean_other_prov2_nid							:= IF(r.name_type = 4	,r.Clean_name.nid,								l.clean_other_prov2_nid);	
				SELF            := l;
		END;

	  denormRecs :=  DENORMALIZE(temp_base_seq,all_name,
								  LEFT.unique_id = RIGHT.unique_id,
								  denormNID(LEFT,RIGHT), LOCAL);

		final_file	:= PROJECT(denormRecs, hxmx.layouts.base.hx_record); 
		RETURN final_file;
	END;

	EXPORT mx_records(DATASET(hxmx.Layouts.Base.mx_record)	pBaseFile) := FUNCTION

		expand_mx_rec_layout	:= RECORD
			UNSIGNED8			unique_id :=0;
			UNSIGNED4			name_type :=0;
			hxmx.Layouts.base.mx_record;
			hxmx.Layouts.base.clean_name clean_name;
			STRING20		append_fname;
			STRING20		append_mname;
			STRING20		append_lname;
			STRING20		append_suffix	:= '';
		END;

		//expand the layout for normalize/denormalize name fields
		expand_mx_rec_layout expand_rec(pBaseFile L) := TRANSFORM
			SELF := L;
			SELF := [];
		END;

		temp_base_recs := PROJECT(pBaseFile,expand_rec(LEFT));		

		//assign a unique_id for normalize/denormalize
		ut.MAC_Sequence_Records(temp_base_recs,unique_id,temp_base_seq);

		expand_mx_rec_layout tNormalizeName(temp_base_seq L, UNSIGNED cnt) := TRANSFORM   
			SELF.unique_id				:= l.unique_id;
			SELF.name_type				:= cnt;
			SELF.append_fname			:= CHOOSE(cnt,L.billing_first_name,L.emt_paramedic_first_name,	L.ordering_prov_first_name,	L.pay_to_first_name,	
																					L.purch_service_first_name,	L.ref_prov_first_name,	L.render_prov_first_name,	
																					L.serv_line_ref_prov_first_name,L.serv_line_render_prov_first_name,
																					L.serv_line_supervising_prov_first_name,	L.supervising_prov_first_name);
			SELF.append_mname			:= CHOOSE(cnt,L.billing_middle_name,L.emt_paramedic_middle_name,L.ordering_prov_middle_name,L.pay_to_middle_name,
																					L.purch_service_middle_name,L.ref_prov_middle_name,	L.render_prov_middle_name,
																					L.serv_line_ref_prov_middle_name,	L.serv_line_render_prov_middle_name, 
																					L.serv_line_supervising_prov_middle_name,	L.supervising_prov_middle_name);
			SELF.append_lname			:= CHOOSE(cnt,L.billing_last_name,L.emt_paramedic_last_name,	L.ordering_prov_last_name,	L.pay_to_last_name,	
																					L.purch_service_last_name,	L.ref_prov_last_name,		L.render_prov_last_name,	
																					L.serv_line_ref_prov_last_name, L.serv_line_render_prov_last_name, 
																					L.serv_line_supervising_prov_last_name,	L.supervising_prov_last_name);
			SELF := L;
			SELF := [];
		END;

		//normalize the records to populate the name information for all names
		dNamePrep	:= NORMALIZE(temp_base_seq,11,tNormalizeName(LEFT,counter));

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

		expand_mx_rec_layout tr(cleanNames L) := TRANSFORM
			SELF.clean_name.title 							:= IF(l.nameType='P' AND L.cln_title IN ['MR','MS'], L.cln_title, '');
			SELF.clean_name.fname 							:= IF(l.nameType='P',L.cln_fname,'');
			SELF.clean_name.mname 							:= IF(l.nameType='P',L.cln_mname,'');
			SELF.clean_name.lname 							:= IF(l.nameType='P',L.cln_lname,'');
			SELF.clean_name.name_suffix 				:= IF(l.nameType='P',fGetSuffix(L.cln_suffix),'');
			SELF.clean_name.nid									:= IF(l.nameType='P',L.nid,0);
			SELF            	:= L;
		END;
		dNameAppended	:= PROJECT(cleanNames,tr(LEFT));

		still_blank	:= dNameAppended(clean_name.fname = '' AND clean_name.lname = '');

		full_name_append	:= RECORD
			expand_mx_rec_layout;
			STRING80 full_name := '';
		END;

		full_name_append fix_name(still_blank L) := TRANSFORM
			SELF.full_name	:= Stringlib.StringCleanSpaces(StringLib.StringToUpperCase(StringLib.StringFilterOut
												(L.append_fname + L.append_mname + L.append_lname,'0123456789-&#.^!$+<>@=%?*\'')  + L.append_suffix));
			SELF := L;
			SELF := [];
		END;

		full_name_in_lname	:= PROJECT(still_blank, fix_name(LEFT));

		NID.Mac_CleanFullNames(full_name_in_lname,   cleanNames2
														, full_name
														, includeInRepository:=FALSE, normalizeDualNames:=TRUE);

		expand_mx_rec_layout tr2(cleanNames2 L) := TRANSFORM
			SELF.clean_name.title 							:= IF(l.nameType='P' AND L.cln_title IN ['MR','MS'], L.cln_title, '');
			SELF.clean_name.fname 							:= IF(l.nameType='P',L.cln_fname,'');
			SELF.clean_name.mname 							:= IF(l.nameType='P',L.cln_mname,'');
			SELF.clean_name.lname 							:= IF(l.nameType='P',L.cln_lname,'');
			SELF.clean_name.name_suffix 				:= IF(l.nameType='P',fGetSuffix(L.cln_suffix),'');
			SELF.clean_name.nid								:= IF(l.nameType='P',L.nid,0);
			SELF            	:= L;
		END;

		dNameAppended2	:= PROJECT(cleanNames2,tr2(LEFT));

		dCleanedTwice	:= dNameAppended + dNameAppended2;

		all_together	:= DISTRIBUTE(dCleanedTwice + dWithout_name, HASH(unique_id));

	  //denormalize the records 
		temp_base_seq denormNID(temp_base_seq l, all_together r) := TRANSFORM			
				SELF.clean_billing_company_name										:= ut.CleanCompany(l.billing_org_name);
				SELF.clean_facility_lab_name											:= ut.CleanCompany(l.facility_lab_name);
				SELF.clean_serv_line_fac_company_name							:= ut.CleanCompany(l.serv_line_fac_name);
				SELF.clean_billing_title													:= IF(r.name_type = 1 ,r.clean_name.title,							l.clean_billing_title);
				SELF.clean_billing_fname													:= IF(r.name_type = 1 ,r.clean_name.fname,							l.clean_billing_fname);
				SELF.clean_billing_mname													:= IF(r.name_type = 1 ,r.clean_name.mname,							l.clean_billing_mname);
				SELF.clean_billing_lname													:= IF(r.name_type = 1 ,r.clean_name.lname,							l.clean_billing_lname);
				SELF.clean_billing_name_suffix										:= IF(r.name_type = 1 ,r.clean_name.name_suffix,				l.clean_billing_name_suffix);
				SELF.clean_billing_name_type											:= IF(r.name_type = 1 ,r.clean_name.name_type,					l.clean_billing_name_type);
				SELF.clean_billing_nid														:= IF(r.name_type = 1 ,r.clean_name.nid,								l.clean_billing_nid);
				SELF.clean_emt_paramedic_title		 								:= IF(r.name_type = 2	,r.clean_name.title, 							l.clean_emt_paramedic_title);
				SELF.clean_emt_paramedic_fname										:= IF(r.name_type = 2	,r.clean_name.fname, 							l.clean_emt_paramedic_fname);
				SELF.clean_emt_paramedic_mname										:= IF(r.name_type = 2	,r.Clean_name.mname, 							l.clean_emt_paramedic_mname);
				SELF.clean_emt_paramedic_lname										:= IF(r.name_type = 2	,r.Clean_name.lname, 							l.clean_emt_paramedic_lname);
				SELF.clean_emt_paramedic_name_suffix							:= IF(r.name_type = 2	,r.Clean_name.name_suffix,				l.clean_emt_paramedic_name_suffix);
				SELF.clean_emt_paramedic_name_type								:= IF(r.name_type = 2	,r.Clean_name.name_type,					l.clean_emt_paramedic_name_type);
				SELF.clean_emt_paramedic_nid											:= IF(r.name_type = 2	,r.Clean_name.nid,								l.clean_emt_paramedic_nid);			
				SELF.clean_ordering_prov_title		 								:= IF(r.name_type = 3, r.clean_name.title, 							l.clean_ordering_prov_title);
				SELF.clean_ordering_prov_fname										:= IF(r.name_type = 3	,r.clean_name.fname, 							l.clean_ordering_prov_fname);
				SELF.clean_ordering_prov_mname										:= IF(r.name_type = 3	,r.Clean_name.mname, 							l.clean_ordering_prov_mname);
				SELF.clean_ordering_prov_lname										:= IF(r.name_type = 3	,r.Clean_name.lname, 							l.clean_ordering_prov_lname);
				SELF.clean_ordering_prov_name_suffix							:= IF(r.name_type = 3	,r.Clean_name.name_suffix,				l.clean_ordering_prov_name_suffix);
				SELF.clean_ordering_prov_name_type								:= IF(r.name_type = 3	,r.Clean_name.name_type,					l.clean_ordering_prov_name_type);
				SELF.clean_ordering_prov_nid											:= IF(r.name_type = 3	,r.Clean_name.nid,								l.clean_ordering_prov_nid);			
				SELF.clean_pay_to_title		 												:= IF(r.name_type = 4 ,r.clean_name.title, 							l.clean_pay_to_title);
				SELF.clean_pay_to_fname														:= IF(r.name_type = 4	,r.clean_name.fname, 							l.clean_pay_to_fname);
				SELF.clean_pay_to_mname														:= IF(r.name_type = 4	,r.Clean_name.mname, 							l.clean_pay_to_mname);
				SELF.clean_pay_to_lname														:= IF(r.name_type = 4	,r.Clean_name.lname, 							l.clean_pay_to_lname);
				SELF.clean_pay_to_name_suffix											:= IF(r.name_type = 4	,r.Clean_name.name_suffix,				l.clean_pay_to_name_suffix);
				SELF.clean_pay_to_name_type												:= IF(r.name_type = 4	,r.Clean_name.name_type,					l.clean_pay_to_name_type);
				SELF.clean_pay_to_nid															:= IF(r.name_type = 4	,r.Clean_name.nid,								l.clean_pay_to_nid);							
				SELF.clean_purch_service_title			 							:= IF(r.name_type = 5 ,r.clean_name.title, 							l.clean_purch_service_title);
				SELF.clean_purch_service_fname										:= IF(r.name_type = 5	,r.clean_name.fname, 							l.clean_purch_service_fname);
				SELF.clean_purch_service_mname										:= IF(r.name_type = 5	,r.Clean_name.mname, 							l.clean_purch_service_mname);
				SELF.clean_purch_service_lname										:= IF(r.name_type = 5	,r.Clean_name.lname, 							l.clean_purch_service_lname);
				SELF.clean_purch_service_name_suffix							:= IF(r.name_type = 5	,r.Clean_name.name_suffix,				l.clean_purch_service_name_suffix);
				SELF.clean_purch_service_name_type								:= IF(r.name_type = 5	,r.Clean_name.name_type,					l.clean_purch_service_name_type);
				SELF.clean_purch_service_nid											:= IF(r.name_type = 5	,r.Clean_name.nid,								l.clean_purch_service_nid);			
				SELF.clean_ref_prov_title		 											:= IF(r.name_type = 6 ,r.clean_name.title, 							l.clean_ref_prov_title);
				SELF.clean_ref_prov_fname													:= IF(r.name_type = 6	,r.clean_name.fname, 							l.clean_ref_prov_fname);
				SELF.clean_ref_prov_mname													:= IF(r.name_type = 6	,r.Clean_name.mname, 							l.clean_ref_prov_mname);
				SELF.clean_ref_prov_lname													:= IF(r.name_type = 6	,r.Clean_name.lname, 							l.clean_ref_prov_lname);
				SELF.clean_ref_prov_name_suffix										:= IF(r.name_type = 6	,r.Clean_name.name_suffix,				l.clean_ref_prov_name_suffix);
				SELF.clean_ref_prov_name_type											:= IF(r.name_type = 6	,r.Clean_name.name_type,					l.clean_ref_prov_name_type);
				SELF.clean_ref_prov_nid														:= IF(r.name_type = 7	,r.Clean_name.nid,								l.clean_ref_prov_nid);				
				SELF.clean_render_prov_title 											:= IF(r.name_type = 7, r.clean_name.title, 							l.clean_render_prov_title);
				SELF.clean_render_prov_fname											:= IF(r.name_type = 7	,r.clean_name.fname, 							l.clean_render_prov_fname);
				SELF.clean_render_prov_mname											:= IF(r.name_type = 7	,r.Clean_name.mname, 							l.clean_render_prov_mname);
				SELF.clean_render_prov_lname											:= IF(r.name_type = 7	,r.Clean_name.lname, 							l.clean_render_prov_lname);
				SELF.clean_render_prov_name_suffix								:= IF(r.name_type = 7	,r.Clean_name.name_suffix,				l.clean_render_prov_name_suffix);
				SELF.clean_render_prov_name_type									:= IF(r.name_type = 7	,r.Clean_name.name_type,					l.clean_render_prov_name_type);
				SELF.clean_render_prov_nid												:= IF(r.name_type = 7	,r.Clean_name.nid,								l.clean_render_prov_nid);			
				SELF.clean_serv_line_ref_prov_title				 				:= IF(r.name_type = 8 ,r.clean_name.title, 							l.clean_serv_line_ref_prov_title);
				SELF.clean_serv_line_ref_prov_fname								:= IF(r.name_type = 8	,r.clean_name.fname, 							l.clean_serv_line_ref_prov_fname);
				SELF.clean_serv_line_ref_prov_mname								:= IF(r.name_type = 8	,r.Clean_name.mname, 							l.clean_serv_line_ref_prov_mname);
				SELF.clean_serv_line_ref_prov_lname								:= IF(r.name_type = 8	,r.Clean_name.lname, 							l.clean_serv_line_ref_prov_lname);
				SELF.clean_serv_line_ref_prov_name_suffix					:= IF(r.name_type = 8	,r.Clean_name.name_suffix,				l.clean_serv_line_ref_prov_name_suffix);
				SELF.clean_serv_line_ref_prov_name_type						:= IF(r.name_type = 8	,r.Clean_name.name_type,					l.clean_serv_line_ref_prov_name_type);
				SELF.clean_serv_line_ref_prov_nid									:= IF(r.name_type = 8	,r.Clean_name.nid,								l.clean_serv_line_ref_prov_nid);			
				SELF.clean_serv_line_render_prov_title		 				:= IF(r.name_type = 9	,r.clean_name.title, 							l.clean_serv_line_render_prov_title);
				SELF.clean_serv_line_render_prov_fname						:= IF(r.name_type = 9	,r.clean_name.fname, 							l.clean_serv_line_render_prov_fname);
				SELF.clean_serv_line_render_prov_mname						:= IF(r.name_type = 9	,r.Clean_name.mname, 							l.clean_serv_line_render_prov_mname);
				SELF.clean_serv_line_render_prov_lname						:= IF(r.name_type = 9	,r.Clean_name.lname, 							l.clean_serv_line_render_prov_lname);
				SELF.clean_serv_line_render_prov_name_suffix			:= IF(r.name_type = 9	,r.Clean_name.name_suffix,				l.clean_serv_line_render_prov_name_suffix);
				SELF.clean_serv_line_render_prov_name_type				:= IF(r.name_type = 9	,r.Clean_name.name_type,					l.clean_serv_line_render_prov_name_type);
				SELF.clean_serv_line_render_prov_nid							:= IF(r.name_type = 9	,r.Clean_name.nid,								l.clean_serv_line_render_prov_nid);				
				SELF.clean_serv_line_supervising_prov_title 			:= IF(r.name_type = 10,r.clean_name.title, 							l.clean_serv_line_supervising_prov_title);
				SELF.clean_serv_line_supervising_prov_fname				:= IF(r.name_type = 10,r.clean_name.fname, 							l.clean_serv_line_supervising_prov_fname);
				SELF.clean_serv_line_supervising_prov_mname				:= IF(r.name_type = 10,r.Clean_name.mname, 							l.clean_serv_line_supervising_prov_mname);
				SELF.clean_serv_line_supervising_prov_lname				:= IF(r.name_type = 10,r.Clean_name.lname, 							l.clean_serv_line_supervising_prov_lname);
				SELF.clean_serv_line_supervising_prov_name_suffix	:= IF(r.name_type = 10,r.Clean_name.name_suffix,				l.clean_serv_line_supervising_prov_name_suffix);
				SELF.clean_serv_line_supervising_prov_name_type		:= IF(r.name_type = 10,r.Clean_name.name_type,					l.clean_serv_line_supervising_prov_name_type);
				SELF.clean_serv_line_supervising_prov_nid					:= IF(r.name_type = 10,r.Clean_name.nid,								l.clean_serv_line_supervising_prov_nid);				
				SELF.clean_supervising_prov_title 								:= IF(r.name_type = 11,r.clean_name.title, 							l.clean_supervising_prov_title);
				SELF.clean_supervising_prov_fname									:= IF(r.name_type = 11,r.clean_name.fname, 							l.clean_supervising_prov_fname);
				SELF.clean_supervising_prov_mname									:= IF(r.name_type = 11,r.Clean_name.mname, 							l.clean_supervising_prov_mname);
				SELF.clean_supervising_prov_lname									:= IF(r.name_type = 11,r.Clean_name.lname, 							l.clean_supervising_prov_lname);
				SELF.clean_supervising_prov_name_suffix						:= IF(r.name_type = 11,r.Clean_name.name_suffix,				l.clean_supervising_prov_name_suffix);
				SELF.clean_supervising_prov_name_type							:= IF(r.name_type = 11,r.Clean_name.name_type,					l.clean_supervising_prov_name_type);
				SELF.clean_supervising_prov_nid										:= IF(r.name_type = 11,r.Clean_name.nid,								l.clean_supervising_prov_nid);	
				SELF            := l;
		END;

	  denormRecs :=  DENORMALIZE(temp_base_seq,all_together,
								  LEFT.unique_id = RIGHT.unique_id,
								  denormNID(LEFT,RIGHT),LOCAL);

		final_file	:= PROJECT(denormRecs, hxmx.layouts.base.mx_record); 
		RETURN final_file;
	END;

END;
	   