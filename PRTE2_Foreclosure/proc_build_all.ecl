EXPORT proc_build_all(string filedate) := function
 do_all := sequential(proc_build_base(filedate),proc_build_keys(filedate));
 return do_all;
end;