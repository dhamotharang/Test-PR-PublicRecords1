import Address, Lib_AddrClean, Ut, lib_stringlib, _Control, business_header,_Validate, UtilFile, AID;

/*****length(Address_Street_Name) < 30 as the filter in Ab initio, pull back the lost data from historical CP historical******/

//join entity with address files

f_entity := files_cp.entity_current + files_cp.entity_history;

f_entity_dist := distribute(f_entity,hash(cps_sig_ent));

f_addr := files_cp.addr_current + files_cp.addr_history;

f_addr_dist := distribute(f_addr, hash(cps_sig_ent));

fn_filter(string sec_range) := stringlib.stringcleanspaces(stringlib.StringFilter(sec_range,'0123456789'));
fix_leading_zero(string addr) := stringlib.stringcleanspaces(regexreplace('^[^A-Z1-9]+',addr, ''));

Addr_Street_func_temp(string addr) := stringlib.Stringfindreplace(stringlib.Stringfindreplace(Addr,'MR-', ''), '1/2', ' 1/2');

Addr_Street_func(string addr) := stringlib.stringcleanspaces(if(stringlib.StringFilter(Addr_Street_func_temp(Addr),'0123456789 ')= '' or stringlib.Stringfind(Addr_Street_func_temp(Addr),'-0-', 1) = 1,'', fix_leading_zero(Addr_Street_func_temp(Addr))));

layout_extended := record
		utilfile.Layout_util_cp.entity;
		utilfile.Layout_util_cp.svcaddr and not [CPS_LOAD_DTTM,CPS_VENDOR_CD,CPS_SIG_ENT];
		
	end;
		
layout_extended joinEntitySVCAddr(f_entity l, f_addr r) := transform
				self := l;
				self := r;
		end;

extended_file := join(f_entity_dist,f_addr_dist,
trim(left.cps_sig_ent,left,right) = trim(right.cps_sig_ent,left,right), joinEntitySVCAddr(left,right),local);

//get the data only existing in historical CP
util_full := utilfile.file_util.full_base;

util_full_dist := distribute(util_full, hash(orig_fname, orig_lname));
extended_file_dist := distribute(extended_file, hash(Name_First, Name_last));

extended_file_dist tjoin(extended_file_dist l, util_full_dist r) := transform

self := l;

end;

cp_only := join(extended_file_dist(Addr_House_Num <> '' or addr_street_name <> '' or Addr_State_Abbr <> ''), util_full_dist, trim(left.name_first,left, right) = trim(right.orig_fname,left, right) 
and trim(left.name_last,left, right) = trim(right.orig_lname,left, right) and trim(left.Addr_Street_Name,left,right) = trim(right.Address_Street_Name,left,right)
and fn_filter(Addr_Street_func(left.Addr_House_Num)) = fn_filter(Addr_Street_func(right.address_street)) and trim(left.Addr_State_Abbr,left,right) = trim(right.address_State,left,right),
tjoin(left, right), left only, local): persist('~thor_data400::persist::utility_cp_only');

//get length(Address_Street_Name) >= 30 from CP utility 

cp_only_filter := cp_only(length(trim(addr_street_name,left,right)) >= 30);

//append id 

cp_id_rec := record

cp_only;
integer temp_id := 0;
end;
cp_append_id := table(cp_only_filter, cp_id_rec);

Ut.MAC_Sequence_Records(cp_append_id, temp_id, cp_id)

searchpattern_dt :='(.*)/(.*)/(.*) (.*)';

utilfile.Layout_Utility_In tformat(cp_id l) := transform

self.id := (string15)(ut.DaysSince1900((string4)regexfind(trim(searchpattern_dt,left,right),l.cps_load_dttm, 3), (string2)regexfind(trim(searchpattern_dt,left,right), l.cps_load_dttm, 2),

(string2)regexfind(trim(searchpattern_dt,left,right), l.cps_load_dttm, 1)) + intformat(l.temp_id, 10, 1));

self.exchange_serial_number := l.vend_ref_num; 

self.date_first_seen := l.cln_vend_add_dte;
self.record_date    := 
(string4)regexfind(trim(searchpattern_dt,left,right),l.cps_load_dttm, 3) + 
(string2)regexfind(trim(searchpattern_dt,left,right), l.cps_load_dttm, 2) + 
(string2)regexfind(trim(searchpattern_dt,left,right), l.cps_load_dttm, 1);
self.util_type := trim(l.svc_type_cd,left,right)[1];
self.orig_lname := l.name_last;
self.orig_fname := l.name_first;
self.orig_mname := l.name_mid;
self.orig_name_suffix := l.name_suffix;
self.address_street := l.Addr_House_Num;
self.address_street_name := l.Addr_Street_Name;
self.address_street_Type := l.Addr_Suffix;
self.address_street_direction := l.Addr_Pre_Dir;
self.address_apartment := l.Addr_Apt_Num;
self.address_city := l.Addr_City;
self.address_state := l.Addr_State_Abbr;
self.address_zip := l.Addr_Postal_Code;
self.phone := trim(l.cln_area_code,left,right) + trim(l.cln_phone,left,right);
self.drivers_license_state_code := l.cps_dl_state_abbr;
self.drivers_license := l.cln_dl_num;
self := l;
self := [];
end;

