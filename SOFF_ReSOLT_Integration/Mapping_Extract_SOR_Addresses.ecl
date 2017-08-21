import Address;

remove_these := ['CO','COUNT','COUN','CANNOT BE VERIFIED','CANNOT BE V','NONE, ?? 00000','N/A, ?? 00000',',',
                              'NONE','N/A','NONE NONE, ?? 00000','N/A N/A, ?? 00000'];

addrRec_temp1 := RECORD
  File_Generated_UNQ_PK_DID_Plus_Relatives.persistent_key;
	Layout_SexOffender_Main.seisint_primary_key;
	//UNSIGNED1 numRows;
	STRING    Addr_type;
	STRING    Name;
  STRING    Address1;
	STRING    Address2;
	STRING    Address3;
	STRING    Address4;
	STRING    Address5;
	STRING    County;	
END;

addrRec_temp2 := RECORD
  File_Generated_UNQ_PK_DID_Plus_Relatives.persistent_key;
	Layout_SexOffender_Main.seisint_primary_key;
	UNSIGNED1 numRows;
  string    Addr_type; 
  STRING    theaddr;
	string    Name; 
	string    street;
//string    street2;
//string    city;
	string    city_state_zip;
	string    county;	
END;

/*addressTable := DATASET([ {'Other ADDRESS: 3723 VISION BLVD,  ORANGE COUNTY JAIL, ORLANDO, FL 32839-8600, County :ORANGE'},
{'Registration ADDRESS: URB. EL CORTIJO APT.D 0-23, BAYAMON, PR 00956;'},
{'Employer ADDRESS: 6557 COUNTY HIGHWAY 67, HANCOCK, NY 13783;Employer ADDRESS: UNKNOWN, TROUT CREEK, NY 00000'}],origaddrRec);
*/

//OffenderMain   := File_SOR_Main_with_PKey;
//D_offendermain := distribute(OffenderMain,hash(seisint_primary_key));
D_offendermain := File_SOR_Main_with_PKey;

// Normalize addresses in the record.
addrRec_temp1 Extract_addresses(D_offendermain  L, INTEGER Cnt) := TRANSFORM 
  SELf.Addr_type     := MAP (Cnt = 1  => 'EMPLOYER',
	                           Cnt = 2  => 'SCHOOL',
												    //Cnt = 3 and L.other_registration_address_1 <> ''=> 'Other Registration',
														//cnt = 4 and L.temp_lodge_address_1 <> '' => 'Temp Lodge'
														'');
												
  SELF.Name          := MAP (Cnt = 1 => L.employer,
	                           Cnt = 2 => L.school,
											       '');
												
  SELF.address1      := MAP (Cnt = 1 => L.employer_address_1,
	                           Cnt = 2 => L.school_address_1,
												   //Cnt = 3 => L.registration_address_1,
												   //Cnt = 4 => L.temp_lodge_address_1,
												     '');
												
	SELF.address2      := MAP (Cnt = 1 => L.employer_address_2,
	                           Cnt = 2 => L.school_address_2,
											     //Cnt = 3 => L.registration_address_2,
												   //Cnt = 4 => L.temp_lodge_address_2,
												     '');
												
	string v_temp_add3 := MAP (Cnt = 1 => L.employer_address_3,
	                           Cnt = 2 => L.school_address_3,
												   //Cnt = 3 => L.registration_address_3,
												   //Cnt = 4 => L.temp_lodge_address_3,
													 '');											
												
	SELF.address3      := IF(stringlib.stringfind(v_temp_add3,'ADDRESS AS OF:',1) >0 or
	                         stringlib.stringfind(v_temp_add3,'ADDRESS START DATE:',1)>0 or
													 stringlib.stringfind(v_temp_add3,'TYPE:',1) >0 ,'', v_temp_add3);
	
	string v_temp_add4 := MAP (Cnt = 1 => L.employer_address_4,
	                           Cnt = 2 => L.school_address_4,
												    //Cnt = 3 => L.registration_address_4,
												    //Cnt = 4 => L.temp_lodge_address_4,			
														 '');
												
	SELF.address4      := IF(stringlib.stringfind(v_temp_add4,'ADDRESS AS OF:',1) >0 or
	                         stringlib.stringfind(v_temp_add4,'ADDRESS START DATE:',1)>0 or
													 stringlib.stringfind(v_temp_add4,'TYPE:',1) >0 or
													 stringlib.stringfind(v_temp_add4,'ADDRESS STATUS:',1)>0  ,'',v_temp_add4);
												
	string v_temp_add5 := MAP (Cnt = 1 => L.employer_address_5,
	                           Cnt = 2 => L.school_address_5,
												     //Cnt = 3 => L.registration_address_5,
												     //Cnt = 4 => L.temp_lodge_address_5,
												     '');
	SELF.address5			 := IF(stringlib.stringfind(v_temp_add5,'ADDRESS AS OF:',1) >0 or 
	                         stringlib.stringfind(v_temp_add5,'ADDRESS START DATE:',1)>0 or 
													 stringlib.stringfind(v_temp_add5,'ADDRESS STATUS:',1)>0 or
													 stringlib.stringfind(v_temp_add5,'TYPE:',1) >0 or	
	                         stringlib.stringfind(v_temp_add5,'SOURCE/ADDRESS VERIFIED:',1) >0  ,''	,v_temp_add5);	
																			
	SELF.county        := MAP (Cnt = 1 => L.employer_county,
	                           Cnt = 2 => L.school_county,
												     //Cnt = 3 => L.registration_county,
												     //Cnt = 4 => L.temp_lodge_county,
												     '');												
  SELF :=L;
 
