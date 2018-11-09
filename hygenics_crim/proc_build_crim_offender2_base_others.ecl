import crim_common,did_add,didville,header,header_slimsort,ut,watchdog, address,nid;

def 	:= sort(distribute(hygenics_crim.file_in_defendant(statecode in ['PA','NC','OR']),hash(recordid,sourceid)), recordid,sourceid, local);
ah		 := dedup(sort(distribute(hygenics_crim.file_in_addresshistory(statecode in ['PA','NC','OR']),hash(recordid,sourceid)), recordid,sourceid, local), record);
aka	 := dedup(sort(distribute(hygenics_crim.file_in_alias(statecode in ['PA','NC','OR']),hash(recordid,sourceid)), recordid,sourceid, local), record);
off 	:= dedup(sort(distribute(hygenics_crim.file_in_offense(statecode in ['PA','NC','OR']),hash(recordid,sourceid)), recordid,sourceid, local), record);

	slimOffense_rec := RECORD 
		off.recordid;
		off.statecode;
		off.DocketNumber;
		off.CaseNumber;
		off.Casetitle;
		off.Casetype;
		off.Fileddate;
		off.Courtname;
		off.sourceid;
	end;

	slimOffense_rec slimOff(off l):= transform
		self := l;
	end;

slim_off := project(off, slimOff(left),local);

	def join_def_alias(def l, aka r) := transform 
	  self.nametype 		:= 'A';
	  self.Name 			:= r.AKAname;
	  self.LastName 		:= r.AKAlastname;
	  self.FirstName 		:= r.AKAfirstname;
	  self.MiddleName 		:= r.AKAmiddlename;
	  self.Suffix 			:= r.AKAsuffix;
	  self.DOB 				:= if(((integer)stringlib.GetDateYYYYMMDD()[1..4])-((integer)r.akadob[1..4])>=18,
									r.akadob, 
									'');
	  self := l;
	end;

def_with_alias := join(def, aka,
		left.recordid=right.recordid and 
		left.sourceid=right.sourceid,
		join_def_alias(left,right),local,nosort);

all_names 				:= def_with_alias + def;// :persist ('~thor_data200::persist::crim::aoc::offender_all_names_pa_nc_or');
all_unique_names_dedup	:= dedup(sort(all_names, record,local), record,local);

//Adding a flag to be used for sort below to ensure that the def address gets selected when available
temp_layout :=record
def;
string sortflag := '';
end;
	temp_layout join_def_ah(def l, ah r) := transform 
	  self := r;
	  self := l;
	end;

	def_with_ahist := join(all_unique_names_dedup, ah,
		left.recordid=right.recordid and 
		left.sourceid=right.sourceid,
		join_def_ah(left,right),local,nosort);
		
all_names_addresses := def_with_ahist+ project(all_unique_names_dedup,transform(temp_layout,self:=Left; self.sortflag := 'P'));

	layout_temp_offender addrPop(all_names_addresses l):= transform
		self.street_address_1 := if(regexfind('[A-Z]+', stringlib.stringtouppercase(l.street), 0)<>'',
									              trim(l.street+if(l.unit<>'', ' '+l.unit, ''), left, right),
									              '');
		self.street_address_2 :=_functions.CleanAddress(l.city+', '+l.orig_state+' '+l.orig_zip);
		self.name_type_hd     := L.sortflag; // use this field temporarily to store the sort flag. It gets overwritten later.
		
		self := l;
		self := [];
	end;

addrProject 	:= project(all_names_addresses, addrPop(left));

//Rollup Addresses
sorted_rcommon	:= sort(distribute(addrProject, hash(recordid,sourceid)), recordid, sourceid, name, dob,  
						-street, -unit, -city, -orig_state, -orig_zip,
						-street_address_1, -street_address_2,local);
						
sorted_rcommon rollupCrim(sorted_rcommon L, sorted_rcommon R) := TRANSFORM
	self.street						:= if(l.street = '', r.street, l.street);
	self.unit						:= if(l.unit = '', r.unit, l.unit);
	self.city						:= if(l.city = '', r.city, l.city);
	self.orig_state					:= if(l.orig_state = '', r.orig_state, l.orig_state);
	self.orig_zip      				:= if(l.orig_zip = '', r.orig_zip, l.orig_zip);
	self.street_address_1			:= if(l.street_address_1 = '', r.street_address_1, l.street_address_1);
	self.street_address_2			:= if(l.street_address_2 = '', r.street_address_2, l.street_address_2);
	SELF 							:= L; 
