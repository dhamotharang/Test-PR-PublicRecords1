#workunit('name','clean all utility file');
import ut, AID, utilfile, address,wma, NID;

export proc_utility_full(dataset(UtilFile.Layout_Utility_In) util_full)	:= 

function

rec_temp := record
	utilfile.Layout_Utility_In;
	string1 name_flag;
  string73 name_clean;
	AID.Common.xAID							Append_RawAID; 
	
end;

remove_junk_name(string name_field) := stringlib.StringFindReplace(regexreplace('SPNP|NONPUB|NONLIST|DNL|OCLS|DECEASED',name_field, ''),'(ENP)', '');
name_func(string name_field) := stringlib.StringFilter(remove_junk_name(name_field),'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz');
 
util_base := project(util_full, transform(rec_temp,
self.name_clean := stringlib.stringcleanspaces(name_func(trim(left.orig_fname,left,right)) + ' ' + trim(left.orig_mname,left,right) +' ' + trim(left.orig_lname,left,right) + 
                                     ' ' + trim(left.orig_Name_Suffix,left,right)),self := left,self := []));

//clean name

NID.Mac_CleanFullNames(util_base, name_out, name_clean, includeInRepository:=true, normalizeDualNames:=true);

append_NID := name_out:persist('~thor_data400::persist::utility_file_tempfile_NID');

utilfile.Layout_Util.base tformat1(append_NID le) := transform

self.title 			:= le.cln_title;
self.fname 			:= le.cln_fname;
self.mname 			:= le.cln_mname;
self.lname 			:= le.cln_lname;
self.name_suffix 	:= le.cln_suffix;
self.name_flag  :=  le.nametype;
self := Le;
end;

map_name_clean := project(append_NID,tformat1(left));

//lift stats
wma.Layout_Util.lift_base tstats1(append_NID le) := transform

self.title 			:= le.cln_title;
self.fname 			:= le.cln_fname;
self.mname 			:= le.cln_mname;
self.lname 			:= le.cln_lname;
self.name_suffix 	:= le.cln_suffix;
self.name_flag  :=  le.nametype;

self.old_title 			:= le.title;
self.old_fname 			:= le.fname;
self.old_mname 			:= le.mname;
self.old_lname 			:= le.lname;
self.old_name_suffix 	:= le.name_suffix;

self := Le;
self := [];

end;

map_name_clean_lift := project(append_NID,tstats1(left));


//combine two records
map_combine := map_name_clean;// + map_noaddr_clean;
out_f := output(map_combine,, '~thor_data400::base::utility_NID_20120510', __compressed__,overwrite);

//combine two records in lift
map_combine_lift := map_name_clean_lift;// + map_noaddr_clean_lift;
out_f_lift := output(map_combine_lift,, '~thor_data400::base::utility_name_lift_20120510', __compressed__,overwrite);

is_canadian_phone(string phone1, string phone2) := phone1[1..3] in utilfile.Canadian_areacode or phone2[1..3] in utilfile.Canadian_areacode;

util_daily_canadian := output(map_combine((unsigned)append_rawaid = 0 and is_canadian_phone(work_phone, phone)),, '~thor_data400::base::utility_canadian_20100305', __compressed__,overwrite);

proc_util := parallel(out_f, out_f_lift);

return proc_util;

end;