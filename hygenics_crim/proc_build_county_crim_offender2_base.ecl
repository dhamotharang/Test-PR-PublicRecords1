import NID,crim_common,did_add,didville,header,header_slimsort,ut,watchdog, address,AID,AID_Support;

def 	:= sort(distribute(hygenics_crim.file_in_defendant_counties(),hash(recordid)),recordid,local);
ah		:= dedup(sort(distribute(hygenics_crim.file_in_addresshistory_counties,hash(recordid)), recordid, local), record,local);
aka	  := dedup(sort(distribute(hygenics_crim.file_in_alias_counties(),hash(recordid)), recordid, local), record,local);
off 	:= hygenics_crim.file_in_offense_counties();

slimOffense_rec := RECORD 
  off.recordid;
	off.statecode;
	off.DocketNumber;
	off.CaseNumber;
	off.Casetitle;
	off.Casetype;
	off.Fileddate;
	off.Courtname;
	off.offensetype;
end;


slim_off := dedup(sort(distribute(project(off, slimOffense_rec),hash(recordid)), record, local), record,local);

def join_def_alias(def l, aka r) := transform 
  self.nametype 		:= 'A';
  self.Name 			  := r.AKAname;
  self.LastName 		:= r.AKAlastname;
  self.FirstName 		:= r.AKAfirstname;
  self.MiddleName 	:= r.AKAmiddlename;
  self.Suffix 			:= r.AKAsuffix;
  self.DOB 				  := Map(trim(r.akadob) ='19000101' => '',
	                         ((integer)stringlib.GetDateYYYYMMDD()[1..4])-((integer)r.akadob[1..4])>=18 => trim(r.akadob), 
								           '');
  self := l;
end;

def_with_alias := join(def, aka,
		left.recordid=right.recordid and 
		left.statecode=right.statecode,
		join_def_alias(left,right),local,nosort);
		


Layout_defplusaka := record
def;
string alias;
end;

//handle aka's - regexfind('([ -/;]AKA[ /-;])',name)
Layout_defplusaka pullaka(def L) := Transform	


	self.name := hygenics_crim._functions.strip_name_from_AKA(l.name,l.lastname,l.firstname,l.middlename,l.suffix);
	

	self.alias:= hygenics_crim._functions.strip_alias_from_AKA(l.name,l.lastname,l.firstname,l.middlename,l.suffix);

	self := l;
end;

defwith_aka := project(def(regexfind('([": ,-;/]AKA[": ,-;/])|[(]AKA',name)), pullaka(left),local);	


  
def NormAlias(defwith_aka L, INTEGER cnt) := TRANSFORM
	
  self.name 					 := MAP(cnt =1 => L.name,
	                            cnt =2 => L.alias,
	                            '');
																
	self.nametype 			 := IF (cnt =1, l.nametype, 'A');

  SELF 								 := L;
end;

def_and_aka := NORMALIZE(defwith_aka, 2 ,NormAlias(LEFT,COUNTER),local);

all_names 				:= def_and_aka(name <> '') + def_with_alias + def(regexfind('([": ,-;/]AKA[": ,-;/])|^[ ]*AKA[ ]*$|[(]AKA',name,0) ='') :persist ('~thor_data200::persist::crim::county::offender_all_names');

             
//output(choosen(all_names(recordid in setti),all),{recordid,lastname,firstname,nametype});  

all_unique_names_dedup	:= dedup(sort(all_names, record,local), record,local);
// all_unique_names		:= distribute(all_unique_names_dedup, hash(recordid));
// output(all_unique_names(recordid ='OHJEFFERSONTORONTO24465'));
def join_def_ah(def l, ah r) := transform 
  self := r;
  self := l;
end;

def_with_ahist := join(all_unique_names_dedup, ah,
		left.recordid=right.recordid and left.statecode=right.statecode,
		join_def_ah(left,right),local,nosort);
		
