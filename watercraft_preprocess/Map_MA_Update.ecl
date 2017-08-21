import watercraft,ut,address,AID,header,address;

// translates ma_phase01.mp Ab intio graph into ECL

fIn_raw := watercraft_preprocess.Files_raw.ma ; 

temp_rec := {Watercraft.layout_ma,string1 name_format,string100 concat_name}; 

fprecelan := project( fIn_raw, transform({temp_rec}, 

                self.FIRST_NAME      := if(trim(left.FIRST_NAME,left,right)='-' OR watercraft_preprocess.Mod_Clean_Entities.TrimandUp(left.FIRST_NAME)='NULL', ' ' , trim(left.FIRST_NAME,left,right));
                self.MID             := if(trim(left.MID,left,right)='-' OR trim(left.MID,left,right)='.' OR watercraft_preprocess.Mod_Clean_Entities.TrimandUp(left.MID)='NULL',' ' , trim(left.MID,left,right));
                self.LAST_NAME       := if(trim(left.LAST_NAME,left,right)[1] = '+' , StringLib.StringFindReplace(left.LAST_NAME,'+', '&') ,
		                                if(watercraft_preprocess.Mod_Clean_Entities.TrimandUp(left.LAST_NAME)='NULL' ,' ', trim(left.LAST_NAME,left,right)));
                self.MODEL := if(trim(left.MODEL,left,right)in ['null','NULL'] OR trim(left.MODEL,left,right)='UNK'OR trim(left.MODEL,left,right)='UNKOWN','',left.MODEL);
                self.ENG_MN_TYP_CODE := if(trim(left.ENG_MN_TYP_CODE,left,right)in ['null','NULL']OR trim(left.ENG_MN_TYP_CODE,left,right)='UNK'OR trim(left.ENG_MN_TYP_CODE,left,right)='UNKOWN','', left.ENG_MN_TYP_CODE);
                self.SERIAL_NUMBER := if(trim(left.SERIAL_NUMBER,left,right)in ['null','NULL']OR trim(left.SERIAL_NUMBER,left,right)='UNK'OR trim(left.SERIAL_NUMBER,left,right)='UNKOWN','',left.SERIAL_NUMBER);
                self.concat_name := watercraft_preprocess.Mod_Clean_Entities.TrimandUp(watercraft_preprocess.fn_concat_name_MA(self.first_name,self.mid,self.last_name)); 
			    self.name_format := if(StringLib.stringfind(left.name,',',1)!=0 , 'F' , 'U');
     		    self := left));

ut.Mac_Clean_Dual_Names(fprecelan,concat_name,fcelanDname,name_format);

fcelanname := project(fcelanDname , transform({ Watercraft.Layout_ma_clean_in }, 
                         self.state_origin := 'MA'; 
				         self.process_date := watercraft_preprocess.version;
						 self.clean_address := ''; 
						 self := left 
						 )); 
						 
export Map_MA_Update := sequential(output(fcelanname,,watercraft.Cluster_In+'in::watercraft_ma_'+watercraft_preprocess.version),
								  FileServices.AddSuperFile( watercraft.Cluster_In + 'in::watercraft_ma', watercraft.Cluster_In+'in::watercraft_ma_'+watercraft_preprocess.version)
								  ) ;