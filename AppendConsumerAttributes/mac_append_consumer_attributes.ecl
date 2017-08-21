EXPORT mac_append_consumer_attributes (Infile, Input_Lexid = '', Input_LName = '', Input_FName = '', Input_MName = '', Input_SName = '', 
																			 Input_PrimRange = '', Input_PreDirectional = '', Input_PrimaryName = '', Input_AddressSuffix = '', Input_PostDirectional = '', Input_SecondaryRange = '', Input_City = '', Input_State = '', Input_Zip = '',
																			 Input_DOB = '', Input_SSN = '', Input_Gender = '', Input_DPPA = '', Input_GLB = '', Input_DataRestriction = '', Input_DataPermission = '', 
																			 Input_Roxie = '\'\'', appendPrefix = '\'\'', ParallelNodes = 50, BatchSize = 100, ParallelRequests = 2) := FUNCTIONMACRO
	
		import STD;
		OutPut_Rec := RECORD
			RECORDOF (Infile);  	
			STRING1 	#EXPAND(appendPrefix + 'hasBankruptcy');
			STRING1	  #EXPAND(appendPrefix + 'hasConvictions');
			STRING1   #EXPAND(appendPrefix + 'hasDeceased');
			STRING8   #EXPAND(appendPrefix + 'DateOfDeaceased');
			STRING1 	#EXPAND(appendPrefix + 'hasRelativeBankruptcy');
			STRING1	  #EXPAND(appendPrefix + 'hasRelativeConvictions');
			STRING8		#EXPAND(appendPrefix + 'BankruptcyDate');
			STRING8		#EXPAND(appendPrefix + 'ConvictionDate');
			STRING3		#EXPAND(appendPrefix + 'RelativeCount');
			STRING3   #EXPAND(appendPrefix + 'RelativesBankruptcyCount');
			STRING3   #EXPAND(appendPrefix + 'RelativesFelonyCount');
		END;

		Consumer_Shell_Input := RECORD
			UNSIGNED4	Seq;
			STRING30  AcctNo;
			STRING50  LexID;
			STRING9   SSN;
			STRING120 UnParsedFullName;
			STRING30  Name_First;
			STRING30  Name_Middle;
			STRING30  Name_Last;
			STRING5   Name_Suffix;
			STRING8   DOB;
			STRING65 	street_addr;
			STRING25  p_City_name;
			STRING2   St;
			STRING5   Z5;
			STRING10  Home_Phone;
			STRING10  Work_Phone :='';
		END;

		Consumer_Shell_Input_Parsed := RECORD
			Consumer_Shell_Input;
			STRING10 Prim_Range;
			STRING2  Predir;
			STRING28 Prim_Name;
			STRING4  Addr_Suffix;
			STRING2  Postdir;
			STRING8  Sec_Range;
		END;

		Consumer_Shell_Input_Parsed AssignBatchSeq (Infile Le, INTEGER C) := TRANSFORM
			SELF.AcctNo								:=	(STRING)C;
			#IF ( #TEXT(Input_Lexid) <> '' ) SELF.LexID :=  (TYPEOF(SELF.LexID)) Le.Input_Lexid;  #ELSE    SELF.LexID := (TYPEOF(SELF.LexID))'';  #END	
			#IF ( #TEXT(Input_SSN) <> '' ) 	 SELF.SSN :=  	(TYPEOF(SELF.SSN)) Le.Input_SSN;  		#ELSE    SELF.SSN := (TYPEOF(SELF.SSN))'';  		#END	
			#IF ( #TEXT(Input_FName) <> '' ) SELF.Name_First :=  (TYPEOF(SELF.Name_First)) Le.Input_FName;  #ELSE    SELF.Name_First := (TYPEOF(SELF.Name_First))'';  #END	
			#IF ( #TEXT(Input_MName) <> '' ) SELF.Name_Middle := (TYPEOF(SELF.Name_Middle)) Le.Input_MName;  #ELSE    SELF.Name_Middle := (TYPEOF(SELF.Name_Middle))'';  #END	
			#IF ( #TEXT(Input_LName) <> '' ) SELF.Name_Last :=  	(TYPEOF(SELF.Name_Last)) Le.Input_LName;  #ELSE    SELF.Name_Last := (TYPEOF(SELF.Name_Last))'';  #END	
			#IF ( #TEXT(Input_SName) <> '' ) SELF.Name_Suffix :=  (TYPEOF(SELF.Name_Suffix)) Le.Input_SName;  #ELSE    SELF.Name_Suffix := (TYPEOF(SELF.Name_Suffix))'';  #END	
			#IF ( #TEXT(Input_DOB) <> '' ) 	 SELF.DOB :=  (TYPEOF(SELF.DOB)) Le.Input_DOB;  #ELSE    SELF.DOB := (TYPEOF(SELF.DOB))'';  #END	
			
			PrimRange									:=	#IF ( #TEXT(Input_PrimRange) <> '') 			(STRING) Le.Input_PrimRange 	     #ELSE '' #END;
			PreDirectional						:=	#IF ( #TEXT(Input_PreDirectional) <> '') 	(STRING) Le.Input_PreDirectional  #ELSE '' #END;
			PrimaryName								:=	#IF ( #TEXT(Input_PrimaryName) <> '') 		(STRING) Le.Input_PrimaryName 	   #ELSE '' #END;
			AddressSuffix							:=	#IF ( #TEXT(Input_AddressSuffix) <> '') 	(STRING) Le.Input_AddressSuffix 	 #ELSE '' #END;
			PostDirectional						:=	#IF ( #TEXT(Input_PostDirectional) <> '') (STRING) Le.Input_PostDirectional #ELSE '' #END;
			SecondaryRange						:=	#IF ( #TEXT(Input_SecondaryRange) <> '') 	(STRING) Le.Input_SecondaryRange  #ELSE '' #END;
			Street_Addr								:=	PrimRange + ' ' + PreDirectional + ' ' + PrimaryName + ' ' + 
																		AddressSuffix + ' ' + PostDirectional + ' ' + SecondaryRange;							
			SELF.Street_Addr					:=	STD.Str.ToUpperCase(STD.Str.CleanSpaces(Street_Addr));

			SELF.P_City_name					:=	#IF ( #TEXT(Input_City) <> '') 	(STRING) Le.Input_City   #ELSE '' #END;
			SELF.St										:=	#IF ( #TEXT(Input_State) <> '') (STRING) Le.Input_State  #ELSE '' #END;
			SELF.Z5										:=	#IF ( #TEXT(Input_Zip) <> '') 	(STRING) Le.Input_Zip    #ELSE '' #END;
			SELF.Home_Phone						:=	'';
			SELF.Work_Phone 					:=	'';
			SELF.Prim_Range						:=	PrimRange;
			SELF.Predir								:=	PreDirectional;
			SELF.Prim_Name						:=	PrimaryName;
			SELF.Addr_Suffix					:=	AddressSuffix;
			SELF.Postdir							:=	PostDirectional;
			SELF.Sec_Range						:=	SecondaryRange;
			SELF := [];
		END;
		
		Assign_Batch_Seq := PROJECT (Infile, AssignBatchSeq (LEFT, COUNTER));
 
		D_Infile := DISTRIBUTE (Assign_Batch_Seq (Name_Last <> '' and Name_First <> '' and ((Street_Addr <> '' and Z5 <> '') OR (SSN <> ''))), HASH64(Name_Last, Name_First, Name_Middle, Name_Suffix, Prim_Range, Predir, Prim_Name,  Addr_Suffix, Postdir, Sec_Range, P_City_Name, St, Z5, DOB, SSN));
		
		Remove_Duplicates := DEDUP(SORT (D_Infile, Name_Last, Name_First, Name_Middle, Name_Suffix, Prim_Range, Predir, Prim_Name, Addr_Suffix, Postdir, Sec_Range, P_City_Name, St, Z5, DOB, SSN, LOCAL), Name_Last, Name_First, Name_Middle, Name_Suffix, Prim_Range, Predir, Prim_Name, Addr_Suffix, Postdir, Sec_Range, P_City_Name, St, Z5, DOB, SSN, LOCAL);
	
		Consumer_Shell_Output := RECORD
			STRING30 acctno;
			STRING50 Lexid := '';
			STRING10 DateOfDeath;
			boolean	 Death_Ind;
			STRING3  v4_RelativesCount;
			STRING3  v4_RelativesBankruptcyCount;
			STRING3  v4_RelativesFelonyCount;
			STRING2  v4_DerogSeverityIndex;
			STRING3  v4_DerogCount;
			STRING3  v4_DerogAge;
			STRING3  v4_FelonyCount;
			STRING3  v4_FelonyAge;
			STRING3  v4_FelonyCount01;
			STRING3  v4_FelonyCount03;
			STRING3  v4_FelonyCount06;
			STRING3  v4_FelonyCount12;
			STRING3  v4_FelonyCount24;
			STRING3  v4_FelonyCount60;
			STRING3  v4_ArrestCount;
			STRING3  v4_ArrestAge;
			STRING3  v4_ArrestCount01;
			STRING3  v4_ArrestCount03;
			STRING3  v4_ArrestCount06;
			STRING3  v4_ArrestCount12;
			STRING3  v4_ArrestCount24;
			STRING3  v4_ArrestCount60;
			STRING3  v4_BankruptcyCount;
			STRING3  v4_BankruptcyAge;
			STRING2  v4_BankruptcyType;
			STRING35 v4_BankruptcyStatus;
			STRING3  v4_BankruptcyCount01;
			STRING3  v4_BankruptcyCount03;
			STRING3  v4_BankruptcyCount06;
			STRING3  v4_BankruptcyCount12;
			STRING3  v4_BankruptcyCount24;
			STRING3  v4_BankruptcyCount60;
			STRING   errorcode := '';
			INTEGER  ResponseTime {XPATH('_call_latency_ms')};
		END;
		
		Consumer_Results_REC := RECORD
			STRING30  Name_First;
			STRING30  Name_Middle;
			STRING30  Name_Last;
			STRING5   Name_Suffix;
			STRING8   DOB;
			STRING9   SSN;
			STRING10 Prim_Range;
			STRING2  Predir;
			STRING28 Prim_Name;
			STRING4  Addr_Suffix;
			STRING2  Postdir;
			STRING8  Sec_Range;
			STRING65 	Street_Addr;
			STRING25  P_City_Name;
			STRING2   St;
			STRING5   Z5;
			STRING50  ILexid;
			STRING50 	OLexid;
			STRING10 DateOfDeath;
			boolean	 Death_Ind;
			STRING3  v4_RelativesCount;
			STRING3  v4_RelativesBankruptcyCount;
			STRING3  v4_RelativesFelonyCount;
			STRING2  v4_DerogSeverityIndex;
			STRING3  v4_DerogCount;
			STRING3  v4_DerogAge;
			STRING3  v4_FelonyCount;
			STRING3  v4_FelonyAge;
			STRING3  v4_FelonyCount01;
			STRING3  v4_FelonyCount03;
			STRING3  v4_FelonyCount06;
			STRING3  v4_FelonyCount12;
			STRING3  v4_FelonyCount24;
			STRING3  v4_FelonyCount60;
			STRING3  v4_ArrestCount;
			STRING3  v4_ArrestAge;
			STRING3  v4_ArrestCount01;
			STRING3  v4_ArrestCount03;
			STRING3  v4_ArrestCount06;
			STRING3  v4_ArrestCount12;
			STRING3  v4_ArrestCount24;
			STRING3  v4_ArrestCount60;
			STRING3  v4_BankruptcyCount;
			STRING3  v4_BankruptcyAge;
			STRING2  v4_BankruptcyType;
			STRING35 v4_BankruptcyStatus;
			STRING3  v4_BankruptcyCount01;
			STRING3  v4_BankruptcyCount03;
			STRING3  v4_BankruptcyCount06;
			STRING3  v4_BankruptcyCount12;
			STRING3  v4_BankruptcyCount24;
			STRING3  v4_BankruptcyCount60;
		END;
		
		DPPA_Indicator   := #IF ( #TEXT(Input_DPPA) <> '' ) 	TRIM ((STRING)Input_DPPA) #ELSE '0' #END;
		GLB_Indicator  	 := #IF ( #TEXT(Input_GLB)  <> '' ) 	TRIM ((STRING)Input_GLB)  #ELSE '0' #END;
		Data_Restriction := #IF ( #TEXT(Input_DataRestriction)  <> '' ) TRIM ((STRING)Input_DataRestriction)  #ELSE '00000100010011' #END;
		Data_Permission  := #IF ( #TEXT(Input_DataPermission)   <> '' ) TRIM ((STRING)Input_DataPermission)   #ELSE '0000000000000' #END;
		Industry_class   := '';
			
		ServiceIP 			 	:= #IF ( #TEXT(Input_Roxie) <> '') 	(STRING) TRIM(Input_Roxie)  #ELSE 'http://10.239.194.100:9876' #END;
		ServiceName			 	:= 'RAMPS_Healthcare.ConsumerShellService';
		
		STRING optionValue := '<DPPAPurpose>'+DPPA_Indicator+'</DPPAPurpose><GLBPurpose>'+GLB_Indicator+'</GLBPurpose><DataRestrictionMask>'+Data_Restriction+'</DataRestrictionMask><DataPermissionMask>'+Data_Permission+'</DataPermissionMask><IndustryClass>'+Industry_class+'</IndustryClass>';
		STRING options := optionValue + '<batch_in><Row>';					

		D_Input_ds	:= DISTRIBUTE(PROJECT(Remove_Duplicates,Consumer_Shell_Input), (RANDOM() % ParallelNodes) + 1);
		
		Consumer_Shell_Output failX (Consumer_Shell_Input L) := TRANSFORM
			SELF.ErrorCode := FAILCODE + FAILMESSAGE;
			SELF 					 := L;
			SELF 					 := [];
		END;
		
		Output_DS		:= SOAPCALL(D_Input_ds,
														ServiceIP,
														ServiceName,
														{D_Input_ds},
														DATASET(Consumer_Shell_Output),
														ONFAIL(failx(LEFT)),
														HEADING(options,'</Row></batch_in>'),
														PARALLEL(2),
														MERGE(batchSize));
		
		Consumer_Data := JOIN (Remove_Duplicates,Output_DS,LEFT.AcctNo = RIGHT.AcctNo,TRANSFORM(Consumer_Results_REC, SELF.ILexID := LEFT.Lexid; SELF.OLexid := RIGHT.LexID; SELF := RIGHT; SELF := LEFT;), KEEP(1), HASH);
	
		Remove_Ambiguous_LEXID := Consumer_Data (((INTEGER)ILexID > 0 AND (INTEGER)OLexid > 0 AND (INTEGER)ILexID = (INTEGER)OLexid));
																							// OR ((INTEGER)ILexID = 0 AND (INTEGER)OLexid > 0));
		
		Consumer_Reslts := JOIN (Infile, Remove_Ambiguous_LEXID, LEFT.Input_FName = RIGHT.Name_First AND 
																									 LEFT.Input_MName = RIGHT.Name_Middle AND 
																									 LEFT.Input_LName = RIGHT.Name_Last AND
																									 LEFT.Input_SName = RIGHT.Name_Suffix AND
																									 // LEFT.Input_SSN = RIGHT.SSN AND
																									 // (INTEGER)LEFT.Input_DOB = (INTEGER)RIGHT.DOB AND
																									 LEFT.Input_PrimRange = RIGHT.Prim_Range AND
																									 LEFT.Input_PreDirectional = RIGHT.Predir AND
																									 LEFT.Input_PrimaryName = RIGHT.Prim_Name AND
																									 LEFT.Input_AddressSuffix = RIGHT.Addr_Suffix AND
																									 LEFT.Input_PostDirectional = RIGHT.Postdir AND
																									 LEFT.Input_SecondaryRange = RIGHT.Sec_Range AND
																									 LEFT.Input_City = RIGHT.P_City_name AND
																									 LEFT.Input_State = RIGHT.St AND
																									 LEFT.Input_Zip = RIGHT.Z5,TRANSFORM(OutPut_Rec, 
																									 SELF.#EXPAND(appendPrefix + 'hasBankruptcy')						:= IF(((INTEGER)RIGHT.v4_BankruptcyCount01 +
																																																								 (INTEGER)RIGHT.v4_BankruptcyCount03 +
																																																								 (INTEGER)RIGHT.v4_BankruptcyCount06 +
																																																								 (INTEGER)RIGHT.v4_BankruptcyCount12 +
																																																								 (INTEGER)RIGHT.v4_BankruptcyCount24 +
																																																								 (INTEGER)RIGHT.v4_BankruptcyCount60)	> 0, 'Y', 'N');
																									 SELF.#EXPAND(appendPrefix + 'hasConvictions')					:= IF(((INTEGER)RIGHT.v4_FelonyCount01 + 
																																																							   (INTEGER)RIGHT.v4_FelonyCount03 +
																																																								 (INTEGER)RIGHT.v4_FelonyCount06 +
																																																								 (INTEGER)RIGHT.v4_FelonyCount12 +
																																																								 (INTEGER)RIGHT.v4_FelonyCount24 +
																																																								 (INTEGER)RIGHT.v4_FelonyCount60) > 0, 'Y', 'N');
																									 SELF.#EXPAND(appendPrefix + 'hasDeceased')							:= IF(RIGHT.Death_Ind, 'Y','N');
																									 SELF.#EXPAND(appendPrefix + 'DateOfDeaceased')					:= TRIM(RIGHT.DateOfDeath);
																									 SELF.#EXPAND(appendPrefix + 'hasRelativeBankruptcy')		:= IF((INTEGER)RIGHT.v4_RelativesBankruptcyCount > 0, 'Y','N');
																									 SELF.#EXPAND(appendPrefix + 'hasRelativeConvictions')	:= IF((INTEGER)RIGHT.v4_RelativesFelonyCount > 0, 'Y','N');
																									 SELF.#EXPAND(appendPrefix + 'BankruptcyDate')					:= MAP((INTEGER)RIGHT.v4_BankruptcyCount01 > 0 => 'Past 1M', 
																																																								 (INTEGER)RIGHT.v4_BankruptcyCount03 > 0 => 'Past 3M', 
																																																								 (INTEGER)RIGHT.v4_BankruptcyCount06 > 0 => 'Past 6M', 
																																																								 (INTEGER)RIGHT.v4_BankruptcyCount12 > 0 => 'Past 1Y', 
																																																								 (INTEGER)RIGHT.v4_BankruptcyCount24	> 0 => 'Past 2Y', 
																																																								 (INTEGER)RIGHT.v4_BankruptcyCount60 > 0 => 'Past 5Y', '');
																									 SELF.#EXPAND(appendPrefix + 'ConvictionDate')					:= MAP((INTEGER)RIGHT.v4_FelonyCount01 > 0 => 'Past 1M', 
																																																							   (INTEGER)RIGHT.v4_FelonyCount03 > 0 => 'Past 3M', 
																																																								 (INTEGER)RIGHT.v4_FelonyCount06 > 0 => 'Past 6M', 
																																																								 (INTEGER)RIGHT.v4_FelonyCount12 > 0 => 'Past 1Y', 
																																																								 (INTEGER)RIGHT.v4_FelonyCount24 > 0 => 'Past 2Y', 
																																																								 (INTEGER)RIGHT.v4_FelonyCount60 > 0 => 'Past 5Y', '');
																									 SELF.#EXPAND(appendPrefix + 'RelativeCount')						 :=	RIGHT.v4_RelativesCount;
																									 SELF.#EXPAND(appendPrefix + 'RelativesBankruptcyCount') := RIGHT.v4_RelativesBankruptcyCount;
																									 SELF.#EXPAND(appendPrefix + 'RelativesFelonyCount')		 :=	RIGHT.v4_RelativesFelonyCount;
																									 SELF := LEFT;
																									 ), LEFT OUTER, KEEP(1), LIMIT(0), HASH);
    // output (Consumer_Data,,'~thor::pilgrim::Consumer_Data::sajishtest::20161007',overwrite,compressed,expire(20));																										
		RETURN IF(COUNT(Infile) < 20000000,Consumer_Reslts,FAIL(Consumer_Reslts,99,'Input file is bigger than the allowed limit'));
ENDMACRO;