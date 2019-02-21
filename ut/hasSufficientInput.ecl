/*-----------------------------
**********This func macro evaluates user input and determines whether the expected minimum input is met based on the limit provided. ***********

Validity_LIMIT a value that quantifies the minimum input. Here are possible values:-
	10 for DID only,
	 9 for (Firstname AND LASTNAME) AND (StreetAddress AND ((city and state) OR zip)) AND (dob OR ssn),								 
	 8 for (Firstname OR LASTNAME) AND (StreetAddress AND ((city and state) OR zip)) AND (dob OR ssn),
	 7 for (Firstname OR LASTNAME) AND (StreetAddress AND ((city and state) OR zip)),								 
	 6 for (Firstname OR LASTNAME) AND (dob OR ssn),								 
	 5 for (StreetAddress AND ((city and state) OR zip)) AND (dob OR ssn),								 
	 4 for (StreetAddress AND ((city and state) OR zip)),								 
	 3 for SSN only,								 

----------------------------------*/

EXPORT hasSufficientInput(inputf, Validity_LIMIT=10, did='did', name_first='name_first', name_last='name_last', 
												prim_range='prim_range', prim_name='prim_name', city='p_city_name', st='st', z5='z5', ssn='ssn', dob='dob') := FUNCTIONMACRO

	hasDID				:= (UNSIGNED)inputf.did <> 0;
	hasFname		 	:= inputf.name_first 	<> '';
	hasLname		 	:= inputf.name_last 	<> '';		
	
	hasPrim_range	:= inputf.prim_range	<> '';
	hasPrim_name	:= inputf.prim_name		<> '';
	hasCity				:= inputf.city 				<> '';
	hasState			:= ut.valid_st(inputf.st);
	hasZip				:= inputf.z5 					<> '';
	hasAddr		 		:= (hasPrim_range AND hasPrim_name) OR ut.isPOBox(inputf.prim_name) or ut.isRR(inputf.prim_name);
	hasAddr2		 	:= (hasCity AND hasState) OR  hasZip;
		
  hasDOB		 		:= STD.Date.IsValidDate((UNSIGNED4) STD.Str.Filter(inputf.dob,'0123456789'));
	hasSSN		 		:= LENGTH(stringlib.stringfilter(inputf.SSN,'0123456789')) = 9;

	nameScore 		:= MAP(hasLname AND hasFname => 2,
											 hasLname => 1,
											 0);
	enumName			:=  ENUM(none=0, partialname, fullname); 

	matchValue 		:= MAP(hasDID => 10,
									(nameScore = enumName.fullname) AND hasAddr AND hasAddr2 AND (hasDOB OR hasSSN) => 9,								 
									(nameScore = enumName.partialname) AND hasAddr AND hasAddr2 AND (hasDOB OR hasSSN) => 8,
									(nameScore > enumName.none) AND hasAddr AND hasAddr2 => 7,								 
									(nameScore > enumName.none) AND (hasDOB OR hasSSN) => 6,								 						 
									hasAddr AND hasAddr2 AND (hasDOB OR hasSSN) => 5,								 
									hasAddr AND hasAddr2 => 4,
									hasSSN => 3,
									0);		
								
	isValidInput := matchValue >= Validity_LIMIT;	
	RETURN isValidInput;
ENDMACRO;
	