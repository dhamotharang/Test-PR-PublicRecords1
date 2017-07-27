IMPORT idl_header;


BOOLEAN isCustTestEnv           := FALSE:STORED('CustomerTestEnv');

// Insurance Header
iHeader := dataset([], idl_header.Layout_Header_Link);

hdr0 := project(iHeader,
					transform(IDL_Header.layout_xlink, 								
								STRING5 ssn5_temp := (STRING)LEFT.SSN[1..5];
								STRING4 ssn4_temp := (STRING)LEFT.SSN[6..9];
								SELF.ssn5 := if (ssn5_temp <> '00000', ssn5_temp, '');
								SELF.ssn4 := if (ssn4_temp <> '0000', ssn4_temp, '');
								SELF := LEFT));

EXPORT File_InsuranceHeader 	:= if(isCustTestEnv, CustTest_Header, hdr0)  ;
