
import	address,lib_stringlib;

#workunit('name','Accurint Business Company Experian Alerts relaxed');
//contains matches based on all factors(telephone,comp name,comp address)

lAlertListDate		:=	'20080201';
lCustomerListDate	:=	'20080201';

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
								   address.cleanpersonFML73(pInput.FirstName + ' '  + pInput.MiddleName + ' ' + pInput.LastName),
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
	string	companyid;
	string	companyname;
	string	main_contact_name;
	string	main_contact_email;
	string	main_address_line_1;
	string	main_address_line_2;
	string	main_address_line_3;
	string	main_address_city;
	string	main_address_state;
	string	main_address_zip;
	string	main_phone_voice;
	string	billing_contact_name;
	string	billing_contact_email;
	string	billing_address_line_1;
	string	billing_address_line_2;
	string	billing_address_line_3;
	string	billing_address_city;
	string	billing_address_state;
	string	billing_address_zip;
	string	billing_phone_voice;
  end
 ;

dCompany	:=	dataset('~thor_data400::ab_company::' + lCustomerListDate + '::data',rCompany,csv(separator(','),terminator('\n'),quote('"'),heading(1)));

rCompanySlim
 :=
  record
	rCompany;
  end
 ;

rCompanySlimBlob
 :=
  record
	rCompanySlim;
	string73	main_contact_name_clean;
	string73	billing_contact_name_clean;
	string182	main_address_clean;
	string182	billing_address_clean;
  end
 ;

rCompanySlimBlob	tCompanySlimBlob(dCompany pInput)
 :=
  transform
    self.companyname				:=	lib_stringlib.StringLib.stringtouppercase(pInput.companyname);
	 self.main_phone_voice			:=	lib_stringlib.StringLib.stringfilter(pInput.main_phone_voice,'0123456789');
	 self.billing_phone_voice		:=	lib_stringlib.StringLib.stringfilter(pInput.billing_phone_voice,'0123456789');
	self.main_contact_name_clean	:=	if(pInput.main_contact_name<>'',
										   address.cleanpersonFML73(pInput.main_contact_name),
										   ''
										  );
	self.billing_contact_name_clean	:=	if(pInput.billing_contact_name<>'',
										   address.cleanpersonFML73(pInput.billing_contact_name),
										   ''
										  );
	self.main_address_clean			:=	if(pInput.main_address_state<>'' or pInput.main_address_zip<>'',
										   address.cleanaddress182(pInput.main_address_line_1 + ' ' + pInput.main_address_line_2 + ' ' + pInput.main_address_line_3,pInput.main_address_city + ' ' + pInput.main_address_state + '  ' + pInput.main_address_zip),
										   ''
										  );
	self.billing_address_clean		:=	if(pInput.billing_address_state<>'' or pInput.billing_address_zip<>'',
										   address.cleanaddress182(pInput.billing_address_line_1 + ' ' + pInput.billing_address_line_2 + ' ' + pInput.billing_address_line_3,pInput.billing_address_city + ' ' + pInput.billing_address_state + '  ' + pInput.billing_address_zip),
										   ''
										  );
	self							:=	pInput;
  end
 ;
  
dCompanySlimBlob	:=	project(dCompany,tCompanySlimBlob(left));

