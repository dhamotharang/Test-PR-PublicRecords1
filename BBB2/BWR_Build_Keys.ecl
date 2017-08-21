import RoxieKeyBuild,BBB2;
#workunit('name', 'BBB Build Roxie Keys ' + bbb2.version);

RoxieKeyBuild.Mac_Daily_Email_Local('BBB','SUCC',bbb2.version,send_succ_msg,bbb2.Email_Notification_Lists.RoxieKeybuild);
RoxieKeyBuild.Mac_Daily_Email_Local('BBB','FAIL',bbb2.version,send_fail_msg,bbb2.Email_Notification_Lists.RoxieKeybuild);

lProc_Build_Keys	:= bbb2.Proc_Build_Keys(bbb2.version).All	: success(output('Keys created successfully.'));
lProc_Accept_to_QA	:= bbb2.Proc_Accept_to_QA	: success(send_succ_msg), failure(send_fail_msg);

sequential(
	 lProc_Build_Keys
	,lProc_Accept_to_QA
);