import autokey;

export InterfaceForBuild := 
		INTERFACE
			export dataset(autokey.layouts.master) L_indata;
			export string L_inkeyname;
			export string L_inlogical;
			export set of string1 L_build_skip_set := [];
			export boolean L_UseNewPreferredFirst:=FALSE;
			export boolean L_AddCities:=TRUE;
			export boolean L_diffing := FALSE;					
			export boolean L_Biz_useAllLookups:=TRUE;
			export boolean L_Indv_useAllLookups:=TRUE; 	
			export boolean L_skipaddrnorm:=FALSE;
			export boolean L_skipB2behavior:=FALSE;
			export boolean L_useFakeIDs:=TRUE;
			export boolean L_useOnlyRecordIDs:=TRUE;
			export boolean L_by_lookup:=TRUE;
			export integer L_Biz_favor_lookup:=0;
			export integer L_Indv_favor_lookup:=0;
			export integer L_Rep_addr:=4;	
			export boolean L_useLiteralLookupsValue:=FALSE;//setting this to TRUE is not compatible with explicit use of L_Rep_addr
			export boolean L_processCompoundNames:=FALSE;
		END;
