import UtilFile,ut,address,AID,header, NID;

export map_util_hist_new(dataset(UtilFile.layout_util.daily_in_new) util_daily_in)	:= module

temp_rec := record
integer id := 0;
UtilFile.layout_util.daily_in_new;
end;
 
daily_id := project(util_daily_in, transform(temp_rec, self.id := counter, self := left));

//Ut.MAC_Sequence_Records(file_daily_preID, id, daily_id)

//normalize on dual address

utilfile.Layout_Util.preclean tnormAddr(daily_id le, integer cnt) := transform

s_address := trim(le.Svc_addr_street, left,right) + trim(le.Svc_addr_street_name, left,right)
            + trim(le.Svc_addr_street_type, left,right) + trim(le.Svc_addr_street_direction, left,right)
						+ trim(le.Svc_addr_apartment, left,right) + trim(le.Svc_addr_city, left,right)
						+ trim(le.Svc_addr_state, left,right) + trim(le.Svc_addr_zip, left,right);

B_address := trim(le.bus_addr_street, left,right) + trim(le.bus_addr_street_name, left,right)
            + trim(le.bus_addr_street_type, left,right) + trim(le.bus_addr_street_direction, left,right)
						+ trim(le.bus_addr_apartment, left,right) + trim(le.bus_addr_city, left,right)
						+ trim(le.bus_addr_state, left,right) + trim(le.bus_addr_zip, left,right);
						
self.id := (string15)(ut.DaysSince1900(ut.GetDate[1..4], ut.GetDate[5..6], ut.GetDate[7..8]) + intformat(le.id, 10, 1));
self.Exchange_Serial_Number := le.CSD_Reference_Number;
self.Date_added_to_exchange := le.Date_Last_Verified;
self.Connect_date           := le.Date_First_Verified;
self.util_type              := le.addr_type;
self.Last_Name              := le.Consumer_Last_Name;
self.First_Name             := le.first_name;
self.Middle_Name            := le.middle_name;
self.addr_type      := choose(cnt, if(S_address <> '', 'S', ''), if(B_address <> '' and S_address <> B_address, 'B', ''));
self.address_street := choose(cnt, le.Svc_addr_street, le.bus_addr_street);
self.address_street_name := choose(cnt, le.Svc_addr_street_name, le.bus_addr_street_name);
self.address_street_type := choose(cnt, le.Svc_addr_street_type, le.bus_addr_street_type);
self.Address_Street_direction := choose(cnt, le.Svc_addr_street_direction, le.bus_addr_street_direction);
self.Address_Apartment := choose(cnt, le.Svc_addr_apartment, le.bus_addr_apartment);
self.Address_City := choose(cnt, le.Svc_addr_city, le.bus_addr_city); 
self.Address_State := choose(cnt, le.Svc_addr_state, le.bus_addr_state); 
self.Address_Zip := choose(cnt, le.Svc_addr_zip, le.bus_addr_zip); 
self.addr_dual      := if(S_address = '' and B_address = '', 'F',if(S_address <> '' and B_address <> '' and S_address <> B_address, 'Y' ,'N'));
self.Social_Security_Number := le.ssn;
self.Work_Phone             := le.wrk_phone;
self.Phone                  := le.svc_phone;
self.Drivers_License_State_code := le.DLN_state_code;
self.Drivers_License        := le.drivers_license;
self := le;
self := [];

end;

Norm_dual_addr := normalize(daily_id, 2, tnormAddr(left,counter));

Norm_dual_addr_dedup := dedup(Norm_dual_addr, all);

Norm_dual_addr_slim := Norm_dual_addr_dedup(addr_dual = 'F' or addr_type <> '');

//analyz business name

utilfile.Layout_Util.preclean tpreclean(Norm_dual_addr_slim le) := transform

