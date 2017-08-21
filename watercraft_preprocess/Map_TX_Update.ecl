import watercraft,ut,address,AID,header,watercraft_preprocess;

// translates  tx_phase01.mp Ab intio graph into ECL 

fIn_raw := watercraft_preprocess.Files_raw.TX ; 

fnameRef := project(fIn_raw , transform({fIn_raw} , 
                     self.name :=if(left.PRIMARY_OWNER_COMPANY <>'', left.PRIMARY_OWNER_COMPANY , trim(regexreplace(' +',left.LAST_NAME+left.FIRST_NAME+left.MID+left.PRIMARY_OWNER_SUFFIX,' '),left,right));
					 self := left)); 

fnameRef_0   :=  fnameRef(trim(FIRST_NAME,left,right) = '&'); 
fnameRef_0_1 :=  fnameRef(trim(FIRST_NAME,left,right) <> '&'); 

fnameRef_1   := fnameRef_0_1(trim(FIRST_NAME,left,right) = '' AND trim(PRIMARY_OWNER_COMPANY,left,right)='' AND trim(LAST_NAME,left,right)<>''); 
fnameRef_1_1 := fnameRef_0_1(~(trim(FIRST_NAME,left,right) = '' AND trim(PRIMARY_OWNER_COMPANY,left,right)='' AND trim(LAST_NAME,left,right)<>'')); 

fnameRef_2   := fnameRef_1_1(trim(PRIMARY_OWNER_COMPANY,left,right) <>'');
fnameRef_2_1 := fnameRef_1_1(trim(PRIMARY_OWNER_COMPANY,left,right) ='');

fnameRef_3 :=  fnameRef_2_1 ; 

fnameRefClean0 := project(fnameRef_0 , transform({watercraft.layout_TX_clean_in},
                     self.state_origin := 'TX'; 
					 self.process_date := watercraft_preprocess.version ; 
					 self.pname := '';
                     self.cname := trim(regexreplace(' +',left.LAST_NAME+left.FIRST_NAME+left.MID,' '),left,right);
					 self.clean_address := ''; 
                     self := left )); 
					 
fnameRefClean1 := project(fnameRef_1 , transform({watercraft.layout_TX_clean_in},
                      cat_name := watercraft_preprocess.Mod_Clean_Entities.concat_name('','',left.MID,left.LAST_NAME,left.PRIMARY_OWNER_SUFFIX); 
                      v_pname := if(StringLib.StringFind(left.LAST_NAME,'_',1)!=0 , Address.CleanPersonLFM73(left.LAST_NAME), if(trim(left.MID,left,right)<>'', Address.CleanPersonFML73(cat_name) , ''));
      				  self.state_origin := 'TX'; 
					  self.process_date := watercraft_preprocess.version ; 
                      self.pname := v_pname;
                      self.cname := if(trim(v_pname,left,right)='' , left.LAST_NAME , '');
                      self.clean_address := ''; 
                      self := left ));

fnameRefClean2 := project(fnameRef_2 , transform({watercraft.layout_TX_clean_in},
                      self.state_origin := 'TX'; 
					  self.process_date := watercraft_preprocess.version ; 
                      self.pname := '';
                      self.cname := left.PRIMARY_OWNER_COMPANY; 
                      self.clean_address := ''; 
                      self := left ));
					  
fnameRefClean3 := project(fnameRef_3 , transform({watercraft.layout_TX_clean_in},
                      self.state_origin := 'TX'; 
					  self.process_date := watercraft_preprocess.version ; 
                      self.pname :=  Address.CleanPersonFML73(watercraft_preprocess.Mod_Clean_Entities.concat_name('',left.FIRST_NAME,left.MID,left.LAST_NAME,left.PRIMARY_OWNER_SUFFIX));
                      self.cname := ''; 
                      self.clean_address := ''; 
                      self := left ));

fnameRefClean3_1 :=fnameRefClean3((integer)pname[71..73]>=75 OR trim(PRIMARY_OWNER_SUFFIX,left,right)<>'');
fnameRefClean3_2:= project(fnameRefClean3(~((integer)pname[71..73]>=75 OR trim(PRIMARY_OWNER_SUFFIX,left,right)<>'')) , transform({watercraft.layout_TX_clean_in}, 

                         self.pname := '';
                         self.cname := trim(regexreplace(' +',left.LAST_NAME+left.FIRST_NAME+left.MID,' '));
                         self := left)); 
		  
fclean := fnameRefClean0+ fnameRefClean1+ fnameRefClean2+ fnameRefClean3_1+fnameRefClean3_2; 

export Map_TX_Update := sequential(output(fclean,,watercraft.Cluster_In+'in::watercraft_tx_'+watercraft_preprocess.version),
								  FileServices.AddSuperFile( watercraft.Cluster_In + 'in::watercraft_tx', watercraft.Cluster_In+'in::watercraft_tx_'+watercraft_preprocess.version)
								  ) ;
