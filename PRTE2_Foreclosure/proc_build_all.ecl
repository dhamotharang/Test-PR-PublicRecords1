EXPORT proc_build_all(string filedate) := function
#workunit('name','PRTE Foreclosure Base');
 do_all := sequential(fn_Spray_Files, proc_build_base(filedate),proc_build_keys(filedate));
 return do_all;
end;