import watercraft,ut,address,AID,header,address;

// translates mn_phase01_update.mp Ab intio graph into ECL this state non updating from 2006

fIn_raw := watercraft_preprocess.Files_raw.mn ; 

temp_rec := {Watercraft.layout_mn,string1 name_format}; 

fprecelan := project( fIn_raw, transform({temp_rec}, 
              
			   tmp_xname1:=watercraft_preprocess.Mod_Clean_Entities.TrimandUp(left.NAME);
			   tmp_xname2:=regexreplace(tmp_xname1,',JR',' JR');
			   tmp_xname3:=regexreplace(tmp_xname2,',SR',' SR');
			   tmp_xname4:=regexreplace(tmp_xname3,',III',' III');
               tmp_xname5:=regexreplace(tmp_xname4,',3RD',' 3RD');
			   
               self.name :=tmp_xname5 ; 
               self.name_format := if(StringLib.stringfind(tmp_xname5,',',1)!=0 , 'L' , 'U');
     		   self := left));

ut.Mac_Clean_Dual_Names(fprecelan,name,fcelanDname,name_format);

fcelanname := project(fcelanDname , transform({ Watercraft.Layout_mn_clean_in }, 
                         self.state_origin := 'MN'; 
				         self.process_date := watercraft_preprocess.version;
						 self.clean_address := ''; 
						 self := left 
						 )); 
						 
export Map_MN_Update := sequential(output(fcelanname,,watercraft.Cluster_In+'in::watercraft_mn_'+watercraft_preprocess.version),
								  FileServices.AddSuperFile( watercraft.Cluster_In + 'in::watercraft_mn', watercraft.Cluster_In+'in::watercraft_mn_'+watercraft_preprocess.version)
								  ) ;