import watercraft,ut,address,AID,header;

// Translates or_phase01_mod_V002.ksh*

fIn_raw := watercraft_preprocess.Files_raw.or_; 

temp_rec := {Watercraft.layout_or,string concat_name_prev , string1 name2_format}; 

fprecelan := project( fIn_raw, transform({temp_rec}, 

tmp_xname := if(( left.NAME2<>''AND StringLib.stringfind(trim(left.NAME2),' ',1)=0 ) OR
	       ( left.NAME2[1]='&' OR
		     left.NAME2[1..3]='CO 'OR
		StringLib.stringfind(left.NAME2,' CO ',1) !=0 OR
		StringLib.stringfind(left.NAME2,'INC ',1) != 0 OR
		StringLib.stringfind(left.NAME2,'AND RESORT',1) != 0 OR
		StringLib.stringfind(left.NAME2,'AUTHORITY',1) != 0 OR
		StringLib.stringfind(left.NAME2,'CLAIM',1) != 0 OR
		StringLib.stringfind(left.NAME2,'SALVAGE TITLE',1) != 0 OR
		StringLib.stringfind(left.NAME2,'SALVAGE',1) != 0 OR
		StringLib.stringfind(left.NAME2,'LAW ENF',1) != 0 OR
		StringLib.stringfind(left.NAME2,'WILDLIFE',1) != 0 OR
		StringLib.stringfind(left.NAME2,'WASTEWTR RECLMTION',1) != 0 OR
		StringLib.stringfind(left.NAME2,'WASTEWTR ',1) != 0 OR
		StringLib.stringfind(left.NAME2,'ACTIVITIES & RECREATION',1) != 0 OR
		left.NAME2[1..4]='AND ' OR
		StringLib.stringfind(left.NAME2,'CENTER ',1) != 0 OR
		StringLib.stringfind(left.NAME2,'CLUB',1) != 0 OR
		StringLib.stringfind(left.NAME2,'COLLEGE',1) !=0 OR
		StringLib.stringfind(left.NAME2,'COMPANY',1) !=0 OR
		StringLib.stringfind(left.NAME2,'CONSULTANTS',1) !=0 OR
		StringLib.stringfind(left.NAME2,'CONTRACTORS',1) !=0 OR
		StringLib.stringfind(left.NAME2,'DATED ',1) !=0 OR
		StringLib.stringfind(left.NAME2,'COUNCIL ',1) !=0 OR
		StringLib.stringfind(left.NAME2,'COURTHOUSE',1) !=0 OR
		StringLib.stringfind(left.NAME2,'COUNCEL',1) !=0 OR
		StringLib.stringfind(left.NAME2,'DEPT ',1) !=0 OR
		StringLib.stringfind(left.NAME2,'SERVICES',1) !=0 OR
		StringLib.stringfind(left.NAME2,'GENERAL SERV ',1) !=0 OR
		StringLib.stringfind(left.NAME2,'GEOLOGY',1) !=0 OR
		StringLib.stringfind(left.NAME2,'DEPT OF ',1) !=0 OR
		StringLib.stringfind(left.NAME2,'DIVING ',1) !=0 OR
		StringLib.stringfind(left.NAME2,'DIVING & SALVAGE',1) !=0 OR
		StringLib.stringfind(left.NAME2,'DIVISION OF',1) !=0 OR
		StringLib.stringfind(left.NAME2,'DIVISION OF LAW',1) !=0 OR
		StringLib.stringfind(left.NAME2,'LAW ENFORCEMENT',1) !=0 OR
		StringLib.stringfind(left.NAME2,'LAW ENFORC ',1) !=0 OR
		StringLib.stringfind(left.NAME2,'PARKS DEPT',1) !=0 OR
		StringLib.stringfind(left.NAME2,'PARKS & RECREATION',1) !=0 OR
		StringLib.stringfind(left.NAME2,'IRREV TR ',1) !=0 OR
		StringLib.stringfind(left.NAME2,'BEACH ',1) !=0 OR
		StringLib.stringfind(left.NAME2,'CO PARKS',1) !=0 OR
		StringLib.stringfind(left.NAME2,'ENTERPRISES CORP',1) !=0 OR
		StringLib.stringfind(left.NAME2,'ENVIRONMENTAL SER ',1) !=0 OR
		StringLib.stringfind(left.NAME2,'EQUIPMENT CO',1) !=0 OR
		StringLib.stringfind(left.NAME2,'ESTATE & HOLDING',1) !=0 OR
		trim(left.NAME2)='FAMILY TRUST' OR
		StringLib.stringfind(left.NAME2,'FIRE DEPARTMENT',1) !=0 OR
		StringLib.stringfind(left.NAME2,'FIRE PROTECTION',1) !=0 OR
		StringLib.stringfind(left.NAME2,'FISCHER ',1) !=0 OR
		StringLib.stringfind(left.NAME2,'FISH COMMISSION',1) !=0 OR
		StringLib.stringfind(left.NAME2,'FLEET SERVICES',1) !=0 OR
		StringLib.stringfind(left.NAME2,'GRAVEL CO',1) !=0 OR
		StringLib.stringfind(left.NAME2,'GRAVEL ',1) !=0 OR
		StringLib.stringfind(left.NAME2,'MARINE ',1) !=0 OR
		StringLib.stringfind(left.NAME2,'RESERVATION ',1) !=0 OR
		StringLib.stringfind(left.NAME2,'WATER BOARD',1) !=0 OR
		StringLib.stringfind(left.NAME2,'WATER DISTRICT',1) !=0 OR
		StringLib.stringfind(left.NAME2,'WATER TREATMENT',1) !=0 OR
		StringLib.stringfind(left.NAME2,'WATER RESORCES',1) !=0 OR
		StringLib.stringfind(left.NAME2,'FISH COMM',1) !=0 OR
		StringLib.stringfind(left.NAME2,'SHERIFF',1) !=0 OR
		StringLib.stringfind(left.NAME2,'SHERIFF OFFICE',1) !=0 ) AND StringLib.stringfind(left.NAME2,'C/O',1)=0   , ' ' , StringLib.StringToUpperCase(trim(left.NAME2)));
 
   tmp_xname1:=StringLib.StringFindReplace(tmp_xname,'(','');
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
		
               self.concat_name_prev := tmp_xname11; 
               self.name2_format   := if(StringLib.stringfind(tmp_xname11,',',1)!=0 , 'L' , 'U');
    		   self := left)); 
  
