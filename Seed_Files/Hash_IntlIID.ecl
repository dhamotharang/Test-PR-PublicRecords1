export Hash_IntlIID(
									unicode fname, unicode lname, string natID, 
									unicode postalcode, string phone) := function

retval := hashmd5(fname, lname, natID, postalcode, phone);

return retval;

end;