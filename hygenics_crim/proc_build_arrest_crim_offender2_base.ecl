import crim_common, did_add, didville, header, header_slimsort, ut, watchdog, address, lib_date,nid;

def 		:= distribute(hygenics_crim.file_in_defendant_arrests,hash(recordid,sourceid));
ah			:= dedup(sort(distribute(hygenics_crim.file_in_address_history_arrests,hash(recordid,sourceid)), record, local), record,local);
aka	  	:= dedup(sort(distribute(hygenics_crim.file_in_alias_arrests,hash(recordid,sourceid)), record, local), record,local);
off 		:= hygenics_crim.file_in_offense_arrests;
cha 		:= dedup(sort(distribute(hygenics_crim.file_in_charge_arrests,hash(recordid,sourceid)), record, local), record,local);

	slimOffense_rec := RECORD 
		off.recordid;
		off.statecode;
		off.DocketNumber;
		off.CaseNumber;
		off.Casetitle;
		off.Casetype;
		off.FiledDate;
		off.Courtname;
		off.DispositionDate;
		off.CourtDate;
		off.OffenseDate;
		off.caseid;
		off.sourceid;
	end;

slim_off := dedup(sort(distribute(project(off, slimOffense_rec),hash(recordid,sourceid)), record, local), record,local);

	def join_def_alias(def l, aka r) := transform 
		self.nametype 		:= 'A';
		self.Name 			  := r.AKAname;
		self.LastName 		:= r.AKAlastname;
		self.FirstName 		:= r.AKAfirstname;
		self.MiddleName 	:= r.AKAmiddlename;
		self.Suffix 			:= r.AKAsuffix;
		self.DOB 				  := if(((integer)stringlib.GetDateYYYYMMDD()[1..4])-((integer)r.akadob[1..4])>=18,
														r.akadob, 
														'');
		self := l;
	end;

def_with_alias := join(def, aka,
										left.recordid=right.recordid and 
										left.statecode=right.statecode,
										join_def_alias(left,right),local);

	Layout_defplusaka := record
		def;
		string alias;
	end;

	//handle aka's - regexfind('([ -/;]AKA[ /-;])',name)
	Layout_defplusaka pullaka(def L) := Transform	

		self.name := _functions.strip_name_from_AKA(l.name,l.lastname,l.firstname,l.middlename,l.suffix);
										 
		self.alias:= _functions.strip_alias_from_AKA(l.name,l.lastname,l.firstname,l.middlename,l.suffix);

		self := l;
	end;

defwith_aka := project(def(regexfind('([": ,-;/]AKA[": ,-;/])',name+' ')), pullaka(left),local);	

	def NormAlias(defwith_aka L, INTEGER cnt) := TRANSFORM
		self.name 					 := MAP(cnt =1 => L.name,
																cnt =2 => L.alias,
																'');
		self.nametype 			 := IF (cnt =1, l.nametype, 'A');
		SELF 								 := L;
	end;

def_and_aka := NORMALIZE(defwith_aka, 2 ,NormAlias(LEFT,COUNTER),local);

all_names 							:= def_and_aka + def_with_alias + def(regexfind('([" -/;]AKA[" /-;])',name+' ',0) ='') :persist ('~thor_data200::persist::crim::arrest::offender');
all_unique_names	      := dedup(sort(all_names, record,local), record,local);
// all_unique_names				:= distribute(all_unique_names_dedup, hash(recordid));

	def join_def_ah(def l, ah r) := transform 
		self := r;
		self := l;
	end;

def_with_ahist := join(all_unique_names, ah,
										left.recordid=right.recordid and 
										left.statecode=right.statecode,
										join_def_ah(left,right),local);
		
all_names_addresses := def_with_ahist+ all_unique_names;

	layout_temp_offender addrPop(all_names_addresses l):= transform
	                                                                                                                                            
   	 self.j_RecordID 				:= l.recordid;
		 self.j_StateCode 			:= l.statecode;
		 self.name_type_hd      := l.nametype; // added this b/c NID cleaner over writes this field.

		 self.name              := MAP(l.name ='' => l.firstname+' '+l.middlename+' '+l.lastname+' '+l.suffix ,
                                   l.name);

	  vStreet := MAP(l.street in _functions.StreetAddressToFilter => '',
		               l.street);
									 
		self.street_address_1 //:= l.street+if(l.unit<>'', ' '+l.unit, '');
		                      := map(l.sourcename='NORTH_CAROLINA_MECKLENBURG_COUNTY_ARRESTS' and regexfind('([A-Za-z]+)( NC$)',trim(vStreet)) 
	                                       	 => regexreplace('([A-Za-z]+)( NC$)',trim(vStreet),''),
																 vStreet+if(l.unit<>'', ' '+l.unit, ''));	
		
		self.street_address_2 := _functions.CleanAddress(l.city+', '+l.orig_state+' '+l.orig_zip);
		self := l;
		self := [];
	end;

