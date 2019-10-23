EXPORT proc_build_all(string filedate, boolean skipDOPS=FALSE, string emailTo='') := function
 
 do_all := sequential(fn_Spray, proc_build_base,proc_build_keys(filedate,skipDOPS,emailTo));
 return do_all;
end;