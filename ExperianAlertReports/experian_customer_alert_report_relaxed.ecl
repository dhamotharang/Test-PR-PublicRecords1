import	address,lib_stringlib;

#workunit('name','Accurint Company Experian Alerts relaxed version');
//contains matches based on all factors(telephone,comp address,comp name) 

lAlertListDate		:=	'20081001';
lCustomerListDate	:=	'20081001';

rAlertList
 :=
   record
   string AlertId;
	string CreateDateTime;
	string LastUpdateDateTime;
	string AlertOpenDate;
	string BusinessSequenceNumber;
	string BusinessName;
	string DBAAssumedName;
	string Address;
	string City;
	string State;
	string Zip;
	string Telephone;
	string Website;
	string ContactSequenceNumber;
	string LastName;
	string FirstName;
	string MiddleName;
	string GenCode;
	string Title1;
	
	end
 ;
  
dAlertList	:=	dataset('~thor_data400::in::experian_customer_alert::' + lAlertListDate + '::data',rAlertList,csv(separator(','),terminator('\n'),heading(1)));

rAlertListBlob
 :=
  record
	rAlertList;
	string73	Contact_Name_clean;
	string182	Address_Clean;
  end
 ;

rAlertListBlob	tAlertListBlob(dAlertList pInput)
 :=
  transform
	self.BusinessName		:=	lib_stringlib.StringLib.stringtouppercase(pInput.BusinessName);
	self.DBAAssumedName		:=	lib_stringlib.StringLib.stringtouppercase(pInput.DBAAssumedName);	
	self.Telephone				:=	lib_stringlib.StringLib.stringfilter(pInput.Telephone,'0123456789');
	self.Contact_Name_Clean	:=	if(pInput.FirstName<>'',
								   address.cleanpersonFML73(pInput.FirstName + pInput.LastName),
								   ''
								  );
	self.Address_Clean		:=	if(pInput.State<>'' or pInput.Zip<>'',
								   address.cleanaddress182(pInput.Address,pInput.City + ' ' + pInput.State + '  ' + pInput.Zip),
								   ''
								  );
	self					:=	pInput;
  end
 ;
  
dAlertListBlob	:=	project(dAlertList,tAlertListBlob(left));

rAlertListClean
 :=
  record
	rAlertList;
	string5		title;
	string20	fname;
	string20	mname;
	string20	lname;
	string5		name_suffix;
	string3		name_cleaning_score;
	string10	prim_range;
	string2		predir;
	string28	prim_name;
	string4		suffix;
	string2		postdir;
	string10	unit_desig;
	string8		sec_range;
	string25	p_city_name;
	string25	v_city_name;
	string2		st;
	string5		zip5;
	string4		zip4;
	string4		cart;
	string1		cr_sort_sz;
	string4		lot;
	string1		lot_order;
	string2		dpbc;
	string1		chk_digit;
	string2		rec_type;
	string2		ace_fips_st;
	string3		ace_fips_county;
	string10	geo_lat;
	string11	geo_long;
	string4		msa;
	string7		geo_blk;
	string1		geo_match;
	string4		err_stat;
  end
 ;

rAlertListClean	tAlertListCleanFromBlob(dAlertListBlob pInput)
 :=
  transform
	self.title					:=	pInput.Contact_Name_Clean[1..5];
	self.fname					:=	pInput.Contact_Name_Clean[6..25];
	self.mname					:=	pInput.Contact_Name_Clean[26..45];
	self.lname					:=	pInput.Contact_Name_Clean[46..65];
	self.name_suffix			:=	pInput.Contact_Name_Clean[66..70];
	self.name_cleaning_score	:=	pInput.Contact_Name_Clean[71..73];
	self.prim_range 			:=	pInput.Address_Clean[1..10];
	self.predir 				:=	pInput.Address_Clean[11..12];
	self.prim_name 				:=	pInput.Address_Clean[13..40];
	self.suffix 				:=	pInput.Address_Clean[41..44];
	self.postdir 				:=	pInput.Address_Clean[45..46];
	self.unit_desig 			:=	pInput.Address_Clean[47..56];
	self.sec_range 				:=	pInput.Address_Clean[57..64];
	self.p_city_name 			:=	pInput.Address_Clean[65..89];
	self.v_city_name 			:=	pInput.Address_Clean[90..114];
	self.st 					:=	pInput.Address_Clean[115..116];
	self.zip5 					:=	pInput.Address_Clean[117..121];
	self.zip4 					:=	pInput.Address_Clean[122..125];
	self.cart 					:=	pInput.Address_Clean[126..129];
	self.cr_sort_sz 			:=	pInput.Address_Clean[130];
	self.lot 					:=	pInput.Address_Clean[131..134];
	self.lot_order 				:=	pInput.Address_Clean[135];
	self.dpbc 					:=	pInput.Address_Clean[136..137];
	self.chk_digit 				:=	pInput.Address_Clean[138];
	self.rec_type				:=	pInput.Address_Clean[139..140];
	self.ace_fips_st 			:=	pInput.Address_Clean[141..142];
	self.ace_fips_county		:=	pInput.Address_Clean[143..145];
	self.geo_lat 				:=	pInput.Address_Clean[146..155];
	self.geo_long 				:=	pInput.Address_Clean[156..166];
	self.msa 					:=	pInput.Address_Clean[167..170];
	self.geo_blk 				:=	pInput.Address_Clean[171..177];
	self.geo_match 				:=	pInput.Address_Clean[178];
	self.err_stat 				:=	pInput.Address_Clean[179..182];
	self						:=	pInput;
  end
 ;

dAlertListClean	:=	project(dAlertListBlob,tAlertListCleanFromBlob(left)) : persist('~thor_data400::persist::alert_list');