rCompanySlimClean
 :=
  record
	rCompanySlim;
	string5		main_contact_name_title;
	string20	main_contact_name_fname;
	string20	main_contact_name_mname;
	string20	main_contact_name_lname;
	string5		main_contact_name_name_suffix;
	string3		main_contact_name_name_cleaning_score;
	string5		billing_contact_name_title;
	string20	billing_contact_name_fname;
	string20	billing_contact_name_mname;
	string20	billing_contact_name_lname;
	string5		billing_contact_name_name_suffix;
	string3		billing_contact_name_name_cleaning_score;
	string10	main_address_prim_range;
	string2		main_address_predir;
	string28	main_address_prim_name;
	string4		main_address_suffix;
	string2		main_address_postdir;
	string10	main_address_unit_desig;
	string8		main_address_sec_range;
	string25	main_address_p_city_name;
	string25	main_address_v_city_name;
	string2		main_address_st;
	string5		main_address_zip5;
	string4		main_address_zip4;
	string4		main_address_cart;
	string1		main_address_cr_sort_sz;
	string4		main_address_lot;
	string1		main_address_lot_order;
	string2		main_address_dpbc;
	string1		main_address_chk_digit;
	string2		main_address_rec_type;
	string2		main_address_ace_fips_st;
	string3		main_address_ace_fips_county;
	string10	main_address_geo_lat;
	string11	main_address_geo_long;
	string4		main_address_msa;
	string7		main_address_geo_blk;
	string1		main_address_geo_match;
	string4		main_address_err_stat;
	string10	billing_address_prim_range;
	string2		billing_address_predir;
	string28	billing_address_prim_name;
	string4		billing_address_suffix;
	string2		billing_address_postdir;
	string10	billing_address_unit_desig;
	string8		billing_address_sec_range;
	string25	billing_address_p_city_name;
	string25	billing_address_v_city_name;
	string2		billing_address_st;
	string5		billing_address_zip5;
	string4		billing_address_zip4;
	string4		billing_address_cart;
	string1		billing_address_cr_sort_sz;
	string4		billing_address_lot;
	string1		billing_address_lot_order;
	string2		billing_address_dpbc;
	string1		billing_address_chk_digit;
	string2		billing_address_rec_type;
	string2		billing_address_ace_fips_st;
	string3		billing_address_ace_fips_county;
	string10	billing_address_geo_lat;
	string11	billing_address_geo_long;
	string4		billing_address_msa;
	string7		billing_address_geo_blk;
	string1		billing_address_geo_match;
	string4		billing_address_err_stat;
  end
 ;

