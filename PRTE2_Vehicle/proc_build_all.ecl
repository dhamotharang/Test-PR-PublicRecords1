#workunit('name','PRTE Vehicle Build');
import prte2_Vehicle;

EXPORT proc_build_all(string filedate) := function
 do_all := ordered(fnSpray,proc_build_base,proc_build_keys(filedate));
 return do_all;
end;