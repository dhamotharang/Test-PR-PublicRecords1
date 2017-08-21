import	Address,idl_header,ut;

export	FlipNames(dataset(LN_PropertyV2.layout_deed_mortgage_property_search)	pSearch)	:=
function

	dInSearch	:=	pSearch(nameasis	<>	'');

	// Pass to the name indicator macro to distinguish between individuals and businesses
	Address.Mac_Is_Business(dInSearch,nameasis,dSearchNameInd,name_type);

	dSearchNameType	:=	dSearchNameInd	+	pSearch(nameasis	=	'');
	
	LN_PropertyV2.layout_deed_mortgage_property_search	tCleanName(dSearchNameType	pInput)	:=
	transform
		/*
		string	clean_name	:=	address.CleanPersonFML73(pInput.cname);
		
		self.title				:=	if(pInput.name_type	=	'B','',if(pInput.title	!=	'',pInput.title,clean_name[1..5]));;
		self.fname				:=	if(pInput.name_type	=	'B','',if(pInput.fname	!=	'',pInput.fname,clean_name[6..25]));
		self.mname				:=	if(pInput.name_type	=	'B','',if(pInput.mname	!=	'',pInput.mname,clean_name[26..45]));
		self.lname				:=	if(pInput.name_type	=	'B','',if(pInput.lname	!=	'',pInput.lname,clean_name[46..65]));
		self.name_suffix	:=	if(pInput.name_type	=	'B','',if(pInput.name_suffix	!=	'',pInput.name_suffix,clean_name[66..70]));
		self.cname				:=	if(pInput.name_type	!=	'B','',if(pInput.cname	!=	'',pInput.cname,pInput.nameasis));
		*/
		self							:=	pInput;
	end;
	
	dSearchCleanName	:=	project(dSearchNameType,tCleanName(left));
	
	// Flip last name to first name if the name order is switched
	ut.mac_flipnames(dSearchCleanName,fname,mname,lname,dSearchFlipName);
	
	return	dSearchFlipName;
end;