rCompany
 :=
  record
	string	COMPANYID;
	string	COMPANYNAME;
	string	EIN;
	string	Telephone_VOICE1;
	string	Telephone_VOICE1_EXT;
	string	Telephone_VOICE2;
	string	Telephone_VOICE2_EXT;
	string	Telephone_FAX;
	string	Telephone_FAX_EXT;
	string	URL;
	string	ADDR_LINE1;
	string	ADDR_LINE2;
	string	ADDR_COUNTRY;
	string	ADDR_CITY;
	string	ADDR_STATE;
	string	ADDR_POSTALCODE;
	string	COMPANY_STATUS;
	string	SUSPENSION_DT;
	string	MAINNAME;
	string	MAINADDR1;
	string	MAINADDR2;
	string	MAINCITY;
	string	MAINSTATE;
	string	MAINZIP;
	string	MAINTelephoneV1;
	string	MAINTelephoneV1_EXT;
	string	MAINTelephoneV2;
	string	MAINTelephoneV2_EXT;
	string	MAINTelephoneFX;
	string	MAINTelephoneFX_EXT;
	string	MAINEMAIL;
	string	BILLNAME;
	string	BILLADDR1;
	string	BILLADDR2;
	string	BILLCITY;
	string	BILLSTATE;
	string	BILLZIP;
	string	BILLTelephoneV1;
	string	BILLTelephoneV1_EXT;
	string	BILLTelephoneV2;
	string	BILLTelephoneV2_EXT;
	string	BILLTelephoneFX;
	string	BILLTelephoneFX_EXT;
	string	BILLEMAIL;
	string	PARENTCOMPANYID;
	string	PLANID;
	string	START_DATE;
	string	NEXT_BILLING_DATE;
	string	SALESPERSON_USERID;
	string	TRANSACTION_CREDIT;
	string	CREDIT_LIMIT;
	string	FREETRIALENDDATE;
	string	SOURCETYPE;
	string	SOURCEDESCRIPTION;
	string	DATEADDED;
	string	DATECHANGED;
	string	USERCHANGED;
	string	IndustryClass;
	string	vendorid;
	string	vendor_picture;
	string	COMPANYTYPE;
	string	AppStatus;
	string	AppReceivedIncomplete;
	string	AppReceivedComplete;
	string	AppVerified;
	string	DunningExemptFlag;
	string	DUNNINGSTATUS;
	string	DUNNINGSTATUS1DATE;
	string	DUNNINGSTATUS2DATE;
	string	DUNNINGAMNESTYDATE;
	string	DUNNINGLASTNOTICEDATE;
	string	DUNNINGPRESUSPENDSTATUS;
	string	DUNNINGRESENDINTERVAL;
	string	DUNNINGFORCERESENDFLAG;
	string	DUNNINGSTATUS3DATE;
	string	BILLUSERID;
	string	BILLVERIFIEDDATE;
	string	MAINUSERID;
	string	MAINVERIFIEDDATE;
	string	RESELLERFLAG;
	string	BILLINGINTERVALTYPE;
	string	SENDINVOICEFLAG;
	string	DONOTEMAILSTATEMENTFLAG;
	string	BILLTYPE;
	string	ParentIntegratorID;
	string	BILLING_AUTHORITY_FLAG;
	string	ADDRESS_CLEANED;
	string	INDUSTRY1_CODE;
	string	INDUSTRY2_CODE;
	string	INDUSTRY_DEPARTMENT_CODE;
	string	PRIMARY_MARKET_CODE;
  end
 ;

dCompany	:=	dataset('~thor_data400::company::' + lCustomerListDate + '::data',rCompany,csv(quote('\"'),separator('\t'),terminator('\n'),heading(2)));

rCompanySlim
 :=
  record
	string		COMPANYID;
	string		COMPANYNAME;
	string		Telephone_VOICE1;
	string		Telephone_VOICE2;
	string		Telephone_FAX;
	string		URL;
	string		ADDR_LINE1;
	string		ADDR_LINE2;
	string		ADDR_CITY;
	string		ADDR_STATE;
	string		ADDR_POSTALCODE;
	// string		COMPANY_STATUS;
	// string		SUSPENSION_DT;
	string		MAINNAME;
	string		MAINADDR1;
	string		MAINADDR2;
	string		MAINCITY;
	string		MAINSTATE;
	string		MAINZIP;
	string		MAINTelephoneV1;
	string		MAINTelephoneV2;
	string		MAINTelephoneFX;
	string		BILLNAME;
	string		BILLADDR1;
	string		BILLADDR2;
	string		BILLCITY;
	string		BILLSTATE;
	string		BILLZIP;
	string		BILLTelephoneV1;
	string		BILLTelephoneV2;
	string		BILLTelephoneFX;
	string		PARENTCOMPANYID;
	string		RESELLERFLAG;
  end
 ;

rCompanySlimBlob
 :=
  record
	rCompanySlim;
	string73	MAINNAME_clean_name;
	string73	BILLNAME_clean_name;
	string182	ADDR_clean_address;
	string182	MAINADDR_clean_address;
	string182	BILLADDR_clean_address;
  end
 ;

rCompanySlimBlob	tCompanySlimBlob(dCompany pInput)
 :=
  transform
    self.COMPANYNAME			:=	lib_stringlib.StringLib.stringtouppercase(pInput.COMPANYNAME);
   	 self.Telephone_VOICE1			:=	lib_stringlib.StringLib.stringfilter(pInput.Telephone_VOICE1,'0123456789');
	 self.Telephone_VOICE2			:=	lib_stringlib.StringLib.stringfilter(pInput.Telephone_VOICE2,'0123456789');
	 self.MAINTelephoneV1			:=	lib_stringlib.StringLib.stringfilter(pInput.MAINTelephoneV1,'0123456789');
	 self.MAINTelephoneV2			:=	lib_stringlib.StringLib.stringfilter(pInput.MAINTelephoneV2,'0123456789');
	 self.BILLTelephoneV1			:=	lib_stringlib.StringLib.stringfilter(pInput.BILLTelephoneV1,'0123456789');
	self.BILLTelephoneV2			:=	lib_stringlib.StringLib.stringfilter(pInput.BILLTelephoneV2,'0123456789');
	self.MAINNAME_clean_Name	:=	if(pInput.MAINNAME<>'',
									   address.cleanpersonFML73(pInput.MAINNAME),
									   ''
									  );
	self.BILLNAME_clean_Name	:=	if(pInput.BILLNAME<>'',
									   address.cleanpersonFML73(pInput.BILLNAME),
									   ''
									  );
	self.ADDR_clean_address		:=	if(pInput.ADDR_STATE<>'' or pInput.ADDR_POSTALCODE<>'',
									   address.cleanaddress182(pInput.ADDR_LINE1 + ' ' + pInput.ADDR_LINE2,pInput.ADDR_CITY + ' ' + pInput.ADDR_STATE + '  ' + pInput.ADDR_POSTALCODE),
									   ''
									  );
	self.MAINADDR_clean_address	:=	if(pInput.MAINSTATE<>'' or pInput.MAINZIP<>'',
									   address.cleanaddress182(pInput.MAINADDR1 + ' ' + pInput.MAINADDR2,pInput.MAINCITY + ' ' + pInput.MAINSTATE + '  ' + pInput.MAINZIP),
									   ''
									  );
	self.BILLADDR_clean_address	:=	if(pInput.BILLSTATE<>'' or pInput.BILLZIP<>'',
									   address.cleanaddress182(pInput.BILLADDR1 + ' ' + pInput.BILLADDR2,pInput.BILLCITY + ' ' + pInput.BILLSTATE + '  ' + pInput.BILLZIP),
									   ''
									  );
	self						:=	pInput;
  end
 ;
  
dCompanySlimBlob	:=	project(dCompany,tCompanySlimBlob(left));

