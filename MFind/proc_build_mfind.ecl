import mfind;

export proc_build_mfind(string filedate) := function
 
 do_all := sequential(mfind.proc_build_mfind_file,mfind.proc_build_mfind_keys(filedate));

return do_all;

end;