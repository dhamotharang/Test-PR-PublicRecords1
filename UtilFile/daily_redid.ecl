import did_add, ut, header_slimsort,didville,mdr,header,idl_header, risk_indicators;
export daily_redid(string filedate) := function
//apply date filter on how many daily util files will be included
util_full := utilfile.file_util.full_did(record_date >= StartDate);

//apply gender 

header.Mac_Apply_Title(util_full, title, fname, mname, apply_title)

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
