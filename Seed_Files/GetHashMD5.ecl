export GetHashMD5(
									string fname,string lname,string ssn,
									string zip,string phone//,dl, abc
									) := function



retval := hashmd5(fname,lname,ssn,zip,phone);//,dl,abc);

return retval;

end;