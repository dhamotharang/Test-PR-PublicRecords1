EXPORT fn_cln_name2_OR(string NAME2)  := function

	//Verify if name2 a seperate name
	tmp_name2 := if((NAME2<>''AND StringLib.stringfind(trim(NAME2),' ',1)=0 ) OR
		(NAME2[1]='&' OR
		NAME2[1..3]='CO 'OR
		StringLib.stringfind(NAME2,' CO ',1) !=0 OR
		StringLib.stringfind(NAME2,'INC ',1) != 0 OR
		StringLib.stringfind(NAME2,'AND RESORT',1) != 0 OR
		StringLib.stringfind(NAME2,'AUTHORITY',1) != 0 OR
		StringLib.stringfind(NAME2,'CLAIM',1) != 0 OR
		StringLib.stringfind(NAME2,'SALVAGE TITLE',1) != 0 OR
		StringLib.stringfind(NAME2,'SALVAGE',1) != 0 OR
		StringLib.stringfind(NAME2,'LAW ENF',1) != 0 OR
		StringLib.stringfind(NAME2,'WILDLIFE',1) != 0 OR
		StringLib.stringfind(NAME2,'WASTEWTR RECLMTION',1) != 0 OR
		StringLib.stringfind(NAME2,'WASTEWTR ',1) != 0 OR
		StringLib.stringfind(NAME2,'ACTIVITIES & RECREATION',1) != 0 OR
		NAME2[1..4]='AND ' OR
		StringLib.stringfind(NAME2,'CENTER ',1) != 0 OR
		StringLib.stringfind(NAME2,'CLUB',1) != 0 OR
		StringLib.stringfind(NAME2,'COLLEGE',1) !=0 OR
		StringLib.stringfind(NAME2,'COMPANY',1) !=0 OR
		StringLib.stringfind(NAME2,'CONSULTANTS',1) !=0 OR
		StringLib.stringfind(NAME2,'CONTRACTORS',1) !=0 OR
		StringLib.stringfind(NAME2,'DATED ',1) !=0 OR
		StringLib.stringfind(NAME2,'COUNCIL ',1) !=0 OR
		StringLib.stringfind(NAME2,'COURTHOUSE',1) !=0 OR
		StringLib.stringfind(NAME2,'COUNCEL',1) !=0 OR
		StringLib.stringfind(NAME2,'DEPT ',1) !=0 OR
		StringLib.stringfind(NAME2,'SERVICES',1) !=0 OR
		StringLib.stringfind(NAME2,'GENERAL SERV ',1) !=0 OR
		StringLib.stringfind(NAME2,'GEOLOGY',1) !=0 OR
		StringLib.stringfind(NAME2,'DEPT OF ',1) !=0 OR
		StringLib.stringfind(NAME2,'DIVING ',1) !=0 OR
		StringLib.stringfind(NAME2,'DIVING & SALVAGE',1) !=0 OR
		StringLib.stringfind(NAME2,'DIVISION OF',1) !=0 OR
		StringLib.stringfind(NAME2,'DIVISION OF LAW',1) !=0 OR
		StringLib.stringfind(NAME2,'LAW ENFORCEMENT',1) !=0 OR
		StringLib.stringfind(NAME2,'LAW ENFORC ',1) !=0 OR
		StringLib.stringfind(NAME2,'PARKS DEPT',1) !=0 OR
		StringLib.stringfind(NAME2,'PARKS & RECREATION',1) !=0 OR
		StringLib.stringfind(NAME2,'IRREV TR ',1) !=0 OR
		StringLib.stringfind(NAME2,'BEACH ',1) !=0 OR
		StringLib.stringfind(NAME2,'CO PARKS',1) !=0 OR
		StringLib.stringfind(NAME2,'ENTERPRISES CORP',1) !=0 OR
		StringLib.stringfind(NAME2,'ENVIRONMENTAL SER ',1) !=0 OR
		StringLib.stringfind(NAME2,'EQUIPMENT CO',1) !=0 OR
		StringLib.stringfind(NAME2,'ESTATE & HOLDING',1) !=0 OR
		trim(NAME2)='FAMILY TRUST' OR
		StringLib.stringfind(NAME2,'FIRE DEPARTMENT',1) !=0 OR
		StringLib.stringfind(NAME2,'FIRE PROTECTION',1) !=0 OR
		StringLib.stringfind(NAME2,'FISCHER ',1) !=0 OR
		StringLib.stringfind(NAME2,'FISH COMMISSION',1) !=0 OR
		StringLib.stringfind(NAME2,'FLEET SERVICES',1) !=0 OR
		StringLib.stringfind(NAME2,'GRAVEL CO',1) !=0 OR
		StringLib.stringfind(NAME2,'GRAVEL ',1) !=0 OR
		StringLib.stringfind(NAME2,'MARINE ',1) !=0 OR
		StringLib.stringfind(NAME2,'RESERVATION ',1) !=0 OR
		StringLib.stringfind(NAME2,'WATER BOARD',1) !=0 OR
		StringLib.stringfind(NAME2,'WATER DISTRICT',1) !=0 OR
		StringLib.stringfind(NAME2,'WATER TREATMENT',1) !=0 OR
		StringLib.stringfind(NAME2,'WATER RESORCES',1) !=0 OR
		StringLib.stringfind(NAME2,'FISH COMM',1) !=0 OR
		StringLib.stringfind(NAME2,'SHERIFF',1) !=0 OR
		StringLib.stringfind(NAME2,'SHERIFF OFFICE',1) !=0 ) AND StringLib.stringfind(NAME2,'C/O',1)=0   , ' ' , StringLib.StringToUpperCase(trim(NAME2)));
 
   tmp_xname1:=StringLib.StringFindReplace(tmp_name2,'(','');
   tmp_xname2:=StringLib.StringFindReplace(tmp_xname1,')','');
   tmp_xname3:=StringLib.StringFindReplace(tmp_xname2,'DECEASED','');
   tmp_xname4:=StringLib.StringFindReplace(tmp_xname3,'DECD','');
   tmp_xname5:=StringLib.StringFindReplace(tmp_xname4,'DIV DEC','');
   tmp_xname6:=StringLib.StringFindReplace(tmp_xname5,'POD','');
   tmp_xname7:=StringLib.StringFindReplace(tmp_xname6,'DEA CERT','');
   tmp_xname8:=StringLib.StringFindReplace(tmp_xname7,'AFFID OF REPO','');
   tmp_xname9:=StringLib.StringFindReplace(tmp_xname8,'AFFD OF DEC','');
   tmp_xname10:=StringLib.StringFindReplace(tmp_xname9,'REPO','');
   
    tmp_xname11:= if (StringLib.StringFind(tmp_xname1,'C/O',1)!=0 AND tmp_xname1[1..3]='C/O',trim(StringLib.StringFindReplace(tmp_xname1,'C/O','')),tmp_xname10);
		
		RETURN tmp_xname11;
END;