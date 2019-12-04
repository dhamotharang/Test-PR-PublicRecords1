EXPORT proc_build_all(string filedate, boolean skipDOPS=FALSE, string emailTo='') := function
 
 do_all := sequential(fn_spray,proc_build_boca,proc_build_alpha,proc_build_keys(filedate,skipDOPS,emailTo));
 
 return do_all;
end;