import Crim_Common, CRIM, Address, lib_stringlib;

//Input_RawFile := File_TN_RutherFord_GS;

Layout_In_Court_Offender_temp := record
  Crim_Common.Layout_In_Court_Offender;
	String40 Name_alias;
	String40 Name_alias2;
  string   Alias;
	
	integer  aliascount;
	string   string_aka;
	integer  localalias;
	string   alphastreet;
	string   numstreet;
end;	


Input_RawFile    :=  distribute(File_TN_RutherFord_GS(trim(name) not in FILTER_CONDITIONS and 
                            length(trim(name))>1 and 
														length(trim(cause_number))>1), hash(cause_number));

Layout_In_Court_Offender_temp Map_offender(Input_RawFile L) := Transform
  
	String  V_name_tmp    := stringlib.stringfindreplace(stringlib.stringfindreplace(stringlib.stringfindreplace(
	                         stringlib.stringfindreplace(stringlib.stringfindreplace(stringlib.stringfindreplace(
	                         stringlib.stringfindreplace(stringlib.stringfindreplace(stringlib.stringfindreplace(
	                         L.name,' BELIEVED TO BE ',' AKA '),'BELIEVED TO BE:',' AKA '),
                                  '(BELIEVED TO BE',' AKA '),'BEL.TO BE',' AKA '),'BELIEVED:',' AKA '),'BEL. TO BE','AKA'),
																	' BEL. ',' AKA '),' BELIEVED ',' AKA '),'  ',' ');
	string5 string_AKA    := REGEXFIND(('[\\(, ]AKA[ ;:.]|A/K/A'),V_name_tmp,0);
  integer loc_alias     := IF (string_AKA <> '', stringlib.stringfind(V_name_tmp,string_AKA,1),0);
	
	integer loc_alias2    := IF (string_AKA <> '', stringlib.stringfind(V_name_tmp,string_AKA,2),0);
	
  string40 v_name       := IF (loc_alias >0, V_name_tmp[1..loc_alias-1],V_name_tmp);
	
	string20 v_lastname   := stringlib.stringfindreplace(regexfind('([A-Z]+)[ ]*(,)',v_name,0),',','');
	
  String40 v_name_aka   := MAP(loc_alias >0 and loc_alias2 >0 => TRIM(stringlib.stringfindreplace(V_name_tmp[loc_alias..loc_alias2-1],TRIM(string_AKA),''),LEFT,RIGHT),
	                             loc_alias >0 and loc_alias2 =0 => TRIM(stringlib.stringfindreplace(V_name_tmp[loc_alias..],TRIM(string_AKA),''),LEFT,RIGHT),
															 ''); 
  
	String40 v_name_aka2  := IF (loc_alias2 >0, TRIM(stringlib.stringfindreplace(V_name_tmp[loc_alias2..],TRIM(string_AKA),''),LEFT,RIGHT),'');
	
	String40 v_name_aka_enhanced  := stringlib.stringfindreplace(If ( stringlib.stringfind(trim(v_name_aka),' ',1) >0 ,v_name_aka, trim(v_name_aka)+' '+v_lastname),'"','');
	String40 v_name_aka_enhanced2 := stringlib.stringfindreplace(If ( stringlib.stringfind(trim(v_name_aka2),' ',1) >0 ,v_name_aka2, trim(v_name_aka2)+' '+v_lastname),'"','');
  integer DBA_loc       := stringlib.stringfind(v_name,' DBA ',1)+stringlib.stringfind(v_name,'/DBA',1);
	
  SELF.string_AKA       := string_AKA;
	SELF.localalias       := loc_alias;
	string v_dr_lic       := IF( TRIM(L.drivers_lic) in invalid_values ,'',TRIM(L.drivers_lic));
	string v_ssn          := IF( TRIM(L.ssn) in invalid_values or 
	                             stringlib.stringfind(L.ssn,'UNK',1)>0,'',TRIM(L.ssn));
															 
