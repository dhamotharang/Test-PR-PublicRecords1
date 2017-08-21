import crim_common, Crim, Address, lib_stringlib,ut;

input1 := CRIM.File_MD_Statewide.Circuit;
input2 := CRIM.File_MD_Statewide.District;

cmbndLayout := record
input1;
string IssuedDate;
string DocumentType;
string DistrictCode;
string LocationCode;
string TrialType;
string Statute_Description;
string AmendedDate;
string MO_PLL;
string ProbableCause;
string VictimAge;
string Fine;
string Court_costs;
string CICF;
string Amt_Suspended_Fine;
string Amt_Suspended_Court_costs;
string Amt_Suspended_CICF;
string PBJ_EndDate;
string Probation_End_Date;
string Restitution_Amount;
string JailTerm;
string SuspendedTerm;
string CreditTimeServed;
end;

cmbndLayout t1(input1 L) := transform
self := L;
self := [];
end;

precs1 := project(input1,t1(left));

cmbndLayout t2(input2 L) := transform
self := L;
self := [];
end;

precs2 := project(input2,t2(left));

cmbndFile := precs1 + precs2;

//////////////////////////////////////////////////////////////////////////////////

Crim_Common.Layout_In_Court_Offender trecs(cmbndFile l, unsigned cnt) := transform


string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

string8     getReasonableRange(string newDateIn) 
:=    map((newDateIn[1..2] between '19' and '20') and 
			(newDateIn < ut.GetDate) => newDateIn,'');

string 		heightToInches(string n) 
:= function
cleanheight := regexreplace('[^0-9]', n, '');
height_ft:=(integer)cleanheight[1..1];
height_in:=(integer)cleanheight[2..5];
return (string)intformat((height_ft*12+height_in), 3, 1);
end;		

self.process_date		:= Crim_Common.Version_Development;


self.vendor				:= '96';
self.state_origin		:= 'MD';
self.data_type			:= '2';
self.source_file		:= 'MD-STATEWIDE';
self.case_number		:= stringlib.stringtouppercase(l.id);
self.case_court 		:= stringlib.stringtouppercase(l.courtsystem);
self.case_name			:= '';
self.case_type			:= stringlib.stringtouppercase(l.casetype);
self.case_type_desc		:= stringlib.stringtouppercase(l.casetype);
self.case_filing_dt 	:= if(l.filingdate = ''
								,getReasonableRange(fSlashedMDYtoCYMD(l.IssuedDate))
								,getReasonableRange(fSlashedMDYtoCYMD(l.filingdate)));
self.pty_nm 			:= choose(cnt,stringlib.stringtouppercase(l.name),
									trim(regexreplace('AKA ',
										 regexreplace('AKA:',stringlib.stringtouppercase(l.alias),'')
											,''),left,right));
self.pty_nm_fmt			:= 'L';
self.orig_lname			:= '';
self.orig_fname			:= '';     
self.orig_mname			:= '';
self.orig_name_suffix	:= '';
self.pty_typ			:= choose(cnt,'0','2');
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
self.dob				:= getReasonableRange(l.dob);
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= stringlib.stringtouppercase(l.address); 
self.street_address_2	:= stringlib.stringtouppercase(l.city + ' ' + l.state + ' ' + l.zip); 
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race				:= '';
self.race_desc			:= stringlib.stringtouppercase(l.race);
self.sex				:= stringlib.stringtouppercase(l.sex);
self.hair_color			:= '';
self.hair_color_desc	:= '';
self.eye_color			:= '';
self.eye_color_desc		:= '';
self.skin_color			:= '';
self.skin_color_desc	:= '';
self.height				:= if(heightToInches(l.height)<>'000' and regexfind('[0-9+]',heightToInches(l.height),0)<>'',
							heightToInches(l.height),
							'');
self.weight				:= l.weight;
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

self.offender_key       := self.vendor + stringlib.stringtouppercase(self.case_number);

end;

refOffender := normalize(cmbndFile, 2, trecs(left, counter));

outfile := refoffender(regexfind('[A-Z]',pty_nm));


Crim.Crim_clean(outfile,cleanOffender);

dedOffender := dedup(sort(distribute(cleanOffender,hash(offender_key)),
										offender_key,pty_nm,pty_typ,street_address_1,case_filing_dt,dob,local),
										offender_key,pty_nm,pty_typ,right,local) 
										:PERSIST('~thor_dell400::persist::Crim_MD_Statewide_Offender_Clean')
										;


export map_MD_Offender := dedOffender;