import address;

	Layout_Persistent_Key_With_Counter := RECORD
	 Layout_Persistent_KeyFile;
	 integer counter_val; 
	END;
	
Layout_Persistent_Key_With_Counter Generate_PKey_File (Layout_SexOffender_Main L ) := TRANSFORM

    string  V_sysdate       := StringLib.GetDateYYYYMMDD(); 
		integer V_sysYear       := (integer)V_sysdate[1..4];
		integer V_age		        := (integer)L.age;
    string  V_Year_of_birth := IF ( V_age < 5  or V_age > 110 , '' , (string) (V_sysYear - V_age));
		
    SELF.Persistent_key     := (string)HASH32(L.orig_state_code, L.lname, L.fname, L.mname, 
		                                 L.name_suffix,L.dob, L. height, L.weight,V_Year_of_birth );
		SELF.Counter_val        := 0;
		SELF := L;																
 END;  
 
	AllProject_records 	         := PROJECT(File_In_SexOffender_Main, Generate_PKey_File(LEFT));
	
	// Not using the distributed version because we need all the same persistent keys to be together. Records with different 
	// seisint_primary key could have the same persistent_key and we need to make them unique.
	Persistent_key_TrueName_Recs := PROJECT(File_In_SexOffender_Main(name_type = '0'), Generate_PKey_File(LEFT));
	
	D_AllProject_records         := DISTRIBUTE(AllProject_records, HASH(Seisint_primary_key));
	DS_AllProject_records        := SORT(D_AllProject_records,seisint_primary_key,did,name_type,LOCAL);
	//output(count(DS_AllProject_records));
	DS_AllProject_records_dedup    := DEDUP(DS_AllProject_records,seisint_primary_key,did,name_type,LOCAL) ;
	//output(count(DS_AllProject_records_dedup));
	
//------------------------------------------------------------------------------------------------------------------------------------	
//If duplicate persistent_key exists, number the dups to make them unique. 
//Not distributed 
  Layout_Persistent_Key_With_Counter Generate_UNQ_PKey_File (Layout_Persistent_Key_With_Counter L , Layout_Persistent_Key_With_Counter R ) := TRANSFORM
		SELF.counter_val             := IF (L.persistent_key = R.persistent_key , L.counter_val+1 ,0);
	  SELF                         := R;
																
  END;	
	
//Group the records by Persistent_key. Sort them by Persistent_key,Seisint_primary_key
Grp_Persistent_key_recs          := SORT( GROUP(SORT(Persistent_key_TrueName_Recs,Persistent_key),Persistent_key),Seisint_primary_key);

UNQ_Persistent_Key_TrueName_Recs := ITERATE (Grp_Persistent_key_recs,Generate_UNQ_PKey_File(LEFT,RIGHT));													

	
//------------------------------------------------------------------------------------------------------------------------------------	
//Generate Persistent key file for all the name_types	
 Layout_Persistent_KeyFile Generate_FullPKey_File (Layout_Persistent_Key_With_Counter M	, Layout_Persistent_Key_With_Counter L) := TRANSFORM
        
				 SELF.Persistent_key := If (L.counter_Val = 0 ,L.Persistent_key, trim(L.Persistent_key)+'_'+ (string)L.counter_Val);
				 SELF := M;
 
  END;
	

 D_UNQ_Persistent_Key_TrueName_Recs  := DISTRIBUTE(UNQ_Persistent_Key_TrueName_Recs, HASH(Seisint_primary_key));
 
 
 Persistent_key_AllNameType_recs  := JOIN(DS_AllProject_records_dedup, D_UNQ_Persistent_Key_TrueName_Recs, 
																		 			LEFT. seisint_primary_key = RIGHT.seisint_primary_key,
                                          Generate_FullPKey_File(LEFT,RIGHT),LOCAL);
																						
 //S_Persistent_key_All_recs        := SORT(Persistent_key_AllNameType_recs, seisint_primary_key,name_type); //Should this be done before

export Generate_Persistent_key_File := Persistent_key_AllNameType_recs : persist('persist::IMAP::File_Gen_Distributed_Pkey');