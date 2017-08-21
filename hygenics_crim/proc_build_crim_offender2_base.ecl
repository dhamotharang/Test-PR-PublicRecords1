import crim_common,did_add,didville,header,header_slimsort,ut,watchdog, address,nid, AID,AID_Support;

def 	:= sort(distribute(hygenics_crim.file_in_defendant(statecode not in ['NC','PA','OR']),hash(recordid)), recordid, local);
ah		:= dedup(sort(distribute(hygenics_crim.file_in_addresshistory(statecode not in ['NC','PA','OR']),hash(recordid)), recordid, local), record);
aka	  := dedup(sort(distribute(hygenics_crim.file_in_alias(statecode not in ['NC','PA','OR']),hash(recordid)), recordid, local), record);
off 	:= dedup(sort(distribute(hygenics_crim.file_in_offense(statecode not in ['NC','PA','OR']),hash(recordid)), recordid, local), record);

	slimOffense_rec := RECORD 
		off.recordid;
		off.statecode;
		off.DocketNumber;
		off.CaseNumber;
		off.Casetitle;
		off.Casetype;
		off.Fileddate;
		off.Courtname;
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
		left.statecode=right.statecode,
		join_def_alias(left,right),local,nosort);

all_names 				:= def_with_alias + def;// :persist ('~thor_data200::persist::crim::aoc::offender_all_names');

// all_unique_names		    := distribute(all_names, hash(recordid));
all_unique_names_dedup	:= dedup(sort(all_names, record,local), record,local);

	def join_def_ah(def l, ah r) := transform 
	  self := r;
	  self := l;
	end;

	def_with_ahist := join(all_unique_names_dedup, ah,
		left.recordid=right.recordid and 
		left.statecode=right.statecode,
		join_def_ah(left,right),local,nosort);
		
all_names_addresses := def_with_ahist+ all_unique_names_dedup;

	//Populate Address fields
	addAddress_layout := record
		all_names_addresses;
		string street_address_1;
		string street_address_2;
		unsigned8 	append_Rawaid;
	end;

	addAddress_layout addrPop(all_names_addresses l):= transform
		self.street_address_1 := if(regexfind('[A-Z]+', stringlib.stringtouppercase(l.street), 0)<>'',
									              trim(l.street+if(l.unit<>'', ' '+l.unit, ''), left, right),
									              '');
		self.street_address_2 := l.city+', '+l.orig_state+' '+l.orig_zip;
		self.append_Rawaid := 0;
		self := l;
	end;

addrProject 	:= project(all_names_addresses, addrPop(left),local);

//Rollup Addresses
sorted_rcommon	:= sort(distribute(addrProject, hash(recordid)), recordid, statecode, name, dob,  
						            -street, -unit, -city, -orig_state, -orig_zip,
						            -street_address_1, -street_address_2,local);
						
sorted_rcommon rollupCrim(sorted_rcommon L, sorted_rcommon R) := TRANSFORM
	self.street						  := if(l.street = '', r.street, l.street);
	self.unit						    := if(l.unit = '', r.unit, l.unit);
	self.city						    := if(l.city = '', r.city, l.city);
	self.orig_state					:= if(l.orig_state = '', r.orig_state, l.orig_state);
	self.orig_zip      			:= if(l.orig_zip = '', r.orig_zip, l.orig_zip);
	self.street_address_1		:= if(l.street_address_1 = '', r.street_address_1, l.street_address_1);
	self.street_address_2		:= if(l.street_address_2 = '', r.street_address_2, l.street_address_2);
	SELF 							      := L; 
END;

rollupAddrOut := ROLLUP(sorted_rcommon,
                        left.recordid = right.recordid and 
						            trim(left.statecode) = trim(right.statecode) and 
						            trim(left.name) = trim(Right.name) and 
						            trim(left.dob) = trim(Right.dob), 
						            rollupCrim(LEFT,RIGHT)) ;
						 
