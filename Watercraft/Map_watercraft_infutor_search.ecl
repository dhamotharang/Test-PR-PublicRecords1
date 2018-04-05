import lib_stringlib, watercraft, watercraft_infutor, ut, AID, header_slimsort, did_Add, VersionControl, Data_Services;

#OPTION('multiplePersistInstances',FALSE);

delivery_point_desc(string1 code)
 := case(code,
					'D' => 'DPV CONFIRMED FOR PRIMARY NUMBER ONLY, SECONDARY MISSING',
					'N' => 'BOTH PRIMARY AND SECONDARY NUMBER FAILED DPV CONFIRM',
					'S' => 'DPV CONFIRMED FOR PRIMARY NUMBER ONLY, SECONDARY PRESENT BUT UNCONFIRMED',
					'Y' => 'DPV CONFIRMED FOR BOTH PRIMARY AND SECONDARY NUMBER, IF PRESENT',
					'Z' => 'RECORDS FOR VERIFICATION PURPOSE ONLY, NOT FOR MARKETING',
					''  );
					
vacancy_desc(string1 code)
 := case(code,
					'N' => 'SOMEONE LIVING AT ADDRESS',
					'Y' => 'PHYSICAL ADDRESS IDENTIFIED AS VACANT BY USPS',
					'' );
					
dnc_desc(string1 code)
 := case(code,
					'N' => 'TELEPHONE NUMBER PRESENT ON FTC DO NOT CALL LIST',
					'S' => 'TELEPHONE NUMBER PRESENT ON STATE DO NOT CALL LIST',
					'W' => 'WIRELESS',
					'Z' => 'DMAS TELEPHONE PREFERENCE SERVICE',
					''  );
					
ehi_desc(string1 code)
 := case(code,
					'A' => 'LESS THAN $20,000',
					'B' => '$20,000 - $29,999',
					'C' => '$30,000 - $39,999',
					'D' => '$40,000 - $49,999',
					'E' => '$50,000 - $74,999',
					'F' => '$75,000 - $99,999',
					'G' => '$100,000 - $124,999',
					'H' => '$125,000 OR MORE',
					'' );
					
mhv_desc(string1 code)
 := case(code,
					'A' => 'LESS THAN $50,000',
					'B' => '$50,000 - $99,999',
					'C' => '$100,000 - $149,999',
					'D' => '$150,000 - $249,999',
					'E' => '$250,000 - $349,999',
					'F' => '$350,000 - $999,999',
					'G' => '$500,000 - $749,999',
					'H' => '$750,000 - $999,999',
					'I' => '$1,000,000 OR MORE',
					''  );

//Filter out blank name records since there are no registration/hull information to identify watercraft info
ds_watercraft_in := dataset('~thor_data400::base::infutor_watercraft_raw',Watercraft_infutor.layouts.layout_CleanFields,flat);

search_group_add_on := record
	Watercraft.Layout_Watercraft_Search_Group;
	Watercraft_infutor.layouts.Layout_search_add_ons;
end;

