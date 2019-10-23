EXPORT proc_build_all(string filedate) := function
 run_it := sequential(proc_build_base(filedate),proc_build_keys(filedate), 
 	 proc_create_relationships_ssa(filedate)
 );
 return run_it;
end;