END;

rollupAddrOut := ROLLUP(sorted_rcommon,
                        left.recordid = right.recordid and 
						trim(left.sourceid) = trim(right.sourceid) and 
						trim(left.name) = trim(Right.name) and 
						trim(left.dob) = trim(Right.dob), 
						rollupCrim(LEFT,RIGHT));
						 

layout_temp_offender clean_name_add (rollupAddrOut l) := transform
 self.j_RecordID 			:= l.recordid;
 self.j_StateCode 		:= l.statecode;
 self.name_type_hd    := l.nametype; // added this b/c NID cleaner over writes this field.
 self.name          := MAP(l.name ='' => l.firstname+' '+l.middlename+' '+l.lastname+' '+l.suffix ,
                           l.name); 

 SELF 							      := L; 
end;

cleanAddress_prep := project(rollupAddrOut, clean_name_add(left)): INDEPENDENT;//:persist ('~thor_data200::persist::crim::aoc::offender_before_did_pa_nc_or');

cleanAddress := hygenics_crim._fns_AddressCleaner(cleanAddress_prep):persist ('~thor_data200::persist::crim::AOCPANCORAddresscache');
//NID Name cleaner/////////////////////////////////

	nid.mac_cleanfullnames(cleanAddress, cleanfullnames, name);
	// nid.mac_cleanfullnames(cleanAddress, cleanfullnames, name,useV2:=true);

	cleanfullnames projFile(cleanfullnames l):= transform
		self := l;
	end;
	
	all_clean_name_addr := 	project(cleanfullnames, projFile(left)):persist('~thor_200::persist::crimoth_offender_nid');
	
with_ssn			:= all_clean_name_addr;

sort_with_ssn := distribute(with_ssn, hash(recordid,sourceid)); //dedup(sort(distribute(with_ssn, hash(recordid)), recordid, local), record, local);//:persist('~thor_data200::persist::crim::aoc::offender_after_did_pa_nc_or');
sort_slim_off := slim_off ; //dedup(sort(distribute(slim_off, hash(recordid)), recordid, local), record, local);

Layout_almostfinal_offender := record
 Layout_Common_Crim_Offender_orig;
 hygenics_crim.layout_in_defendant.recordid;
 hygenics_crim.layout_in_defendant.sourceid;
end;
 
