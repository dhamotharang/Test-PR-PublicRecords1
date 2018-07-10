IMPORT FraudShared;
EXPORT Mod_Collisions(DATASET(FraudShared.Layouts.Base.Main) FileBase) := Module

SHARED threashold:=enum(unsigned1,Low,Medium,High);
SHARED ssn_threashold:=threashold;
SHARED dob_threashold:=threashold;

//////////////////////////////////
// 'NSD'=> 1             //LASTNAME & FIRSTNAME    & SSN      & DOB
matchset:=['N','S','D'];
Mac_find_collisions(
										FileBase
										,matchset
										,1
										,raw_First_Name, raw_Last_Name, raw_Orig_Suffix
										,ssn, dob
										,DID
										,FraudShared.Layouts.Base.Main
										,dsOut
										,ssn_threashold.High
										,dob_threashold.High
										);

EXPORT N_S_D_col:=dsOut;
//////////////////////////////////
// 'NPD'=> 5            //LASTNAME & FIRSTNAME    & PROB_SSN & DOB
matchset:=['N','P','D'];
Mac_find_collisions(
										FileBase
										,matchset
										,5
										,raw_First_Name, raw_Last_Name, raw_Orig_Suffix
										,ssn, dob
										,DID
										,FraudShared.Layouts.Base.Main
										,dsOut
										,ssn_threashold.Medium
										,dob_threashold.High
										);

EXPORT N_P_D_col:=dsOut;
//////////////////////////////////
concat_all :=
			N_S_D_col
			+ N_P_D_col
			;

export 
concat_srt
					:=
							sort(concat_all
										,raw_First_Name
										,raw_Last_Name
										,raw_Orig_Suffix
										,ssn
										,dob
										,pri
										,did
										)
										;
concat_ddp
					:=
							dedup(concat_srt
										,raw_First_Name
										,raw_Last_Name
										,raw_Orig_Suffix
										,ssn
										,dob
										)
										;

EXPORT matches := concat_ddp;

END;