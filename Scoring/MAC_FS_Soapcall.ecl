export MAC_FS_Soapcall (file_in,  file_out) := macro
  Total := count(file_in);
//Missing Input Data :
  Account := count(file_in(Account =''));
  Last  := count(file_in(Last  =''));
  Addr := count(file_in(Addr =''));
  City := 	count(file_in(City  =''));
  State := count(file_in(State =''));
  Zip := count(file_in(Zip=''));
  SSN := count(file_in(socs =''));
  HomePhone := count(file_in(HPhone =''));
  WorkPhone := count(file_in(wPhone =''));
  DOB := count(file_in(DOB =''));
  drlc := count(file_in(drlc =''));
	EMAIL := count(file_in(EMAIL =''));
	IPAddress := count(file_in(IPAddress =''));
	
//Duplicate Records  :
  Unique_SSN := count(DEDUP(SORT(file_in(Socs <>''), Socs),Socs,all));
  Unique_Phone:= count(DEDUP(SORT(file_in(HPhone <>''), HPhone),HPhone,all));
  Unique_Account := count(DEDUP(SORT(file_in(Account <>''), Account),Account,all));

//Phone Validation Flags :
	invalid_hphn := count(file_in(phonevalflag='0'));
	valid_Wphn := count(file_in(phonevalflag='1'));
	Valid_res_phn := count(file_in(phonevalflag='2'));
	valid_phone_usage_unknown := count(file_in(phonevalflag='3'));
	phone_improperly_formatted := count(file_in(phonevalflag='4'));
//Phone Risk Flags :
	Not_high_risk := count(file_in(hriskphoneflag='0'));
	cell_mobile := count(file_in(hriskphoneflag='1'));
	pager := count(file_in(hriskphoneflag='2'));
	PCS := count(file_in(hriskphoneflag='3'));
	other_npots := count(file_in(hriskphoneflag='4'));
	disconnect := count(file_in(hriskphoneflag='5'));
	highrisk := count(file_in(hriskphoneflag='6')); 	//field summary excel template doesn't have field for hriskphoneflag='7'
//Phone/Zip Mismatch Flags :
	no_mismatch := count(file_in(phonezipflag='0'));
	mismatch  := count(file_in(phonezipflag='1'));
	phnzip_improper_format := count(file_in(phonezipflag='2'));
//Postal Address Validation Flags :
	postal_val_add := count(file_in(addrvalflag='V'));
	postal_inv_add := count(file_in(addrvalflag='N'));
	postal_amb_add := count(file_in(addrvalflag='M'));
//High Risk Address Flags :
	add_not_risk := count(file_in(hriskaddrflag='0'));
	add_pobox  := count(file_in(hriskaddrflag='1'));
	add_corp  := count(file_in(hriskaddrflag='2'));
	add_mil  := count(file_in(hriskaddrflag='3'));
	add_hriskcom  := count(file_in(hriskaddrflag='4'));
	add_improp_format  := count(file_in(hriskaddrflag='5'));
//Type of Dwelling of Apllicant Address :
	sfdu := count(file_in(dwelltypeflag=''));
	multi_unit := count(file_in(dwelltypeflag='A'));
	Comp_org := count(file_in(dwelltypeflag='B'));
	pobox := count(file_in(dwelltypeflag='E'));
	St_alias := count(file_in(dwelltypeflag='G'));
	Rural_route := count(file_in(dwelltypeflag='R'));
	Gen_delivery := count(file_in(dwelltypeflag='S'));
//SSN Validation FLags :
	ssn_valid  := count(file_in(socsvalflag='0'));
	ssn_invalid := count(file_in(socsvalflag='1'));
	SSN_improper_format := count(file_in(socsvalflag='2' or socsvalflag='3'));  
//SSN Deceased Flags :
	not_deceased := count(file_in(decsflag='0'));
	deceased := count(file_in(decsflag='1'));
//SSN/DOB Flags :
	ssn_notprior := count(file_in(socsdobflag='0'));
	ssn_prior := count(file_in(socsdobflag='1'));
	ssndob_improper_format  := count(file_in(socsdobflag='2' or socsdobflag='3'));	
//DL Validation Flags :
	DL_Valid  := count(file_in(drlcvalflag='0'));
	DL_notValid := count(file_in(drlcvalflag='1'));
	DL_improp_format := count(file_in(drlcvalflag='2'));
//Area Code Has or Will Be Changed
	AC_recent_split := count(file_in(areacodesplitflag='1'));
	phn_improper_format := count(file_in(areacodesplitflag='2'));