rCompanySlimClean
 :=
  record
	rCompanySlim;
	string5		MAINNAME_title;
	string20	MAINNAME_fname;
	string20	MAINNAME_mname;
	string20	MAINNAME_lname;
	string5		MAINNAME_name_suffix;
	string3		MAINNAME_name_cleaning_score;
	string5		BILLNAME_title;
	string20	BILLNAME_fname;
	string20	BILLNAME_mname;
	string20	BILLNAME_lname;
	string5		BILLNAME_name_suffix;
	string3		BILLNAME_name_cleaning_score;
	string10	ADDR_prim_range;
	string2		ADDR_predir;
	string28	ADDR_prim_name;
	string4		ADDR_suffix;
	string2		ADDR_postdir;
	string10	ADDR_unit_desig;
	string8		ADDR_sec_range;
	string25	ADDR_p_city_name;
	string25	ADDR_v_city_name;
	string2		ADDR_st;
	string5		ADDR_zip5;
	string4		ADDR_zip4;
	string4		ADDR_cart;
	string1		ADDR_cr_sort_sz;
	string4		ADDR_lot;
	string1		ADDR_lot_order;
	string2		ADDR_dpbc;
	string1		ADDR_chk_digit;
	string2		ADDR_rec_type;
	string2		ADDR_ace_fips_st;
	string3		ADDR_ace_fips_county;
	string10	ADDR_geo_lat;
	string11	ADDR_geo_long;
	string4		ADDR_msa;
	string7		ADDR_geo_blk;
	string1		ADDR_geo_match;
	string4		ADDR_err_stat;
	string10	MAINADDR_prim_range;
	string2		MAINADDR_predir;
	string28	MAINADDR_prim_name;
	string4		MAINADDR_suffix;
	string2		MAINADDR_postdir;
	string10	MAINADDR_unit_desig;
	string8		MAINADDR_sec_range;
	string25	MAINADDR_p_city_name;
	string25	MAINADDR_v_city_name;
	string2		MAINADDR_st;
	string5		MAINADDR_zip5;
	string4		MAINADDR_zip4;
	string4		MAINADDR_cart;
	string1		MAINADDR_cr_sort_sz;
	string4		MAINADDR_lot;
	string1		MAINADDR_lot_order;
	string2		MAINADDR_dpbc;
	string1		MAINADDR_chk_digit;
	string2		MAINADDR_rec_type;
	string2		MAINADDR_ace_fips_st;
	string3		MAINADDR_ace_fips_county;
	string10	MAINADDR_geo_lat;
	string11	MAINADDR_geo_long;
	string4		MAINADDR_msa;
	string7		MAINADDR_geo_blk;
	string1		MAINADDR_geo_match;
	string4		MAINADDR_err_stat;
	string10	BILLADDR_prim_range;
	string2		BILLADDR_predir;
	string28	BILLADDR_prim_name;
	string4		BILLADDR_suffix;
	string2		BILLADDR_postdir;
	string10	BILLADDR_unit_desig;
	string8		BILLADDR_sec_range;
	string25	BILLADDR_p_city_name;
	string25	BILLADDR_v_city_name;
	string2		BILLADDR_st;
	string5		BILLADDR_zip5;
	string4		BILLADDR_zip4;
	string4		BILLADDR_cart;
	string1		BILLADDR_cr_sort_sz;
	string4		BILLADDR_lot;
	string1		BILLADDR_lot_order;
	string2		BILLADDR_dpbc;
	string1		BILLADDR_chk_digit;
	string2		BILLADDR_rec_type;
	string2		BILLADDR_ace_fips_st;
	string3		BILLADDR_ace_fips_county;
	string10	BILLADDR_geo_lat;
	string11	BILLADDR_geo_long;
	string4		BILLADDR_msa;
	string7		BILLADDR_geo_blk;
	string1		BILLADDR_geo_match;
	string4		BILLADDR_err_stat;
  end
 ;