searchpattern1 := '^MR |^MRS | MR$| MRS$| MR | MRS |^MS | MS | MS$';
searchpattern2 := '^MS MS|^MR MR|^MR MRS|^MS MRS|^MR MS|^MRS MR|^MRS MS|^MS MR|^MRS MRS';
valid_prefix := ['MR', 'MS', 'MRS'];
remove_junk_name(string name_field) := stringlib.StringFindReplace(regexreplace('SPNP|NONPUB|NONLIST|DNL|OCLS|DECEASED',name_field, ''),'(ENP)', '');
name_func(string name_field) := stringlib.StringFilter(remove_junk_name(name_field),'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz ');

remove_prefix(string name_field) :=  regexreplace(searchpattern1, name_field, '');
remove_double_prefix(string name_field) :=  regexreplace(searchpattern2, name_field, ''); 
 
clean_orig_fname := if(TRIM(le.first_name,LEFT,RIGHT)IN valid_prefix, '', 
if(regexfind(searchpattern1, TRIM(le.first_name,LEFT,RIGHT)), remove_prefix(name_func(trim(le.first_name,left,right))),name_func(trim(le.first_name,left,right))));
clean_orig_lname := if(TRIM(le.last_name,LEFT,RIGHT)IN valid_prefix, '', 
if(regexfind(searchpattern2, TRIM(le.last_name,LEFT,RIGHT)), remove_double_prefix(trim(le.last_name,left,right)),if(regexfind(searchpattern1, TRIM(le.last_name,LEFT,RIGHT)),
remove_prefix(trim(le.last_name,left,right)), le.last_name)));
clean_orig_mname := if(TRIM(le.middle_name,LEFT,RIGHT)IN valid_prefix, '', 
if(regexfind(searchpattern1, TRIM(le.middle_name,LEFT,RIGHT)), remove_prefix(trim(le.middle_name,left,right)),le.middle_name));

self.name_clean := stringlib.stringcleanspaces(trim(clean_orig_fname,left,right) + ' ' + trim(clean_orig_mname,left,right) +' ' + trim(clean_orig_lname,left,right) + 
                                     ' ' + trim(le.Name_Suffix,left,right));
self := le;
self := [];

end;

parse_raw_addr := project(Norm_dual_addr_slim,tpreclean(left));

//clean raw address

searchpattern1 :='(.*) ([0-9]{5,}$)';
searchpattern2 :='(.*) ([0-9]{5})[-]([0-9]{1,})$';
searchpattern3 :='(.*) (.*) ([A-Z]{2}$)';
searchpattern4 :='(.*) ([A-Z]+)([0-9]{5,}$)';
searchpattern5 :='(.*) ([0-9]{5})[ ]([0-9]{1,})$';
searchpattern6 :='(.*).([0-9]{5})$';
searchpattern7 :='[,] ([0-9]{5})$';

fix_leading_zero(string addr) := stringlib.stringcleanspaces(regexreplace('^[^A-Z1-9]+',addr, ''));


Addr_Street_func_temp(string addr) := stringlib.Stringfindreplace(stringlib.Stringfindreplace(Addr,'MR-', ''), '1/2', ' 1/2');

Addr_Street_func(string addr) := if(stringlib.StringFilter(Addr_Street_func_temp(Addr),'0123456789')= '' or stringlib.Stringfind(Addr_Street_func_temp(Addr),'-0-', 1) = 1,'', fix_leading_zero(Addr_Street_func_temp(Addr)));

utilfile.Layout_Util.preclean tcleanaddr(parse_raw_addr le) := transform

address_street_name_temp := fix_leading_zero(le.Address_Street_Name);
Address_Street_temp := Addr_Street_func(le.address_street);
Boolean isblank_stcityzip := le.address_city ='' and le.address_state = '' and le.address_zip = '';

