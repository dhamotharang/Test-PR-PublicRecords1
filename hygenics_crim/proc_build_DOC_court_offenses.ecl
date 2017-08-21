import ut, codes;

df := hygenics_crim.Out_Moxie_Crim_Court_Offenses;

hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory into_cof(df L, codes.File_Codes_V3_In R) := transform
	self.court_off_lev_mapped 					:= R.long_desc;
	self.arr_off_lev_mapped 						:= '';
	self.fcra_offense_key 							:='';
  self.fcra_conviction_flag						:='';
  self.fcra_traffic_flag     					:='';
  self.fcra_date 											:='';
  self.fcra_date_type 								:='';
  self.conviction_override_date 			:='';
  self.conviction_override_date_type 	:='';
  self.offense_score						 			:='';
	// self.hyg_classification_code				:='';
	self.Old_LN_offense_score						:='';
	self.Offense_category	     					:=0;
	self := L;
end;

df2 := join(df,codes.File_Codes_V3_In,right.file_name='COURT_OFFENSES' and 
			right.field_name = 'COURT_OFF_LEV' and 
			right.field_name2 = left.vendor and 
			right.code = trim(left.court_off_lev,right,left), 
			into_cof(LEFT,RIGHT),lookup,left outer);
			
hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory into_aof(df2 L, codes.File_Codes_V3_In R) := transform
	self.arr_off_lev_mapped := R.long_desc;
	self := L;
end;

df3 := join(df2,codes.File_Codes_V3_In,right.file_name='COURT_OFFENSES' and 
			right.field_name = 'ARR_OFF_LEV' and 
			right.field_name2 = left.vendor and 
			right.code = trim(left.arr_off_lev,right,left),
			into_aof(LEFT,RIGHT),lookup,left outer);
			
hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory fixmapped ( df3 L) := transform