all_names_addresses := def_with_ahist+ all_unique_names_dedup;
// output(all_names_addresses(recordid ='OHJEFFERSONTORONTO24465'));
//Populate Address fields
addAddress_layout := record
	all_names_addresses;
	string street_address_1;
	string street_address_2;
	unsigned8 	append_Rawaid;
end;

addAddress_layout addrPop(all_names_addresses l):= transform

  vStreet               := MAP(l.street in _functions.StreetAddressToFilter => '',
		                           l.street);
	self.street_address_1 := vStreet+if(l.unit<>'', ' '+l.unit, '');
	self.street_address_2 := l.city+', '+l.orig_state+' '+l.orig_zip;
	self.append_Rawaid := 0;
	self := l;
end;

addrProject 	:= project(all_names_addresses, addrPop(left),local);

// Output(addrProject(recordid ='OHJEFFERSONTORONTO24465'));		 
layout_temp_offender := record
 
 hygenics_crim.layout_in_defendant;
 //string115	TempName;
 string40	j_RecordID;
 string2	j_StateCode;
 string1  name_type_hd;
 string115 j_Name;
 string50	 j_LastName;
 string50	 j_FirstName;
 string40	 j_MiddleName; 
 string15	 j_Suffix;
 string8	 j_DOB;
 
 string20	 j_AddressType;
 string150 j_Street;
 string20	 j_Unit;
 string50	 j_City;
 string2	 j_State;
 string9	 j_Zip;
 
 string5  	title;
 string20 	fname;
 string20 	mname;
 string20 	lname;
 string5  	name_suffix;
 string3  	cleaning_score;
	
 string10 	prim_range;
 string2  	predir;
 string28 	prim_name;
 string4  	addr_suffix;
 string2  	postdir;
 string10 	unit_desig;
 string8  	sec_range;
 string25 	p_city_name;
 string25 	v_city_name;
 string2 	state;
 string5  	zip5;
 string4  	zip4;
 string4  	cart;
 string1  	cr_sort_sz;
 string4  	lot;
 string1  	lot_order;
 string2  	dpbc;
 string1  	chk_digit;
 string2  	rec_type;
 string2  	ace_fips_st;
 string3	ace_fips_county;
 string10 	geo_lat;
 string11 	geo_long;
 string4  	msa;
 string7  	geo_blk;
 string1  	geo_match;
 string4  	err_stat;
 
 unsigned6 	did	:= 0;
 unsigned1 	did_score := 0;
 string9 	ssn := '';

end;
//Address Cleaner	
/* Commented for AID change
layout_temp_offender clean_name_add (addrProject l) := transform
 self.j_RecordID 			:= l.recordid;
 self.j_StateCode 		:= l.statecode;
 self.name_type_hd    := l.nametype; // added this b/c NID cleaner over writes this field.

 clean_addr 				:= Address.CleanAddress182(l.street_address_1, l.street_address_2);
 

 self.prim_range 		  	:= clean_addr[1..10];
 self.predir 			    := clean_addr[11..12];
 self.prim_name 		  	:= clean_addr[13..40];
 self.addr_suffix 		  	:= clean_addr[41..44];
 self.postdir 			  	:= clean_addr[45..46];
 self.unit_desig 		  	:= clean_addr[47..56];
 self.sec_range 		  	:= clean_addr[57..64];
 self.p_city_name 			:= clean_addr[65..89];
 self.v_city_name 			:= clean_addr[90..114];
 self.state 			    := clean_addr[115..116];
 self.zip5 				    := clean_addr[117..121];
 self.zip4 				    := clean_addr[122..125];
 self.cart 				    := clean_addr[126..129];
 self.cr_sort_sz 		  	:= clean_addr[130];
 self.lot 				    := clean_addr[131..134];
 self.lot_order 		  	:= clean_addr[135];
 self.dpbc 				    := clean_addr[136..137];
 self.chk_digit 		  	:= clean_addr[138];
 self.rec_type 			  	:= clean_addr[139..140];
 self.ace_fips_st 			:= clean_addr[141..142];
 self.ace_fips_county		:= clean_addr[143..145];
 self.geo_lat 			  	:= clean_addr[146..155];
 self.geo_long 			  	:= clean_addr[156..166];
 self.msa 				    := clean_addr[167..170];
 self.geo_blk 			  	:= clean_addr[171..177];
 self.geo_match 		 	:= clean_addr[178];
 self.err_stat 			  	:= clean_addr[179..182];
  
 self.name        := MAP(l.name ='' => l.firstname+' '+l.middlename+' '+l.lastname+' '+l.suffix ,
                         regexfind('(.*) #VALUE! (.*)',l.name) => regexreplace('(.*) #VALUE! (.*)',l.name,'$1 $2'),
												 regexfind('(.*) [0-9]+ (.*)',l.name) => regexreplace('(.*) [0-9]+ (.*)',l.name,'$1 $2'),
                         l.name);  
 self 						:= l;
 self 						:= [];
end;
cleanAddress := project(addrProject, clean_name_add(left),local): INDEPENDENT;
*/
//AID Address cleaner

	unsigned4 lAIDAppendFlags		:= AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords| AID.Common.eReturnValues.NoNewCacheFiles;
  #constant(AID_Support.Constants.StoredWhichAIDCache, AID_Support.Constants.eCache.ForNonHeader);			
	AID.MacAppendFromRaw_2Line(addrProject, street_address_1, street_address_2,append_Rawaid , addressCleaned, lAIDAppendFlags);
