export Spray_New_PullSSN_File(sourceIP,sourcefile,filedate,group_name= '') := macro

//#workunit('name','LN_Opt_Out Spray '+filedate)


recordsize:=61;

spray_first := FileServices.SprayVariable(sourceIP,sourcefile,,,,,group_name,'~thor_data400::in::ln_opt_out_'+filedate ,,,,true,true);
clear_super := fileservices.clearsuperfile('~thor_data400::in::ln_opt_out',true);
add_super := fileservices.addsuperfile('~thor_data400::in::ln_opt_out','~thor_data400::in::ln_opt_out_'+filedate);

spray_actions := sequential(spray_first,clear_super,add_super);

#uniquename(send_succ_msg)
#uniquename(send_fail_msg)

  sequential(spray_actions);
endmacro;