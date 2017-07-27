import ut;

layout_quarters := record
	real Q1_1996;
	real Q2_1996;
	real Q3_1996;
	real Q4_1996;
	
	real Q1_1997;
	real Q2_1997;
	real Q3_1997;
	real Q4_1997;
	
	real Q1_1998;
	real Q2_1998;
	real Q3_1998;
	real Q4_1998;
	
	real Q1_1999;
	real Q2_1999;
	real Q3_1999;
	real Q4_1999;
	
	real Q1_2000;
	real Q2_2000;
	real Q3_2000;
	real Q4_2000;
	
	real Q1_2001;
	real Q2_2001;
	real Q3_2001;
	real Q4_2001;
	
	real Q1_2002;
	real Q2_2002;
	real Q3_2002;
	real Q4_2002;
	
	real Q1_2003;
	real Q2_2003;
	real Q3_2003;
	real Q4_2003;
	
	real Q1_2004;
	real Q2_2004;
	real Q3_2004;
	real Q4_2004;
	
	real Q1_2005;
	real Q2_2005;
	real Q3_2005;
end;

pi_base_layout := record
	string2 state;
	string5 fips_code;
	string5 zipcode;
	string1 land_use;
	layout_quarters;
end;


f := dataset('~thor_data400::in::avm_pi_basetable', pi_base_layout, csv(heading(1)));

sorted_base := sort(f, fips_code, land_use, zipcode);

export File_PI_BaseTable := project(sorted_base, transform(pi_base_layout, self.fips_code := (string)intformat((integer)left.fips_code,5,1), self := left));