layout_temp_offender := record
 
 hygenics_crim.layout_in_defendant;
 
 string40	 j_RecordID;
 string2	 j_StateCode;
 string1   name_type_hd;
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
 string2 	  state;
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
 string3	  ace_fips_county;
 string10 	geo_lat;
 string11 	geo_long;
 string4  	msa;
 string7  	geo_blk;
 string1  	geo_match;
 string4  	err_stat;
 
 unsigned6 	did	:= 0;
 unsigned1 	did_score := 0;
 string9 	  ssn := '';

end;
//Address Cleaner	
/* Commented for AID change
layout_temp_offender clean_name_add (rollupAddrOut l) := transform
 self.j_RecordID 			:= l.recordid;
 self.j_StateCode 		:= l.statecode;
 self.name_type_hd    := l.nametype; // added this b/c NID cleaner over writes this field.	
 self.name            := MAP(l.name ='' => l.firstname+' '+l.middlename+' '+l.lastname+' '+l.suffix ,
                             l.name);
												 
 clean_addr 				  := Address.CleanAddress182(l.street_address_1, l.street_address_2);
 
 self.prim_range 		  := clean_addr[1..10];
 self.predir 			    := clean_addr[11..12];
 self.prim_name 		  := clean_addr[13..40];
 self.addr_suffix 		:= clean_addr[41..44];
 self.postdir 			  := clean_addr[45..46];
 self.unit_desig 		  := clean_addr[47..56];
 self.sec_range 		  := clean_addr[57..64];
 self.p_city_name 		:= clean_addr[65..89];
 self.v_city_name 		:= clean_addr[90..114];
 self.state 			    := clean_addr[115..116];
 self.zip5 				    := clean_addr[117..121];
 self.zip4 				    := clean_addr[122..125];
 self.cart 				    := clean_addr[126..129];
 self.cr_sort_sz 		  := clean_addr[130];
 self.lot 				    := clean_addr[131..134];
 self.lot_order 		  := clean_addr[135];
 self.dpbc 				    := clean_addr[136..137];
 self.chk_digit 		  := clean_addr[138];
 self.rec_type 			  := clean_addr[139..140];
 self.ace_fips_st 		:= clean_addr[141..142];
 self.ace_fips_county	:= clean_addr[143..145];
 self.geo_lat 			  := clean_addr[146..155];
 self.geo_long 			  := clean_addr[156..166];
 self.msa 				    := clean_addr[167..170];
 self.geo_blk 			  := clean_addr[171..177];
 self.geo_match 		 	:= clean_addr[178];
 self.err_stat 			  := clean_addr[179..182];
 self 						    := l;
 self 						    := [];
end;

cleanAddress := project(rollupAddrOut, clean_name_add(left)):INDEPENDENT;
*/
//AID Address cleaner
	unsigned4 lAIDAppendFlags		:= AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords| AID.Common.eReturnValues.NoNewCacheFiles;
  #constant(AID_Support.Constants.StoredWhichAIDCache, AID_Support.Constants.eCache.ForNonHeader);			
	AID.MacAppendFromRaw_2Line(rollupAddrOut, street_address_1, street_address_2,append_Rawaid , addressCleaned, lAIDAppendFlags);
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
	
	all_clean_name_addr := 	project(cleanfullnames, projFile(left)):persist('~thor_200::persist::crim2_offender_nid_DL');
		
  with_ssn			:= all_clean_name_addr ;


sort_with_ssn := distribute(with_ssn, hash(recordid)); //dedup(sort(distribute(with_ssn, hash(recordid)), recordid, local), record, local); VC
sort_slim_off := slim_off ; //dedup(sort(distribute(slim_off, hash(recordid)), recordid, local), record, local);VC

