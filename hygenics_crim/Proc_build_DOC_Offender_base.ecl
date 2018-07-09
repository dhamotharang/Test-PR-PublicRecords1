import crim_common, did_add, didville, header, header_slimsort, ut, watchdog, address,nid;

def 		:= sort(distribute(hygenics_crim.file_in_defendant_doc(),hash(recordid)),recordid,local);
ah			:= dedup(sort(distribute(hygenics_crim.file_in_addresshistory_doc(),hash(recordid)),recordid,local),record,local);
aka	  	:= dedup(sort(distribute(hygenics_crim.file_in_alias_doc(),hash(recordid)),recordid,local),record,local);

// Not including GA prior records because they give us only offense codes and nothing else
pri   	:= hygenics_crim.file_in_priors_doc(sourcename = 'GEORGIA_DEPARTMENT_OF_CORRECTIONS');
off 		:= hygenics_crim.file_in_offense_doc();
cha 		:= dedup(sort(distribute(hygenics_crim.file_in_charge_doc,hash(recordid)),recordid,local),record,local);
	
	slimOffense_rec := RECORD 
		off.recordid;
		off.statecode;
		off.DocketNumber;
		off.CaseNumber;
		off.CaseID;
		off.Casetitle;
		off.Casetype;
		off.Fileddate;
		off.Courtname;
		off.sourceid;
	end;

	slim_off := distribute(table(off, slimOffense_rec, 
								off.recordid,
								off.statecode,
								off.DocketNumber,
								off.CaseNumber,
								off.CaseID,
								off.Casetitle,
								off.Casetype,
								off.Fileddate,
								off.Courtname,
								off.sourceid), hash(recordid));

	slimOffense_rec slimprior(pri l) := transform
		self := l;
		self := [];
	end;

slim_prior := dedup(sort(distribute(project(pri, slimprior(left)) ,hash(recordid)), record, local), record, local);

	def join_def_alias(def l, aka r) := transform 
	  self.nametype 	:= 'A';
	  self.Name 			:= r.AKAname;
	  self.LastName 	:= r.AKAlastname;
	  self.FirstName 	:= r.AKAfirstname;
	  self.MiddleName := r.AKAmiddlename;
	  self.Suffix 		:= r.AKAsuffix;
	  self.DOB 				:= Map(trim(r.akadob) ='19000101' => '',
											((integer)stringlib.GetDateYYYYMMDD()[1..4])-((integer)r.akadob[1..4]) >= 18 => trim(r.akadob), 
											'');
	  self 						:= l;
	end;

	def_with_alias := join(def, aka,
											left.recordid=right.recordid and 
											left.statecode=right.statecode,
											join_def_alias(left,right),local);

all_names := def_with_alias + def;

	def join_def_ah(def l, ah r) := transform 
	  //self.nametype := 'H';
	  self := r;
	  self := l;
	end;

	def_with_ahist := join(all_names, ah,
											left.recordid=right.recordid and 
											left.statecode=right.statecode,
											join_def_ah(left,right),local);
		
all_names_addresses := def_with_ahist + all_names ;

layout_temp_offender addrPop(all_names_addresses l):= transform
		 self.j_RecordID 			:= l.recordid;
		 self.j_StateCode 		:= l.statecode;
     self.name_type_hd    := l.nametype; // added this b/c NID cleaner over writes this field.

		 self.name            := MAP(l.name ='' => l.firstname+' '+l.middlename+' '+l.lastname+' '+l.suffix ,
                                 l.name);
  vStreet               := MAP(l.street in _functions.StreetAddressToFilter => '',
		                           l.street);
	self.street_address_1 := vStreet+if(l.unit<>'', ' '+l.unit, '');
	self.street_address_2 := _functions.CleanAddress(l.city+', '+l.orig_state+' '+l.orig_zip);

	self := l;
	self := [];
end;

