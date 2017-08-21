import Crim_Common, Address, lib_stringlib;

// Set standard values used throughout all records
Vendor_id        := '31';
origin_st        := 'OR';
source_file_name := 'OR_CRIM_COURT';

// Datasets needed to map the offender data
ds_party       := sort(CRIM.File_OR_Raw_Party        ,court_type,court_location,case_number,party_side,party_id);
ds_party_id    := sort(CRIM.File_OR_Raw_Party_ID     ,court_type,court_location,case_number,party_side,party_id);
ds_address     := sort(CRIM.File_OR_Raw_Party_Address,court_type,court_location,case_number,related_party_side,related_party_id,address_id);
ds_crim_cases  := CRIM.Name_OR_Case_Courts;

// Distribute for joining case and party
ds_crim_offenders := distribute(ds_party      ,hash32(court_type,court_location,case_number));

layout_case_pty := record
   ds_crim_cases;
   CRIM.Layout_OR_Party AND NOT [Court_Type ,Court_Location ,Case_Number
                                ,case_class ,case_type
                                ,Related_Party_Side  ,Related_Party_Id ,Record_Changed_Date
								,Record_Changed_Time ,Command_Name     ,User_ID];
end;

layout_case_pty jcase_party(ds_crim_offenders L, ds_crim_cases R) := transform
   self := R;
   self := L;
end;

ds_case_party := join(ds_crim_offenders, ds_crim_cases
                   ,LEFT.court_type     = RIGHT.court_type
			    AND LEFT.court_location = RIGHT.court_location
				AND LEFT.case_number    = RIGHT.case_number
                   ,jcase_party(LEFT,RIGHT)
				   ,LOCAL);
// output('Criminal cases/parties: ' + count(ds_case_party));
// output(ds_case_party);

//Merged layout for party and party ID data
layout_pty_pty_id := record
   layout_case_pty;
   CRIM.Layout_OR_Party_ID AND NOT [Court_Type ,Court_Location ,Case_Number
                                   ,Party_Side ,Party_ID];
end;

layout_pty_pty_id jParty_Data(ds_case_party L, ds_party_id R) := transform
   self := L;
   self := R;
end;

joined_party_party_id := join(distribute(ds_case_party,hash32(court_type,court_location,case_number,Party_Side,party_id))
                             ,distribute(ds_party_id  ,hash32(court_type,court_location,case_number,Party_Side,Party_Id))
                             ,LEFT.court_type     = RIGHT.court_type
						  AND LEFT.court_location = RIGHT.court_location
						  AND LEFT.case_number    = RIGHT.case_number
						  AND LEFT.party_side     = RIGHT.party_side
						  AND LEFT.party_id       = RIGHT.party_id
                             ,jParty_Data(left,right)
							 ,local
							 ,LEFT OUTER);

// output('Criminal cases/parties/IDs: ' + count(ds_case_party));
// output(joined_party_party_id);

// Merged layout for combined party data with address data
layout_pty_address := record
   layout_pty_pty_id;
   CRIM.Layout_OR_Address AND NOT [Court_Type          ,Court_Location   ,Case_Number
                                  ,Related_Party_Side  ,Related_Party_Id ,Record_Changed_Date
								  ,Record_Changed_Time ,Command_Name     ,User_ID];
end;

layout_pty_address jParty_Address_Data(joined_party_party_id L, ds_address R) := transform
   self := L;
   self := R;
end;

joined_party_address := join(distribute(joined_party_party_id,hash32(court_type,court_location,case_number,Party_Side        ,Party_Id))
                            ,distribute(ds_address           ,hash32(court_type,court_location,case_number,Related_Party_Side,Related_Party_Id))
                            ,LEFT.court_type     = RIGHT.court_type
						 AND LEFT.court_location = RIGHT.court_location
						 AND LEFT.case_number    = RIGHT.case_number
						 AND LEFT.party_side     = RIGHT.related_party_side
						 AND LEFT.party_id       = RIGHT.related_party_id
						    ,jParty_Address_Data(left,right)
							,local
							,LEFT OUTER) : PERSIST('~thor_data400::Persist::Crim_OR_case_party_address');

// output('Criminal cases/parties/addresses: ' + count(joined_party_address));

// Filter for valid records
fOR_Crim := joined_party_address(trim(joined_party_address.court_type,left,right)     <>'0'
                             and trim(joined_party_address.court_location,left,right) <>'000'
							 and trim(joined_party_address.case_number,left,right)    <>'0000000000');
// Clean date values
string8  date_clean(string7 input_date) := if(trim(input_date,left,right) != '' and input_date != '0000000'
											 ,  if(input_date[1..1] = '1','20','19')
											  +    input_date[2..3]
											  +    input_date[4..5]
											  +    input_date[6..7]
											 ,'');
/* Clean height values by changing to inch values completely.
   They are provided as the feet concatenated with the inches, 
   e.g., 5 feet, 10 inches is displayed as "510" and we change 
   it to "070") */ 
