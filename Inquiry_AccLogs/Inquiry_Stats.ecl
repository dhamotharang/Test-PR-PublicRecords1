import header, phonesplus_v2, gong, infutorcid, Risk_Indicators, ut, entiera, impulse_email, business_Header, ut, email_data;

// stat_type values
//'non-fcra', 'fcra'
export Inquiry_Stats (string stat_type = 'nonfcra') := function

// #workunit('name', 'Inquiry_AccLog Stats')

//***************************Slim Inquiry Base File 
inq_file := if(regexreplace('[^a-z]', stringlib.stringtolowercase(stat_type), '') = 'nonfcra',  Inquiry_AccLogs.File_Inquiry_BaseSourced.Full, Inquiry_AccLogs.File_FCRA_Inquiry_BaseSourced)(bus_intel.vertical not in Inquiry_AccLogs.fnCleanFunctions.FilterCds);

slim_Allow_Flags := record
	inq_file.Allow_Flags.allowflags;
end;

slim_Entity := record
	unsigned Appended_Adl;
	unsigned Appended_BDID;
	string10 prim_range ;
	string2  predir ;
	string28 prim_name ;
	string8  sec_range ;
	string25 v_city_name ;
	string2  st ;
	string5  zip5 ;
	string4  zip4 ;
	string10 Personal_Phone;
	string10 Work_Phone;
	string10 Company_Phone;
	unsigned DOB;
	string9 SSN ;
	string9 EIN;
	string Email_Address;
	
end;

slim_bus_intel := record
	inq_file.bus_intel.vertical;
	inq_file.bus_intel.industry;
	inq_file.bus_intel.use;
end;

slim_search_info := record
	inq_file.search_info.function_description;
	inq_file.search_info.Product_Code;
end;

slim_layout := record
	slim_Allow_Flags Allow_Flags;
	slim_Entity;
    slim_bus_intel bus_intel;
	slim_search_info search_info;
	string20 source;
	string14 stat_type;
end;

//Slim inquiry files 
slim_layout t_map_slim (inq_file le) := transform
		boolean is_person := (trim(
								le.Person_Q.Full_Name + 
								le.Person_Q.First_Name + 
								le.Person_Q.Middle_Name + 
								le.Person_Q.Last_Name + 
								le.Person_Q.Address + 
								le.Person_Q.City + 
								le.Person_Q.State + 
								le.Person_Q.Zip + 
								le.Person_Q.Personal_Phone + 
								le.Person_Q.Work_Phone + 
								le.Person_Q.DOB + 
								le.Person_Q.DL + 
								le.Person_Q.DL_St +
								le.Person_Q.Email_Address + 
								le.Person_Q.SSN, all)  <> '');
								
	boolean is_business := trim(le.Bus_Q.CName + 
								le.Bus_Q.Address + 
								le.Bus_Q.City + 
								le.Bus_Q.State + 
								le.Bus_Q.Zip + 
								le.Bus_Q.Company_Phone + 
								le.Bus_Q.EIN, all)  <> '' and 
								trim(le.BusUser_Q.First_Name + 
								le.BusUser_Q.Middle_Name + 
								le.BusUser_Q.Last_Name + 
								le.BusUser_Q.Address + 
								le.BusUser_Q.City + 
								le.BusUser_Q.State + 
								le.BusUser_Q.Zip + 
								le.BusUser_Q.Personal_Phone + 
								le.BusUser_Q.DOB + 
								le.BusUser_Q.DL + 
								le.BusUser_Q.DL_St +
								le.BusUser_Q.SSN, all) = ''
								;
	boolean is_buser := trim(le.BusUser_Q.First_Name + 
								le.BusUser_Q.Middle_Name + 
								le.BusUser_Q.Last_Name + 
								le.BusUser_Q.Address + 
								le.BusUser_Q.City + 
								le.BusUser_Q.State + 
								le.BusUser_Q.Zip + 
								le.BusUser_Q.Personal_Phone + 
								le.BusUser_Q.DOB + 
								le.BusUser_Q.DL + 
								le.BusUser_Q.DL_St +
								le.BusUser_Q.SSN, all) <> '';
								
		self.Appended_Adl 	:= map(is_person => le.Person_Q.Appended_Adl,
									is_buser => le.BusUser_Q.Appended_Adl,
								 0);
		self.Appended_BDID 	:= map(is_business => le.Bus_Q.Appended_BDID,
									0);
		self.prim_range   	:= map(is_person => le.Person_Q.prim_range,
								   is_business => le.Bus_Q.prim_range,
								   '');
		self.predir 		:= map(is_person => le.Person_Q.predir,
								   is_business => le.Bus_Q.predir,
								   '');
		self.prim_name 		:= map(is_person => le.Person_Q.prim_name,
								   is_business => le.Bus_Q.prim_name,
								   '');
		self.sec_range 		:= map(is_person => le.Person_Q.sec_range ,
								   is_business => le.Bus_Q.sec_range ,
								   '');
		self.v_city_name 	:= map(is_person => le.Person_Q.v_city_name ,
								   is_business => le.Bus_Q.v_city_name,
								   '');
		self.st 			:= map(is_person => le.Person_Q.st ,
								   is_business => le.Bus_Q.st,
								   '');
		self.zip5 			:= map(is_person => le.Person_Q.zip5 ,
								   is_business => le.Bus_Q.zip5,
								   '');
		self.zip4 			:= map(is_person => le.Person_Q.zip4 ,
								   is_business => le.Bus_Q.zip4,
								   '');
		self.Personal_Phone := map(is_person => le.Person_Q.Personal_Phone ,
								   is_buser => le.BusUser_Q.Personal_Phone,
								   '');
		self.Work_Phone		:= map(is_person => le.Person_Q.Work_Phone,
								   '');
		self.Company_Phone	:= map(is_business => le.Bus_Q.Company_Phone,
								   '');						   
		self.DOB			:= map(is_person => (unsigned)le.Person_Q.DOB ,
								   is_buser => (unsigned)le.BusUser_Q.DOB,
								   0);
		self.SSN 			:= map(is_person => le.Person_Q.SSN ,
								   is_buser => le.BusUser_Q.SSN,
								   '');
		self.EIN			:= map(is_business => le.Bus_Q.EIN,
								   '');
		self.Email_Address	:= map(is_person => le.Person_Q.Email_Address,
								   '');
		self.stat_type		:= map(is_person => 'PERSON' ,
								   is_business => 'BUSINESS',
								   is_buser => 'BUSINESS_USER',
								   '');
		self.source			:= le.source;
	    self := le;
	end;
		
