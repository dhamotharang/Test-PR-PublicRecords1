
EXPORT proc_Main_build(string filedate, boolean skipDOPS=FALSE, string emailTo='') := function
 Import PRTE2_Email_DataV2;
 do_all := sequential(fn_spray,proc_build_boca,proc_build_alpha,proc_build_keys(filedate,skipDOPS,emailTo),
 PRTE2_Email_DataV2.proc_build_keys(filedate,skipDOPS,emailTo));

return do_all;
 end;
