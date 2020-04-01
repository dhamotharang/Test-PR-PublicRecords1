IMPORT Address, NID;
EXPORT RecleanNames(DATASET(Nid.Layout_Repository) ds) := FUNCTION

Nid.Layout_Repository xform(Nid.Layout_Repository R) := TRANSFORM
		boolean fullName := NID.Common.fGetNID(R.name) = R.Nid;
		nm := IF(fullname, R.Name,
							Nid.ReconstructName(R.fname,R.mname,R.lname, R.suffix)
							);
		ntype := Nid.GetNameType(nm);
		self.nameType := ntype;
		self.nid		:= R.nid;
		self.name	:= R.Name;		//nm;
		//string140 cln_name := CleanName(name,ntype,'f');
		string140 cln_name := IF(fullname,
												Address.NameCleaner.CleanNameEx(nm, bSkipTrust := (ntype='T'), nmtype := ntype),
												Address.NameCleaner.CleanNameEx(nm, hint := 'f', bSkipTrust := (ntype='T'), nmtype := ntype)
												);
		self.cln_title		:= cln_name[1..5];
		self.cln_fname		:= cln_name[6..25];
		self.cln_mname		:= cln_name[26..45];
		self.cln_lname		:= cln_name[46..65];
		self.cln_suffix	    := cln_name[66..70];
		self.cln_title2		:= cln_name[71..75];
		self.cln_fname2		:= cln_name[76..95];
		self.cln_mname2		:= cln_name[96..115];
		self.cln_lname2		:= cln_name[116..135];
		self.cln_suffix2    := cln_name[136..140];
		self.gender			:= if(ntype = 'P',
								Address.NameTester.GenderEx(self.cln_fname,self.cln_mname),'');
		self.nameind := $.NameIndicators.fn_setNameIndicator(ntype,0,
								self.gender,
								NOT fullname);
						//(Address.Persons.NameQuality(Address.PrecleanName(nm)) << 3);
								
		self.std_biz := CASE(ntype,
												'B' => Nid.clnBizName(nm),
												'T' => Nid.clnTrustName(nm),
												'');
		self := R;
END;


	result := PROJECT(ds, xform(LEFT));

	return result;

END;