rCompanySlimClean	tCompanySlimCleanFromBlob(dCompanySlimBlob pInput)
 :=
  transform
	self.main_contact_name_title					:=	pInput.main_contact_name_clean[1..5];
	self.main_contact_name_fname					:=	pInput.main_contact_name_clean[6..25];
	self.main_contact_name_mname					:=	pInput.main_contact_name_clean[26..45];
	self.main_contact_name_lname					:=	pInput.main_contact_name_clean[46..65];
	self.main_contact_name_name_suffix			:=	pInput.main_contact_name_clean[66..70];
	self.main_contact_name_name_cleaning_score	:=	pInput.main_contact_name_clean[71..73];
	self.billing_contact_name_title					:=	pInput.billing_contact_name_clean[1..5];
	self.billing_contact_name_fname					:=	pInput.billing_contact_name_clean[6..25];
	self.billing_contact_name_mname					:=	pInput.billing_contact_name_clean[26..45];
	self.billing_contact_name_lname					:=	pInput.billing_contact_name_clean[46..65];
	self.billing_contact_name_name_suffix			:=	pInput.billing_contact_name_clean[66..70];
	self.billing_contact_name_name_cleaning_score	:=	pInput.billing_contact_name_clean[71..73];
	self.main_address_prim_range 			:=	pInput.main_address_clean[1..10];
	self.main_address_predir 				:=	pInput.main_address_clean[11..12];
	self.main_address_prim_name 			:=	pInput.main_address_clean[13..40];
	self.main_address_suffix 				:=	pInput.main_address_clean[41..44];
	self.main_address_postdir 				:=	pInput.main_address_clean[45..46];
	self.main_address_unit_desig 			:=	pInput.main_address_clean[47..56];
	self.main_address_sec_range 			:=	pInput.main_address_clean[57..64];
	self.main_address_p_city_name 			:=	pInput.main_address_clean[65..89];
	self.main_address_v_city_name 			:=	pInput.main_address_clean[90..114];
	self.main_address_st 					:=	pInput.main_address_clean[115..116];
	self.main_address_zip5 					:=	pInput.main_address_clean[117..121];
	self.main_address_zip4 					:=	pInput.main_address_clean[122..125];
	self.main_address_cart 					:=	pInput.main_address_clean[126..129];
	self.main_address_cr_sort_sz 			:=	pInput.main_address_clean[130];
	self.main_address_lot 					:=	pInput.main_address_clean[131..134];
	self.main_address_lot_order 			:=	pInput.main_address_clean[135];
	self.main_address_dpbc 					:=	pInput.main_address_clean[136..137];
	self.main_address_chk_digit 			:=	pInput.main_address_clean[138];
	self.main_address_rec_type				:=	pInput.main_address_clean[139..140];
	self.main_address_ace_fips_st 			:=	pInput.main_address_clean[141..142];
	self.main_address_ace_fips_county		:=	pInput.main_address_clean[143..145];
	self.main_address_geo_lat 				:=	pInput.main_address_clean[146..155];
	self.main_address_geo_long 				:=	pInput.main_address_clean[156..166];
	self.main_address_msa 					:=	pInput.main_address_clean[167..170];
	self.main_address_geo_blk 				:=	pInput.main_address_clean[171..177];
	self.main_address_geo_match 			:=	pInput.main_address_clean[178];
	self.main_address_err_stat 				:=	pInput.main_address_clean[179..182];
	self.billing_address_prim_range 		:=	pInput.billing_address_clean[1..10];
	self.billing_address_predir 			:=	pInput.billing_address_clean[11..12];
	self.billing_address_prim_name 			:=	pInput.billing_address_clean[13..40];
	self.billing_address_suffix 			:=	pInput.billing_address_clean[41..44];
	self.billing_address_postdir 			:=	pInput.billing_address_clean[45..46];
	self.billing_address_unit_desig 		:=	pInput.billing_address_clean[47..56];
	self.billing_address_sec_range 			:=	pInput.billing_address_clean[57..64];
	self.billing_address_p_city_name 		:=	pInput.billing_address_clean[65..89];
	self.billing_address_v_city_name 		:=	pInput.billing_address_clean[90..114];
	self.billing_address_st 				:=	pInput.billing_address_clean[115..116];
	self.billing_address_zip5 				:=	pInput.billing_address_clean[117..121];
	self.billing_address_zip4 				:=	pInput.billing_address_clean[122..125];
	self.billing_address_cart 				:=	pInput.billing_address_clean[126..129];
	self.billing_address_cr_sort_sz 		:=	pInput.billing_address_clean[130];
	self.billing_address_lot 				:=	pInput.billing_address_clean[131..134];
	self.billing_address_lot_order 			:=	pInput.billing_address_clean[135];
	self.billing_address_dpbc 				:=	pInput.billing_address_clean[136..137];
	self.billing_address_chk_digit 			:=	pInput.billing_address_clean[138];
	self.billing_address_rec_type			:=	pInput.billing_address_clean[139..140];
	self.billing_address_ace_fips_st 		:=	pInput.billing_address_clean[141..142];
	self.billing_address_ace_fips_county	:=	pInput.billing_address_clean[143..145];
	self.billing_address_geo_lat 			:=	pInput.billing_address_clean[146..155];
	self.billing_address_geo_long 			:=	pInput.billing_address_clean[156..166];
	self.billing_address_msa 				:=	pInput.billing_address_clean[167..170];
	self.billing_address_geo_blk 			:=	pInput.billing_address_clean[171..177];
	self.billing_address_geo_match 			:=	pInput.billing_address_clean[178];
	self.billing_address_err_stat 			:=	pInput.billing_address_clean[179..182];
	self									:=	pInput;
  end
 ;

dCompanySlimClean	:=	project(dCompanySlimBlob,tCompanySlimCleanFromBlob(left)) : persist('~thor_data400::persist::ab_company');