END;

NormedAddress_1      := NORMALIZE(d_offendermain(name_type ='0'),2,Extract_addresses(LEFT,COUNTER),local);
Fil_Normed_address_1 := NormedAddress_1(name <> '' or address1 <> '' or 
                                                      address2 <> '' or 
																											address3 <> '' or 
																											address4 <> '' or 
																											address5 <> '' or
																											county   <> '');
																								
//Normalize addresses from address fields
addrRec_temp2 change_layout_address(addrRec_temp1  L) := TRANSFORM

SELF.theaddr             := trim(L.address1)+'*'+trim(L.address2)+'*'+trim(L.address3)+'*'+trim(L.address4)+'*'+trim(L.address5);

string v_city_st_zip     := MAP(L.address5 <> '' and 
                                regexfind('[a-zA-z.]*[ ]*[a-zA-z.]*[ ]*[a-zA-z.]*,*[ ]*[a-zA-z?]*[a-zA-z?]*[ ]*[0-9]*-?[0-9]*',L.address5,0) <> '' => L.address5,
																L.address4 <> '' and 
                                regexfind('[a-zA-z.]*[ ]*[a-zA-z.]*[ ]*[a-zA-z.]*,*[ ]*[a-zA-z?]*[a-zA-z?]*[ ]*[0-9]*-?[0-9]*',L.address4,0) <> '' => L.address4,
																L.address3 <> '' and 
                                regexfind('[a-zA-z.]*[ ]*[a-zA-z.]*[ ]*[a-zA-z.]*,*[ ]*[a-zA-z?]*[a-zA-z?]*[ ]*[0-9]*-?[0-9]*',L.address3,0) <> '' => L.address3,
																L.address2 <> '' and 
                                regexfind('[a-zA-z.]*[ ]*[a-zA-z.]*[ ]*[a-zA-z.]*,*[ ]*[a-zA-z?]*[a-zA-z?]*[ ]*[0-9]*-?[0-9]*',L.address2,0) <> '' => L.address2,
																L.address5 ='' and L.address4 = '' and L.address3 ='' and
																L.address2 ='' and L.address1 <> '' and 
																regexfind('[a-zA-z.]*[ ]*[a-zA-z.]*[ ]*[a-zA-z.]*,[ ]*[a-zA-z?]+[ ]*[0-9]*-?[0-9]*',L.address1,0) <> '' => L.address1,
																'');

