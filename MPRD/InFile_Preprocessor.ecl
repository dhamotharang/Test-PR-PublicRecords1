IMPORT MPRD, ut, lib_stringlib;
EXPORT InFile_Preprocessor(string pversion, boolean pUseProd) := MODULE
	
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
		// qa_input	:= project(MPRD.Files().idv_basc_qa_test_file, transform(mprd.layouts.individual_in, self.isTest := true, self := Left));
		return std_input;// + qa_input;
	END;
	
END;