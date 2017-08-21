import watercraft,ut,address,AID,header,address;

// translates wv_01_2.mp Ab intio graph into ECL

fIn_raw := watercraft_preprocess.Files_raw.wv ; 

temp_rec := {Watercraft.layout_wv,string1 name_format}; 

fprecelan := project( fIn_raw, transform({temp_rec}, 
               self.name := watercraft_preprocess.fn_remove_etal_WV(watercraft_preprocess.Mod_Clean_Entities.TrimandUp(left.name)); 
               self.name_format := if(StringLib.stringfind(left.name,',',1)!=0 , 'L' , 'U');
     		   self := left));

ut.Mac_Clean_Dual_Names(fprecelan,name,fcelanDname,name_format);

fcelanname := project(fcelanDname , transform({ Watercraft.Layout_wv_clean_in }, 
                         self.state_origin := 'WV'; 
				         self.process_date := watercraft_preprocess.version;
						 self.clean_address := ''; 
						 self := left 
						 )); 
						 
export Map_WV_Update := sequential(output(fcelanname,,watercraft.Cluster_In+'in::watercraft_wv_'+watercraft_preprocess.version),
								  FileServices.AddSuperFile( watercraft.Cluster_In + 'in::watercraft_wv', watercraft.Cluster_In+'in::watercraft_wv_'+watercraft_preprocess.version)
								  ) ;