Address1_temp := stringlib.stringcleanspaces(if(isblank_stcityzip and regexfind(searchpattern1, address_street_name_temp), Address_Street_temp + ' ' + regexfind(searchpattern1, address_street_name_temp, 1),
if(isblank_stcityzip and regexfind(searchpattern2, address_street_name_temp), Address_Street_temp + ' ' + regexfind(searchpattern2, address_street_name_temp, 1),
if(isblank_stcityzip and regexfind(searchpattern5, address_street_name_temp), Address_Street_temp + ' ' + regexfind(searchpattern5, address_street_name_temp, 1),
if(isblank_stcityzip and regexfind(searchpattern3, address_street_name_temp), Address_Street_temp + ' ' + regexfind(searchpattern3, address_street_name_temp,1),
if(isblank_stcityzip and regexfind(searchpattern4, address_street_name_temp), Address_Street_temp + ' ' + regexfind(searchpattern4, address_street_name_temp,1) + ' ' + regexfind(searchpattern4, address_street_name_temp,2),
if(isblank_stcityzip and regexfind(searchpattern6, address_street_name_temp), Address_Street_temp + ' ' + regexfind(searchpattern6, address_street_name_temp, 1),
if(isblank_stcityzip, '',
if(trim(le.address_street, left,right) = trim(le.address_street_name, left,right) and le.address_street_name <> '', address_street_name_temp + ' ' + le.Address_Street_Type + ' ' + le.Address_Street_direction + ' ' + le.Address_Apartment,
Address_Street_temp + ' ' + address_street_name_temp + ' ' + le.Address_Street_Type + ' ' + le.Address_Street_direction + ' ' + le.Address_Apartment)))))))));

self.address1 := if(regexfind('^C/O|^ATTN|^@', Address1_temp) and ~regexfind('[0-9]', Address1_temp), '', Address1_temp);

self.Address2 := stringlib.stringcleanspaces(if(isblank_stcityzip and regexfind(searchpattern1, address_street_name_temp), regexfind(searchpattern1, address_street_name_temp, 2)[1..5],
if(isblank_stcityzip and regexfind(searchpattern2, address_street_name_temp), regexfind(searchpattern2, address_street_name_temp, 2)[1..5],
if(isblank_stcityzip and regexfind(searchpattern5, address_street_name_temp), regexfind(searchpattern5, address_street_name_temp, 2)[1..5],
if(isblank_stcityzip and regexfind(searchpattern3, address_street_name_temp),regexfind(searchpattern3, address_street_name_temp,2) + ', ' + regexfind(searchpattern3, address_street_name_temp,3),
if(isblank_stcityzip and regexfind(searchpattern4, address_street_name_temp),regexfind(searchpattern4, address_street_name_temp,3)[1..5],
if(isblank_stcityzip and regexfind(searchpattern6, address_street_name_temp), regexfind(searchpattern6, address_street_name_temp, 2),
if(isblank_stcityzip and regexfind(searchpattern7, stringlib.stringcleanspaces(le.Address_Street_Name))  and regexfind(searchpattern7,stringlib.stringcleanspaces(le.Address_Street_Name), 1) <> '00000', regexfind(searchpattern7, stringlib.stringcleanspaces(le.Address_Street_Name) , 1),
trim(le.address_City,left,right) + if(le.address_City <> '',', ',' ') + trim(le.address_State,left,right) + ' ' + trim(le.address_Zip,left,right)[1..5]))))))));

//clean person names

self := le;

end;
preclean_addr := project(parse_raw_addr,tcleanaddr(left));

NID.Mac_CleanFullNames(preclean_addr, name_out, name_clean, includeInRepository:=true,normalizeDualNames:=true);
append_nameid := name_out : persist('~thor_data400::persist::utility_nctue_hist_name_20131216');
no_AID_addr := append_nameid(address1 = '' and address2 = '');
need_AID_addr := append_nameid(~(address1 = '' and address2 = ''));

//append AID 
unsigned4		lAIDAppendFlags	:=	AID.Common.eReturnValues.RawAID 
																| 	AID.Common.eReturnValues.ACECacheRecords;		
AID.MacAppendFromRaw_2Line(need_AID_addr, Address1, Address2, Append_RawAID, clean_addr, lAIDAppendFlags);

//clean name and reformat the records with clean address
utilfile.Layout_Util.base tformat1(clean_addr le) := transform

