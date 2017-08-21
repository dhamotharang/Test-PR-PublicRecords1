import watercraft,ut,address,AID,header,address;

// translates va_01.mp Ab intio graph into ECL

fIn_raw := watercraft_preprocess.Files_raw.va ; 

temp_rec := {Watercraft.layout_va,string1 name_format}; 

fprecelan := project( fIn_raw, transform({temp_rec,string100 concat_name}, 
               self.concat_name := watercraft_preprocess.Mod_Clean_Entities.TrimandUp(watercraft_preprocess.fn_concat_name_va(left.FIRST_NAME , left.LAST_NAME, left.MID)); 
               self.name_format := if(StringLib.stringfind(left.name,',',1)!=0 , 'L' , 'U');
     		   self := left));

ut.Mac_Clean_Dual_Names(fprecelan,concat_name,fcelanDname,name_format);

fcelanname := project(fcelanDname , transform({ Watercraft.Layout_va_clean_in }, 
                         self.state_origin := 'VA'; 
				         self.process_date := watercraft_preprocess.version;
						 self.clean_address := ''; 
						 self := left 
						 )); 
						 
export Map_VA_Update := sequential(output(fcelanname,,watercraft.Cluster_In+'in::watercraft_va_'+watercraft_preprocess.version),
								  FileServices.AddSuperFile( watercraft.Cluster_In + 'in::watercraft_va', watercraft.Cluster_In+'in::watercraft_va_'+watercraft_preprocess.version)
								  ) ;