slim_inq := project(inq_file, t_map_slim(left));

//***************************Header (Person) 
p_hdr := header.File_Headers;

slim_p_hdr_layout := record
	unsigned6 did := 0;
	string10 prim_range;
	string28 prim_name;
	string8  sec_range;
	string5  zip;
	string phone;
	string ssn;
	unsigned dob;
	string1 valid_SSN;
end; 

slim_p_hdr := project(p_hdr, slim_p_hdr_layout);
slim_p_hdr_dist := distribute(slim_p_hdr, hash(did));

//***************************Header (Business)
b_hdr := business_header.File_Business_Header;
slim_b_hdr_layout := record
	unsigned6 bdid := 0;
	string10 prim_range;
	string28 prim_name;
	string8  sec_range;
	string5  zip;
	string phone;
	unsigned4 fein := 0;
end; 


slim_b_hdr := project(b_hdr, transform (slim_b_hdr_layout,
									   self.zip := intformat(left.zip, 5,1),
									   self.phone := (string) left.phone, 
									   self := left
									   ));

slim_b_hdr_dist := distribute(slim_b_hdr, hash(bdid));


//***************************Address_Files
slim_address_layout := record
	string10 prim_range;
	string28 prim_name;
	string8  sec_range;
	string5  zip;
end;

p_hdr_addr := project(slim_p_hdr, slim_address_layout);
b_hdr_addr := project(slim_b_hdr, slim_address_layout);

all_addresses := p_hdr_addr + b_hdr_addr ;


//***************************Phone Files
slim_phone_layout := record
	unsigned did;
	string phone;
end;

pplus := project(Phonesplus_v2.File_Phonesplus_Base, transform(slim_phone_layout,
																 self.phone := left.cellphone,
																 self.did := left.did));
gong_f :=project(Gong.File_History (phone10 != '' and length(stringlib.stringfilter(phone10,'0123456789')) = 10 and 
				phone10[7..10] != '0000' and phone10[7..10] != '9999' and publish_code != 'N'), 
													   transform(slim_phone_layout,
																self.phone := left.phone10,
																self.did := left.did));
infcid := project(infutorcid.File_InfutorCID_Base(phone != '' and length(stringlib.stringfilter(phone,'0123456789')) = 10 and 
				phone[7..10] != '0000'and phone[7..10] != '9999'), slim_phone_layout);
hdr_ph := project(slim_p_hdr_dist(phone != '' and length(stringlib.stringfilter(phone,'0123456789')) = 10 and 
				phone[7..10] != '0000'and phone[7..10] != '9999'), slim_phone_layout);

all_phones := dedup(sort(distribute(pplus + gong_f + infcid + hdr_ph, hash(did, phone)), did, phone, local), did, phone, local);

telcordia_tpm := distribute(dedup(Risk_Indicators.File_Telcordia_tpm,npa,nxx,tb,all),hash(npa,nxx,tb));

//***************************Email Files
slim_email_layout := record
	unsigned did;
	string email;
end;

entiera_f := project(entiera.File_Entiera_Base, transform(slim_email_layout,
														  self.email := trim(left.orig_email,all),
														  self.did := left.did));
impulse_f := project(impulse_email.files.file_Impulse_Email_Base, transform(slim_email_layout,
														  self.email := trim(left.email, all),
														  self.did := left.did));
all_email := dedup(sort(distribute(entiera_f + impulse_f, hash(did)), did, email, local), did, email, local);

//*********Funtion to validate SSN
boolean is_ssn_valid(string ssn) := function
 boolean is_blank				:= (unsigned) ssn = 0;
 boolean is_partial             := ut.partial_ssn(ssn);
 boolean is_itin                := ssn[1]='9' and ssn[4] in ['7','8'];
 boolean is_666                 := ssn[1..3]='666';
 boolean is_eae                 := ssn[1..3] between '729' and '733';
 boolean is_advertising         := ssn between '987654320' and '987654329';
 boolean is_woolworth           := ssn='078051120';
 boolean is_invalid_area        := ssn[1..3]= '000' and is_partial=false and is_itin=false;
 boolean is_invalid_group       := ssn[4..5]=  '00' and is_partial=false and is_itin=false;
 boolean is_invalid_serial      := ssn[6..9]='0000'                      and is_itin=false;
 boolean all_9				    := ssn[..7] = '9999999' or ssn[2..] = '99999999';
 boolean less_9_len             :=  length(ssn) <> 9;
 boolean invalid_area			:= ssn[..3] between '800' and '999';
								   
