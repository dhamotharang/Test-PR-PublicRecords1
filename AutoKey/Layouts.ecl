import autokeyb2;
export Layouts := 
MODULE

	export MasterP := 
		autokey.Layout_Address - [zip] OR {string6 zip_string6} OR //has conflict with another layout on STRING5 zip;
		autokey.Layout_CityStName OR
		autokey.Layout_Name2 OR
		autokey.Layout_Phone2 OR
		autokey.Layout_SSN2 - [s1,s2,s3,s4,s5,s6,s7,s8,s9] OR {string9 ssn, string1 ssn1,string1 ssn2,string1 ssn3,string1 ssn4,string1 ssn5,string1 ssn6,string1 ssn7,string1 ssn8,string1 ssn9} OR //has conflict on string1 s4;
		autokey.Layout_StName OR
		autokey.Layout_Zip OR
		autokey.Layout_ZipPRLName OR
		{string25 city_name};
		
/* 
// if you want to expand these two (and build the individual layouts from these peices, use
p := dataset([],AutoKey.Layouts.masterp);
output(p,,'cemtemp::p');
b := dataset([],AutoKey.Layouts.masterb);
output(b,,'cemtemp::b');
*/		
		
	export MasterB := 
		autokeyb2.Layout_Address - [zip] OR {string6 zip_string6} OR //has conflict with another layout on STRING5 zip;
		autokeyb2.Layout_Name OR
		autokeyb2.layout_NameWords - [word,seq] OR //i think these should be calculated within this particular keybuild
		{string250 bname} OR
		autokeyb2.Layout_Phone OR
		autokeyb2.Layout_StName OR
		autokeyb2.Layout_Zip OR
		autokeyb2.Layout_FEIN OR
		{string20 fein} OR
		{string25 city_name};
	
	export Custom := RECORD  //must use defaults here
		real lat := 0;
		real long := 0;
	end;
	
	export Inputs := RECORD
		string25 fname;
		string25 mname;
		string25 lname;
		string9 ssn;
		unsigned4	dob;
		string10 phone;
		STRING28 prim_name;
		STRING10 prim_range;
		STRING2 st;
		string50 city_name;
		STRING6 zip;
		STRING8 sec_range;
		unsigned8 states;
		unsigned4 lname1;
		unsigned4 lname2;
		unsigned4 lname3;
		unsigned4 city1;
		unsigned4 city2;
		unsigned4 city3;
		unsigned4 rel_fname1;
		unsigned4 rel_fname2;
		unsigned4 rel_fname3;
		UNSIGNED4 lookups;
		UNSIGNED6 DID;
		STRING200 bname;
		STRING9 fein;
		STRING10 bphone;
		STRING28 bprim_name;
		STRING10 bprim_range;
		STRING2 bst;
		string50 bcity_name;
		STRING5 bzip;
		STRING8 bsec_range;
		UNSIGNED6 BDID;
		Custom;
	end;
		
	export Master := record
		unsigned6 FakeID;
		Inputs Inp;
		MasterP P;
		MasterB B;
		Custom;
	end;

END;