rCompanySlimClean	tCompanySlimCleanFromBlob(dCompanySlimBlob pInput)
 :=
  transform
	self.MAINNAME_title					:=	pInput.MAINNAME_Clean_name[1..5];
	self.MAINNAME_fname					:=	pInput.MAINNAME_Clean_name[6..25];
	self.MAINNAME_mname					:=	pInput.MAINNAME_Clean_name[26..45];
	self.MAINNAME_lname					:=	pInput.MAINNAME_Clean_name[46..65];
	self.MAINNAME_name_suffix			:=	pInput.MAINNAME_Clean_name[66..70];
	self.MAINNAME_name_cleaning_score	:=	pInput.MAINNAME_Clean_name[71..73];
	self.BILLNAME_title					:=	pInput.BILLNAME_Clean_name[1..5];
	self.BILLNAME_fname					:=	pInput.BILLNAME_Clean_name[6..25];
	self.BILLNAME_mname					:=	pInput.BILLNAME_Clean_name[26..45];
	self.BILLNAME_lname					:=	pInput.BILLNAME_Clean_name[46..65];
	self.BILLNAME_name_suffix			:=	pInput.BILLNAME_Clean_name[66..70];
	self.BILLNAME_name_cleaning_score	:=	pInput.BILLNAME_Clean_name[71..73];
	self.ADDR_prim_range 				:=	pInput.ADDR_clean_address[1..10];
	self.ADDR_predir 					:=	pInput.ADDR_clean_address[11..12];
	self.ADDR_prim_name 				:=	pInput.ADDR_clean_address[13..40];
	self.ADDR_suffix 					:=	pInput.ADDR_clean_address[41..44];
	self.ADDR_postdir 					:=	pInput.ADDR_clean_address[45..46];
	self.ADDR_unit_desig 				:=	pInput.ADDR_clean_address[47..56];
	self.ADDR_sec_range 				:=	pInput.ADDR_clean_address[57..64];
	self.ADDR_p_city_name 				:=	pInput.ADDR_clean_address[65..89];
	self.ADDR_v_city_name 				:=	pInput.ADDR_clean_address[90..114];
	self.ADDR_st 						:=	pInput.ADDR_clean_address[115..116];
	self.ADDR_zip5 						:=	pInput.ADDR_clean_address[117..121];
	self.ADDR_zip4 						:=	pInput.ADDR_clean_address[122..125];
	self.ADDR_cart 						:=	pInput.ADDR_clean_address[126..129];
	self.ADDR_cr_sort_sz 				:=	pInput.ADDR_clean_address[130];
	self.ADDR_lot 						:=	pInput.ADDR_clean_address[131..134];
	self.ADDR_lot_order 				:=	pInput.ADDR_clean_address[135];
	self.ADDR_dpbc 						:=	pInput.ADDR_clean_address[136..137];
	self.ADDR_chk_digit 				:=	pInput.ADDR_clean_address[138];
	self.ADDR_rec_type					:=	pInput.ADDR_clean_address[139..140];
	self.ADDR_ace_fips_st 				:=	pInput.ADDR_clean_address[141..142];
	self.ADDR_ace_fips_county			:=	pInput.ADDR_clean_address[143..145];
	self.ADDR_geo_lat 					:=	pInput.ADDR_clean_address[146..155];
	self.ADDR_geo_long 					:=	pInput.ADDR_clean_address[156..166];
	self.ADDR_msa 						:=	pInput.ADDR_clean_address[167..170];
	self.ADDR_geo_blk 					:=	pInput.ADDR_clean_address[171..177];
	self.ADDR_geo_match 				:=	pInput.ADDR_clean_address[178];
	self.ADDR_err_stat 					:=	pInput.ADDR_clean_address[179..182];
	self.MAINADDR_prim_range 			:=	pInput.MAINADDR_clean_address[1..10];
	self.MAINADDR_predir 				:=	pInput.MAINADDR_clean_address[11..12];
	self.MAINADDR_prim_name 			:=	pInput.MAINADDR_clean_address[13..40];
	self.MAINADDR_suffix 				:=	pInput.MAINADDR_clean_address[41..44];
	self.MAINADDR_postdir 				:=	pInput.MAINADDR_clean_address[45..46];
	self.MAINADDR_unit_desig 			:=	pInput.MAINADDR_clean_address[47..56];
	self.MAINADDR_sec_range 			:=	pInput.MAINADDR_clean_address[57..64];
	self.MAINADDR_p_city_name 			:=	pInput.MAINADDR_clean_address[65..89];
	self.MAINADDR_v_city_name 			:=	pInput.MAINADDR_clean_address[90..114];
	self.MAINADDR_st 					:=	pInput.MAINADDR_clean_address[115..116];
	self.MAINADDR_zip5 					:=	pInput.MAINADDR_clean_address[117..121];
	self.MAINADDR_zip4 					:=	pInput.MAINADDR_clean_address[122..125];
	self.MAINADDR_cart 					:=	pInput.MAINADDR_clean_address[126..129];
	self.MAINADDR_cr_sort_sz 			:=	pInput.MAINADDR_clean_address[130];
	self.MAINADDR_lot 					:=	pInput.MAINADDR_clean_address[131..134];
	self.MAINADDR_lot_order 			:=	pInput.MAINADDR_clean_address[135];
	self.MAINADDR_dpbc 					:=	pInput.MAINADDR_clean_address[136..137];
	self.MAINADDR_chk_digit 			:=	pInput.MAINADDR_clean_address[138];
	self.MAINADDR_rec_type				:=	pInput.MAINADDR_clean_address[139..140];
	self.MAINADDR_ace_fips_st 			:=	pInput.MAINADDR_clean_address[141..142];
	self.MAINADDR_ace_fips_county		:=	pInput.MAINADDR_clean_address[143..145];
	self.MAINADDR_geo_lat 				:=	pInput.MAINADDR_clean_address[146..155];
	self.MAINADDR_geo_long 				:=	pInput.MAINADDR_clean_address[156..166];
	self.MAINADDR_msa 					:=	pInput.MAINADDR_clean_address[167..170];
	self.MAINADDR_geo_blk 				:=	pInput.MAINADDR_clean_address[171..177];
	self.MAINADDR_geo_match 			:=	pInput.MAINADDR_clean_address[178];
	self.MAINADDR_err_stat 				:=	pInput.MAINADDR_clean_address[179..182];
	self.BILLADDR_prim_range 			:=	pInput.BILLADDR_clean_address[1..10];
	self.BILLADDR_predir 				:=	pInput.BILLADDR_clean_address[11..12];
	self.BILLADDR_prim_name 			:=	pInput.BILLADDR_clean_address[13..40];
	self.BILLADDR_suffix 				:=	pInput.BILLADDR_clean_address[41..44];
	self.BILLADDR_postdir 				:=	pInput.BILLADDR_clean_address[45..46];
	self.BILLADDR_unit_desig 			:=	pInput.BILLADDR_clean_address[47..56];
	self.BILLADDR_sec_range 			:=	pInput.BILLADDR_clean_address[57..64];
	self.BILLADDR_p_city_name 			:=	pInput.BILLADDR_clean_address[65..89];
	self.BILLADDR_v_city_name 			:=	pInput.BILLADDR_clean_address[90..114];
	self.BILLADDR_st 					:=	pInput.BILLADDR_clean_address[115..116];
	self.BILLADDR_zip5 					:=	pInput.BILLADDR_clean_address[117..121];
	self.BILLADDR_zip4 					:=	pInput.BILLADDR_clean_address[122..125];
	self.BILLADDR_cart 					:=	pInput.BILLADDR_clean_address[126..129];
	self.BILLADDR_cr_sort_sz 			:=	pInput.BILLADDR_clean_address[130];
	self.BILLADDR_lot 					:=	pInput.BILLADDR_clean_address[131..134];
	self.BILLADDR_lot_order 			:=	pInput.BILLADDR_clean_address[135];
	self.BILLADDR_dpbc 					:=	pInput.BILLADDR_clean_address[136..137];
	self.BILLADDR_chk_digit 			:=	pInput.BILLADDR_clean_address[138];
	self.BILLADDR_rec_type				:=	pInput.BILLADDR_clean_address[139..140];
	self.BILLADDR_ace_fips_st 			:=	pInput.BILLADDR_clean_address[141..142];
	self.BILLADDR_ace_fips_county		:=	pInput.BILLADDR_clean_address[143..145];
	self.BILLADDR_geo_lat 				:=	pInput.BILLADDR_clean_address[146..155];
	self.BILLADDR_geo_long 				:=	pInput.BILLADDR_clean_address[156..166];
	self.BILLADDR_msa 					:=	pInput.BILLADDR_clean_address[167..170];
	self.BILLADDR_geo_blk 				:=	pInput.BILLADDR_clean_address[171..177];
	self.BILLADDR_geo_match 			:=	pInput.BILLADDR_clean_address[178];
	self.BILLADDR_err_stat 				:=	pInput.BILLADDR_clean_address[179..182];
	self								:=	pInput;
  end
 ;

dCompanySlimClean	:=	project(dCompanySlimBlob,tCompanySlimCleanFromBlob(left)) : persist('~thor_data400::persist::company_data');

rCompanySlimJoin
 :=
  record
	rCompanySlim;
	rAlertListClean;
	string1	Company_Address 		:= 	'';
	string1	Company_MainAddress 	:= 	'';
	string1	Company_BillAddress 	:= 	'';
	string1	DBAAssumed_Address 		:= 	'';
	string1	DBAAssumed_MainAddress 	:= 	'';
	string1	DBAAssumed_BillAddress 	:= 	'';
	string1	MainContact_Address 	:= 	'';
	string1	MainContact_MainAddress	:= 	'';
	string1	MainContact_BillAddress	:= 	'';
	string1	BillContact_Address 	:= 	'';
	string1	BillContact_MainAddress	:= 	'';
	string1	BillContact_BillAddress	:= 	'';
	string1 Company_MainContact		:=	'';
	string1	Company_BillContact		:=	'';
	string1 DBAAssumed_MainContact		:=	'';
	string1	DBAAssumed_BillContact		:=	'';
	string1	Telephone1					:=	'';
	string1	Telephone2					:=	'';
	string1	MainTelephone1				:=	'';
	 string1	MainTelephone2				:=	'';
	 string1	BillTelephone1				:=	'';
	 string1	BillTelephone2				:=	'';
	 string1	WebAddress				:=	'';
	string2	MatchCount				:=	'';
  end
 ;

