Import did_add;

matchset 	:= ['A','Z','S','D'];

did_add.MAC_Match_Flex(WorldCompliance.dsPrepForLinking,
											 matchset,
											 SSN,
											 Clean_Dob, 
											 FName,
											 MiddleName,
											 LastName,
											 Suffix,
											 Clean_prim_range,
											 Clean_prim_name,
											 Clean_sec_range,
											 Clean_ZipCode,
											 Clean_StateProvince,
											 '', 
											 LexId,
											 rAsciiUSNamesANDAddress,
											 false,
											 DID_Score_field,
											 75,
											 dsLexIdTemp);
											 
EXPORT dsLexIds := dsLexIdTemp;

