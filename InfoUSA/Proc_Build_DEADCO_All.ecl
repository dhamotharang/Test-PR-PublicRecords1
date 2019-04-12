import _Control, InfoUSA, Roxiekeybuild;

export Proc_Build_DEADCO_All(string filedate) := function

//Spray File
sprayfile := InfoUSA.fSprayInputFiles(_control.IPAddress.edata10
												,'/prod_data_build_13/eval_data/infousa/dead_companies/out'
												,'deadco_'+filedate+'.d00'
												,'deadco'
												,'thor400_92');

//Build Base File
mk_base := InfoUSA.Proc_Deadco_Base;

//Build Keys
mk_key := InfoUSA.Proc_Build_Keys(filedate,'DEADCO');
//DF-24528 Build autokey with CCPA fields
mk_autokey := InfoUSA.Proc_Build_autokey_deadco_ccpa(filedate, 'DEADCO');
build_boolean := infousa.Proc_Build_deadco_Boolean_Keys(filedate);

build_keys := sequential(mk_key, mk_autokey, build_boolean);
key_msg := build_keys : success(send_key_email(filedate,'DEADCO').keys_success), failure(send_key_email(filedate,'DEADCO').keys_fail);

//Update Roxie Page
UpdateRoxiePage := RoxieKeybuild.updateversion('DEADCOKeys', filedate, _control.MyInfo.EmailAddressNotify,,'N|B');

retval := sequential(sprayfile, mk_base, key_msg, UpdateRoxiePage
							,Output(choosen(sort(File_DEADCO_Base(bdid > 0),-process_date),1000))
							) : success(Send_Email(filedate,'DEADCO').Build_Success), failure(Send_Email(filedate,'DEADCO').Build_Failure);
return retval;
end;