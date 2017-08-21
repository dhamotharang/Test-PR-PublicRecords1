export Spray_PullSSN_File(sourceIP,sourcefile,filedate,group_name= '') := macro

#workunit('name','Pull SSN Spray '+filedate)
#OPTION('AllowedClusters','thor400_44,thor400_60')
//#OPTION('AllowAutoSwitchQueue','1')

recordsize:=61;

spray_first := FileServices.SprayFixed(sourceIP,sourcefile, recordsize, group_name,'~thor_data400::in::pull_ssn_'+filedate ,,,,true,true);
clear_super := fileservices.clearsuperfile('~thor_data400::in::pull_ssn',true);
add_super := fileservices.addsuperfile('~thor_data400::in::pull_ssn','~thor_data400::in::pull_ssn_'+filedate);

spray_actions := sequential(spray_first,clear_super,add_super);

#uniquename(send_succ_msg)
#uniquename(send_fail_msg)

//RoxieKeyBuild.Mac_Daily_Email_Local('PULLSSN','SUCC',filedate,%send_succ_msg%,PullSSN.Spray_Notification_Email_Address);
//RoxieKeyBuild.Mac_Daily_Email_Local('PULLSSN','FAIL',filedate,%send_fail_msg%,PullSSN.Spray_Notification_Email_Address);

//sequential(spray_actions,doxie.Proc_Build_Key_pullSSN(filedate)) : success(%send_succ_msg%), failure(%send_fail_msg%);
  sequential(spray_actions); //: success(%send_succ_msg%), failure(%send_fail_msg%);
endmacro;