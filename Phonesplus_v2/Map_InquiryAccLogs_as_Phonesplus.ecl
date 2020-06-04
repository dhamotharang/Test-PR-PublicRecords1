/*2011-05-03T12:42:30Z (Cecelie_p Guyton)

*/
//****************Maps infutor CID to a common layout********************
import Gong, ut, _validate, InfutorCID, Mdr, Inquiry_Acclogs;

/* Source 'IQ' is not being used in MDR.sourceTools and would make a good canidate if necessary */

// dBaseHistory := Inquiry_Acclogs.File_Inquiry_Base.History(
dBaseHistory := Inquiry_Acclogs.File_Inquiry_Base.historyAll(
									~inquiry_acclogs.fntranslations.is_Opt_Out(allow_flags.allowflags) and
									 trim(person_q.lname,all) <> '' and
									 trim(person_q.Personal_Phone + person_q.work_phone, all) <> '' and
									 person_q.appended_adl > 0);

// dBaseHistory := distribute(base_history, random()); - distributed when called
							 
phone_file := normalize(dBaseHistory, 2, /* 1 & 2 - Person_Q*/
												
transform(Layout_In_Phonesplus.Layout_In_Common,

	phone7key(string phone, unsigned did) := hashmd5((data)phone [length(phone) - 6 ..length(phone)] + (data)did);

																																		 
	self.DateFirstSeen 						:= (unsigned3) _validate.date.fCorrectedDateString((string)left.Search_Info.datetime[1..8]) [1..6];
	self.DateLastSeen 						:= (unsigned3) _validate.date.fCorrectedDateString((string)left.Search_Info.datetime[1..8]) [1..6];
	self.DateVendorLastReported 	:= (unsigned3) _validate.date.fCorrectedDateString((string)left.Search_Info.datetime[1..8]) [1..6];
	self.DateVendorFirstReported 	:= (unsigned3) _validate.date.fCorrectedDateString((string)left.Search_Info.datetime[1..8]) [1..6];
	self.orig_dt_last_seen				:= (unsigned3)left.Search_Info.datetime[1..6];
	
	// G=GLB, D=DPPA, B=Both, ''=Neither, 'U'=Utility
	self.glb_dppa_flag						:= 'G';

   self.src_all									:= translation_codes.source_bitmap_code(mdr.sourceTools.src_InquiryAcclogs);
	 self.append_avg_source_conf 	:= phonesplus_v2.Translation_Codes.source_conf(mdr.sourceTools.src_InquiryAcclogs);
	 self.append_max_source_conf 	:= self.append_avg_source_conf;
	 self.append_min_source_conf 	:= self.append_avg_source_conf;
	 self.append_total_source_conf := self.append_avg_source_conf;	
	
	self.OrigName									:= StringLib.stringcleanspaces(left.person_q.first_name + ' ' + left.person_q.middle_name + ' ' + left.person_q.last_name);
																		

	self.Address1									:= left.person_q.address;
	self.Address2 := '';
	
	self.OrigCity									:= left.person_q.city;
																			
	self.OrigState								:= left.person_q.state;
																		
	self.OrigZip									:= StringLib.stringcleanspaces(
																			left.person_q.zip5 +
																			left.person_q.zip4);
																			
	pre_orig_phone								:= choose(counter, left.person_q.Personal_Phone, left.person_q.work_phone);
  self.orig_phone								:= Fn_Clean_Phone10(pre_orig_phone);
	self.npa											:= self.orig_phone[..3];
	self.phone7										:= self.orig_phone[4..];

/* //************Cleaned Address fields */
	self.prim_range				    		:=left.person_q.prim_range;
	self.predir 									:=left.person_q.predir;
	self.prim_name 								:=left.person_q.prim_name;
	self.addr_suffix 							:=left.person_q.addr_suffix;
	self.postdir 									:=left.person_q.postdir;
	self.sec_range 								:=left.person_q.sec_range;
	self.p_city_name 							:=left.person_q.v_city_name;
	self.state 										:=left.person_q.st;
	self.zip5 										:=left.person_q.zip5;
	self.zip4 										:=left.person_q.zip4;
/* //************Fields appended by address cleaner. */
	self.v_city_name  						:=left.person_q.v_city_name;
	self.unit_desig	  						:=left.person_q.unit_desig;
	// self.cart 						:=if(appended_addr, '', input.cart);
	// self.cr_sort_sz 				:=if(appended_addr, '', input.cr_sort_sz);
	// self.lot 						:=if(appended_addr, '', input.lot);
	// self.lot_order 					:=if(appended_addr, '', input.lot_order);
	// self.dpbc 						:=if(appended_addr, '', input.dbpc);
	// self.chk_digit 					:=if(appended_addr, '', input.chk_digit);
	self.rec_type 								:=left.person_q.addr_rec_type; 
	self.ace_fips_st 							:=left.person_q.fips_state; 
	self.ace_fips_county 					:=left.person_q.fips_county;
	self.geo_lat 									:=left.person_q.geo_lat;
	self.geo_long 								:=left.person_q.geo_long;
	// self.msa 						:=if(appended_addr, '', input.msa); 
	self.geo_blk 									:=left.person_q.geo_blk;
	self.geo_match 								:=left.person_q.geo_match;
	self.err_stat 								:=left.person_q.err_stat;
	// self.name_score					:=  '';
	self.did 											:= left.person_q.Appended_ADL;

	self.title									:=left.person_q.title;
	self.fname									:=left.person_q.fname;
	self.mname									:=left.person_q.mname;
	self.lname									:=left.person_q.lname;
	self.name_suffix						:=left.person_q.name_suffix;

	self.phone7_did_key         := phone7key(self.orig_phone, self.did);

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
																	
	self.company 								:= '';
  self.source			:= mdr.sourceTools.src_InquiryAcclogs; //DF-25784
	self.cellphone 	:= self.npa + self.phone7; //DF-25784		
	self := left), local);
	
distPhoneFile := distribute(phone_file(trim(origname + lname, all) <> '' and (unsigned)orig_phone > 0 and did > 0), hash(origname, fname, lname, orig_phone, company));

dPhoneFile := dedup(sort(distPhoneFile, record, local), record, local);

CreateDates := rollup(dPhoneFile, transform(Layout_In_Phonesplus.Layout_In_Common,
																			self.DateFirstSeen := if(left.DateFirstSeen < right.DateFirstSeen and left.DateFirstSeen > 0, left.DateFirstSeen, right.DateFirstSeen);
																			self.DateLastSeen  := if(left.DateLastSeen > right.DateLastSeen, left.DateLastSeen, right.DateLastSeen);
																			self.DateVendorFirstReported := self.DateFirstSeen;
																			self.DateVendorLastReported  := self.DateLastSeen;
																			self := right), 
																	record, except DateFirstSeen, DateLastSeen, DateVendorFirstReported, DateVendorLastReported, local);
																			
export Map_InquiryAccLogs_as_Phonesplus	:=  CreateDates
									  : persist('~thor_data400::persist::Phonesplus::Map_InquiryAccLogs_as_Phonesplus');		
										
// export Map_InquiryAccLogs_as_Phonesplus	:= 'todo';