Layout_almostfinal_offender to_crim_offender(sort_slim_off l, sort_with_ssn r) := transform
 vVendor 				:= hygenics_crim._functions.fn_sourcename_to_vendor(trim(r.sourcename), trim(r.statecode));
 
 string temp_case_number:= if(l.casenumber <> '', 
								l.casenumber,
								if(l.DocketNumber <> '', 
								l.DocketNumber,
								''));

 self.offender_key		:= hygenics_crim._functions.fn_persistent_offender_key(vVendor, r.name, r.dob, r.docnumber, r.inmatenumber, 
																					r.stateidnumber, r.fbinumber, l.casenumber, l.fileddate, l.casetype);
							//hygenics_crim._functions.fn_offender_key(vVendor, r.recordid, temp_case_number, l.fileddate);				
 self.state_origin		:= r.statecode;
 self.vendor			:= vVendor;
 self.source_file		:= hygenics_crim._functions.fn_shorten_sourcename(r.sourcename);
																	
 self.process_date		:= stringlib.getdateyyyymmdd();

 self.data_type			:= '2';
 self.case_number		:= l.casenumber;
 
   		get_court_desc :=
	           MAP(r.sourcename = 'ALASKA_ADMINISTRATOR_OF_THE_COURTS' => Trim(regexreplace('(.*- )(.*)',l.courtname,'$2')),   
										r.sourcename = 'ARIZONA_ADMINISTRATOR_OF_THE_COURTS' => Trim(regexreplace('(.*- )(.*)',l.courtname,'$2')),            
										r.sourcename = 'HAWAII_STATE_JUDICIARY   ' => Trim(regexreplace('(.*-[ ])([A-Z]+.*)',l.courtname ,('$2'))),            
										r.sourcename = 'INDIANA_ADMINISTRATOR_OF_THE_COURTS' => Trim(l.courtname),            
										r.sourcename = 'MARYLAND_ADMINISTRATOR_OF_THE_COURTS' => Trim(regexreplace('([A-Z .\']+)-.*',l.courtname,'$1')),            
										r.sourcename = 'MINNESOTA_DEPARTMENT_OF_PUBLIC_SAFETY' => Trim(l.courtname),            
										r.sourcename = 'MISSOURI_ADMINISTRATOR_OF_THE_COURTS' => Trim(l.courtname),            
										r.sourcename = 'NEW_MEXICO_ADMINISTRATOR_OF_THE_COURTS' => Trim(l.courtname),            
										r.sourcename = 'NORTH_DAKOTA_ADMINISTRATOR_OF_THE_COURTS' => Trim(l.courtname),            
										r.sourcename = 'OREGON_ADMINISTRATOR_OF_THE_COURTS' => Trim(regexreplace('.*- ([A-Z ]+)',l.courtname,'$1')),            
										r.sourcename = 'RHODE_ISLAND_ADMINISTRATOR_OF_THE_COURTS' => Trim(regexreplace('(.*- )(.*)',l.courtname,'$2')),            
										r.sourcename = 'RHODE_ISLAND_ADMINISTRATOR_OF_THE_COURTS_TRAFFIC' => Trim(regexreplace('(.*- )(.*)',l.courtname,'$2')),            
										r.sourcename = 'TENNESSEE_ADMINISTRATOR_OF_THE_COURTS' => regexreplace('(.*- )(.*)',l.courtname,'$2'),            
										r.sourcename = 'TEXAS_DEPARTMENT_OF_PUBLIC_SAFETY' => Trim(l.courtname),            
										r.sourcename = 'UTAH_ADMINISTRATOR_OF_THE_COURTS' => Trim(regexreplace('(.*- )(.*)',l.courtname,'$2')),   
										r.sourcename = 'VIRGINIA_ADMINISTRATOR_OF_THE_COURTS' => Trim( map(
																																																											regexfind('(.*- )(.*)(-[ A-Z]+)',l.courtname)
																																																													=> regexreplace('(.*- )(.*)(-[ A-Z]+)',l.courtname,'$2$3'),	
																																																																		regexfind('(.*- )(.*)',l.courtname)
																																																																				 => regexreplace('(.*- )(.*)',l.courtname,'$2')
																																																																									,'')), 
										r.sourcename='MINNESOTA_DEPARTMENT_OF_PUBLIC_SAFETY'  => 
																																						map(regexfind('([A-Z ]+)(CO DISTRICT COURT.*)',l.courtname)
																																													=> l.courtname,
																																															 regexfind('([A-Z ]+)(DIST COURT.*)',l.courtname)
																																																	 => l.courtname,
																																																			regexfind('([A-Z ]+)(COUNTY.*)',l.courtname)
																																																				 => l.courtname,
																																																							regexfind('([A-Z ]+)(CO COURT.*)',l.courtname)
																																																							 => l.courtname																								
																																																															,'')	,																																																																		
																																																																									
																																																																									
																																																																											'');
 
 self.case_court		:= get_court_desc; 
 
            // if(trim(l.courtname, left, right)='AGENCY UNKNOWN',
								// '',
								// l.courtname);
								
 self.case_name			:= l.casetitle;
 self.case_type			:= '';
 self.case_type_desc	:= if(r.statecode='FL',
								'',
								l.casetype);
 self.case_filing_dt	:= if(length(l.fileddate)>4 and trim(l.fileddate)[1..2] in ['19','20'] and trim(l.fileddate, left, right)[5..6] in ['01','02','03','04','05','06','07','08','09','10','11','12'],
						        trim(l.fileddate),
							if(length(l.fileddate)=4 and trim(l.fileddate)[1..2] in ['19','20'],
						        trim(l.fileddate),
						        ''));
 self.pty_nm			:= if(r.lastname='' and r.name<>'',
									trim(r.name),
									trim(trim(trim(trim(r.firstname)+' '+trim(r.middlename))+' '+trim(r.lastname))+' '+trim(r.suffix)));
 self.pty_nm_fmt		:= if(r.lastname='' and r.name<>'',
									'L',
									'F');
 self.orig_lname		:= r.lastname;
 self.orig_fname		:= r.firstname;
 self.orig_mname		:= r.middlename;
 self.orig_name_suffix	:= r.suffix;
 //from NID cleaner
	self.title               		:= r.cln_title;
	self.fname			     				:= r.cln_fname;
	self.mname			     				:= r.cln_mname;
	self.lname									:= r.cln_lname;
	self.name_suffix        		:= r.cln_suffix;
  //self.name_type							:= r.name_format;	
	self.nid										:= r.nid;	
	self.ntype									:= r.nametype;
	self.nindicator							:= r.name_ind;
	
 self.pty_typ			:= MAP(r.name_type_hd ='A' => '2', 
                            '0' );
 self.nitro_flag		:= '';
 self.orig_ssn			:= r.orig_ssn;
 self.dle_num			:= r.stateidnumber;
 self.fbi_num			:= r.fbinumber;
 self.doc_num			:= r.docnumber;
 self.ins_num			:= r.aliennumber;
 self.id_num			:= r.inmatenumber;
 self.dl_num			:= r.dlnumber;
 self.dl_state			:= r.dlstate;

 self.citizenship		:= if(r.uscitizenflag='Y','US','');	

 self.dob				:= if(r.dob[1..2] in ['19','20'] and ((integer)stringlib.GetDateYYYYMMDD()[1..4])-((integer)r.dob[1..4])>=18 and r.name_type_hd<>'A',
								trim(r.dob,left,right),
								'');
 self.dob_alias			:= if(r.dob[1..2] in ['19','20'] and ((integer)stringlib.GetDateYYYYMMDD()[1..4])-((integer)r.dob[1..4])>=18 and r.name_type_hd='A',
								trim(r.dob,left,right),
								'');
 self.place_of_birth	:= trim(trim(r.birthcity)+' '+ r.birthplace);

 self.street_address_1	:= trim(r.street)+if(r.unit<>'', ' '+r.unit, '');
 self.street_address_2	:= trim(trim(trim(r.city)+' '+trim(r.orig_state))+' '+trim(r.orig_zip));
 self.street_address_3	:= '';
 self.street_address_4	:= '';
 self.street_address_5	:= '';
 
 self.race				:= if(length(trim(r.race))=1 and regexfind('[A-Z]', stringlib.stringtouppercase(r.race), 0)<>'' , trim(r.race), '');
 
							
 string temp_ethn   := MAP(r.ethnicity in ['UNKNOWN', 'INVALID', 'NONE', ''] => '',
							         r.ethnicity = 'AMER.' => 'AMERICAN',
								       r.ethnicity <> '' => r.ethnicity,
								       '');
															 
 self.race_desc			:= IF (hygenics_crim._functions.fn_standarddize_race(r.race)='', 
			                     hygenics_crim._functions.fn_standarddize_race(r.ethnicity),
								           hygenics_crim._functions.fn_standarddize_race(r.race));
 
                /*if(trim(temp_ethn, left, right) <> '', 
								temp_ethn,
								temp_race);*/ 
	
 self.sex				:= map(r.gender[1..1] in ['M','F'] => r.gender[1..1],
								 '');

 self.hair_color		:= if(trim(r.haircolor,left,right) 
								in ['BAL','BLK','BLN','BRO','GRY','RED','SDY','WHI','UNK'],
								r.haircolor,
								'');
								
 self.hair_color_desc	:= map(r.haircolor='B' => '',
								 r.haircolor='BAL' => 'BALD',
								 r.haircolor='BLACK' => 'BLACK',
								 r.haircolor='BLD' => 'BALD',
								 r.haircolor='BLK' => 'BLACK',
								 r.haircolor='BLN' => 'BLOND OR STRAWBERRY',
								 r.haircolor='BLOND' => 'BLOND',
								 r.haircolor='BLOND OR S' => 'BLOND OR STRAWBERRY',
								 r.haircolor='BLONDE' => 'BLOND',
								 r.haircolor='BLONDE OR' => 'BLOND OR STRAWBERRY',
								 r.haircolor='BLU' => 'BLUE',
								 r.haircolor='BLUE' => 'BLUE',
								 r.haircolor='BRN' => 'BROWN',
								 r.haircolor='BRO' => 'BROWN',
								 r.haircolor='BROWN' => 'BROWN',
								 r.haircolor='GRAY' => 'GRAY',
								 r.haircolor='GRAY OR PA' => 'GRAY OR PARTIALLY GRAY',
								 r.haircolor='GREY' => 'GREY',
								 r.haircolor='GREY OR PA' => 'GRAY OR PARTIALLY GRAY',
								 r.haircolor='GRN' => 'GREEN',
								 r.haircolor='GREEN' => 'GREEN',
								 r.haircolor='GRY' => 'GRAY OR PARTIALLY GRAY',
								 r.haircolor='H' => '',
								 r.haircolor='HAZ' => '',
								 r.haircolor='LT BLOND' => 'LT BLOND',
								 r.haircolor='MUL' => 'MULTIPLE',
								 r.haircolor='RED' => 'RED',
								 r.haircolor='RED OR AUB' => 'RED OR AUBURN',
								 r.haircolor='SANDY' => 'SANDY',
								 r.haircolor='SDY' => 'SANDY',
								 r.haircolor='UNKNOWN' => '',
								 r.haircolor='WHITE' => 'WHITE',
								 r.haircolor='WHI' => 'WHITE',
								 r.haircolor='W' => '',
								 r.haircolor<>'' => '','');
								 
 self.eye_color			:= if(trim(r.eyecolor,left,right)
								in['BLK','BLU','BRO','GRN','GRY','HAZ','MUL','PNK','UNK'],
								r.eyecolor,
								'');
								
 self.eye_color_desc	:= map(r.eyecolor='1' => '',
								 r.eyecolor='2' => '',
								 r.eyecolor='BLACK' => 'BLACK',
								 r.eyecolor='BLK' => 'BLACK',
								 r.eyecolor='BLA' => 'BLACK',
								 r.eyecolor='BLN' => '',
								 r.eyecolor='BLO' => '',
								 r.eyecolor='BLU' => 'BLUE',
								 r.eyecolor='BLUE' => 'BLUE',
								 r.eyecolor='BRN' => 'BROWN', //?
								 r.eyecolor='BRO' => 'BROWN',
								 r.eyecolor='BROWN' => 'BROWN',
								 r.eyecolor='GREEN' => 'GREEN',
								 r.eyecolor='GRN' => 'GREEN',
								 r.eyecolor='GREY' => 'GREY',
								 r.eyecolor='GRAY' => 'GRAY',
								 r.eyecolor='GRY' => 'GREY',
								 r.eyecolor='GRA' => 'GRAY',
								 r.eyecolor='HAZ' => 'HAZEL',
								 r.eyecolor='HAZEL' => 'HAZEL',
								 r.eyecolor='HZL' => 'HAZEL',
								 r.eyecolor='MULTICOLOR' => 'MULTICOLOR',
								 r.eyecolor='RED' => 'RED',
								 r.eyecolor='UNKNOWN' => '',
								 r.eyecolor<>'' => '','');

 self.skin_color			:= '';
 self.skin_color_desc		:= r.skincolor;
		
 self.height				:= hygenics_crim._functions.fn_height_to_inches(r.height);
 self.weight				:= if((integer) stringlib.stringfilter(r.weight,'1234567890')<>0,
								 stringlib.stringfilter(r.weight,'1234567890'),
								 '');							

 self.party_status			:= '';
 self.party_status_desc		:= if(r.statecode not in ['TN', 'NC', 'AR'],
								r.defendantstatus,
								'');

 //self.did					:= if(r.did<>0,intformat(r.did,12,1),	'');
 self.pgid					:= '';
 //self.ssn					:= r.ssn;
 self.src_upload_date		:= r.recorduploaddate;
 self.age         			:= r.age;
 self.image_link			:= if(trim(r.photoname, left, right)<>'',
								StringLib.StringToUpperCase(trim(vVendor)+'_'+r.photoname),
								'');
 //self.pkey					:= '';
								/*hygenics_crim._functions.fn_persistent_offender_key(vVendor, r.name, r.dob, r.docnumber, r.inmatenumber, 
																					r.stateidnumber, r.fbinumber, l.casenumber, l.fileddate, l.casetype);*/
 //self.restrict_flag			:= '';
 self 						:= r;
 

