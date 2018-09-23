IMPORT FraudShared;
EXPORT Mod_Collisions(DATASET(FraudShared.Layouts.Base.Main) FileBase) := Module

SHARED threashold:=enum(unsigned1,Low,Medium,High);
SHARED ssn_threashold:=threashold;
SHARED dob_threashold:=threashold;

export DidSlim := 
record
	string20		fname;
	string20		mname;
	string20		lname;
	string5			name_suffix;
	string10		prim_range;
	string28		prim_name;
	string25		v_city_name;
	string5			zip;
	string2			st;
	string9			ssn;
	unsigned		dob;
	unsigned6		did := 0;
	unsigned1		did_score := 0;
end;

// SHARED	SlimBase := project(FileBase, transform(DidSlim, SELF.fname:=LEFT.cleaned_name.fname, 
// SELF.lname:=LEFT.cleaned_name.lname, SELF.name_suffix:= LEFT.cleaned_name.name_suffix; SELF.ssn := LEFT.clean_ssn; SELF.dob := (unsigned)LEFT.clean_dob; SELF.prim_range := LEFT.clean_address.prim_range; SELF.prim_name := LEFT.clean_address.prim_name; SELF.v_city_name := LEFT.clean_address.v_city_name; SELF.st := LEFT.clean_address.st; SELF.zip := LEFT.clean_address.zip; SELF := LEFT; SELF := []));
//As per conversation with Danny over the phone 9/22/2018 we decided to go with raw fields.
SHARED	SlimBase := project(FileBase, transform(DidSlim, SELF.fname:=LEFT.raw_first_name, 
SELF.lname:=LEFT.raw_last_name, SELF.name_suffix:= LEFT.raw_Orig_Suffix; SELF.ssn := LEFT.ssn; SELF.dob := (unsigned)LEFT.dob; SELF.prim_range := LEFT.clean_address.prim_range; SELF.prim_name := LEFT.clean_address.prim_name; SELF.v_city_name := LEFT.clean_address.v_city_name; SELF.st := LEFT.clean_address.st; SELF.zip := LEFT.zip; SELF := LEFT; SELF := []));
//////////////////////////////////
// 'NSD'=> 1             //LASTNAME & FIRSTNAME    & SSN      & DOB
matchset:=['N','S','D'];
Mac_find_collisions(
										SlimBase
										,matchset
										,1
										,fname, lname, name_suffix
										,ssn, dob
										,DID
										,prim_range, prim_name
										,v_city_name, st, zip
										,FraudShared.Layouts.Base.Main
										,dsOut
										,ssn_threashold.High
										,dob_threashold.High
										);

EXPORT N_S_D_col:=dsOut;
//////////////////////////////////
// 'VSD'=> 2             //Partial Name    & SSN      & DOB
matchset:=['V','S','D'];
Mac_find_collisions(
										SlimBase
										,matchset
										,2
										,fname, lname, name_suffix
										,ssn, dob
										,DID
										,prim_range, prim_name
										,v_city_name, st, zip
										,FraudShared.Layouts.Base.Main
										,dsOut
										,ssn_threashold.High
										,dob_threashold.High
										);

EXPORT V_S_D_col:=dsOut;
//////////////////////////////////
// 'NSB'=> 3             //LASTNAME & FIRSTNAME    & SSN      & PROB_DOB
matchset:=['N','S','B'];
Mac_find_collisions(
										SlimBase
										,matchset
										,3
										,fname, lname, name_suffix
										,ssn, dob
										,DID
										,prim_range, prim_name
										,v_city_name, st, zip
										,FraudShared.Layouts.Base.Main
										,dsOut
										,ssn_threashold.High
										,dob_threashold.Medium
										);

EXPORT N_S_B_col:=dsOut;

//////////////////////////////////
// 'NPD'=> 5            //LASTNAME & FIRSTNAME    & PROB_SSN & DOB
matchset:=['N','P','D'];
Mac_find_collisions(
										SlimBase
										,matchset
										,5
										,fname, lname, name_suffix
										,ssn, dob
										,DID
										,prim_range, prim_name
										,v_city_name, st, zip
										,FraudShared.Layouts.Base.Main
										,dsOut
										,ssn_threashold.Medium
										,dob_threashold.High
										);

EXPORT N_P_D_col:=dsOut;

//////////////////////////////////
// 'NDACZ'=> 10            //LASTNAME & FIRSTNAME    & DOB & ADDRESS, CITY, ZIP
matchset:=['N','D','A','C','Z'];
Mac_find_collisions(
										SlimBase
										,matchset
										,10
										,fname, lname, name_suffix
										,ssn, dob
										,DID
										,prim_range, prim_name
										,v_city_name, st, zip
										,FraudShared.Layouts.Base.Main
										,dsOut
										,ssn_threashold.High
										,dob_threashold.High
										);

EXPORT N_D_A_C_Z_col:=dsOut;

//////////////////////////////////
// 'NDAZ'=> 12            //LASTNAME & FIRSTNAME    & DOB & ADDRESS, ZIP
matchset:=['N','D','A','Z'];
Mac_find_collisions(
										SlimBase
										,matchset
										,12
										,fname, lname, name_suffix
										,ssn, dob
										,DID
										,prim_range, prim_name
										,v_city_name, st, zip
										,FraudShared.Layouts.Base.Main
										,dsOut
										,ssn_threashold.High
										,dob_threashold.High
										);

EXPORT N_D_A_Z_col:=dsOut;

//////////////////////////////////
concat_all :=
			N_S_D_col
			+ V_S_D_col
			+ N_S_B_col
			+ N_P_D_col
			+ N_D_A_C_Z_col
			+ N_D_A_Z_col
			;

export 
concat_srt
					:=
							sort(concat_all
										,fname
										,lname
										,name_suffix
										,ssn
										,dob
										,pri
										,did
										)
										;
concat_ddp
					:=
							dedup(concat_srt
										,fname
										,lname
										,name_suffix
										,ssn
										,dob
										)
										;

EXPORT matches := concat_ddp;

END;