return ~(is_blank or is_partial or is_itin or is_eae or is_advertising or is_woolworth or is_invalid_area or is_invalid_group or is_invalid_serial or all_9 or  less_9_len or invalid_area); 
end;

//***********************************************    STATS    ********************************************
//1.       Total number of inquiry records
tot_inq := slim_inq;

//2.       Total number of inquiry records associated with an ADL/BDL
tot_inq_with_adl := slim_inq(appended_adl > 0);
tot_inq_with_bdl := slim_inq(Appended_BDID > 0);
tot_inq_with_adl_d := dedup(slim_inq(appended_adl > 0), appended_adl, all);
tot_inq_with_bdl_d := dedup(slim_inq(Appended_BDID > 0), Appended_BDID, all);

//3.       Total number of inquiry records that are flagged to be allowed for data return
tot_inq_allow_return := slim_inq(~Inquiry_AccLogs.fnTranslations.is_Opt_Out(Allow_Flags.allowflags));

//4.       Total number of inquiry records that are flagged to be allowed for data return that are associated with an ADL
tot_inq_allow_return_with_adl := slim_inq(~Inquiry_AccLogs.fnTranslations.is_Opt_Out(Allow_Flags.allowflags) and appended_adl > 0);
tot_inq_allow_return_with_bdl := slim_inq(~Inquiry_AccLogs.fnTranslations.is_Opt_Out(Allow_Flags.allowflags) and Appended_BDID > 0);

//5.       Total number of new, unique phone numbers
slim_ph_ly := record
	string phone;
	tot_inq.stat_type;
end;

phones_all := project(tot_inq(length(trim(Personal_Phone, all)) = 10), transform(slim_ph_ly, self.phone := left.Personal_Phone, self := left)) +
			   project(tot_inq(length(trim(Company_Phone, all)) = 10), transform(slim_ph_ly, self.phone := left.Company_Phone, self := left));	

phones_uniq := dedup(sort(distribute(phones_all, hash(phone)), phone, local), phone, local);

new_phones := join(distribute(phones_uniq, hash(phone)),
				   distribute(all_phones, hash(phone)),
				   left.phone = right.phone,
				   left only, 
				   local);

new_phones_valid := join(distribute(new_phones, hash(Phone[1..3], Phone[4..6] ,Phone[7])), 
									telcordia_tpm,
									left.Phone[1..3] = right.npa and 
									left.Phone[4..6] = right.nxx and
									left.Phone[7]    = right.tb,
									local); 

//output(new_phones_valid);
//6.       Total number of new, unique addresses
addresses_uniq := dedup(sort(distribute(tot_inq(trim(prim_name + sec_range, all) <> '' and zip5 <> '' and zip4 <> '' and zip4 not in ['9999', '0001']), 
								hash(prim_range, prim_name, sec_range,zip5)),
						  prim_range, prim_name, sec_range,zip5, local), 
				     prim_range, prim_name, sec_range,zip5,  local);

new_addresses := join(addresses_uniq,
					  distribute(all_addresses, hash(prim_range, prim_name, sec_range,zip)),
					  left.prim_range = right.prim_range and
					  left.prim_name = right.prim_name and
					  left.sec_range = right.sec_range and
					  left.zip5 = right.zip,
					  left only,
					  local);

//output(new_addresses);
				  
//7.       Total number of inquiry sourced unique SSNs tied to an ADL / BDL
tot_ssn_adl := slim_inq(SSN <> '' and appended_adl > 0 and is_ssn_valid(trim(SSN,all)));
hdr_ssn_did := dedup(sort(slim_p_hdr_dist, did, (if (valid_ssn = 'G', 1,2)), -ssn, local), did, local);

hdr_without_good_ssn := join(slim_p_hdr_dist, 
							 hdr_ssn_did(valid_ssn = 'G'),  //with good ssn,
							 left.did = right.did,
							 left only,
							 local);
							 
tot_ssn_adl_new := join(distribute(tot_ssn_adl, hash(appended_adl)),							
							 hdr_without_good_ssn,
							 left.appended_adl = right.did and
							 left.SSN <> right.ssn,
							 local);
							 
tot_ssn_adl_uniq := dedup(sort(tot_ssn_adl_new, appended_adl, SSN, local), appended_adl, SSN, local);							 

//output(sort(tot_ssn_adl_new, SSN))	;	
//output(sort(tot_ssn_adl_new, -SSN))	;

tot_ssn_bdl := slim_inq(EIN <> '' and appended_bdid > 0 and (unsigned)EIN > 9999);
hdr_fei_did := dedup(sort(slim_b_hdr_dist, bdid, -fein, local), bdid, local);

tot_ssn_bdl_new := join(distribute(tot_ssn_bdl, hash(appended_bdid)),
							 hdr_fei_did(fein <= 9999),
							 left.appended_bdid = right.bdid,
							 local);