end;

result_comm 	:= join(sort_slim_off, sort_with_ssn, 
					left.recordid=right.recordid and 
					left.sourceid=right.sourceid,
					to_crim_offender(left,right), 
					local, right outer);//:persist ('~thor_data200::persist::crim::aoc::offender_others2');

//Assign primary name offender_key to aliases
result_comm1	:= sort(distribute(result_comm(pty_typ='2' and state_origin in ['OR', 'PA']), hash(recordid, sourceid)), recordid, sourceid, case_number,local);
result_comm2	:= sort(distribute(result_comm(pty_typ='0' and state_origin in ['OR', 'PA']), hash(recordid, sourceid)), recordid, sourceid, case_number,local); 

hygenics_crim.Layout_Common_Crim_Offender_orig transferkey (result_comm2 L, result_comm1 r) := transform
 self.offender_key := l.offender_key;
 self.case_number  := l.case_number;
 self := l;
end; 					

result_aliases1 := join(result_comm2,result_comm1, 
					             left.recordid = right.recordid and 
								          left.sourceid = right.sourceid and
								          left.case_number = right.case_number,
					             transferkey(left,right));//:persist ('~thor_data200::persist::crim::aoc::offender_alias_OR_PA');
								 
result_comm3	:= sort(distribute(result_comm(pty_typ='2' and state_origin in ['NC']), hash(recordid, sourceid)), recordid, sourceid, case_number,local);
result_comm4	:= sort(distribute(result_comm(pty_typ='0' and state_origin in ['NC']), hash(recordid, sourceid)), recordid, sourceid, case_number,local); 