rCompanySlimJoin
 :=
  record
	rCompanySlim;
	rAlertListClean;
	string1	Company_Address 		:= 	'';
	string1	Company_main_address 	:= 	'';
	string1	Company_billing_address 	:= 	'';
	string1	DBAAssumed_Address 		:= 	'';
	string1	DBAAssumed_main_address 	:= 	'';
	string1	DBAAssumed_billing_address 	:= 	'';
	string1	MainContact_Address 	:= 	'';
	string1	MainContact_main_address	:= 	'';
	string1	MainContact_billing_address	:= 	'';
	string1	BillContact_Address 	:= 	'';
	string1	BillContact_main_address	:= 	'';
	string1	BillContact_billing_address	:= 	'';
	string1 Company_MainContact		:=	'';
	string1	Company_BillContact		:=	'';
	string1 DBAAssumed_MainContact		:=	'';
	string1	DBAAssumed_BillContact		:=	'';
	string1	Phone1					:=	'';
	string1	Phone2					:=	'';
	 string1	MainPhone1				:=	'';
	string1	MainPhone2				:=	'';
	 string1	BillPhone1				:=	'';
  string1	BillPhone2				:=	'';
	string1	WebAddress				:=	'';
	string2	MatchCount				:=	'';
  end
 ;

rCompanySlimJoin	tJoin_Company_Main_Address(dCompanySlimClean pCompany, dAlertListClean pAlertList)
 :=
  transform
	self.Company_main_Address	:=	'Y';
	self						:=	pCompany;
	self						:=	pAlertList;
  end
 ;

dJoin_Company_main_address:=	join(dCompanySlimClean,dAlertListClean,
								 left.COMPANYNAME			=	right.BusinessName
							 and left.main_address_zip5			=	right.zip5
							 and left.main_address_prim_name	=	right.prim_name
							 and left.main_address_prim_range	=	right.prim_range
							 and left.COMPANYNAME <> ''
							 and left.main_address_zip5 <> '',
								 tJoin_company_main_address(left,right),
								 lookup
								);
rCompanySlimJoin	tJoin_DBACompany_Main_Address(dCompanySlimClean pCompany, dAlertListClean pAlertList)
 :=
  transform
	//self.Company_main_Address	:=	'Y';
	self.DBAAssumed_main_Address := 'Y';
	self						:=	pCompany;
	self						:=	pAlertList;
  end
 ;

dJoin_DBACompany_main_address:=	join(dCompanySlimClean,dAlertListClean,
								 left.COMPANYNAME			=	right.DBAAssumedName
							 and left.main_address_zip5			=	right.zip5
							 and left.main_address_prim_name	=	right.prim_name
							 and left.main_address_prim_range	=	right.prim_range
							 and left.COMPANYNAME <> ''
							 and left.main_address_zip5 <> '',
								 tJoin_DBACompany_main_address(left,right),
								 lookup
								);
rCompanySlimJoin	tJoin_Company_billing_address(dCompanySlimClean pCompany, dAlertListClean pAlertList)
 :=
  transform
	self.Company_billing_address	:=	'Y';
	self						:=	pCompany;
	self						:=	pAlertList;
  end
 ;

dJoin_Company_billing_address:=	join(dCompanySlimClean,dAlertListClean,
								 left.COMPANYNAME			=	right.BusinessName
							 and left.billing_address_zip5			=	right.zip5
							 and left.billing_address_prim_name	=	right.prim_name
							 and left.billing_address_prim_range	=	right.prim_range
							 and left.COMPANYNAME <> ''
							 and left.billing_address_zip5 <> '',
								 tJoin_Company_billing_address(left,right),
								 lookup
								);
								
rCompanySlimJoin	tJoin_DBACompany_billing_address(dCompanySlimClean pCompany, dAlertListClean pAlertList)
 :=
  transform
	self.DBAAssumed_billing_address	:=	'Y';
	self						:=	pCompany;
	self						:=	pAlertList;
  end
 ;
dJoin_DBACompany_billing_address:=	join(dCompanySlimClean,dAlertListClean,
								 left.COMPANYNAME			=	right.DBAAssumedName
							 and left.billing_address_zip5			=	right.zip5
							 and left.billing_address_prim_name	=	right.prim_name
							 and left.billing_address_prim_range	=	right.prim_range
							 and left.COMPANYNAME <> ''
							 and left.billing_address_zip5 <> '',
								 tJoin_DBACompany_billing_address(left,right),
								 lookup
								);