util_cp := project(cp_id, tformat(left));

util_cp_dedup := dedup(distribute(util_cp, hash(orig_fname, orig_lname)), record, except id, all, local);

rec_temp := record
utilfile.layout_utility_in;
string73 name_clean;
 string1 name_flag;
 string address1;
 string address2;
AID.Common.xAID							Append_RawAID;        
   
end;

remove_junk_name(string name_field) := stringlib.StringFindReplace(regexreplace('SPNP|NONPUB|NONLIST|DNL|OCLS|DECEASED',name_field, ''),'(ENP)', '');
name_func(string name_field) := stringlib.StringFilter(remove_junk_name(name_field),'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz ');

rec_temp tpreCleanname(util_cp_dedup l) :=	transform

		 self.name_clean := stringlib.stringcleanspaces(name_func(l.orig_fname) + ' ' + name_func(l.orig_mname) +' ' + name_func(l.orig_lname) + 
                            ' ' + trim(l.orig_name_suffix,left,right));
		 self := l;
		 self := [];
		 
		 end;
		 
pre_dCleaned_name := project(util_cp_dedup, tpreCleanname(left));
	 
Address.Mac_Is_Business(pre_dCleaned_name, name_clean, add_name_flag, name_flag, true);
dCleaned_name := add_name_flag;

	//////////////////////////////////////////////////////////////////////////////////////////
	// - Standardize the address and name
	//////////////////////////////////////////////////////////////////////////////////////////

searchpattern1 :='(.*) ([0-9]{5,}$)';
searchpattern2 :='(.*) (.*) (.*) ([0-9]{5})[-]([0-9]{1,})$';
searchpattern3 :='(.*) (.*) ([A-Z]{2}$)';
searchpattern4 :='(.*) (.*) ([A-Z]+)([0-9]{5,}$)';
searchpattern5 :='(.*) ([0-9]{5})[ ]([0-9]{1,})$';
searchpattern6 :='(.*).([0-9]{5})$';
searchpattern7 :='[,] ([0-9]{5})$';
searchpattern8 :='(.*) (.*) ([A-Z]+) ([0-9]{5,}$)';
searchpattern9:='(.*) (USA$)';


rec_temp tpreCleanaddr(dCleaned_name le) := transform

address_street_name_temp := fix_leading_zero(if(regexfind(searchpattern9,le.Address_Street_Name),
regexfind(searchpattern9,le.Address_Street_Name, 1),le.Address_Street_Name));
Address_Street_temp := Addr_Street_func(le.address_street);
Boolean isblank_stcityzip := le.address_city ='' and le.address_state = '' and le.address_zip = '';


Address1_temp := stringlib.stringcleanspaces(if(isblank_stcityzip and regexfind(searchpattern2, address_street_name_temp), Address_Street_temp + ' ' + regexfind(searchpattern2, address_street_name_temp, 1),
if(isblank_stcityzip and regexfind(searchpattern4, address_street_name_temp), Address_Street_temp + ' ' + regexfind(searchpattern4, address_street_name_temp,1),
if(isblank_stcityzip and regexfind(searchpattern8, address_street_name_temp), Address_Street_temp + ' ' + regexfind(searchpattern8, address_street_name_temp, 1),
if(isblank_stcityzip and regexfind(searchpattern5, address_street_name_temp), Address_Street_temp + ' ' + regexfind(searchpattern5, address_street_name_temp, 1),
if(isblank_stcityzip and regexfind(searchpattern6, address_street_name_temp), Address_Street_temp + ' ' + regexfind(searchpattern6, address_street_name_temp, 1),
if(isblank_stcityzip and regexfind(searchpattern7, address_street_name_temp), Address_Street_temp + ' ' + regexfind(searchpattern7, address_street_name_temp, 1),
if(isblank_stcityzip and regexfind(searchpattern1, address_street_name_temp), Address_Street_temp + ' ' + regexfind(searchpattern1, address_street_name_temp, 1),
if(isblank_stcityzip and regexfind(searchpattern3, address_street_name_temp), Address_Street_temp + ' ' + regexfind(searchpattern3, address_street_name_temp,1),
if(isblank_stcityzip, '',
if(regexfind(searchpattern1, address_street_name_temp), Address_Street_temp + regexfind(searchpattern1, address_street_name_temp, 1) + ' ' + le.Address_Street_Type + ' ' + le.Address_Street_direction + ' ' + le.Address_Apartment,
Address_Street_temp + ' ' + address_street_name_temp + ' ' + le.Address_Street_Type + ' ' + le.Address_Street_direction + ' ' + le.Address_Apartment)))))))))));

self.address1 := if(regexfind('^C/O|^ATTN|^@', Address1_temp) and ~regexfind('[0-9]', Address1_temp), '', Address1_temp);

