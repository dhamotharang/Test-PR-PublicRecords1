EXPORT Mod_Collisions(DATASET(DidSlim) SlimBase) := Module

SHARED threashold:=enum(unsigned1,Low,Medium,High);
SHARED ssn_threashold:=threashold;
SHARED dob_threashold:=threashold;

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
										,DidSlim
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
										,DidSlim
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
										,DidSlim
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
										,DidSlim
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
										,DidSlim
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
										,DidSlim
										,dsOut
										,ssn_threashold.High
										,dob_threashold.High
										);

EXPORT N_D_A_Z_col:=dsOut;

//////////////////////////////////

concat_all := //sort(
			N_S_D_col
			+ V_S_D_col
			+ N_S_B_col
			+ N_P_D_col
			+ N_D_A_C_Z_col
			+ N_D_A_Z_col
			;
// export 
concat_srt
					:=
							sort(concat_all
										,pri
										,new_rid
										,old_rid
										)
										:persist('~otto::persist::concat_srt')
										;
concat_ddp
					:=
							dedup(concat_srt
										,old_rid
										)
										:persist('~otto::persist::concat_ddp')
										;

EXPORT matches := sort(concat_ddp,-new_rid, -pri);

END;