layout_temp_offender addressAppended(addressCleaned pInput) := transform

	self.j_RecordID 			    := pInput.recordid;
	self.j_StateCode 			    := pInput.statecode;
	self.name_type_hd         := pInput.nametype; // added this b/c NID cleaner over writes this field.
	 self.name                := MAP(pInput.name ='' => pInput.firstname+' '+pInput.middlename+' '+pInput.lastname+' '+pInput.suffix ,
                                   regexfind('(.*) #VALUE! (.*)',pInput.name) => regexreplace('(.*) #VALUE! (.*)',pInput.name,'$1 $2'),
												           regexfind('(.*) [0-9]+ (.*)',pInput.name) => regexreplace('(.*) [0-9]+ (.*)',pInput.name,'$1 $2'),
                                  pInput.name);
	//self.Append_RawAID				:= pInput.AIDWork_RawAID;
	self.prim_range 					:= pInput.AIDWork_ACECache.prim_range;
	self.predir 							:= pInput.AIDWork_ACECache.predir;
	self.prim_name 						:= pInput.AIDWork_ACECache.prim_name;
	self.addr_suffix 					:= pInput.AIDWork_ACECache.addr_suffix;
	self.postdir 							:= pInput.AIDWork_ACECache.postdir;
	self.unit_desig 					:= pInput.AIDWork_ACECache.unit_desig;
	self.sec_range 						:= pInput.AIDWork_ACECache.sec_range;
	self.p_city_name 					:= pInput.AIDWork_ACECache.p_city_name;
	self.v_city_name 					:= pInput.AIDWork_ACECache.v_city_name;
	self.state 								:= pInput.AIDWork_ACECache.st;
	self.zip5 								:= pInput.AIDWork_ACECache.zip5;
	self.zip4 								:= pInput.AIDWork_ACECache.zip4;
	self.cart 								:= pInput.AIDWork_ACECache.cart;
	self.cr_sort_sz 					:= pInput.AIDWork_ACECache.cr_sort_sz;
	self.lot 									:= pInput.AIDWork_ACECache.lot;
	self.lot_order 						:= pInput.AIDWork_ACECache.lot_order;
	self.dpbc 								:= pInput.AIDWork_ACECache.dbpc;
	self.chk_digit 						:= pInput.AIDWork_ACECache.chk_digit;
	self.rec_type 						:= pInput.AIDWork_ACECache.rec_type;
  self.ace_fips_st          := pInput.AIDWork_ACECache.county[1..2];
	self.ace_fips_county 			:= pInput.AIDWork_ACECache.county[3..];
	self.geo_lat 							:= pInput.AIDWork_ACECache.geo_lat;
	self.geo_long 						:= pInput.AIDWork_ACECache.geo_long;
	self.msa 									:= pInput.AIDWork_ACECache.msa;
	self.geo_blk 							:= pInput.AIDWork_ACECache.geo_blk;
	self.geo_match 						:= pInput.AIDWork_ACECache.geo_match;
	self.err_stat 						:= pInput.AIDWork_ACECache.err_stat;
	self											:= pInput;
	self 									    := [];
	end;
		