string v_street          := MAP(L.address5 = v_city_st_zip => trim(trim(trim(trim(L.address1)+' '+ L.address2,LEFT,RIGHT)+' '+L.address3,LEFT,RIGHT)+' '+L.address4,LEFT,RIGHT),
                                L.address4 = v_city_st_zip => trim(trim(trim(L.address1)+' '+ L.address2,LEFT,RIGHT)+' '+L.address3,LEFT,RIGHT),
                                L.address3 = v_city_st_zip => trim(trim(L.address1)+' '+ L.address2,LEFT,RIGHT),
                                L.address2 = v_city_st_zip => trim(L.address1),
																'');

SELF.street              := if (v_street in remove_these, '',v_street);  
SELF.city_state_zip      := if (v_city_st_zip in remove_these, '',v_city_st_zip);  
SELF.numrows 						 := 0;
SELF :=L;

END;
SOR_addresses := project(Fil_Normed_address_1, change_layout_address(LEFT));
//---------------------------------------------------------------------------------------------------------------------------------------------------
// Extract addresses from Addl_comments
addrRec_temp2 Extract_addr_frm_comm(D_offendermain  L) := TRANSFORM

integer numrows := stringlib.StringFindCount(L.Addl_comments_1,';');
string lastchar := L.Addl_comments_1[length(L.Addl_comments_1)];
SELF.numRows    := If (lastchar =';',numrows,numrows+1);
SELF.theaddr    := If (lastchar =';',L.Addl_comments_1,L.Addl_comments_1+';');
SELF.Addr_type  := '';
SELF.name       := '';
SELF.street  		:= '';
//SELF.street2 		:= '';
//SELF.city    		:= '';
SELF.city_state_zip	:= ''; 
SELF.county  		:= '';
SELF := L;
END;

Addr_addl_comments1 := project(d_OffenderMain(name_type ='0' and stringlib.stringfind(Addl_comments_1,'ADDRESS:',1 )>0),Extract_addr_frm_comm(LEFT),local);

addrRec_temp2 Extract_addr_frm_comm2(D_offendermain  L) := TRANSFORM

integer numrows := stringlib.StringFindCount(L.Addl_comments_2,';');
string lastchar := L.Addl_comments_2[length(L.Addl_comments_2)];
SELF.numRows    := If (lastchar =';',numrows,numrows+1);
SELF.theaddr    := If (lastchar =';',L.Addl_comments_2,L.Addl_comments_2+';');
SELF.Addr_type  := '';
SELF.name       := '';
SELF.street  		:= '';
//SELF.street2 		:= '';
//SELF.city    		:= '';
SELF.city_state_zip	:= ''; 
SELF.county  		:= '';
SELF := L;
END;
Addr_addl_comments2 := project(d_OffenderMain(name_type ='0' and stringlib.stringfind(Addl_comments_2,'ADDRESS:',1 )>0),Extract_addr_frm_comm2(LEFT),local);

Combine_addresses   := Addr_addl_comments1+Addr_addl_comments2;
//--------------------------------------------------------------------------------------------------------------------------------------------
//Normalize addresses from Addl_comments
addrRec_temp2 Norm_address(addrRec_temp2  L, INTEGER Cnt) := TRANSFORM

integer nth_address_loc  := stringlib.stringfind(trim(L.theaddr),';',cnt);
integer nth_minus1_loc   := IF(cnt =1, 0, stringlib.stringfind(L.theaddr,';',cnt-1));

string  v_the_address    := stringlib.stringfindreplace(L.theaddr[nth_minus1_loc+1..nth_address_loc-1], 'COMMENTS:','');
SELF.theaddr             := v_the_address;

integer first_colon      := stringlib.stringfind(v_the_address,'ADDRESS:',1);

string v_Addr_type       := trim(If(first_colon >0, v_the_address[1..first_colon+6],''),LEFT,RIGHT);

