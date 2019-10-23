import corp2_mapping,ut,corp2;
export fCleanBusinessName(string pStateOrigin,string pStateOriginDesc,string pBName='') := module
	//********************************************************************
	//fCleanBusinessName: takes a business and tries to determine if it is
	//								 		a valid name.
	//Blank out the name if:
	//1) Only special characters exists in the field	
	//*******************************************************************

		shared UC_StateOrigin				:= corp2_mapping.fn_RemoveSpecialChars(corp2.t2u(pStateOrigin));
		shared UC_StateOriginDesc		:= corp2_mapping.fn_RemoveSpecialChars(corp2.t2u(pStateOriginDesc));
		shared UC_BName 						:= corp2_mapping.fn_RemoveSpecialChars(corp2.t2u(pBName));
		shared UC_CleanedName				:= corp2.t2u(stringlib.stringfilterout(UC_BName,'`'));
		shared PatternInvalidNames	:= '^TEST(ING)* RECORD|^TEST(ING)* NAME|^TEST ASSUMED NAME$|NOT PROVIDED|^NONE,$|^NONE$';
		shared Test4Unknown					:= if(regexfind('UNKNOWN',corp2.t2u(UC_CleanedName),0)<>'', //Found a company of "UOWN" so checking first for "UNKNOWN"
																			map(corp2.t2u(stringlib.stringfilterout(UC_CleanedName,'UNKNOWN;:,?!/{}[]-_)(*&^%$#@!`~<>'))='' => '',
																					UC_CleanedName
																				 ),
																			UC_CleanedName
																	 );

		shared BusinessNameFilter		:= if(regexfind(PatternInvalidNames,corp2.t2u(Test4Unknown),0)<>'','',Test4Unknown);
		//If only special characters exists in the field, blank out	
		export BusinessName					:= if(corp2.t2u(stringlib.stringfilterout(BusinessNameFilter,'. '))='','',BusinessNameFilter);
end;