export Hash_InstantID(
									string fname,string lname,string ssn,string fein,
									string zip,string phone,
									string company_name//,dl, abc
									) := function



retval := hashmd5(fname,lname,ssn,fein,zip,phone,company_name);//,dl,abc);

return retval;

end;