rCompanySlimJoin	tJoin_Company_Address(dCompanySlimClean pCompany, dAlertListClean pAlertList)
 :=
  transform
	self.Company_Address		:=	'Y';
	//self.DBAAssumed_Address := 'Y';
	self						:=	pCompany;
	self						:=	pAlertList;
  end
 ;

dJoin_Company_Address	:=	join(dCompanySlimClean,dAlertListClean,
								 left.COMPANYNAME		=	right.BusinessName
						//	 and left.COMPANYNAME  = right.DBAAssumedName
							 and left.ADDR_zip5			=	right.zip5
							 and left.ADDR_prim_name	=	right.prim_name
							 and left.ADDR_prim_range	=	right.prim_range
							 and left.COMPANYNAME <> ''
							 and left.ADDR_zip5 <> '',
								 tJoin_Company_Address(left,right),
								 lookup
								);
rCompanySlimJoin	tJoin_DBACompany_Address(dCompanySlimClean pCompany, dAlertListClean pAlertList)
 :=
  transform
	//self.Company_Address		:=	'Y';
	self.DBAAssumed_Address := 'Y';
	self						:=	pCompany;
	self						:=	pAlertList;
  end
 ;
 dJoin_DBAComp_Address	:=	join(dCompanySlimClean,dAlertListClean,
						//		 left.COMPANYNAME		=	right.BusinessName
						  left.COMPANYNAME  = right.DBAAssumedName
							 and left.ADDR_zip5			=	right.zip5
							 and left.ADDR_prim_name	=	right.prim_name
							 and left.ADDR_prim_range	=	right.prim_range
							 and left.COMPANYNAME <> ''
							 and left.ADDR_zip5 <> '',
								 tJoin_DBACompany_Address(left,right),
								 lookup
								);

rCompanySlimJoin	tJoin_Company_MainAddress(dCompanySlimClean pCompany, dAlertListClean pAlertList)
 :=
  transform
	self.Company_MainAddress	:=	'Y';
	//self.DBAAssumed_MainAddress := 'Y';
	self						:=	pCompany;
	self						:=	pAlertList;
  end
 ;

dJoin_Company_MainAddress:=	join(dCompanySlimClean,dAlertListClean,
								 left.COMPANYNAME			=	right.BusinessName
							// and left.COMPANYNAME  = right.DBAAssumedName
							 and left.MAINADDR_zip5			=	right.zip5
							 and left.MAINADDR_prim_name	=	right.prim_name
							 and left.MAINADDR_prim_range	=	right.prim_range
							 and left.COMPANYNAME <> ''
							 and left.MAINADDR_zip5 <> '',
								 tJoin_Company_MainAddress(left,right),
								 lookup
								);
rCompanySlimJoin	tJoin_DBACompany_MainAddress(dCompanySlimClean pCompany, dAlertListClean pAlertList)
 :=
  transform
	//self.Company_MainAddress	:=	'Y';
	self.DBAAssumed_MainAddress := 'Y';
	self						:=	pCompany;
	self						:=	pAlertList;
  end
 ;
dJoin_DBACompany_MainAddress:=	join(dCompanySlimClean,dAlertListClean,
								// left.COMPANYNAME			=	right.BusinessName
							 left.COMPANYNAME  = right.DBAAssumedName
							 and left.MAINADDR_zip5			=	right.zip5
							 and left.MAINADDR_prim_name	=	right.prim_name
							 and left.MAINADDR_prim_range	=	right.prim_range
							 and left.COMPANYNAME <> ''
							 and left.MAINADDR_zip5 <> '',
								 tJoin_DBACompany_MainAddress(left,right),
								 lookup
								);

rCompanySlimJoin	tJoin_Company_BillAddress(dCompanySlimClean pCompany, dAlertListClean pAlertList)
 :=
  transform
	self.Company_BillAddress	:=	'Y';
	//self.DBAAssumed_BillAddress := 'Y';
	self						:=	pCompany;
	self						:=	pAlertList;
  end
 ;

dJoin_Company_BillAddress:=	join(dCompanySlimClean,dAlertListClean,
								 left.COMPANYNAME			=	right.BusinessName
							 and left.BILLADDR_zip5			=	right.zip5
							 and left.BILLADDR_prim_name	=	right.prim_name
							 and left.BILLADDR_prim_range	=	right.prim_range
							 and left.COMPANYNAME <> ''
							 and left.BILLADDR_zip5 <> '',
								 tJoin_Company_BillAddress(left,right),
								 lookup
								);
rCompanySlimJoin	tJoin_DBACompany_BillAddress(dCompanySlimClean pCompany, dAlertListClean pAlertList)
 :=
  transform
	//self.Company_BillAddress	:=	'Y';
	self.DBAAssumed_BillAddress := 'Y';
	self						:=	pCompany;
	self						:=	pAlertList;
  end
 ;
 
 dJoin_DBACompany_BillAddress:=	join(dCompanySlimClean,dAlertListClean,
								 left.COMPANYNAME			=	right.DBAAssumedName
							 and left.BILLADDR_zip5			=	right.zip5
							 and left.BILLADDR_prim_name	=	right.prim_name
							 and left.BILLADDR_prim_range	=	right.prim_range
							 and left.COMPANYNAME <> ''
							 and left.BILLADDR_zip5 <> '',
								 tJoin_DBACompany_BillAddress(left,right),
								 lookup
								);
rCompanySlimJoin	tJoin_MainContact_Address(dCompanySlimClean pCompany, dAlertListClean pAlertList)
 :=
  transform
	self.MainContact_Address	:=	'Y';
	self						:=	pCompany;
	self						:=	pAlertList;
  end
 ;

dJoin_MainContact_Address:=	join(dCompanySlimClean,dAlertListClean,
								 left.MAINNAME_lname	=	right.lname
							 and left.MAINNAME_fname	=	right.fname
							 and left.ADDR_zip5			=	right.zip5
							 and left.ADDR_prim_name	=	right.prim_name
							 and left.ADDR_prim_range	=	right.prim_range
							 and left.MAINNAME_lname <> ''
							 and left.ADDR_zip5 <> '',
								 tJoin_MainContact_Address(left,right),
								 lookup
								);

rCompanySlimJoin	tJoin_MainContact_MainAddress(dCompanySlimClean pCompany, dAlertListClean pAlertList)
 :=
  transform
	self.MainContact_MainAddress:=	'Y';
	self						:=	pCompany;
	self						:=	pAlertList;
  end
 ;

