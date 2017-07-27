// EXPORT Keynames_w_medschool := 'todo';
import tools;

export Keynames_w_medschool(

	 string		pversion							= '',
   boolean pUseProd = false

) :=
module

export facility_lFileTemplate	    	         := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::facility::@version@::';
export facilityjoin_grpkey_lFileTemplate	   := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::facility_join::@version@::';
export facilityjoin_filecodekey_lFileTemplate:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::facility_filecode::@version@::';
export individual_lFileTemplate	             := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::individual::@version@::';
export individualjoin_grpkey_lFileTemplate	 := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::individual_join::@version@::';
export basc_cp_lFileTemplate	               := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::basc_cp::@version@::';
export basc_claims_lFileTemplate	           := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::basc_claims::@version@::';
export npi_extension_lFileTemplate	         := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::npi_extension::@version@::';
export npi_extension_facility_lFileTemplate	 := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::npi_extension_facility::@version@::';
export claims_addr_master_lFileTemplate	     := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::claims_addr_master::@version@::';
export claims_by_month_lFileTemplate	       := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::claims_by_month::@version@::';
export npi_tin_xref_lFileTemplate	           := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::npi_tin_xref::@version@::';
export taxonomy_equiv_lFileTemplate	         := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::taxonomy_equiv::@version@::';
export basc_deceased_lFileTemplate	         := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::basc_deceased::@version@::';
export basc_addr_lFileTemplate	             := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::basc_addr::@version@::';
export client_Data_lFileTemplate	           := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::client_Data::@version@::';	
export std_terms_lu_lFileTemplate	           := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::std_terms_lu::@version@::';
export taxonomy_full_lu_lFileTemplate	       := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::taxonomy_full_lu::@version@::';
export specialty_lu_lFileTemplate	           := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::specialty_lu::@version@::';	
export group_lu_lFileTemplate	               := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::group_lu::@version@::';	
export hospital_lu_lFileTemplate	           := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::hospital_lu::@version@::';	
export dea_xref_lFileTemplate	               := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::dea_xref::@version@::';
export lic_xref_lFileTemplate	               := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::lic_xref::@version@::';
export facility_name_xref_lFileTemplate	     := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::facility_name_xref::@version@::';
export addr_name_xref_lFileTemplate	         := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::addr_name_xref::@version@::';
export basc_facility_mme_lFileTemplate	     := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::basc_facility_mme::@version@::';
export nanpa_lFileTemplate	                 := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::nanpa::@version@::';
export best_hospital_lFileTemplate	         := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::best_hospital::@version@::';
export last_name_stats_lFileTemplate	       := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::last_name_stats::@version@::';	
export source_confidence_lu_lFileTemplate	   := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::source_confidence_lu::@version@::';	
export office_attributes_facility_lFileTemplate	   := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::office_attributes_facility::@version@::';
export office_attributes_lFileTemplate	     := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::office_attributes::@version@::';	
export ignore_terms_lu_lFileTemplate	       := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::ignore_term_lu::@version@::';	
export taxon_lu_lFileTemplate	               := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::taxon_lu::@version@::';
export abbr_lu_lFileTemplate	               := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::abbr_lu::@version@::';	
export call_queue_bad_lFileTemplate	         := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::call_queue_bad::@version@::';
export medschool_lFileTemplate	             := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::medschool::@version@::';
export medschool_wordlist_lFileTemplate	     := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::medschool_wordlist::@version@::';
export non_medschool_lFileTemplate	             := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::non_medschool::@version@::';
export non_medschool_wordlist_lFileTemplate	     := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::non_medschool_wordlist::@version@::';


	
	export facility_lgroup_key				        := facility_lFileTemplate + 'group_key';
	export facility_group_key				          := tools.mod_FilenamesBuild(facility_lgroup_key	,pversion);
	export facility_group_dAll_filenames	    := facility_group_key.dAll_filenames;
	
	
	export facility_lsurrogate_key				   := facility_lFileTemplate + 'surrogate_key';
	export facility_surrogate_key				     := tools.mod_FilenamesBuild(facility_lsurrogate_key	,pversion);
	export facility_surrogate_dAll_filenames := facility_surrogate_key.dAll_filenames;

	export facility_laddr_key				         := facility_lFileTemplate + 'addr_key';
	export facility_addr_key				         := tools.mod_FilenamesBuild(facility_laddr_key	,pversion);
	export facility_addr_dAll_filenames	     := facility_addr_key.dAll_filenames;
	
	export facility_ljoin_group_key	         := facilityjoin_grpkey_lFileTemplate + 'group_key';
	export facility_join_group_key				         := tools.mod_FilenamesBuild(facility_ljoin_group_key	,pversion);
	export facility_join_group_key_dAll_filenames	 := facility_join_group_key.dAll_filenames;
	
	
	export facility_ljoin_filecode_key	         := facilityjoin_grpkey_lFileTemplate + 'filecode_key';
	export facility_join_filecode_key				     := tools.mod_FilenamesBuild(facility_ljoin_filecode_key	,pversion);
	export facility_join_filecode_key_dAll_filenames	 := facility_join_filecode_key.dAll_filenames;
	
	
	//export facility	                        := facility_addr_key.dAll_filenames + facility_group_key.dAll_filenames;
	
	export individual_lgroup_key		         := individual_lFileTemplate + 'group_key';
	export individual_group_key			         := tools.mod_FilenamesBuild(individual_lgroup_key	,pversion);
	export individual_group_dAll_filenames	 := individual_group_key.dAll_filenames;
	
	export individual_lsurrogate_key				 := individual_lFileTemplate + 'surrogate_key';
	export individual_surrogate_key				   := tools.mod_FilenamesBuild(individual_lsurrogate_key	,pversion);
	export individual_surrogate_dAll_filenames	:= individual_surrogate_key.dAll_filenames;


	export individual_ljoin_group_key	         := individualjoin_grpkey_lFileTemplate + 'group_key';
	export individual_join_group_key				         := tools.mod_FilenamesBuild(individual_ljoin_group_key	,pversion);
	export individual_join_group_key_dAll_filenames	 := individual_join_group_key.dAll_filenames;
	
	
 	export basc_cp_lgroup_key		         := basc_cp_lFileTemplate + 'group_key';
  export basc_cp_group_key			         := tools.mod_FilenamesBuild(basc_cp_lgroup_key	,pversion);
	export basc_cp_group_dAll_filenames	   := basc_cp_group_key.dAll_filenames;
	
	export basc_cp_lsurrogate_key				   := basc_cp_lFileTemplate + 'surrogate_key';
	export basc_cp_surrogate_key				   := tools.mod_FilenamesBuild(basc_cp_lsurrogate_key	,pversion);
	export basc_cp_surrogate_dAll_filenames	:= basc_cp_surrogate_key.dAll_filenames;

	
  export basc_claims_lgroup_key		         := basc_claims_lFileTemplate + 'group_key';	
	export basc_claims_group_key			        := tools.mod_FilenamesBuild(basc_claims_lgroup_key	,pversion);
	export basc_claims_group_dAll_filenames	 := basc_claims_group_key.dAll_filenames;
	
	export basc_claims_lsurrogate_key				 := basc_claims_lFileTemplate + 'surrogate_key';
	export basc_claims_surrogate_key				  := tools.mod_FilenamesBuild(basc_claims_lsurrogate_key	,pversion);
	export basc_claims_surrogate_dAll_filenames	:= basc_claims_surrogate_key.dAll_filenames;

	
	
	
	
	export npi_extension_lnpi_num_key		     :=  npi_extension_lFileTemplate + 'npi_num';
	export npi_extension_npi_num_key			   := tools.mod_FilenamesBuild(npi_extension_lnpi_num_key	,pversion);
	export npi_extension_npi_num_dAll_filenames	:= npi_extension_npi_num_key.dAll_filenames;
	
	
	export npi_extension_facility_lnpi_num_key		:=  npi_extension_facility_lFileTemplate + 'npi_num';
	export npi_extension_facility_npi_num_key			:= tools.mod_FilenamesBuild(npi_extension_facility_lnpi_num_key	,pversion);
	export npi_extension_facility_npi_num_dAll_filenames	:= npi_extension_facility_npi_num_key.dAll_filenames;
	
	
	export claims_addr_master_lbill_tin_key		        := claims_addr_master_lFileTemplate + 'bill_tin';
	export claims_addr_master_bill_tin_key			      := tools.mod_FilenamesBuild(claims_addr_master_lbill_tin_key	,pversion);
	export claims_addr_master_bill_tin_dAll_filenames	:= claims_addr_master_bill_tin_key.dAll_filenames;
	
	export claims_addr_master_lbill_npi_key		        := claims_addr_master_lFileTemplate + 'bill_npi';
	export claims_addr_master_bill_npi_key			      := tools.mod_FilenamesBuild(claims_addr_master_lbill_npi_key	,pversion);
	export claims_addr_master_bill_npi_dAll_filenames	:= claims_addr_master_bill_npi_key.dAll_filenames;
  	
	export claims_addr_master_lrendering_npi_key		       := claims_addr_master_lFileTemplate + 'rendering_npi';
	export claims_addr_master_rendering_npi_key			       := tools.mod_FilenamesBuild(claims_addr_master_lrendering_npi_key	,pversion);
	export claims_addr_master_rendering_npi_dAll_filenames := claims_addr_master_rendering_npi_key.dAll_filenames;
	
	
	
	export claims_by_month_lbill_tin_key		        :=  claims_by_month_lFileTemplate + 'bill_tin';
	export claims_by_month_bill_tin_key			        := tools.mod_FilenamesBuild(claims_by_month_lbill_tin_key	,pversion);
	export claims_by_month_bill_tin_dAll_filenames	:= claims_by_month_bill_tin_key.dAll_filenames;
	
	

	
	export npi_tin_xref_lbill_npi_key		        :=  npi_tin_xref_lFileTemplate + 'bill_npi';
	export npi_tin_xref_bill_npi_key		        := tools.mod_FilenamesBuild(npi_tin_xref_lbill_npi_key	,pversion);
	export npi_tin_xref_bill_npi_dAll_filenames	:= npi_tin_xref_bill_npi_key.dAll_filenames;
	
	export taxonomy_equiv_ltaxonomy_key		      :=  taxonomy_equiv_lFileTemplate + 'taxonomy';
	export taxonomy_equiv_taxonomy_key			    := tools.mod_FilenamesBuild(taxonomy_equiv_ltaxonomy_key	,pversion);
	export taxonomy_equiv_taxonomy_dAll_filenames	:= taxonomy_equiv_taxonomy_key.dAll_filenames;
	
	
	export basc_deceased_lgroup_key		        :=  basc_deceased_lFileTemplate + 'group_key';
	export basc_deceased_group_key		        := tools.mod_FilenamesBuild(basc_deceased_lgroup_key	,pversion);
	export basc_deceased_group_dAll_filenames	:= basc_deceased_group_key.dAll_filenames;
	
	export basc_addr_lsurrogate_key		        :=  basc_addr_lFileTemplate + 'surrogate_key';
	export basc_addr_surrogate_key		        := tools.mod_FilenamesBuild(basc_addr_lsurrogate_key	,pversion);
	export basc_addr_surrogate_dAll_filenames	:= basc_addr_surrogate_key.dAll_filenames;
	
	export client_Data_lsurrogate_key		        :=  client_Data_lFileTemplate + 'surrogate_key';
	export client_Data_surrogate_key		        := tools.mod_FilenamesBuild(client_Data_lsurrogate_key	,pversion);
	export client_Data_surrogate_dAll_filenames	:= client_Data_surrogate_key.dAll_filenames;
	
	export std_terms_lu_lcode_key		           :=  std_terms_lu_lFileTemplate + 'code';
	export std_terms_lu_code_key		             := tools.mod_FilenamesBuild(std_terms_lu_lcode_key	,pversion);
	export std_terms_lu_code_dAll_filenames	   := std_terms_lu_code_key.dAll_filenames;
	
	export taxonomy_full_lu_ltaxonomy_key		        :=  taxonomy_full_lu_lFileTemplate + 'taxonomy';
	export taxonomy_full_lu_taxonomy_key		        := tools.mod_FilenamesBuild(taxonomy_full_lu_ltaxonomy_key	,pversion);
	export taxonomy_full_lu_taxonomy_dAll_filenames	:= taxonomy_full_lu_taxonomy_key.dAll_filenames;
	
	export specialty_lu_lspecialty_key		          :=  specialty_lu_lFileTemplate + 'specialty';
	export specialty_lu_specialty_key		            := tools.mod_FilenamesBuild(specialty_lu_lspecialty_key	,pversion);
	export specialty_lu_specialty_dAll_filenames	  := specialty_lu_specialty_key.dAll_filenames;
	
	export group_lu_lcode_key		                  :=  group_lu_lFileTemplate + 'code';
	export group_lu_code_key		                  := tools.mod_FilenamesBuild(group_lu_lcode_key	,pversion);
	export group_lu_code_dAll_filenames	          := group_lu_code_key.dAll_filenames;
	
	export hospital_lu_lcode_key		        			:=  hospital_lu_lFileTemplate + 'code';
	export hospital_lu_code_key		        				:= tools.mod_FilenamesBuild(hospital_lu_lcode_key	,pversion);
	export hospital_lu_code_dAll_filenames	      := hospital_lu_code_key.dAll_filenames;
	
	export dea_xref_lgroup_key		                :=  dea_xref_lFileTemplate + 'group_key';
	export dea_xref_group_key		                  := tools.mod_FilenamesBuild(dea_xref_lgroup_key	,pversion);
	export dea_xref_group_dAll_filenames	        := dea_xref_group_key.dAll_filenames;
	
	export lic_xref_lgroup_key		        				:=  lic_xref_lFileTemplate + 'group_key';
	export lic_xref_group_key		        					:= tools.mod_FilenamesBuild(lic_xref_lgroup_key	,pversion);
	export lic_xref_group_dAll_filenames	       	:= lic_xref_group_key.dAll_filenames;
	
	
	export facility_name_xref_ltaxonomy_key		        :=  facility_name_xref_lFileTemplate + 'taxonomy';
	export facility_name_xref_taxonomy_key		        := tools.mod_FilenamesBuild(facility_name_xref_ltaxonomy_key	,pversion);
	export facility_name_xref_taxonomy_dAll_filenames := facility_name_xref_taxonomy_key.dAll_filenames;
	
	export addr_name_xref_lgroup_key		             :=  addr_name_xref_lFileTemplate + 'group_key';
	export addr_name_xref_group_key		               := tools.mod_FilenamesBuild(addr_name_xref_lgroup_key	,pversion);
	export addr_name_xref_group_dAll_filenames	     := addr_name_xref_group_key.dAll_filenames;
	
	export basc_facility_mme_lgroup_key		        :=  basc_facility_mme_lFileTemplate + 'group_key';
	export basc_facility_mme_group_key		        := tools.mod_FilenamesBuild(basc_facility_mme_lgroup_key	,pversion);
	export basc_facility_mme_group_dAll_filenames	:= basc_facility_mme_group_key.dAll_filenames;
	
	
	export nanpa_lnpa_num_key		                    := nanpa_lFileTemplate + 'npa_num';
	export nanpa_npa_num_key		                    := tools.mod_FilenamesBuild(nanpa_lnpa_num_key	,pversion);
	export nanpa_npa_num_dAll_filenames	            := nanpa_npa_num_key.dAll_filenames;

  export best_hospital_laddr_key		            :=  best_hospital_lFileTemplate + 'addr_key';
	export best_hospital_addr_key		              := tools.mod_FilenamesBuild(best_hospital_laddr_key	,pversion);
	export best_hospital_addr_dAll_filenames	    := best_hospital_addr_key.dAll_filenames;
	
	export last_name_stats_llast_name_key	          :=  last_name_stats_lFileTemplate + 'last_name';
	export last_name_stats_last_name_key		        := tools.mod_FilenamesBuild(last_name_stats_llast_name_key	,pversion);
	export last_name_stats_last_name_dAll_filenames := last_name_stats_last_name_key.dAll_filenames;

  export source_confidence_lu_lfile_code_key		        :=  source_confidence_lu_lFileTemplate + 'filecode';
	export source_confidence_lu_file_code_key		        := tools.mod_FilenamesBuild(source_confidence_lu_lfile_code_key	,pversion);
	export source_confidence_lu_file_code_dAll_filenames	:= source_confidence_lu_file_code_key.dAll_filenames;
	
  export office_attributes_facility_lsurrogate_key		        :=  office_attributes_facility_lFileTemplate + 'surrogate_key';
	export office_attributes_facility_surrogate_key		          := tools.mod_FilenamesBuild(office_attributes_facility_lsurrogate_key	,pversion);
	export office_attributes_facility_surrogate_dAll_filenames	:= office_attributes_facility_surrogate_key.dAll_filenames;
	
	export office_attributes_lsurrogate_key		        :=  office_attributes_lFileTemplate + 'surrogate_key';
	export office_attributes_surrogate_key		        := tools.mod_FilenamesBuild(office_attributes_lsurrogate_key	,pversion);
	export office_attributes_surrogate_dAll_filenames	:= office_attributes_surrogate_key.dAll_filenames;


  export ignore_terms_lu_lcode_key		        :=  ignore_terms_lu_lFileTemplate + 'code';
	export ignore_terms_lu_code_key		        := tools.mod_FilenamesBuild(ignore_terms_lu_lcode_key,pversion);
	export ignore_terms_lu_code_dAll_filenames	:= ignore_terms_lu_code_key.dAll_filenames;
	
	
	export taxon_lu_lcode_key		        :=  taxon_lu_lFileTemplate + 'code';
	export taxon_lu_code_key		        := tools.mod_FilenamesBuild(taxon_lu_lcode_key,pversion);
	export taxon_lu_code_dAll_filenames	:= taxon_lu_code_key.dAll_filenames;
	
	export abbr_lu_lcode_key		        :=  abbr_lu_lFileTemplate + 'code';
	export abbr_lu_code_key		          := tools.mod_FilenamesBuild(abbr_lu_lcode_key,pversion);
	export abbr_lu_code_dAll_filenames	:= abbr_lu_code_key.dAll_filenames;
	
	
	
	export call_queue_bad_lphone_key		        :=  call_queue_bad_lFileTemplate + 'prac_phone1';
	export call_queue_bad_phone_key		        := tools.mod_FilenamesBuild(call_queue_bad_lphone_key,pversion);
	export call_queue_bad_phone_dAll_filenames	:= call_queue_bad_phone_key.dAll_filenames;
	
	export medschool_lmsid_key		        :=  medschool_lFileTemplate + 'msid';
	export medschool_msid_key		          := tools.mod_FilenamesBuild(medschool_lmsid_key,pversion);
	export medschool_msid_dAll_filenames	:= medschool_msid_key.dAll_filenames;

  export medschool_wordlist_lword_key		        :=  medschool_wordlist_lFileTemplate + 'words';
	export medschool_wordlist_word_key		        := tools.mod_FilenamesBuild(medschool_wordlist_lword_key,pversion);
	export medschool_wordlist_word_dAll_filenames	:= medschool_wordlist_word_key.dAll_filenames;

  export non_medschool_lmsid_key		        :=  non_medschool_lFileTemplate + 'msid';
	export non_medschool_msid_key		          := tools.mod_FilenamesBuild(non_medschool_lmsid_key,pversion);
	export non_medschool_msid_dAll_filenames	:= non_medschool_msid_key.dAll_filenames;

  export non_medschool_wordlist_lword_key		        :=  non_medschool_wordlist_lFileTemplate + 'words';
	export non_medschool_wordlist_word_key		        := tools.mod_FilenamesBuild(non_medschool_wordlist_lword_key,pversion);
	export non_medschool_wordlist_word_dAll_filenames	:= non_medschool_wordlist_word_key.dAll_filenames;

/* 	export lFileTemplate	    := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::@version@::'	;
   	
   	export lDid			:= lFileTemplate + 'did'		;
   
   	export Did		:= tools.mod_FilenamesBuild(ldid	,pversion);
   
   	export dAll_filenames := 
   
   		Did.dAll_filenames
   		;
*/

end;