search_group_add_on search_mapping_format(ds_watercraft_in L)
 :=
  transform
	self.date_first_seen			:=	''; //Cannot be determined if dates in record were firstlast seen as they are vendor
	self.date_last_seen				:=	''; //processing dates which does not meet our definition of these date fields.
	// self.date_vendor_first_reported	:=	(string)VersionControl.fGetFilenameVersion('~thor_data400::in::watercraft::infutor');
	// self.date_vendor_last_reported	:=	(string)VersionControl.fGetFilenameVersion('~thor_data400::in::watercraft::infutor');
	self.date_vendor_first_reported	:= L.filedate;
	self.date_vendor_last_reported	:= L.filedate;
	tempName								:= REGEXREPLACE('[^a-zA-Z0-9]',trim(L.fname,all)+trim(L.mname,all)+trim(L.lname,left,right)+trim(L.suffix,all),'');
	self.watercraft_key			:= IF(trim(L.pid,all)='',REGEXREPLACE('[^a-zA-Z0-9]',tempName+trim(L.make,left,right)+trim(L.model,left,right)+
																trim(L.year,left,right)+trim(L.boat_length,left,right)[1..30],''),
																REGEXREPLACE('[^a-zA-Z0-9]',trim(L.pid,all)+trim(L.make,left,right)+trim(L.model,left,right)+
																						trim(L.year,left,right)+trim(L.boat_length,left,right)[1..30],''));                      
	self.sequence_key				:=	(string) IF(tempName <> '',hash(tempName),hash(REGEXREPLACE('[^a-zA-Z0-9]',trim(L.ADDRESS1,left,right)+trim(L.ADDRESS2,left,right)+
																	trim(L.make,left,right)+trim(L.model,left,right)+trim(L.year,left,right)+trim(L.boat_length,left,right),'')));

	self.state_origin				:=	'US';
	self.source_code				:=	'W1';
	self.dppa_flag					:=	'';
	self.orig_name					:=	StringLib.StringCleanSpaces(trim(L.fname,left,right)+' '+trim(L.mname,all)+' '+trim(L.lname,left,right)+' '+trim(L.suffix,all));
	self.orig_name_type_code	:=	'O';
	self.orig_name_type_description	:=  'OWNER';
	self.orig_name_first			:=	L.fname;
	self.orig_name_middle			:=	L.mname;
	self.orig_name_last				:=	L.lname;
	self.orig_name_suffix			:=	L.suffix;
	self.orig_address_1				:=	L.ADDRESS1;
	self.orig_address_2				:=	'';
	self.orig_city						:=	L.city;
	self.orig_state						:=	L.state;
	self.orig_zip							:=	IF(trim(L.zip4)<>'',L.zip+'-'+L.zip4,L.zip);
	self.orig_fips						:=	'';
	self.dob									:=	'';
	self.orig_ssn							:=	'';
	self.orig_fein						:=	'';
	self.gender								:=	'';
	self.phone_1							:=	L.phone;
	self.phone_2							:=	'';
	self.clean_pname          :=  L.pname1;
	self.company_name					:=	L.cname1;
	self.clean_address        :=  L.Clean_Address;            
	self.bdid									:=	'';
	self.fein									:=	'';
	self.did									:=	'';
	self.did_score						:=	'';                              
	self.ssn									:=	'';
	self.history_flag					:=	'';
	self.delivery_point_valid	:= L.dpv;
	self.delivery_point_desc	:= delivery_point_desc(L.dpv);
	self.vacant								:= L.vacant;
	self.vacant_desc					:= vacancy_desc(L.vacant);
	self.do_not_call					:= L.dnc;
	self.do_not_call_desc			:= dnc_desc(L.dnc);
	self.fips_county					:= L.fips_county;
	self.msa									:= L.msa;
	self.cbsa									:= L.cbsa;
	self.internal1						:= L.internal1;
	self.internal2						:= L.internal2;
	self.internal3						:= L.internal3;
	self.est_house_income			:= L.est_house_income;
	self.est_house_income_desc := ehi_desc(L.est_house_income);
	self.child								:= L.child;
	self.homeowner						:= L.homeowner;
	self.pct_range_white			:= L.pctw;
	self.pct_range_black			:= L.pctb;
	self.pct_range_asian			:= L.pcta;
	self.pct_range_hispanic		:= L.pcth;
	self.pct_range_speak_english	:= L.pctspe;
	self.pct_range_speak_spanish	:= L.pctsps;
	self.pct_range_speak_asian		:= L.pctspa;			
	self.median_house_value				:= L.median_house_value;
	self.median_house_value_desc 	:= mhv_desc(L.median_house_value);
	self.pct_range_mail_order			:= L.mor;
	self.pct_range_white_collar		:= L.pctoccw;
	self.pct_range_blue_collar		:= L.pctoccb;
	self.pct_range_other_occupation	:= L.pctocco;
	self.length_of_residence	:= L.length_of_residence;
	self.pct_range_sfdu				:= L.sfdu;
	self.pct_range_mfdu				:= L.mfdu;
  end;
	
//output that includes the extra Infutor fields	
ds_map_search := project(ds_watercraft_in(fname <> '' and lname <> ''), search_mapping_format(left)) : persist('persist::Watercraft_NonDPPA_Search_Base');

//Output to watercraft search layout to be included in Watercraft.Persist_Search_Joined process
ds_map_to_watercraft_search := project(ds_map_search, transform(Watercraft.Layout_Watercraft_Search_Group, self := left));

//Remove duplicates for final output
ds_watercraft_search_dedup := dedup(ds_map_to_watercraft_search,all);

//Count of records that were filtered due to blank names
output(count(ds_watercraft_in(trim(fname,all) = '' and trim(lname,all) = '')),named('BlankNamesFiltered'));

EXPORT Map_watercraft_infutor_search := ds_watercraft_search_dedup; 