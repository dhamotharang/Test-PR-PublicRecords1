EXPORT proc_build_all(string filedate) := function

do_all := sequential(proc_build_keys(filedate), build_orbit(filedate));

return do_all;
end;