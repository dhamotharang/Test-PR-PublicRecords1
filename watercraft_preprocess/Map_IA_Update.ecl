import watercraft,ut,address,AID,header,address;

// translates ia_phase01_update.mp Ab intio graph into ECL

fIn_raw := watercraft_preprocess.Files_raw.ia ;

fref := project( fIn_raw, transform({watercraft_preprocess.layout_temp.layout_temp_ia}, 


						t_first := regexreplace( ' OR$| AND$| &$| &/OR$| &/AND$| AND/OR$| OR/&$| OR/AND$',trim(left.FIRST_name), ' ');
						
						self.FIRST_NAME := if(regexfind( ' OR | & |&/OR | AND | AND/OR | OR/AND ',trim(t_first))=false AND
										regexfind( ' JR| SR| I+ | IV | V | VI | VII ',t_first) =true , regexreplace( ' JR.| JR| SR| SR.| I+ | IV | V | VI | VII ',t_first, ' ')
										, t_first) ;

                        self.LAST_name := if(regexfind( ' OR | & |&/OR | AND | AND/OR | OR/AND ',trim(t_first))=false AND
            regexfind( ' JR ',t_first) =true , trim(left.LAST_name)+ ' JR ' , 
            if(regexfind( ' OR | & |&/OR | AND | AND/OR | OR/AND ',trim(t_first))=false AND 
              regexfind( ' SR ',t_first) = true ,  trim(left.LAST_name)+ ' SR ' , 
            if(regexfind( ' OR | & |&/OR | AND | AND/OR | OR/AND ',trim(t_first))=false AND
               regexfind( ' I ',t_first) = true, trim(left.LAST_name)+ ' I ' , 
            if(regexfind( ' OR | & |&/OR | AND | AND/OR | OR/AND ',trim(t_first))=false AND
               regexfind( ' II ',t_first) =true , trim(left.LAST_name)+ ' II ' ,
            if(regexfind( ' OR | & |&/OR | AND | AND/OR | OR/AND ',trim(t_first))= false AND
               regexfind( ' III ',t_first) = true , trim(left.LAST_name)+ ' III ' ,
            if(regexfind(' OR | & |&/OR | AND | AND/OR | OR/AND ',trim(t_first)) =false AND
               regexfind( ' IV',t_first) = true ,  trim(left.LAST_name)+ ' IV ' ,
            if(regexfind( ' OR | & |&/OR | AND | AND/OR | OR/AND ',trim(t_first))=false AND
               regexfind( ' V ',t_first) =true , trim(left.LAST_name)+ ' V ' ,
            if(regexfind( ' OR | & |&/OR | AND | AND/OR | OR/AND ',trim(t_first))=false AND
               regexfind( ' VI ',left.FIRST_name) =true , trim(left.LAST_name)+ ' VI ' , 
            if(regexfind( ' OR | & |&/OR | AND | AND/OR | OR/AND ',trim(left.FIRST_name))=false AND
               regexfind(' VII ',t_first)= true , trim(left.LAST_name)+ ' VII ', 
             left.LAST_name))))))))) ;
			
			            self.Toilet := '';
						self.ORIG_FIRST := left.FIRST_name;
						self.ORIG_LAST := left.LAST_name;
						self:= left)); 

frefconcat := project( fref, transform ( {fref, string115 concat_name,string1 name_format},
                       self.concat_name := watercraft_preprocess.Mod_Clean_Entities.TrimandUp(watercraft_preprocess.fn_concat_name_IA(left.first_name, left.mid,left.last_name)) ; 
					   self.name_format := if(StringLib.stringfind(self.concat_name,',',1)!=0 , 'L' , 'F');
					   self:= left)); 

ut.Mac_Clean_Dual_Names(frefconcat,concat_name,fcelanDname,name_format);

fcelanname := project(fcelanDname , transform({ fcelanDname,string65 second_owners_name}, 
                         self.second_owners_name:= if(regexfind( 'TRUSTEE|TRUST|TRST |TRST DTD|REV TRST|CHARITABLE',left.Second_Owners_Last_Name)=false AND StringLib.stringfind(left.Second_Owners_First_Name, ' JR ',1) !=0, StringLib.StringToUpperCase(StringLib.StringFindReplace(left.Second_Owners_First_Name,' JR ', '')+' '+left.Second_Owners_Middle_Initial+' '+left.Second_Owners_Last_Name+' '+' JR ' ) ,
	      	    if(regexfind( 'TRUSTEE|TRUST|TRST |TRST DTD|REV TRST|CHARITABLE',left.Second_Owners_Last_Name)=false AND StringLib.stringfind(left.Second_Owners_First_Name, ' SR ',1)!=0 , StringLib.StringToUpperCase(StringLib.StringFindReplace(left.Second_Owners_First_Name,' SR ','')+' '+left.Second_Owners_Middle_Initial+' '+left.Second_Owners_Last_Name+' '+' SR ' ) ,
	      	    if(regexfind( 'TRUSTEE|TRUST|TRST |TRST DTD|REV TRST|CHARITABLE',left.Second_Owners_Last_Name)=false AND StringLib.stringfind(left.Second_Owners_First_Name, ' II ',1)!=0 ,  StringLib.StringToUpperCase(StringLib.StringFindReplace(left.Second_Owners_First_Name,' II ','')+' '+left.Second_Owners_Middle_Initial+' '+left.Second_Owners_Last_Name+' '+' II ' ),
	      	    if(regexfind( 'TRUSTEE|TRUST|TRST |TRST DTD|REV TRST|CHARITABLE',left.Second_Owners_Last_Name)=false AND StringLib.stringfind(left.Second_Owners_First_Name, ' III ',1)!=0 ,  StringLib.StringToUpperCase(StringLib.StringFindReplace(left.Second_Owners_First_Name,' III ','')+' '+left.Second_Owners_Middle_Initial+' '+left.Second_Owners_Last_Name+' '+' III ' ),
	      	    if(regexfind( 'TRUSTEE|TRUST|TRST |TRST DTD|REV TRST|CHARITABLE',left.Second_Owners_Last_Name)=false AND StringLib.stringfind(left.Second_Owners_First_Name, ' IV ',1)!=0 ,  StringLib.StringToUpperCase(StringLib.StringFindReplace(left.Second_Owners_First_Name,' IV ','')+' '+left.Second_Owners_Middle_Initial+' '+left.Second_Owners_Last_Name+' '+' IV ' ) , StringLib.StringToUpperCase(left.Second_Owners_First_Name+' '+left.Second_Owners_Middle_Initial+' '+left.Second_Owners_Last_Name))))));
 
						 self := left 
						 )); 

Address.Mac_Is_Business(fcelanname,second_owners_name,fNametype,name_type);

fclean :=  project(fNametype, transform ({watercraft.layout_ia_clean_in}, 

                   self.clean_second_owner_cname := if(left.name_type = 'B', trim(left.second_owners_name,left,right),  '');
                   self.clean_second_owner_pname := if(left.name_type <>'B' ,Address.CleanPersonFML73(left.second_owners_name),'');
				   self.clean_address := '' ;
				   self.is_company_flag := if(left.name_type = 'B', 1, 0); 
				   self.process_date :=watercraft_preprocess.version,
				   self.state_origin := 'IA'; 
				   self := left ));
				   
export Map_IA_Update := sequential(output(fclean,,watercraft.Cluster_In+'in::watercraft_ia_'+watercraft_preprocess.version),
								  FileServices.AddSuperFile( watercraft.Cluster_In + 'in::watercraft_ia', watercraft.Cluster_In+'in::watercraft_ia_'+watercraft_preprocess.version)
								  ) ;