dJoin_MainContact_MainAddress:=	join(dCompanySlimClean,dAlertListClean,
									 left.MAINNAME_lname		=	right.lname
								 and left.MAINNAME_fname		=	right.fname
								 and left.MAINADDR_zip5			=	right.zip5
								 and left.MAINADDR_prim_name	=	right.prim_name
								 and left.MAINADDR_prim_range	=	right.prim_range
								 and left.MAINNAME_lname <> ''
								 and left.MAINADDR_zip5 <> '',
									 tJoin_MainContact_MainAddress(left,right),
									 lookup
									);

rCompanySlimJoin	tJoin_MainContact_BillAddress(dCompanySlimClean pCompany, dAlertListClean pAlertList)
 :=
  transform
	self.MainContact_BillAddress:=	'Y';
	self						:=	pCompany;
	self						:=	pAlertList;
  end
 ;

dJoin_MainContact_BillAddress:=	join(dCompanySlimClean,dAlertListClean,
									 left.MAINNAME_lname		=	right.lname
								 and left.MAINNAME_fname		=	right.fname
								 and left.BILLADDR_zip5			=	right.zip5
								 and left.BILLADDR_prim_name	=	right.prim_name
								 and left.BILLADDR_prim_range	=	right.prim_range
								 and left.MAINNAME_lname <> ''
								 and left.BILLADDR_zip5 <> '',
									 tJoin_MainContact_BillAddress(left,right),
									 lookup
									);

rCompanySlimJoin	tJoin_BillContact_Address(dCompanySlimClean pCompany, dAlertListClean pAlertList)
 :=
  transform
	self.BillContact_Address	:=	'Y';
	self						:=	pCompany;
	self						:=	pAlertList;
  end
 ;

dJoin_BillContact_Address:=	join(dCompanySlimClean,dAlertListClean,
								 left.BILLNAME_lname	=	right.lname
							 and left.BILLNAME_fname	=	right.fname
							 and left.ADDR_zip5			=	right.zip5
							 and left.ADDR_prim_name	=	right.prim_name
							 and left.ADDR_prim_range	=	right.prim_range
							 and left.BILLNAME_lname <> ''
							 and left.ADDR_zip5 <> '',
								 tJoin_BillContact_Address(left,right),
								 lookup
								);

rCompanySlimJoin	tJoin_BillContact_MainAddress(dCompanySlimClean pCompany, dAlertListClean pAlertList)
 :=
  transform
	self.BillContact_MainAddress:=	'Y';
	self						:=	pCompany;
	self						:=	pAlertList;
  end
 ;

dJoin_BillContact_MainAddress:=	join(dCompanySlimClean,dAlertListClean,
									 left.BILLNAME_lname		=	right.lname
								 and left.BILLNAME_fname		=	right.fname
								 and left.MAINADDR_zip5			=	right.zip5
								 and left.MAINADDR_prim_name	=	right.prim_name
								 and left.MAINADDR_prim_range	=	right.prim_range
								 and left.BILLNAME_lname <> ''
								 and left.MAINADDR_zip5 <> '',
									 tJoin_BillContact_MainAddress(left,right),
									 lookup
									);

rCompanySlimJoin	tJoin_BillContact_BillAddress(dCompanySlimClean pCompany, dAlertListClean pAlertList)
 :=
  transform
	self.BillContact_BillAddress:=	'Y';
	self						:=	pCompany;
	self						:=	pAlertList;
  end
 ;

dJoin_BillContact_BillAddress:=	join(dCompanySlimClean,dAlertListClean,
									 left.BILLNAME_lname		=	right.lname
								 and left.BILLNAME_fname		=	right.fname
								 and left.BILLADDR_zip5			=	right.zip5
								 and left.BILLADDR_prim_name	=	right.prim_name
								 and left.BILLADDR_prim_range	=	right.prim_range
								 and left.BILLNAME_lname <> ''
								 and left.BILLADDR_zip5 <> '',
									 tJoin_BillContact_BillAddress(left,right),
									 lookup
									);
 rCompanySlimJoin	tJoin_Company_MainContact(dCompanySlimClean pCompany, dAlertListClean pAlertList)
  :=
  transform
	self.Company_MainContact	:=	'Y';
	//self.DBAAssumed_MainContact := 'Y';
	self						:=	pCompany;
	self						:=	pAlertList;
  end
  ;

 dJoin_Company_MainContact	:=	join(dCompanySlimClean,dAlertListClean,
									  left.COMPANYNAME			=	right.BusinessName
								// and left.COMPANYNAME     =  right.DBAAssumedName
								 and left.MAINNAME_lname		=	right.lname
								  and left.MAINNAME_fname		=	right.fname
								  and left.COMPANYNAME <> ''
								  and left.MAINNAME_lname <> '',
									 tJoin_Company_MainContact(left,right),
									 lookup
									);
	rCompanySlimJoin	tJoin_DBACompany_MainContact(dCompanySlimClean pCompany, dAlertListClean pAlertList)
  :=
  transform
	//self.Company_MainContact	:=	'Y';
	self.DBAAssumed_MainContact := 'Y';
	self						:=	pCompany;
	self						:=	pAlertList;
  end
  ;
dJoin_DBACompany_MainContact	:=	join(dCompanySlimClean,dAlertListClean,
								//	  left.COMPANYNAME			=	right.BusinessName
								  left.COMPANYNAME     =  right.DBAAssumedName
								 and left.MAINNAME_lname		=	right.lname
								  and left.MAINNAME_fname		=	right.fname
								  and left.COMPANYNAME <> ''
								  and left.MAINNAME_lname <> '',
									 tJoin_DBACompany_MainContact(left,right),
									 lookup
									);
 rCompanySlimJoin	tJoin_Company_BillContact(dCompanySlimClean pCompany, dAlertListClean pAlertList)
  :=
   transform
	self.Company_BillContact	:=	'Y';
//	self.DBAAssumed_BillContact := 'Y';
	self						:=	pCompany;
	self						:=	pAlertList;
  end
  ;

dJoin_Company_BillContact	:=	join(dCompanySlimClean,dAlertListClean,
									 left.COMPANYNAME			=	right.BusinessName
								//	and left.COMPANYNAME = right.DBAAssumedName
								  and left.BILLNAME_lname		=	right.lname
								  and left.BILLNAME_fname		=	right.fname
								  and left.COMPANYNAME <> ''
								 and left.BILLNAME_lname <> '',
									  tJoin_Company_BillContact(left,right),
									 lookup
);


rCompanySlimJoin	tJoin_DBACompany_BillContact(dCompanySlimClean pCompany, dAlertListClean pAlertList)
  :=
   transform
	//self.Company_BillContact	:=	'Y';
	self.DBAAssumed_BillContact := 'Y';
	self						:=	pCompany;
	self						:=	pAlertList;
  end
  ;
