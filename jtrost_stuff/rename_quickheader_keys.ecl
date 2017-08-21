import ut;

export rename_quickheader_keys(string newdate) :=
function

all_src := DATASET([
{'~thor_data400::key::headerquick_autokeyaddress_qa'   ,'~thor_data400::key::headerquick::'+newdate+'::autokey_address'},
{'~thor_data400::key::headerquick_autokeycitystname_qa','~thor_data400::key::headerquick::'+newdate+'::autokey_citystname'}, 
{'~thor_data400::key::headerquick_autokeyname_qa'      ,'~thor_data400::key::headerquick::'+newdate+'::autokey_name'}, 
{'~thor_data400::key::headerquick_autokeypayload_qa'   ,'~thor_data400::key::headerquick::'+newdate+'::autokey_payload'}, 
{'~thor_data400::key::headerquick_autokeyphone_qa'     ,'~thor_data400::key::headerquick::'+newdate+'::autokey_phone'}, 
{'~thor_data400::key::headerquick_autokeyssn_qa'       ,'~thor_data400::key::headerquick::'+newdate+'::autokey_ssn'}, 
{'~thor_data400::key::headerquick_autokeystname_qa'    ,'~thor_data400::key::headerquick::'+newdate+'::autokey_stname'}, 
{'~thor_data400::key::headerquick_autokeyzip_qa'       ,'~thor_data400::key::headerquick::'+newdate+'::autokey_zip'}, 
{'~thor_data400::key::headerquickdid_qa'               ,'~thor_data400::key::headerquick::'+newdate+'::did'}, 
{'~thor_data400::key::headerquick_autokeyzipprlname_qa','~thor_data400::key::headerquick::'+newdate+'::autokey_zipprlname'}

], ut.Layout_Superkeynames.inputlayout);

return_this := ut.fLogicalKeyRenaming(all_src, false);

return return_this;

end;
