// ******************************  IMPORTANT NOTE ***************************************************
// Before this build is run the first time, spec_to_pt_yyyymmdd file must be imported and processed into creating the following file
// '~Thor400_Data::IN::HMS::SureScripts::SpecCodes::SpecDetails'. This build assumes that this file exists.
// ******************************  IMPORTANT NOTE ***************************************************

IMPORT  HMS_SureScripts;

EXPORT Build_SpecialtyCodes( string	pversion, boolean pUseProd = false) := module
		EXPORT DoTheBuild (string pversion, boolean pUseProd) := FUNCTION

			std_input	:= HMS_SureScripts.Update_Specialty_base(pversion,pUseProd)._base;
			//SpecCodes_Details := Dataset('~Thor400_Data::IN::HMS::SureScripts::SpecCodes::SpecDetails',HMS_SureScripts.Layouts.SpecDetails, csv( separator('\t'),heading(1), terminator(['\n', '\r\n']), quote('"')));
			SpecCodes_Base := HMS_SureScripts.Files(pVersion).Spec_Details_base;
			SpecCodes_Details := Dataset(SpecCodes_Base, HMS_SureScripts.Layouts.SpecDetails, THOR);
			std_input_S := SORT(std_input, Out_Code);
			SpecCodes_Details_S := SORT(SpecCodes_Details, Spec_Code);
		
			HMS_SureScripts.Layouts.Base_SpecialtyCodes xform( std_input_S L,  SpecCodes_Details_S R) := Transform
				SELF.In_Code := L.In_Code;
				SELF.Spec_Code := R.Spec_Code;
				SELF.Spec_Desc := R.Spec_Desc;
				SELF.Activity_Code := R.Activity_Code;
				SELF.Practice_Type_Code := R.Practice_Type_Code;
				SELF.Practice_Type_Desc := R.Practice_Type_Desc;
				SELF.record_type := L.record_type;
				SELF.dt_vendor_first_reported := L.dt_vendor_first_reported; 
				SELF.dt_vendor_last_reported := L.dt_vendor_last_reported;
			end;

			Matched_T := JOIN(std_input_S, SpecCodes_Details_S, LEFT.Out_Code = RIGHT.Spec_Code, xform(LEFT,Right), LEFT OUTER);
			
			output(Matched_T,,'~Thor400_Data::BASE::HMS::SureScripts::SpecCodes::SpecialtyCodes', OVERWRITE, THOR);
			return ('All ok');
		END;
		EXPORT Built :=  DoTheBuild (pversion, pUseProd);
end;