addrProject 	:= project(all_names_addresses, addrPop(left),local):INDEPENDENT;
// output(addrProject(recordid in ['FLALACHUACOUNTYSOARRMA37787','FLALACHUACOUNTYSOARRMA37959'])	);			 

cleanAddress := hygenics_crim._fns_AddressCleaner(addrProject):persist ('~thor_data200::persist::crim::arrestaddresscache');
//NID Name cleaner/////////////////////////////////

	nid.mac_cleanfullnames(cleanAddress, cleanfullnames, name);
	// nid.mac_cleanfullnames(cleanAddress, cleanfullnames, name,useV2:=true);

	cleanfullnames projFile(cleanfullnames l):= transform
		self := l;
	end;
	
	all_clean_name_addr := project(cleanfullnames, projFile(left)):persist('~thor_200::persist::crimarr_offender_nid');

with_ssn						:= all_clean_name_addr;

	addChgLayout := record
		slim_off;
		string20	BookingNumber;
		string8		ArrestDate;
		string8		BookingDate;
	end;

	addChgLayout addField(slim_off l, cha r):= transform
		self 								:= l;
		self.bookingnumber 	:= r.bookingnumber;
		self.arrestdate			:= r.arrestdate;
		self.bookingdate 		:= r.bookingdate;
	end;
	
	slim_AllOffChg := join(slim_off, cha,
												left.statecode=right.statecode and 
												left.recordid=right.recordid and 
												left.caseid=right.caseid, 
												addField(left,right), left outer, local);	
	
	Layout_almostfinal_offender := record
		Layout_Common_Crim_Offender_orig;
		hygenics_crim.layout_in_defendant.recordid;
		hygenics_crim.layout_in_defendant.sourceid;
	end;
 
	Layout_almostfinal_offender to_crim_offender(with_ssn l, slim_AllOffChg r) := transform
	 
	 string temp_case_number:= MAP(r.casenumber <> ''   => r.casenumber, 
																 r.DocketNumber <> '' => r.DocketNumber,
																 '');

		 casenumber 					:= map(l.sourcename='ALABAMA_BALDWIN_COUNTY_ARRESTS' and regexfind('([A-Z0-9]+)( )(.*)',r.casenumber) => regexreplace('([A-Z0-9]+)( )(.*)',r.casenumber,'$1'),
																REGEXFIND('CRIME FOR BENEFIT',r.casenumber,NOCASE) =>'',
																REGEXFIND('ENTER AT DIV',r.casenumber,NOCASE) =>'',
																REGEXFIND('TERMINATED DIVERSION',r.casenumber,NOCASE) =>''																															
																,r.casenumber); 
	 
	 vVendor 								:= hygenics_crim._functions.fn_sourcename_to_vendor(trim(l.sourcename), trim(l.statecode)); 
	 v_pty_nm               := StringLib.StringFilter(StringLib.StringToUpperCase(l.name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); 	
	 vDob										:= StringLib.StringFilter(StringLib.StringToUpperCase(l.dob),'0123456789'); 	
	 vBookingNumber					:= StringLib.StringFilter(StringLib.StringToUpperCase(r.bookingnumber),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	 vBookingDate						:= if(regexfind('/', r.bookingdate, 0)<>'',
																(string)LIB_Date.Date_MMDDYY_I2(regexreplace('/', r.bookingdate, '')),
																r.bookingdate);
	 vArrestDate						:= if(regexfind('/', r.arrestdate, 0)<>'',
																(string)LIB_Date.Date_MMDDYY_I2(regexreplace('/', r.arrestdate, '')),
																r.arrestdate);
	 vCourtDate							:= if(regexfind('/', r.courtdate, 0)<>'',
																(string)LIB_Date.Date_MMDDYY_I2(regexreplace('/', r.courtdate, '')),
																r.courtdate);
	 vOffenseDate						:= if(regexfind('/', r.offensedate, 0)<>'',
																(string)LIB_Date.Date_MMDDYY_I2(regexreplace('/', r.offensedate, '')),
																r.offensedate);
	 vFileDate							:= if(regexfind('/', r.fileddate, 0)<>'',
																(string)LIB_Date.Date_MMDDYY_I2(regexreplace('/', r.fileddate, '')),
																r.fileddate);
	 vDispDate							:= if(regexfind('/', r.dispositiondate, 0)<>'',
																(string)LIB_Date.Date_MMDDYY_I2(regexreplace('/', r.dispositiondate, '')),
																r.dispositiondate);
	 vCourtName							:= StringLib.StringFilter(StringLib.StringToUpperCase(r.courtname),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	 vDocketNum							:= StringLib.StringFilter(StringLib.StringToUpperCase(r.docketnumber),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	 vCaseID							:= StringLib.StringFilter(StringLib.StringToUpperCase(r.caseid),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	 
	 self.offender_key			:= if(l.name_type_hd <>'A' and trim(vBookingDate, left, right) <>'' and trim(vVendor) not in ['BN','BU','BY','CV','GH','GX','IP','KB','NQ'],
																		trim(vVendor) + (string)HASH64(v_pty_nm) + trim(vDOB, all) + vBookingDate,
																 if(l.name_type_hd <> 'A' and trim(vArrestDate, left, right) <>'' and vVendor not in ['BN','BU','BY','CV','KB'],
																		trim(vVendor) + (string)HASH64(v_pty_nm) + trim(vDOB, all) + vArrestDate,
																 if(l.name_type_hd <> 'A' and trim(vBookingNumber, left, right) <>'' and trim(vVendor) in ['BJ','BN','BU','BY','CV','GH','GX','IP','KB','NQ'],
																		trim(vVendor) + (string)HASH64(v_pty_nm) + trim(vDOB, all) + vBookingNumber,
																 if(l.name_type_hd <> 'A' and trim(vCourtName, left, right) <>'' and trim(vVendor) in ['BM','CS','LI','QE'],
																		trim(vVendor) +(string)HASH64(v_pty_nm) + trim(vDOB, all) + vCourtName,
																 if(l.name_type_hd <> 'A' and trim(vCourtDate, left, right) <>'' and trim(vVendor) in ['BZ','HG','KI','IQ','KL'],
																		trim(vVendor) + (string)HASH64(v_pty_nm) + trim(vDOB, all) + vCourtDate,
																 if(l.name_type_hd <> 'A' and trim(vDocketNum, left, right) <>'' and trim(vVendor) in ['CW','LH','LJ'],
																		trim(vVendor) + (string)HASH64(v_pty_nm) + trim(vDOB, all) + vDocketNum,
																 if(l.name_type_hd <> 'A' and trim(vDispDate, left, right) <>'' and trim(vVendor) in ['MQ','MU','MY','NI','NK'],
																		trim(vVendor) + (string)HASH64(v_pty_nm) + trim(vDOB, all) + vDispDate,
																 if(l.name_type_hd <> 'A' and trim(vOffenseDate, left, right) <>'' and trim(vVendor) in ['HX'],
																		trim(vVendor) + (string)HASH64(v_pty_nm) + trim(vDOB, all) + vOffenseDate,
																 if(l.name_type_hd <> 'A' ,
																		trim(vVendor) + (string)HASH64(v_pty_nm) + trim(vDOB, all) + trim(l.race)+trim(l.gender),
																		'')))))))));

	 self.state_origin			:= l.statecode;
	 self.vendor			  		:= vVendor;
	 self.source_file				:= hygenics_crim._functions.fn_shorten_sourcename(trim(l.sourcename));
																		
	 self.process_date			:= stringlib.getdateyyyymmdd();

	 self.data_type					:= '5';
	 
	 self.case_number				:= '';//casenumber;
	 
		 courtname := map(l.sourcename = 'UTAH_UTAH_COUNTY_ARRESTS' and length(trim(r.courtname)) > 4
																					 => '',r.courtname);																	 

	 self.case_court				:= MAP (trim(vVendor) = 'GE' => '',
                                  courtname);
	 self.case_name					:= r.casetitle;
	 self.case_type					:= '';
	 self.case_type_desc		:= r.casetype ; //if(l.statecode='FL','',);
	self.case_filing_dt			:= if(length(vFileDate)>=4 and trim(vFileDate)[1..2] in ['19','20'],
															trim(vFileDate),
															'');
	 self.pty_nm			  		:= if(l.lastname='' and l.name<>'',
															trim(l.name),
															trim(trim(trim(trim(l.firstname)+' '+trim(l.middlename))+' '+trim(l.lastname))+' '+trim(l.suffix)));
	 self.pty_nm_fmt	  		:= if(l.lastname='' and l.name<>'','L',	'F');
	 self.orig_lname				:= l.lastname;
	 self.orig_fname				:= l.firstname;
	 self.orig_mname				:= l.middlename;
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
	
	 self.pty_typ						:= MAP(l.name_type_hd ='A' => '2', 
																'0');
	 self.nitro_flag				:= '';
	 self.orig_ssn					:= if(regexfind('[A-Z]+', l.orig_ssn, 0)='',
																l.orig_ssn,
																'');
	 self.dle_num						:= l.stateidnumber;
	 self.fbi_num						:= l.fbinumber;
	 self.doc_num						:= l.docnumber;
	 self.ins_num						:= l.aliennumber;
	 self.id_num						:= l.inmatenumber;
	 self.dl_num						:= l.dlnumber;
	 self.dl_state					:= l.dlstate;

	 self.citizenship				:= if(l.uscitizenflag='Y','US','');	

	 self.dob								:= if(_functions.fn_validate_dt(l.dob,'')=1 and l.dob[1..2] in ['19','20'] and ((integer)stringlib.GetDateYYYYMMDD()[1..4])-((integer)l.dob[1..4])>=18,
															trim(l.dob,left,right),
															'');

	 self.dob_alias					:= '';
	 self.place_of_birth		:= trim(trim(l.birthcity)+' '+ l.birthplace);


   tempstreet             :=  map(l.sourcename='NORTH_CAROLINA_MECKLENBURG_COUNTY_ARRESTS' and regexfind('([A-Za-z]+)( NC$)',trim(l.street)) 
	                                       	 => regexreplace('([A-Za-z]+)( NC$)',trim(l.street),''),l.street+if(l.unit<>'', ' '+l.unit, ''));	
   self.street_address_1	:= If(length(tempstreet)>25, tempstreet[1..25],tempstreet);
   self.street_address_2	:= If(length(tempstreet)>25, tempstreet[26..],'');
   self.street_address_3	:= trim(l.city);
   self.street_address_4	:= trim(l.orig_state);
   self.street_address_5	:= trim(l.orig_zip);
	 
	 self.race				  		:= if(length(trim(l.race))=1 and regexfind('[A-Z]', l.race, 0)<>'' , trim(l.race), '');
	 
	 string temp_race   		:= hygenics_crim._functions.fn_standarddize_race(l.race);					
	 string temp_ethn   		:= hygenics_crim._functions.fn_standarddize_race(l.ethnicity);
															 
	 self.race_desc					:= If(temp_race <> '' ,trim(temp_race), trim(temp_ethn));
		
	 self.sex				    		:= map(l.gender[1..1] in ['M','F'] => l.gender[1..1],
															'');

	 self.hair_color				:= MAP(  
																l.haircolor<>'' and regexfind('[0-9]',l.haircolor) =>'' ,
																trim(l.haircolor) in ['XX','UNK','XXX','N/A','!!!','---'] => '',
																length(trim(l.haircolor)) <= 3 => trim(l.haircolor),
																'');
   hair_desc              := _functions.fn_standardize_haircolor(l.haircolor);
	 self.hair_color_desc		:= MAP(l.haircolor='GRAY/PARTI' => 'GRAY',
	                               stringlib.stringfind(hair_desc,' HAI',1)>0 => hair_desc[1..stringlib.stringfind(hair_desc,' HAI',1)-1],
	                               hair_desc);  
	 self.eye_color			  	:= MAP( l.eyecolor<>'' and regexfind('[0-9]',l.eyecolor) =>'' ,
																trim(l.eyecolor) in ['XX','UNK','XXX','N/A','!!!','---'] => '',
																length(trim(l.eyecolor)) <= 3 => trim(l.eyecolor) ,
																'');
	 eye_desc               := _functions.fn_standardize_eyecolor(l.eyecolor);															
	 self.eye_color_desc		:= MAP(stringlib.stringfind(eye_desc,' EYES',1)>0 => eye_desc[1..stringlib.stringfind(eye_desc,' EYE',1)-1],
	                               eye_desc);  
									 
	 self.skin_color				:= '';
	 self.skin_color_desc		:= l.skincolor;
			
	 self.height				  	:= hygenics_crim._functions.fn_height_to_inches(l.height);
	 self.weight				  	:= if((integer) stringlib.stringfilter(l.weight,'1234567890')<>0,
															stringlib.stringfilter(l.weight,'1234567890'),
															'');							

	 self.party_status	    := '';
	 self.party_status_desc	:= l.defendantstatus;								             
	 self.pgid						  := '';
	 self.src_upload_date   := l.recorduploaddate;
	 self.age               := l.age;
	 self.image_link		:= if(trim(l.photoname, left, right)<>'' and trim(l.sourcename, left, right)<>'FLORIDA_BREVARD_COUNTY_ARRESTS',
									StringLib.StringToUpperCase(trim(vVendor)+'_'+l.photoname),
								if(trim(l.photoname, left, right)<>'' and regexfind(',', l.photoname, 0)<>'' and trim(l.sourcename, left, right)='FLORIDA_BREVARD_COUNTY_ARRESTS',
									StringLib.StringToUpperCase(trim(vVendor)+'_'+l.photoname[1..DataLib.StringFind(l.photoname, ',', 1)]),
								if(trim(l.photoname, left, right)<>'' and regexfind(',', l.photoname, 0)='' and trim(l.sourcename, left, right)='FLORIDA_BREVARD_COUNTY_ARRESTS',
									StringLib.StringToUpperCase(trim(vVendor)+'_'+l.photoname),
									'')));
	 self 					:= l;
	end;

result_comm 		:= join(distribute(with_ssn ,hash(recordid,sourceid)), distribute(slim_AllOffChg ,hash(recordid,sourceid)), 
					            left.recordid=right.recordid and 
								left.statecode=right.statecode,
					            to_crim_offender(left,right), 
					            left outer, local);//:persist ('~thor_data200::persist::crim::arrest::offender_after_did');

result_common1	:= dedup(sort(distribute(result_comm, hash(recordid,sourceid)), record,local), record,local);

	//Following code requird if we are using persistent offender_key - based on DOC numbers etc					
	Layout_Common_Crim_Offender_orig transferkey (result_common1 L, result_common1 R) := transform
	 self.offender_key := r.offender_key;
	 self.case_number  := r.case_number;
	 self := L;
	end; 					

result_aliases := join(result_common1(pty_typ ='2'),result_common1(pty_typ ='0'), 
					             left.recordid = right.recordid and 
											 left.sourceid = right.sourceid,
					             transferkey(left,right), 
					             local);

result_common2 := project(result_common1(pty_typ ='0'),Layout_Common_Crim_Offender_orig)+result_aliases;	

//REMOVE RECORDS WITH NO VENDOR CODE ASSIGNED////////////////////////////////////
result_common3 := distribute(result_common2(trim(vendor, left, right)<>''),HASH(offender_key));

//Pick one image for each offender_key
//Simple dedup without the imagelink doesn't work because different addresses create duplicates as well
image_slim    := dedup(sort(distribute(table(result_common3,{offender_key,image_link},offender_key,image_link,few),HASH(offender_key)),  
                    record, local), record, except image_link, right,local);

Layout_Common_Crim_Offender_orig transferimagelink (result_common3 L, image_slim R) := transform
	 self.image_link := R.image_link;
	 self := L;
	end; 					

result_common4 := join(result_common3,image_slim, 
					             left.offender_key = right.offender_key ,										 
					             transferimagelink(left,right),left outer, 
					             local);
                      
											
sorted_rcommon	:= sort(result_common4, 
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
											

result_common_dedup := 	dedup(sort(rollupCrimOut,
process_date, offender_key, vendor, State_Origin, data_type, source_file, case_number, case_court, case_name, case_type, case_type_desc, case_filing_dt, pty_nm, pty_nm_fmt, orig_lname, orig_fname, orig_mname, orig_name_suffix, 
nitro_flag, orig_ssn, dle_num, fbi_num, doc_num, ins_num, id_num, dl_num, dl_state, citizenship, dob, dob_alias, place_of_birth, street_address_1, street_address_2, street_address_3, street_address_4, street_address_5, race, 
race_desc, SEX, hair_color, hair_color_desc, eye_color, eye_color_desc, skin_color, skin_color_desc, height, WEIGHT, party_status, party_status_desc, prim_range, predir, prim_name, addr_suffix, postdir, unit_desig, sec_range, 
p_city_name, state, zip5, zip4, fname, mname, lname, name_suffix,cleaning_score, pgid, src_upload_date, age, image_link,pty_typ , local ),record,except age,pty_typ,left,local ): persist ('~thor_data200::persist::hygenics::crim::HD::arrest::offender_test');

export proc_build_arrest_crim_offender2_base := result_common_dedup ;  //sequential(o1);



