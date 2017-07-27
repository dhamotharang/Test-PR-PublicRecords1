import ut, doxie, business_header, NID;

export fn_DeriveFields(
	dataset(autokey.layouts.master) inf,
	boolean L_UseNewPreferredFirst = FALSE,
	boolean L_useLiteralLookupsValue = FALSE
) := 
FUNCTION

fein_use(string infein) := stringlib.stringfilterout((string)infein,'-');
up(string s) := stringlib.stringtouppercase(s);

autokey.layouts.master tra(inf l) := 
transform
	self.inp := l.inp;
	
	SELF.p.dph_lname := metaphonelib.DMetaPhone1(l.inp.lname);  
	SELF.p.lname := up(trim(l.inp.lname,LEFT));
	SELF.p.pfname := up(NID.PreferredFirstNew(l.inp.fname, L_UseNewPreferredFirst));
	SELF.p.fname := up(l.inp.fname);
	SELF.p.minit := up(l.inp.mname[1]);
	SELF.p.rel_fname1 := l.inp.rel_fname1;
	SELF.p.rel_fname2 := l.inp.rel_fname2;
	SELF.p.rel_fname3 := l.inp.rel_fname3;
	//**SSN
	SELF.p.s4 := (unsigned)(((string)l.inp.ssn)[6..9]);
	SELF.p.ssn := if((integer)l.inp.ssn=0,'',(string9)l.inp.ssn);
	SELF.p.ssn1 := l.inp.ssn[1];	
	SELF.p.ssn2 := l.inp.ssn[2];
	SELF.p.ssn3 := l.inp.ssn[3];
	SELF.p.ssn4 := l.inp.ssn[4];
	SELF.p.ssn5 := l.inp.ssn[5];
	SELF.p.ssn6 := l.inp.ssn[6];
	SELF.p.ssn7 := l.inp.ssn[7];
	SELF.p.ssn8 := l.inp.ssn[8];
	SELF.p.ssn9 := l.inp.ssn[9];
	//**DOB
	SELF.p.dob := (integer)l.inp.dob;
	SELF.p.yob := doxie.DOBTools((integer)l.inp.dob).year_in; 
	SELF.p.lname1 := l.inp.lname1;
	SELF.p.lname2 := l.inp.lname2;
	SELF.p.lname3 := l.inp.lname3;
	//**ADDR
	SELF.p.prim_name := ut.StripOrdinal(l.inp.prim_name);		
	SELF.p.prim_range := TRIM(ut.CleanPrimRange(l.inp.prim_range),LEFT);
	SELF.p.st := l.inp.st;
	SELF.p.city_name := l.inp.city_name;
	SELF.p.city_code := doxie.Make_CityCode(l.inp.city_name); 
	SELF.p.zip_string6 := l.inp.zip;
	SELF.p.zip := (unsigned4)l.inp.zip;	
	SELF.p.sec_range := l.inp.sec_range;
	SELF.p.city1 := l.inp.city1;
	SELF.p.city2 := l.inp.city2;
	SELF.p.city3 := l.inp.city3;
	SELF.p.states := l.inp.states;
	//**PHONE
	SELF.p.p7 := l.inp.phone[4..10];
	SELF.p.p3 := l.inp.phone[1..3];			
	//**LOOKUPS AND DID
	SELF.p.lookups := 
	if(
		L_useLiteralLookupsValue,
		l.inp.lookups,
		l.inp.lookups | ut.bit_set(0,0)
	);
	SELF.p.did := l.inp.did;
			
	//***** BUSINESS FIELDS
	//**NAME
	SELF.b.bname := up(l.inp.bname);
	SELF.b.cname_indic := business_header.CompanyCleanFields(l.inp.bname, true).indicative; 
	SELF.b.cname_sec := business_header.CompanyCleanFields(l.inp.bname, true).secondary;	
	//**PHONE
	SELF.b.p7 := l.inp.bphone[4..10];  
	SELF.b.p3 := l.inp.bphone[1..3];
	//**ADDR	
	SELF.b.zip := (unsigned4)l.inp.bzip;
	SELF.b.zip_string6 := l.inp.bzip;
	SELF.b.prim_name := ut.StripOrdinal(l.inp.bprim_name);		
	SELF.b.prim_range := TRIM(ut.CleanPrimRange(l.inp.bprim_range),LEFT);
	SELF.b.st := l.inp.bst;
	SELF.b.state := l.inp.bst;
	SELF.b.city_name := l.inp.bcity_name;
	SELF.b.city_code := doxie.Make_CityCode(l.inp.bcity_name); 
	SELF.b.sec_range := l.inp.bsec_range;
	//**LOOKUPS AND BDID
	SELF.b.lookups := 
	if(
		L_useLiteralLookupsValue,
		l.inp.lookups,
		l.inp.lookups | ut.bit_set(0,0)
	);	
	SELF.b.bdid := (unsigned6)l.inp.bdid;
	SELF.b.fein := (string)l.inp.fein;
	SELF.b.f1 := fein_use((string)l.inp.fein)[1];
	SELF.b.f2 := fein_use((string)l.inp.fein)[2];
	SELF.b.f3 := fein_use((string)l.inp.fein)[3];
	SELF.b.f4 := fein_use((string)l.inp.fein)[4];
	SELF.b.f5 := fein_use((string)l.inp.fein)[5];
	SELF.b.f6 := fein_use((string)l.inp.fein)[6];
	SELF.b.f7 := fein_use((string)l.inp.fein)[7];
	SELF.b.f8 := fein_use((string)l.inp.fein)[8];
	SELF.b.f9 := fein_use((string)l.inp.fein)[9];
	SELF := l.inp;  //this picks up custom fields that need no special mapping
	SELF := l;

end;

return project(inf, tra(left));

END;

