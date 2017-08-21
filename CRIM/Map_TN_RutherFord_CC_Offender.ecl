import Crim_Common, CRIM, Address, lib_stringlib;

Input_RawFile := File_TN_RutherFord_CC;

Layout_In_Court_Offender_temp := record
  Crim_Common.Layout_In_Court_Offender;
	String40 Name_alias;
  string Alias;
	integer aliascount;
	string string_aka;
	integer localalias;
	string alphastreet;
	string numstreet;
end;	

dInput_RawFile:= distribute(Input_RawFile(trim(name) not in FILTER_CONDITIONS), hash(cause_number));

Layout_In_Court_Offender_temp Map_offender(Input_RawFile L) := Transform
	
	string5 string_AKA    := REGEXFIND(('[\\(, ]AKA[ ;:]|A/K/A'),L.name,0);
  integer localias      := IF ( string_AKA <> '', stringlib.stringfind(L.name,string_AKA,1),0);
  string40 v_name       := IF (localias >0, TRIM(L.name[1..localias-1]),L.name);
  String40 v_name_aka   := IF (localias >0, TRIM(stringlib.stringfindreplace(L.name[localias..],TRIM(string_AKA),''),LEFT,RIGHT),'');
	integer DBA_loc       := stringlib.stringfind(v_name,' DBA ',1)+stringlib.stringfind(v_name,'/DBA',1);
  SELF.string_AKA       := string_AKA;
	SELF. localalias      := localias;
	
	string v_dr_lic       := IF( TRIM(L.drivers_license) in invalid_values ,'',TRIM(L.drivers_license));
	string v_ssn          := IF( TRIM(L.social_sec_no) in invalid_values or 
	                             stringlib.stringfind(L.social_sec_no,'UNK',1)>0,'',TRIM(L.social_sec_no));

  string id_flag        := REGEXFIND('([-]*[I]+[.]*[D]+[. ]*[#]*[:]*)',v_dr_lic,0); 
	string alien_flag     := REGEXFIND('(ALIEN[ ]*[#]+[:]*)',v_dr_lic,0);  
	string phone_flag     := REGEXFIND('(TE[L;]+[/. ]*[#]*[:]*|PHONE[. ]*[#])',v_dr_lic,0);	
	
	string dlstate_temp   := IF (id_flag <> '' or alien_flag <> '' or phone_flag <> '' or
	                             (REGEXFIND('([0-9])',v_dr_lic,0) = '' and length(v_dr_lic) >3),'NOTDL',
	                                REGEXFIND('([ /(,-]+[a-zA-Z][a-zA-Z]+[ ]*[).]*[ ]*$|^[(]*[a-zA-Z][a-zA-Z]+[ ]*[ );:.#/-]+)',l.drivers_license,0));
  String dlstate_temp1  := trim(stringlib.stringfilterout(dlstate_temp,';\\)\\(/#:.-,'),left,right);
             
	self.process_date     := Crim_Common.Version_In_Arrest_Offender;
	self.offender_key			:= TN_RutherFord_Offender_key_Generator('3RC', L.Cause_number,L.indictmentdate);
																		
	self.vendor				    := '3R';
	self.state_origin			:= 'TN';
	self.data_type				:= '2';
	self.source_file			:= 'TN_RUTHERFORD_CC_CRM';
	self.case_number			:= TRIM(L.Cause_number,left,right);
	self.case_court			  := 'Circuit Court';
	self.case_name				:= '';
	self.case_type				:= '';
	self.case_type_desc		:= '';//L.Type_of_case;
	
	string v_case_dt      := Function_ParseDate(L.IndictmentDate,'MMDDYY');
	
	self.case_filing_dt		:= IF(v_case_dt[1..2] between '19' and '20', v_case_dt,'');
															
	self.pty_nm				    := stringlib.stringfindreplace(stringlib.stringfindreplace(IF(DBA_loc >0 ,v_name[1..DBA_loc-1 ],v_name),
	                                                                                  '/','-'),' - ','-');
	self.pty_nm_fmt			  := 'L';
	self.orig_lname			  := '';
	self.orig_fname			  := '';    
	self.orig_mname			  := '';
	self.orig_name_suffix	:= '';
	self.pty_typ				  := '0';
	self.nitro_flag			  := '';
	self.orig_ssn				  := ''; //StringLib.StringFindReplace(TRIM(v_ssn,left,right),'-','');
	self.dle_num				  := '';
	self.fbi_num				  := '';
	self.doc_num				  := '';
	self.ins_num				  := IF(alien_flag <> '', trim(stringlib.stringfindreplace(v_dr_lic,alien_flag,''),LEFT,right),'');
	self.id_num				    := IF(id_flag <> '', v_dr_lic,'');
	string v_dl_num       := MAP (dlstate_temp ='NOTDL'=> '',
	                              dlstate_temp <> '' => stringlib.stringfindreplace(v_dr_lic,trim(dlstate_temp),''),
																v_dr_lic);     
  self.dl_num           := trim(MAP (v_dl_num[length(v_dl_num)] in ['-','/',',','#'] => v_dl_num[1..length(v_dl_num)-1],
																v_dl_num),left,right);
	                             
	self.dl_state				  := MAP (dlstate_temp ='NOTDL'=> '',
	                              dlstate_temp1 in ['TDL','HISTORY'] => '',
                                length(dlstate_temp1) > 2 => dlstate_temp1[1..2],																
											          dlstate_temp1);
	self.citizenship		  := '';
	self.dob					    := IF(Function_ParseDate(TRIM(L.Birthday,right),'MMDDYYDOB') >= '19000101'  and 
	                            ((integer)stringlib.GetDateYYYYMMDD()[1..4])-((integer)Function_ParseDate(TRIM(L.Birthday,right),'MMDDYYDOB')[1..4])>=18,
									            Function_ParseDate(TRIM(L.Birthday,right),'MMDDYYDOB'),'');
	self.dob_alias				:= '';
	self.place_of_birth	  := '';
	
	
 String V_state_tmp    := StringLib.StringFindReplace(StringLib.StringFindReplace(TRIM(L.state,left,right),'.',''),'`','');
 string V_alphastate   := regexfind('[A-Za-z/\' ]*',V_state_tmp,0);
 string V_numastate    := regexfind('[0-9][0-9][0-9][0-9][0-9]$',TRIM(L.state,left,right),0);

  self.alphastreet      := V_alphastate;
	self.numstreet        := V_numastate; 
	
	self.street_address_1	:= MAP (L.address[1..3] in ['DBA', 'AKA'] => TRIM(L.city),
	                              TRIM(L.address));
	self.street_address_2	:= '';
	self.street_address_3	:= MAP (L.address[1..3] in ['DBA', 'AKA'] => TRIM(L.state),
	                              TRIM(L.city));
  self.street_address_4	:= MAP ( L.address[1..3] in ['DBA', 'AKA'] => TRIM(L.zip),
	                               LENGTH(TRIM(V_alphastate,left,right)) = 2 => stringlib.stringtouppercase(TRIM(V_alphastate,left,right)), 
																 LENGTH(TRIM(V_alphastate,left,right)) IN [3,4] => StringLib.StringFindReplace(TRIM(V_alphastate,left,right),' ',''), 
	                               V_alphastate
																 ); 

	self.street_address_5	:= MAP (L.address[1..3] in ['DBA', 'AKA'] => '',
	                            	LENGTH(TRIM(L.zip,left,right)) >= 5  and REGEXFIND('[0-9]', L.zip) =>  TRIM(L.zip[1..5],right),
																LENGTH(TRIM(V_numastate,left,right)) = 5 or LENGTH(TRIM(V_numastate,left,right)) = 9 => trim(V_numastate[1..5]),
																 '');
	string v_temp_race 		:= If (REGEXFIND('[1-9]', L.race),'', L.race);								 
	self.race					    := stringlib.stringfilterout(v_temp_race,'/\'');
	self.race_desc		    := RaceCode2StandardDescription(v_temp_race);
	self.sex					    := IF(TRIM(L.sex,left,right)[1] in ['F','M'],
									            TRIM(L.sex,left,right)[1],
										          '');
															
	self.Name_alias       := v_name_aka; 
	
	string v_temp_alias   := MAP(trim(L.Alias[1..3]) ='AKA' => trim(L.Alias[3..])+' AKA ',
	                             trim(L.Alias[1..3]) ='DBA' => '',
	                             L.Alias <> '' => trim(L.Alias)+' AKA ',
															 '');
															 
	string v_temp_addr_alias := MAP (L.address[1..3] = 'AKA' => trim(L.address[3..])+' AKA '
	                                 ,'');
																	 
	self.Alias            := v_temp_alias + v_temp_addr_alias;
	
  self.aliascount       := stringlib.StringFindCount(v_temp_alias +v_temp_addr_alias,' AKA ');
  self                  := [];
