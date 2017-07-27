import business_header, ut,address;
export Clean_n_Validate_Name(

	 string			pName
	,string1		pNameOrder																// 'F' = fml, 'L' = lfm
	,unsigned4	pNameScoreThreshold									= 75	// deprecated with new name cleaner(always returns 99, so it is useless now)
	,unsigned4	pBusiness_HeaderCleanNameThreshold	= 3
	,boolean		pRequiresCommaInLastName						= false					

) :=
function

	clean_person_name_string		:= if(		pNameOrder 	 = 'F'	,address.CleanPersonFML73(pName)
																														,address.CleanPersonLFM73(pName)
																		);
	
	clean_person_name						:= CleanNameFields(clean_person_name_string);
	
	
	name_score							:= Business_Header.CleanName(
																											 clean_person_name.fname
																											,clean_person_name.mname
																											,clean_person_name.lname
																											,clean_person_name.name_suffix
															)[142];

	IsPerson 								:=		(integer)name_score < pBusiness_HeaderCleanNameThreshold 
														and Business_Header.CheckPersonName( 
																										 clean_person_name.fname
																										,clean_person_name.mname
																										,clean_person_name.lname
																										,clean_person_name.name_suffix
																)
																
														and Address.Business.GetNameType(pName) in ['P','D']
														and not ut.IsCompany(pName)
														and if(pRequiresCommaInLastName, regexfind(',',pName), true)
													;

	clean_person_name_decision := if(pName = '' or not IsPerson, '', clean_person_name_string);
	
	return cleannamefields(clean_person_name_decision);
	
end;