tot_ssn_bdl_uniq := dedup(sort(tot_ssn_bdl_new, appended_bdid, ein, local), appended_bdid, ein, local);								 

//8.       Total number of inquiry sourced unique DOBs tied to an ADL 
tot_dob_adl := slim_inq(DOB > 19100101 and DOB < (unsigned)((string)((unsigned)ut.GetDate[..4] - 18)[..4] +  ut.GetDate[5..])   and appended_adl > 0);

hdr_dob_did := dedup(sort(slim_p_hdr_dist, did, -dob, local), did, local);

tot_dob_adl_new := join(distribute(tot_dob_adl, hash(appended_adl)),
							 hdr_dob_did(dob < 190001),
							 left.appended_adl = right.did,
							 local);
//output(sort(tot_dob_adl_new, DOB))	;	
//output(sort(tot_dob_adl_new, -DOB))	;						 							 

tot_dob_adl_uniq := dedup(sort(tot_dob_adl_new, appended_adl, DOB, local), appended_adl, DOB, local);


//9.       Total number of inquiry sourced unique phones tied to an ADL 
tot_phone_adl := slim_inq(Personal_Phone <> '' and appended_adl > 0);

tot_phone_adl_new := join(distribute(tot_phone_adl, hash(appended_adl)),
				   distribute(all_phones(did >0), hash(did)),
				   left.appended_adl =  right.did and 
				   left.Personal_Phone = right.phone,
				   left only, 
				   local) ;

tot_phone_adl_new_valid := join(distribute(tot_phone_adl_new, hash(Personal_Phone[1..3], Personal_Phone[4..6] ,Personal_Phone[7])), 
									telcordia_tpm,
									left.Personal_Phone[1..3] = right.npa and 
									left.Personal_Phone[4..6] = right.nxx and
									left.Personal_Phone[7]    = right.tb,
									local); 
//output(tot_phone_adl_new_valid)	;

tot_phone_adl_uniq := dedup(sort(distribute(tot_phone_adl_new_valid , hash(appended_adl)), appended_adl, Personal_Phone, local), appended_adl, Personal_Phone, local);


tot_phone_bdl := slim_inq((unsigned)Company_Phone > 0 and appended_bdid > 0 );

tot_phone_bdl_new := join(distribute(tot_ssn_bdl, hash(appended_bdid)),
							 slim_b_hdr_dist(phone <> ''),
							 left.appended_bdid = right.bdid and
							 left.Company_Phone = right.Phone,
							 left only,
							 local);



tot_phone_bdl_new_valid := join(distribute(tot_phone_bdl_new, hash(Phone[1..3],Phone[4..6] ,Phone[7])), 
									telcordia_tpm,
									left.Phone[1..3] = right.npa and 
									left.Phone[4..6] = right.nxx and
									left.Phone[7]    = right.tb,
									left only,
									local); 


tot_phone_bdl_uniq := dedup(sort(distribute(tot_phone_bdl_new_valid , hash(appended_bdid)), appended_bdid, Company_Phone, local), appended_adl, Company_Phone, local);
									
//10.   Total number of inquiry sourced unique addresses tied to an ADL 
tot_address_adl := slim_inq(trim(prim_name + sec_range, all) <> '' and zip5 <> '' and appended_adl > 0 and zip4 <> '');

tot_address_adl_new := join(distribute(tot_address_adl, hash(appended_adl)),
							 slim_p_hdr_dist,
							 left.appended_adl = right.did and
							 left.prim_range = (string)right.prim_range and
							 left.prim_name = (string)right.prim_name and
							 left.sec_range = (string)right.sec_range and
							 left.zip5 = (string)right.zip,
							 left only,
							 local);
							 

tot_address_adl_uniq := dedup(sort(tot_address_adl_new, appended_adl, prim_range, prim_name, sec_range, zip5,local), appended_adl, prim_range, prim_name, sec_range, zip5, local);

//output(tot_address_adl_uniq )	;

tot_address_bdl := slim_inq(trim(prim_name + sec_range, all) <> '' and zip5 <> '' and appended_bdid > 0 and zip4 <> '');

tot_address_bdl_new := join(distribute(tot_address_bdl, hash(appended_bdid)),
							 slim_b_hdr_dist,
							 left.appended_bdid = right.bdid and
							 left.prim_range = right.prim_range and
							 left.prim_name = right.prim_name and
							 left.sec_range = right.sec_range and
							 left.zip5 = right.zip,
							 left only,
							 local);
							 

tot_address_bdl_uniq := dedup(sort(tot_address_bdl_new, appended_bdid, prim_range, prim_name, sec_range, zip5,local), appended_bdid, prim_range, prim_name, sec_range, zip5, local);

//11.   Total number of inquiry sourced unique email addresses tied to an ADL 
tot_email_adl := slim_inq(Email_Address <> '' and length(trim(Email_Address,all)) > 4 and StringLib.StringFindCount(Email_Address,  '@') > 0 and length(Email_data.Fn_Clean_Email_Username(Email_Address)) >  1  and appended_adl > 0);

tot_email_adl_new := join(distribute(tot_email_adl, hash(appended_adl)),
							 all_email,
							 left.appended_adl = right.did and
							 left.Email_Address = right.email,
							 left only,
							 local);