end;

P_TNRC_Offender := PROJECT(dInput_RawFile, Map_offender(left),LOCAL);



crim_common.Layout_In_Court_Offender NormAlias(P_TNRC_Offender L, INTEGER cnt) := TRANSFORM
 //cnt =1 for true name. cnt=2 for AKA in name. Cnt >=3 for aka's in alias
  integer alias_cnt      := IF (cnt < 3, 0,cnt-2);
  integer nth_alias_loc  := stringlib.stringfind(L.alias,' AKA ',alias_cnt);
  integer nth_minus1_loc := IF (cnt >= 3, stringlib.stringfind(L.alias,' AKA ',alias_cnt-1),alias_cnt);
  string  v_alias        := IF (cnt < 3, '',IF(nth_alias_loc =0, L.alias, L.alias[nth_minus1_loc+1..nth_alias_loc-1]));
	
	// Alias field is not big enough to hold more than one alias. remove names after ';' they are never complete
	//If the length of this field is increased re-evaluate whether the alias after ';' can be used
	string  v_alias1       := IF (stringlib.stringfind(v_alias,';',1)>0 , v_alias[1..stringlib.stringfind(v_alias,';',1)-1],v_alias);
	
  SELF.pty_nm 					 := MAP(cnt =1 => stringlib.stringfindreplace(L.pty_nm,',',' ') ,
	                              cnt =2 => stringlib.stringfindreplace(L.Name_alias,',',' ') ,
	                              IF(v_alias[1..3] ='AKA ',stringlib.stringfindreplace(trim(v_alias1[4..],LEFT,RIGHT),',',' ') , 
																                         stringlib.stringfindreplace(v_alias1,',',' ') ));
																
	self.pty_nm_fmt			   := MAP(cnt = 1 => IF(stringlib.stringfind(L.pty_nm,',',1)>0,'L','F'),
	                              cnt = 2 => IF(stringlib.stringfind(L.Name_alias,',',1)>0,'L','F'),
																IF(stringlib.stringfind(v_alias1,',',1)>0,'L','F')
	                             );			
															 
  SELF.pty_typ 					 := IF (cnt =1, L.pty_typ, '2');
	//SELF.localalias        := nth_alias_loc;
	//SELf.aliascount        := nth_minus1_loc;
  SELF 									 := L;
END;

Norm_TNRC_Offender := NORMALIZE(P_TNRC_Offender, LEFT.aliascount+2 ,NormAlias(LEFT,COUNTER),local);
Flt_TNRC_Offender  := Norm_TNRC_Offender(pty_nm <>'');
Crim.Crim_clean(Flt_TNRC_Offender,clean_TNRC_Offender);
STNRC_Offender     := sort(clean_TNRC_Offender,case_number,lname,fname,mname,name_suffix,pty_typ, local);
TNRC_Offender_dedup:= dedup(STNRC_Offender,case_number,lname,fname,mname,name_suffix,local); 

//call the GS offender mapping
TNRG_Offender      := CRIM.Map_TN_RutherFord_GS_Offender;
  
export Map_TN_RutherFord_CC_Offender := TNRC_Offender_dedup+TNRG_Offender :PERSIST('~thor_dell400::persist::Crim_TN_Rutherford_Offender');