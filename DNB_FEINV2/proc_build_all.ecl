import RoxieKeybuild;
export proc_build_all(filedate,retval)
 :=
  macro

	//import dnb_feinv2,RoxieKeyBuild;
	#uniquename(zRunStatsReference)
	dnb_feinv2.proc_dnbfein_stats(filedate,%zRunStatsReference%);			
	#uniquename(Proc_Build_Base)
	#uniquename(Proc_Build_keys)
	#uniquename(Proc_accept_to_QA)
	#uniquename(new_records_sample_for_qa)
	#uniquename(Proc_dnbfein_Base)
	#uniquename(build_boolean_key)
	#uniquename(Proc_Update_RoxiePage)
	%Proc_Build_Base%				:= DNB_FEINv2.proc_build_main_base(filedate)  : success(output('Dnb_Fein Base Files created successfully.'));
	%Proc_Build_Keys%				:= DNB_FEINv2.proc_build_keys(filedate)      : success(output('Dnb_Fein Keys created successfully.'));
	%Proc_Accept_to_QA%			:= DNB_FEINv2.proc_AcceptSK_ToQA	           : success(DNB_FEINv2.Mac_Email_Local(filedate)), failure(FileServices.sendemail('akayttala@seisint.com', 'DNB_FEIN Build Failure', failmessage));
	//%proc_dnbfein_Stats%			:= %zRunStatsReference%					   : success(output('Dnb_Fein Stats created successfully.'));
	%new_records_sample_for_qa%	:= dnb_feinv2.New_records_sample             : success(dnb_feinv2.Email_notification_lists(filedate));
	%build_boolean_key% := dnb_feinv2.Proc_Build_Boolean_keys(filedate);
	%Proc_Update_RoxiePage% := RoxieKeybuild.updateversion('DNBFEINV2Keys', filedate, _control.MyInfo.EmailAddressNotify,,'N|B');
	retval := sequential(
		 %Proc_Build_Base%
		,%Proc_Build_Keys%
		,%build_boolean_key%  
		,%Proc_Accept_to_QA%
		,%Proc_Update_RoxiePage%
		,%new_records_sample_for_qa%
		,%zRunStatsReference%  
	);

  endmacro
 ;

