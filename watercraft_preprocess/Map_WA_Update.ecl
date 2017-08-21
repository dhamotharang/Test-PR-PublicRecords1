import watercraft,ut,address,AID,header,address,watercraft_preprocess, Data_Services, NID;


//fIn_raw :=watercraft_preprocess.Files_raw.wa;
fIn_raw	:= dataset(Data_Services.Data_location.Prefix('NONAMEGIVEN')+ 'thor_data::in::watercraft_raw_wa', Watercraft.layout_wa, flat); 

//blank bad reg_owner2 names
//blank bad reg_owner2 names
fixreg_own2 := project(fIn_raw ,transform( {fIn_raw, string concat_name, string name_format}, 
                                   t_Reg_Owner_Name_2 := if(stringlib.stringfilterout( left.Reg_Owner_Name_2, '#-0123456789')= '', '', left.Reg_Owner_Name_2); 
                                   self.concat_name := if(stringlib.stringfind( left.Reg_Owner_Name_2,',',1)>0, trim(left.name,left,right) +' AND ' + trim(t_Reg_Owner_Name_2), 
																	                      trim(left.name,left,right) +' ' + trim(t_Reg_Owner_Name_2));              
																	 self.name_format := if(StringLib.stringfind(self.concat_name,',',1)!=0 , 'L' , 'U');
																	 self:= left )); 
																	

NID.Mac_CleanFullNames(fixreg_own2,fcleanDname,concat_name,includeInRepository:=false,_nameorder := name_format);

person_flags	:= ['P', 'D'];
Bus_flags   	:= ['B', 'U', 'T', 'I']; 
fclean := project(fcleanDname , transform({Watercraft.layout_wa_clean_in}, 

        self.state_origin := 'WA'; 
				self.process_date := watercraft_preprocess.version;
				self.pname1					:= if(left.nametype IN person_flags, left.cln_title + left.cln_fname + left.cln_mname + left.cln_lname + left.cln_suffix,'');
				self.pname2					:= if(left.cln_fname2 <> '' or left.cln_lname2 <> '', left.cln_title2 + left.cln_fname2 + left.cln_mname2 + left.cln_lname2 + left.cln_suffix2,'');
				self.cname1					:= if(left.nametype IN Bus_flags, StringLib.StringCleanSpaces(left.concat_name),'');
				self := left));
				
export Map_WA_Update := dedup(fclean,all) :persist('persist::WA_as_clean'); 