self.Address2 := stringlib.stringcleanspaces(
if(isblank_stcityzip and regexfind(searchpattern2, address_street_name_temp),  regexfind(searchpattern2, address_street_name_temp, 3) + ' ' + regexfind(searchpattern2, address_street_name_temp, 4)[1..5],
if(isblank_stcityzip and regexfind(searchpattern4, address_street_name_temp),  regexfind(searchpattern4, address_street_name_temp, 3) + ' ' + regexfind(searchpattern4, address_street_name_temp,4)[1..5],
if(isblank_stcityzip and regexfind(searchpattern8, address_street_name_temp), regexfind(searchpattern8, address_street_name_temp, 3) + ' ' + regexfind(searchpattern8, address_street_name_temp,4)[1..5],
if(isblank_stcityzip and regexfind(searchpattern5, address_street_name_temp), regexfind(searchpattern5, address_street_name_temp, 2)[1..5],
if(isblank_stcityzip and regexfind(searchpattern6, address_street_name_temp), regexfind(searchpattern6, address_street_name_temp, 2),
if(isblank_stcityzip and regexfind(searchpattern7, stringlib.stringcleanspaces(le.Address_Street_Name))  and regexfind(searchpattern7,stringlib.stringcleanspaces(le.Address_Street_Name), 1) <> '00000', regexfind(searchpattern7, stringlib.stringcleanspaces(le.Address_Street_Name) , 1),
if(isblank_stcityzip and regexfind(searchpattern1, address_street_name_temp), regexfind(searchpattern1, address_street_name_temp, 2)[1..5],
if(isblank_stcityzip and regexfind(searchpattern3, address_street_name_temp), trim(utilfile.city_name(regexfind(searchpattern3, address_street_name_temp,2)),left,right) + ', ' + trim(regexfind(searchpattern3, address_street_name_temp,3),left,right),
trim(le.address_City,left,right) + if(le.address_City <> '',', ',' ') + trim(le.address_State,left,right) + ' ' + trim(le.address_Zip,left,right)[1..5])))))))));
//clean person names
self.name_clean := if(le.name_flag = 'P',Address.CleanPerson73(le.name_clean),'');
           self := le;
		   self := [];
		   end;
		   
pre_dCleaned_addr := project(dCleaned_name, tpreCleanaddr(left)) : persist('~thor_data400::in::utility_cp_clean_name');
   
no_addr_clean   := pre_dCleaned_addr(address1 = '' and address2 = '');
need_addr_clean := pre_dCleaned_addr(~(address1 = '' and address2 = ''));

//append AID 
unsigned4		lAIDAppendFlags	:=	AID.Common.eReturnValues.RawAID 
																| 	AID.Common.eReturnValues.ACECacheRecords;		
AID.MacAppendFromRaw_2Line(need_addr_clean, Address1, Address2, Append_RawAID, append_AID, lAIDAppendFlags);		

//clean name and reformat the records with clean address
utilfile.Layout_Util.base tCleanaddrFields(append_AID le) := transform

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
self.title 			:= le.name_clean[1..5];
self.fname 			:= le.name_clean[6..25];
self.mname 			:= le.name_clean[26..45];
self.lname 			:= le.name_clean[46..65];
self.name_suffix 	:= le.name_clean[66..70];
self.name_score     := le.name_clean[71..73];

self := le;
end;
		

map_addr_clean := project(append_AID, tCleanaddrFields(left)) : persist('~thor_data400::in::utility_cp_clean_addr');


//clean name and reformat the records without clean address
utilfile.Layout_Util.base tCleanNoaddrFields(no_addr_clean le) := transform

self.title 			:= le.name_clean[1..5];
self.fname 			:= le.name_clean[6..25];
self.mname 			:= le.name_clean[26..45];
self.lname 			:= le.name_clean[46..65];
self.name_suffix 	:= le.name_clean[66..70];
self.name_score     := le.name_clean[71..73];

self.prim_range    := '';
self.predir        := '';
self.prim_name     := '';
self.addr_suffix     := '';
self.postdir        := '';
self.unit_desig	   :=	'';
self.sec_range     := '';
self.p_city_name    := '';
self.v_city_name     := '';
self.st            := '';
self.zip           := ''; 	
self.zip4          := '';	
self.cart		   :=	'';
self.cr_sort_sz	   :=	'';
self.lot		   :=	'';
self.lot_order		:=	'';
self.dbpc		    :=	'';
self.chk_digit		:=	'';
self.rec_type	    :=	'';
self.county	        :=	'';
self.geo_lat		:=	'';
self.geo_long		:=	'';
self.msa			:=	'';
self.geo_blk		:=	'';
self.geo_match		:=	'';
self.err_stat		:=	'';

self := Le;
end;

map_noaddr_clean := project(no_addr_clean,tCleanNoaddrFields(left)) ;

//combine two records
map_combine := map_addr_clean + map_noaddr_clean;
out_f := output(map_combine,, '~thor_data400::base::utility_cp_restore_20100305', __compressed__,overwrite);

add_super := FileServices.AddSuperFile('~thor_data400::base::utility_file', '~thor_data400::base::utility_cp_restore_20100305'); 

export proc_cp_history := sequential(out_f, add_super);