rCompanySlimJoin	tJoin_MainContact_main_address(dCompanySlimClean pCompany, dAlertListClean pAlertList)
 :=
  transform
	self.MainContact_main_address:=	'Y';
	self						:=	pCompany;
	self						:=	pAlertList;
  end
 ;

dJoin_MainContact_main_address:=	join(dCompanySlimClean,dAlertListClean,
									 left.main_contact_name_lname		=	right.lname
								 and left.main_contact_name_fname		=	right.fname
								 and left.main_address_zip5			=	right.zip5
								 and left.main_address_prim_name	=	right.prim_name
								 and left.main_address_prim_range	=	right.prim_range
								 and left.main_contact_name_lname <> ''
								 and left.main_address_zip5 <> '',
									 tJoin_MainContact_main_address(left,right),
									 lookup
									);

rCompanySlimJoin	tJoin_MainContact_billing_address(dCompanySlimClean pCompany, dAlertListClean pAlertList)
 :=
  transform
	self.MainContact_billing_address:=	'Y';
	self						:=	pCompany;
	self						:=	pAlertList;
  end
 ;

dJoin_MainContact_billing_address:=	join(dCompanySlimClean,dAlertListClean,
									 left.main_contact_name_lname		=	right.lname
								 and left.main_contact_name_fname		=	right.fname
								 and left.billing_address_zip5			=	right.zip5
								 and left.billing_address_prim_name	=	right.prim_name
								 and left.billing_address_prim_range	=	right.prim_range
								 and left.main_contact_name_lname <> ''
								 and left.billing_address_zip5 <> '',
									 tJoin_MainContact_billing_address(left,right),
									 lookup
									);

rCompanySlimJoin	tJoin_BillContact_main_address(dCompanySlimClean pCompany, dAlertListClean pAlertList)
 :=
  transform
	self.BillContact_main_address:=	'Y';
	self						:=	pCompany;
	self						:=	pAlertList;
  end
 ;

dJoin_BillContact_main_address:=	join(dCompanySlimClean,dAlertListClean,
									 left.billing_contact_name_lname		=	right.lname
								 and left.billing_contact_name_fname		=	right.fname
								 and left.main_address_zip5			=	right.zip5
								 and left.main_address_prim_name	=	right.prim_name
								 and left.main_address_prim_range	=	right.prim_range
								 and left.billing_contact_name_lname <> ''
								 and left.main_address_zip5 <> '',
									 tJoin_BillContact_main_address(left,right),
									 lookup
									);

rCompanySlimJoin	tJoin_BillContact_billing_address(dCompanySlimClean pCompany, dAlertListClean pAlertList)
 :=
  transform
	self.BillContact_billing_address:=	'Y';
	self						:=	pCompany;
	self						:=	pAlertList;
  end
 ;

dJoin_BillContact_billing_address:=	join(dCompanySlimClean,dAlertListClean,
									 left.billing_contact_name_lname		=	right.lname
								 and left.billing_contact_name_fname		=	right.fname
								 and left.billing_address_zip5			=	right.zip5
								 and left.billing_address_prim_name	=	right.prim_name
								 and left.billing_address_prim_range	=	right.prim_range
								 and left.billing_contact_name_lname <> ''
								 and left.billing_address_zip5 <> '',
									 tJoin_BillContact_billing_address(left,right),
									 lookup
									);

 rCompanySlimJoin	tJoin_Company_MainContact(dCompanySlimClean pCompany, dAlertListClean pAlertList)
  :=
   transform
	 self.Company_MainContact	:=	'Y';
	 self						:=	pCompany;
	 self						:=	pAlertList;
   end
  ;

 dJoin_Company_MainContact	:=	join(dCompanySlimClean,dAlertListClean,
									 left.COMPANYNAME			=	right.BusinessName
								  and left.main_contact_name_lname		=	right.lname
								  and left.main_contact_name_fname		=	right.fname
								  and left.COMPANYNAME <> ''
								  and left.main_contact_name_lname <> '',
									  tJoin_Company_MainContact(left,right),
									  lookup
									 );

