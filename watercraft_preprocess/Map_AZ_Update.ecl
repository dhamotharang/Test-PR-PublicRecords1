import watercraft,ut,address,AID,header,watercraft_preprocess;

// translates az_update.mp Ab intio graph into ECL 

fIn_raw := watercraft_preprocess.Files_raw.AZ ; 

rAdd_date :={ string2 state_origin, string8 process_date, Watercraft.layout_AZ} ; 

fAddate := project(fIn_raw , transform({rAdd_date},
										 self.process_date :=watercraft_preprocess.version,
										 self.state_origin := 'AZ'; 
   string50 v_new_first_name   := if(StringLib.StringFind(left.first_name, '&',1) = 0 and 
	                                  StringLib.StringFind(left.first_name, 'COMPANY',1) = 0 and 
	                                   StringLib.StringFind(left.first_name, ' CO ',1) = 0 and 
	                                    StringLib.StringFind(left.first_name, ' INC',1) = 0 , 
	                                     StringLib.StringFilterOut(left.first_name,'*') , ''); 
   
   string15 v_new_mid         := if(regexfind('[a-zA-Z]',left.mid) = true and
	                                StringLib.StringFind(left.mid, '&',1) = 0 and
	                                 StringLib.StringFind(left.mid, 'COMPANY',1) = 0 and
	                                  StringLib.StringFind(left.mid, 'CO ',1) = 0 and
	                                   StringLib.StringFind(left.mid, 'INC',1) = 0, 
	                                    StringLib.StringFilterOut(left.mid,'*') , ''); 
	
   string50 v_new_last_name   :=  StringLib.StringFilterOut(left.last_name,'*');

   string2 v_new_suffix       := if( trim(left.suffix,left,right) in ['I', 'II','III',
                                    'IV', 'V','VI', 'MD','JR', 'SR'], left.suffix , '');     

   string75 v_new_address_1   := if(StringLib.StringFind(left.address_1,'C/O',1) = 0  , trim(left.address_1,left,right), 
	                              if(regexfind('^[0-9]',trim(left.address_1,left,right)), trim(left.address_1,left,right)[1 ..StringLib.StringFind(left.address_1,'C/O',1)] ,  
	                                if(trim(left.address_1,left,right)[1..3] = 'C/O' , REGEXREPLACE(left.address_1,'C/O', '') ,
	                                  if(StringLib.StringFilterOut(StringLib.StringToUpperCase(left.address_1), ' ')[1..5] = 'POBOX' , trim(left.address_1,left,right)[1..StringLib.StringFind(left.address_1,'C/O',1)], 
								        ''))));
									
   string100 v_new_name       := if(left.first_name<>'', trim(left.first_name,left,right)+' ' ,  '') +
	                                 if(left.mid <>'',trim(left.mid)+ ' ', '')+ trim(left.last_name,left,right)+ trim(v_new_suffix,left,right);
			 
   self.first_name            := v_new_first_name;
   self.mid                   := v_new_mid;
   self.last_name             := v_new_last_name;
   self.suffix                := v_new_suffix;
   self.name                  := v_new_name;
   self.Address_1             := v_new_address_1;	
   self                       := left)); 

// Add name_type 

Address.Mac_Is_Business_Parsed(	fAddate,fPreclean,FIRST_NAME,MID,LAST_NAME,SUFFIX,,name_type);

// Clean names 		
fClean_name := project(fPreclean,transform({watercraft.Layout_AZ_clean_in}, 
           
                      self.pname1          := if(left.name_type not in [ 'B','U'],Address.CleanPersonFML73(left.name),'');
					  self.pname2          := '' ; 
					  self.cname1          := if(left.name_type in [ 'B','U'] , Mod_Clean_Entities.cleanCompany(left.name) ,''); 
					  self.cname2          := '';
                      self.clean_address   := '' ; 
					  self                 := left));

									
export Map_AZ_Update:= sequential(output(fClean_name,,watercraft.Cluster_In+'in::watercraft_az_'+watercraft_preprocess.version),
								  FileServices.AddSuperFile( watercraft.Cluster_In + 'in::watercraft_az', watercraft.Cluster_In+'in::watercraft_az_'+watercraft_preprocess.version)
								  ) ;


