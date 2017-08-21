import watercraft,ut,address,AID,header,address;

//ny_phase01_update.mp // parsing % not done 

fIn_raw := watercraft_preprocess.Files_raw.ny ; 

temp_rec := {Watercraft.layout_ny,string130 concat_name, string1 name_format}; 

fprecelan := project( fIn_raw, transform({temp_rec}, 
               self.concat_name := watercraft_preprocess.Mod_Clean_Entities.TrimandUp(watercraft_preprocess.fn_concat_name_NY(left.name,left.name2)); 
               self.name_format := if(StringLib.stringfind(left.name,',',1)!=0 , 'L' , 'U');
     		   self := left));

ut.Mac_Clean_Dual_Names(fprecelan,concat_name,fcelanDname,name_format);

fcelanname := project(fcelanDname , transform({ Watercraft.Layout_ny_clean_in }, 
                         self.state_origin := 'NY'; 
				         self.process_date := watercraft_preprocess.version;
						 self.clean_address := ''; 
						 self := left 
						 )); 
						 
export Map_NY_Update := sequential(output(fcelanname,,watercraft.Cluster_In+'in::watercraft_ny_'+watercraft_preprocess.version),
								  FileServices.AddSuperFile( watercraft.Cluster_In + 'in::watercraft_ny', watercraft.Cluster_In+'in::watercraft_ny_'+watercraft_preprocess.version)
								  ) ;
