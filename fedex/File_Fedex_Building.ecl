import	Address,ut;

// Request from Fedex to add records with invalid USPS zips - specialized fedex zip codes which assist in their routing
FedEx.layout_fedex_base	tBlankFields(fedex.File_FedEx_Add_Records	pInput)	:=
transform
	modCleanAddress		:=	Address.CleanAddressParsed(	pInput.address_line1,
																										Address.Addr2FromComponents(pInput.city,pInput.state,pInput.zip)
																									);
	self.prim_range		:=	modCleanAddress.prim_range;
	self.predir				:=	modCleanAddress.predir;
	self.prim_name		:=	modCleanAddress.prim_name;
	self.addr_suffix	:=	modCleanAddress.addr_suffix;
	self.postdir			:=	modCleanAddress.postdir;
	self.unit_desig		:=	modCleanAddress.unit_desig;
	self.sec_range		:=	modCleanAddress.sec_range;
	self.p_city_name	:=	modCleanAddress.p_city_name;
	// FedEx requested to change the city name for this particular case
	self.v_city_name	:=	if(	ut.CleanSpacesAndUpper(pInput.city)	=	'LENEXA'	and	pInput.zip	=	'66150'	and	modCleanAddress.v_city_name	=	'OVERLAND PARK',
														ut.CleanSpacesAndUpper(pInput.city),
														modCleanAddress.v_city_name
													);
	self.st						:=	modCleanAddress.st;
	self.zip5					:=	pInput.zip;
	self.zip6					:=	pInput.zip;
	self							:=	pInput;
	self							:=	[];
end;

dFedExAddsCleanAddr	:=	project(fedex.File_FedEx_Add_Records,tBlankFields(left));

setFedExRecordID	:=	[	'FDX000002715440','FDX000008240443','FDX000008767551','FDX000008767551',
												'FDX000009427346','FDX000000931173'
											];

// Fedex base file
dFedEx	:=	project(Fedex.file_fedex_base, transform (fedex.layout_fedex_base, 
                                        self.phone := if(left.phone = '2152481861'  and left.first_name= 'TERRY' and left.last_name = 'SIMPSON'and left.prim_range ='8430' and left.prim_name= 'GERMANTOWN' and left.addr_suffix = 'AVE' and
																											       left.st = 'PA' and left.zip = '19118', '2158587948', left.phone); 
                                        self := left));

export	File_Fedex_Building	:=		dFedEx(	~(			(	phone	=	'7758561163'	and	prim_range	=	'3983'	and	predir	=	'S'	and	prim_name	=	'MCCARRAN'	and	addr_suffix	=	'BLVD'	and	unit_desig	=	'APT'	and	sec_range	=	'475'	and	v_city_name	=	'RENO'	and	st	=	'NV'	and	zip	=	'89502')
																							or	(	business_indicator	!=	'Y'	and	prim_range	=	'941'	and	prim_name	=	'CORPORATE CENTER'	and	addr_suffix	=	'DR'	and	v_city_name	=	'POMONA'	and	st	=	'CA'	and	zip	=	'91768')
																							or	(	business_indicator	!=	'Y'	and	prim_range	=	'120'	and	predir	=	'S'	and	prim_name	=	'VICTORY'	and	addr_suffix	=	'ST'	and	v_city_name	=	'LITTLE ROCK'	and	st	=	'AR'	and	zip	=	'72201')
																							or	(	(regexfind('^(VERIZON)',ut.CleanSpacesAndUpper(first_name),nocase)	or	regexfind('^(VERIZON)',ut.CleanSpacesAndUpper(last_name),nocase)	or	regexfind('^(VERIZON)',ut.CleanSpacesAndUpper(full_name),nocase)	or	regexfind('^(VERIZON)',ut.CleanSpacesAndUpper(company_name),nocase))	and	err_stat[1]	=	'E')
																							or	(	record_id	in	setFedExRecordID)
																						)
																				)
																+	dFedExAddsCleanAddr;
