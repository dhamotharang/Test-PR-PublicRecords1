EXPORT proc_build_all(string filedate) := function
 run_it := sequential(fspray,proc_build_base(filedate),proc_build_keys(filedate));
 return run_it;
end;