cleanAddress 		:= project(addressCleaned,addressAppended(left)): INDEPENDENT ;
//End Address clean
 //NID Name cleaner/////////////////////////////////

	nid.mac_cleanfullnames(cleanAddress, cleanfullnames, name);
	// nid.mac_cleanfullnames(cleanAddress, cleanfullnames, name,useV2:=true);

	cleanfullnames projFile(cleanfullnames l):= transform
		self := l;
	end;
	
	all_clean_name_addr := project(cleanfullnames, projFile(left),local):persist('~thor_200::persist::crimcty_offender_nid');
	
	with_ssn			:= all_clean_name_addr;


Layout_almostfinal_offender := record
 hygenics_crim.Layout_Common_Crim_Offender_orig;
 hygenics_crim.layout_in_defendant.recordid;
 end;
 
Layout_almostfinal_offender to_crim_offender(with_ssn l, slim_off r) := transform
 vVendor 				:= hygenics_crim._functions.fn_sourcename_to_vendor(trim(l.sourcename), trim(l.statecode));
 
 string temp_case_number:= MAP(stringlib.stringfind(r.casenumber,'HTTP/',1) >0 =>'',
                               r.casenumber);  

 //self.offender_key	:= hygenics_crim._functions.fn_offender_key(vVendor, l.recordid, temp_case_number, r.fileddate);				
  self.offender_key		:= MAP(l.name_type_hd ='A' => '',                               
															 hygenics_crim._functions.fn_persistent_offender_key(vVendor, l.name, l.dob, l.docnumber, l.inmatenumber, 
																					l.stateidnumber, l.fbinumber, temp_case_number, r.fileddate, '')
															 );	
 self.state_origin	:= l.statecode;
 self.vendor			  := vVendor;
 self.source_file		:= hygenics_crim._functions.fn_shorten_sourcename(trim(l.sourcename));
																	
 self.process_date	:= stringlib.getdateyyyymmdd();

 self.data_type			:= '2';
 self.case_number		:= temp_case_number;
 self.case_court		:= r.courtname;
 self.case_name			:= r.casetitle;
 self.case_type			:= '';
 self.case_type_desc	:= Map(l.sourcename ='FLORIDA_LEON_COUNTY' =>'',
                             l.sourcename ='CALIFORNIA_CONTRA_COSTA_COUNTY' => r.offensetype,
                             r.casetype);
 self.case_filing_dt	:= Map(trim(r.fileddate) ='19000101' => '',
                             length(r.fileddate)>=4 and trim(r.fileddate)[1..2] in ['19','20'] => trim(r.fileddate),
						                 '');
 self.pty_nm			  := if(l.lastname='' and l.name<>'',
									        trim(l.name),
									        trim(trim(trim(trim(l.firstname)+' '+trim(l.middlename))+' '+trim(l.lastname))+' '+trim(l.suffix)));
 self.pty_nm_fmt	  := if(l.lastname='' and l.name<>'','L',	'F');
 self.orig_lname		:= l.lastname;
 self.orig_fname		:= l.firstname;
 self.orig_mname		:= l.middlename;
 self.orig_name_suffix	:= l.suffix;
 
 //from NID cleaner
 	self.title               		:= l.cln_title;
	self.fname			     				:= l.cln_fname;
	self.mname			     				:= l.cln_mname;
	self.lname									:= l.cln_lname;
	self.name_suffix        		:= l.cln_suffix;
  //self.name_type							:= l.name_format;	
	self.nid										:= l.nid;	
	self.ntype									:= l.nametype;
	self.nindicator							:= l.name_ind;

 self.pty_typ			:= MAP(l.name_type_hd ='A' => '2', 
                            '0' );
 self.nitro_flag		:= '';
 self.orig_ssn			:= if(regexfind('[A-Z]+', l.orig_ssn, 0)='',
							            l.orig_ssn,
							            '');
 self.dle_num			:= l.stateidnumber;
 self.fbi_num			:= l.fbinumber;
 self.doc_num			:= l.docnumber;
 self.ins_num			:= l.aliennumber;
 self.id_num			:= l.inmatenumber;
 self.dl_num			:= l.dlnumber;
 self.dl_state		:= l.dlstate;

 self.citizenship	:= if(l.uscitizenflag='Y','US','');	

 self.dob				  := map(trim(l.dob) ='19000101' => '',
                         _functions.fn_validate_dt(l.dob,'')=1 and l.dob[1..2] in ['19','20'] and ((integer)stringlib.GetDateYYYYMMDD()[1..4])-((integer)l.dob[1..4])>=18 => trim(l.dob,left,right),
								         '');

 self.dob_alias			:= '';
 self.place_of_birth	:= trim(trim(l.birthcity)+' '+ l.birthplace);

 self.street_address_1	:= trim(l.street)+if(l.unit<>'', ' '+l.unit, '');
 self.street_address_2	:= trim(trim(trim(l.city)+' '+trim(l.orig_state))+' '+trim(l.orig_zip));
 self.street_address_3	:= '';
 self.street_address_4	:= '';
 self.street_address_5	:= '';
 
 self.race				  := if(length(trim(l.race))=1 and regexfind('[A-Z]', l.race, 0)<>'' , trim(l.race), '');
 
 string temp_race   := hygenics_crim._functions.fn_standarddize_race(l.race);
  				
 string temp_ethn   := hygenics_crim._functions.fn_standarddize_race(l.ethnicity);
 														 
 self.race_desc			:= If (temp_race <> '' ,trim(temp_race), trim(temp_ethn));
  
 self.sex				    := map(l.gender[1..1] in ['M','F'] => l.gender[1..1],
								       '');

 self.hair_color		:= MAP(   l.haircolor='GRAY/PARTI' => 'GRAY',
                              l.haircolor<>'' and regexfind('[0-9]',l.haircolor) =>'' ,
															trim(l.haircolor) in ['XX','UNK','XXX','N/A','!!!','---'] => '',
                              length(trim(l.haircolor)) <= 3 => trim(l.haircolor),
															''
													);
 self.hair_color_desc	:= hygenics_crim._functions.fn_standardize_haircolor(l.haircolor);  
 self.eye_color			  := MAP( l.eyecolor<>'' and regexfind('[0-9]',l.eyecolor) =>'' ,
                              trim(l.eyecolor) in ['XX','UNK','XXX','N/A','!!!','---'] => '',
                              length(trim(l.eyecolor)) <= 3 => trim(l.eyecolor) ,
														  ''
														);
 self.eye_color_desc	:= hygenics_crim._functions.fn_standardize_eyecolor(l.eyecolor);
                 
 self.skin_color			:= '';
 self.skin_color_desc	:= l.skincolor;
		
 self.height				  := hygenics_crim._functions.fn_height_to_inches(l.height);
 self.weight				  := if((integer) stringlib.stringfilter(l.weight,'1234567890')<>0,
								            stringlib.stringfilter(l.weight,'1234567890'),
								            '');							

 self.party_status	    := '';
 self.party_status_desc	:= if(l.statecode not in ['TN', 'NC', 'AR'],
								              l.defendantstatus,
								              '');

 //self.did					    := if(l.did<>0,intformat(l.did,12,1),	'');
 self.pgid						  := '';
 
 self.src_upload_date   := l.recorduploaddate;
 self.age               := l.age;
 self.image_link		:= if(trim(l.photoname, left, right)<>'',
							StringLib.StringToUpperCase(trim(vVendor)+'_'+l.photoname),
							'');

 self 							    := l;