rCompanySlimJoin	tJoin_DBACompany_MainContact(dCompanySlimClean pCompany, dAlertListClean pAlertList)
  :=
   transform
	 self.DBAAssumed_MainContact	:=	'Y';
	 self						:=	pCompany;
	 self						:=	pAlertList;
   end
  ;
	dJoin_DBACompany_MainContact	:=	join(dCompanySlimClean,dAlertListClean,
									 left.COMPANYNAME			=	right.DBAAssumedName
								  and left.main_contact_name_lname		=	right.lname
								  and left.main_contact_name_fname		=	right.fname
								  and left.COMPANYNAME <> ''
								  and left.main_contact_name_lname <> '',
									  tJoin_DBACompany_MainContact(left,right),
									  lookup
									 );
 rCompanySlimJoin	tJoin_Company_BillContact(dCompanySlimClean pCompany, dAlertListClean pAlertList)
  :=
   transform
	 self.Company_BillContact	:=	'Y';
	self						:=	pCompany;
	 self						:=	pAlertList;
   end
  ;

 dJoin_Company_BillContact	:=	join(dCompanySlimClean,dAlertListClean,
									  left.COMPANYNAME			=	right.BusinessName
								  and left.billing_contact_name_lname		=	right.lname
								  and left.billing_contact_name_fname		=	right.fname
								  and left.COMPANYNAME <> ''
								  and left.billing_contact_name_lname <> '',
									  tJoin_Company_BillContact(left,right),
									  lookup
									 );
rCompanySlimJoin	tJoin_DBACompany_BillContact(dCompanySlimClean pCompany, dAlertListClean pAlertList)
  :=
   transform
	 self.DBAAssumed_BillContact	:=	'Y';
	self						:=	pCompany;
	 self						:=	pAlertList;
   end
  ;
	dJoin_DBACompany_BillContact	:=	join(dCompanySlimClean,dAlertListClean,
									  left.COMPANYNAME			=	right.DBAAssumedName
								  and left.billing_contact_name_lname		=	right.lname
								  and left.billing_contact_name_fname		=	right.fname
								  and left.COMPANYNAME <> ''
								  and left.billing_contact_name_lname <> '',
									  tJoin_DBACompany_BillContact(left,right),
									  lookup
									 );
 rCompanySlimJoin	tJoin_MainPhone1(dCompanySlimClean pCompany, dAlertListClean pAlertList)
  :=
   transform
	 self.MainPhone1				:=	'Y';
	 self						:=	pCompany;
	 self						:=	pAlertList;
   end
  ;

 dJoin_MainPhone1			:=	join(dCompanySlimClean,dAlertListClean,
									  left.MAIN_PHONE_VOICE		=	right.Telephone
								  and left.MAIN_PHONE_VOICE <> '',
									  tJoin_MainPhone1(left,right),
									  lookup
									 );

 rCompanySlimJoin	tJoin_BillPhone1(dCompanySlimClean pCompany, dAlertListClean pAlertList)
  :=
   transform
	 self.BillPhone1				:=	'Y';
	 self						:=	pCompany;
	 self						:=	pAlertList;
   end
  ;

 dJoin_BillPhone1			:=	join(dCompanySlimClean,dAlertListClean,
									  left.BILLING_PHONE_VOICE		=	right.Telephone
								  and left.BILLING_PHONE_VOICE <> '',
									  tJoin_BillPhone1(left,right),
									  lookup
									 );

dAllJoins	:=	dJoin_Company_main_address
			+	dJoin_Company_billing_address
			+ dJoin_DBACompany_main_address
			+	dJoin_DBACompany_billing_address
			+	dJoin_MainContact_main_address
			+	dJoin_MainContact_billing_address
			+	dJoin_BillContact_main_address
			+	dJoin_BillContact_billing_address
			 +	dJoin_Company_MainContact
			 +	dJoin_Company_BillContact
			  +	dJoin_DBACompany_MainContact
			 +	dJoin_DBACompany_BillContact
			 +	dJoin_MainPHone1
			 +	dJoin_BillPHone1
			;