addrProject 	:= project(all_names_addresses, addrPop(left),local):INDEPENDENT ;

	cleanAddress := hygenics_crim._fns_AddressCleaner(addrProject):persist ('~thor_data200::persist::crim::DOCAddresscache');
  //NID Name cleaner/////////////////////////////////

	nid.mac_cleanfullnames(cleanAddress, cleanfullnames, name);
	// nid.mac_cleanfullnames(cleanAddress, cleanfullnames, name,useV2:=true);

	cleanfullnames projFile(cleanfullnames l):= transform
		self := l;
	end;
	
	all_clean_name_addr := project(cleanfullnames, projFile(left)):persist('~thor_200::persist::crimdoc_offender_nid');
	//with_ssn						:= all_clean_name_addr;

	slim_AllOff 				:= slim_prior + slim_off;
	
	addChgLayout := record
		slim_AllOff;
		string8	BookingDate;
	end;

	addChgLayout addField(slim_AllOff l, cha r):= transform
		self := l;
		self.bookingdate := r.bookingdate;
	end;
	 
	slim_AllOffChg := join(slim_AllOff, cha,
												left.statecode=right.statecode and 
												left.recordid=right.recordid and 
												left.caseid=right.caseid, 
												addField(left,right), left outer, local);
	
	with_ssn 				:= dedup(sort(distribute(all_clean_name_addr, hash(recordid)), recordid, local), record, local);
	slim_AllOffense := dedup(sort(distribute(slim_AllOffChg, hash(recordid)), recordid, local), record, local);

	Layout_almostfinal_offender := record
		 Layout_Common_Crim_Offender_orig;
		 hygenics_crim.layout_in_defendant.recordid;
	end;

	Layout_almostfinal_offender to_crim_offender(with_ssn l, slim_AllOffense r) := transform
		// List of Mapping issues to fix 
		// 1) Place of birth in SC
		// 2) Party status in OR; Also, fields have codes instead of desc

		vVendor 								:= hygenics_crim._functions.fn_sourcename_to_vendor(trim(l.sourcename),l.statecode);
		 
		string temp_case_number	:= MAP(stringlib.stringfind(r.casenumber,'INCORRECT',1) >0 =>'',
																		r.casenumber); 	
											
		string ls_source     		:= hygenics_crim._functions.fn_shorten_sourcename(l.sourcename);			
		 
		vcase_type          		:= MAP (l.recordtype = 'CRIMINAL ADMISSION' =>'ADM',  
																		l.recordtype = 'CRIMINAL RELEASE' => 'REL',    
																		l.recordtype = 'CRIMINAL RESIDENT' => 'RES',
																		'');
		
		v_pty_nm                 := StringLib.StringFilter(StringLib.StringToUpperCase(l.name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); 
		v_doc_num1               := StringLib.StringFilter(StringLib.StringToUpperCase(l.docnumber),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
		v_inm_num1               := StringLib.StringFilter(StringLib.StringToUpperCase(l.inmatenumber),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'); 
		v_stid_num1              := StringLib.StringFilter(StringLib.StringToUpperCase(l.stateidnumber),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'); 
		//v_filter_list           := ['NA','UNK','NULL','R000'];
		v_doc_num               := IF(v_doc_num1  in _functions.Filterlist,'',v_doc_num1);
		v_inm_num               := IF(v_inm_num1  in _functions.Filterlist,'',v_inm_num1);
		v_stid_num              := IF(v_stid_num1 in _functions.Filterlist,'',v_stid_num1);
		
		self.offender_key				:= MAP(l.name_type_hd not in ['A'] and vVendor in [
																	'DA','DB','DH','DJ','DI',
																	'DP','DM','DQ','DN','SB',
																	'DS','DU','EU','DY','DV',
																	'DX','EV','WG','EW','EX',
																	'EF','WH','WK','EP','ER',
																	'ET','DF','6X','ZB','6W'] and v_doc_num <> ''  => trim(vVendor) + v_doc_num, 
																	
																l.name_type_hd not in ['A'] and vVendor in [
																	'DD','DG','WL','DD','VE',
																	'WD','EA','WC','ED','WF',
																	'EE','EG','EI','EJ','EO',
																	'EQ'] and v_inm_num <> ''	=> trim(vVendor) + v_inm_num,
																	
																vVendor in [
																	'EL','DW','6H','6Z'] and v_stid_num <> ''	=> trim(vVendor) + v_stid_num +trim(l.dob, all),
																	
																vVendor in [
																	'DR','DZ','WE','EK','ES','EM'] and v_stid_num <> ''	=> trim(vVendor) + v_stid_num,
																	
																l.name_type_hd not in ['A'] and vVendor in [
																	'DO','EB','EC','WJ','EH','EN'] => trim(vVendor) + (string)HASH64( v_pty_nm) + trim(l.gender, all) + trim(l.dob, all) + trim(l.race, all),
																
																l.name_type_hd not in ['A'] and vVendor in [
																	'DT']  			 => trim(vVendor) + (string)HASH64( v_pty_nm) + trim(l.gender, all) + trim(l.race, all) + trim(l.dob, all) + trim(r.courtname, all) + trim(r.docketnumber, all),
																
																l.name_type_hd not in ['A'] and vVendor in [
																	'EY'] 			 => trim(vVendor) + (string)HASH64( v_pty_nm) + trim(l.gender, all) + trim(r.bookingdate, all),
																//l.name_type_hd <> 'A' and vVendor in [
																//	'DL']				 => vVendor + (string)HASH64( v_pty_nm)+ trim(l.dob, all)  ,																
																
																l.name_type_hd not in ['A'] and trim(l.dob, all) <> '' => trim(vVendor) + (string)HASH64( v_pty_nm) +  trim(l.dob, all),
																
																l.name_type_hd not in ['A'] and trim(l.dob, all) =  '' => trim(vVendor) + (string)HASH64( v_pty_nm) +  trim(l.gender, all) + trim(l.race, all),
																'');	
																//hygenics_crim._functions.fn_persistent_offender_key(vVendor, l.name, l.dob, l.docnumber, l.inmatenumber, 
																//l.stateidnumber, l.fbinumber, temp_case_number, r.fileddate, vcase_type)
																//);
										
		self.state_origin				:= l.statecode;
		self.vendor							:= vVendor;
		self.source_file				:= ls_source;
																			
		self.process_date				:= stringlib.getdateyyyymmdd();

		self.data_type					:= '1';
		self.case_number				:= temp_case_number;
		self.case_court					:= r.courtname;
		self.case_name					:= r.casetitle;

		self.case_type					:= vcase_type;
		self.case_type_desc			:= 'Department Of Correction';
		self.case_filing_dt			:= map(trim(r.fileddate) ='19000101' => '', 
																length(r.fileddate)>=4 and trim(r.fileddate)[1..2] in ['19','20'] => trim(r.fileddate),
																'');
		self.pty_nm							:= trim(trim(trim(trim(l.firstname)+' '+trim(l.middlename))+' '+trim(l.lastname))+' '+trim(l.suffix));
		self.pty_nm_fmt					:= 'F';
		self.orig_lname					:= trim(l.lastname);
		self.orig_fname					:= trim(l.firstname);
		self.orig_mname					:= trim(l.middlename);
		self.orig_name_suffix		:= l.suffix;

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
		                               //l.name_type_hd ='H' => '3',
																	'0');
		self.nitro_flag					:= '';
		self.orig_ssn						:= l.orig_ssn;
		self.dle_num						:= l.stateidnumber;
		self.fbi_num						:= regexreplace('-',l.fbinumber,'');
		self.doc_num						:= l.docnumber;
		self.ins_num						:= l.aliennumber;
		self.id_num							:= l.inmatenumber;
		self.dl_num							:= l.dlnumber;	
		self.dl_state						:= l.dlstate;

		self.citizenship				:= if(l.uscitizenflag='Y','US','');	

		self.dob								:= Map(trim(l.dob) ='19000101' => '',
																l.dob[1..2] in ['19','20'] and ((integer)stringlib.GetDateYYYYMMDD()[1..4])-((integer)l.dob[1..4])>=18 => trim(l.dob,left,right),
																'');

		self.dob_alias					:= '';
		self.place_of_birth			:= MAP(l.birthcity <> '' and l.birthplace <> '' => trim(trim(l.birthcity)+' '+ l.birthplace,left,right),
																 l.birthcity <> '' => trim(l.birthcity),
																 l.birthplace <> '' => trim(l.birthplace,left,right),
																 '');


    tempstreet              := trim(l.street)+if(l.unit<>'', ' APT: '+l.unit, '');
    self.street_address_1	  := If(length(tempstreet)>25, tempstreet[1..25],tempstreet);
    self.street_address_2  	:= If(length(tempstreet)>25, tempstreet[26..],'');
    self.street_address_3	  := trim(l.city);
    self.street_address_4  	:= trim(l.orig_state);
    self.street_address_5	  := trim(l.orig_zip);
		
		self.race								:= if(length(trim(l.race))=1 , trim(l.race),'');
		 
			string temp_race    	:= hygenics_crim._functions.fn_standarddize_race(l.race);		 
			string temp_ethn    	:= hygenics_crim._functions.fn_standarddize_race(l.ethnicity);																	 
		 
		self.race_desc					:= If (temp_race  <> '' ,trim(temp_race), trim(temp_ethn));	
		 
		self.sex								:= map(l.gender[1..1] in ['M','F'] => l.gender[1..1],
																'');
		
		self.hair_color					:= MAP(l.haircolor<>'' and regexfind('[0-9]',l.haircolor) =>'' ,
																trim(l.haircolor) in ['XX','UNK','UNKNOWN','XXX','N/A','!!!','---'] => '',
																length(trim(l.haircolor)) <= 3 => trim(l.haircolor),
																l.haircolor);									
		
		self.hair_color_desc		:= _functions.fn_standardize_haircolor(l.haircolor);                 						 
		
		self.eye_color					:= Map(l.eyecolor<>'' and regexfind('[0-9]',l.eyecolor) =>'',
															 trim(l.eyecolor) in ['XX','UNK','XXX','UNKNOWN','N/A','!!!','---'] => '',
															 length(trim(l.eyecolor)) <= 3 => trim(l.eyecolor) ,
															 l.eyecolor);								 
		
		self.eye_color_desc			:= _functions.fn_standardize_eyecolor(l.eyecolor);	 
		self.skin_color					:= '';
		self.skin_color_desc		:= MAP(l.skincolor<>'' and regexfind('[0-9]',l.skincolor) =>'',
																l.skincolor);
				
		self.height							:= hygenics_crim._functions.fn_height_to_inches(l.height);
		self.weight							:= if((integer) stringlib.stringfilter(l.weight,'1234567890')<>0,
																stringlib.stringfilter(l.weight,'1234567890'),
																'');							
		self.party_status				:= '';
		self.party_status_desc	:= MAP(
		                            vVendor ='6W' and regexfind('([A-Z -]+)[ ]*([(][0-9/]*[)]*)',l.defendantstatus) => stringlib.stringfilterout(regexreplace('([A-Z -]+)[ ]*([(][0-9/]*[)]*)',l.defendantstatus,'$1'),'('),
																regexfind('LAST MOVE DATE: [0-9]*',l.defendantstatus) => '',
																regexfind('STATUS START ',l.defendantstatus) => '',
																l.defendantstatus);
		self.pgid								:= '';
		self.src_upload_date 		:= l.recorduploaddate;
		self.age         				:= l.age;
		self.image_link					:= if(trim(l.photoname, left, right)<>'',
																StringLib.StringToUpperCase(trim(vVendor)+'_'+l.photoname),
																'');
		self 										:= l;
	end;

result_comm 	:= join(distribute(with_ssn, hash(recordid)), slim_AllOffense, 
											left.recordid=right.recordid and 
											left.statecode=right.statecode and 
											left.sourceid = right.sourceid,
											to_crim_offender(left,right), local, left outer):persist('~thor40_241::persist::doc_offender_key');

result_common1	:= dedup(sort(distribute(result_comm, hash(recordid, state_origin)), record,local), record,local);
					
//Following code requird if we areusing persistent offender_key_alternate - based on DOC numbers etc					
	Layout_Common_Crim_Offender_orig transferkey (result_common1 L, result_common1 R) := transform
		 self.offender_key := r.offender_key;
		 self.case_number  := r.case_number;
		 self := L;
	end; 					

result_aliases 	:= join(result_common1(pty_typ in ['2']), result_common1(pty_typ ='0'), 
											left.recordid = right.recordid and 
											left.state_origin = right.state_origin,
											transferkey(left,right), local);
											
					
result_common2 	:= project(result_common1(pty_typ ='0'), Layout_Common_Crim_Offender_orig) + result_aliases ;
//REMOVE RECORDS WHERE VENDOR CODE IS NOT ASSIGNED//////////////
ds_offender 	:= result_common2(pty_nm <> '' and trim(vendor, left, right)<>'');

///////////////////////////////////////////////////////////////////////

	ds_offender rollupdef(ds_offender L, ds_offender R) := TRANSFORM
		self.case_filing_dt  	:= if(l.case_filing_dt  	= '', r.case_filing_dt , l.case_filing_dt);	
		self.case_number      := if(l.case_number       = '',  r.case_number,  l.case_number);
		self.doc_num  			:= if(l.doc_num    			= '', r.doc_num , l.doc_num);
		self.id_num  			:= if(l.id_num     			= '', r.id_num  , l.id_num);
		self.dle_num  			:= if(l.dle_num    			= '', r.dle_num , l.dle_num);
		self.ins_num  			:= if(l.ins_num    			= '', r.ins_num , l.ins_num);
		self.fbi_num  			:= if(l.fbi_num    			= '', r.fbi_num , l.fbi_num);
		self.dl_num  			:= if(l.dl_num    			= '', r.dl_num  , l.dl_num);
		self.dl_state  			:= if(l.dl_state  			= '', r.dl_state, l.dl_state);
		self.race  			    := if(l.race       			= '', r.race , l.race);
		self.race_desc  		:= if(l.race_desc  			= '', r.race_desc , l.race_desc);	
		self.sex  	          	:= if(l.sex        			= '', r.sex , l.sex);	
		self.weight  	        := if(l.weight     			= '', r.weight , l.weight);	
		self.height  	        := if(l.height     			= '', r.height , l.height);	
		self.hair_color     	:= if(l.hair_color 			= '', r.hair_color , l.hair_color);	
		self.hair_color_desc  	:= if(l.hair_color_desc 	= '', r.hair_color_desc , l.hair_color_desc);	
		self.eye_color  	    := if(l.eye_color       	= '', r.eye_color , l.eye_color);	
		self.eye_color_desc  	:= if(l.eye_color_desc  	= '', r.eye_color_desc , l.eye_color_desc);	
		self.skin_color     	:= if(l.skin_color      	= '', r.skin_color , l.skin_color);
		self.skin_color_desc  	:= if(l.skin_color_desc 	= '', r.skin_color_desc , l.skin_color_desc);
		self.party_status     	:= if(l.party_status    	= '', r.party_status , l.party_status);
		self.party_status_desc	:= if(l.party_status_desc	= '', r.party_status_desc , l.party_status_desc);
		self.prim_range     	:= if(l.prim_range       	= '', r.prim_range , l.prim_range);
		self.predir     	    := if(l.predir           	= '', r.predir , l.predir);
		self.prim_name        	:= if(l.prim_name        	= '', r.prim_name , l.prim_name);
		self.addr_suffix      	:= if(l.addr_suffix      	= '', r.addr_suffix , l.addr_suffix);
		self.postdir          	:= if(l.postdir          	= '', r.postdir , l.postdir);
		self.unit_desig       	:= if(l.unit_desig       	= '', r.unit_desig , l.unit_desig);
		self.sec_range        	:= if(l.sec_range        	= '', r.sec_range , l.sec_range);
		self.v_city_name      	:= if(l.v_city_name      	= '', r.v_city_name , l.v_city_name);
		self.state            	:= if(l.state            	= '', r.state , l.state);
		self.zip5             	:= if(l.zip5             	= '', r.zip5 , l.zip5);
		SELF 					:= L; 
	END;

Rollup_offender := ROLLUP(sort(distribute(ds_offender,HASH(offender_key,vendor,state_origin)),
                          offender_key,dob,fname,lname,mname,name_suffix ,vendor,state_origin,source_file ,
                          case_filing_dt ,case_number ,doc_num,id_num ,dle_num,ins_num,fbi_num,dl_num ,dl_state    ,
                          race ,race_desc,sex  ,weight ,height ,hair_color  ,hair_color_desc,eye_color   ,eye_color_desc ,
                          skin_color  ,skin_color_desc,party_status,party_status_desc	,prim_range  ,predir ,prim_name   ,addr_suffix ,
                          postdir,unit_desig  ,sec_range   ,v_city_name ,state,zip5,pty_typ, local),		


													 left.offender_key            = right.offender_key and 
													 left.dob                     = right.dob and 
													 left.fname                   = right.fname and
													 left.lname                   = right.lname and
													 left.mname                   = right.mname and 
													 left.name_suffix             = right.name_suffix and 
													 left.vendor                  = right.vendor and
													 left.state_origin            = right.state_origin and 
													 left.source_file             = right.source_file and 
													(left.case_filing_dt    = ''   or right.case_filing_dt  = ''   or trim(left.case_filing_dt)  = trim(right.case_filing_dt)) and 
													(left.case_number       = ''   or right.case_number     = ''   or trim(left.case_number)     = trim(right.case_number)) and 
													(left.doc_num           = ''   or right.doc_num         = ''   or trim(left.doc_num)  = trim(right.doc_num)) and 
													(left.id_num            = ''   or right.id_num          = ''   or trim(left.id_num)   = trim(right.id_num))  and 
													(left.dle_num           = ''   or right.dle_num         = ''   or trim(left.dle_num)  = trim(right.dle_num)) and 
													(left.ins_num           = ''   or right.ins_num         = ''   or trim(left.ins_num)  = trim(right.ins_num)) and 
													(left.fbi_num           = ''   or right.fbi_num         = ''   or trim(left.fbi_num)  = trim(right.fbi_num)) and 
													(left.dl_num            = ''   or right.dl_num          = ''   or trim(left.dl_num)   = trim(right.dl_num)) and 
													(left.dl_state          = ''   or right.dl_state        = ''   or trim(left.dl_state) = trim(right.dl_state)) and 
													(left.race              = ''   or right.race            = ''   or trim(left.race)= trim(right.race)) and 
													(left.race_desc         = ''   or right.race_desc       = ''   or trim(left.race_desc)= trim(right.race_desc)) and 
													(left.sex               = ''   or right.sex             = ''   or trim(left.sex)      = trim(right.sex)) and 
													(left.weight            = ''   or right.weight          = ''   or trim(left.weight)   = trim(right.weight)) and 
													(left.height            = ''   or right.height          = ''   or trim(left.height)   = trim(right.height)) and 
													(left.hair_color        = ''   or right.hair_color      = ''   or trim(left.hair_color)       = trim(right.hair_color)) and 
													(left.hair_color_desc   = ''   or right.hair_color_desc = ''   or trim(left.hair_color_desc)  = trim(right.hair_color_desc)) and 
													(left.eye_color         = ''   or right.eye_color       = ''   or trim(left.eye_color)        = trim(right.eye_color))  and 
													(left.eye_color_desc    = ''   or right.eye_color_desc  = ''   or trim(left.eye_color_desc)   = trim(right.eye_color_desc))  and 
													(left.skin_color        = ''   or right.skin_color      = ''   or trim(left.skin_color)       = trim(right.skin_color)) and 
													(left.skin_color_desc   = ''   or right.skin_color_desc = ''   or trim(left.skin_color_desc)  = trim(right.skin_color_desc)) and 
													(left.party_status      = ''   or right.party_status    = ''   or trim(left.party_status)     = trim(right.party_status)) and 
													(left.party_status_desc = ''   or right.party_status_desc= ''  or trim(left.party_status_desc)= trim(right.party_status_desc)) and 
													(left.prim_range        = ''   or right.prim_range  = '' or trim(left.prim_range) = trim(right.prim_range)) and 
													(left.predir            = ''   or right.predir      = '' or trim(left.predir)     = trim(right.predir)) and 
													(left.prim_name         = ''   or right.prim_name   = '' or trim(left.prim_name)  = trim(right.prim_name)) and 
													(left.addr_suffix       = ''   or right.addr_suffix = '' or trim(left.addr_suffix)= trim(right.addr_suffix)) and 
													(left.postdir           = ''   or right.postdir     = '' or trim(left.postdir)    = trim(right.postdir)) and 
													(left.unit_desig        = ''   or right.unit_desig  = '' or trim(left.unit_desig) = trim(right.unit_desig)) and 
													(left.sec_range         = ''   or right.sec_range   = '' or trim(left.sec_range)  = trim(right.sec_range)) and 
													(left.v_city_name       = ''   or right.v_city_name = '' or trim(left.v_city_name)= trim(right.v_city_name)) and 
													(left.state             = ''   or right.state       = '' or trim(left.state)      = trim(right.state)) and
													(left.zip5              = ''   or right.zip5        = '' or trim(left.zip5)       = trim(right.zip5)) ,
													 rollupdef(LEFT,RIGHT),local);
		
export proc_build_DOC_Offender_base := Rollup_offender : persist ('persist::out::crim::HD::DOC::offender'); 