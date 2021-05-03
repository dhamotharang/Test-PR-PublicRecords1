
EXPORT proc_build_all(string filedate) := function
 do_all := sequential(fspray,proc_build_base,proc_build_keys(filedate),build_orbit(filedate));
  
 return do_all;
end;