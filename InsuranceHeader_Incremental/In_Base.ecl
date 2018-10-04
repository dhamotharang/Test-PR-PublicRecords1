IMPORT IDL_Header,insuranceHeader_preprocess;

// dsbase equals to IDL_Header.Files.DS_IDL_POLICY_HEADER_BASE, when latest postprocess running it eauals to father file
	
	dsBase         := InsuranceHeader_Incremental.Files.dsBase; // IDL_Header.Files.DS_IDL_POLICY_HEADER_FATHER;
	
 //Insurance 
 iBase           := dsBase(src[1..3] <> 'ADL');
 iBasenotblank   := iBase(not(fname = '' and lname = ''and prim_name = '' and city = ''));
 iclean_name_adr := insuranceHeader_preprocess.mod_clean_record(iBasenotblank).records;
 iclean_suffix   := insuranceHeader_preprocess.mod_clean_suffix(iclean_name_adr).records;
 	
 Base_Insurance  := PROJECT(iclean_suffix, TRANSFORM({Layout_Base},
                                 validSSN := TRIM(LEFT.ssn) <> '';
				                         validDLN := TRIM(LEFT.dl_nbr) <> ''; 
																 lname_char_space_flag := IF(LEFT.lname[1..2] = 'D ' or LEFT.lname[1..2] = 'L ' or LEFT.lname = 'O ', true, false);
				                         lastName         := IF(lname_char_space_flag = true, StringLib.StringFindReplace(LEFT.lname, LEFT.lname[1..2],LEFT.lname[1]), LEFT.lname);
                                 SELF.lname       := lastName;
																 SELF.src_orig := LEFT.src ; 
																 SELF.src := MAP(LEFT.src[1..3] = 'IVS' => 'IVS', 
																                 LEFT.src[1..3] = 'ICA' => 'ICA',
																								 LEFT.src[1..3] = 'ICP' => 'ICP' , LEFT.src),
																 SELF.ssn         := IF((INTEGER4)LEFT.ssn = 0, '', LEFT.ssn),
																 SELF.dl_nbr		  := IF(validSSN AND validDLN AND (STRING)LEFT.ssn = (STRING)LEFT.dl_nbr, ''  , LEFT.dl_nbr),
				                         SELF.dlno_ind	  := IF(validSSN AND validDLN AND (STRING)LEFT.ssn = (STRING)LEFT.dl_nbr, 'S' , ''), SELF:= LEFT));
																 

//Boca
 Base           := dsBase(src[1..3] = 'ADL' );
 dnotblank      := Base(not(fname = '' and lname = ''and prim_name = '' and city = ''));
 
 clean_name_adr := insuranceHeader_preprocess.mod_clean_record(dnotblank).records;
 clean_suffix   := insuranceHeader_preprocess.mod_clean_suffix(clean_name_adr).records;
 	
 Base_boca := PROJECT(clean_suffix, TRANSFORM({Layout_Base},
                                				SELF.ssn         := IF((INTEGER4)LEFT.ssn = 0, '', LEFT.ssn),SELF.src_orig := LEFT.src,SELF:= LEFT));
															
EXPORT In_Base :=  Base_boca + Base_Insurance ; 