import Address, Ut, lib_stringlib, _Control, business_header,_Validate, mdr,Health_Facility_Services,HealthCareFacility,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, NID, AID, Health_Provider_Services
,Scrubs_SureScripts,Scrubs;

EXPORT Update_Specialty_Base (string filedate, boolean pUseProd = false) := MODULE

	EXPORT Mark_history (pBaseFile, pLayout_base)	:= FUNCTIONMACRO
		pLayout_base hist(pLayout_base L):= TRANSFORM
				SELF.record_type	:= 'H';
				SELF							:= L;
		END;
		RETURN PROJECT(pBaseFile, hist(LEFT));
	ENDMACRO;
	

	EXPORT _Base := FUNCTION
		std_input	:= HMS_SureScripts.StandardizeInputFile_Specialty(filedate,pUseProd).base;
		hist_base := Mark_history(HMS_SureScripts.Specialty_Files(filedate,pUseProd).base.built,HMS_SureScripts.layouts.Base_Spec_Codes);
		cleanAdd_a	:= std_input:PERSIST('~thor400_data::Persist::base::hms::surescripts::SS_Specs');

		base_and_update := if(nothor(FileServices.GetSuperFileSubCount(Filenames_SpecCodes(filedate, pUseProd).lSpecCodesTemplate_Built)) = 0
													 ,cleanAdd_a
													 ,cleanAdd_a  + hist_base); 
														
	new_base_d := distribute(base_and_update, hash(In_Code, Out_Code));  // Need more than these?, Why not just SPI?
	
	new_base_s := sort(new_base_d
		,In_Code
		,Out_Code
	,local);
																	 						
	Layouts.Base_Spec_Codes t_rollup (new_base_s  le, new_base_s ri) := transform
		 self.dt_vendor_first_reported := ut.EarliestDate(le.dt_vendor_first_reported, ri.dt_vendor_first_reported);
		 self.dt_vendor_last_reported  := ut.LatestDate(le.dt_vendor_last_reported, ri.dt_vendor_last_reported);
		 self := if(le.dt_vendor_last_reported > ri.dt_vendor_last_reported,le,ri);
	end;
	base_f := rollup(new_base_s,
									left.In_Code = right.In_Code
									and left.Out_Code = right.Out_Code
									,t_rollup(left, right)
									,local);

		return base_f;
		
	End; //Function
END; // Module

