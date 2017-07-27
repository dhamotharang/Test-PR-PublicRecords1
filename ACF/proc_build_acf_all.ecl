export proc_build_acf_all(string filedate) := function

do1 := acf.proc_spray_acf(filedate);
do2 := acf.BWR_Build(filedate);

retval := sequential(do1,do2);

return retval;
end;