self.arr_off_lev_mapped := If (L.arr_off_lev_mapped <> '' , L.arr_off_lev_mapped,
            MAP(
						trim(l.arr_off_lev,left,right) ='AM'=>	'A MISDEMEANOR'  ,
						trim(l.arr_off_lev,left,right) IN ['AF','AF2'] =>	'AGGRAVATED FELONY',
						trim(l.arr_off_lev,left,right) IN ['AF2'] =>	'AGGRAVATED FELONY 2',
						trim(l.arr_off_lev,left,right) ='BM'=>	'B MISDEMEANOR', 
						trim(l.arr_off_lev,left,right) ='CM'=>	'C MISDEMEANOR',
						trim(l.arr_off_lev,left,right) ='CF'=>	'C FELONY',						
						trim(l.arr_off_lev,left,right) ='FA'=>	'CLASS A FELONY',                                                                                                                                                                                                                                                 
						trim(l.arr_off_lev,left,right) ='FB'=>	'CLASS B FELONY',                                                                                                                                                                                                                                                 
						trim(l.arr_off_lev,left,right) ='FC'=>	'CLASS C FELONY',                                                                                                                                                                                                                                                 
						trim(l.arr_off_lev,left,right) ='FD'=>	'CLASS D FELONY',                                                                                                                                                                                                                                                 
						trim(l.arr_off_lev,left,right) IN['FE','FELO','FU','FX;FX','FY','UF','UNCF','UNCLF','UNF','F','F0','FE','FELON','FF']=>	'FELONY',                                                                                                                                                                                                                                                 
						trim(l.arr_off_lev,left,right) ='F6'=>	'FELONY  6TH DEGREE',         
						trim(l.arr_off_lev,left,right) ='F7'=>	'FELONY  7TH DEGREE',         
						trim(l.arr_off_lev,left,right) ='F8'=>	'FELONY  8TH DEGREE',         
						trim(l.arr_off_lev,left,right) ='F9'=>	'FELONY  9TH DEGREE',         
						trim(l.arr_off_lev,left,right) ='F5'=>	'FELONY  FIFTH DEGREE',           
						trim(l.arr_off_lev,left,right) ='F1'=>	'FELONY  FIRST DEGREE',
						trim(l.arr_off_lev,left,right) ='1F'=>	'FELONY  FIRST DEGREE', 
						trim(l.arr_off_lev,left,right) ='4 F'=>	'FELONY  FOURTH DEGREE',  
						trim(l.arr_off_lev,left,right) ='4F'=>	'FELONY  FOURTH DEGREE',  
						trim(l.arr_off_lev,left,right) ='F4'=>	'FELONY  FOURTH DEGREE',           
						trim(l.arr_off_lev,left,right) ='2F'=>	'FELONY  SECOND DEGREE',       
						trim(l.arr_off_lev,left,right) ='F2'=>	'FELONY  SECOND DEGREE',          
						trim(l.arr_off_lev,left,right) ='F 3'=>	'FELONY  THIRD DEGREE',    
						trim(l.arr_off_lev,left,right) ='3F'=>	'FELONY  THIRD DEGREE',       
						trim(l.arr_off_lev,left,right) ='F3'=>	'FELONY  THIRD DEGREE',          
						trim(l.arr_off_lev,left,right) ='FCA'=>	'FELONY CA',
						trim(l.arr_off_lev,left,right) ='FL'=>	'FELONY L',                                                                                                                                                                                                                                                 
						trim(l.arr_off_lev,left,right) ='FS'=>	'FELONY S',
						trim(l.arr_off_lev,left,right) IN['INFR','I','IN']=>	'INFRACTION',
						trim(l.arr_off_lev,left,right) ='LIF'=>	'LIFE',
						trim(l.arr_off_lev,left,right) ='LIFE'=>	'LIFE',
						trim(l.arr_off_lev,left,right) ='MM'=>	'MINOR MISDEMEANOR',
						trim(l.arr_off_lev,left,right) IN ['M','MI','MISD','MSD']=>	'MISDEMEANOR', 
						trim(l.arr_off_lev,left,right) IN ['MU','MU1','MU2','MU3','M','M 0','M*','M0','MI','MIS','MISDE']=>	'MISDEMEANOR',                                                                                                                                                                                                                                                    
						trim(l.arr_off_lev,left,right) ='MS'=>	'MISDEMEANOR  S',
						trim(l.arr_off_lev,left,right) ='MA'=>	'MISDEMEANOR A',
						trim(l.arr_off_lev,left,right) ='MB'=>	'MISDEMEANOR B',
						trim(l.arr_off_lev,left,right) ='MC'=>	'MISDEMEANOR C',
						trim(l.arr_off_lev,left,right) ='MD'=>	'MISDEMEANOR D',
						trim(l.arr_off_lev,left,right) ='M1'=>	'MISDEMEANOR CLASS 1',
						trim(l.arr_off_lev,left,right) ='M2'=>	'MISDEMEANOR CLASS 2',
						trim(l.arr_off_lev,left,right) ='M3'=>	'MISDEMEANOR CLASS 3',
						trim(l.arr_off_lev,left,right) ='M4'=>	'MISDEMEANOR CLASS 4',
						trim(l.arr_off_lev,left,right) ='M5'=>	'MISDEMEANOR CLASS 5',
						trim(l.arr_off_lev,left,right) ='M8'=>	'MISDEMEANOR CLASS 8',
						trim(l.arr_off_lev,left,right) ='GM'=>	'MISDEMEANOR G',
						trim(l.arr_off_lev,left,right) IN['P M','PM']=>	'PETITE MISDEMEANOR', 
						trim(l.arr_off_lev,left,right) IN ['T ','TR']=>	'TRAFFIC',
						trim(l.arr_off_lev,left,right) ='TI'=>	'TRAFFIC INFRACTION',
						trim(l.arr_off_lev,left,right) ='TM'=>	'TRAFFIC MISDEMEANOR',''
						));