hygenics_crim.Layout_Common_Crim_Offender_orig transferkey2(result_comm4 L, result_comm3 r) := transform
 self.offender_key := l.offender_key;
 self.case_number  := l.case_number;
  self.case_filing_dt := r.case_filing_dt;
 self := r;
end; 					

result_aliases2 := join(result_comm4,result_comm3, 
					             left.recordid = right.recordid and 
								          left.sourceid = right.sourceid and
								          left.case_number = right.case_number and
								         (left.case_filing_dt = right.case_filing_dt or (left.case_filing_dt ='' and right.case_filing_dt ='')),
					             transferkey2(left,right));//:persist ('~thor_data200::persist::crim::aoc::offender_alias_NC');

result_aliases	:= result_aliases1 + result_aliases2;

result_common2 	:= project(result_comm(pty_typ ='0'),hygenics_crim.Layout_Common_Crim_Offender_orig)+result_aliases;		
								
//REMOVE RECORDS WHERE NO VENDOR CODE IS ASSIGNED///////////////////////								
//Rollup Other Fields
sorted_r2common	:= sort(distribute(result_common2(trim(vendor, left, right)<>''), hash(offender_key)), offender_key, state_origin, pty_nm, dob,  
						            street_address_1,street_address_2,-case_court,local);
						