SELF.Addr_type           := trim(stringlib.stringfindreplace(regexfind('[ ]*[a-zA-z.]*[ ]ADDRESS',v_Addr_type,0),'ADDRESS',''),LEFT,RIGHT); 

string  v_addr_noaddtype := trim(If(first_colon >0, v_the_address[first_colon..],v_the_address),LEFT,RIGHT);  

integer county_exists    := stringlib.stringfind(v_addr_noaddtype,', COUNTY',1);

SELF.county 						 := IF (county_exists >0 ,v_addr_noaddtype[county_exists+10..] ,'');

string v_addr_nocounty   := IF (county_exists >0 ,v_addr_noaddtype[1..county_exists-1] ,v_addr_noaddtype);

string v_state_zip1      := regexfind(', [a-zA-z.]*[ ]*[a-zA-z.]*[ ]*[a-zA-z.]*,[ ][a-zA-z][a-zA-z]+[ ]*[0-9][0-9][0-9][0-9][0-9]-?[0-9]*',v_addr_nocounty,0);
string v_state_zip2      := regexfind(': [a-zA-z.]*[ ]*[a-zA-z.]*[ ]*[a-zA-z.]*,[ ][a-zA-z][a-zA-z]+[ ]*[0-9][0-9][0-9][0-9][0-9]-?[0-9]*',v_addr_nocounty,0);
string v_state_zip3      := regexfind(', [a-zA-z.]*[ ]*[a-zA-z.]*[ ]*[a-zA-z.]*,[ ][a-zA-z][a-zA-z]+[ ]*[0-9]*-?[0-9]*',v_addr_nocounty,0);
string v_state_zip4      := regexfind(': [a-zA-z.]*[ ]*[a-zA-z.]*[ ]*[a-zA-z.]*,[ ][a-zA-z][a-zA-z]+[ ]*[0-9]*-?[0-9]*',v_addr_nocounty,0);
string v_state_zip5      := regexfind(',[ ][a-zA-z][]*[a-zA-z]*[ ]*[0-9]*-?[0-9]*',v_addr_nocounty,0);
string v_state_zip6      := regexfind(':[ ][a-zA-z][]*[a-zA-z]*[ ]*[0-9]*-?[0-9]*',v_addr_nocounty,0);

SELF.city_state_zip      := MAP (v_state_zip1 <> '' => v_state_zip1[3..],
                                 v_state_zip2 <> '' => v_state_zip2[3..],
								      		 	 	   v_state_zip3 <> '' => v_state_zip3[3..],
											      	   v_state_zip4 <> '' => v_state_zip4[3..],
																 v_state_zip5 <> '' => v_state_zip5[3..],
														     v_state_zip6[3..]); 

string v_addr_strcity    := MAP (v_state_zip1 <> '' => regexreplace(v_state_zip1,v_addr_nocounty,''),
                                 v_state_zip2 <> '' => regexreplace(v_state_zip2[2..],v_addr_nocounty,''),
													 		   v_state_zip3 <> '' => regexreplace(v_state_zip3,v_addr_nocounty,''),
														 		 v_state_zip4 <> '' => regexreplace(v_state_zip4[2..],v_addr_nocounty,''),
																 v_state_zip5 <> '' => regexreplace(v_state_zip5,v_addr_nocounty,''),
																 v_state_zip6 <> '' => regexreplace(v_state_zip6[2..],v_addr_nocounty,''),
																 v_addr_nocounty);
																
//SELF.theaddr           := v_addr_strcity;
integer street_pos       := stringlib.stringfind(v_addr_strcity,':',1);
integer first_comma      := stringlib.stringfind(v_addr_strcity,',',1);
string v_street          := IF(first_comma >0 , v_addr_strcity[street_pos+1..first_comma-1],v_addr_strcity[street_pos+1..]) ;

string v_addr_remaining  := IF(first_comma >0 ,trim(v_addr_strcity[first_comma+1 ..],LEFT,RIGHT),'');