ut.Mac_Clean_Dual_Names(fprecelan,concat_name_prev,fprecelanname2,name2_format);

fprecelanname := project(fprecelanname2, transform({Watercraft.layout_or,string concat_name , string70 pname6;
                                       string3  pname6_score;string100 cname6;string70 pname7;
                                       string3  pname7_score;string100 cname7;string70 pname8;
                                       string3  pname8_score;string100 cname8;string70 pname9;
                                       string3  pname9_score;string100 cname9;string70 pname10;
                                       string3  pname10_score;string100 cname10, string1 name2_format,string1 name_format},
            
			     tmp_xname1 := if(( left.NAME2 <> '' AND StringLib.stringfind(trim(left.NAME2),' ',1)=0 ) OR
	       ( left.NAME2[1]='&' OR
		left.NAME2[1..3]='CO 'OR
		StringLib.stringfind(left.NAME2,' CO ',1) !=0 OR
		StringLib.stringfind(left.NAME2,'INC ',1) != 0 OR
		StringLib.stringfind(left.NAME2,'AND RESORT',1) != 0 OR
		StringLib.stringfind(left.NAME2,'AUTHORITY',1) != 0 OR
		StringLib.stringfind(left.NAME2,'CLAIM',1) != 0 OR
		StringLib.stringfind(left.NAME2,'SALVAGE TITLE',1) != 0 OR
		StringLib.stringfind(left.NAME2,'SALVAGE',1) != 0 OR
		StringLib.stringfind(left.NAME2,'LAW ENF',1) != 0 OR
		StringLib.stringfind(left.NAME2,'WILDLIFE',1) != 0 OR
		StringLib.stringfind(left.NAME2,'WASTEWTR RECLMTION',1) != 0 OR
		StringLib.stringfind(left.NAME2,'WASTEWTR ',1) != 0 OR
		StringLib.stringfind(left.NAME2,'ACTIVITIES & RECREATION',1) != 0 OR
		left.NAME2[1..4]='AND ' OR
		StringLib.stringfind(left.NAME2,'CENTER ',1) != 0 OR
		StringLib.stringfind(left.NAME2,'CLUB',1) != 0 OR
		StringLib.stringfind(left.NAME2,'COLLEGE',1) !=0 OR
		StringLib.stringfind(left.NAME2,'COMPANY',1) !=0 OR
		StringLib.stringfind(left.NAME2,'CONSULTANTS',1) !=0 OR
		StringLib.stringfind(left.NAME2,'CONTRACTORS',1) !=0 OR
		StringLib.stringfind(left.NAME2,'DATED ',1) !=0 OR
		StringLib.stringfind(left.NAME2,'COUNCIL ',1) !=0 OR
		StringLib.stringfind(left.NAME2,'COURTHOUSE',1) !=0 OR
		StringLib.stringfind(left.NAME2,'COUNCEL',1) !=0 OR
		StringLib.stringfind(left.NAME2,'DEPT ',1) !=0 OR
		StringLib.stringfind(left.NAME2,'SERVICES',1) !=0 OR
		StringLib.stringfind(left.NAME2,'GENERAL SERV ',1) !=0 OR
		StringLib.stringfind(left.NAME2,'GEOLOGY',1) !=0 OR
		StringLib.stringfind(left.NAME2,'DEPT OF ',1) !=0 OR
		StringLib.stringfind(left.NAME2,'DIVING ',1) !=0 OR
		StringLib.stringfind(left.NAME2,'DIVING & SALVAGE',1) !=0 OR
		StringLib.stringfind(left.NAME2,'DIVISION OF',1) !=0 OR
		StringLib.stringfind(left.NAME2,'DIVISION OF LAW',1) !=0 OR
		StringLib.stringfind(left.NAME2,'LAW ENFORCEMENT',1) !=0 OR
		StringLib.stringfind(left.NAME2,'LAW ENFORC ',1) !=0 OR
		StringLib.stringfind(left.NAME2,'PARKS DEPT',1) !=0 OR
		StringLib.stringfind(left.NAME2,'PARKS & RECREATION',1) !=0 OR
		StringLib.stringfind(left.NAME2,'IRREV TR ',1) !=0 OR
		StringLib.stringfind(left.NAME2,'BEACH ',1) !=0 OR
		StringLib.stringfind(left.NAME2,'CO PARKS',1) !=0 OR
		StringLib.stringfind(left.NAME2,'ENTERPRISES CORP',1) !=0 OR
		StringLib.stringfind(left.NAME2,'ENVIRONMENTAL SER ',1) !=0 OR
		StringLib.stringfind(left.NAME2,'EQUIPMENT CO',1) !=0 OR
		StringLib.stringfind(left.NAME2,'ESTATE & HOLDING',1) !=0 OR
		trim(left.NAME2)='FAMILY TRUST' OR
		StringLib.stringfind(left.NAME2,'FIRE DEPARTMENT',1) !=0 OR
		StringLib.stringfind(left.NAME2,'FIRE PROTECTION',1) !=0 OR
		StringLib.stringfind(left.NAME2,'FISCHER ',1) !=0 OR
		StringLib.stringfind(left.NAME2,'FISH COMMISSION',1) !=0 OR
		StringLib.stringfind(left.NAME2,'FLEET SERVICES',1) !=0 OR
		StringLib.stringfind(left.NAME2,'GRAVEL CO',1) !=0 OR
		StringLib.stringfind(left.NAME2,'GRAVEL ',1) !=0 OR
		StringLib.stringfind(left.NAME2,'MARINE ',1) !=0 OR
		StringLib.stringfind(left.NAME2,'RESERVATION ',1) !=0 OR
		StringLib.stringfind(left.NAME2,'WATER BOARD',1) !=0 OR
		StringLib.stringfind(left.NAME2,'WATER DISTRICT',1) !=0 OR
		StringLib.stringfind(left.NAME2,'WATER TREATMENT',1) !=0 OR
		StringLib.stringfind(left.NAME2,'WATER RESORCES',1) !=0 OR
		StringLib.stringfind(left.NAME2,'FISH COMM',1) !=0 OR
		StringLib.stringfind(left.NAME2,'SHERIFF',1) !=0 OR
		StringLib.stringfind(left.NAME2,'SHERIFF OFFICE',1) !=0 ) AND StringLib.stringfind(left.NAME2,'C/O',1)=0 ,
 	  	trim(StringLib.StringToUpperCase(trim(left.NAME)+' '+trim(left.NAME2))) ,
		StringLib.StringToUpperCase(trim(left.NAME)));
				 
		self.name_format  := if(StringLib.stringfind(tmp_xname1,',JR ',1)!=0  OR 
		   StringLib.stringfind(tmp_xname1,',SR ',1)!=0  OR
		   StringLib.stringfind(tmp_xname1,',I ',1)!=0   OR
		   StringLib.stringfind(tmp_xname1,',II ',1)!=0  OR
		   StringLib.stringfind(tmp_xname1,',III ',1)!=0  OR
		   StringLib.stringfind(tmp_xname1,',IV ',1)!=0 OR 
  	   	   StringLib.stringfind(tmp_xname1,',1ST ',1)!=0 OR
  	   	   StringLib.stringfind(tmp_xname1,',2ND ',1)!=0 OR
  	   	   StringLib.stringfind(tmp_xname1,',2ND ',1)!=0 OR 
		   StringLib.stringfind(tmp_xname1,',3RD ',1)!=0 OR 
		   StringLib.stringfind(tmp_xname1,',',1)!=0 , 'L' , 'U');

		         self.pname6       := left.pname1;
                 self.pname6_score := left.pname1_score;
                 self.cname6       := left.cname1;       
				 self.pname7       := left.pname2;
                 self.pname7_score := left.pname2_score;
                 self.cname7       := left.cname2;
                 self.pname8       := left.pname3;
                 self.pname8_score := left.pname3_score;
                 self.cname8       := left.cname3;
                 self.pname9       := left.pname4;
                 self.pname9_score := left.pname4_score;
                 self.cname9       := left.cname4;
                 self.pname10      := left.pname5;
                 self.pname10_score:= left.pname5_score;
                 self.cname10      := left.cname5;
				 self.concat_name         := tmp_xname1 ; 
				 self := left)); 

ut.Mac_Clean_Dual_Names(fprecelanname,concat_name,fCleanname,name_format);

fCleannameFinal := project( fCleanname, transform({Watercraft.Layout_or_clean_in } , 
                    					
					self.state_origin := 'OR' ;
					self.process_date := watercraft_preprocess.version; 
					self.clean_address := '' ; 
					self := left));
					
export Map_OR_Update := sequential(output(fCleannameFinal,,watercraft.Cluster_In+'in::watercraft_or_'+watercraft_preprocess.version),
								  FileServices.AddSuperFile( watercraft.Cluster_In + 'in::watercraft_or', watercraft.Cluster_In+'in::watercraft_or_'+watercraft_preprocess.version)
								 ) ;