////////////////////////////////////////////////////////////////////////

sorted_r2common rollupCrim2(sorted_r2common L, sorted_r2common R) := TRANSFORM
	self.case_court					:= if(l.case_court = '', r.case_court, l.case_court);
	self.street_address_1	:= if(l.street_address_1  = '', r.street_address_1 , l.street_address_1 );
	self.street_address_2	:= if(l.street_address_2  = '', r.street_address_2 , l.street_address_2 );
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
	SELF 							:= L; 
END;


rollupOthOut := ROLLUP(sorted_r2common,
                       left.offender_key = right.offender_key and 
						                 trim(left.state_origin) = trim(right.state_origin) and 
						                 trim(left.pty_nm) = trim(Right.pty_nm) and 
						                 trim(left.dob) = trim(Right.dob) and
											           (left.street_address_1 =	right.street_address_1 	or  right.street_address_1  =''	or left.street_address_1 	='') and 	
											           (left.street_address_2 =	right.street_address_2 	or  right.street_address_2  =''	or left.street_address_2 	='') ,											 
						                 rollupCrim2(LEFT,RIGHT));//:persist ('~thor_data200::persist::crim::aoc::offender');



result_dedup := dedup(sort(distribute(rollupOthOut, hash(offender_key)), record, local), record, local, except pty_typ, left) : persist ('~thor_data200::persist::crim::aoc::offender_mod_pa_nc_or2');

export proc_build_crim_offender2_base_others := result_dedup;