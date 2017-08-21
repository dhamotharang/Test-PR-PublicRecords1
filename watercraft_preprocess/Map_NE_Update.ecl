import watercraft,ut,address,AID,header;

// Translates ne_phase01_update.mp

fIn_raw := watercraft_preprocess.Files_raw.NE; 

temp_rec := {Watercraft.layout_NE,string concat_name_prev , string1 name2_format}; 

fprecelan := project( fIn_raw, transform({temp_rec}, 

                  tmp_xname2:=StringLib.StringToUpperCase(trim(left.Previous_Owner,left,right));
   tmp_xname3:=StringLib.StringFindReplace(tmp_xname2,'(','');
   tmp_xname4:=StringLib.StringFindReplace(tmp_xname3,')','');
   tmp_xname5:=StringLib.StringFindReplace(tmp_xname4,'DECEASED','');
   tmp_xname6:=StringLib.StringFindReplace(tmp_xname5,'DECD','');
   tmp_xname7:=StringLib.StringFindReplace(tmp_xname6,'DIV DEC','');
   tmp_xname8:=StringLib.StringFindReplace(tmp_xname7,'POD','');
   tmp_xname9:=StringLib.StringFindReplace(tmp_xname8,'DEA CERT','');
   tmp_xname10:=StringLib.StringFindReplace(tmp_xname9,'AFFID OF REPO','');
   tmp_xname11:=StringLib.StringFindReplace(tmp_xname10,'AFFD OF DEC','');
   tmp_xname12:=StringLib.StringFindReplace(tmp_xname11,'REPO','');
               self.concat_name_prev := tmp_xname12; 
               self.name2_format   := if(StringLib.stringfind(tmp_xname12,',',1)!=0 , 'L' , 'U');


     		   self := left)); 
  
ut.Mac_Clean_Dual_Names(fprecelan,concat_name_prev,fprecelanname2,name2_format);

fprecelanname := project(fprecelanname2, transform({Watercraft.layout_NE,string concat_name , string70 pname6;
                                       string3  pname6_score;string100 cname6;string70 pname7;
                                       string3  pname7_score;string100 cname7;string70 pname8;
                                       string3  pname8_score;string100 cname8;string70 pname9;
                                       string3  pname9_score;string100 cname9;string70 pname10;
                                       string3  pname10_score;string100 cname10, string1 name2_format,string1 name_format},
            
			   tmp_xname1 := regexreplace('3/4/75',StringLib.StringToUpperCase(trim(left.NAME)),' '); 
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
		   StringLib.stringfind(tmp_xname1,',',1)!=0 ,'L' , 'U');
				 self := left)); 

ut.Mac_Clean_Dual_Names(fprecelanname,concat_name,fCleanname,name_format);

fCleannameFinal := project( fCleanname, transform({Watercraft.Layout_NE_clean_in } , 
                    					
					self.state_origin := 'NE' ;
					self.process_date := watercraft_preprocess.version; 
					self.clean_address := '' ; 
					self := left));
					
export Map_NE_Update := sequential(output(fCleannameFinal,,watercraft.Cluster_In+'in::watercraft_ne_'+watercraft_preprocess.version),
								  FileServices.AddSuperFile( watercraft.Cluster_In + 'in::watercraft_ne', watercraft.Cluster_In+'in::watercraft_ne_'+watercraft_preprocess.version)
								 ) ;