rCompanySlimJoin	tRollUp(dAllJoins pLeft, dAllJoins pRight)
 :=
  transform
	self.Company_main_address		:=	if(pLeft.Company_main_address	 = 'Y' or pRight.Company_main_address      = 'Y','Y','');
	self.Company_billing_address		:=	if(pLeft.Company_billing_address	 = 'Y' or pRight.Company_billing_address      = 'Y','Y','');
	self.DBAAssumed_main_address		:=	if(pLeft.DBAAssumed_main_address	 = 'Y' or pRight.DBAAssumed_main_address      = 'Y','Y','');
	self.DBAAssumed_billing_address		:=	if(pLeft.DBAAssumed_billing_address	 = 'Y' or pRight.DBAAssumed_billing_address      = 'Y','Y','');
	self.MainContact_main_address	:=	if(pLeft.MainContact_main_address = 'Y' or pRight.MainContact_main_address  = 'Y','Y','');
	self.MainContact_billing_address	:=	if(pLeft.MainContact_billing_address = 'Y' or pRight.MainContact_billing_address  = 'Y','Y','');
	self.BillContact_main_address	:=	if(pLeft.BillContact_main_address = 'Y' or pRight.BillContact_main_address  = 'Y','Y','');
	self.BillContact_billing_address	:=	if(pLeft.BillContact_billing_address = 'Y' or pRight.BillContact_billing_address  = 'Y','Y','');
	 self.Company_MainContact		:=	if(pLeft.Company_MainContact	 = 'Y' or pRight.Company_MainContact      = 'Y','Y','');
	 self.Company_BillContact		:=	if(pLeft.Company_BillContact	 = 'Y' or pRight.Company_BillContact      = 'Y','Y','');
	 self.DBAAssumed_MainContact		:=	if(pLeft.DBAAssumed_MainContact	 = 'Y' or pRight.DBAAssumed_MainContact      = 'Y','Y','');
	 self.DBAAssumed_BillContact		:=	if(pLeft.DBAAssumed_BillContact	 = 'Y' or pRight.DBAAssumed_BillContact      = 'Y','Y','');
	 self.MainPhone1					:=	if(pLeft.MainPhone1              = 'Y' or pRight.MainPhone1               = 'Y','Y','');
	 self.BillPhone1					:=	if(pLeft.BillPhone1              = 'Y' or pRight.BillPhone1               = 'Y','Y','');
	self.MatchCount					:=	(string2)length(lib_stringlib.StringLib.stringfilter(self.Company_main_address
																						   + self.Company_billing_address
																							 + self.DBAAssumed_main_address
																						   + self.DBAAssumed_billing_address
																						   + self.MainContact_main_address
																						   + self.MainContact_billing_address
																						   + self.BillContact_main_address
																						   + self.BillContact_billing_address
																						    + self.Company_MainContact    
																						    + self.Company_BillContact 
																								 + self.DBAAssumed_MainContact    
																						    + self.DBAAssumed_BillContact
																						    + self.MainPhone1		           
																						    + self.BillPhone1		           
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
output(dJoin_Company_main_address,named('Company_main_address'),all);
output(dJoin_Company_billing_address,named('Company_billing_address'),all);
output(dJoin_MainContact_Address,named('MainContact_Address'),all);
output(dJoin_MainContact_main_address,named('MainContact_main_address'),all);
output(dJoin_MainContact_billing_address,named('MainContact_billing_address'),all);
output(dJoin_BillContact_Address,named('BillContact_Address'),all);
output(dJoin_BillContact_main_address,named('BillContact_main_address'),all);
output(dJoin_BillContact_billing_address,named('BillContact_billing_address'),all);
output(dJoin_Company_MainContact,named('Company_MainContact'),all);
output(dJoin_Company_BillContact,named('Company_BillContact'),all);
output(dJoin_PHone1,named('Phone1'),all);
output(dJoin_PHone2,named('Phone2'),all);
output(dJoin_MainPHone1,named('MainPhone1'),all);
output(dJoin_MainPHone2,named('MainPhone2'),all);
output(dJoin_BillPHone1,named('BillPhone1'),all);
output(dJoin_BillPHone2,named('BillPhone2'),all);
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