self.orig_lName := le.last_name;
self.orig_fName := le.first_name;
self.orig_mName := le.middle_name;
self.orig_Name_suffix := le.Name_Suffix;
self.ssn := le.Social_Security_Number;
self.date_first_seen := if(le.connect_date = '', le.date_added_to_exchange, le.connect_date);
self.record_date := ut.GetDate;
self.title 			:= le.cln_title;
self.fname 			:= le.cln_fname;
self.mname 			:= le.cln_mname;
self.lname 			:= le.cln_lname;
self.name_suffix 	:= le.cln_suffix;
self.name_flag :=  le.nametype;
//append AID and address
self.Append_RawAID	:=	le.AIDWork_RawAID;
self.prim_range    := le.AIDWork_ACECache.prim_range;
self.predir        := le.AIDWork_ACECache.predir;
self.prim_name     := le.AIDWork_ACECache.prim_name;
self.addr_suffix     := le.AIDWork_ACECache.addr_suffix;
self.postdir        := le.AIDWork_ACECache.postdir;
self.unit_desig	   :=	le.AIDWork_AceCache.unit_desig;
self.sec_range     := le.AIDWork_ACECache.sec_range;
self.p_city_name    := le.AIDWork_ACECache.p_city_name;
self.v_city_name     := le.AIDWork_ACECache.v_city_name;
self.st            := le.AIDWork_ACECache.st;
self.zip           := le.AIDWork_ACECache.zip5; 	
self.zip4          := le.AIDWork_ACECache.zip4;	
self.cart		   :=	le.AIDWork_AceCache.cart;
self.cr_sort_sz	   :=	le.AIDWork_AceCache.cr_sort_sz;
self.lot		   :=	le.AIDWork_AceCache.lot;
self.lot_order		:=	le.AIDWork_AceCache.lot_order;
self.dbpc		    :=	le.AIDWork_AceCache.dbpc;
self.chk_digit		:=	le.AIDWork_AceCache.chk_digit;
self.rec_type	    :=	le.AIDWork_AceCache.rec_type;
self.county	        :=	le.AIDWork_AceCache.county;
self.geo_lat		:=	le.AIDWork_AceCache.geo_lat;
self.geo_long		:=	le.AIDWork_AceCache.geo_long;
self.msa			:=	le.AIDWork_AceCache.msa;
self.geo_blk		:=	le.AIDWork_AceCache.geo_blk;
self.geo_match		:=	le.AIDWork_AceCache.geo_match;
self.err_stat		:=	le.AIDWork_AceCache.err_stat;
//self.csa_indicator := le.csa_uca_indicator;
self := Le;
self := [];
end;

map_addr_clean := project(clean_addr,tformat1(left));

//clean name, canadian address and reformat the records without clean address
utilfile.Layout_Util.base tformat2(no_AID_addr le) := transform

//clean raw address
self.orig_lName := le.last_name;
self.orig_fName := le.first_name;
self.orig_mName := le.middle_name;
self.orig_Name_suffix := le.Name_Suffix;
self.ssn := le.Social_Security_Number;
self.date_first_seen := if(le.connect_date = '', le.date_added_to_exchange, le.connect_date);
self.record_date := ut.GetDate;
self.title 			:= le.cln_title;
self.fname 			:= le.cln_fname;
self.mname 			:= le.cln_mname;
self.lname 			:= le.cln_lname;
self.name_flag  :=  le.nametype;
//self.csa_indicator := le.csa_uca_indicator;
self := Le;
self := [];
end;

map_invalid_addr := project(no_AID_addr,tformat2(left)) ;

//combine records with AID and invalid addr
shared map_combine := (map_addr_clean + map_invalid_addr)(UtilFile.Blocked_data()) : persist('~thor_data400::persist::utility_nctue_hist_only_clean_20131216');

export util_daily_clean:= map_combine;

//copy canadian records having canadian phone numbers in the new phone file
is_canadian_phone(string phone1, string phone2) := phone1[1..3] in utilfile.Canadian_areacode or phone2[1..3] in utilfile.Canadian_areacode;
export util_daily_canadian := map_combine((unsigned)append_rawaid = 0 and is_canadian_phone(work_phone, phone));

end;







