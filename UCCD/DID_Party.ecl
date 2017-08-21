import did_add, header_slimsort, ut, didville;

par := uccd.Updated_Party;
prec := uccd.Layout_Updated_Party;

prec zeroit(par l) := transform
	self.did := 0;
	self.bdid := 0;
	self := l;
end;

par_zero := project(par, zeroit(left));

ms := ['A','P','S','D'];

did_Add.MAC_Match_Flex
  (par_zero, ms,						
	 ssn, dob, pname1_fname, pname1_mname,pname1_lname, pname1_name_suffix, 
	 address1_prim_range, address1_prim_name, address1_sec_range, 
	 address1_zip, address1_st, phone10,
	 DID,   			
	 prec, 
	 false, junk,	
	 75,	//dids with a score below here will be dropped 
	 parout)

export DID_Party := parout : persist('UCCD_DID_Party');