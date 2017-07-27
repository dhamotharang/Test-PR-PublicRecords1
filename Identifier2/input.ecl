import doxie, AutoHeaderI, AutoStandardI;

doxie.MAC_Header_Field_Declare()
 
export input := module
  export boolean Exact_Last_Name_Match := false : stored('ExactLastNameMatch');
	export boolean	Exact_First_Name_Match := false : stored('ExactFirstNameMatch');
	export boolean	Exact_Addr_Match := false : stored('ExactAddrMatch');
	export boolean	Exact_Phone_Match := false : stored('ExactPhoneMatch');
	export boolean	Exact_DOB_Match := false : stored('ExactDOBMatch');
	export boolean	Exact_SSN_Match := false : stored('ExactSSNMatch');
  export boolean  Exact_Requested := if (Exact_Last_Name_Match or Exact_First_Name_Match or Exact_Addr_Match
                                     or Exact_DOB_Match or Exact_SSN_Match , true, false);
  
	export params := interface(
		AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,
		AutoStandardI.InterfaceTranslator.glb_purpose.params,
		AutoStandardI.InterfaceTranslator.dppa_purpose.params,
		AutoStandardI.InterfaceTranslator.ssn_mask_val.params,
		AutoStandardI.InterfaceTranslator.dl_mask_val.params,
		AutoStandardI.InterfaceTranslator.dob_mask_val.params)
 end;
							
end;