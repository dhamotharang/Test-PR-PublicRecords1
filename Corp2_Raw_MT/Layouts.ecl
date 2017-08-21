export Layouts := module

	export VendorKey												:= record
		 string1    businessentitytypecd;										//businessentitytypecd;
		 string6    businessentityno;												//businessentityno;
		 string1    businessrecordtype;											//recordtype;
		 string5		nonreadabletext;												//nonreadabletext;
		 string1		businessstatuscd;												//statcode;
	end;

	//This layout translates the ebcdic data to  format
	export VendorRawLayoutIn								:= record
		 ebcdic string1    businessentitytypecd;						//businessentitytypecd;
		 ebcdic string6    businessentityno;								//businessentityno;
		 ebcdic string1    businessrecordtype;							//recordtype;
		 ebcdic string192  payload;													//payload;
	end;

	// Record_Type = 1
	export FileBusinessLayoutIn							:= record
			VendorKey;
			string1		ka_busn_enty_char;											//businessentitycode;
			string6		ka_busn_enty_no;												//businessentitynum
			string8		ka_incrp_dt;														//incorporatedate
			string4		ka_trm_exst_corp;												//termofexistence
			string8		ka_enty_expr_dt;												//expirationdate
			string3		ka_busn_sts;														//statuscode
			string3		ka_busn_sts_rsn;												//statusreasoncode
			string8		ka_file_dt;															//filingdate
			string1		ka_inat_rsn;														//inactivereasoncode
			string8		ka_inat_dt;															//inactivedate
			string8		ka_reviv_rnst_dt;												//reviverreinstatedate
			string2		ka_corp_typ;														//corporationtype
			string3		ka_busn_purp_cd;												//businesspurposecd
			string9		ka_mca_statute;													//montanacodestatute
			string2		ka_jurs_stt;														//stateofjurisdiction
			string8		ka_ntc_dt;															//noticedate
			string8		ka_dsl_invl_intn_dt;										//involdissolintentdate
			string8		ka_dsl_voln_intn_dt;										//volundissolintentdate
			string8		ka_ar_lst_dt;														//arlastgendate
			string8		ka_ar_lst_file_dt;											//arlastfileddate
			string8		ka_suspd_dt;														//suspensiondate
			string8		ka_sspd_dsl_intn_dt;										//suspensionintentdate
			string8		ka_suspd_disl_dt;												//suspensiondissoldate
	end;

	
	// Record_Type = 2
	export FileBusinessNameLayoutIn 				:= record
			VendorKey;
			string1   reasoncode;															//reasoncode
			string8   inactivedate;														//inactivedate												
			string2   filler;																	//filler												
			string144 kb_busn_enty_nm;												//businessname
		end;
		
		// Record_Type = 3
	export FileOfficerPartnerLayoutIn 			:= record
			VendorKey;
			string1  	kk_ofc_nm_typ;													//officernmtypecd
			string12 	kk_name_first;													//officerfirstnm
			string2  	kk_name_initial;												//officerinitial
			string16 	kk_name_last;														//officerlastnm
			string30 	kk_st_addr_ln1;													//officerstreetaddr
			string22 	kk_city_nm;															//officercity
			string2  	kk_state_nm_shr;												//officerstate
			string9  	kk_zip_cd_x;														//officerzip
			string30 	kk_addr_ln4;														//officercountry
			string8  	kk_indv_mgr_dscn_dt;										//managerdissocdate - not for LP, 
	end;
		
		// Record_Type = 4
	export FileOfficerShareholderLayoutIn		:= record
			VendorKey;
			string8  	kj_auth_sh_no;													//authorizednbr
			string1  	kj_auth_sh_cls;													//class
			string15 	kj_auth_sh_sers;												//series
			string8  	kj_auth_sh_iss;													//sharesissued
			string1  	kj_auth_sh_pv;													//parvalue
			string9  	kj_auth_sh_pv_amt;											//parvalueamnt
	end;
		
		// Record_Type = 5
	export FileRelatedBusinessLayoutIn			:= record
			VendorKey;
			string7  	kh_busn_enty_id;												//relatedbusinessid
			string1  	kh_busn_enty_rlt;												//relationshiptype
			string8  	kh_regis_mgr_dscn_dt;										//regmgrdissocdt
			string30 	kh_regis_mgr_addr_ln1;									//regmgraddrline1
			string30 	kh_regis_mgr_addr_ln2;									//regmgraddrline2
			string22 	kh_regis_mgr_city_nm;										//regmgrcity
			string2  	kh_regis_mgr_state_nm_shr;							//regmgrstate
			string9  	kh_regis_mgr_zip_cd_x;									//regmgrzip
			string30 	kh_regis_mgr_addr_ln4;									//regmgrcountry
	end;
		
		// Record_Type = 6
	export FileAgentOwnerLayoutIn 					:= record
			VendorKey;
			string1  	kd_owner_type;													//ownertypecd
			string35 	kd_agnt_ownr_nm;												//raname
			string30 	kd_st_addr_ln1;													//raaddrline1
			string30 	kd_st_addr_ln2;													//raaddrline2
			string22 	kd_city_nm;															//racity
			string2  	kd_state_nm_shr;												//rastate
			string9  	kd_zip_cd_x;														//razip
		end;
		
		// Record_Type = 7
	export FileAssumedBusinessNameLayoutIn	:= record
			VendorKey;
			string57 	ke_abn_cnty;	                          //counties
			string8  	ke_abn_fst_use_mt;											//datefirstuse
			string7  	ke_fold_loc;														//folderlocation
			string35 	ke_abn_purp_desc;												//purpose
		end;
		
		// Record_Type = 8
	export FileForeignBusinessLayoutIn 			:= record
			VendorKey;
			string8  	kf_qual_file_dt;												//qualificationfilingdt
			string30 	kf_st_addr_ln1;													//principleofficestreetaddr
			string22 	kf_city_nm;															//principleofficecity
			string2  	kf_state_nm_shr;												//principleofficest
			string9  	kf_zip_cd_x;														//principleofficezip
			string30 	kf_addr_ln4;														//principleofficecountry  was string20???
			string30 	kf_jurs_cntry;					 								//countryofjurisdiction
			string15 	kf_tot_busn_rect;												//totalreceipts
			string15 	kf_mt_busn_rect;												//montanareceipts
			string15 	kf_tot_prop_val;												//totalvalue
			string15 	kf_mt_prop_val;													//montanavalue
			string3  	kf_pct_empl_mt;													//percentageemploymentmt
	end;

	// Record_Type = 9
	export FileTrademarksLayoutIn 					:= record
			VendorKey;
			string8  	kg_tm_fst_use_mt;												//dateoffirstusemt
			string8  	kg_tm_fst_use_any;											//dateoffirstuseanywhere
			string8  	kg_tm_rnwl_dt;													//renewaldate
			string3  	kg_tm_cls1;															//classcd1
			string3  	kg_tm_cls2;															//classcd2
			string3  	kg_tm_cls3;															//classcd3
			string3  	kg_tm_cls4;															//classcd4
			string3  	kg_tm_cls5;															//classcd5
			string3  	kg_tm_cls6;															//classcd6 vendor states there should be 7
			string3  	kg_tm_cls7;															//classcdflag //truncated flag
			string35 	kg_tm_goods_desc;												//descriptionofgoods
			string35 	kg_tm_use_desc;													//mannerofuse
			string6  	kg_fold_loc;														//folderlocation
	end;
			
	export TempBusinessLayoutIn							:= record
			VendorKey;
			FileBusinessLayoutIn						-VendorKey;
			FileBusinessNameLayoutIn				-VendorKey;
			FileForeignBusinessLayoutIn			-VendorKey;
			FileAgentOwnerLayoutIn          -VendorKey;
			string agentStatusCode;
			FileAssumedBusinessNameLayoutIn	-VendorKey;
			FileTrademarksLayoutIn					-VendorKey;
	end;
																										
	export TempContactLayoutIn							:= record
			VendorKey;	
		  FileBusinessNameLayoutIn.kb_busn_enty_nm;
			FileRelatedBusinessLayoutIn     -VendorKey;
		  FileOfficerPartnerLayoutIn 			-VendorKey;
			FileAgentOwnerLayoutIn	 				-VendorKey;
			string		temp_rectype;
			string 		temp_cont_full_name;
			string    temp_title_cd;
			string 		temp_cont_address_line1;
			string 		temp_cont_address_line2;
			string 		temp_cont_city;
			string 		temp_cont_state;
			string 		temp_cont_zip;
			string 		temp_cont_country;
			string 		temp_addl_info;
	end;
	
end;