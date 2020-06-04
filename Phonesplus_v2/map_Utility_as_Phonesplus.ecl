import Gong, ut, _validate, Mdr,phonesplus_v2,UtilFile, header, std;
phone_file := UtilFile.file_util.full_did_for_index((phone<>'' or work_phone<>'') and ~header.IsOldUtil((STRING8)Std.Date.Today(), false, record_date));

unsigned3 add4(unsigned3 dt) := if ((dt+4) % 100 > 12, dt + 104 - 12, dt+4);

unsigned3 todaydate := (unsigned3)((integer)(STRING8)Std.Date.Today() div 100);

// will be used to adjust date last seens -- if d_first_seen+4 < today, use dfs+4, else today
// not defining a condition to handle an incoming value of 0 would return a value of 4
unsigned3 lesser(unsigned3 dt2) := if(dt2=0,
                                    0,
                                   if (add4(dt2) < todaydate, 
								    add4(dt2),
								   todaydate));
layout_src := RECORD
UtilFile.Layout_DID_Out;
string2 src;
end;
								   
layout_src asSrc(phone_file l, boolean iswork) := transform
 self.src := map( iswork and l.util_type= 'Z' => mdr.sourceTools.src_ZUtil_Work_Phone
								,~iswork and l.util_type= 'Z' => mdr.sourceTools.src_ZUtilities
								,~iswork and l.util_type<>'Z' => mdr.sourceTools.src_Utilities
								,mdr.sourceTools.src_Util_Work_Phone);
 self := l;
end;

p_UT := project(phone_file,asSrc(left, false));
p_UW := project(phone_file((integer)work_phone > 1000000),asSrc(LEFT, true));

//Select records with valid phone numbers
//Seperated for work phones
phonesplus_v2.Mac_Filter_Bad_Phones(p_UT,phone,,,p_UT_filt);
phonesplus_v2.Mac_Filter_Bad_Phones(p_UW,work_phone,,,p_UW_filt);

util_dups := p_UT_filt + p_UW_filt;			 
			 
util_dis := distribute(util_dups,hash(id));
util_noID := dedup(util_dis, all,local);

//map to a common layout
phonesplus_v2.Layout_In_Phonesplus.Layout_In_Common t_map_common_layout(util_noID input) := Transform

	boolean future_dt 				:= input.date_first_seen>(STRING8)Std.Date.Today();

	self.DateFirstSeen := if(future_dt,0,(integer)input.date_first_seen div 100);
    self.DateLastSeen := lesser((integer)self.DateFirstSeen);
    self.DateVendorLastReported := if((integer)input.record_Date[5..6] > 12, (integer)(input.record_date[..4] + input.record_date[7..]),(integer)input.record_date[..6]);
    self.DateVendorFirstReported := if((integer)input.record_Date[5..6] > 12, (integer)(input.record_date[..4] + input.record_date[7..]),(integer)input.record_date[..6]);
	self.orig_dt_last_seen			:= self.DateLastSeen;

	// G=GLB, D=DPPA, B=Both, ''=Neither, ('U' = Utility changed to 'G' with 118021)
	self.glb_dppa_flag		 		:= 'G';

	self.src_all						:= phonesplus_v2.translation_codes.source_bitmap_code(input.src);
	self.append_avg_source_conf 	:= phonesplus_v2.Translation_Codes.source_conf(input.src);
	self.append_max_source_conf 	:= self.append_avg_source_conf;
	self.append_min_source_conf 	:= self.append_avg_source_conf;
	self.append_total_source_conf   := self.append_avg_source_conf;
	
	self.OrigName					:= StringLib.StringCleanSpaces(input.fname + ' ' + input.mname + ' ' + input.lname + ' ' + input.name_suffix);
	self.Address1				:= StringLib.StringCleanSpaces(input.address_street + ' ' + input.address_street_direction + ' ' + input.address_street_name + ' ' + input.address_street_type);
	self.Address2				:= StringLib.StringCleanSpaces(input.address_apartment);
	self.OrigCity					:= input.address_city;
	self.OrigState					:= input.address_state;
	self.OrigZip					:= input.address_zip;
	self.orig_phone					:= if(input.src=mdr.sourceTools.src_Util_Work_Phone,phonesplus_v2.Fn_Clean_Phone10(input.work_phone),phonesplus_v2.Fn_Clean_Phone10(input.phone));
	self.phone7_did_key         	:= hashmd5((data)self.orig_phone[length(self.orig_phone)-6.. length(self.orig_phone)]+(data)(unsigned)input.did);
	self.npa						:= self.orig_phone[..3];
	self.phone7						:= self.orig_phone[4..];
	self.state						:= input.st;
	self.zip5						:= input.zip;
	self.p_city_name				:= input.p_city_name;
	self.v_city_name				:= input.v_city_name;
	self.addr_suffix				:= input.address_street_Type;
	self.ace_fips_county			:= input.county;
	self.did						:= (unsigned)input.did;
	self.source					:= input.src; //DF-25784
	self.cellphone 		:= self.npa + self.phone7; //DF-25784	
	self 							:= input; 
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

export map_Utility_as_Phonesplus := project(util_noID,t_map_common_layout(left)) 
									  :persist('~thor_data400::persist::Phonesplus::map_Utility_as_Phonesplus');