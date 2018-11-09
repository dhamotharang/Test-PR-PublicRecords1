export Spray_PeopleWise_File(sourceIP,sourcefile,filedate,group_name= '') := macro

#workunit('name','Yogurt:Suppression Key Build '+filedate);
#OPTION('AllowedClusters','thor400_44,thor400_66');
//#OPTION('AllowAutoSwitchQueue','1');


clear_super := fileservices.clearsuperfile('~thor_data400::in::pplwise_opt_out_consumer',true);
spray := FileServices.SprayVariable(sourceIP, sourcefile,,,,,group_name, '~thor_data400::in::pplwise::consumer_export_'+filedate ,,,,true,true);
add_super := fileservices.addsuperfile('~thor_data400::in::pplwise_opt_out_consumer','~thor_data400::in::pplwise::consumer_export_'+filedate);



spray_actions := sequential(clear_super,spray, 
add_super);


#uniquename(send_succ_msg)
#uniquename(send_fail_msg)

RoxieKeyBuild.Mac_Daily_Email_Local('SuppressionKeys','SUCC',filedate,%send_succ_msg%,Suppress.Spray_Notification_Email_Address);
RoxieKeyBuild.Mac_Daily_Email_Local('SuppressionKeys','FAIL',filedate,%send_fail_msg%,Suppress.Spray_Notification_Email_Address);


sequential(spray_actions,Suppress.Proc_Buld_New_Suppression_All(filedate),Scrubs_Suppress.fn_RunScrubs(filedate[1..8],'')) : success(%send_succ_msg%), failure(%send_fail_msg%);


endmacro;