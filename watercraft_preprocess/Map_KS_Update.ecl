import watercraft,ut,address,AID,header,watercraft_preprocess;

// translates  ks_phase01.mp Ab intio graph into ECL 

fIn_raw := watercraft_preprocess.Files_raw.KS ; 

// Clean names 		
fpreNametype := project(fIn_raw,transform({fIn_raw, string t_concat_name}, 

                     self.t_concat_name := watercraft_preprocess.fn_concat_name_KS(left.first_name,left.last_name); 
                     self                 := left));

Address.Mac_Is_Business(fpreNametype,t_concat_name,fNametype,name_type);

fclean := project(fNametype , transform({watercraft.Layout_KS_clean_in}, 
                      
					  self.state_origin    := 'KS' ; 
					  Self.process_date    := watercraft_preprocess.version ;  
                      self.clean_pname     := if(left.name_type <>'B',Address.CleanPersonFML73(left.t_concat_name),'');
					  self.clean_cname     := if(left.name_type = 'B', Mod_Clean_Entities.cleanCompany(left.t_concat_name) ,''); 
                      self.clean_address   := '' ; 
					  self.concat_name     := left.t_concat_name;
                      self.is_company_flag := if( left.name_type ='B', 1,0); 
				      self := left )); 
					  
export Map_KS_Update := sequential(output(fclean,,watercraft.Cluster_In+'in::watercraft_KS_'+watercraft_preprocess.version),
								  FileServices.AddSuperFile( watercraft.Cluster_In + 'in::watercraft_KS', watercraft.Cluster_In+'in::watercraft_KS_'+watercraft_preprocess.version)
								  ) ;

								  