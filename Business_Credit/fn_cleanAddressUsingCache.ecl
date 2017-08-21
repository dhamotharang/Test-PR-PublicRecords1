IMPORT	Business_Credit,	Address,	ut;
EXPORT	fn_cleanAddressUsingCache(DATASET(RECORDOF(Business_Credit.Layouts.SBFEAccountLayout)) pInput) := FUNCTION 
	
	
	dNoAddress					:=	pInput(Original_address_line_1='' AND Original_address_line_2=''	AND Original_city='' AND Original_state='' AND Original_zip_code_or_ca_postal_code=''); 
	dHasAddress					:=	pInput(Original_address_line_1<>'' OR Original_address_line_2<>''	OR Original_city<>'' OR Original_state<>'' OR Original_zip_code_or_ca_postal_code<>''); 
	dAddressCache				:=	Business_Credit.Files().SBFEAddressCache;
	dAddressCache_Dist	:=	SORT(DISTRIBUTE(dAddressCache,HASH(	address_line_1,address_line_2,city,state,zip_code_or_ca_postal_code,postal_code,country_code)),
																															address_line_1,address_line_2,city,state,zip_code_or_ca_postal_code,postal_code,country_code,LOCAL);
	dHasAddress_Dist		:=	SORT(DISTRIBUTE(dHasAddress,HASH(	Original_address_line_1,Original_address_line_2,Original_city,Original_state,Original_zip_code_or_ca_postal_code,Original_postal_code,Original_country_code)),
																														Original_address_line_1,Original_address_line_2,Original_city,Original_state,Original_zip_code_or_ca_postal_code,Original_postal_code,Original_country_code,LOCAL);
	dNewAddresses	:=	JOIN(
													dAddressCache_Dist,
													dHasAddress_Dist,
														LEFT.address_line_1							=	RIGHT.Original_address_line_1	AND
														LEFT.address_line_2							=	RIGHT.Original_address_line_2	AND
														LEFT.city												=	RIGHT.Original_city	AND
														LEFT.state											=	RIGHT.Original_state	AND
														LEFT.zip_code_or_ca_postal_code	=	RIGHT.Original_zip_code_or_ca_postal_code	AND
														LEFT.postal_code								=	RIGHT.Original_postal_code	AND
														LEFT.country_code								=	RIGHT.Original_country_code,
													TRANSFORM(RIGHT),
													RIGHT	ONLY,
													LOCAL
												);

	dNewAddresses_Dedup	:=	DEDUP(SORT(DISTRIBUTE(dNewAddresses,HASH(	Original_address_line_1,Original_address_line_2,Original_city,Original_state,Original_zip_code_or_ca_postal_code,Original_postal_code,Original_country_code)),
																																		Original_address_line_1,Original_address_line_2,Original_city,Original_state,Original_zip_code_or_ca_postal_code,Original_postal_code,Original_country_code,LOCAL),
																																		Original_address_line_1,Original_address_line_2,Original_city,Original_state,Original_zip_code_or_ca_postal_code,Original_postal_code,Original_country_code,LOCAL);

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Clean New Address using Address Cache
	rCleanAddr	:=	RECORD
		STRING	prep_address1;
		STRING	prep_address2;
		STRING	clean_address1	:=	'';
		STRING	clean_address2	:=	'';
		Business_Credit.Layouts.AddressSegment;
	END; 

	Unit_Desigs :=
	['APT','#','STE','UNIT','LOT','TRLR','SPC','FL','RM','BLDG',
	'REAR','PH','BSMT','UPPR','FRNT','NUM','LOWR','DEPT','SIDE','BZN','OFC',
	'STOP','MS','N','SLIP','ALTO','LBBY','WING','PIER','HNGR'];

	fCreateAddr1(STRING	line1,	STRING	line2)	:=	FUNCTION
		splitLine1	:=	ut.StringSplit(line1);
		splitLine2	:=	ut.StringSplit(line2);
		line				:=	IF(TRIM(line2,ALL)='' OR TRIM(line1,ALL)=TRIM(line2,ALL),ut.fnTrim2Upper(line1),
											IF(TRIM(line1,ALL)='',ut.fnTrim2Upper(line2),
												//	If line1 looks like a unit designation, then create address as line2+line1.
												IF(splitLine1[1] IN Unit_Desigs OR	splitLine1[1][1]='#',
													ut.fnTrim2Upper(line2+line1),ut.fnTrim2Upper(line1+line2))
											)
										);
		RETURN line;
								
	END;

	rCleanAddr tPrepAddress(dNewAddresses_Dedup L)	:=	TRANSFORM
		SELF.Segment_Identifier					:=	L.record_type;
		SELF.Address_Line_1							:=	L.Original_address_line_1;
		SELF.Address_Line_2							:=	L.Original_address_line_2;
		SELF.City												:=	L.Original_city;
		SELF.State											:=	L.Original_state;
		SELF.Zip_Code_or_CA_Postal_Code	:=	L.Original_zip_code_or_ca_postal_code;
		SELF.Postal_Code								:=	L.Original_postal_code;
		SELF.Country_Code								:=	L.Original_country_code;
		SELF.prep_address1							:=	ut.fn_addr_clean_prep(fCreateAddr1(SELF.address_line_1,SELF.address_line_2),'first');
		SELF.prep_address2							:=	ut.fn_addr_clean_prep(
																					address.Addr2FromComponents(SELF.city,SELF.state
																						,TRIM(SELF.zip_code_or_ca_postal_code,ALL)+
																							IF(TRIM(SELF.zip_code_or_ca_postal_code,ALL)<>'' AND 
																								TRIM(SELF.postal_code,ALL)<>'','-'+TRIM(SELF.postal_code,ALL),'')
																					),'last'
																				);
		SELF.File_Sequence_Number				:=	'';
		SELF.Parent_Sequence_Number			:=	'';
		SELF.Account_Base_Number				:=	'';
		SELF.Primary_Address_Indicator	:=	'';
		SELF.Address_Classification			:=	'';
		SELF														:=	L;
	END;

	dTempAddr	:=	PROJECT(dNewAddresses_Dedup, tPrepAddress(LEFT)); 

	Address.MAC_Address_Clean(dTempAddr,prep_address1,prep_address2,TRUE,dAppendAddr);	

	dAppendAddr tFillCleanAddress(dAppendAddr L)	:=	TRANSFORM
		SELF.clean_address1	:=	Address.CleanAddressFieldsFips(L.clean).addr1;
		SELF.clean_address2	:=	Address.CleanAddressFieldsFips(L.clean).addr2;
		SELF								:=	L;
	END;
	dCleanAddr			:=	PROJECT(dAppendAddr, tFillCleanAddress(LEFT));
	
	basefilename		:=	Business_Credit.Filenames().AddressCache;
	logicalfilename	:=	basefilename+'::'+workunit;
	IF(COUNT(dNewAddresses)>0,
		SEQUENTIAL
		(
			OUTPUT(dCleanAddr,,logicalfilename,OVERWRITE,__compressed__);
			FileServices.StartSuperFileTransaction(),
			FileServices.AddSuperFile(basefilename,logicalfilename),
			FileServices.FinishSuperFileTransaction()
		)
	);
	
	dNewAddressCache			:=	IF(COUNT(dNewAddresses)>0,
															DATASET(logicalfilename,Layouts.rCleanAddrCache,THOR),
															DATASET([],Layouts.rCleanAddrCache));
	dNewAddressCache_Dist	:=	DEDUP(SORT(DISTRIBUTE(dAddressCache+dNewAddressCache,
															HASH(	address_line_1,address_line_2,city,state,zip_code_or_ca_postal_code,postal_code,country_code)),
															address_line_1,address_line_2,city,state,zip_code_or_ca_postal_code,postal_code,country_code,LOCAL),
															address_line_1,address_line_2,city,state,zip_code_or_ca_postal_code,postal_code,country_code,LOCAL);

	RECORDOF(pInput)	tFillAddress(dNewAddressCache_Dist	L,	pInput	R)	:=	TRANSFORM
		SELF.prim_range		:=	Address.CleanAddressFieldsFips(L.clean).prim_range;
		SELF.predir				:=	Address.CleanAddressFieldsFips(L.clean).predir;
		SELF.prim_name		:=	Address.CleanAddressFieldsFips(L.clean).prim_name;
		SELF.addr_suffix	:=	Address.CleanAddressFieldsFips(L.clean).addr_suffix;
		SELF.postdir			:=	Address.CleanAddressFieldsFips(L.clean).postdir;
		SELF.unit_desig		:=	Address.CleanAddressFieldsFips(L.clean).unit_desig;
		SELF.sec_range		:=	Address.CleanAddressFieldsFips(L.clean).sec_range;
		SELF.p_city_name	:=	Address.CleanAddressFieldsFips(L.clean).p_city_name;
		SELF.v_city_name	:=	Address.CleanAddressFieldsFips(L.clean).v_city_name;
		SELF.st						:=	IF(Address.CleanAddressFieldsFips(L.clean).st = '',ziplib.ZipToState2(Address.CleanAddressFieldsFips(L.clean).zip),Address.CleanAddressFieldsFips(L.clean).st);
		SELF.zip					:=	Address.CleanAddressFieldsFips(L.clean).zip;
		SELF.zip4					:=	Address.CleanAddressFieldsFips(L.clean).zip4;
		SELF.cart					:=	Address.CleanAddressFieldsFips(L.clean).cart;
		SELF.cr_sort_sz		:=	Address.CleanAddressFieldsFips(L.clean).cr_sort_sz;
		SELF.lot					:=	Address.CleanAddressFieldsFips(L.clean).lot;
		SELF.lot_order		:=	Address.CleanAddressFieldsFips(L.clean).lot_order;
		SELF.dbpc					:=	Address.CleanAddressFieldsFips(L.clean).dbpc;
		SELF.chk_digit		:=	Address.CleanAddressFieldsFips(L.clean).chk_digit;
		SELF.rec_type			:=	Address.CleanAddressFieldsFips(L.clean).rec_type;
		SELF.fips_state		:=	Address.CleanAddressFieldsFips(L.clean).fips_state;
		SELF.fips_county	:=	Address.CleanAddressFieldsFips(L.clean).fips_county;
		SELF.geo_lat			:=	Address.CleanAddressFieldsFips(L.clean).geo_lat;
		SELF.geo_long			:=	Address.CleanAddressFieldsFips(L.clean).geo_long;
		SELF.msa					:=	Address.CleanAddressFieldsFips(L.clean).msa;
		SELF.geo_blk			:=	Address.CleanAddressFieldsFips(L.clean).geo_blk;
		SELF.geo_match		:=	Address.CleanAddressFieldsFips(L.clean).geo_match;
		SELF.err_stat			:=	Address.CleanAddressFieldsFips(L.clean).err_stat;
		SELF							:=	R;
	END;
	
	dFillAddresses			:=	JOIN(
														dNewAddressCache_Dist,
														dHasAddress_Dist,
															LEFT.address_line_1							=	RIGHT.Original_address_line_1	AND
															LEFT.address_line_2							=	RIGHT.Original_address_line_2	AND
															LEFT.city												=	RIGHT.Original_city	AND
															LEFT.state											=	RIGHT.Original_state	AND
															LEFT.zip_code_or_ca_postal_code	=	RIGHT.Original_zip_code_or_ca_postal_code	AND
															LEFT.postal_code								=	RIGHT.Original_postal_code	AND
															LEFT.country_code								=	RIGHT.Original_country_code,
														tFillAddress(LEFT,RIGHT),
														RIGHT	OUTER,
														LOCAL
													);

	RETURN(dFillAddresses+dNoAddress);
	
END;
