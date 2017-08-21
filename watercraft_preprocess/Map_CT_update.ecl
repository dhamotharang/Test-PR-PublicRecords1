import watercraft,ut,address,AID,header,idl_header,watercraft_preprocess;

// translates  ct_phase01.mp Ab intio graph into ECL 

fIn_raw := watercraft_preprocess.Files_raw.CT ; 

temp_rec := {Watercraft.layout_CT,string1 name_type}; 

fprecelan := project( fIn_raw, transform({temp_rec}, 
               self.name_type   := if(StringLib.StringFind(left.NAME,',',1)!=0 , 'L' , 'U');
     		   self := left)); 
  
ut.Mac_Clean_Dual_Names(fprecelan,name,fprecelanout,name_type,true); 

outfile := project(fprecelanout,  transform({watercraft.Layout_CT_clean_in}, 
                self.state_origin   := 'CT'; 
				self.process_date  := watercraft_preprocess.version; 
                self.clean_address := ''; 
                self := left)); 
				
export Map_CT_update := sequential(output(outfile,,watercraft.Cluster_In+'in::watercraft_ct_'+watercraft_preprocess.version),
								  FileServices.AddSuperFile( watercraft.Cluster_In + 'in::watercraft_ct', watercraft.Cluster_In+'in::watercraft_ct_'+watercraft_preprocess.version)
								  ) ;