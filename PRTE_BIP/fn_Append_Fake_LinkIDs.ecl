import ut;

export fn_Append_Fake_LinkIDs
(
	dataset(prte_bip.Layout_Append_FakeIds.LinkIds) infile
) :=
FUNCTION

BH_INIT_DOTID 	:= _Constants().BH_INIT_DOTID;
BH_INIT_EMPID 	:= _Constants().BH_INIT_EMPID;
BH_INIT_POWID 	:= _Constants().BH_INIT_POWID;
BH_INIT_PROXID 	:= _Constants().BH_INIT_PROXID;
BH_INIT_SELEID 	:= _Constants().BH_INIT_SELEID;
BH_INIT_LGID3 	:= _Constants().BH_INIT_LGID3;
BH_INIT_ORGID 	:= _Constants().BH_INIT_ORGID;
BH_INIT_ULTID 	:= _Constants().BH_INIT_ULTID;
MAX_UNSIGNED6 	:= _Constants().MAX_UNSIGNED6;

infile_with_company_names 		:= infile(ut.fnTrim2Upper(company_name)<>'');
infile_without_company_names 	:= infile(ut.fnTrim2Upper(company_name)='');

prte_bip.Layout_Append_FakeIds.LinkIds LoadFakeBIPIds(prte_bip.Layout_Append_FakeIds.LinkIds l) := transform
		temp_diff_dot			:= (string)BH_INIT_DOTID[1.. length((string)BH_INIT_DOTID)
													- length((string)hash(ut.fnTrim2Upper(l.company_name + l.prim_range + l.prim_name+ l.sec_range + l.v_city_name + l.st + l.zip))) + 1]
													+ (string)hash(ut.fnTrim2Upper(l.company_name + l.prim_range + l.prim_name+ l.sec_range + l.v_city_name + l.st + l.zip));
		//dotid - 0 or 1 contact at company/address		
		self.dotid				:= if (ut.fnTrim2Upper(l.company_name + l.prim_range + l.prim_name+ l.sec_range + l.v_city_name + l.st + l.zip) <> '',
														 if (hash(ut.fnTrim2Upper(l.company_name + l.prim_range + l.prim_name+ l.sec_range + l.v_city_name + l.st + l.zip))
														 between BH_INIT_DOTID and MAX_UNSIGNED6,
															     hash(ut.fnTrim2Upper(l.company_name + l.prim_range + l.prim_name+ l.sec_range + l.v_city_name + l.st + l.zip)),
																   (unsigned6)temp_diff_dot																 
																 ),
														 BH_INIT_DOTID
														);
		temp_diff_empid		:= (string)BH_INIT_EMPID[1.. length((string)BH_INIT_EMPID)
													- length((string)hash(ut.fnTrim2Upper(l.company_name + l.prim_name + l.fname + l.lname))) + 1]
													+ (string)hash(ut.fnTrim2Upper(l.company_name + l.prim_name + l.fname + l.lname));														
		//empid - contact id																								
		self.empid				:= if (ut.fnTrim2Upper(l.company_name + l.prim_name + l.fname + l.lname) <> '',
														 if (hash(ut.fnTrim2Upper(l.company_name + l.prim_name + l.fname + l.lname))
														 between BH_INIT_EMPID and MAX_UNSIGNED6,
																	 hash(ut.fnTrim2Upper(l.company_name + l.prim_name + l.fname + l.lname)),
																  (unsigned6)temp_diff_empid																	 
																),
														 BH_INIT_EMPID
														 );
		temp_diff_powid		:= (string)BH_INIT_POWID[1.. length((string)BH_INIT_POWID)
													- length((string)hash(ut.fnTrim2Upper(l.company_name + l.prim_range + l.prim_name + l.v_city_name + l.st + l.zip))) + 1]
													+ (string)hash(ut.fnTrim2Upper(l.company_name + l.prim_range + l.prim_name + l.v_city_name + l.st + l.zip));														 
		//powid - place of work id																																																	
		self.powid				:= if (ut.fnTrim2Upper(l.company_name + l.prim_range + l.prim_name + l.v_city_name + l.st + l.zip) <> '',
														 if (hash(ut.fnTrim2Upper(l.company_name + l.prim_range + l.prim_name + l.v_city_name + l.st + l.zip))
														 between BH_INIT_POWID and MAX_UNSIGNED6,
																   hash(ut.fnTrim2Upper(l.company_name + l.prim_range + l.prim_name + l.v_city_name + l.st + l.zip)),
																	(unsigned6)temp_diff_powid																	 
																),
														 BH_INIT_POWID
						 								);
		temp_diff_proxid	:= (string)BH_INIT_PROXID[1.. length((string)BH_INIT_PROXID)
													- length((string)hash(ut.fnTrim2Upper(l.company_name + l.prim_range + l.prim_name+ l.sec_range + l.v_city_name + l.st + l.zip))) + 1]
													+ (string)hash(ut.fnTrim2Upper(l.company_name + l.prim_range + l.prim_name+ l.sec_range + l.v_city_name + l.st + l.zip));														
		//proxid - company/address
		self.proxid				:= if (ut.fnTrim2Upper(l.company_name + l.prim_range + l.prim_name+ l.sec_range + l.v_city_name + l.st + l.zip) <> '',
														 if (hash(ut.fnTrim2Upper(l.company_name + l.prim_range + l.prim_name+ l.sec_range + l.v_city_name + l.st + l.zip))
														 between BH_INIT_PROXID and MAX_UNSIGNED6,
															     hash(ut.fnTrim2Upper(l.company_name + l.prim_range + l.prim_name+ l.sec_range + l.v_city_name + l.st + l.zip)),		
																  (unsigned6)temp_diff_proxid
																),
													   BH_INIT_PROXID
														 );
		temp_diff_seleid	:= (string)BH_INIT_SELEID[1.. length((string)BH_INIT_SELEID)
													- length((string)hash(ut.fnTrim2Upper(l.company_name + l.prim_range + l.prim_name+ l.sec_range + l.v_city_name + l.st + l.zip))) + 1]
													+ (string)hash(ut.fnTrim2Upper(l.company_name + l.prim_range + l.prim_name+ l.sec_range + l.v_city_name + l.st + l.zip));
		//seleid - the smallest enclosing legal entity
		self.seleid				:= if (ut.fnTrim2Upper(l.company_name + l.prim_range + l.prim_name+ l.sec_range + l.v_city_name + l.st + l.zip) <> '',
														 if (hash(ut.fnTrim2Upper(l.company_name + l.prim_range + l.prim_name+ l.sec_range + l.v_city_name + l.st + l.zip))
														 between BH_INIT_SELEID and MAX_UNSIGNED6,
															     hash(ut.fnTrim2Upper(l.company_name + l.prim_range + l.prim_name+ l.sec_range + l.v_city_name + l.st + l.zip)),		
																  (unsigned6)temp_diff_seleid
																),
													   BH_INIT_SELEID
														 );														
		temp_diff_lgid3		:= (string)BH_INIT_LGID3[1.. length((string)BH_INIT_LGID3)
													- length((string)hash(ut.fnTrim2Upper(l.company_name + l.company_fein))) + 1]
													+ (string)hash(ut.fnTrim2Upper(l.company_name + l.company_fein));														
		//lgid3 - the highest level of entity linking based on legally identifable elements
		//(fein, address, name, charter number, etc.
		self.lgid3				:= if (ut.fnTrim2Upper(l.company_name + l.company_fein) <> '',
														 if (hash(ut.fnTrim2Upper(l.company_name + l.company_fein))
														 between BH_INIT_LGID3 and MAX_UNSIGNED6,
																  hash(ut.fnTrim2Upper(l.company_name + l.company_fein)),
																 (unsigned6)temp_diff_lgid3																	
																),
														 BH_INIT_LGID3
													  );
		//orgid - group level of LNCA (LexisNexis Corporate Affiliations)
		self.orgid				:= BH_INIT_ORGID;
		//ultid - highest level legal entity in hierarchy
		self.ultid				:= BH_INIT_ULTID;
		self							:= l;
end;

//only add linkids to records with company names
Append_Fake_LinkIDs 	:= project(infile_with_company_names,LoadFakeBIPIds(left));

Appended_Fake_LinkIDs := Append_Fake_LinkIDs + infile_without_company_names;

return(Appended_Fake_LinkIDs);

end;