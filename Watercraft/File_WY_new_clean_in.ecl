import Address;

_File_WY_new_sprayed_in := 
dataset(watercraft.Cluster_In + 'in::watercraft_wy_new', watercraft.Layout_WY_new, flat);

//Clean coowner name and prevous owner names
//from 'NA' and 'N/A' tags

_PreCleanedNames := PROJECT(_File_WY_new_sprayed_in,
                                      transform(RECORDOF(_File_WY_new_sprayed_in),
									            BOOLEAN is_dirty(STRING name_in) := regexfind('^NA$|^N/A$|^SAME[*, /]*|^SAME$',TRIM(StringLib.StringToUpperCase(name_in),LEFT,RIGHT)); 
									            												
												SELF.coownername  := if(is_dirty(LEFT.coownername),'',LEFT.coownername);
											    SELF.coownerfname  := if(is_dirty(LEFT.coownerfname),'',LEFT.coownerfname);
												SELF.coownerlname  := if(is_dirty(LEFT.coownerlname),'',LEFT.coownerlname);
												SELF.coownermname  := if(is_dirty(LEFT.coownermname),'',LEFT.coownermname);
												SELF.prevownername := if(is_dirty(LEFT.prevownername),'',LEFT.prevownername);
											    SELF.prevownerfname  := if(is_dirty(LEFT.prevownerfname),'',LEFT.prevownerfname);
												SELF.prevownerlname  := if(is_dirty(LEFT.prevownerlname),'',LEFT.prevownerlname);
												SELF.prevownermname  := if(is_dirty(LEFT.prevownermname),'',LEFT.prevownermname);
												SELF := LEFT;));
											   



_CleanedNames := PROJECT (_PreCleanedNames,
                              transform(Watercraft.Layout_WY_new_clean_in,
							        
									    BOOLEAN NotAPerson(STRING lnm,
										                   STRING fnm,
														   STRING mnm) := 
										   TRIM(lnm,left,right) + 
										   TRIM(fnm,left,right) +
										   TRIM(mnm,left,right) = '';
								   					         				
																	
								         SELF.State_Origin := 'WY';
										 SELF.Process_Date := StringLib.GetDateYYYYMMDD();
										 
                                         SELF.owner_pname := IF(NotAPerson(LEFT.last_nm,LEFT.first_nm,LEFT.mid_nm),'',Address.CleanPersonLFM73_fields(LEFT.name).full_name);
                                         SELF.owner_pname_score := IF(NotAPerson(LEFT.last_nm,LEFT.first_nm,LEFT.mid_nm),'',Address.CleanPersonLFM73_fields(LEFT.name).name_score); 
                                         SELF.cname1 := IF(NotAPerson(LEFT.last_nm,LEFT.first_nm,LEFT.mid_nm),LEFT.name,'');
                                         
										 SELF.coowner_pname := IF(NotAPerson(LEFT.coownerlname,LEFT.coownerfname,LEFT.coownermname),'',Address.CleanPersonLFM73_fields(LEFT.coownername).full_name);
                                         SELF.coowner_pname_score := IF(NotAPerson(LEFT.coownerlname,LEFT.coownerfname,LEFT.coownermname),'',Address.CleanPersonLFM73_fields(LEFT.coownername).name_score);
                                         SELF.cname2 := IF(NotAPerson(LEFT.coownerlname,LEFT.coownerfname,LEFT.coownermname),LEFT.coownername,'');
                                      
									     SELF.prevowner_pname := IF(NotAPerson(LEFT.prevownerlname,LEFT.prevownerfname,LEFT.prevownermname),'',Address.CleanPersonLFM73_fields(LEFT.prevownername).full_name);
                                         SELF.prevowner_pname_score := IF(NotAPerson(LEFT.prevownerlname,LEFT.prevownerfname,LEFT.prevownermname),'',Address.CleanPersonLFM73_fields(LEFT.prevownername).name_score);
                                         SELF.cname3 := IF(NotAPerson(LEFT.prevownerlname,LEFT.prevownerfname,LEFT.prevownermname),LEFT.prevownername,'');
                                         
										 SELF.clean_address := Address.cleanaddress182(LEFT._ADDRESS, address.Addr2FromComponents(LEFT.CITY, LEFT.STATE, LEFT.ZIP));
										 SELF := LEFT;)
						   ); 








export File_WY_new_clean_in := _CleanedNames; 