dJoin_DBACompany_BillContact	:=	join(dCompanySlimClean,dAlertListClean,
									 //left.COMPANYNAME			=	right.BusinessName
									 left.COMPANYNAME = right.DBAAssumedName
								  and left.BILLNAME_lname		=	right.lname
								  and left.BILLNAME_fname		=	right.fname
								  and left.COMPANYNAME <> ''
								 and left.BILLNAME_lname <> '',
									  tJoin_DBACompany_BillContact(left,right),
									 lookup
									 );

 rCompanySlimJoin	tJoin_Telephone1(dCompanySlimClean pCompany, dAlertListClean pAlertList)
  :=
  transform
	 self.Telephone1					:=	'Y';
	 self						:=	pCompany;
	self						:=	pAlertList;
  end
 ;

 dJoin_Telephone1				:=	join(dCompanySlimClean,dAlertListClean,
									  left.Telephone_VOICE1		=	right.Telephone
								 and left.Telephone_VOICE1 <> '',
									 tJoin_Telephone1(left,right),
									 lookup
									 );

 rCompanySlimJoin	tJoin_Telephone2(dCompanySlimClean pCompany, dAlertListClean pAlertList)
  :=
   transform
	 self.Telephone2					:=	'Y';
	 self						:=	pCompany;
	self						:=	pAlertList;
  end
  ;

dJoin_Telephone2				:=	join(dCompanySlimClean,dAlertListClean,
									  left.Telephone_VOICE2		=	right.Telephone
								 and left.Telephone_VOICE2 <> '',
									 tJoin_Telephone2(left,right),
									  lookup
									 );

 rCompanySlimJoin	tJoin_MainTelephone1(dCompanySlimClean pCompany, dAlertListClean pAlertList)
 :=
   transform
	self.MainTelephone1				:=	'Y';
	 self						:=	pCompany;
	 self						:=	pAlertList;
   end
 ;

 dJoin_MainTelephone1			:=	join(dCompanySlimClean,dAlertListClean,
									  left.MAINTelephoneV1		=	right.Telephone
								  and left.MAINTelephoneV1 <> '',
									  tJoin_MainTelephone1(left,right),
									  lookup
									 );

 rCompanySlimJoin	tJoin_MainTelephone2(dCompanySlimClean pCompany, dAlertListClean pAlertList)
  :=
   transform
	 self.MainTelephone2				:=	'Y';
	 self						:=	pCompany;
	 self						:=	pAlertList;
   end
  ;

 dJoin_MainTelephone2			:=	join(dCompanySlimClean,dAlertListClean,
									  left.MAINTelephoneV2		=	right.Telephone
								  and left.MAINTelephoneV2 <> '',
									  tJoin_MainTelephone2(left,right),
									  lookup
									 );

 rCompanySlimJoin	tJoin_BillTelephone1(dCompanySlimClean pCompany, dAlertListClean pAlertList)
  :=
   transform
	 self.BillTelephone1				:=	'Y';
	 self						:=	pCompany;
	 self						:=	pAlertList;
   end
  ;

 dJoin_BillTelephone1			:=	join(dCompanySlimClean,dAlertListClean,
									  left.BILLTelephoneV1		=	right.Telephone
								  and left.BILLTelephoneV1 <> '',
									  tJoin_BillTelephone1(left,right),
									  lookup
									 );

 rCompanySlimJoin	tJoin_BillTelephone2(dCompanySlimClean pCompany, dAlertListClean pAlertList)
  :=
   transform
	 self.BillTelephone2				:=	'Y';
	 self						:=	pCompany;
	 self						:=	pAlertList;
   end
  ;

 dJoin_BillTelephone2			:=	join(dCompanySlimClean,dAlertListClean,
									  left.BILLTelephoneV2		=	right.Telephone
								  and left.BILLTelephoneV2 <> '',
									  tJoin_BillTelephone2(left,right),
									  lookup
									 );

 rCompanySlimJoin	tJoin_WebAddress(dCompanySlimClean pCompany, dAlertListClean pAlertList)
  :=
   transform
	 self.WebAddress				:=	'Y';
	 self						:=	pCompany;
	 self						:=	pAlertList;
  end
  ;

 dJoin_WebAddress			:=	join(dCompanySlimClean,dAlertListClean,
									 left.URL	=	right.website
								  and left.URL <> '',
									  tJoin_WebAddress(left,right),
									  lookup
									 );

dAllJoins	:=	dJoin_Company_Address
			+	dJoin_Company_MainAddress
			+	dJoin_Company_BillAddress
			+	dJoin_MainContact_Address
			+	dJoin_MainContact_MainAddress
			+	dJoin_MainContact_BillAddress
			+	dJoin_BillContact_Address
			+	dJoin_BillContact_MainAddress
			+	dJoin_BillContact_BillAddress
			 +	dJoin_Company_MainContact
			 +	dJoin_Company_BillContact
			 +	dJoin_Telephone1
			+	dJoin_Telephone2
			 +	dJoin_MainTelephone1
			+	dJoin_MainTelephone2
			+	dJoin_BillTelephone1
			+	dJoin_BillTelephone2
			+	dJoin_WebAddress
			;

