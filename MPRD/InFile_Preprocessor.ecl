IMPORT MPRD, ut, lib_stringlib;
EXPORT InFile_Preprocessor(string pversion, boolean pUseProd) := MODULE

	EXPORT Prepped_Basc_Claims	:= FUNCTION
		std_input := project(MPRD.Files(pversion,pUseProd).basc_claims_file, 
				transform(mprd.layouts.basc_claims_in, 
									self.isTest := false, 
									self.lic1_begin_date	:= trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic1_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
									self.lic1_end_date		:= trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic1_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),;
									self.last_update_date	:= trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.last_update_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
									self.npi_deact_date		:= trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.npi_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
									self := Left));
		qa_input	:= project(MPRD.Files().basc_claims_qa_test_file, transform(mprd.layouts.basc_claims_in, self.isTest := true, self := Left));
		return std_input + qa_input;
	END;
	
	EXPORT Prepped_Choice_Point	:= FUNCTION
		std_input	:= project(MPRD.Files(pversion,pUseProd).basc_cp_file, 
					transform(mprd.layouts.choice_point_in, 
							self.isTest := false, 
							self.lic1_begin_date			:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic1_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic1_end_date				:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic1_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic2_begin_date			:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic2_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic2_end_date				:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic2_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic3_begin_date			:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic3_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic3_end_date				:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic3_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic4_begin_date			:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic4_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic4_end_date				:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic4_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic5_begin_date			:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic5_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic5_end_date				:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic5_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.birthdate						:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.birthdate,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.sanc1_date						:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.sanc1_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.sanc2_date						:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.sanc2_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.sanc3_date						:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.sanc3_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.sanc4_date						:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.sanc4_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.sanc5_date						:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.sanc5_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.sanc6_date						:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.sanc6_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.sanc7_date						:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.sanc7_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.sanc8_date						:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.sanc8_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.sanc9_date						:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.sanc9_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.sanc10_date					:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.sanc10_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.date_of_death				:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.date_of_death,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.last_update_date			:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.last_update_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.dea_num1_deact_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.dea_num1_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.dea_num2_deact_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.dea_num2_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.dea_num3_deact_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.dea_num3_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.dea_num4_deact_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.dea_num4_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.dea_num5_deact_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.dea_num5_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.dea_num6_deact_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.dea_num6_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.dea_num7_deact_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.dea_num7_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.dea_num8_deact_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.dea_num8_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.dea_num9_deact_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.dea_num9_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.dea_num10_deact_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.dea_num10_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.npi_deact_date				:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.npi_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.sanc1_rein_date			:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.sanc1_rein_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.sanc2_rein_date			:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.sanc2_rein_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.sanc3_rein_date			:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.sanc3_rein_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.sanc4_rein_date			:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.sanc4_rein_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.sanc5_rein_date			:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.sanc5_rein_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.sanc6_rein_date			:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.sanc6_rein_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.sanc7_rein_date			:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.sanc7_rein_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.sanc8_rein_date			:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.sanc8_rein_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.sanc9_rein_date			:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.sanc9_rein_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.sanc10_rein_date			:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.sanc10_rein_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.dea_num1_exp					:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.dea_num1_exp,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.dea_num2_exp         :=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.dea_num2_exp,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.dea_num3_exp         :=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.dea_num3_exp,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.dea_num4_exp         :=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.dea_num4_exp,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.dea_num5_exp         :=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.dea_num5_exp,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.dea_num6_exp         :=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.dea_num6_exp,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.dea_num7_exp         :=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.dea_num7_exp,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.dea_num8_exp         :=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.dea_num8_exp,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.dea_num9_exp         :=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.dea_num9_exp,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.dea_num10_exp         :=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.dea_num10_exp,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),				
							self := Left));
		qa_input	:= project(MPRD.Files().basc_cp_qa_test_file, transform(mprd.layouts.choice_point_in, self.isTest := true, self := Left));
		return std_input + qa_input;
	END;
		
	EXPORT Prepped_Basc_Deceased	:= FUNCTION
		std_input := project(MPRD.Files(pversion,pUseProd).basc_deceased_file, 
				transform(mprd.layouts.basc_deceased_in, 
							self.isTest := false, 
							self.birthdate								:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.birthdate,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.date_of_death						:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.date_of_death,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.incomplete_date_of_death	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.incomplete_date_of_death,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self := Left));
		qa_input	:= project(MPRD.Files().basc_deceased_qa_test_file, transform(mprd.layouts.basc_deceased_in, self.isTest := true, self := Left));
		return std_input + qa_input;
	END;
	
	EXPORT Prepped_Facility	:= FUNCTION
		std_input := project(MPRD.Files(pversion,pUseProd).fac_basc_file, 
				transform(mprd.layouts.facility_in, 
							self.isTest := false, 
							self.lic1_begin_date						:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic1_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic1_end_date							:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic1_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic2_begin_date						:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic2_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic2_end_date							:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic2_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic3_begin_date						:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic3_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic3_end_date							:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic3_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.medicare_fac_num_term_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.medicare_fac_num_term_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.last_update_date						:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.last_update_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.sanc1_date									:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.sanc1_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.dea_num1_deact_date				:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.dea_num1_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.npi_deact_date							:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.npi_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.sanc1_rein_date						:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.sanc1_rein_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.clia_cert_eff_date					:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.clia_cert_eff_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.clia_end_date							:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.clia_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),							
							self.dea_num1_exp								:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.dea_num1_exp,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self := Left));
		qa_input	:= project(MPRD.Files().fac_basc_qa_test_file, transform(mprd.layouts.facility_in, self.isTest := true, self := Left));
		return std_input + qa_input;
	END;
	
	EXPORT Prepped_Basc_Facility_mme	:= FUNCTION
		std_input := project(MPRD.Files(pversion,pUseProd).basc_facility_mme_file, transform(mprd.layouts.basc_facility_mme_in, self.isTest := false, self := Left));
		qa_input	:= project(MPRD.Files().basc_facility_mme_qa_test_file, transform(mprd.layouts.basc_facility_mme_in, self.isTest := true, self := Left));
		return std_input + qa_input;
  END;
	
	EXPORT Prepped_Individual	:= FUNCTION
		std_input := project(MPRD.Files(pversion,pUseProd).idv_basc_file, 
				transform(mprd.layouts.individual_in, 
							self.isTest := false, 
							self.birthdate								:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.birthdate,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic1_begin_date					:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic1_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic1_end_date						:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic1_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic2_begin_date					:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic2_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic2_end_date						:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic2_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic3_begin_date					:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic3_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic3_end_date						:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic3_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.sanc1_date								:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.sanc1_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.date_of_death						:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.date_of_death,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.last_update_date					:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.last_update_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.abms_start_eff_date			:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.abms_start_eff_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.abms_end_eff_date				:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.abms_end_eff_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.dea_num1_deact_date			:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.dea_num1_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.npi_deact_date						:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.npi_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),		
							self.sanc1_rein_date					:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.sanc1_rein_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.medicare_optout_eff_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.medicare_optout_eff_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.medicare_optout_end_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.medicare_optout_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.dea_num1_exp							:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.dea_num1_exp,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self := Left));
		qa_input	:= project(MPRD.Files().idv_basc_qa_test_file, transform(mprd.layouts.individual_in, self.isTest := true, self := Left));
		return std_input + qa_input;
	END;
	
	EXPORT Prepped_Best_Hospital	:= FUNCTION
		std_input := project(MPRD.Files(pversion,pUseProd).best_hospital_file, transform(mprd.layouts.best_hospital_in, self.isTest := false, self := Left));
		qa_input	:= project(MPRD.Files().best_hospital_qa_test_file, transform(mprd.layouts.best_hospital_in, self.isTest := true, self := Left));
		return std_input + qa_input;
	END;
        
	EXPORT Prepped_Claims_Address_Master	:= FUNCTION
		std_input := project(MPRD.Files(pversion,pUseProd).claims_addr_master_file, 
				transform(mprd.layouts.claims_address_master_in, 
							self.isTest := false, 
							self.latest_clm_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.latest_clm_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.earliest_clm_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.earliest_clm_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.insert_date				:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.insert_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self := Left));
		qa_input	:= project(MPRD.Files().claims_addr_master_qa_test_file, transform(mprd.layouts.claims_address_master_in, self.isTest := true, self := Left));
		return std_input + qa_input;
	END;
	
	EXPORT Prepped_Claims_By_Month	:= FUNCTION
		std_input := project(MPRD.Files(pversion,pUseProd).claims_by_month_file, transform(mprd.layouts.claims_by_month_in, self.isTest := false, self := Left));
		qa_input	:= project(MPRD.Files().claims_by_month_qa_test_file, transform(mprd.layouts.claims_by_month_in, self.isTest := true, self := Left));
		return std_input + qa_input;
	END;
	
	EXPORT Prepped_CMS_ECP	:= FUNCTION
		std_input := project(MPRD.Files(pversion,pUseProd).cms_ecp_file, transform(mprd.layouts.cms_ecp_in, self.isTest := false, self := Left));
		qa_input	:= project(MPRD.Files().cms_ecp_qa_test_file, transform(mprd.layouts.cms_ecp_in, self.isTest := true, self := Left));
		return std_input + qa_input;
	END;

	EXPORT Prepped_Group_lu	:= FUNCTION
		std_input := project(MPRD.Files(pversion,pUseProd).group_lu_file, transform(mprd.layouts.group_lu_in, self.isTest := false, self := Left));
		qa_input 	:= project(MPRD.Files().group_lu_qa_test_file, transform(mprd.layouts.group_lu_in, self.isTest := true, self := Left));
		return std_input + qa_input;
	END;
	
	EXPORT Prepped_Hospital_lu	:= FUNCTION
		std_input	:= project(MPRD.Files(pversion,pUseProd).hospital_lu_file, transform(mprd.layouts.hospital_lu_in, self.isTest := false, self := Left));
		qa_input	:= project(MPRD.Files().hospital_lu_qa_test_file, transform(mprd.layouts.hospital_lu_in, self.isTest := true, self := Left));
		return std_input + qa_input;
	END;
	
	EXPORT Prepped_Lic_filedate	:= FUNCTION
		std_input := project(MPRD.Files(pversion,pUseProd).lic_filedate_file, 
				transform(mprd.layouts.lic_filedate_in, 
						self.isTest := false, 
						self.filedate := trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.filedate,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right), 						
						self := Left));
		qa_input  := project(MPRD.Files().lic_filedate_qa_test_file, transform(MPRD.layouts.lic_filedate_in, self.isTest := true, self := Left));
		return std_input + qa_input;
	END;

	EXPORT Prepped_nanpa	:= FUNCTION
		std_input := project(MPRD.Files(pversion,pUseProd).nanpa_file, 
				transform(mprd.layouts.nanpa_in, 
							self.isTest := false, 
							self.effective_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.effective_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.assign_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.assign_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self := Left));
		qa_input	:= project(MPRD.Files().nanpa_qa_test_file, transform(MPRD.layouts.nanpa_in, self.isTest := true, self	:= Left));
		return std_input + qa_input;
	END;
	
	EXPORT Prepped_npi_extension	:= FUNCTION
		std_input	:= project(MPRD.Files(pversion,pUseProd).npi_extension_file, 
				transform(mprd.layouts.npi_extension_in, 
							self.isTest := false, 
							self.lic1_begin_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic1_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic1_end_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic1_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic2_begin_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic2_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic2_end_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic2_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic3_begin_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic3_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic3_end_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic3_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic4_begin_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic4_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic4_end_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic4_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic5_begin_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic5_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic5_end_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic5_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic6_begin_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic6_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic6_end_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic6_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic7_begin_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic7_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic7_end_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic7_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic8_begin_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic8_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic8_end_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic8_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic9_begin_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic9_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic9_end_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic9_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic10_begin_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic10_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic10_end_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic10_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic11_begin_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic11_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic11_end_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic11_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic12_begin_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic12_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic12_end_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic12_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic13_begin_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic13_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic13_end_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic13_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic14_begin_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic14_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic14_end_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic14_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic15_begin_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic15_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic15_end_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic15_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.npi_deact_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.npi_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.npi_enum_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.npi_enum_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.npi_react_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.npi_react_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),						
							self := Left));
		qa_input	:= project(MPRD.Files().npi_extension_qa_test_file, transform(MPRD.layouts.npi_extension_in, self.isTest := true, self := Left));
		return std_input + qa_input;
	END;
	
	EXPORT Prepped_npi_extension_facility	:= FUNCTION
		std_input	:= project(MPRD.Files(pversion,pUseProd).npi_extension_facility_file, 
					transform(mprd.layouts.npi_extension_facility_in, 
							self.istest := false, 
							self.lic1_begin_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic1_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic1_end_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic1_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic2_begin_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic2_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic2_end_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic2_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic3_begin_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic3_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic3_end_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic3_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic4_begin_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic4_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic4_end_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic4_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic5_begin_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic5_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic5_end_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic5_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic6_begin_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic6_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic6_end_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic6_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic7_begin_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic7_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic7_end_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic7_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic8_begin_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic8_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic8_end_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic8_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic9_begin_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic9_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic9_end_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic9_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic10_begin_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic10_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic10_end_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic10_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic11_begin_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic11_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic11_end_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic11_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic12_begin_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic12_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic12_end_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic12_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic13_begin_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic13_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic13_end_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic13_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic14_begin_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic14_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic14_end_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic14_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic15_begin_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic15_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.lic15_end_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.lic15_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.npi_deact_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.npi_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.npi_enum_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.npi_enum_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self.npi_react_date		:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.npi_react_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self := Left));
		qa_input	:= project(MPRD.Files().npi_extension_facility_qa_test_file, transform(MPRD.layouts.npi_extension_facility_in, self.isTest := true, self := Left));
		return std_input + qa_input;
	END;
	
	EXPORT Prepped_npi_tin_xref	:= FUNCTION
		std_input := project(MPRD.Files(pversion,pUseProd).npi_tin_xref_file, transform(mprd.layouts.npi_tin_xref_in, self.isTest := false, self := Left));
		qa_input  := project(MPRD.Files().npi_tin_xref_qa_test_file, transform(MPRD.layouts.npi_tin_xref_in, self.isTest := true, self := Left));
		return std_input + qa_input;
	END;
	
	EXPORT Prepped_office_attributes	:= FUNCTION
		std_input	:= project(MPRD.Files(pversion,pUseProd).office_attributes_file, transform(mprd.layouts.office_attributes_in, self.isTest := false, self := Left));
		qa_input	:= project(MPRD.Files().office_attributes_qa_test_file, transform(MPRD.layouts.office_attributes_in, self.isTest := true, self := Left));
		return std_input + qa_input;
	END;
	
	EXPORT Prepped_office_attributes_facility	:= FUNCTION
		std_input := MPRD.Files(pversion,pUseProd).office_attributes_facility_file;
		qa_input 	:= project(MPRD.Files().office_attributes_facility_qa_test_file, transform(MPRD.layouts.office_attributes_facility_in, self.isTest := true, self := Left));
		return std_input + qa_input;
	END;
	
	EXPORT Prepped_opi	:= FUNCTION
		std_input	:= project(MPRD.Files(pversion,pUseProd).opi_file, transform(mprd.layouts.opi_in, self.isTest := false, self := Left));
		qa_input	:= project(MPRD.Files().opi_qa_test_file, transform(MPRD.layouts.opi_in, self.isTest := true, self := Left));
		return std_input + qa_input;
	END;
	
	EXPORT Prepped_opi_facility	:= FUNCTION
		std_input	:= project(MPRD.Files(pversion,pUseProd).opi_facility_file, transform(mprd.layouts.opi_facility_in, self.isTest := false, self := Left));
		qa_input	:= project(MPRD.Files().opi_facility_qa_test_file, transform(MPRD.layouts.opi_facility_in, self.isTest := true, self := Left));
		return std_input + qa_input;
	END;
	
	EXPORT Prepped_source_confidence_lu	:= FUNCTION
		std_input := project(MPRD.Files(pversion,pUseProd).source_confidence_lu_file, 
					transform(mprd.layouts.source_confidence_lu_in, 
							self.isTest := false, 
							self.audit_date	:=	trim(Stringlib.StringCleanSpaces(stringlib.stringfilterout(Left.audit_date,'-&#.^!$+<>@=%?*/:;[]#\\')),Left, Right),
							self := Left));
		qa_input	:= project(MPRD.Files().source_confidence_lu_qa_test_file, transform(MPRD.layouts.source_confidence_lu_in, self.isTest := true, self := Left));
		return std_input + qa_input;
	END;
END;