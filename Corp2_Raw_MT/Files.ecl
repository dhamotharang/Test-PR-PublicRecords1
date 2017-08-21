import ut, tools, corp2;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//-----------------------------------------------------------------------------------------
	// Input Files
	// Note: The vendor's raw data on tapeload is in ebcdic format.
	//				VendorRaw  - Contains the converted data where the data is translated from ebcdic  
	//-----------------------------------------------------------------------------------------
	EXPORT Input := MODULE
		tools.mac_FilesInput(Corp2_Raw_MT.filenames(pversion, pUseOtherEnvironment).Input.VendorRaw, Corp2_Raw_MT.Layouts.VendorRawLayoutIn, VendorRaw);
	
		
		// f01_Business Transform
		EXPORT Corp2_Raw_MT.Layouts.FileBusinessLayoutIn f01_Trf(Corp2_Raw_MT.Layouts.VendorRawLayoutIn l) := transform
		   self.nonreadabletext       := corp2.t2u(l.payload[1..5]);
		   self.businessstatuscd      := corp2.t2u(l.payload[6..6]);
		   self.ka_busn_enty_char    	:= corp2.t2u(l.payload[7..7]);
		   self.ka_busn_enty_no     	:= corp2.t2u(l.payload[8..13]);
		   self.ka_incrp_dt       		:= corp2.t2u(l.payload[14..21]);
		   self.ka_trm_exst_corp      := corp2.t2u(l.payload[22..25]);
		   self.ka_enty_expr_dt       := corp2.t2u(l.payload[26..33]);
		   self.ka_busn_sts           := corp2.t2u(l.payload[34..36]);
		   self.ka_busn_sts_rsn      	:= corp2.t2u(l.payload[37..39]);
		   self.ka_file_dt            := corp2.t2u(l.payload[40..47]);
		   self.ka_inat_rsn    				:= corp2.t2u(l.payload[48..48]);
		   self.ka_inat_dt          	:= corp2.t2u(l.payload[49..56]);
		   self.ka_reviv_rnst_dt  		:= corp2.t2u(l.payload[57..64]);
		   self.ka_corp_typ       		:= corp2.t2u(l.payload[65..66]);
		   self.ka_busn_purp_cd     	:= corp2.t2u(l.payload[67..69]);
		   self.ka_mca_statute    		:= corp2.t2u(l.payload[70..78]);
		   self.ka_jurs_stt				    := corp2.t2u(l.payload[79..80]);
		   self.ka_ntc_dt            	:= corp2.t2u(l.payload[81..88]);
		   self.ka_dsl_invl_intn_dt 	:= corp2.t2u(l.payload[89..96]);
		   self.ka_dsl_voln_intn_dt 	:= corp2.t2u(l.payload[97..104]);
		   self.ka_ar_lst_dt         	:= corp2.t2u(l.payload[105..112]);
		   self.ka_ar_lst_file_dt     := corp2.t2u(l.payload[113..120]);
		   self.ka_suspd_dt       		:= corp2.t2u(l.payload[121..128]);
		   self.ka_sspd_dsl_intn_dt  	:= corp2.t2u(l.payload[129..136]);
		   self.ka_suspd_disl_dt  		:= corp2.t2u(l.payload[137..145]);		   
		   self                       := l;		   
	  end;
	 	 
		// f02_BusinessName transform
		EXPORT Corp2_Raw_MT.Layouts.FileBusinessNameLayoutIn f02_Trf(Corp2_Raw_MT.Layouts.VendorRawLayoutIn l) := transform
		   self.nonreadabletext 		:= corp2.t2u(l.payload[1..5]);
		   self.businessstatuscd   	:= corp2.t2u(l.payload[6..6]);
		   self.reasoncode      		:= corp2.t2u(l.payload[7..7]);
		   self.inactivedate    		:= corp2.t2u(l.payload[8..15]);
		   self.filler          		:= corp2.t2u(l.payload[16..17]);
		   self.kb_busn_enty_nm 		:= corp2.t2u(l.payload[18..161]);		  
		   self                 		:= l;		   
		end;
		
		// f03_OfficerPartner transform
		EXPORT Corp2_Raw_MT.Layouts.FileOfficerPartnerLayoutIn f03_Trf(Corp2_Raw_MT.Layouts.VendorRawLayoutIn l) := transform
		   self.nonreadabletext   	:= corp2.t2u(l.payload[1..5]);
		   self.businessstatuscd    := corp2.t2u(l.payload[6..6]);
		   self.kk_ofc_nm_typ   		:= corp2.t2u(l.payload[7..7]);
		   self.kk_name_first    		:= corp2.t2u(l.payload[8..19]);
		   self.kk_name_initial    	:= corp2.t2u(l.payload[20..21]);
		   self.kk_name_last     		:= corp2.t2u(l.payload[22..37]);
		   self.kk_st_addr_ln1 			:= corp2.t2u(l.payload[38..67]);
		   self.kk_city_nm       		:= corp2.t2u(l.payload[68..89]);
		   self.kk_state_nm_shr     := corp2.t2u(l.payload[90..91]);
		   self.kk_zip_cd_x        	:= corp2.t2u(l.payload[92..100]);
		   self.kk_addr_ln4    			:= corp2.t2u(l.payload[101..130]);
		   self.kk_indv_mgr_dscn_dt := corp2.t2u(l.payload[131..138]); 
		   self                 		:= l;		   
		end;

    // f04_OfficerShareholder	
		EXPORT Corp2_Raw_MT.Layouts.FileOfficerShareholderLayoutIn f04_Trf(Corp2_Raw_MT.Layouts.VendorRawLayoutIn l) := transform
		   self.nonreadabletext   := corp2.t2u(l.payload[1..5]);
		   self.businessstatuscd  := corp2.t2u(l.payload[6..6]);
		   self.kj_auth_sh_no     := corp2.t2u(l.payload[7..14]);
		   self.kj_auth_sh_cls    := corp2.t2u(l.payload[15..15]);
		   self.kj_auth_sh_sers   := corp2.t2u(l.payload[16..30]);
		   self.kj_auth_sh_iss    := corp2.t2u(l.payload[31..38]);
		   self.kj_auth_sh_pv     := corp2.t2u(l.payload[39..39]);
		   self.kj_auth_sh_pv_amt := corp2.t2u(l.payload[40..48]);		
		   self                 	:= l;		   
		end;
		
		// f05_RelatedBusiness
		EXPORT Corp2_Raw_MT.Layouts.FileRelatedBusinessLayoutIn f05_Trf(Corp2_Raw_MT.Layouts.VendorRawLayoutIn l) := transform
		   self.nonreadabletext   				:= corp2.t2u(l.payload[1..5]);
		   self.businessstatuscd        	:= corp2.t2u(l.payload[6..6]);
		   self.kh_busn_enty_id		 				:= corp2.t2u(l.payload[7..13]);
		   self.kh_busn_enty_rlt  				:= corp2.t2u(l.payload[14..14]);
		   self.kh_regis_mgr_dscn_dt    	:= corp2.t2u(l.payload[15..22]);
		   self.kh_regis_mgr_addr_ln1   	:= corp2.t2u(l.payload[23..52]);
		   self.kh_regis_mgr_addr_ln2   	:= corp2.t2u(l.payload[53..82]);
		   self.kh_regis_mgr_city_nm      := corp2.t2u(l.payload[83..104]);
		   self.kh_regis_mgr_state_nm_shr := corp2.t2u(l.payload[105..106]);
		   self.kh_regis_mgr_zip_cd_x     := corp2.t2u(l.payload[107..115]);
		   self.kh_regis_mgr_addr_ln4     := corp2.t2u(l.payload[116..145]);		   
		   self                   				:= l;		   
		end;
		
		// f06_AgentOwner
		EXPORT Corp2_Raw_MT.Layouts.FileAgentOwnerLayoutIn f06_Trf(Corp2_Raw_MT.Layouts.VendorRawLayoutIn l) := transform
		   self.nonreadabletext  := corp2.t2u(l.payload[1..5]);
		   self.businessstatuscd := corp2.t2u(l.payload[6..6]);
		   self.kd_owner_type    := corp2.t2u(l.payload[7..7]);
		   self.kd_agnt_ownr_nm  := corp2.t2u(l.payload[8..42]);
		   self.kd_st_addr_ln1   := corp2.t2u(l.payload[43..72]);
		   //check if both address lines contain the same information			 
		   self.kd_st_addr_ln2   := if(corp2.t2u(l.payload[43..72])=corp2.t2u(l.payload[73..102]),'',corp2.t2u(l.payload[73..102]));
		   self.kd_city_nm       := corp2.t2u(l.payload[103..124]);
		   self.kd_state_nm_shr  := corp2.t2u(l.payload[125..126]);
		   self.kd_zip_cd_x      := corp2.t2u(l.payload[127..135]);		      
		   self                  := l;		   
		end;
		
		// f07_AssumedBusName
		EXPORT Corp2_Raw_MT.Layouts.FileAssumedBusinessNameLayoutIn f07_Trf(Corp2_Raw_MT.Layouts.VendorRawLayoutIn l) := transform                               
		   self.nonreadabletext   := corp2.t2u(l.payload[1..5]);
		   self.businessstatuscd  := corp2.t2u(l.payload[6..6]);
		   self.ke_abn_cnty       := corp2.t2u(l.payload[7..63]);
		   self.ke_abn_fst_use_mt := corp2.t2u(l.payload[64..71]);
		   self.ke_fold_loc   		:= corp2.t2u(l.payload[72..78]);
		   self.ke_abn_purp_desc  := corp2.t2u(l.payload[79..113]);
		   self                   := l;		   
		end; 
		
		// f08_ForeignBusiness
		EXPORT Corp2_Raw_MT.Layouts.FileForeignBusinessLayoutIn f08_Trf(Corp2_Raw_MT.Layouts.VendorRawLayoutIn l) := transform
		   self.nonreadabletext           := corp2.t2u(l.payload[1..5]);
		   self.businessstatuscd          := corp2.t2u(l.payload[6..6]);
		   self.kf_qual_file_dt     			:= corp2.t2u(l.payload[7..14]);
		   self.kf_st_addr_ln1 						:= corp2.t2u(l.payload[15..44]);
		   self.kf_city_nm       					:= corp2.t2u(l.payload[45..66]);
		   self.kf_state_nm_shr         	:= corp2.t2u(l.payload[67..68]);
		   self.kf_zip_cd_x        				:= corp2.t2u(l.payload[69..77]);
		   self.kf_addr_ln4    						:= corp2.t2u(l.payload[78..97]);
		   self.kf_jurs_cntry     				:= corp2.t2u(l.payload[98..127]);
		   self.kf_tot_busn_rect          := corp2.t2u(l.payload[128..142]);
		   self.kf_mt_busn_rect           := corp2.t2u(l.payload[143..157]);
		   self.kf_tot_prop_val           := corp2.t2u(l.payload[158..172]);
		   self.kf_mt_prop_val            := corp2.t2u(l.payload[173..187]);
		   self.kf_pct_empl_mt    				:= corp2.t2u(l.payload[188..190]);
		   self                					  := l;		   
		end;
		
		// f09_Trademarks
		EXPORT Corp2_Raw_MT.Layouts.FileTrademarksLayoutIn f09_Trf(Corp2_Raw_MT.Layouts.VendorRawLayoutIn l) := transform
		   self.nonreadabletext        := corp2.t2u(l.payload[1..5]);
		   self.businessstatuscd       := corp2.t2u(l.payload[6..6]);
		   self.kg_tm_fst_use_mt       := corp2.t2u(l.payload[7..14]);
		   self.kg_tm_fst_use_any 		 := corp2.t2u(l.payload[15..22]);
		   self.kg_tm_rnwl_dt          := corp2.t2u(l.payload[23..30]);
		   self.kg_tm_cls1             := corp2.t2u(l.payload[31..33]);
		   self.kg_tm_cls2             := corp2.t2u(l.payload[34..36]);
		   self.kg_tm_cls3             := corp2.t2u(l.payload[37..39]);
		   self.kg_tm_cls4             := corp2.t2u(l.payload[40..42]);
		   self.kg_tm_cls5             := corp2.t2u(l.payload[43..45]);
		   self.kg_tm_cls6             := corp2.t2u(l.payload[46..48]);
		   self.kg_tm_cls7             := corp2.t2u(l.payload[49..51]);
		   self.kg_tm_goods_desc     	 := corp2.t2u(l.payload[52..86]);
		   self.kg_tm_use_desc         := corp2.t2u(l.payload[87..121]);
		   self.kg_fold_loc         	 := corp2.t2u(l.payload[122..127]);		   
		   self                        := l;		   
		end;
		
		// Files to use as input into the Mapper
		EXPORT f01_Business           := project(VendorRaw.Logical(corp2.t2u(businessrecordtype)='1'), f01_Trf(LEFT)); 
		EXPORT f02_BusinessName       := project(VendorRaw.Logical(corp2.t2u(businessrecordtype)='2'), f02_Trf(LEFT));
		EXPORT f03_OfficerPartner     := project(VendorRaw.Logical(corp2.t2u(businessrecordtype)='3'), f03_Trf(LEFT));		
		EXPORT f04_OfficerShareholder := project(VendorRaw.Logical(corp2.t2u(businessrecordtype)='4'), f04_Trf(LEFT));
		EXPORT f05_RelatedBusiness    := project(VendorRaw.Logical(corp2.t2u(businessrecordtype)='5'), f05_Trf(LEFT));
		EXPORT f06_AgentOwner       	:= project(VendorRaw.Logical(corp2.t2u(businessrecordtype)='6'), f06_Trf(LEFT));	
		EXPORT f07_AssumedBusName     := project(VendorRaw.Logical(corp2.t2u(businessrecordtype)='7'), f07_Trf(LEFT));
		EXPORT f08_ForeignBusiness    := project(VendorRaw.Logical(corp2.t2u(businessrecordtype)='8'), f08_Trf(LEFT));
		EXPORT f09_Trademarks       	:= project(VendorRaw.Logical(corp2.t2u(businessrecordtype)='9'), f09_Trf(LEFT));
		
	END;	
	
END;