//output(sort(tot_email_adl_new, Email_Address))	;	
//output(sort(tot_email_adl_new, -Email_Address))	;	

tot_email_adl_uniq := dedup(sort(tot_email_adl_new, appended_adl, Email_Address, local), appended_adl, Email_Address, local);

//12.   Total number of inquiry sourced unique SSNs tied to an ADL that are flagged to be allowed for data return
tot_ssn_adl_allow_return  := tot_ssn_adl_new (~Inquiry_AccLogs.fnTranslations.is_Opt_Out(Allow_Flags.allowflags));
tot_ssn_adl_allow_return_uniq := dedup(sort(distribute(tot_ssn_adl_allow_return, hash(appended_adl)), appended_adl,SSN, local), appended_adl, SSN, local);
	
tot_ssn_bdl_allow_return  := tot_ssn_bdl_new (~Inquiry_AccLogs.fnTranslations.is_Opt_Out(Allow_Flags.allowflags));
tot_ssn_bdl_allow_return_uniq := dedup(sort(distribute(tot_ssn_bdl_allow_return, hash(appended_bdid)), appended_bdid ,ein, local), appended_bdid, ein, local);
	
	
//13.   Total number of inquiry sourced unique DOBs tied to an ADL that are flagged to be allowed for data return
tot_dob_adl_allow_return := tot_dob_adl_new(~Inquiry_AccLogs.fnTranslations.is_Opt_Out(Allow_Flags.allowflags));
tot_dob_adl_allow_return_uniq := dedup(sort(distribute(tot_dob_adl_allow_return, hash(appended_adl)), appended_adl, DOB, local), appended_adl, DOB, local);

//14.   Total number of inquiry sourced unique phones tied to an ADL that are flagged to be allowed for data return
tot_phone_adl_allow_return := tot_phone_adl_new_valid(~Inquiry_AccLogs.fnTranslations.is_Opt_Out(Allow_Flags.allowflags));
tot_phone_adl_allow_return_uniq := dedup(sort(distribute(tot_phone_adl_allow_return , hash(appended_adl)), appended_adl, Personal_Phone, local), appended_adl, Personal_Phone, local);

tot_phone_bdl_allow_return := tot_phone_bdl_new_valid(~Inquiry_AccLogs.fnTranslations.is_Opt_Out(Allow_Flags.allowflags));
tot_phone_bdl_allow_return_uniq := dedup(sort(distribute(tot_phone_bdl_allow_return , hash(appended_bdid)), appended_bdid, Company_Phone, local), appended_bdid, Company_Phone, local);

//15.   Total number of inquiry sourced unique addresses tied to an ADL that are flagged to be allowed for data return
tot_address_adl_allow_return := tot_address_adl_new(trim(prim_name + sec_range, all) <> ''  and zip5 <> '' and appended_adl > 0 and ~Inquiry_AccLogs.fnTranslations.is_Opt_Out(Allow_Flags.allowflags));
tot_address_adl_allow_return_uniq := dedup(sort(distribute(tot_address_adl_allow_return , hash(appended_adl)), appended_adl, prim_range, prim_name, sec_range, zip5,local), appended_adl, prim_range, prim_name, sec_range, zip5, local);

tot_address_bdl_allow_return := tot_address_bdl_new(trim(prim_name + sec_range, all) <> ''  and zip5 <> '' and appended_adl > 0 and ~Inquiry_AccLogs.fnTranslations.is_Opt_Out(Allow_Flags.allowflags));
tot_address_bdl_allow_return_uniq := dedup(sort(distribute(tot_address_bdl_allow_return , hash(appended_bdid)), appended_bdid, prim_range, prim_name, sec_range, zip5,local), appended_bdid, prim_range, prim_name, sec_range, zip5, local);

//16.   Total number of inquiry sourced unique email addresses tied to an ADL that are flagged to be allowed for data return
tot_email_adl_allow_return := tot_email_adl_new(Email_Address <> '' and appended_adl > 0 and ~Inquiry_AccLogs.fnTranslations.is_Opt_Out(Allow_Flags.allowflags));
tot_email_adl_allow_return_uniq := dedup(sort(distribute(tot_email_adl_allow_return, hash(appended_adl)), appended_adl, Email_Address, local), appended_adl, Email_Address, local);

//17.   Total number of inquiries for each of the vertical assignments (Financial Services, Collections, etc)
tbl_vertical := table(slim_inq, {
								 string50 vertical := trim(stringlib.stringtouppercase(bus_intel.vertical), left, right), 
								 all_		  := count(group),
								 pct := ((real)count(group) / (real)count(slim_inq)) * 100,
								 person_Cnt   := count(group,stat_type='PERSON'),
								 pct1 := ((real)count(group,stat_type='PERSON') / (real)count(slim_inq(stat_type='PERSON'))) * 100,
								 bus     := count(group,stat_type='BUSINESS'),
								 pct2 := ((real)count(group,stat_type='BUSINESS') / (real)count(slim_inq(stat_type='BUSINESS'))) * 100,
								 busu     := count(group,stat_type='BUSINESS_USER'),
								 pct3 := ((real)count(group,stat_type='BUSINESS_USER') / (real)count(slim_inq(stat_type='BUSINESS_USER'))) * 100
								 },
								 trim(stringlib.stringtouppercase(bus_intel.vertical), left, right), few);

