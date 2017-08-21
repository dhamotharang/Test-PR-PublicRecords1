import watercraft,ut,address,AID,header,address;

// translates ga_phase01.mp Ab intio graph into ECL

fIn_raw := watercraft_preprocess.Files_raw.ga ; 

temp_rec := {Watercraft.layout_ga,string100 concat_name ,string1 name_format}; 

fprecelan := project( fIn_raw, transform({temp_rec}, 
               self.concat_name := watercraft_preprocess.Mod_Clean_Entities.TrimandUp(watercraft_preprocess.fn_concat_name_GA(left.first_name,left.last_name,left.mid,left.suffix)); 
               self.name_format := if(StringLib.stringfind(left.name,',',1)!=0 , 'F' , 'U');
     		  // self.STATE_PURCH := '';
			   self := left));
			   
ut.Mac_Clean_Dual_Names(fprecelan,concat_name,fcelanDname,name_format);

fcelanname := project(fcelanDname , transform({ Watercraft.Layout_ga_clean_in }, 
                         self.state_origin := 'GA'; 
				         self.process_date := watercraft_preprocess.version;
						 self.clean_address := ''; 
						 self := left 
						 )); 
export Map_GA_Update := sequential(output(fcelanname,,watercraft.Cluster_In+'in::watercraft_ga_'+watercraft_preprocess.version),
								  FileServices.AddSuperFile( watercraft.Cluster_In + 'in::watercraft_ga', watercraft.Cluster_In+'in::watercraft_ga_'+watercraft_preprocess.version)
								  ) ;