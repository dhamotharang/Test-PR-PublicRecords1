import Crim_Common, Address, VersionControl;

p	:= ArrestLogs.file_GA_Gwinnett.cmbnd;

Crim_Common.Layout_In_Court_Offender tGwinnett(p input) := Transform
updateFileNo   := fileservices.GetSuperFileSubCount('~thor_data400::in::arrlog::ga::gwinnett'): stored('updateFileNo');; 
updateFileName := fileservices.GetSuperFileSubName('~thor_data400::in::arrlog::ga::gwinnett',updateFileNo): stored('updateFileName');
update_date    := stringlib.stringfilter(regexreplace('thor_data400',updateFileName,''),'0123456789')[1..8]: stored('update_date');

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=     intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
 +     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
 +     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date		:= update_date;
self.offender_key		:= 'AN'+input.ID;
self.vendor				:= 'AN';
self.state_origin		:= 'GA';
self.data_type			:= '5';
self.source_file		:= '(CV)GA-GwinnettCtyArr';
self.case_number		:= '';
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= '';
self.pty_nm				:= regexreplace(' +',input.First_Name+' '+regexreplace('NMN',input.Middle_Name,'')+' '+input.Last_Name,' ');
self.pty_nm_fmt			:= 'F';
self.orig_lname			:= input.Last_Name;
self.orig_fname			:= input.First_Name;
self.orig_mname			:= input.Middle_Name;
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
self.dob				:= if(fSlashedMDYtoCYMD(input.Birth_Dt)[1..2] = '19',
						   fSlashedMDYtoCYMD(input.Birth_Dt),
						   '');
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= '';
self.street_address_2	:= '';
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
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

pGwinnett := project(p, tGwinnett(left));

ArrestLogs.ArrestLogs_clean(pGwinnett,cleanGwinnett);

arrOut:= cleanGwinnett + ArrestLogs.FileAbinitioOffender(vendor='AN');

dd_arrOut :=  dedup(sort(distribute(arrOut(regexfind('[0-9]',pty_nm)=false),hash(offender_key)),
										offender_key,pty_typ,lname,fname,mname,name_suffix,case_filing_dt,source_file,local)
										,offender_key,pty_typ,lname,fname,local,right): 
										PERSIST('~thor_dell400::persist::Arrestlogs_GA_Gwinnett_Offender');

export map_GA_GwinnettOffender := dd_arrOut;