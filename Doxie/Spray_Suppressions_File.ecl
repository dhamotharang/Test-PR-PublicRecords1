export Spray_Suppressions_File(sourceIP,sourcefile,filedate,group_name= '') := macro
//#workunit('name','Suppression Web File Spray '+filedate)



recordsize:=425;

//spray_first := FileServices.SprayVariable(sourceIP,sourcefile,,,,,group_name,'~thor_data400::in::suppressions'+filedate ,,,,true,true);
spray_first := FileServices.SprayFixed(sourceIP,sourcefile,recordsize,group_name,'~thor_data400::in::suppressions'+filedate ,,,,true,true);
clear_super := fileservices.clearsuperfile('~thor_data400::in::web_suppression',true);
add_super := fileservices.addsuperfile('~thor_data400::in::web_suppression','~thor_data400::in::suppressions'+filedate);

spray_actions := sequential(spray_first,clear_super,add_super);

#uniquename(send_succ_msg)
#uniquename(send_fail_msg)



 sequential(spray_actions);
endmacro;