self.court_off_lev_mapped := If (L.court_off_lev_mapped <> '' , L.court_off_lev_mapped,
            MAP(
						trim(l.court_off_lev,left,right) ='AM'=>	'A MISDEMEANOR'  ,
						trim(l.court_off_lev,left,right) IN ['AF','AF2'] =>	'AGGRAVATED FELONY',
						trim(l.court_off_lev,left,right) IN ['AF2'] =>	'AGGRAVATED FELONY 2',
						trim(l.court_off_lev,left,right) ='BM'=>	'B MISDEMEANOR', 
						trim(l.court_off_lev,left,right) ='CM'=>	'C MISDEMEANOR', 
						trim(l.court_off_lev,left,right) ='CF'=>	'C FELONY',
						trim(l.court_off_lev,left,right) ='FA'=>	'CLASS A FELONY',                                                                                                                                                                                                                                                 
						trim(l.court_off_lev,left,right) ='FB'=>	'CLASS B FELONY',                                                                                                                                                                                                                                                 
						trim(l.court_off_lev,left,right) ='FC'=>	'CLASS C FELONY',                                                                                                                                                                                                                                                 
						trim(l.court_off_lev,left,right) ='FD'=>	'CLASS D FELONY',                                                                                                                                                                                                                                                 
						trim(l.court_off_lev,left,right) IN ['FE','FELO','FU','FX;FX','FY','UF','UNCF','UNCLF','UNF','F','F0','FE','FELON','FF']=>	'FELONY',                                                                                                                                                                                                                                                 
						trim(l.court_off_lev,left,right) ='F6'=>	'FELONY  6TH DEGREE',         
						trim(l.court_off_lev,left,right) ='F7'=>	'FELONY  7TH DEGREE',         
						trim(l.court_off_lev,left,right) ='F8'=>	'FELONY  8TH DEGREE',         
						trim(l.court_off_lev,left,right) ='F9'=>	'FELONY  9TH DEGREE',         
						trim(l.court_off_lev,left,right) ='F5'=>	'FELONY  FIFTH DEGREE',           
						trim(l.court_off_lev,left,right) ='F1'=>	'FELONY  FIRST DEGREE',
						trim(l.court_off_lev,left,right) ='1F'=>	'FELONY  FIRST DEGREE', 
						trim(l.court_off_lev,left,right) ='4 F'=>	'FELONY  FOURTH DEGREE',  
						trim(l.court_off_lev,left,right) ='4F'=>	'FELONY  FOURTH DEGREE',  
						trim(l.court_off_lev,left,right) ='F4'=>	'FELONY  FOURTH DEGREE',           
						trim(l.court_off_lev,left,right) ='2F'=>	'FELONY  SECOND DEGREE',       
						trim(l.court_off_lev,left,right) ='F2'=>	'FELONY  SECOND DEGREE',          
						trim(l.court_off_lev,left,right) ='F 3'=>	'FELONY  THIRD DEGREE',    
						trim(l.court_off_lev,left,right) ='3F'=>	'FELONY  THIRD DEGREE',       
						trim(l.court_off_lev,left,right) ='F3'=>	'FELONY  THIRD DEGREE',          
						trim(l.court_off_lev,left,right) ='FCA'=>	'FELONY CA',
						trim(l.court_off_lev,left,right) ='FL'=>	'FELONY L',                                                                                                                                                                                                                                                 
						trim(l.court_off_lev,left,right) ='FS'=>	'FELONY S',
						trim(l.court_off_lev,left,right) IN['INFR','I','IN']=>	'INFRACTION',
						trim(l.court_off_lev,left,right) ='LIF'=>	'LIFE',
						trim(l.court_off_lev,left,right) ='LIFE'=>	'LIFE',
						trim(l.court_off_lev,left,right) ='MM'=>	'MINOR MISDEMEANOR',
						trim(l.court_off_lev,left,right) IN ['M','MI','MISD','MSD']=>	'MISDEMEANOR', 
						trim(l.court_off_lev,left,right) IN ['MU','MU1','MU2','MU3','M','M 0','M*','M0','MI','MIS','MISDE']=>	'MISDEMEANOR',                                                                                                                                                                                                                                                    
						trim(l.court_off_lev,left,right) ='MS'=>	'MISDEMEANOR  S',
						trim(l.court_off_lev,left,right) ='MA'=>	'MISDEMEANOR A',
						trim(l.court_off_lev,left,right) ='MB'=>	'MISDEMEANOR B',
						trim(l.court_off_lev,left,right) ='MC'=>	'MISDEMEANOR C',
						trim(l.court_off_lev,left,right) ='MD'=>	'MISDEMEANOR D',
						trim(l.court_off_lev,left,right) ='M1'=>	'MISDEMEANOR CLASS 1',
						trim(l.court_off_lev,left,right) ='M2'=>	'MISDEMEANOR CLASS 2',
						trim(l.court_off_lev,left,right) ='M3'=>	'MISDEMEANOR CLASS 3',
						trim(l.court_off_lev,left,right) ='M4'=>	'MISDEMEANOR CLASS 4',
						trim(l.court_off_lev,left,right) ='M5'=>	'MISDEMEANOR CLASS 5',
						trim(l.court_off_lev,left,right) ='M8'=>	'MISDEMEANOR CLASS 8',
						trim(l.court_off_lev,left,right) ='GM'=>	'MISDEMEANOR G',
						trim(l.court_off_lev,left,right) IN['P M','PM']=>	'PETITE MISDEMEANOR', 
						trim(l.court_off_lev,left,right) IN ['T','TR']=>	'TRAFFIC',
						trim(l.court_off_lev,left,right) ='TI'=>	'TRAFFIC INFRACTION', 
						trim(l.court_off_lev,left,right) ='TM'=>	'TRAFFIC MISDEMEANOR',''
						));
self := L;
end;			

df4 := project(df3,fixmapped(left)); //: persist('persist::base::corrections_court_offenses_public_vaani');

export proc_build_DOC_court_offenses := df4;