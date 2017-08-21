import watercraft,ut,address,AID,header,address;

// translates mt_phase01_update.ksh* Ab intio graph into ECL  this state is non updating...

fIn_raw := watercraft_preprocess.Files_raw.mt ; 

temp_rec := {Watercraft.layout_mt,string1 name_format}; 

fprecelan := project( fIn_raw, transform({temp_rec}, 
               
			    tmp_xname1:=watercraft_preprocess.Mod_Clean_Entities.TrimandUp(left.name); 
			    tmp_xname2:=regexreplace(',JR',tmp_xname1,' JR');
				tmp_xname3:=regexreplace(',SR',tmp_xname2,' SR');
				tmp_xname4:=regexreplace(',III',tmp_xname3,' III');
				tmp_xname5:=regexreplace(',3RD',tmp_xname4,' 3RD');

               self.name := tmp_xname5 ; 
               self.name_format := if(StringLib.stringfind(tmp_xname5,',',1)!=0 , 'L' , 'U');
     		   self := left));

ut.Mac_Clean_Dual_Names(fprecelan,name,fcelanDname,name_format);

fcelanname := project(fcelanDname , transform({ Watercraft.Layout_mt_clean_in }, 
                         self.state_origin := 'MT'; 
				         self.process_date := watercraft_preprocess.version;
						 self.clean_address := ''; 
						 self := left 
						 )); 
export Map_MT_Update :=	sequential(output(fcelanname,,watercraft.Cluster_In+'in::watercraft_Mt_'+watercraft_preprocess.version),
								  FileServices.AddSuperFile( watercraft.Cluster_In + 'in::watercraft_Mt', watercraft.Cluster_In+'in::watercraft_Mt_'+watercraft_preprocess.version)
								  ) ;					 