import watercraft,ut,address,AID,header,idl_header;

// translates co_phase01.mp Ab intio graph into ECL 

fIn_raw := watercraft_preprocess.Files_raw.CO ; 

Address.Mac_Is_Business_Parsed(	fIn_raw,fPreclean,FIRST_NAME,MID,LAST_NAME,'',,name_type);

// Clean name 
		
fClean_name := project(fPreclean,transform({Watercraft.Layout_CO_clean_in}, 

                      string100 temp_name  := trim(left.FIRST_NAME,left,right)+' '+trim(left.LAST_NAME,left,right);
                      
					  self.clean_pname    := if(left.name_type <>'B' /*or left.LAST_NAME in ['WILCUTTS','MOONEY', 'LEAQUE','MARTINEZ','NATION']*/, 
					                          if((StringLib.StringFind(left.FIRST_NAME,' JR ',1)!=0 or StringLib.StringFind(left.FIRST_NAME,' SR ',1)!=0),
					                          Address.CleanPersonLFM73(trim(left.LAST_NAME,left,right)+', '+trim(left.FIRST_NAME,left,right)),
					                          Address.CleanPersonFML73(temp_name)),
					                          '');
					  self.clean_cname     := if(left.name_type = 'B' /*and left.LAST_NAME not in ['WILCUTTS','MOONEY', 'LEAQUE','MARTINEZ','NATION']*/ ,Mod_Clean_Entities.cleanCompany(temp_name),''); 
					  self.clean_address   := '' ; 
					  self.process_date    :=watercraft_preprocess.version;
					  self.state_origin    := 'CO' ;
					  self.is_company_flag := if(left.name_type='B', 1, 0); 
					  self.address_1       := if(trim(left.address_1,left,right)[1..3] = 'C/O' , REGEXREPLACE(left.address_1,'C/O', '')
											  , trim(left.address_1,left,right));
     				  self                 := left));

export Map_CO_Update := sequential(output(fClean_name,,watercraft.Cluster_In+'in::watercraft_co_'+watercraft_preprocess.version),
								  FileServices.AddSuperFile( watercraft.Cluster_In + 'in::watercraft_co', watercraft.Cluster_In+'in::watercraft_co_'+watercraft_preprocess.version)
								  ) ;

