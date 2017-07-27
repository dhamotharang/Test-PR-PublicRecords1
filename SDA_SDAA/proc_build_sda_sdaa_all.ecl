export proc_build_sda_sdaa_all(string filedate) := function

do1 := sda_sdaa.proc_spray_sda_sdaa(filedate);
do2 := sda_sdaa.BWR_Build(filedate);

retval := sequential(do1,do2);

return retval;
end;
