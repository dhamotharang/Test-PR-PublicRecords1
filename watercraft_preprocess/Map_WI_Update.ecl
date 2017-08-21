import watercraft,ut,address,AID,header;

// Translates wi_01.mp

fIn_raw := watercraft_preprocess.Files_raw.wi; 

temp_rec := {Watercraft.layout_wi,string concat_name , string1 name_format}; 

fprecelan := project( fIn_raw, transform({temp_rec}, 

                        tmp_xname1:=StringLib.StringToUpperCase(trim(left.CONTACT));
						tmp_xname2:=regexreplace('@',tmp_xname1,' ');
						tmp_xname3:=regexreplace('C/O',tmp_xname2,' ');
						tmp_xname4:=regexreplace('C/0',tmp_xname3,' ');
						tmp_xname5:=regexreplace('ATTN:',tmp_xname4,' ');
						
					   self.concat_name := tmp_xname5; 
                       self.MODEL := trim(left.MODEL);
                       self.ENGINE_TYPE := trim(left.ENGINE_TYPE);
					   self.name_format := if(StringLib.stringfind(tmp_xname5,',',1)!=0 ,'F' ,'U');
                       self:= left)); 
					   
ut.Mac_Clean_Dual_Names(fprecelan,concat_name,fCleanconcat,name_format);	

fpreBusiness := project(fCleanconcat, transform({Watercraft.layout_wi,
                                      string70 CONTACT_pname1, string3  CONTACT_pname1_score,
                                      string70 CONTACT_cname1, string70 CONTACT_pname2 ,string3 CONTACT_pname2_score , string concat_business, string name_format} , 
                       
					   temp_xname1 := StringLib.StringToUpperCase(trim(left.BUSINESS));
										tmp_xname2:=regexreplace('@',temp_xname1,' ');
										tmp_xname3:=regexreplace('C/O',tmp_xname2,' ');
										tmp_xname4:=regexreplace('C/0',tmp_xname3,' ');
										tmp_xname5:=regexreplace('ATTN:',tmp_xname4,' ');
  
					   self.concat_business      := tmp_xname5; 
					   self.name_format          :=  if(StringLib.stringfind(tmp_xname5,',',1)!=0 , 'F' ,'U');
					   self.CONTACT_pname1       := left.pname1 ; 
					   self.CONTACT_pname1_score := left.pname1_score; 
					   self.CONTACT_cname1       := left.cname1; 
					   self.CONTACT_pname2       := left.pname2; 
					   self.CONTACT_pname2_score := left.pname2_score; 
					   self:= left)); 

ut.Mac_Clean_Dual_Names(fpreBusiness,concat_business,fCleanbusiness,name_format);	

fprename := project(fCleanbusiness, transform({Watercraft.layout_wi,
                                      string70 CONTACT_pname1, string3  CONTACT_pname1_score,
                                      string70 CONTACT_cname1, string70 CONTACT_pname2 ,string3 CONTACT_pname2_score , 
									  string70 BUSINESS_pname1,
									  string3  BUSINESS_pname1_score, 
									  string70 BUSINESS_cname1,
									  string70 BUSINESS_pname2,
                                      string3  BUSINESS_pname2_score,
									  string concat_pname, string name_format} , 
                       
					    tmp_xname1 := StringLib.StringToUpperCase(
	                    trim(left.FIRST_NAME)+' '+trim(left.MID)+' '+trim(left.LAST_NAME));
						tmp_xname2:=regexreplace('@',tmp_xname1,' ');
						tmp_xname3:=regexreplace('C/O',tmp_xname2,' ');
						tmp_xname4:=regexreplace('C/0',tmp_xname3,' ');
						tmp_xname5:=regexreplace('ATTN:',tmp_xname4,' ');
  
					   self.concat_pname      := tmp_xname5; 
					   self.name_format          :=  if(StringLib.stringfind(tmp_xname5,',',1)!=0 , 'F' ,'U');
					   self.BUSINESS_pname1       := left.pname1 ; 
					   self.BUSINESS_pname1_score := left.pname1_score; 
					   self.BUSINESS_cname1       := left.cname1; 
					   self.BUSINESS_pname2       := left.pname2; 
					   self.BUSINESS_pname2_score := left.pname2_score; 
					   self:= left)); 

ut.Mac_Clean_Dual_Names(fprename,concat_pname,fCleanname,name_format);	

fCleannameFinal := project( fCleanname, transform({Watercraft.Layout_wi_clean_in } , 
                    					
					self.state_origin := 'WI' ;
					self.process_date := watercraft_preprocess.version; 
					self.clean_address := '' ; 
					self.LAST_TRANSACTION_DATE := if(trim(left.LAST_TRANSACTION_DATE)[1] = '0','20'+trim(left.LAST_TRANSACTION_DATE),trim(left.LAST_TRANSACTION_DATE));
                    /*out.clean_address :: address_sixline(
                     in.ADDRESS_1,
					in.ADDRESS2,
						' ',
                     in.CITY,
					in.STATE,
					in.ZIP);*/ 

					self := left));
					
export Map_WI_Update := sequential(output(fCleannameFinal,,watercraft.Cluster_In+'in::watercraft_wi_'+watercraft_preprocess.version),
								  FileServices.AddSuperFile( watercraft.Cluster_In + 'in::watercraft_wi', watercraft.Cluster_In+'in::watercraft_wi_'+watercraft_preprocess.version)
								 ) ;