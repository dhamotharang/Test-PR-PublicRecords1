import ut;

ut.MAC_SF_Move('~thor_data400::base::mar_div::intermediate','P',mv1);

//query superfiles for logical files that will need to be cleared.
clear_div_sfs := fn_clear_superfiles(Fileservices.LogicalFileList('*mar_div*divorce*',false,true));
clear_mar_sfs := fn_clear_superfiles(Fileservices.LogicalFileList('*mar_div*marriage*',false,true));

export proc_move_to_qa := sequential(mv1,clear_div_sfs,clear_mar_sfs);