end;

result_common1 := join(distribute(with_ssn ,hash(recordid)), 
                       slim_off, 
					             left.recordid=right.recordid and 
											 left.statecode=right.statecode,
					             to_crim_offender(left,right), 
					             left outer, local);//:persist ('~thor_data200::persist::crimtemp::aoc::offender_after_did_Vaani');



//Following code requird if we are using persistent offender_key - based on DOC numbers etc					
hygenics_crim.Layout_Common_Crim_Offender_orig transferkey (result_common1 L, result_common1 R) := transform
 self.offender_key   := r.offender_key;
 self.case_number    := r.case_number;
 self.case_filing_dt := r.case_filing_dt;
 self := L;
end; 					

result_aliases := join(result_common1(pty_typ ='2'),result_common1(pty_typ ='0'), 
					             left.recordid = right.recordid and left.state_origin = right.state_origin and 
											 (left.case_number= right.case_number or (left.case_number='' and right.case_number ='' )) and
											 (left.case_filing_dt = right.case_filing_dt or (left.case_filing_dt ='' and right.case_filing_dt ='')),
					             transferkey(left,right), 
					             local);

result_common2 := project(result_common1(pty_typ ='0'),hygenics_crim.Layout_Common_Crim_Offender_orig)+result_aliases;	

sorted_rcommon	:= sort(distribute(result_common2(trim(vendor, left, right)<>''),HASH(offender_key)), 
                        offender_key,case_number,case_court,case_name,case_type,case_type_desc,case_filing_dt,
                        pty_nm,pty_nm_fmt,orig_lname,orig_fname,orig_mname,orig_name_suffix,pty_typ,dle_num,fbi_num,doc_num,ins_num,id_num,dl_num,
												dl_state,dob,street_address_1,street_address_2,street_address_3,race,race_desc,sex,hair_color,hair_color_desc,eye_color,eye_color_desc,skin_color,skin_color_desc,
                        height,weight,party_status,party_status_desc,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,
												v_city_name,state,zip5,title,fname,mname,lname,name_suffix,Age,image_link, local):INDEPENDENT;
									

