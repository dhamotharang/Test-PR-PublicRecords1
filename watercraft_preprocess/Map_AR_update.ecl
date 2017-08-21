import watercraft,ut,address,AID,header;

//ar_sekhar_phase01_update.mp
fIn_raw := watercraft_preprocess.Files_raw.AR ; 

temp_rec := {Watercraft.layout_AR,string1 name_format}; 

fprecelan := project( fIn_raw, transform({temp_rec}, 
               self.name_format   := if(StringLib.StringFind(left.name2,',',1)!=0 , 'L' , 'U');
     		   self := left)); 
  
ut.Mac_Clean_Dual_Names(fprecelan,name2,fprecelanname2,name_format);

fprecelanname := project(fprecelanname2, transform({Watercraft.layout_AR,string70 pname6;
                                       string3  pname6_score;string100 cname6;string70 pname7;
                                       string3  pname7_score;string100 cname7;string70 pname8;
                                       string3  pname8_score;string100 cname8;string70 pname9;
                                       string3  pname9_score;string100 cname9;string70 pname10;
                                       string3  pname10_score;string100 cname10, string1 name_format},
            
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
				 self.name_format   := if(StringLib.StringFind(left.name,',',1)!=0 , 'L' , 'U');
				 self := left)); 

ut.Mac_Clean_Dual_Names(fprecelanname,name,fCleanname,name_format);

fCleannameFinal := project( fCleanname, transform({Watercraft.Layout_AR_clean_in } , 
                    					
					self.state_origin := 'AR' ;
					self.process_date := watercraft_preprocess.version; 
					self.clean_address := '' ; 
					self := left)); 
					
export Map_AR_update := sequential(output(fCleannameFinal,,watercraft.Cluster_In+'in::watercraft_ar_'+watercraft_preprocess.version),
								  FileServices.AddSuperFile( watercraft.Cluster_In + 'in::watercraft_ar', watercraft.Cluster_In+'in::watercraft_ar_'+watercraft_preprocess.version)
								 ) ;
