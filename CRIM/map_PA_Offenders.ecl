import crim_common, Crim, Address;

fPAOffend_init	:= Crim.File_PA_CROTN;

// Remove Expunge Records //

dPA_Exp := dedup(sort(Crim.File_PA_Expunge.File_PA_Updating_Expunge,Docket_Number), Docket_Number);

fPAOffend_exp := join(fPAOffend_init, dPA_Exp, left.DISTRICT_NUMBER + left.Docket_number=right.Docket_number, left only);

Crim.layout_PA_CROTN Exp_remove(fPAOffend_exp input) := transform
self := input;
END;

fPAOffend := project(fPAOffend_exp, Exp_remove(left));
// End Of Remove Expunge Records //

Crim_Common.Layout_In_Court_Offender tPAOffend(fPAOffend input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= '46'+trim(input.DISTRICT_NUMBER,left,right)+trim(input.DOCKET_NUMBER,left,right);
self.vendor				:= '46';
self.state_origin		:= 'PA';
self.data_type			:= '2';
self.source_file		:= '(CV)PA STATEWIDE CRI';
self.case_number		:= trim(input.DOCKET_NUMBER,left,right);
self.case_court			:= 'District '+trim(input.DISTRICT_NUMBER,left,right);
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= '';/*if(if(trim(input.scheduled_year,left,right)[1]='0','',
								if(trim(input.scheduled_year,left,right)[1]='1','19'+trim(input.scheduled_year,left,right)[2..3],
								if(trim(input.scheduled_year,left,right)[1]='2','20'+trim(input.scheduled_year,left,right)[2..3],'')))+
								if(DataLib.StringFind(input.scheduled_month, ' ',2)=2,'0'+trim(input.scheduled_month,left,right),trim(input.scheduled_month,left,right))+
								if(DataLib.StringFind(input.scheduled_day, ' ',2)=2,'0'+trim(input.scheduled_day,left,right),trim(input.scheduled_day,left,right)) < Crim_Common.Version_In_Arrest_Offender,	
							if(trim(input.scheduled_year,left,right)[1]='0','18'+trim(input.scheduled_year,left,right)[2..3],
								if(trim(input.scheduled_year,left,right)[1]='1','19'+trim(input.scheduled_year,left,right)[2..3],
								if(trim(input.scheduled_year,left,right)[1]='2','20'+trim(input.scheduled_year,left,right)[2..3],'')))+
								if(DataLib.StringFind(input.scheduled_month, ' ',2)=2,'0'+trim(input.scheduled_month,left,right),trim(input.scheduled_month,left,right))+
								if(DataLib.StringFind(input.scheduled_day, ' ',2)=2,'0'+trim(input.scheduled_day,left,right),trim(input.scheduled_day,left,right)),							
							'');*/
self.pty_nm				:= regexreplace('AKA',input.FIRST_NAME,'')+' '+regexreplace('AKA',input.LAST_NAME,'');
self.pty_nm_fmt			:= 'F';
self.orig_lname			:= regexreplace('AKA',input.LAST_NAME,'');
self.orig_fname			:= regexreplace('AKA',input.FIRST_NAME,'');     
self.orig_mname			:= '';
self.orig_name_suffix	:= '';
self.pty_typ			:= '0';
self.nitro_flag			:= '';
self.orig_ssn			:= '';
self.dle_num			:= '';
self.fbi_num			:= '';
self.doc_num			:= '';
self.ins_num			:= '';
self.id_num				:= '';
self.dl_num				:= '';
self.dl_state			:= '';
self.citizenship		:= '';
self.dob				:= '';
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= regexreplace('C/O',trim(input.address,left,right),'');
self.street_address_2	:= if(input.street_number<>'',trim(input.street_number,left,right),'')+' '+
						   if(input.street_name<>'',trim(input.street_name,left,right),'')+' '+
						   if(input.apartment_number<>'','APT','')+' '+trim(input.apartment_number,left,right);
self.street_address_3	:= trim(input.city,left,right);
self.street_address_4	:= input.state;
self.street_address_5	:= if(trim(input.zip,left,right)<>'1',input.zip,'');
self.race				:= '';
self.race_desc			:= '';
self.sex				:= '';
self.hair_color			:= '';
self.hair_color_desc	:= '';
self.eye_color			:= '';
self.eye_color_desc		:= '';
self.skin_color			:= '';
self.skin_color_desc	:= '';
self.height				:= '';
self.weight				:= '';
self.party_status		:= '';
self.party_status_desc	:= '';
self.prim_range 		:= ''; 
self.predir 			:= '';					   
self.prim_name 			:= '';
self.addr_suffix 		:= '';
self.postdir 			:= '';
self.unit_desig 		:= '';
self.sec_range 			:= '';
self.p_city_name 		:= '';
self.v_city_name 		:= '';
self.state 				:= '';
self.zip5 				:= '';
self.zip4 				:= '';
self.cart 				:= '';
self.cr_sort_sz 		:= '';
self.lot 				:= '';
self.lot_order 			:= '';
self.dpbc 				:= '';
self.chk_digit 			:= '';
self.rec_type 			:= '';
self.ace_fips_st		:= '';
self.ace_fips_county	:= '';
self.geo_lat 			:= '';
self.geo_long 			:= '';
self.msa 				:= '';
self.geo_blk 			:= '';
self.geo_match 			:= '';
self.err_stat 			:= '';
self.title 				:= '';
self.fname 				:= '';
self.mname 				:= '';
self.lname 				:= '';
self.name_suffix 		:= '';
self.cleaning_score 	:= ''; 

end;

pPAOffend := project(fPAOffend, tPAOffend(left));

pPAFilterOffend := pPAOffend(regexfind('EXPUNG',orig_fname)<>(boolean)'TRUE' and regexfind('EXPUNG',orig_lname)<>(boolean)'TRUE');

Crim.Crim_clean(pPAFilterOffend,cleanPAOffend);

//arrOut:= cleanLosAngeles + Crim.FileAbinitioOffender(vendor='AG');

dd_PAOut := dedup(sort(distribute(cleanPAOffend,hash(offender_key)),
										offender_key,case_number,case_court,pty_nm,pty_nm_fmt,pty_typ,dob,local),
										offender_key,pty_nm,pty_typ,local,left): 
										PERSIST('~thor_dell400::persist::Crim_PA_Offender_Clean');

export map_PA_Offenders := dd_PAOut;
