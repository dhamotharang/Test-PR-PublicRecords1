import did_add, ut, header_slimsort,didville,mdr,header,idl_header, risk_indicators;
export daily_redid(string filedate) := function
//full util
util_full := project(utilfile.file_util_full_daily,utilfile.Layout_DID_Out);

ut.mac_flipnames(util_full,fname,mname,lname,flip_out);

with_did := record
 utilfile.Layout_DID_Out;
 unsigned6 did_temp := 0;
end;

//add src
src_rec := record
header_slimsort.Layout_Source;
with_did;
end;

DID_Add.Mac_Set_Source_Code(flip_out, src_rec, 'UU', util_full_src)

matchset := ['A','S','P','4','Z'];
did_Add.MAC_Match_Flex
	(util_full_src, matchset,						
	 ssn, dob, fname, mname,lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st, phone, 
	 did_temp, src_rec, false, DID_Score_field,							
	 75, out_src, true, src)
	 
//remove src and reformat

did_ed := project(out_src,transform(utilfile.Layout_DID_Out, self.did := intformat(left.did_temp,12,1),self := left));

//apply gender 

header.Mac_Apply_Title(did_ed, title, fname, mname, apply_title)

//reDID if the prod header version is newer than the last utility

util_daily_redid := output(apply_title,,'~thor_data400::base::utility::Daily::'+filedate+ '::reDID',overwrite, __Compressed__);
//add util redid to superfile

clear_super_redid := sequential(FileServices.RemoveOwnedSubFiles('~thor_data400::base::utility::daily_redid',true),
FileServices.ClearSuperFile('~thor_data400::base::utility::daily_redid'),
Fileservices.addsuperfile('~thor_data400::base::utility::daily_redid','~thor_data400::base::utility::Daily::'+filedate+ '::reDID'));

clear_super_did := sequential(FileServices.RemoveOwnedSubFiles('~thor_data400::in::utility::daily_did',true),
FileServices.ClearSuperFile('~thor_data400::in::utility::daily_did'),
fileservices.addsuperfile('~thor_data400::in::utility::daily_did','~thor_data400::base::utility::Daily::'+filedate+ '::reDID'));

build_daily_redid := sequential(util_daily_redid,clear_super_redid,clear_super_did);

return build_daily_redid;
end;