// look for other types of data in DL number field															 
	string id_flag        := REGEXFIND('([-]*[I]+[.]*[D]+[. ]*[#]*[:]*)',v_dr_lic,0); 
	string alien_flag     := REGEXFIND('(ALIEN[ ]*[#]+[:]*)',v_dr_lic,0);  
	string phone_flag     := REGEXFIND('(TE[L;]+[/. ]*[#]*[:]*|PHONE[. ]*[#])',v_dr_lic,0);	
	
	string dlstate_temp   := MAP (stringlib.stringfind(v_dr_lic,'SUS',1)> 0 or stringlib.stringfind(v_dr_lic,'REV',1) >0 =>'',
	                              id_flag <> '' or alien_flag <> '' or phone_flag <> '' or
	                             (REGEXFIND('([0-9])',v_dr_lic,0) = '' and length(v_dr_lic) >3  ) =>'NOTDL',
															  
	                              REGEXFIND('([ /(,-]+[a-zA-Z][a-zA-Z]+[ ]*[).]*[ ]*$|^[(]*[a-zA-Z][a-zA-Z]+[ ]*[ );:.#/-]+)',l.drivers_lic,0));
  String dlstate_temp1  := trim(stringlib.stringfilterout(dlstate_temp,';\\)\\(/#:.-,'),left,right);
	
	self.process_date     := Crim_Common.Version_In_Arrest_Offender;
	self.offender_key			:= TN_RutherFord_Offender_key_Generator('3YG', L.Cause_number,L.court_Date);
	
	self.vendor				    := '3Y';
	self.state_origin			:= 'TN';
	self.data_type				:= '2';
	self.source_file			:= '(CP)TN_RUTHERFORD_GS_CRM';
	self.case_number			:= TRIM(L.Cause_number,left,right);
	self.case_court			  := 'GENERAL SESSION';
	self.case_name				:= '';
	self.case_type				:= '';
	self.case_type_desc		:= '';//L.Type_of_case;
	
  string v_case_dt      := Function_ParseDate(L.court_Date,'MMDDYY');
	
	self.case_filing_dt		:= ''; //IF(v_case_dt[1..2] between '19' and '20', v_case_dt,'');
	
	self.pty_nm				    := stringlib.stringfindreplace(stringlib.stringfindreplace(IF(DBA_loc >0 ,v_name[1..DBA_loc-1 ],v_name),
	                                                                                  '/','-'),' - ','-');
	self.pty_nm_fmt			  := 'L';
	self.orig_lname			  := '';
	self.orig_fname			  := '';    
	self.orig_mname			  := '';
	self.orig_name_suffix	:= '';
	self.pty_typ				  := '0';
	self.nitro_flag			  := '';
	self.orig_ssn				  := ''; //StringLib.StringFindReplace(StringLib.StringFindReplace(TRIM(v_ssn,left,right),'-','') ,'XXXXXXXXX','');
	self.dle_num				  := '';
	self.fbi_num				  := '';
	self.doc_num				  := '';
	self.ins_num				  := IF(alien_flag <> '', trim(stringlib.stringfindreplace(v_dr_lic,alien_flag,''),LEFT,right),'');
	self.id_num				    := IF(id_flag <> '', v_dr_lic,'');
	string v_dl_num       := MAP (dlstate_temp ='NOTDL'=> '',
	                              dlstate_temp <> '' => stringlib.stringfindreplace(v_dr_lic,trim(dlstate_temp),''),
																v_dr_lic);     
  self.dl_num           := trim(MAP (v_dl_num[length(v_dl_num)] in ['-','/',',','#'] => v_dl_num[1..length(v_dl_num)-1],
	                              v_dl_num),LEFT,RIGHT);
	                             
	self.dl_state				  := MAP (dlstate_temp ='NOTDL'=> '',
	                              dlstate_temp1 in ['TDL','HISTORY'] => '',
                                length(dlstate_temp1) > 2 => dlstate_temp1[1..2],																
											          dlstate_temp1);
	self.citizenship		  := '';
	self.dob					    := IF(Function_ParseDate(TRIM(L.DOB,right),'MMDDYY') >= '19000101'  and 
	                            ((integer)stringlib.GetDateYYYYMMDD()[1..4])-((integer)Function_ParseDate(TRIM(L.DOB,right),'MMDDYY')[1..4])>=18,
									            Function_ParseDate(TRIM(L.DOB,right),'MMDDYY'),'');
	self.dob_alias				:= '';
	self.place_of_birth	  := '';
 
  String V_Alias_tmp    := MAP ( regexfind('^[0-9]+$',trim(L.alias,left,right),0) <> '' or 
													       regexfind('^DBA',trim(L.alias,left,right),0) <> '' => '',
																 regexfind('^A[ :;/]',L.alias,0) <> '' => trim(L.alias[3..],left,right),
																 L.alias);
	//Look for address in alias															 
  String V_AddrInAlias  := trim(regexfind('^[ a-zA-z.-]*[0-9]+[ ]*[a-zA-z.-]*[ ]*[a-zA-z.-]*[0-9]*',trim(V_Alias_tmp),0));
  String V_Alias        := If (V_AddrInAlias <> '' ,'',V_Alias_tmp ); 
  String V_state_tmp    := StringLib.StringFindReplace(StringLib.StringFindReplace(TRIM(L.state,left,right),'.',''),'`','');
  string V_alphastate   := regexfind('[A-Za-z/\' ]*',V_state_tmp,0);
  string V_numastate    := regexfind('[0-9][0-9][0-9][0-9][0-9]$',TRIM(L.state,left,right),0);

  self.alphastreet      := V_Alias_tmp;
	self.numstreet        := V_Alias; 
	
	self.street_address_1	:= MAP(V_AddrInAlias <> '' =>V_Alias_tmp, 
	                              L.address);
	self.street_address_2	:= '';
	self.street_address_3	:= MAP ( V_AddrInAlias <> '' and 
	                               (V_alphastate ='' or V_alphastate = trim(L.city))=> L.address,
																  TRIM(L.city));
																	
  self.street_address_4	:= MAP ( LENGTH(TRIM(V_alphastate,left,right)) = 2 => stringlib.stringtouppercase(TRIM(V_alphastate,left,right)), 
																 LENGTH(TRIM(V_alphastate,left,right)) IN [3,4] => StringLib.StringFindReplace(TRIM(V_alphastate,left,right),' ',''), 
	                               (V_alphastate ='' or V_alphastate = trim(L.city) )and 
																  V_AddrInAlias <> '' and length(trim(L.city)) =2 => L.city,
																	V_alphastate
																 ); 

	self.street_address_5	:= MAP (LENGTH(TRIM(L.zip,left,right)) >= 5 and REGEXFIND('[0-9]', L.zip) =>  TRIM(L.zip[1..5],right),
																 LENGTH(TRIM(V_numastate,left,right)) = 5 or LENGTH(TRIM(V_numastate,left,right)) = 9 => trim(V_numastate),
																 '');
	string v_temp_race 		:= If (REGEXFIND('[1-9]', L.race),'', L.race);								 
	self.race					    := stringlib.stringfilterout(v_temp_race,'/\'');
	self.race_desc		    := RaceCode2StandardDescription(v_temp_race);
	self.sex					    := IF(TRIM(L.sex,left,right)[1] in ['F','M'],
									            TRIM(L.sex,left,right)[1],
										          '');
	self.Name_alias       := trim(v_name_aka,LEFT); 
	self.Name_alias2       := trim(v_name_aka2,LEFT); 

	//Look for alias in address
  string v_temp_alias   := MAP(trim(V_Alias[1..4]) ='AKA:' => trim(V_Alias[5..])+' AKA ',
	                             trim(V_Alias[1..4]) ='AKA;' => trim(V_Alias[5..])+' AKA ',
															 trim(V_Alias[1..4]) ='AKA/' => trim(V_Alias[5..])+' AKA ',
															 trim(V_Alias[1..3]) ='AKA' => trim(V_Alias[4..])+' AKA ',
	                             trim(V_Alias[1..3]) ='DBA' => '',
															 trim(V_Alias[1..5]) ='D/B/A' => '',
	                             V_Alias <> '' => trim(V_Alias)+' AKA ',
															 '');
															 
	string v_temp_addr_alias := MAP ( L.address[1..3] = 'AKA' => TRIM(L.address[3..])+' AKA '
	                                 ,'');
																	 
	self.Alias            := TRIM(v_temp_alias,LEFT) + TRIM(v_temp_addr_alias,LEFT);
	
  self.aliascount       := stringlib.StringFindCount(v_temp_alias +v_temp_addr_alias,' AKA ');
  
  self                  := [];