//18.   Total number of inquiries for each of the industry values (Bank, Credit Union, Auto, etc)
tbl_industry := table(slim_inq, {string50 industry := trim(stringlib.stringtouppercase(bus_intel.industry), left, right),
								 all_ := count(group),
								 pct := ((real)count(group) / (real)count(slim_inq)) * 100,
								 person_Cnt   := count(group,stat_type='PERSON'),
								 pct1 := ((real)count(group,stat_type='PERSON') / (real)count(slim_inq(stat_type='PERSON'))) * 100,
								 bus     := count(group,stat_type='BUSINESS'),
								 pct2 := ((real)count(group,stat_type='BUSINESS') / (real)count(slim_inq(stat_type='BUSINESS'))) * 100,
								 busu     := count(group,stat_type='BUSINESS_USER'),
								 pct3 := ((real)count(group,stat_type='BUSINESS_USER') / (real)count(slim_inq(stat_type='BUSINESS_USER'))) * 100
								 }, 
								 trim(stringlib.stringtouppercase(bus_intel.industry), left, right), few);
								
//19.   Total number of inquiries for each function name (InstantID, Person Search, etc)
tbl_funtion := table(slim_inq, {
								string50 b_function := trim(stringlib.stringtouppercase(search_info.function_description), left, right), 
								 all_ := count(group),
								 pct := ((real)count(group) / (real)count(slim_inq)) * 100,
								 person_Cnt   := count(group,stat_type='PERSON'),
								 pct1 := ((real)count(group,stat_type='PERSON') / (real)count(slim_inq(stat_type='PERSON'))) * 100,
								 bus     := count(group,stat_type='BUSINESS'),
								 pct2 := ((real)count(group,stat_type='BUSINESS') / (real)count(slim_inq(stat_type='BUSINESS'))) * 100,
								 busu     := count(group,stat_type='BUSINESS_USER'),
								 pct3 := ((real)count(group,stat_type='BUSINESS_USER') / (real)count(slim_inq(stat_type='BUSINESS_USER'))) * 100
								},
								   trim(stringlib.stringtouppercase(search_info.function_description), left, right),few);
//20.   Total number of inquiries for each platform (Accurint, Riskwise, Banko, etc)
tbl_platform := table(slim_inq, {
								 source,
								 all_ := count(group),
								 pct := ((real)count(group) / (real)count(slim_inq)) * 100,
								 person_Cnt   := count(group,stat_type='PERSON'),
								 pct1 := ((real)count(group,stat_type='PERSON') / (real)count(slim_inq(stat_type='PERSON'))) * 100,
								 bus     := count(group,stat_type='BUSINESS'),
								 pct2 := ((real)count(group,stat_type='BUSINESS') / (real)count(slim_inq(stat_type='BUSINESS'))) * 100,
								 busu     := count(group,stat_type='BUSINESS_USER'),
								 pct3 := ((real)count(group,stat_type='BUSINESS_USER') / (real)count(slim_inq(stat_type='BUSINESS_USER'))) * 100		  
									 }, source,
										few);

//21.   Total number of inquiries for each use
tbl_use := table(slim_inq, {
								 string50 use := bus_intel.use,
								 all_ := count(group),
								 pct := ((real)count(group) / (real)count(slim_inq)) * 100,
								 person_Cnt   := count(group,stat_type='PERSON'),
								 pct1 := ((real)count(group,stat_type='PERSON') / (real)count(slim_inq(stat_type='PERSON'))) * 100,
								 bus     := count(group,stat_type='BUSINESS'),
								 pct2 := ((real)count(group,stat_type='BUSINESS') / (real)count(slim_inq(stat_type='BUSINESS'))) * 100,
								 busu     := count(group,stat_type='BUSINESS_USER'),
								 pct3 := ((real)count(group,stat_type='BUSINESS_USER') / (real)count(slim_inq(stat_type='BUSINESS_USER'))) * 100		  
									 }, bus_intel.use,
										few);
										
										
										

fn_AddStat(real8 value, string name) := 
FUNCTION
	return ut.fn_AddStatDS(dataset([{name, value}], ut.layout_stats_extend));
END;