integer second_comma     := stringlib.stringfind(v_addr_remaining,',',1);
string v_street3         := If (second_comma >0 ,trim(v_addr_remaining[second_comma+1..],LEFT,RIGHT),'');
string street3           := if (v_street3 in remove_these, '',v_street3);  
//self.city              := street3;
string v_street2         := trim(If (second_comma >0 ,trim(v_addr_remaining[1..second_comma-1],LEFT,RIGHT),v_addr_remaining),LEFT,RIGHT);
string v_cln_street2     := if (v_street2 in remove_these, '',v_street2);
//SELF.street2           := v_cln_street2;
SELF.street              := trim(trim(trim(v_street)+' '+ v_street2,LEFT,RIGHT)+' '+v_street3,LEFT,RIGHT);    
//sELF.city              := ;
SELF :=L;

END;

NormedAddress_2 := NORMALIZE(Combine_addresses,LEFT.numRows,Norm_address(LEFT,COUNTER),local);
fil_norm_addl_address := NormedAddress_2(Addr_type <> '');
//output(NormedAddress_1);

All_addresses   := fil_norm_addl_address+SOR_addresses;//SOR_addresses + fil_norm_addl_address;

//----------------------Clean the Addresses-----------------------------
  Layout_SOR_Address_out  Clean_addresses(addrRec_temp2 L) := TRANSFORM

 								 
  string182 tempAddressReturn := stringlib.StringToUpperCase(
										if(L.street <> '' or
										   L.city_state_zip <> '' ,
										   Address.CleanAddress182(
										   trim(L.street,left,right),
										   L.city_state_zip),''));
  self.street          := L.street;
	self.city_state_zip  := L.city_state_zip;
	self.prim_range   := tempAddressReturn[1..10];
	self.predir 	    := tempAddressReturn[11..12];
	self.prim_name 		:= tempAddressReturn[13..40];
	self.addr_suffix  := tempAddressReturn[41..44];
	self.postdir 			:= tempAddressReturn[45..46];
	self.unit_desig 	:= tempAddressReturn[47..56];
	self.sec_range 		:= tempAddressReturn[57..64];
	self.v_city_name	:= tempAddressReturn[90..114];
	self.st 					:= tempAddressReturn[115..116];
	self.zip 					:= tempAddressReturn[117..121];
	self.zip4					:= tempAddressReturn[122..125];
	self.geo_match 		:= tempAddressReturn[178];
	//self.err_stat 		:= tempAddressReturn[179..182];
	SELF := L; 
  end; 
	
  Address_List_cleaned   := PROJECT(All_addresses, Clean_addresses(LEFT),LOCAL) ;
//----------------------------------------------------------------------
//Extract registration address
//--------------------------------------------------------------------------
  Layout_SOR_Address_out	 Extract_RegAdr_SOR(D_offendermain R) := TRANSFORM
	
	SELf.Addr_type     := 'REGISTRATION';
												
  											
  STRING Vaddress1   := R.registration_address_1;
												
	STRING Vaddress2   := R.registration_address_2;					
												
	STRING Vaddress3   := IF(stringlib.stringfind(R.registration_address_3,'ADDRESS AS OF:',1) >0 or
	                         stringlib.stringfind(R.registration_address_3,'ADDRESS START DATE:',1)>0 or
											     stringlib.stringfind(R.registration_address_3,'TYPE:',1) >0 ,'', R.registration_address_3);
	
											
	STRING Vaddress4   := IF(stringlib.stringfind(R.registration_address_4,'ADDRESS AS OF:',1) >0 or
	                         stringlib.stringfind(R.registration_address_4,'ADDRESS START DATE:',1)>0 or
												   stringlib.stringfind(R.registration_address_4,'TYPE:',1) >0 or
												   stringlib.stringfind(R.registration_address_4,'ADDRESS STATUS:',1)>0  ,'',R.registration_address_4);
												
	STRING Vaddress5			 := IF(stringlib.stringfind(R.registration_address_5,'ADDRESS AS OF:',1) >0 or 
	                         stringlib.stringfind(R.registration_address_5,'ADDRESS START DATE:',1)>0 or 
													 stringlib.stringfind(R.registration_address_5,'ADDRESS STATUS:',1)>0 or
													 stringlib.stringfind(R.registration_address_5,'TYPE:',1) >0 or	
	                         stringlib.stringfind(R.registration_address_5,'SOURCE/ADDRESS VERIFIED:',1) >0  ,''	,R.registration_address_5);	