sorted_rcommon rollupCrim(sorted_rcommon L, sorted_rcommon R) := TRANSFORM
  self.case_court				:= if(l.case_court = '', r.case_court, l.case_court);
  self.dle_num          := if(l.dle_num  = '', r.dle_num , l.dle_num );
	self.fbi_num          := if(l.fbi_num  = '', r.fbi_num , l.fbi_num );
	self.doc_num          := if(l.doc_num  = '', r.doc_num , l.doc_num );
	self.ins_num          := if(l.ins_num  = '', r.ins_num , l.ins_num );
	self.id_num           := if(l.id_num   = '', r.id_num  , l.id_num  );
	self.dl_num           := if(l.dl_num   = '', r.dl_num  , l.dl_num  );
	self.dl_state         := if(l.dl_state = '', r.dl_state, l.dl_state);
	
	self.sex				      := if(l.sex               = '', r.sex            , l.sex);
	self.race     		    := if(l.race              = '', r.race           , l.race);
	self.race_desc		    := if(l.race_desc         = '', r.race_desc      , l.race_desc);
	self.eye_color        := if(l.eye_color         = '', r.eye_color      , l.eye_color      );
	self.eye_color_desc   := if(l.eye_color_desc    = '', r.eye_color_desc , l.eye_color_desc );
	self.hair_color       := if(l.hair_color        = '', r.hair_color     , l.hair_color     );
	self.hair_color_desc  := if(l.hair_color_desc   = '', r.hair_color_desc, l.hair_color_desc);
	self.skin_color       := if(l.skin_color        = '', r.skin_color     , l.skin_color     );
	self.skin_color_desc  := if(l.skin_color_desc   = '', r.skin_color_desc, l.skin_color_desc);
	
	self.height		        := if(l.height            = '', r.height           , l.height           );
	self.weight		        := if(l.weight            = '', r.weight           , l.weight           );
	self.street_address_1	:= if(l.street_address_1  = '', r.street_address_1 , l.street_address_1 );
	self.street_address_2	:= if(l.street_address_2  = '', r.street_address_2 , l.street_address_2 );
	self.party_status_desc:= if(l.party_status_desc = '', r.party_status_desc, l.party_status_desc);
	self.age	            := if(l.age               = '', r.age              , l.age              );
	self.image_link	      := if(l.image_link        = '', r.image_link       , l.image_link       );
											
  self.prim_range 		  := if(l.prim_range 		  = '', r.prim_range 		 , l.prim_range 	  );	
	self.predir 				  := if(l.predir 				  = '', r.predir 				 , l.predir 			  );
  self.prim_name 		    := if(l.prim_name 			= '', r.prim_name 		 , l.prim_name 		  );
	self.addr_suffix 		  := if(l.addr_suffix 		= '', r.addr_suffix 	 , l.addr_suffix 	  );	
	self.postdir 				  := if(l.postdir 				= '', r.postdir 			 , l.postdir 			  );
  self.unit_desig 		  := if(l.unit_desig 			= '', r.unit_desig 		 , l.unit_desig 	  );
	self.sec_range 			  := if(l.sec_range 			= '', r.sec_range 		 , l.sec_range 		  );
	self.p_city_name 		  := if(l.p_city_name 		= '', r.p_city_name 	 , l.p_city_name 	  );	
	self.v_city_name 			:= if(l.v_city_name 		= '', r.v_city_name 	 , l.v_city_name 	  );
  self.state 		        := if(l.state 			    = '', r.state 		     , l.state 	        );
	self.zip5 			      := if(l.zip5 			      = '', r.zip5 		       , l.zip5 		      );
	self.zip4 					  := if(l.zip4 					  = '', r.zip4 					 , l.zip4 					);
	self.cart 					  := if(l.cart 					  = '', r.cart 					 , l.cart 					);
	self.cr_sort_sz 		  := if(l.cr_sort_sz 		  = '', r.cr_sort_sz 		 , l.cr_sort_sz 		);
	self.lot 						  := if(l.lot 						= '', r.lot 					 , l.lot 						);
	self.lot_order 			  := if(l.lot_order 			= '', r.lot_order 		 , l.lot_order 			);
	self.dpbc 					  := if(l.dpbc 					  = '', r.dpbc 					 , l.dpbc 					);
	self.chk_digit 			  := if(l.chk_digit 			= '', r.chk_digit 		 , l.chk_digit 			);
	self.rec_type 			  := if(l.rec_type 			  = '', r.rec_type 			 , l.rec_type 			);
	self.ace_fips_st      := if(l.ace_fips_st     = '', r.ace_fips_st    , l.ace_fips_st    );
	self.ace_fips_county  := if(l.ace_fips_county = '', r.ace_fips_county, l.ace_fips_county);
	self.geo_lat 				  := if(l.geo_lat 				= '', r.geo_lat 			 , l.geo_lat 				);
	self.geo_long 			  := if(l.geo_long 			  = '', r.geo_long 			 , l.geo_long 			);
	self.msa 						  := if(l.msa 						= '', r.msa 					 , l.msa 						);
	self.geo_blk 				  := if(l.geo_blk 				= '', r.geo_blk 			 , l.geo_blk 				);
	self.geo_match 			  := if(l.geo_match 			= '', r.geo_match 		 , l.geo_match 			);
	self.err_stat 			  := if(l.err_stat 			  = '', r.err_stat 			 , l.err_stat 			);
	
	SELF 							:= L; 
