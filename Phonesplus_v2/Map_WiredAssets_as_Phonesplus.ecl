/*2010-09-07T21:13:27Z (aherzberg)
c:\SuperComputer\Dataland\QueryBuilder\workspace\aherzberg\dataland\Phonesplus_v2\Map_WiredAssets_as_Phonesplus\2010-09-07T21_13_27Z.ecl
*/
import Gong, ut, _validate, Mdr,phonesplus_v2,OptinCellphones, mdr;

export Map_WiredAssets_as_Phonesplus(boolean is_royalty_paid) := function
royalty_file := phonesplus_v2.File_WiredAssets_Owned(phone <> '');
phone_file := OptinCellphones.Files.File_Base(orig_phone<>'' and current_rec_flag = 1);
//Select records with valid phone numbers
phonesplus_v2.Mac_Filter_Bad_Phones (phone_file,orig_phone,,,phone_f);

//Select records for which royalties have been paid
	phone_input := if(is_royalty_paid = true, 
										 join(distribute(phone_f, hash(orig_phone)), 
											distribute(royalty_file, hash(phone)),
											left.orig_phone = right.phone,
											transform(recordof(phone_f), self := left),
											local),
											//else select records for which royalties have not been paid
											join(distribute(phone_f, hash(orig_phone)), 
											distribute(royalty_file, hash(phone)),
											left.orig_phone = right.phone,
											transform(recordof(phone_f), self := left),
											left only,
											local));

//map to a common layout
phonesplus_v2.Layout_In_Phonesplus.Layout_In_Common t_map_common_layout(phone_input input) := Transform
	self.DateFirstSeen 						:= (unsigned3)_validate.date.fCorrectedDateString((string)input.date_first_seen) [1..6];
	self.DateLastSeen 						:= (unsigned3)_validate.date.fCorrectedDateString((string)input.date_last_seen) [1..6];
	self.DateVendorLastReported 	:= (unsigned3)_validate.date.fCorrectedDateString((string)input.date_vendor_last_reported) [1..6];
	self.DateVendorFirstReported := (unsigned3)_validate.date.fCorrectedDateString((string)input.date_vendor_first_reported) [1..6];	
	self.orig_dt_last_seen				:= self.DateLastSeen;
	self.phone7_did_key         	:= hashmd5((data)input.orig_phone[length(input.orig_phone)-6..length(input.orig_phone)]+(data)(unsigned)input.did);
	
	//Select source depending on whether or not the record has fully paid royaties or not
	self.src_all											:= if(is_royalty_paid = true,
																				phonesplus_v2.translation_codes.source_bitmap_code(mdr.sourceTools.src_wired_assets_owned),
																				phonesplus_v2.translation_codes.source_bitmap_code(mdr.sourceTools.src_wired_assets_royalty));
	self.append_avg_source_conf 	:= if(is_royalty_paid = true,
																			phonesplus_v2.Translation_Codes.source_conf(mdr.sourceTools.src_wired_assets_owned),
																			phonesplus_v2.Translation_Codes.source_conf(mdr.sourceTools.src_wired_assets_royalty));
	self.append_max_source_conf 	:= self.append_avg_source_conf;
	self.append_min_source_conf 	:= self.append_avg_source_conf;
	self.append_total_source_conf := self.append_avg_source_conf;
	self.OrigName								:= StringLib.StringCleanSpaces(input.fname + ' ' + input.mname + ' ' + input.lname + ' ' + input.name_suffix);
	self.Address1						:= StringLib.StringCleanSpaces(input.prim_range + ' ' + input.predir + ' ' + input.prim_name + ' ' + input.addr_suffix + ' ' + input.postdir);
	self.Address2						:= StringLib.StringCleanSpaces(input.unit_desig + ' ' + input.sec_range);
	self.OrigCity								:= input.orig_city;
	self.OrigState								:= input.st;
	self.OrigZip									:= input.zip+input.zip4;
	self.orig_phone								:= phonesplus_v2.Fn_Clean_Phone10(input.orig_phone);
	self.npa											:= self.orig_phone[..3];
	self.phone7										:= self.orig_phone[4..];
	self.state										:= input.st;
	self.zip5											:= input.zip;
	self.p_city_name							:= input.p_city_name;
	self.v_city_name							:= input.v_city_name;
	self.ace_fips_county					:= input.county;
	self.did											:= (unsigned)input.did;
	self.did_score								:= (string)input.did_score_field;
	self.source										:= if(is_royalty_paid = true,
																				mdr.sourceTools.src_wired_assets_owned,
																				mdr.sourceTools.src_wired_assets_royalty); //DF-25784
	self.cellphone 								:= self.npa + self.phone7; //DF-25784																					
	self 													:= input; 
	self.CellPhoneIDKey         	:= hashmd5((data)self.orig_phone [length(self.orig_phone) - 6 ..length(self.orig_phone)] + 
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
as_Phonesplus := project(phone_input(orig_phone <> ''),t_map_common_layout(left)) ;	
return(as_Phonesplus);

end;