end;

P_TNRG_Offender := PROJECT(Input_RawFile, Map_offender(left),LOCAL);
//output(P_TNRG_Offender(case_number ='260670'));

Crim_Common.Layout_In_Court_Offender NormAlias(P_TNRG_Offender L, INTEGER cnt) := TRANSFORM
//cnt =1 for true name. cnt=2,3 for AKA in name. Cnt >=4 for aka's in alias
  integer alias_cnt      := IF (cnt < 4, 0,cnt-3);
  integer nth_alias_loc  := stringlib.stringfind(L.alias,' AKA ',alias_cnt);
  integer nth_minus1_loc := IF (cnt >= 4, stringlib.stringfind(L.alias,' AKA ',alias_cnt-1),alias_cnt);
//	string  v_aliastemp    := trim(IF (cnt < 4, '',IF(nth_alias_loc =0, L.alias, L.alias[nth_minus1_loc+1..nth_alias_loc-1])));
//	integer v_aliasLen     := length(v_aliastemp);
  string  v_alias        := trim(IF (cnt < 4, '',IF(nth_alias_loc =0, L.alias, L.alias[nth_minus1_loc+1..nth_alias_loc-1])));
	//IF (v_aliasLen > 0 ,
	//                                IF ( v_aliastemp[v_aliasLen-4 ..] = ' AKA' ,v_aliastemp[1..v_aliasLen-4],v_aliastemp),'');
	
  SELF.pty_nm 					 := MAP(cnt =1 => stringlib.stringfindreplace(L.pty_nm,',',' ')  ,
	                              cnt =2 => stringlib.stringfindreplace(L.Name_alias,',',' '),
																cnt =3 => stringlib.stringfindreplace(L.Name_alias2,',',' '),
	                              IF(v_alias[1..3] ='AKA ',stringlib.stringfindreplace(trim(v_alias[4..],LEFT,RIGHT),',',' '), 
																                         stringlib.stringfindreplace(v_alias,',',' ')));
	self.pty_nm_fmt			   := MAP(cnt = 1 => IF(stringlib.stringfind(L.pty_nm,',',1)>0,'L','F'),
	                              cnt = 2 => IF(stringlib.stringfind(L.Name_alias,',',1)>0,'L','F'),
																cnt = 3 => IF(stringlib.stringfind(L.Name_alias2,',',1)>0,'L','F'),
																IF(stringlib.stringfind(v_alias,',',1)>0,'L','F')
	                             );																
  SELF.pty_typ 					 := IF (cnt =1, L.pty_typ, '2');
	//SELF.localalias        := nth_alias_loc;
	//SELf.aliascount        := nth_minus1_loc;
  SELF 									 := L;
END;

Norm_TNRG_Offender := NORMALIZE(P_TNRG_Offender, LEFT.aliascount+3 ,NormAlias(LEFT,COUNTER),local);

Flt_TNRG_Offender  := Norm_TNRG_Offender( length(trim(pty_nm))>1);
Crim.Crim_clean(Flt_TNRG_Offender,clean_TNRG_Offender);
STNRG_Offender     := sort(clean_TNRG_Offender,case_number,lname,fname,mname,name_suffix,pty_typ, local);
TNRG_Offender_dedup:= dedup(STNRG_Offender,case_number,lname,fname,mname,name_suffix,local); 

export Map_TN_RutherFord_GS_Offender := TNRG_Offender_dedup(pty_nm <>'') ;