string v_city_st_zip     := MAP(vaddress5 <> '' and 
                                regexfind('[a-zA-z.]*[ ]*[a-zA-z.]*[ ]*[a-zA-z.]*,*[ ]*[a-zA-z?]*[a-zA-z?]*[ ]*[0-9]*-?[0-9]*',vaddress5,0) <> '' => vaddress5,
																vaddress4 <> '' and 
                                regexfind('[a-zA-z.]*[ ]*[a-zA-z.]*[ ]*[a-zA-z.]*,*[ ]*[a-zA-z?]*[a-zA-z?]*[ ]*[0-9]*-?[0-9]*',vaddress4,0) <> '' => vaddress4,
																vaddress3 <> '' and 
                                regexfind('[a-zA-z.]*[ ]*[a-zA-z.]*[ ]*[a-zA-z.]*,*[ ]*[a-zA-z?]*[a-zA-z?]*[ ]*[0-9]*-?[0-9]*',vaddress3,0) <> '' => vaddress3,
																vaddress2 <> '' and 
                                regexfind('[a-zA-z.]*[ ]*[a-zA-z.]*[ ]*[a-zA-z.]*,*[ ]*[a-zA-z?]*[a-zA-z?]*[ ]*[0-9]*-?[0-9]*',vaddress2,0) <> '' => vaddress2,
																vaddress5 ='' and vaddress4 = '' and vaddress3 ='' and
																vaddress2 ='' and vaddress1 <> '' and 
																regexfind('[a-zA-z.]*[ ]*[a-zA-z.]*[ ]*[a-zA-z.]*,[ ]*[a-zA-z?]+[ ]*[0-9]*-?[0-9]*',vaddress1,0) <> '' => vaddress1,
																'');

  string v_street       := MAP(vaddress5 = v_city_st_zip => trim(trim(trim(trim(vaddress1)+' '+ vaddress2,LEFT,RIGHT)+' '+vaddress3,LEFT,RIGHT)+' '+vaddress4,LEFT,RIGHT),
                               vaddress4 = v_city_st_zip => trim(trim(trim(vaddress1)+' '+ vaddress2,LEFT,RIGHT)+' '+vaddress3,LEFT,RIGHT),
                               vaddress3 = v_city_st_zip => trim(trim(vaddress1)+' '+ vaddress2,LEFT,RIGHT),
                               vaddress2 = v_city_st_zip => trim(vaddress1),
															'');

  SELF.street           := if (v_street in remove_these, '',v_street);  
  SELF.city_state_zip   := if (v_city_st_zip in remove_these, '',v_city_st_zip);  
																			
	SELF.county       := R.registration_county;
	                          
	SELF.geo_match    := '';
	SELF.zip          := R.zip5;
	SELF.zip4         := R.zip4;
	SELF.name         :='';
	//SELF.err_stat     :='';
  SELF:= R;
  end;
	
  SOR_RegAddress_List 	:= PROJECT(D_offendermain(name_type ='0'), Extract_RegAdr_SOR(LEFT), LOCAL);
	Fil_SOR_RegAddress_List := SOR_RegAddress_List(street <> '' or 
                                                 city_state_zip <> '' or 
																								 county   <> '');

export Mapping_Extract_SOR_Addresses := Address_List_cleaned +Fil_SOR_RegAddress_List ;//: persist('persist::Imap::SOR_addresses'); 