string3 height_to_inches(string3 input_height) := if(     input_height             != '000'
                                                 AND trim(input_height,left,right) != ''
												 AND length(lib_stringlib.StringLib.StringFilter(input_height,'1234567890')) = 3
												    ,intformat((integer)input_height[1..1] * 12 + (integer)input_height[2..3],3,1)
													,'');

crim_common.Layout_Moxie_Crim_Offender2 tOR_Crim_Map(fOR_Crim Input) := transform
   
   
   self.process_date      := Crim_Common.Version_Development;
   self.offender_key      := Vendor_id 
                           + trim(Input.court_type,left,right)
						   + trim(Input.court_location,left,right)
						   + trim(Input.case_number,left,right)
						   + trim(Input.Party_Id,left,right);
   self.vendor            := Vendor_id;
   self.state_origin      := origin_st;
   self.data_type         := '2'; // Set to 2 because it is criminal court data
   self.source_file       := source_file_name;
   self.case_number       := trim(Input.case_number,left,right);
   self.case_court        := Input.case_court_name;
   self.case_name         := '';
   self.case_type         := Input.case_class + Input.case_type;
   self.case_type_desc    := Lookup_OR_Crim_Data.Case_Type_lookup(Input.case_class + Input.case_type)[1..25];
   self.case_filing_dt    := date_clean(Input.date_case_filed);
   self.pty_nm			  := Input.Name;
   self.pty_nm_fmt		  := 'L';
   self.orig_lname		  := '';
   self.orig_fname		  := '';
   self.orig_mname		  := '';
   self.orig_name_suffix  := '';
   self.pty_typ			  := if(Input.party_side = 'AKA'
                               ,'2'
							   ,'0');
   self.nitro_flag        := '';
   self.orig_ssn          := if(Input.SSN != '000000000'
                               ,Input.SSN
							   ,'');
   self.dle_num           := '';
   self.fbi_num           := trim(Input.FBI,left,right)[1..9];
   self.doc_num           := '';
   self.ins_num           := '';
   self.id_num            := trim(Input.sid,left,right);
   self.dl_num            := if(regexfind('[1-9]', trim(Input.Drivers_License_Number,left,right)), trim(Input.Drivers_License_Number,left,right), '');
   self.dl_state          := Input.Drivers_License_State;
   self.citizenship       := '';
   self.dob               := date_clean(Input.date_of_birth);
   self.dob_alias         := '';
   self.place_of_birth    := '';
   self.street_address_1  := Input.address_line_1;
   self.street_address_2  := Input.address_line_2;
   self.street_address_3  := Input.city;
   self.street_address_4  := Input.state;
   self.street_address_5  := Input.zip;
   self.race              := Input.Race;
   self.race_desc         := Lookup_OR_Crim_Data.race_description_lookup(Input.race);
   self.sex               := Input.Sex;
   self.hair_color        := Input.Hair;
   self.hair_color_desc   := Lookup_OR_Crim_Data.hair_description_lookup(Input.Hair);
   self.eye_color         := Input.Eyes;
   self.eye_color_desc    := Lookup_OR_Crim_Data.hair_description_lookup(Input.Eyes);
   self.skin_color        := '';
   self.skin_color_desc   := '';
   self.height            := if(regexfind('[1-9]', height_to_inches(Input.Height)), height_to_inches(Input.Height), '');
   self.weight            := if(regexfind('[1-9]', Input.Weight), Input.Weight, '');
   self.party_status      := '';
   self.party_status_desc := '';
   self.prim_range        := '';
   self.predir            := '';
   self.prim_name         := '';
   self.addr_suffix       := '';
   self.postdir           := '';
   self.unit_desig        := '';
   self.sec_range         := '';
   self.p_city_name       := '';
   self.v_city_name       := '';
   self.state             := '';
   self.zip5              := '';
   self.zip4              := '';
   self.cart              := '';
   self.cr_sort_sz        := '';
   self.lot               := '';
   self.lot_order         := '';
   self.dpbc              := '';
   self.rec_type          := '';
   self.ace_fips_st       := '';
   self.ace_fips_county   := '';
   self.geo_lat           := '';
   self.geo_long          := '';
   self.msa               := '';
   self.geo_blk           := '';
   self.geo_match         := '';
   self.err_stat          := '';
   self.title             := '';
   self.fname             := '';
   self.mname             := '';
   self.lname             := '';
   self.name_suffix       := '';
   self.cleaning_score    := '';
   self.chk_digit         := '';
   self.SSN               := '';
   self.did               := '';
   self.pgid              := '';
end;

pOR_Crim := project(fOR_Crim, tOR_Crim_Map(left))(~regexfind('(EXPUNG)' ,pty_nm));

// Push the data through the standard criminal court name cleaner
CRIM.Crim_clean(pOR_Crim,cleanORCrim);

ds_crimoffenderOut:= dedup(sort(distribute(cleanORCrim,hash(offender_key))
                               ,offender_key,pty_nm,pty_typ,case_filing_dt,source_file,local)
						  ,offender_key,pty_nm,pty_typ,local,left)
						  : PERSIST('~thor_dell400::persist::CrimCourt_OR_Offender');

export Map_OR_Offender := ds_crimoffenderOut;