END;

								 
rollupCrimOut := ROLLUP(sorted_rcommon,
                        left.offender_key          = right.offender_key and 
												trim(left.Case_number)     = trim(right.Case_number) and
												trim(left.case_type_desc)  = trim(right.case_type_desc) and
												trim(left.case_filing_dt)  = trim(right.case_filing_dt) and
												trim(left.pty_nm)          = trim(right.pty_nm) and 
												trim(left.orig_lname)      = trim(right.orig_lname) and 
												trim(left.orig_fname)      = trim(right.orig_fname) and 
												trim(left.orig_mname)      = trim(right.orig_mname) and 
												trim(left.orig_name_suffix)= trim(right.orig_name_suffix) and
												trim(left.dob)             = trim(Right.dob)    and 
												(left.case_court       =	right.case_court 		    or  right.case_court 		    =''	or left.case_court 		    ='') and
												(left.dle_num          =	right.dle_num           or  right.dle_num           ='' or left.dle_num           ='') and
												(left.fbi_num          =	right.fbi_num           or  right.fbi_num           ='' or left.fbi_num           ='') and
												(left.doc_num          =	right.doc_num           or  right.doc_num           ='' or left.doc_num           ='') and
												(left.ins_num          =	right.ins_num           or  right.ins_num           ='' or left.ins_num           ='') and
												(left.id_num           =	right.id_num            or  right.id_num            ='' or left.id_num            ='') and				
												(left.dl_num           =	right.dl_num            or  right.dl_num            ='' or left.dl_num            ='') and
												(left.dl_state         =	right.dl_state          or  right.dl_state          ='' or left.dl_state          ='') and
												(left.street_address_1 =	right.street_address_1 	or  right.street_address_1  =''	or left.street_address_1 	='') and 	
												(left.street_address_2 =	right.street_address_2 	or  right.street_address_2  =''	or left.street_address_2 	='') and 	
												(left.race             =	right.race              or  right.race              ='' or left.race              ='') and
												(left.race_desc        =	right.race_desc         or  right.race_desc         ='' or left.race_desc         ='') and
												(left.sex              =	right.sex               or  right.sex               ='' or left.sex               ='') and
												(left.hair_color       =  right.hair_color        or  right.hair_color        =''	or left.hair_color        ='') and												
												(left.hair_color_desc  =  right.hair_color_desc   or  right.hair_color_desc   =''	or left.hair_color_desc   ='') and
												(left.eye_color        =  right.eye_color         or  right.eye_color         =''	or left.eye_color         ='') and
												(left.eye_color_desc   =  right.eye_color_desc    or  right.eye_color_desc    =''	or left.eye_color_desc    ='') and												
												(left.skin_color       =  right.skin_color        or  right.skin_color        =''	or left.skin_color        ='') and
												(left.skin_color_desc  =  right.skin_color_desc   or  right.skin_color_desc   =''	or left.skin_color_desc   ='') and												
												(left.height 				   =	right.height 		        or  right.height 		        =''	or left.height 		        ='') and
												(left.weight 				   =	right.weight 		        or  right.weight 		        =''	or left.weight 		        ='') and	
												(left.party_status_desc=	right.party_status_desc or  right.party_status_desc =''	or left.party_status_desc ='') and
												
												//Did not include the rest of the address fields as they are in street_address 1 and 2. sometimes the below field do not fit into address 1&2.
												(left.addr_suffix 		 =	right.addr_suffix 		  or  right.addr_suffix 	=''	or left.addr_suffix 	 ='') and
												(left.postdir 				 =	right.postdir 		      or  right.postdir 		  =''	or left.postdir 		   ='') and	
												(left.unit_desig 			 =	right.unit_desig 		    or  right.unit_desig 		=''	or left.unit_desig 		 ='') and
												(left.sec_range 			 =	right.sec_range 		    or  right.sec_range 		=''	or left.sec_range 		 ='') and												
												(left.age 				     =	right.age 		          or  right.age 		      =''	or left.age 		       ='') and
												(left.image_link 			 =	right.image_link 		    or  right.image_link 	  =''	or left.image_link 		 ='') 
												, 
												rollupCrim(LEFT,RIGHT),local);


//REMOVE RECORDS WITH NO VENDOR CODE ASSIGNED////////////////////////////////////
result_common := dedup(sort(rollupCrimOut, record,local), 
                 record, except pty_typ, left,local) : persist ('~thor_data200::persist::hygenics::crim::HD::county::offender_withIndepDL');

// output(result_common(offender_key in Set_offender_key))	;
export proc_build_county_crim_offender2_base := result_common;  //sequential(o1);