Layout_almostfinal_offender := record
 hygenics_crim.Layout_Common_Crim_Offender_orig;
 hygenics_crim.layout_in_defendant.recordid;
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
																	
 self.process_date		:= global(stringlib.getdateyyyymmdd());

 self.data_type			:= '2';
 self.case_number		:= l.casenumber;
 
 get_court_desc :=
	           MAP(r.sourcename = 'ALASKA_ADMINISTRATOR_OF_THE_COURTS'          => Trim(regexreplace('(.*- )(.*)',l.courtname,'$2')),   
										r.sourcename = 'ARIZONA_ADMINISTRATOR_OF_THE_COURTS'      => Trim(regexreplace('(.*- )(.*)',l.courtname,'$2')),            
										r.sourcename = 'HAWAII_STATE_JUDICIARY   '                => Trim(regexreplace('(.*-[ ])([A-Z]+.*)',l.courtname ,('$2'))),            
										r.sourcename = 'INDIANA_ADMINISTRATOR_OF_THE_COURTS'      => Trim(l.courtname),            
										r.sourcename = 'MARYLAND_ADMINISTRATOR_OF_THE_COURTS'     => Trim(regexreplace('([A-Z .\']+)-.*',l.courtname,'$1')),            
										r.sourcename = 'MINNESOTA_DEPARTMENT_OF_PUBLIC_SAFETY'    => Trim(l.courtname),            
										r.sourcename = 'MISSOURI_ADMINISTRATOR_OF_THE_COURTS'     => Trim(l.courtname),            
										r.sourcename = 'NEW_MEXICO_ADMINISTRATOR_OF_THE_COURTS'   => Trim(l.courtname),            
										r.sourcename = 'NORTH_DAKOTA_ADMINISTRATOR_OF_THE_COURTS' => Trim(l.courtname),            
										r.sourcename = 'OREGON_ADMINISTRATOR_OF_THE_COURTS'       => Trim(regexreplace('.*- ([A-Z ]+)',l.courtname,'$1')),            
										r.sourcename = 'RHODE_ISLAND_ADMINISTRATOR_OF_THE_COURTS' => Trim(regexreplace('(.*- )(.*)',l.courtname,'$2')),            
										r.sourcename = 'RHODE_ISLAND_ADMINISTRATOR_OF_THE_COURTS_TRAFFIC' => Trim(regexreplace('(.*- )(.*)',l.courtname,'$2')),            
										r.sourcename = 'TENNESSEE_ADMINISTRATOR_OF_THE_COURTS'    => regexreplace('(.*- )(.*)',l.courtname,'$2'),            
										r.sourcename = 'TEXAS_DEPARTMENT_OF_PUBLIC_SAFETY'        => Trim(l.courtname),            
										r.sourcename = 'UTAH_ADMINISTRATOR_OF_THE_COURTS'         => Trim(regexreplace('(.*- )(.*)',l.courtname,'$2')),   
										r.sourcename = 'VIRGINIA_ADMINISTRATOR_OF_THE_COURTS'     => Trim(map(regexfind('(.*- )(.*)(-[ A-Z]+)',l.courtname) => regexreplace('(.*- )(.*)(-[ A-Z]+)',l.courtname,'$2$3'),	
																																											    regexfind('(.*- )(.*)',l.courtname)           => regexreplace('(.*- )(.*)',l.courtname,'$2'),
																																											    '')), 
										r.sourcename='MINNESOTA_DEPARTMENT_OF_PUBLIC_SAFETY'      =>map(regexfind('([A-Z ]+)(CO DISTRICT COURT.*)',l.courtname)=> l.courtname,
																																										regexfind('([A-Z ]+)(DIST COURT.*)',l.courtname)       => l.courtname,
																																										regexfind('([A-Z ]+)(COUNTY.*)',l.courtname)           => l.courtname,
																																										regexfind('([A-Z ]+)(CO COURT.*)',l.courtname)         => l.courtname,																								
								                                                                    ''),
                    '');
 self.case_court		:= get_court_desc;
 self.case_name			:= l.casetitle;
 self.case_type			:= '';
 self.case_type_desc:= if(r.statecode='FL',	'',		l.casetype);
 self.case_filing_dt:= if(length(l.fileddate)>4 and trim(l.fileddate)[1..2] in ['19','20'] and trim(l.fileddate, left, right)[5..6] in ['01','02','03','04','05','06','07','08','09','10','11','12'],
						                 trim(l.fileddate),
							              if(length(l.fileddate)=4 and trim(l.fileddate)[1..2] in ['19','20'],
						                 trim(l.fileddate),
						               ''));
 self.pty_nm			  := if(r.lastname='' and r.name<>'',
									      trim(r.name),
									      trim(trim(trim(trim(r.firstname)+' '+trim(r.middlename))+' '+trim(r.lastname))+' '+trim(r.suffix)));
 self.pty_nm_fmt		:= if(r.lastname='' and r.name<>'', 'L','F');
 self.orig_lname		:= r.lastname;
 self.orig_fname		:= r.firstname;
 self.orig_mname		:= r.middlename;
 self.orig_name_suffix	:= r.suffix;
 
 //from NID cleaner
	self.title        := r.cln_title;
	self.fname			  := r.cln_fname;
	self.mname			  := r.cln_mname;
	self.lname				:= r.cln_lname;
	self.name_suffix  := r.cln_suffix;
  //self.name_type		:= r.name_format;	
	self.nid					:= r.nid;	
	self.ntype				:= r.nametype;
	self.nindicator		:= r.name_ind;
 self.pty_typ			  := MAP(r.name_type_hd ='A' => '2', 
                            '0' );
 self.nitro_flag		:= '';
 self.orig_ssn			:= r.orig_ssn;
 self.dle_num			  := r.stateidnumber;
 self.fbi_num			  := r.fbinumber;
 self.doc_num			  := r.docnumber;
 self.ins_num			  := r.aliennumber;
 self.id_num			  := r.inmatenumber;
 self.dl_num			  := r.dlnumber;
 self.dl_state			:= r.dlstate;

 self.citizenship		:= if(r.uscitizenflag='Y','US','');	

 self.dob				    := MAP(vVendor IN ['W0003','W0004'] and r.name_type_hd<>'A' =>  trim(r.dob,left,right),
                          r.dob[1..2] in ['19','20'] and ((integer)stringlib.GetDateYYYYMMDD()[1..4])-((integer)r.dob[1..4])>=18 and r.name_type_hd<>'A' =>
								          trim(r.dob,left,right),
								          '');
 self.dob_alias			:= if(r.dob[1..2] in ['19','20'] and ((integer)stringlib.GetDateYYYYMMDD()[1..4])-((integer)r.dob[1..4])>=18 and r.name_type_hd='A',
								          trim(r.dob,left,right),
								          '');
 self.place_of_birth:= trim(trim(r.birthcity)+' '+ r.birthplace);

 self.street_address_1	:= trim(r.street)+if(r.unit<>'', ' '+r.unit, '');
 self.street_address_2	:= trim(trim(trim(r.city)+' '+trim(r.orig_state))+' '+trim(r.orig_zip));
 self.street_address_3	:= '';
 self.street_address_4	:= '';
 self.street_address_5	:= '';
 
 self.race				:= if(length(trim(r.race))=1 and regexfind('[A-Z]', r.race, 0)<>'' , trim(r.race), '');
 
							
 string temp_ethn := MAP(r.ethnicity in ['UNKNOWN', 'INVALID', 'NONE', ''] => '',
							         r.ethnicity = 'AMER.' => 'AMERICAN',
								       r.ethnicity <> '' => r.ethnicity,
								       '');
															 
 self.race_desc		:= IF (hygenics_crim._functions.fn_standarddize_race(r.race)='', 
			                     hygenics_crim._functions.fn_standarddize_race(r.ethnicity),
								           hygenics_crim._functions.fn_standarddize_race(r.race));
	
 self.sex				  := map(r.gender[1..1] in ['M','F'] => r.gender[1..1],
								     '');

 self.hair_color	:= if(trim(r.haircolor,left,right) in ['BAL','BLK','BLN','BRO','GRY','RED','SDY','WHI','UNK'],
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
								 
 self.eye_color	:= if(trim(r.eyecolor,left,right)  in['BLK','BLU','BRO','GRN','GRY','HAZ','MUL','PNK','UNK'],
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

 self.skin_color			  := '';
 self.skin_color_desc		:= r.skincolor;
		
 self.height				    := hygenics_crim._functions.fn_height_to_inches(r.height);
 self.weight				    := if((integer) stringlib.stringfilter(r.weight,'1234567890')<>0, stringlib.stringfilter(r.weight,'1234567890'), '');							

 self.party_status			:= '';
 self.party_status_desc	:= if(r.statecode not in ['TN', 'NC', 'AR'],	r.defendantstatus,	'');
 self.pgid					    := '';
 self.src_upload_date		:= r.recorduploaddate;
 self.age         			:= r.age;
 self.image_link			  := if(trim(r.photoname, left, right)<>'',
								            StringLib.StringToUpperCase(trim(vVendor)+'_'+r.photoname),''); 
 self 						      := r;
end;

result_comm := join(sort_slim_off, sort_with_ssn, 
					              left.recordid=right.recordid 
					          and left.statecode=right.statecode,
					          to_crim_offender(left,right), 
					          local, right outer);//:persist ('~thor_data200::persist::crim::aoc::offender_all');

result_common1	:= distribute(result_comm, hash(recordid, state_origin));

//output(result_common1(recordid ='GAAOCBOI146779'));

//Following code requird if we are using persistent offender_key - based on DOC numbers etc					
hygenics_crim.Layout_Common_Crim_Offender_orig transferkey (result_common1 L, result_common1 R) := transform
 self.offender_key   := r.offender_key;
 self.case_number    := r.case_number;
 self.case_filing_dt := r.case_filing_dt;
 self := l;
end; 					

result_aliases := join(result_common1(pty_typ ='2'),result_common1(pty_typ ='0'), 
					             left.recordid = right.recordid and 
								       left.state_origin = right.state_origin and
								       left.case_number = right.case_number and 
								       (left.case_filing_dt = right.case_filing_dt or (left.case_filing_dt ='' and right.case_filing_dt ='')),
					             transferkey(left,right), 
					             local);

result_common2 := project(result_common1(pty_typ ='0'),hygenics_crim.Layout_Common_Crim_Offender_orig)+result_aliases;	
					
//REMOVE RECORDS WITH NO VENDOR CODE ASSIGNED//////////////////////

//Rollup Other Fields
sorted_r2common	:= sort(distribute(result_common2(trim(vendor, left, right)<>''), hash(offender_key)), offender_key, state_origin, pty_nm, dob,  
						-case_court,local);

//output(sorted_r2common(vendor ='GD' and pty_nm ='RALPH BERNARD FAVORS'));
///////////////////////////////////////////////////////////////////
						
sorted_r2common rollupCrim2(sorted_r2common L, sorted_r2common R) := TRANSFORM
	self.case_court					:= if(l.case_court = '', r.case_court, l.case_court);
	SELF 							:= L; 
END;

rollupOthOut := ROLLUP(sorted_r2common,
                       left.offender_key = right.offender_key and 
						           trim(left.state_origin) = trim(right.state_origin) and 
						           trim(left.pty_nm) = trim(Right.pty_nm) and 
						           trim(left.dob) = trim(Right.dob), 
						           rollupCrim2(LEFT,RIGHT));//:persist ('~thor_data200::persist::crim::aoc::offender');
								
result_common := dedup(sort(distribute(rollupOthOut + proc_build_crim_offender2_base_others, hash(offender_key)), record, local), record, local, except pty_typ, left) : persist ('~thor_data200::persist::crim::aoc::offender');

export proc_build_crim_offender2_base := result_common;  //sequential(o1);
