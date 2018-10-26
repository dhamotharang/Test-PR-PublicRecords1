/*
 This attribute is used to support the name repository lookup.
  It should not be accessed directly
*/
import Address;

r1 := RECORD
	string75		name;
	string140		cln_name;
END;

overrideNamees := DICTIONARY(PROJECT(Nid.Overrides(false)(nametype in ['P','D']), TRANSFORM(r1,
												self.name := left.name;
												self.cln_name := left.cln_title + left.cln_fname + left.cln_mname + left.cln_lname + left.cln_suffix +
																					left.cln_title2 + left.cln_fname2 + left.cln_mname2 + left.cln_lname2 + left.cln_suffix2;)
												),
											{name => cln_name});


export string140 CleanNameEx(string name, string1 hint='U', boolean bSkipTrust = false, string1 nmtype='') := 
						IF(name in overrideNamees, overrideNamees[name].cln_name,
						Address.NameCleaner.CleanNameEx(name, hint, bSkipTrust, nmtype));
