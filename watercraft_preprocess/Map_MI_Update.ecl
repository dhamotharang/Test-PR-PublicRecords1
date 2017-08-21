import watercraft,ut,address,AID,header,address;

// translates mi_phase01_update.mp Ab intio graph into ECL

fIn_raw := watercraft_preprocess.Files_raw.mi ; 

temp_rec := {Watercraft.layout_mi,string1 name_format}; 

fprecelan := project( fIn_raw, transform({temp_rec}, 

              string100 t_name := watercraft_preprocess.Mod_Clean_Entities.TrimandUp(left.NAME);
						
						tmp_xname0:=regexreplace('@',t_name,' ');
						tmp_xname2:=regexreplace('ATTN:',tmp_xname0,' ');
						tmp_xname3:=regexreplace('3/4/75',tmp_xname2,' ');
						tmp_xname4:=StringLib.StringFindReplace(tmp_xname3,' / JR ',' JR');
						tmp_xname5:=StringLib.StringFindReplace(tmp_xname4,' /JR ',' JR');
						tmp_xname6:=StringLib.StringFindReplace(tmp_xname5,' /SR ',' SR');
						tmp_xname7:=StringLib.StringFindReplace(tmp_xname6,' /IV ',' IV');
						tmp_xname8:=StringLib.StringFindReplace(tmp_xname7,' /III ',' III');
						tmp_xname9:=StringLib.StringFindReplace(tmp_xname8,' / III ',' III');
						tmp_xname10:=StringLib.StringFindReplace(tmp_xname9,' /II ',' II');
						tmp_xname11:=regexreplace(' (ATTY) ',tmp_xname10,' ');
						tmp_xname12:=regexreplace(' ARCHBIXHOP ',tmp_xname11,' ');
						tmp_xname13:=regexreplace( ' /AL | /AK | /AR | /AZ | /CO | /CT | /DE | /FL | /GA | /IA | /ID | /IL | /IN | /LA | /KS | /KY | /MA | /MD | /ME | /MI| /MN | /MO | /MS | /MT | /NC | /ND | /NE | /NH | /NV | /NY | /PA | /OH | /OK | /OR | /SC | /TN | /TX | /UT | /VA | /WA | /WI | /WV | /WY',tmp_xname12,' ');
						tmp_xname14:=regexreplace( '/FL |/IL |/KY |/WA |/VA ',tmp_xname13,' ');
						tmp_xname1:=StringLib.StringFindReplace(tmp_xname14,' /I ',' I');
			   
			   self.name := tmp_xname1; 
               self.name_format := if(StringLib.StringFind(tmp_xname1,' JR,',1)!=0  OR 
		   StringLib.StringFind(tmp_xname1,' SR,',1)!=0  OR
		   StringLib.StringFind(tmp_xname1,' I,',1)!=0   OR
		   StringLib.StringFind(tmp_xname1,' II,',1)!=0  OR
		   StringLib.StringFind(tmp_xname1,' III,',1)!=0 OR 
		   StringLib.StringFind(tmp_xname1,' IV,',1)!=0 OR 
		   StringLib.StringFind(tmp_xname1,',',1)!=0 , 'L' , 'U');
     		   self := left));

ut.Mac_Clean_Dual_Names(fprecelan,name,fcelanDname,name_format);

fcelanname := project(fcelanDname , transform({ Watercraft.Layout_mi_clean_in }, 
                         self.state_origin := 'MI'; 
				         self.process_date := watercraft_preprocess.version;
						 self.clean_address := ''; 
						 self := left 
						 )); 
						 
export Map_MI_Update :=sequential(output(fcelanname,,watercraft.Cluster_In+'in::watercraft_mi_'+watercraft_preprocess.version),
								  FileServices.AddSuperFile( watercraft.Cluster_In + 'in::watercraft_mi', watercraft.Cluster_In+'in::watercraft_mi_'+watercraft_preprocess.version)
								  ) ;