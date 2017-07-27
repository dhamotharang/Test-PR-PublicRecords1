import did_add, ut, header_slimsort,didville,mdr,header;
export daily_redid(string filedate) := function
//full util
util_full := utilfile.file_util_daily_did_in;

with_did := record
 utilfile.Layout_DID_Out;
 unsigned6 did_temp := 0;
end;

//add src
src_rec := record
header_slimsort.Layout_Source;
with_did;
end;

DID_Add.Mac_Set_Source_Code(util_full, src_rec, 'UU', util_full_src)

matchset := ['A','S','P','4','Z'];
did_Add.MAC_Match_Flex
	(util_full_src, matchset,						
	 ssn, dob, fname, mname,lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st, phone, 
	 did_temp, src_rec, false, DID_Score_field,							
	 75, out_src, true, src)
	 
//remove src and reformat
did_ed := project(out_src,transform(utilfile.Layout_DID_Out, self.did := intformat(left.did_temp,12,1),self := left));

//reDID if the prod header version is newer than the last utility

clear_super := FileServices.ClearSuperFile('~thor_data400::base::utility::daily_redid',true);

util_daily_redid := output(did_ed,,'~thor_data400::base::utility::Daily::'+filedate+ '::reDID',overwrite);
//add util redid to superfile
add_daily_redid := fileservices.addsuperfile('~thor_data400::base::utility::daily_redid','~thor_data400::base::utility::Daily::'+filedate+ '::reDID');

build_daily_redid := sequential(clear_super,util_daily_redid,add_daily_redid);

return build_daily_redid;
end;