inq_stats := parallel(

fn_AddStat(count(tot_inq),														'All 01. Total number of inquiry records'),
fn_AddStat(count(tot_inq_with_adl) + count(tot_inq_with_bdl),												'All 02. Total number of inquiry records associated with an ADL/BDL'),
fn_AddStat(count(tot_inq_with_adl_d) + count(tot_inq_with_bdl_d),												'All 02. Total number of inquiry records associated with an ADL/BDL Unique'),
fn_AddStat(count(tot_inq_allow_return),											'All 03. Total number of inquiry records that are flagged to be allowed for data return'),
fn_AddStat(count(tot_inq_allow_return_with_adl) + 
		   count(tot_inq_allow_return_with_bdl),								'All 04. Total number of inquiry records that are flagged to be allowed for data return that are associated with an ADL/BDL'),
fn_AddStat(count(new_phones_valid),												'All 05. Total number of new unique phone numbers'),
fn_AddStat(count(new_addresses),												'All 06. Total number of new unique addresses'),
fn_AddStat(count(tot_ssn_adl_uniq) + count(tot_ssn_bdl_uniq),												'All 07. Total number of new unique SSNs/EIN tied to an ADL/BDL'),
fn_AddStat(count(tot_dob_adl_uniq),												'All 08. Total number of new unique DOBs tied to an ADL/BDL'),
fn_AddStat(count(tot_phone_adl_uniq) + count(tot_phone_bdl_uniq),											'All 09. Total number of new unique phones tied to an ADL/BDL '),
fn_AddStat(count(tot_address_adl_uniq) + count(tot_address_bdl_uniq),											'All 10. Total number of new unique addresses tied to an ADL/BDL'),
fn_AddStat(count(tot_email_adl_uniq),											'All 11. Total number of new unique email addresses tied to an ADL/BDL'),
fn_AddStat(count(tot_ssn_adl_allow_return_uniq) + 
		   count(tot_ssn_bdl_allow_return_uniq),								'All 12. Total number of new unique SSNs tied to an ADL/BDL that are flagged to be allowed for data return'),
fn_AddStat(count(tot_dob_adl_allow_return_uniq),								'All 13. Total number of new unique DOBs tied to an ADL/BDL that are flagged to be allowed for data return'),
fn_AddStat(count(tot_phone_adl_allow_return_uniq) + 
		   count(tot_phone_bdl_allow_return_uniq),								'All 14. Total number of new unique phones tied to an ADL/BDL that are flagged to be allowed for data return'),
fn_AddStat(count(tot_address_adl_allow_return_uniq ) +
		   count(tot_address_bdl_allow_return_uniq),							'All 15. Total number of new unique addresses tied to an ADL/BDL that are flagged to be allowed for data return'),
fn_AddStat(count(tot_email_adl_allow_return_uniq),								'All 16. Total number of new unique email addresses tied to an ADL/BDL that are flagged to be allowed for data return'),


fn_AddStat(count(tot_inq(stat_type = 'PERSON')),								'Person 01. Total number of inquiry records'),
fn_AddStat(count(tot_inq_with_adl(stat_type = 'PERSON')),						'Person 02. Total number of inquiry records associated with an ADL'),
fn_AddStat(count(tot_inq_with_adl_d(stat_type = 'PERSON')),						'Person 02. Total number of inquiry records associated with an ADL Unique'),
fn_AddStat(count(tot_inq_allow_return(stat_type = 'PERSON')),					'Person 03. Total number of inquiry records that are flagged to be allowed for data return'),
fn_AddStat(count(tot_inq_allow_return_with_adl(stat_type = 'PERSON')),			'Person 04. Total number of inquiry records that are flagged to be allowed for data return that are associated with an ADL'),
fn_AddStat(count(new_phones_valid(stat_type = 'PERSON')),						'Person 05. Total number of new unique phone numbers'),
fn_AddStat(count(new_addresses(stat_type = 'PERSON')),							'Person 06. Total number of new unique addresses'),
fn_AddStat(count(tot_ssn_adl_uniq(stat_type = 'PERSON')),						'Person 07. Total number of new unique SSNs tied to an ADL'),
fn_AddStat(count(tot_dob_adl_uniq(stat_type = 'PERSON')),						'Person 08. Total number of new unique DOBs tied to an ADL'),
fn_AddStat(count(tot_phone_adl_uniq(stat_type = 'PERSON')),						'Person 09. Total number of new unique phones tied to an ADL '),
fn_AddStat(count(tot_address_adl_uniq(stat_type = 'PERSON')),					'Person 10. Total number of new unique addresses tied to an ADL'),
fn_AddStat(count(tot_email_adl_uniq(stat_type = 'PERSON')),						'Person 11. Total number of new unique email addresses tied to an ADL'),
fn_AddStat(count(tot_ssn_adl_allow_return_uniq(stat_type = 'PERSON')),			'Person 12. Total number of new unique SSNs tied to an ADL that are flagged to be allowed for data return'),
fn_AddStat(count(tot_dob_adl_allow_return_uniq(stat_type = 'PERSON')),			'Person 13. Total number of new unique DOBs tied to an ADL that are flagged to be allowed for data return'),
fn_AddStat(count(tot_phone_adl_allow_return_uniq(stat_type = 'PERSON')),		'Person 14. Total number of new unique phones tied to an ADL that are flagged to be allowed for data return'),
fn_AddStat(count(tot_address_adl_allow_return_uniq(stat_type = 'PERSON') ),		'Person 15. Total number of new unique addresses tied to an ADL that are flagged to be allowed for data return'),
fn_AddStat(count(tot_email_adl_allow_return_uniq(stat_type = 'PERSON')),		'Person 16. Total number of new unique email addresses tied to an ADL that are flagged to be allowed for data return'),


fn_AddStat(count(tot_inq(stat_type = 'BUSINESS')),								'Bus 01. Total number of inquiry records'),
fn_AddStat(count(tot_inq_with_bdl),												'Bus 02. Total number of inquiry records associated with an BDL'),
fn_AddStat(count(tot_inq_with_bdl_d),												'Bus 02. Total number of inquiry records associated with an BDL Unique'),
fn_AddStat(count(tot_inq_allow_return(stat_type = 'BUSINESS')),					'Bus 03. Total number of inquiry records that are flagged to be allowed for data return'),
fn_AddStat(count(tot_inq_allow_return_with_bdl),		'Bus 04. Total number of inquiry records that are flagged to be allowed for data return that are associated with an BDL'),
fn_AddStat(count(new_phones_valid(stat_type = 'BUSINESS')),						'Bus 05. Total number of new unique phone numbers'),
fn_AddStat(count(new_addresses(stat_type = 'BUSINESS')),						'Bus 06. Total number of new unique addresses'),
fn_AddStat(count(tot_ssn_bdl_uniq),						'Bus 07. Total number of new unique EINs tied to an BDL'),
fn_AddStat(count(tot_phone_bdl_uniq),					'Bus 09. Total number of new unique phones tied to an BDL '),
fn_AddStat(count(tot_address_bdl_uniq),					'Bus 10. Total number of new unique addresses tied to an BDL'),
fn_AddStat(count(tot_ssn_bdl_allow_return_uniq),		'Bus 12. Total number of new unique EINs tied to an BDL that are flagged to be allowed for data return'),
fn_AddStat(count(tot_phone_bdl_allow_return_uniq),		'Bus 14. Total number of new unique phones tied to an BDL that are flagged to be allowed for data return'),
fn_AddStat(count(tot_address_bdl_allow_return_uniq),	'Bus 15. Total number of new unique addresses tied to an BDL that are flagged to be allowed for data return'),

fn_AddStat(count(tot_inq(stat_type = 'BUSINESS_USER')),							'Bus_User 01. Total number of inquiry records'),
fn_AddStat(count(tot_inq_with_adl(stat_type = 'BUSINESS_USER')),				'Bus_User 02. Total number of inquiry records associated with an ADL'),
fn_AddStat(count(tot_inq_with_adl_d(stat_type = 'BUSINESS_USER')),				'Bus_User 02. Total number of inquiry records associated with an ADL Unique'),
fn_AddStat(count(tot_inq_allow_return(stat_type = 'BUSINESS_USER')),			'Bus_User 03. Total number of inquiry records that are flagged to be allowed for data return'),
fn_AddStat(count(tot_inq_allow_return_with_adl(stat_type = 'BUSINESS_USER')),	'Bus_User 04. Total number of inquiry records that are flagged to be allowed for data return that are associated with an ADL'),
fn_AddStat(count(new_phones_valid(stat_type = 'BUSINESS_USER')),				'Bus_User 05. Total number of new unique phone numbers'),
fn_AddStat(count(new_addresses(stat_type = 'BUSINESS_USER')),					'Bus_User 06. Total number of new unique addresses'),
fn_AddStat(count(tot_ssn_adl_uniq(stat_type = 'BUSINESS_USER')),				'Bus_User 07. Total number of new unique SSNs tied to an ADL'),
fn_AddStat(count(tot_dob_adl_uniq(stat_type = 'BUSINESS_USER')),				'Bus_User 08. Total number of new unique DOBs tied to an ADL'),
fn_AddStat(count(tot_phone_adl_uniq(stat_type = 'BUSINESS_USER')),				'Bus_User 09. Total number of new unique phones tied to an ADL '),
fn_AddStat(count(tot_address_adl_uniq(stat_type = 'BUSINESS_USER')),			'Bus_User 10. Total number of new unique addresses tied to an ADL'),
fn_AddStat(count(tot_email_adl_uniq(stat_type = 'BUSINESS_USER')),				'Bus_User 11. Total number of new unique email addresses tied to an ADL'),
fn_AddStat(count(tot_ssn_adl_allow_return_uniq(stat_type = 'BUSINESS_USER')),	'Bus_User 12. Total number of new unique SSNs tied to an ADL that are flagged to be allowed for data return'),
fn_AddStat(count(tot_dob_adl_allow_return_uniq(stat_type = 'BUSINESS_USER')),	'Bus_User 13. Total number of new unique DOBs tied to an ADL that are flagged to be allowed for data return'),
fn_AddStat(count(tot_phone_adl_allow_return_uniq(stat_type = 'BUSINESS_USER')),	'Bus_User 14. Total number of new unique phones tied to an ADL that are flagged to be allowed for data return'),
fn_AddStat(count(tot_address_adl_allow_return_uniq(stat_type ='BUSINESS_USER')),'Bus_User 15. Total number of new unique addresses tied to an ADL that are flagged to be allowed for data return'),
fn_AddStat(count(tot_email_adl_allow_return_uniq(stat_type = 'BUSINESS_USER')),	'Bus_User 16. Total number of new unique email addresses tied to an ADL that are flagged to be allowed for data return')

);


return parallel(output('Running ' + regexreplace('[^a-z]', stringlib.stringtolowercase(stat_type), '')),
								 inq_stats, 
								 sequential(output(sort(tbl_vertical, vertical), all, named('TotalNumberOfInquiriesForEachVertical')),
								 output(sort(tbl_industry, industry), all, named('TotalNumberOfInquiriesForEachIndustry')),
								 output(sort(tbl_funtion, b_function), all, named('TotalNumberOfInquiriesForEachFuntion')),
								 output(sort(tbl_platform, source), all, named('TotalNumberOfInquiriesForEachPlatform'))),
								 output(sort(tbl_use, use), all, named('TotalNumberOfInquiriesForEachUse')))
								 ;

end;
