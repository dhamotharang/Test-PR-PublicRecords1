import did_add, ut, header_slimsort,didville,mdr,header;
export utility_did(string filedate) := function
//full util
util_full := utilfile.file_util_in;

with_did := record
 utilfile.Layout_Utility_In;
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
util_redid := output(did_ed ,,'~thor_data400::base::utility::'+filedate+ '::reDID',overwrite, __Compressed__);
//add util redid to superfile
clear_super := sequential(FileServices.RemoveOwnedSubFiles('~thor_data400::base::utility_DID',true),
               FileServices.ClearSuperFile('~thor_data400::base::utility_DID'),
               Fileservices.addsuperfile('~thor_data400::base::utility_DID','~thor_data400::base::utility::'+filedate+ '::reDID'));

build_util_did := sequential(util_redid,clear_super);

return build_util_did;
end;