rCompanySlimJoin	tRollUp(dAllJoins pLeft, dAllJoins pRight)
 :=
  transform
	self.Company_Address			:=	if(pLeft.Company_Address		 = 'Y' or pRight.Company_Address          = 'Y','Y','');	
	self.Company_MainAddress		:=	if(pLeft.Company_MainAddress	 = 'Y' or pRight.Company_MainAddress      = 'Y','Y','');
	self.Company_BillAddress		:=	if(pLeft.Company_BillAddress	 = 'Y' or pRight.Company_BillAddress      = 'Y','Y','');
	self.DBAAssumed_Address			:=	if(pLeft.DBAAssumed_Address		 = 'Y' or pRight.DBAAssumed_Address          = 'Y','Y','');	
	self.DBAAssumed_MainAddress		:=	if(pLeft.DBAAssumed_MainAddress	 = 'Y' or pRight.DBAAssumed_MainAddress      = 'Y','Y','');
	self.DBAAssumed_BillAddress		:=	if(pLeft.DBAAssumed_BillAddress	 = 'Y' or pRight.DBAAssumed_BillAddress      = 'Y','Y','');
	self.MainContact_Address		:=	if(pLeft.MainContact_Address	 = 'Y' or pRight.MainContact_Address      = 'Y','Y','');
	self.MainContact_MainAddress	:=	if(pLeft.MainContact_MainAddress = 'Y' or pRight.MainContact_MainAddress  = 'Y','Y','');
	self.MainContact_BillAddress	:=	if(pLeft.MainContact_BillAddress = 'Y' or pRight.MainContact_BillAddress  = 'Y','Y','');
	self.BillContact_Address		:=	if(pLeft.BillContact_Address	 = 'Y' or pRight.BillContact_Address      = 'Y','Y','');
	self.BillContact_MainAddress	:=	if(pLeft.BillContact_MainAddress = 'Y' or pRight.BillContact_MainAddress  = 'Y','Y','');
	self.BillContact_BillAddress	:=	if(pLeft.BillContact_BillAddress = 'Y' or pRight.BillContact_BillAddress  = 'Y','Y','');
	 self.Company_MainContact		:=	if(pLeft.Company_MainContact	 = 'Y' or pRight.Company_MainContact      = 'Y','Y','');
	 self.Company_BillContact		:=	if(pLeft.Company_BillContact	 = 'Y' or pRight.Company_BillContact      = 'Y','Y','');
	 self.DBAAssumed_MainContact		:=	if(pLeft.DBAAssumed_MainContact	 = 'Y' or pRight.DBAAssumed_MainContact      = 'Y','Y','');
	 self.DBAAssumed_BillContact		:=	if(pLeft.DBAAssumed_BillContact	 = 'Y' or pRight.DBAAssumed_BillContact      = 'Y','Y','');
	 self.Telephone1						:=	if(pLeft.Telephone1                  = 'Y' or pRight.Telephone1                   = 'Y','Y','');
	 self.Telephone2						:=	if(pLeft.Telephone2                  = 'Y' or pRight.Telephone2                   = 'Y','Y','');
	 self.MainTelephone1					:=	if(pLeft.MainTelephone1              = 'Y' or pRight.MainTelephone1               = 'Y','Y','');
	self.MainTelephone2					:=	if(pLeft.MainTelephone2              = 'Y' or pRight.MainTelephone2               = 'Y','Y','');
	self.BillTelephone1					:=	if(pLeft.BillTelephone1              = 'Y' or pRight.BillTelephone1               = 'Y','Y','');
	self.BillTelephone2					:=	if(pLeft.BillTelephone2              = 'Y' or pRight.BillTelephone2               = 'Y','Y','');
	self.WebAddress					:=	if(pLeft.WebAddress              = 'Y' or pRight.WebAddress               = 'Y','Y','');
	self.MatchCount					:=	(string2)length(lib_stringlib.StringLib.stringfilter(self.Company_Address
																						   + self.Company_MainAddress
																						   + self.Company_BillAddress
																						   + self.MainContact_Address    
																						   + self.MainContact_MainAddress
																						   + self.MainContact_BillAddress
																						   + self.BillContact_Address    
																						   + self.BillContact_MainAddress
																						   + self.BillContact_BillAddress
																						   + self.Company_MainContact    
																						   + self.Company_BillContact    
																						   + self.Telephone1			              
																						   + self.Telephone2			              
																						   + self.MainTelephone1		           
																						   + self.MainTelephone2		           
																						   + self.BillTelephone1		           
																						   + self.BillTelephone2		           
																						   + self.WebAddress		           
																						    ,'Y'));
	self							:=	pLeft;
  end
 ;

dAllJoinsDist		:=	distribute(dAllJoins,hash(COMPANYID));
dAllJoinsSort		:=	sort(dAllJoinsDist,COMPANYID,local);
dAllJoinsRolledUp	:=	rollup(dAllJoinsSort,
							   left.COMPANYID	=	right.COMPANYID,
							   tRollup(left,right),
							   local
							  );

dCompanyRolledUpSort:=	sort(dAllJoinsRolledUp,COMPANYID);

output(dCompanyRolledUpSort,all,named('All_With_Match_Flags'));

/*
output(dJoin_Company_Address,named('Company_Address'),all);
output(dJoin_Company_MainAddress,named('Company_MainAddress'),all);
output(dJoin_Company_BillAddress,named('Company_BillAddress'),all);
output(dJoin_MainContact_Address,named('MainContact_Address'),all);
output(dJoin_MainContact_MainAddress,named('MainContact_MainAddress'),all);
output(dJoin_MainContact_BillAddress,named('MainContact_BillAddress'),all);
output(dJoin_BillContact_Address,named('BillContact_Address'),all);
output(dJoin_BillContact_MainAddress,named('BillContact_MainAddress'),all);
output(dJoin_BillContact_BillAddress,named('BillContact_BillAddress'),all);
output(dJoin_Company_MainContact,named('Company_MainContact'),all);
output(dJoin_Company_BillContact,named('Company_BillContact'),all);
output(dJoin_Telephone1,named('Telephone1'),all);
output(dJoin_Telephone2,named('Telephone2'),all);
output(dJoin_MainTelephone1,named('MainTelephone1'),all);
output(dJoin_MainTelephone2,named('MainTelephone2'),all);
output(dJoin_BillTelephone1,named('BillTelephone1'),all);
output(dJoin_BillTelephone2,named('BillTelephone2'),all);
output(dJoin_WebAddress,named('WebAddress'),all);
*/

/*
output(dAlertListClean);
output(dCompanySlimClean);
*/


/*
	self.title					:=	pInput.clean_pname[1..5];
	self.fname					:=	pInput.clean_pname[6..25];
	self.mname					:=	pInput.clean_pname[26..45];
	self.lname					:=	pInput.clean_pname[46..65];
	self.name_suffix			:=	pInput.clean_pname[66..70];
	self.name_cleaning_score	:=	pInput.clean_pname[71..73];
	self.prim_range 			:=	pInput.clean_address[1..10];
	self.predir 				:=	pInput.clean_address[11..12];
	self.prim_name 				:=	pInput.clean_address[13..40];
	self.suffix 				:=	pInput.clean_address[41..44];
	self.postdir 				:=	pInput.clean_address[45..46];
	self.unit_desig 			:=	pInput.clean_address[47..56];
	self.sec_range 				:=	pInput.clean_address[57..64];
	self.p_city_name 			:=	pInput.clean_address[65..89];
	self.v_city_name 			:=	pInput.clean_address[90..114];
	self.st 					:=	pInput.clean_address[115..116];
	self.zip5 					:=	pInput.clean_address[117..121];
	self.zip4 					:=	pInput.clean_address[122..125];
	self.cart 					:=	pInput.clean_address[126..129];
	self.cr_sort_sz 			:=	pInput.clean_address[130];
	self.lot 					:=	pInput.clean_address[131..134];
	self.lot_order 				:=	pInput.clean_address[135];
	self.dpbc 					:=	pInput.clean_address[136..137];
	self.chk_digit 				:=	pInput.clean_address[138];
	self.rec_type				:=	pInput.clean_address[139..140];
	self.ace_fips_st 			:=	pInput.clean_address[141..142];
	self.ace_fips_county		:=	pInput.clean_address[143..145];
	self.geo_lat 				:=	pInput.clean_address[146..155];
	self.geo_long 				:=	pInput.clean_address[156..166];
	self.msa 					:=	pInput.clean_address[167..170];
	self.geo_blk 				:=	pInput.clean_address[171..177];
	self.geo_match 				:=	pInput.clean_address[178];
	self.err_stat 				:=	pInput.clean_address[179..182];
	self.county					:=	pInput.clean_address[143..145];
*/