//Searchable Input Elements :
phone_s :=  count(file_in((hriskphoneflag<'1' or hriskphoneflag>'4') and (phonevalflag<>'0' and phonevalflag<>'4')));
address_s := count(file_in(Addr <>'' and length(zip)>=5));
//Counting Number of Input Elements Hit
search4 := count(file_in(socsvalflag='0'and last<>'' and Addr <>'' and length(zip)>=5 and 
					(hriskphoneflag<'1' or hriskphoneflag>'4') and (phonevalflag<>'0' and phonevalflag<>'4')));
search3 := count(file_in( (socsvalflag='0' and last<>'' and addr<>'' and length(zip)>=5) or
						(socsvalflag='0' and last<>'' and ((hriskphoneflag<'1' or hriskphoneflag>'4') and phonevalflag<>'0' and phonevalflag<>'4')) or 
						(socsvalflag='0' and addr<>'' and length(zip)>=5 and (hriskphoneflag<'1' or hriskphoneflag>'4') and phonevalflag<>'0' and phonevalflag<>'4') or
						(last<>'' and addr<>'' and length(zip)>=5 and (hriskphoneflag<'1' or hriskphoneflag>'4') and (phonevalflag<>'0' and phonevalflag<>'4'))));
					
search2 := count(file_in( (socsvalflag='0' and last<>'') or (socsvalflag='0' and addr<>''and length(zip)>=5) or
						(socsvalflag='0' and ((hriskphoneflag<'1' or hriskphoneflag>'4') and (phonevalflag<>'0' and phonevalflag<>'4'))) or
						(last<>'' and addr<>''and length(zip)>=5 )or
						(last<>'' and ((hriskphoneflag<'1' or hriskphoneflag>'4') and phonevalflag<>'0' and phonevalflag<>'4'))or
						(addr<>''and length(zip)>=5 and (hriskphoneflag<'1' or hriskphoneflag>'4') and phonevalflag<>'0' and phonevalflag<>'4')));
us_state := count(file_in(state<>'' and StringLib.StringToupperCase(state) in ['AL' 	,'AK' 	,'AS' 	,'AZ' 	,'AR' 	,
	'CA' 	,'CO' 	,'CT' 	,'DE' 	,'DC' 	,'FM' 	,'FL' 	,
	'GA' 	,'GU' 	,'HI' 	,'ID' 	,'IL' 	,'IN' 	,'IA' 	,
	'KS' 	,'KY' 	,'LA' 	,'ME' 	,'MH' 	,'MD' 	,'MA' 	,'MI' 	,'MN' 	,'MS' 	,'MO' 	,'MT' 	,
	'NE' 	,'NV' 	,'NH' 	,'NJ' 	,'NM' 	,'NY' 	,'NC' 	,'ND' 	,'MP' 	,
	'OH' 	,'OK' 	,'OR' 	,'PW' 	,'PA' 	,'PR' 	,'RI' 	,
	'SC' 	,'SD' 	,'TN' 	,'TX' 	,'UT' 	,
	'VT' 	,'VI' 	,'VA' 	,'WA' 	,'WV' 	,'WI' 	,'WY' 	,'AE' 	,'AA' 	,'AP' 	]));

FSR_Format := record
  Total;
  Account;
  Last;
  Addr;
  City;
  State;
  Zip;
  SSN;
  HomePhone;
  workphone;
  DOB;
  drlc;
  Unique_SSN;
  Unique_Phone;
  Unique_Account;
  invalid_hphn ;
  valid_Wphn ;
  Valid_res_phn ;
  valid_phone_usage_unknown ;
  phone_improperly_formatted ;
  Not_high_risk ;
	cell_mobile ;
	pager ;
	PCS ;
	other_npots ;
	disconnect ;
	highrisk ;
	no_mismatch ;
	mismatch ;
	phnzip_improper_format ;
	postal_val_add ;
	postal_inv_add ;
	postal_amb_add ;
	add_not_risk ;
	add_pobox ;
	add_corp ;
	add_mil ;
	add_hriskcom ;
	add_improp_format ;
	sfdu ;
	multi_unit ;
	Comp_org ;
	pobox ;
	St_alias ;
	Rural_route ;
	Gen_delivery ;
	ssn_valid; 
	ssn_invalid ;
	SSN_improper_format ;
	not_deceased ;
	deceased ;
	ssn_notprior ;
	ssn_prior ;
	ssndob_improper_format ;
	DL_Valid ;
	DL_notValid ;
	DL_improp_format ;
	AC_recent_split ;
	phn_improper_format ;
	phone_s ;
	address_s; 
	search4 ;
	search3 ;
	search2 ;
	us_state ;
	EMAIL;
	IPAddress;

end;

file_out := TABLE(file_in, FSR_Format,Total);
endmacro;