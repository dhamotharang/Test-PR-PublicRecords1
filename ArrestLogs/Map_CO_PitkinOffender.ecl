import Crim_Common, Address, lib_date;

p1	:= ArrestLogs.file_CO_Pitkin;
p2  := ArrestLogs.file_CO_Pitkin_new;

newLayout := record
string ID;
string Name;
string DOB;
string Sex;
string Offense;
string book_dt;
string Bonds;
string Class;
end;

newLayout rPitkin1(p1 input) := transform
self.class 		:= '';
self.book_dt 	:= (string)LIB_Date.Date_MMDDYY_I2(regexreplace('/',input.book_dt,''));
self.dob		:= (string)LIB_Date.Date_MMDDYY_I2(regexreplace('/',input.dob,''));
self := input;
end;

pOld := project(p1,rPitkin1(left));

newLayout rPitkin2(p2 input) := transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.name 		:= if(trim(input.lastname,left,right)<>'' and trim(input.firstname,left,right)<>'' and trim(input.middlename)<>'',
					StringLib.StringToUpperCase(trim(input.lastname,left,right)+', '+trim(input.firstname,left,right)+' '+trim(input.middlename)),
					if(trim(input.lastname,left,right)<>'' and trim(input.firstname,left,right)<>'' and trim(input.middlename)='',
					StringLib.StringToUpperCase(trim(input.lastname,left,right)+', '+trim(input.firstname,left,right)),''));
self.book_dt 	:= if(StringLib.StringFind(input.arrest_date,'/',1)=2 and StringLib.StringFind(input.arrest_date,'/',2)=4,
					fSlashedMDYtoCYMD('0'+input.arrest_date[1..2]+'0'+input.arrest_date[3..8]),
					if(StringLib.StringFind(input.arrest_date,'/',1)=3 and StringLib.StringFind(input.arrest_date,'/',2)=5,
					fSlashedMDYtoCYMD(input.arrest_date[1..3]+'0'+input.arrest_date[4..9]),
					if(StringLib.StringFind(input.arrest_date,'/',1)=2 and StringLib.StringFind(input.arrest_date,'/',2)=5,
					fSlashedMDYtoCYMD('0'+input.arrest_date[1..9]),
					if(StringLib.StringFind(input.arrest_date,'/',1)=3 and StringLib.StringFind(input.arrest_date,'/',2)=6,
					fSlashedMDYtoCYMD(input.arrest_date[1..10]),
					''))));
self.dob 		:= if(StringLib.StringFind(input.dob,'/',1)=2 and StringLib.StringFind(input.dob,'/',2)=4,
					fSlashedMDYtoCYMD('0'+input.dob[1..2]+'0'+input.dob[3..8]),
					if(StringLib.StringFind(input.dob,'/',1)=3 and StringLib.StringFind(input.dob,'/',2)=5,
					fSlashedMDYtoCYMD(input.dob[1..3]+'0'+input.dob[4..9]),
					if(StringLib.StringFind(input.dob,'/',1)=2 and StringLib.StringFind(input.dob,'/',2)=5,
					fSlashedMDYtoCYMD('0'+input.dob[1..9]),
					if(StringLib.StringFind(input.dob,'/',1)=3 and StringLib.StringFind(input.dob,'/',2)=6,
					fSlashedMDYtoCYMD(input.dob),
					''))));
self := input;
end;

pNew := project(p2,rPitkin2(left));

p	:= pOld+pNew;

fPitkin := p(trim(p.Name,left,right) ~in ['Name','LASTNAME, FIRSTNAME MIDDLENAME']);

Crim_Common.Layout_In_Court_Offender tPitkin(fPitkin input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);
 
self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= (string)'D8'+hash(trim(input.Name,all))+lib_date.Date_MMDDYY_I2(regexreplace('/',input.Book_Dt,''));
self.vendor				:= 'D8';//NEED TO UPDATE
self.state_origin		:= 'CO';
self.data_type			:= '5';
self.source_file		:= '(CV)CO-PitkinCtyArr';
self.case_number		:= '';
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= trim(input.book_dt,left,right);
self.pty_nm				:= trim(input.Name,left,right);
self.pty_nm_fmt			:= 'L';
self.orig_lname			:= '';
self.orig_fname			:= '';
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
self.dob				:= if(trim(input.dob,left,right)[1..2]>='19' and 
							(integer)stringlib.GetDateYYYYMMDD()[1..4]-(integer)trim(input.dob,left,right)[1..4] >=18,
							trim(input.dob,left,right),
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
self.sex				:= if(trim(input.Sex,left,right) in ['F','M'],
							trim(input.sex,left,right),
							'');
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

pPitkin := project(fPitkin,tPitkin(left));

ArrestLogs.ArrestLogs_clean(pPitkin,cleanPitkin);

//arrOut:= cleanPitkin + ArrestLogs.FileAbinitioOffender(vendor='');

dd_arrOut:= dedup(sort(distribute(cleanPitkin,hash(offender_key)),
										offender_key,pty_nm,pty_typ,case_filing_dt,source_file,local)
										,offender_key,pty_nm,pty_typ,local,left): 
										PERSIST('~thor_dell400::persist::Arrestlogs_CO_Pitkin_Offender');

export Map_CO_PitkinOffender := dd_arrOut;