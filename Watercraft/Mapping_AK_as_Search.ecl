
import watercraft;


Layout_Watercraft_Search_Group_temp := record


Watercraft.Layout_AK_clean_in;

string73 clean_pname1;
string73 clean_cname1;


end;

Layout_Watercraft_Search_Group_temp search_mapping_format_temp(Watercraft.Layout_AK_clean_in L, integer1 C)
 :=transform
 
self.clean_pname1 := choose(C,L.pname1, L.pname2, L.pname3, L.pname4, L.pname5);
self.clean_cname1 := choose(C,L.cname1, L.cname2, L.cname3, L.cname4, L.cname5);
self              := L;

end;

Mapping_AK_as_Search_temp := normalize(Watercraft.file_AK_clean_in,5,search_mapping_format_temp(left,counter))(clean_pname1<> '' or clean_cname1<> '');


watercraft.Macro_Is_hull_id_in_MIC(Mapping_AK_as_Search_temp, Layout_Watercraft_Search_Group_temp, wDatasetwithflag)


Watercraft.Layout_Watercraft_Search_Group search_mapping_format(wDatasetwithflag L, integer1 C)
 :=
  transform
	self.date_first_seen			:=	if(L.DMVStatusDate1 > L.REG_DATE, L.DMVStatusDate1, L.REG_DATE);
	self.date_last_seen				:=	if(L.DMVStatusDate1 > L.REG_DATE, L.REG_DATE, L.DMVStatusDate1);
	self.date_vendor_first_reported	:=	L.process_date;
	self.date_vendor_last_reported	:=	L.process_date;
	self.watercraft_key				:=	if(trim(L.year, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12 and L.is_hull_id_in_MIC, trim(L.HULL_ID,left, right),
	                                    (trim(L.HULL_ID, left, right) + trim(L.MAKE, left, right) + trim(L.YEAR, left, right) + L.last_NAME + L.first_name + L.mid)[1..30]);                                          
	self.sequence_key				:=	if(L.DMVStatusDate1 > L.REG_DATE, L.DMVStatusDate1, L.REG_DATE);
	self.state_origin				:=	'AK';
	self.source_code				:=	'AW';
	self.dppa_flag					:=	'';
	self.orig_name					:=	choose(C,L.Company1, L.OwnerNameCompany2, L.OwnerNameCompany3, L.OwnerNameCompany4, L.OwnerNameCompany5);
	self.orig_name_type_code		:=	'O';
	self.orig_name_type_description	:=	'OWNER';
	self.orig_name_first			:=	choose(C,L.FIRST_NAME, L.OwnerNameFirst2, L.OwnerNameFirst3, L.OwnerNameFirst4, L.OwnerNameFirst5);
	self.orig_name_middle			:=	choose(C,L.MID, L.OwnerNameMiddle2, L.OwnerNameMiddle3, L.OwnerNameMiddle4, L.OwnerNameMiddle5);
	self.orig_name_last				:=	choose(C,L.LAST_NAME, L.OwnerNameLast2, L.OwnerNameLast3, L.OwnerNameLast4, L.OwnerNameLast5);
	self.orig_name_suffix			:=	choose(C,L.Suffix1, L.OwnerNameSuffix2, L.OwnerNameSuffix3, L.OwnerNameSuffix4, L.OwnerNameSuffix5);
	self.orig_address_1				:=	if(L.clean_resaddress[179] <> 'S'or regexfind('PO BOX', L.clean_resaddress), L.Address_1, L.AddressRes1);
	self.orig_address_2				:=	if(L.clean_resaddress[179] <> 'S'or regexfind('PO BOX', L.clean_resaddress), L.Address2,L.AddressRes2);
	self.orig_city					:=	if(L.clean_resaddress[179] <> 'S'or regexfind('PO BOX', L.clean_resaddress),  L.City, L.CityRes);
	self.orig_state					:=	if(L.clean_resaddress[179] <> 'S'or regexfind('PO BOX', L.clean_resaddress),  L.STATE, L.StateRes);
	self.orig_zip					:=	if(L.clean_resaddress[179] <> 'S'or regexfind('PO BOX', L.clean_resaddress), L.ZIP, if(L.ZipRes <> '' and L.Zip4res <> '', L.ZipRes +'-'+ L.Zip4Res, 
	                                    if(L.ZipRes = '', L.Zip4res, L.Zipres)));
	self.orig_fips					:=	L.FIPS;
	self.dob						:=	'';
	self.orig_ssn					:=	'';
	self.orig_fein					:=	'';
	self.gender						:=	'';
	self.phone_1					:=	'';
	self.phone_2					:=	'';
	self.clean_pname                :=  choose(C,L.clean_pname1,L.owner2_pname,L.owner3_pname, L.owner4_pname, L.owner5_pname);
	self.company_name				:=	choose(C,L.clean_cname1,L.company1_cname, L.company2_cname, L.company3_cname, L.company4_cname,L.company5_cname);
	self.clean_address              :=  if(L.clean_resaddress[179] <> 'S' or regexfind('PO BOX', L.clean_resaddress), L.clean_address, L.clean_resaddress);            
	self.bdid						:=	'';
	self.fein						:=	'';
	self.did						:=	'';
	self.did_score					:=	'';                              
	self.ssn						:=	'';
	self.history_flag				:=	'';
  end
 ; 
 
export Mapping_AK_as_Search	:= (normalize(wDatasetwithflag,5,search_mapping_format(left,counter)))
                                (clean_pname <> '' and trim(clean_pname, left, right) <> '0' or company_name <> '');


