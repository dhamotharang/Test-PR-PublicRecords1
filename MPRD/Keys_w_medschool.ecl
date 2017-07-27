// EXPORT Keys_w_medschool := 'todo';
import doxie, tools,healthcare_cleaners,mprd;

export Keys_w_medschool(

	 string		pversion							= ''
	,boolean pUseProd = false

) :=
module

	//export Base					:= Files(pversion,pUseProd).Base.Built;
	
	export facility_in					    := Files(pversion,pUseProd).fac_basc_file;
	export fac_joined_grp_key  :=    mprd.special_keys(pversion,pUseProd).facility_joined_key;
	export fac_Base_gk							:= facility_in(group_key <> '');
	export fac_Base_sugk						:= facility_in(surrogate_key <>'');
	export fac_Base_joinedgk			  := fac_joined_grp_key((string38)group_key <> '');
	export fac_joined_filecode_key  := fac_joined_grp_key(group_affiliation<>'' or hosp_affiliation<>'');
	
	export individual_in					  := Files(pversion,pUseProd).idv_basc_file;
	export ind_joined_grp_key       :=  mprd.special_keys(pversion,pUseProd).individual_joined_key;
	export ind_Base_gk							:= individual_in((string38)group_key <> '');
	export ind_Base_sugk						:= individual_in(surrogate_key <> '');
	export ind_Base_joinedgk			  := ind_joined_grp_key((string38)group_key <> '');
	//export ind_Base_lnpid						:= individual_in(lnpid > 0);
	
	
	
	
	export basc_cp_in					      := Files(pversion,pUseProd).basc_cp_file;
	export basc_cp_Base_gk					:= basc_cp_in((string38)group_key <> '');
	export basc_cp_Base_sugk				:= basc_cp_in(surrogate_key <>'');
	
	export basc_claims_in					  := Files(pversion,pUseProd).basc_claims_file;
	export basc_claims_Base_gk			:= basc_claims_in((string38)group_key <> '');
	export basc_claims_Base_sugk		:= basc_claims_in(surrogate_key <>'');
	
	
	
	
	export npi_extension_Base				  := Files(pversion,pUseProd).npi_extension_file;
	export npi_extension_Base_npinumk	:= npi_extension_Base(npi_num <> '');
	
	
	export npi_extension_facility_Base				 := Files(pversion,pUseProd).npi_extension_facility_file;
	export npi_extension_facility_Base_npinumk := npi_extension_facility_Base(npi_num <> '');


  export claims_addr_master_Base				  := Files(pversion,pUseProd).claims_addr_master_file;
	export claims_addr_master_Base_billtink	:= claims_addr_master_Base(bill_tin <> '');
  export claims_addr_master_Base_billnpik	:= claims_addr_master_Base(bill_npi <> '');	
	export claims_addr_master_Base_renderingnpik	:= claims_addr_master_Base(rendering_npi <> '');	
	
	
	
	export claims_by_month_Base				    := Files(pversion,pUseProd).claims_by_month_file;
  export claims_by_month_Base_billtink	:= claims_by_month_Base(bill_tin <> '');
 
  export npi_tin_xref_Base				  := Files(pversion,pUseProd).npi_tin_xref_file;
  export npi_tin_xref_Base_billnpik	:= npi_tin_xref_Base(bill_npi <> '');
	
	export taxonomy_equiv_Base				    := Files(pversion,pUseProd).taxonomy_equiv_file;
  export taxonomy_equiv_Base_taxonomyk	:= taxonomy_equiv_Base(taxonomy <> '');

 export source_confidence_lu_Base				  := Files(pversion,pUseProd).source_confidence_lu_file;
 export source_confidence_lu_Base_fcodek	:= source_confidence_lu_Base(filecode<> '');
 
 export ignore_terms_lu_Base				          := Files(pversion,pUseProd).ignore_terms_lu_file;
 export ignore_terms_lu_Base_codek	          := ignore_terms_lu_Base(code<> '');
 
 
  export abbr_lu_Base				                 := Files(pversion,pUseProd).abbr_lu_file;
 export abbr_lu_Base_codek	                 := abbr_lu_Base(code<> '');

  export taxon_lu_Base				          := Files(pversion,pUseProd).taxon_lu_file;
 export taxon_lu_Base_codek	          := taxon_lu_Base(code<> '');

 

 export basc_deceased_Base				    := Files(pversion,pUseProd).basc_deceased_file;
 export basc_deceased_Base_gk	        := basc_deceased_Base(group_key <> '');
 
 export basc_addr_Base				        := Files(pversion,pUseProd).basc_addr_file;
 export basc_addr_Base_sgk	          := basc_addr_Base(surrogate_key <> '');

 export client_Data_Base				        := Files(pversion,pUseProd).client_Data_file;
 export client_Data_Base_sgk	          := client_Data_Base(surrogate_key <> '');
 
 
 export std_terms_lu_Base				          := Files(pversion,pUseProd).std_terms_lu_file;
 export std_terms_lu_Base_codek	          := std_terms_lu_Base(code <> '');
 
 export taxonomy_full_lu_Base				    := Files(pversion,pUseProd).taxonomy_full_lu_file;
 export taxonomy_full_lu_Base_taxonomyk := taxonomy_full_lu_Base(taxonomy <> '');

 export specialty_lu_Base				        := Files(pversion,pUseProd).specialty_lu_file;
 export specialty_lu_Base_specialtyk	  := specialty_lu_Base(specialty <> '');

 export group_lu_Base				            := Files(pversion,pUseProd).group_lu_file;
 export group_lu_Base_codek	            := group_lu_Base(code <> '');
 
 export hospital_lu_Base				        := Files(pversion,pUseProd).hospital_lu_file;
 export hospital_lu_Base_codek	        := hospital_lu_Base(code <> '');
 
 export dea_xref_Base				            := Files(pversion,pUseProd).dea_xref_file;
 export dea_xref_Base_gk	              := dea_xref_Base(group_key <> '');
 
 export lic_xref_Base				            := Files(pversion,pUseProd).lic_xref_file;
 export lic_xref_Base_gk	              := lic_xref_Base(group_key <> '');
 
 export facility_name_xref_Base				    := Files(pversion,pUseProd).facility_name_xref_file;
 export facility_name_xref_Base_taxonomyk	:= facility_name_xref_Base(taxonomy <> '');
 
 export addr_name_xref_Base				        := Files(pversion,pUseProd).addr_name_xref_file;
 export addr_name_xref_Base_gk	          := addr_name_xref_Base(group_key <> '');

 export basc_facility_mme_Base				    := Files(pversion,pUseProd).basc_facility_mme_file;
 export basc_facility_mme_Base_gk	        := basc_facility_mme_Base(group_key <> '');

 export nanpa_Base				                := Files(pversion,pUseProd).nanpa_file;
 export nanpa_Base_npanumk	              := nanpa_Base(npa_num <> '');
 
 export best_hospital_Base				        := Files(pversion,pUseProd).best_hospital_file;
 export best_hospital_Base_addrk	        := best_hospital_Base(addr_key <> '');
 
 export last_name_stats_Base				      := Files(pversion,pUseProd).last_name_stats_file;
 export last_name_stats_Base_lnamek	    := last_name_stats_Base(last_name<> '');
 
 // export source_confidence_lu_Base				  := Files(pversion,pUseProd).source_confidence_lu_file;
 // export source_confidence_lu_Base_fcodek	:= source_confidence_lu_Base(filecode<> '');
 
 export office_attributes_facility_Base		    := Files(pversion,pUseProd).office_attributes_facility_file;
 export office_attributes_facility_Base_sgk   := office_attributes_facility_Base(surrogate_key <> '');
 
 export office_attributes_Base				        := Files(pversion,pUseProd).office_attributes_file;
 export office_attributes_Base_sgk	          := office_attributes_Base(surrogate_key <> '');
 
 // export dir_confidence_lu_Base				          := Files(pversion,pUseProd).dir_confidence_lu_file;
 // export dir_confidence_lu_Base_codek	          := dir_confidence_lu_Base(code<> '');

 export call_queue_bad_Base				          := Files(pversion,pUseProd).call_queue_bad_file;
 export call_queue_bad_Base_phonek	          := call_queue_bad_Base(prac_phone1 <> '');
 
 // export lic_file_date_Base				          := Files(pversion,pUseProd).lic_file_date_file;
 // export lic_file_date_Base_codek	          := lic_file_date_Base(code<> '');
 //export medschool_Base				                := dataset('~thor_data400::base::mprd::medschools::20150603',healthcare_cleaners.layouts_medschool.layoutMedicalSchoolWord1,flat);
 export medschool_Base				                := Files_w_medschool(pversion,pUseProd).medschool_file;
 export medschool_Base_msidk	                := medschool_Base(msid <>0);
 export non_medschool_Base				              := Files_w_medschool(pversion,pUseProd).non_medschool_file;
 export non_medschool_Base_msidk	              := non_medschool_Base(msid <>0);
 
 export medschool_wordlist_Base				        := Files_w_medschool(pversion,pUseProd).medschool_wordlist_file;
 export medschool_wordlist_Base_wordk	        := medschool_wordlist_Base(words<> '');
 export non_medschool_wordlist_Base				    := Files_w_medschool(pversion,pUseProd).non_medschool_wordlist_file;
 export non_medschool_wordlist_Base_wordk	    := non_medschool_wordlist_Base(words<> '');
 


 
 
 

 





 


	//export FilterDids		:= Base(did		!= 0);
	
	tools.mac_FilesIndex('facility_in		,{group_key	}	  ,{Fac_Base_gk}'	,keynames(pversion,pUseProd).facility_group_key		,facility_group_key		 );
  tools.mac_FilesIndex('facility_in		,{surrogate_key	}	  ,{fac_Base_sugk	}'	,keynames(pversion,pUseProd).facility_surrogate_key		,facility_surrogate_key	 );
	tools.mac_FilesIndex('fac_joined_grp_key		,{group_key			}	  ,{fac_Base_joinedgk}'	,keynames(pversion,pUseProd).facility_join_group_key		,facility_join_group_key	 );
	tools.mac_FilesIndex('fac_joined_filecode_key		,{filecode			}	  ,{group_affiliation,hosp_affiliation,prac1_key,prac_phone1,group_key}'	,keynames(pversion,pUseProd).facility_join_filecode_key		,facility_join_filecode_key	 );
	

	// individual keys - group_key, lnpid
	tools.mac_FilesIndex('individual_in		,{group_key	}	  ,{ind_Base_gk}'	,keynames(pversion,pUseProd).individual_group_key		,individual_group_key	 );
	tools.mac_FilesIndex('individual_in		,{surrogate_key	}	  ,{ind_Base_sugk}'	,keynames(pversion,pUseProd).individual_surrogate_key		,individual_surrogate_key	 );
	tools.mac_FilesIndex('ind_joined_grp_key		,{group_key			}	  ,{ind_Base_joinedgk}'	,keynames(pversion,pUseProd).individual_join_group_key		,individual_join_group_key	 );
	
	tools.mac_FilesIndex('basc_cp_in		,{group_key	}	  ,{basc_cp_Base_gk}'	,keynames(pversion,pUseProd).basc_cp_group_key		,basc_cp_group_key	 );
	tools.mac_FilesIndex('basc_cp_in		,{surrogate_key	}	  ,{basc_cp_Base_sugk}'	,keynames(pversion,pUseProd).basc_cp_surrogate_key		,basc_cp_surrogate_key );

  tools.mac_FilesIndex('basc_claims_in		,{group_key	}	  ,{basc_claims_Base_gk}'	,keynames(pversion,pUseProd).basc_claims_group_key		,basc_claims_group_key	 );
	tools.mac_FilesIndex('basc_claims_in		,{surrogate_key	}	  ,{basc_claims_Base_sugk}'	,keynames(pversion,pUseProd).basc_claims_surrogate_key		,basc_claims_surrogate_key	 );

	// npi_extension  keys - npi_num_key
  tools.mac_FilesIndex('npi_extension_Base		,{npi_num	}	  ,{npi_extension_Base_npinumk}'	,keynames(pversion,pUseProd).npi_extension_npi_num_key		,npi_extension_npi_num_key);

	// npi_extension_facility  keys - npi_num_key
	tools.mac_FilesIndex('npi_extension_facility_Base		,{npi_num	}	  ,{npi_extension_facility_Base_npinumk}'	,keynames(pversion,pUseProd).npi_extension_facility_npi_num_key		,npi_extension_facility_npi_num_key);
	
  //claims_address_master keys -bill_tin_key
	tools.mac_FilesIndex('claims_addr_master_Base		,{bill_tin	}	  ,{claims_addr_master_Base_billtink}'	,keynames(pversion,pUseProd).claims_addr_master_bill_tin_key		,claims_addr_master_bill_tin_key);
	tools.mac_FilesIndex('claims_addr_master_Base		,{bill_npi	}	  ,{claims_addr_master_Base_billnpik}'	,keynames(pversion,pUseProd).claims_addr_master_bill_npi_key		,claims_addr_master_bill_npi_key);
	tools.mac_FilesIndex('claims_addr_master_Base		,{rendering_npi	}	  ,{claims_addr_master_Base_renderingnpik}'	,keynames(pversion,pUseProd).claims_addr_master_rendering_npi_key		,claims_addr_master_rendering_npi_key);
	
	//claims_by_month keys -bill_tin_key
	tools.mac_FilesIndex('claims_by_month_Base		,{bill_tin	}	  ,{claims_by_month_Base_billtink}'	,keynames(pversion,pUseProd).claims_by_month_bill_tin_key		,claims_by_month_bill_tin_key);
	
	tools.mac_FilesIndex('npi_tin_xref_Base		,{bill_npi	}	  ,{npi_tin_xref_Base_billnpik}'	,keynames(pversion,pUseProd).npi_tin_xref_bill_npi_key		,npi_tin_xref_bill_npi_key);
	
	tools.mac_FilesIndex('taxonomy_equiv_Base		,{taxonomy	}	  ,{taxonomy_equiv_Base_taxonomyk}'	,keynames(pversion,pUseProd).taxonomy_equiv_taxonomy_key		,taxonomy_equiv_taxonomy_key);
	
	tools.mac_FilesIndex('basc_deceased_Base		,{group_key	}	  ,{basc_deceased_Base_gk}'	,keynames(pversion,pUseProd).basc_deceased_group_key		,basc_deceased_group_key);
	
	tools.mac_FilesIndex('basc_addr_Base		,{surrogate_key	}	  ,{basc_addr_Base_sgk}'	,keynames(pversion,pUseProd).basc_addr_surrogate_key		,basc_addr_surrogate_key);
	
	tools.mac_FilesIndex('client_Data_Base		,{surrogate_key	}	  ,{client_Data_Base_sgk}'	,keynames(pversion,pUseProd).client_Data_surrogate_key		,client_Data_surrogate_key);
	
	tools.mac_FilesIndex('std_terms_lu_Base		,{code	}	  ,{std_terms_lu_Base_codek}'	,keynames(pversion,pUseProd).std_terms_lu_code_key		,std_terms_lu_code_key);
	
	tools.mac_FilesIndex('taxonomy_full_lu_Base		,{taxonomy	}	  ,{taxonomy_full_lu_Base_taxonomyk}'	,keynames(pversion,pUseProd).taxonomy_full_lu_taxonomy_key		,taxonomy_full_lu_taxonomy_key);
	
	tools.mac_FilesIndex('specialty_lu_Base		,{specialty}	  ,{specialty_lu_Base_specialtyk}'	,keynames(pversion,pUseProd).specialty_lu_specialty_key		,specialty_lu_specialty_key);
	
	tools.mac_FilesIndex('group_lu_Base		,{code }	  ,{group_lu_Base_codek}'	,keynames(pversion,pUseProd).group_lu_code_key		,group_lu_code_key);
	
	tools.mac_FilesIndex('hospital_lu_Base		,{code }	  ,{hospital_lu_Base_codek}'	,keynames(pversion,pUseProd).hospital_lu_code_key		,hospital_lu_code_key);
	
	tools.mac_FilesIndex('dea_xref_Base		,{group_key }	  ,{dea_xref_Base_gk}'	,keynames(pversion,pUseProd).dea_xref_group_key		,dea_xref_group_key);
	
	tools.mac_FilesIndex('lic_xref_Base		,{group_key }	  ,{lic_xref_Base_gk}'	,keynames(pversion,pUseProd).lic_xref_group_key		,lic_xref_group_key);
	
	tools.mac_FilesIndex('addr_name_xref_Base		,{group_key }	  ,{addr_name_xref_Base_gk}'	,keynames(pversion,pUseProd).addr_name_xref_group_key		,addr_name_xref_group_key);
	
	tools.mac_FilesIndex('basc_facility_mme_Base		,{group_key }	  ,{basc_facility_mme_Base_gk}'	,keynames(pversion,pUseProd).basc_facility_mme_group_key		,basc_facility_mme_group_key);
	
	tools.mac_FilesIndex('facility_name_xref_Base		,{taxonomy}	  ,{facility_name_xref_Base_taxonomyk}'	,keynames(pversion,pUseProd).facility_name_xref_taxonomy_key		,facility_name_xref_taxonomy_key);
		
		
	tools.mac_FilesIndex('nanpa_Base		,{npa_num}	  ,{nanpa_Base_npanumk}'	,keynames(pversion,pUseProd).nanpa_npa_num_key		,nanpa_npa_num_key);
	
	tools.mac_FilesIndex('best_hospital_Base		,{addr_key}	  ,{best_hospital_Base_addrk}'	,keynames(pversion,pUseProd).best_hospital_addr_key		,best_hospital_addr_key);
	
	tools.mac_FilesIndex('last_name_stats_Base		,{last_name}	  ,{last_name_stats_Base_lnamek}'	,keynames(pversion,pUseProd).last_name_stats_last_name_key		,last_name_stats_last_name_key);
	
	tools.mac_FilesIndex('source_confidence_lu_Base		,{filecode}	  ,{source_confidence_lu_Base_fcodek}'	,keynames(pversion,pUseProd).source_confidence_lu_file_code_key		,source_confidence_lu_file_code_key);
	
	tools.mac_FilesIndex('office_attributes_facility_Base		,{surrogate_key}	  ,{office_attributes_facility_Base_sgk}'	,keynames(pversion,pUseProd).office_attributes_facility_surrogate_key		,office_attributes_facility_surrogate_key);
	
	tools.mac_FilesIndex('office_attributes_Base		,{surrogate_key}	  ,{office_attributes_Base_sgk}'	,keynames(pversion,pUseProd).office_attributes_surrogate_key		,office_attributes_surrogate_key);
	
	tools.mac_FilesIndex('ignore_terms_lu_Base		,{code}	  ,{ignore_terms_lu_Base_codek}'	,keynames(pversion,pUseProd).ignore_terms_lu_code_key		,ignore_terms_lu_code_key);
	
	 tools.mac_FilesIndex('taxon_lu_Base		,{code}	  ,{taxon_lu_Base_codek}'	,keynames(pversion,pUseProd).taxon_lu_code_key		,taxon_lu_code_key);
	
	 tools.mac_FilesIndex('abbr_lu_Base		,{code}	  ,{abbr_lu_Base_codek}'	,keynames(pversion,pUseProd).abbr_lu_code_key		,abbr_lu_code_key);

   tools.mac_FilesIndex('call_queue_bad_Base		,{prac_phone1}	  ,{call_queue_bad_Base_phonek}'	,keynames(pversion,pUseProd).call_queue_bad_phone_key,call_queue_bad_phone_key);
	 
	 tools.mac_FilesIndex('medschool_Base		,{msid}	  ,{medschool_Base_msidk}'	,keynames_w_medschool(pversion,pUseProd).medschool_msid_key			,medschool_msid_key);

	 tools.mac_FilesIndex('medschool_wordlist_Base		,{words}	  ,{medschool_wordlist_Base_wordk}'	,keynames_w_medschool(pversion,pUseProd).medschool_wordlist_word_key,medschool_wordlist_word_key);

	tools.mac_FilesIndex('non_medschool_Base		,{msid}	  ,{non_medschool_base_msidk}'	,keynames_w_medschool(pversion,pUseProd).non_medschool_msid_key			,non_medschool_msid_key);

	 tools.mac_FilesIndex('non_medschool_wordlist_Base		,{words}	  ,{non_medschool_wordlist_Base_wordk}'	,keynames_w_medschool(pversion,pUseProd).non_medschool_wordlist_word_key,non_medschool_wordlist_word_key);

	
end;
