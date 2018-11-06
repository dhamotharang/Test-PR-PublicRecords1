IMPORT idl_header,Std, insuranceHeader_preprocess,Insurance_Headers_CC, Insurance_Header_KSDMV, Insurance_Header_NMDMV, Insurance_Header_NCDMV, InsuranceHeader_postprocess, Insurance_Header_DMV, ClueProperty, Insurance_Header_Auto, Insurance_Header_Property;

EXPORT Add_Update_InsuranceData(dataset(idl_header.Layout_Header_Link) hdr) := MODULE

		dmvRecords    := Add_Update_DMVData(hdr).getRecords;
		mvrRecords    := Add_Update_MVRINQData(hdr).getRecords;
		
		cc_as_header 	:= Insurance_Headers_CC.AsHeader_File_CC(hdr).base_cc_header;
		ca_as_header 	:= Insurance_Header_Auto.AsHeader_File_Auto(hdr).Auto_Header;
		cp_as_header 	:= Insurance_Header_Property.AsHeader_File_Property(hdr).Property_Header;
		
		Joined_header := cc_as_header + ca_as_header + cp_as_header + dmvRecords + mvrRecords ; 
		
		clean_name_adr := insuranceHeader_preprocess.mod_clean_record(Joined_header).records;
		clean_suffix   := insuranceHeader_preprocess.mod_clean_suffix(clean_name_adr).records;
		// INSURANCE CLEANING ONLY
		clean          := PROJECT(clean_suffix, TRANSFORM({Layout_Base}, 
                                 validSSN := TRIM(LEFT.ssn) <> ''; 
				                         validDLN := TRIM(LEFT.dl_nbr) <> ''; 
																 lname_char_space_flag := IF(LEFT.lname[1..2] = 'D ' or LEFT.lname[1..2] = 'L ' or LEFT.lname = 'O ', true, false);
				                         lastName := IF(lname_char_space_flag = true, StringLib.StringFindReplace(LEFT.lname, LEFT.lname[1..2],LEFT.lname[1]), LEFT.lname);
                                 SELF.lname    := lastName;
																 SELF.src_orig := LEFT.src; 
																 SELF.src := MAP(LEFT.src[1..3] = 'IVS' => 'IVS', 
																                 LEFT.src[1..3] = 'ICA' => 'ICA',
																								 LEFT.src[1..3] = 'ICP' => 'ICP' , LEFT.src),
																 SELF.ssn := IF((INTEGER4)LEFT.ssn = 0, '', LEFT.ssn),
                                 SELF.DT_EFFECTIVE_FIRST       := Std.Date.Today() ; 
																 SELF.DT_EFFECTIVE_LAST       := 0 ; 
																 SELF.DID := 0 ;
																 SELF.RID := 0 ; 
																 SELF.dl_nbr		  := IF(validSSN AND validDLN AND (STRING)LEFT.ssn = (STRING)LEFT.dl_nbr, ''  , LEFT.dl_nbr),
				                         SELF.dlno_ind	  := IF(validSSN AND validDLN AND (STRING)LEFT.ssn = (STRING)LEFT.dl_nbr, 'S' , ''), SELF:= LEFT)) ; 

	EXPORT getRecords   := clean ; 
		
END; 
		
