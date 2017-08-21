import business_header, ut, address;

export Clean_n_Validate(

	 string			pName
	,string1		pNameOrder																// 'F' = fml, 'L' = lfm
	,unsigned4	pNameScoreThreshold									= 30
	,unsigned4	pBusiness_HeaderCleanNameThreshold	= 3
	,boolean		pRequiresCommaInLastName						= false					

) :=
function

	clean_person_name_string		:= if(		pNameOrder 	 = 'F'	,Address.CleanPersonFML73(stringlib.stringfilter(pName, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ.-\' '))
																														,Address.CleanPersonLFM73(stringlib.stringfilter(pName, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ.-\' '))
																		);
	
	clean_person_name						:= address.CleanNameFields(clean_person_name_string);
	
	
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
														and (unsigned4)clean_person_name.name_score > pNameScoreThreshold
														// and not ut.IsCompany(pName)
														and if(pRequiresCommaInLastName, regexfind(',',pName), true)
													;

	clean_person_name_decision := if(pName = '' or not IsPerson, '', clean_person_name_string);
	
	return address.cleannamefields(clean_person_name_decision);
	
end;