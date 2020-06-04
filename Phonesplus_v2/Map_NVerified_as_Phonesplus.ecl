//****************Maps Neustar verified file to a common layout ********************
//BUG 162654
import ut, _validate, VersionControl, mdr, AlloyMediaConsumer;
phone_file:= Phonesplus_v2.File_NVerification.DIDED;
layout_in :=
RECORD
  string field1;
  string field2;
  string field3;
  string name_last_first;
  string addressline1;
  string addressline2;
  string city;
  string state;
  string zip;
  string phone;
  string eid_1320_resultcode;
  string prepaid_phone_attribute;
  string business_phone_indicator;
  string phone_in_service_indicator;
  string phone_type_indicator;
  string eid_3261_resultcode;
  string eid_3261string;
  string file_dt;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  unsigned8 nid;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string5 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  unsigned8 rawaid;
  unsigned8 aceaid;
  unsigned8 did;
  unsigned8 did_score;
 END;


//phone_file:=dataset('~persist::phonesplus::nverification__p3456110449',layout_in,THOR);

		
//Select records with valid phone numbers
phonesplus_v2.Mac_Filter_Bad_Phones (phone_file,phone,,,phone_f);

//map to a common layout
Layout_In_Phonesplus.Layout_In_Common t_map_common_layout(phone_f input) := TRANSFORM
	
	self.DateFirstSeen					:= IF(TRIM(input.file_dt)<>'',
																		(unsigned3)(_validate.date.fCorrectedDateString((string)input.file_dt)[1..6])[1..6],
																		0);
	self.DateLastSeen						:= IF(TRIM(input.file_dt)<>'',
																		(unsigned3)(_validate.date.fCorrectedDateString((string)input.file_dt)[1..6])[1..6],
																		0);
	self.DateVendorFirstReported:= IF(TRIM(input.file_dt)<>'',
																		(unsigned3)(_validate.date.fCorrectedDateString((string)input.file_dt)[1..6])[1..6],
																		0);
	self.DateVendorLastReported	:= IF(TRIM(input.file_dt)<>'',
																		(unsigned3)(_validate.date.fCorrectedDateString((string)input.file_dt)[1..6])[1..6],
																		0);
	self.orig_dt_last_seen			:= self.DateLastSeen;

	//field 3 indicates the source of record - 01, 02, L9
	//  01 - src_Cellphones_traffix
	//  02 - src_Cellphones_kroll
	//	L9 - link2Tek
	temp_src										:= TRIM(input.field3,left,right);
	self.src_all								:= phonesplus_v2.translation_codes.source_bitmap_code(temp_src);
	
	//glb_dppa_flag: G=GLB, D=DPPA, B=Both, ''=Neither, 'U'=Utility
	//Map_Cellphone_as_Phonesplus did not set glb_dppa_flag. This covers src_Cellphones_traffix and src_Cellphones_kroll
	//Map_Link2Tek_as_Phonesplus set glb_dppa_flag to 'G'
	self.glb_dppa_flag		 			:= IF(temp_src='L9', 'G', '');

	//Derive append_avg_source_conf from temp_src
  self.append_avg_source_conf := phonesplus_v2.Translation_Codes.source_conf(mdr.sourceTools.src_Link2Tek);
	self.append_max_source_conf := self.append_avg_source_conf;
	self.append_min_source_conf := self.append_avg_source_conf;	
	self.append_total_source_conf := self.append_avg_source_conf;
	
	//Populate name and address fields
	self.OrigName								:= TRIM(input.name_last_first);
	self.Address1				        := TRIM(input.addressline1);
	self.Address2				        := TRIM(input.addressline2);
	self.OrigCity								:= TRIM(input.city);
	self.OrigState							:= TRIM(input.state);
	self.OrigZip								:= TRIM(input.zip);
	self.state									:= TRIM(input.st);
	self.zip5										:= TRIM(input.zip);
	self.ace_fips_st						:= input.county[1..2];
	self.ace_fips_county				:= input.county[3..5];
	
	//Populate phone fields
	self.orig_phone							:= Fn_Clean_Phone10(input.phone);	
	self.npa										:= self.orig_phone[..3];
	self.phone7									:= self.orig_phone[4..];
	self.orig_phone_type				:= CASE(input.Phone_Type_Indicator, 'W' => 'W', 'L' => 'L', 'O');

	self.did_score 							:= (string) input.did_score;
	self.source									:= temp_src; //DF-25784
	self.cellphone 							:= self.npa + self.phone7; //DF-25784		
	self 												:= input; 

	//Populate keys
	self.phone7_did_key         := hashmd5((data)input.phone [length(input.phone) - 6 ..length(input.phone)] + (data)(unsigned)input.did);
	self.CellPhoneIDKey         := hashmd5((data)self.orig_phone [length(self.orig_phone) - 6 ..length(self.orig_phone)] + 
																				 (data)self.prim_range + 
																				 (data)self.predir + 
																				 (data)self.prim_name + 
																				 (data)self.addr_suffix + 
																				 (data)self.postdir + 
																				 (data)self.unit_desig + 
																				 (data)self.sec_range + 
																				 (data)self.zip5 +
																				 (data)self.lname + 
																				 (data)self.fname);
	
end;

EXPORT Map_NVerified_as_Phonesplus := PROJECT(phone_f,t_map_common_layout(left)) 
										                  :PERSIST('~thor_data400::persist::Phonesplus::Map_NVerified_as_Phonesplus');		