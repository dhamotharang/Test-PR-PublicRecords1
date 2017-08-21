import Roxiekeybuild, _Control;

export proc_build_abius_all(string filedate) := function 

// Spray file
pre := InfoUSA.fSprayInputFiles(_control.IPAddress.edata10
						,'/prod_data_build_13/eval_data/infousa/abius/out'
						,'abius_'+filedate+'.d00'
						,'abius'
						,'thor400_92');

// Create Base File
do1 := InfoUSA.Make_ABIUS_Company_Base;

// Build Keys
do2 := InfoUSA.Proc_Build_Keys(filedate,'ABIUS');
do3 := InfoUSA.proc_build_Autokey(filedate,'ABIUS');
boolean_build := infousa.Proc_Build_Abius_Boolean_Keys(filedate);

build_keys := sequential(do2, do3, boolean_build);
key_msg := build_keys : success(send_key_email(filedate,'ABIUS').keys_success), failure(send_key_email(filedate,'ABIUS').keys_fail);

//Update Roxie Page
UpdateRoxiePage := RoxieKeybuild.updateversion('ABIKeys', filedate, _control.MyInfo.EmailAddressNotify,,'N|B');

retval := sequential(pre,do1, key_msg, UpdateRoxiePage
							, Output(choosen(sort(File_ABIUS_Company_Base(bdid > 0),-process_date),1000))
							) : success(Send_Email(filedate,'ABIUS').Build_Success), failure(Send_Email(filedate,'ABIUS').Build_Failure);
return retval;
end;
