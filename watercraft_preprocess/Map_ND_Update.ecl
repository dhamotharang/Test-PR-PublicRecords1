import watercraft,ut,address,AID,header,watercraft_preprocess;

// translates  nd_phase01.mp Ab intio graph into ECL 
fIn_raw := watercraft_preprocess.Files_raw.ND ; 

fnameRef := project(fIn_raw , transform({fIn_raw, string100 temp_name} , 

            self.temp_name:= StringLib.StringFindReplace(trim(left.NAME,left,right), ' MRS ', ' ');
            self := left)); 

Address.Mac_Is_Business(fnameRef,temp_name,fNametype,name_type);
  
fclean := project(fNametype , transform({watercraft.Layout_ND_clean_in}, 
                      
					  self.state_origin    := 'ND' ; 
					  Self.process_date    := watercraft_preprocess.version ;  
                      self.clean_pname     := if(left.name_type <>'B',Address.CleanPersonLFM73(left.temp_name),'');
					  self.clean_cname     := if(left.name_type = 'B', Mod_Clean_Entities.cleanCompany(left.temp_name) ,''); 
                      self.clean_address   := '' ; 
                      self.is_company_flag := if(left.name_type ='B', 1,0); 
				      self := left )); 
					  

export Map_ND_Update := sequential(output(fclean,,watercraft.Cluster_In+'in::watercraft_nd_'+watercraft_preprocess.version),
								  FileServices.AddSuperFile( watercraft.Cluster_In + 'in::watercraft_nd', watercraft.Cluster_In+'in::watercraft_nd_'+watercraft_preprocess.version),
								  FileServices.ClearSuperFile('~thor_data::in::watercraft_raw_nd')) ;
