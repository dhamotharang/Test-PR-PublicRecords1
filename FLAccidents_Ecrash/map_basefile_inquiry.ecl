import Address,ut,did_add,business_header_ss,header_slimsort,VehLic,didville,driversv2,idl_header,flaccidents;

export map_basefile_inquiry(string filedate) := function

d 		:= FLAccidents.InFile_NtlAccidents_Alpharetta.cmbnd_inq(first_name_1+middle_name_1+last_name_1+vin !='');

vina	:= VehLic.File_VINA;
dvina := distribute(vina,hash(vin_input));
uvina := dedup(sort(dvina, vin_input, -((unsigned) model_year), local), vin_input, local):persist('~thor_data400::persist::natAcc_inq_vina');

////////////////////////////////////////////////////////////////////////////
//Clean names and addresses then append vina info
///////////////////////////////////////////////////////////////////////////
//Prep address fields for clean address macro to accept
temp_layout := record
d;
string temp_addr1 := '';
string temp_addr2 := '';
end;

temp_layout trecs(d L) := transform
self.temp_addr1 := L.HOUSE_NBR+' '+L.STREET+' '+L.APT_NBR;
self.temp_addr2 := if(L.CITY+' '+L.STATE+' '+L.ZIP5 != '', L.CITY+' '+L.STATE+' '+L.ZIP5, L.inc_CITY+' '+L.STATE_ABBR);
self := L;
end;

precs := project(d,trecs(left));

PrecsBlankAddr := precs(temp_addr1='' and temp_addr2 =''); 
PrecsNBlankAddr := precs(~(temp_addr1='' and temp_addr2 ='')); 

//Clean address
Address.MAC_Address_Clean(PrecsNBlankAddr,temp_addr1,temp_addr2,true,appndAddr);	
cleanAddr := appndAddr +project(PrecsBlankAddr, transform({appndAddr}, self.clean :='', self := left));	

//Parse appended 182 byte clean address field
FLAccidents_Ecrash.Layout_CRU_inquiries trecs2(cleanAddr L, uvina R) := transform

string8     fSlashedMDYtoCYMD(string pDateIn) :=
intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.dt_first_seen					:= fSlashedMDYtoCYMD(L.loss_date[1..10]);
self.dt_last_seen					:= if(L.Last_Changed<>'',L.Last_Changed,self.dt_first_seen);
self.dob_1                := fSlashedMDYtoCYMD(trim(l.dob_1,left,right)[1..10]); 
self.report_code					:= L.service_id;
self.report_category				:= CASE(L.service_id
									,'A'=>'Auto Report'
									,'B'=>'Auto Report'
									,'C'=>'Auto Report'
									,'D'=>'Other Report'
									,'E'=>'Other Report'
									,'F'=>'Other Report'
									,'G'=>'Other Report'
									,'H'=>'Auto Report'
									,'I'=>'Other Report'
									,'J'=>'Auto Report'
									,'K'=>'Other Report'
									,'L'=>'Other Report'
									,'M'=>'Other Report'
									,'N'=>'Other Report'
									,'O'=>'Other Report'
									,'P'=>'Auto Report'
									,'Q'=>'Auto Report'
									,'R'=>'Auto Report'
									,'S'=>'Certificates'
									,'T'=>'Certificates'
									,'U'=>'Other Report'
									,'V'=>'Other Report'
									,'W'=>'Other Report'
									,'X'=>'Auto Report'
									,'Y'=>'Other Report'
									,'Z'=>'Other Report'
									,'FS'=>'Auto Report'
									,'0'=>'Interactive Report'
									,'1'=>'Interactive Report'
									,'2'=>'Interactive Report'
									,'3'=>'Interactive Report'
									,'4'=>'Interactive Report'
									,'5'=>'Interactive Report'
									,'6'=>'Interactive Report'
									,'7'=>'Interactive Report'
									,'8'=>'Interactive Report','');

self.report_code_desc				:= CASE(L.service_id
									,'A'=>'Auto Accident'
									,'B'=>'Auto Theft'
									,'C'=>'Auto Theft Recovery'
									,'D'=>'Theft Burglary'
									,'E'=>'Fire Building'
									,'F'=>'Fire Car'
									,'G'=>'Vandalism'
									,'H'=>'D.U.I. Report'
									,'I'=>'MVR'
									,'J'=>'Registered Vehicle Owner'
									,'K'=>'Autopsy/Coroner'
									,'L'=>'Homicide Report'
									,'M'=>'Photos'
									,'N'=>'Issue Letter Interest'
									,'O'=>'Other'
									,'P'=>'Insurance Verification'
									,'Q'=>'Title History'
									,'R'=>'All Registered Vehicles at Household'
									,'S'=>'Death Certificate'
									,'T'=>'Birth Certificate'
									,'U'=>'Arrest Report'
									,'V'=>'Citation/Conviction Report'
									,'W'=>'EMS Report'
									,'X'=>'Reconstruction Report'
									,'Y'=>'Supplemental Report'
									,'Z'=>'Toxicology Report'
									,'FS'=>'Face Sheet/Log Sheet'
									,'0'=>'All Registered Vehicles At Household By Last Name And Address'
									,'1'=>'VIN'
									,'2'=>'VIN With Reported Damage - Vehicle Claim History'
									,'3'=>'Plate / Tag'
									,'4'=>'Vehicles By Name, Address, Year, Make And Model'
									,'5'=>'AutoCheck&reg - VIN History Report'
									,'6'=>'Claims MVR (Driving History)'
									,'7'=>'Carrier Discovery'
									,'8'=>'Claims Discovery','');
/* Input address is the address where the loss occurred and should not be assumed to be the address of any of the involved parties.  
Most values are cross streets. EX: 'Yamato and Congress' or 'Winn Dixie P Lot'
self.prim_range 					:= L.clean[1..10]; 
self.predir 							:= L.clean[11..12];					   
self.prim_name 						:= L.clean[13..40];
self.suffix 							:= L.clean[41..44];
self.postdir 							:= L.clean[45..46];
self.unit_desig 					:= L.clean[47..56];
self.sec_range 						:= L.clean[57..64];
*/
self.p_city_name 					:= L.clean[65..89];
self.v_city_name 					:= L.clean[90..114];
self.st 									:= if(L.clean[115..116]='',ziplib.ZipToState2(L.clean[117..121]),
																L.clean[115..116]);

self.z5 									:= '';//the only zip info provided is contained in the order version table and must be labeled as inquiry data 
self.z4 									:= '';//the only zip info provided is contained in the order version table and must be labeled as inquiry data 
self.cart 								:= L.clean[126..129];
self.cr_sort_sz 					:= L.clean[130];
self.lot 									:= L.clean[131..134];
self.lot_order 						:= L.clean[135];
self.dpbc 								:= L.clean[136..137];
self.chk_digit 						:= L.clean[138];
self.rec_type 						:= L.clean[139..140];
self.county_code					:= L.clean[141..145];
self.geo_lat 							:= L.clean[146..155];
self.geo_long 						:= L.clean[156..166];
self.msa 									:= L.clean[167..170];
self.geo_blk 							:= L.clean[171..177];
self.geo_match 						:= L.clean[178];
self.err_stat 						:= L.clean[179..182];

//Clean the names of all involved parties -- (party file is already normalized) -- get middle names from order file
CleanName1									:= Address.CleanPersonFML73(stringlib.stringcleanspaces(L.FIRST_NAME_1+' '+L.MIDDLE_NAME_1+' '+L.LAST_NAME_1));
CleanName2									:= Address.CleanPersonFML73(stringlib.stringcleanspaces(L.FIRST_NAME_2+' '+L.MIDDLE_NAME_2+' '+L.LAST_NAME_2));
CleanName3									:= Address.CleanPersonFML73(stringlib.stringcleanspaces(L.FIRST_NAME_3+' '+L.MIDDLE_NAME_3+' '+L.LAST_NAME_3));

self.orig_fname :=L.FIRST_NAME_1;
self.orig_lname :=L.LAST_NAME_1;
self.orig_mname :=L.MIDDLE_NAME_1; 
self.orig_fname2 :=L.FIRST_NAME_2;
self.orig_lname2 :=L.LAST_NAME_2;
self.orig_mname2 :=L.MIDDLE_NAME_2;
self.orig_fname3 :=L.FIRST_NAME_3;
self.orig_lname3 :=L.LAST_NAME_3;
self.orig_mname3 :=L.MIDDLE_NAME_3;
//Parse 73 byte clean name field
self.title							 	:= CleanName1[1..5];
self.fname								:= if(CleanName1[6..25]='UNKNOWN','',CleanName1[6..25]);
self.mname								:= if(CleanName1[26..45]='UNKNOWN','',CleanName1[26..45]); 
self.lname								:= if(CleanName1[46..65]='UNKNOWN','',CleanName1[46..65]);
self.name_suffix 					:= CleanName1[66..70];
self.name_score						:= CleanName1[71..73];
//Parse 73 byte clean name field
self.title2							 	:= CleanName2[1..5];
self.fname2								:= if(CleanName2[6..25]='UNKNOWN','',CleanName2[6..25]);
self.mname2								:= if(CleanName2[26..45]='UNKNOWN','',CleanName2[26..45]); 
self.lname2								:= if(CleanName2[46..65]='UNKNOWN','',CleanName2[46..65]);
self.name_suffix2				:= CleanName2[66..70];
self.name_score2					:= CleanName2[71..73];
//Parse 73 byte clean name field
self.title3							 	:= CleanName3[1..5];
self.fname3								:= if(CleanName3[6..25]='UNKNOWN','',CleanName3[6..25]);
self.mname3								:= if(CleanName3[26..45]='UNKNOWN','',CleanName3[26..45]); 
self.lname3								:= if(CleanName3[46..65]='UNKNOWN','',CleanName3[46..65]);
self.name_suffix3 				:= CleanName3[66..70];
self.name_score3					:= CleanName3[71..73];

// populated by Vina File
self.vehicle_seg					:= map(L.vin = R.vin_input => R.variable_segment,'');	
self.vehicle_seg_type			:= map(L.vin = R.vin_input => R.veh_type,'');	
self.model_year						:= map(L.vin = R.vin_input => R.model_year,'');	
self.body_style_code			:= map(L.vin = R.vin_input => R.vina_body_style,'');	
self.engine_size					:= map(L.vin = R.vin_input => R.engine_size,'');	
self.fuel_code						:= map(L.vin = R.vin_input => R.fuel_code,'');	
self.number_of_driving_wheels		:= map(L.vin = R.vin_input => R.vp_tilt_wheel,'');	
self.steering_type				:= map(L.vin = R.vin_input => R.vp_power_steering,'');		
self.vina_series					:= map(L.vin = R.vin_input => R.vina_series,'');	
self.vina_model						:= map(L.vin = R.vin_input => R.vina_model,'');	
self.vina_make						:= map(L.vin = R.vin_input => R.make_description,'');	
self.vina_body_style			:= map(L.vin = R.vin_input => R.vina_body_style,'');		
self.make_description			:= map(L.vin = R.vin_input => R.make_description,L.vehmake);			
self.model_description		:= map(L.vin = R.vin_input => R.model_description,L.vehmodel);		
self.series_description		:= map(L.vin = R.vin_input => R.series_description,'');	
self.car_cylinders				:= map(L.vin = R.vin_input => R.number_of_cylinders,'');
self.vehicle_status				:= if(R.vin_input !='','V','');	
self.vehicle_incident_id	:= if(L.vehicle_incident_id !='',L.vehicle_incident_id ,'OID'+L.order_id);
self := L;
end;


jrecs := join(distribute(cleanAddr(vin!=''),hash(vin)), uvina,
				left.vin = right.vin_input,
				trecs2(left,right),left outer,local);

////////////////////////////////////////////////////////////////////////////
//Clean names and addresses of records without a vin (flows have been split 
//for faster processing time.  Vin is populated 60+% 
///////////////////////////////////////////////////////////////////////////
FLAccidents_Ecrash.Layout_CRU_inquiries trecs3(cleanAddr L) := transform

string8     fSlashedMDYtoCYMD(string pDateIn) :=
intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.dt_first_seen					:= fSlashedMDYtoCYMD(L.loss_date[1..10]);
self.dt_last_seen					:= map(L.Last_Changed = '00000000' or L.Last_Changed ='' =>self.dt_first_seen,L.Last_Changed);
self.dob_1                := fSlashedMDYtoCYMD(trim(l.dob_1,left,right)[1..10]); 
self.report_code					:= L.service_id;
self.report_category				:= CASE(L.service_id
									,'A'=>'Auto Report'
									,'B'=>'Auto Report'
									,'C'=>'Auto Report'
									,'D'=>'Other Report'
									,'E'=>'Other Report'
									,'F'=>'Other Report'
									,'G'=>'Other Report'
									,'H'=>'Auto Report'
									,'I'=>'Other Report'
									,'J'=>'Auto Report'
									,'K'=>'Other Report'
									,'L'=>'Other Report'
									,'M'=>'Other Report'
									,'N'=>'Other Report'
									,'O'=>'Other Report'
									,'P'=>'Auto Report'
									,'Q'=>'Auto Report'
									,'R'=>'Auto Report'
									,'S'=>'Certificates'
									,'T'=>'Certificates'
									,'U'=>'Other Report'
									,'V'=>'Other Report'
									,'W'=>'Other Report'
									,'X'=>'Auto Report'
									,'Y'=>'Other Report'
									,'Z'=>'Other Report'
									,'FS'=>'Auto Report'
									,'0'=>'Interactive Report'
									,'1'=>'Interactive Report'
									,'2'=>'Interactive Report'
									,'3'=>'Interactive Report'
									,'4'=>'Interactive Report'
									,'5'=>'Interactive Report'
									,'6'=>'Interactive Report'
									,'7'=>'Interactive Report'
									,'8'=>'Interactive Report','');

self.report_code_desc				:= CASE(L.service_id
									,'A'=>'Auto Accident'
									,'B'=>'Auto Theft'
									,'C'=>'Auto Theft Recovery'
									,'D'=>'Theft Burglary'
									,'E'=>'Fire Building'
									,'F'=>'Fire Car'
									,'G'=>'Vandalism'
									,'H'=>'D.U.I. Report'
									,'I'=>'MVR'
									,'J'=>'Registered Vehicle Owner'
									,'K'=>'Autopsy/Coroner'
									,'L'=>'Homicide Report'
									,'M'=>'Photos'
									,'N'=>'Issue Letter Interest'
									,'O'=>'Other'
									,'P'=>'Insurance Verification'
									,'Q'=>'Title History'
									,'R'=>'All Registered Vehicles at Household'
									,'S'=>'Death Certificate'
									,'T'=>'Birth Certificate'
									,'U'=>'Arrest Report'
									,'V'=>'Citation/Conviction Report'
									,'W'=>'EMS Report'
									,'X'=>'Reconstruction Report'
									,'Y'=>'Supplemental Report'
									,'Z'=>'Toxicology Report'
									,'FS'=>'Face Sheet/Log Sheet'
									,'0'=>'All Registered Vehicles At Household By Last Name And Address'
									,'1'=>'VIN'
									,'2'=>'VIN With Reported Damage - Vehicle Claim History'
									,'3'=>'Plate / Tag'
									,'4'=>'Vehicles By Name, Address, Year, Make And Model'
									,'5'=>'AutoCheck&reg - VIN History Report'
									,'6'=>'Claims MVR (Driving History)'
									,'7'=>'Carrier Discovery'
									,'8'=>'Claims Discovery','');
/* Input address is the address where the loss occurred and should not be assumed to be the address of any of the involved parties.  
Most values are cross streets. EX: 'Yamato and Congress' or 'Winn Dixie P Lot'
self.prim_range 					:= L.clean[1..10]; 
self.predir 							:= L.clean[11..12];					   
self.prim_name 						:= L.clean[13..40];
self.suffix 							:= L.clean[41..44];
self.postdir 							:= L.clean[45..46];
self.unit_desig 					:= L.clean[47..56];
self.sec_range 						:= L.clean[57..64];
*/
self.p_city_name 					:= L.clean[65..89];
self.v_city_name 					:= L.clean[90..114];
self.st 									:= if(L.clean[115..116]='',ziplib.ZipToState2(L.clean[117..121]),
																L.clean[115..116]);

self.z5 									:= '';//the only zip info provided is contained in the order version table and must be labeled as inquiry data 
self.z4 									:= '';//the only zip info provided is contained in the order version table and must be labeled as inquiry data 
self.cart 								:= L.clean[126..129];
self.cr_sort_sz 					:= L.clean[130];
self.lot 									:= L.clean[131..134];
self.lot_order 						:= L.clean[135];
self.dpbc 								:= L.clean[136..137];
self.chk_digit 						:= L.clean[138];
self.rec_type 						:= L.clean[139..140];
self.county_code					:= L.clean[141..145];
self.geo_lat 							:= L.clean[146..155];
self.geo_long 						:= L.clean[156..166];
self.msa 									:= L.clean[167..170];
self.geo_blk 							:= L.clean[171..177];
self.geo_match 						:= L.clean[178];
self.err_stat 						:= L.clean[179..182];

//Clean the names of all involved parties -- (party file is already normalized) -- get middle names from order file
CleanName1									:= Address.CleanPersonFML73(stringlib.stringcleanspaces(L.FIRST_NAME_1+' '+L.MIDDLE_NAME_1+' '+L.LAST_NAME_1));
CleanName2									:= Address.CleanPersonFML73(stringlib.stringcleanspaces(L.FIRST_NAME_2+' '+L.MIDDLE_NAME_2+' '+L.LAST_NAME_2));
CleanName3									:= Address.CleanPersonFML73(stringlib.stringcleanspaces(L.FIRST_NAME_3+' '+L.MIDDLE_NAME_3+' '+L.LAST_NAME_3));

self.orig_fname :=L.FIRST_NAME_1;
self.orig_lname :=L.LAST_NAME_1;
self.orig_mname :=L.MIDDLE_NAME_1; 
self.orig_fname2 :=L.FIRST_NAME_2;
self.orig_lname2 :=L.LAST_NAME_2;
self.orig_mname2 :=L.MIDDLE_NAME_2;
self.orig_fname3 :=L.FIRST_NAME_3;
self.orig_lname3 :=L.LAST_NAME_3;
self.orig_mname3 :=L.MIDDLE_NAME_3;
//Parse 73 byte clean name field
self.title							 	:= CleanName1[1..5];
self.fname								:= if(CleanName1[6..25]='UNKNOWN','',CleanName1[6..25]);
self.mname								:= if(CleanName1[26..45]='UNKNOWN','',CleanName1[26..45]); 
self.lname								:= if(CleanName1[46..65]='UNKNOWN','',CleanName1[46..65]);
self.name_suffix 					:= CleanName1[66..70];
self.name_score						:= CleanName1[71..73];
//Parse 73 byte clean name field
self.title2							 	:= CleanName2[1..5];
self.fname2								:= if(CleanName2[6..25]='UNKNOWN','',CleanName2[6..25]);
self.mname2								:= if(CleanName2[26..45]='UNKNOWN','',CleanName2[26..45]); 
self.lname2								:= if(CleanName2[46..65]='UNKNOWN','',CleanName2[46..65]);
self.name_suffix2				:= CleanName2[66..70];
self.name_score2					:= CleanName2[71..73];
//Parse 73 byte clean name field
self.title3							 	:= CleanName3[1..5];
self.fname3								:= if(CleanName3[6..25]='UNKNOWN','',CleanName3[6..25]);
self.mname3								:= if(CleanName3[26..45]='UNKNOWN','',CleanName3[26..45]); 
self.lname3								:= if(CleanName3[46..65]='UNKNOWN','',CleanName3[46..65]);
self.name_suffix3 				:= CleanName3[66..70];
self.name_score3					:= CleanName3[71..73];
self.vehicle_status				:= '';
self.vehicle_incident_id	:= if(L.vehicle_incident_id !='',L.vehicle_incident_id ,'OID'+L.order_id);	
self 											:= L;
self 											:= [];

end;


precs2 := project(cleanAddr(vin=''),trecs3(left));
				
cmbndRecs := jrecs+precs2:persist('~thor_data400::persist::natAcc_inq_clean');
/////////////////////////////////////////////////////////////////////////////
//Pad ssn_1 before passing through the ADL macro
temp_ssn_1_layout := record 
string temp_ssn_1 := '';
cmbndRecs;
end;

temp_ssn_1_layout padssn_1(cmbndRecs L) := transform
self.temp_ssn_1 := map(  length(L.ssn_1) = 7 => '00'+L.ssn_1
					  ,length(L.ssn_1) = 8 => '0' +L.ssn_1
					  ,L.ssn_1);
self := L;
end;

p_ssn_1 := project(cmbndRecs,padssn_1(left));

////////////////////////////////////////////////////////////////////////////////////////
// Pass records to Name Flip Macro to enhance linking
////////////////////////////////////////////////////////////////////////////////////////
ut.mac_flipnames(p_ssn_1,fname,mname,lname,did_prep);
/////////////////////////////////////////////////////////////////////////////
//append DID 
did_matchset := ['A','D','S','Z','G','4'];
did_add.MAC_Match_Flex(did_prep,did_matchset,
                       temp_ssn_1,dob_1,fname,mname,lname,name_suffix,
				   prim_range,prim_name,sec_range,zip5,st,nophone,
				   did,did_prep,true,did_score,75,did_recs);
/////////////////////////////////////////////////////////////////////////////
// Return to original layout 
cmbndRecs tr(did_recs L) := transform
self := L;
end;

p_recs := project(did_recs,tr(left));

/////////////////////////////////////////////////////////////////////////////
//population stats show business name field to be 0%				   

//append bdid
//bdid_matchset := ['A'];
//business_header_ss.MAC_match_FLEX(did_recs,bdid_matchset,business_name,
				//prim_range,prim_name,z5,sec_range,st,foo,foo,
				//bdid,did_recs,true,bdid_score,
				//bdid_recs);


////////////////////////////////////////////////////////////////////////////////////////////////////
//Append DID using lfname and dl match --bug # 48839
////////////////////////////////////////////////////////////////////////////////////////////////////
natInq_noDID:= p_recs(did=0 and DRIVERS_LICENSE != '');
natInq_allothers:= p_recs(did!=0 or DRIVERS_LICENSE = '');
//splitting streams above to reduce skewing and process run time.


dlf := driversv2.File_DL(did!=0 and regexfind('[1-9]',dl_number) and length(lname)>1 and dl_number !='1111111');

//create dl/DID table
slim_dl := record
dlf.lname;
dlf.fname;
dlf.mname;
dlf.dl_number;
dlf.orig_state;
dlf.did;
end;

tbl_dls := table(dlf,slim_dl,lname,fname,mname,dl_number,orig_state,did,few): persist('~thor_200::persist::tbl_dl_ntl');

natInq_noDID getDID(natInq_noDID L, tbl_dls R) :=transform
self.did := map(L.DRIVERS_LICENSE = R.dl_number 
    and ut.NNEQ(L.drivers_license_st,R.orig_state) 
    and (regexfind(
      regexreplace(' +',r.lname,' ')
        ,regexreplace(' +',l.fname+' '+l.mname+' '+l.lname,' ')) or 
         regexfind(
      trim(r.lname,all)
           ,regexreplace(' +',l.fname+' '+l.mname+' '+l.lname,' ')))
    => R.did,L.did);
    
self := L;
    
end;
    
appndDID := join(natInq_noDID,dedup(tbl_dls,dl_number,lname,all),
    left.DRIVERS_LICENSE = right.dl_number and
       ut.NNEQ(left.drivers_license_st,right.orig_state) and
    (regexfind(
      regexreplace(' +',right.lname,' ')
        ,regexreplace(' +',left.fname+' '+left.mname+' '+left.lname,' ')) or 
         regexfind(
      trim(right.lname,all)
           ,regexreplace(' +',left.fname+' '+left.mname+' '+left.lname,' '))),
    getDID(left,right),left outer,hash);

appndDID getDID2(appndDID L, tbl_dls R) :=transform

self.did := map(L.did = 0 
    and L.DRIVERS_LICENSE = R.dl_number 
    and ut.NNEQ(L.drivers_license_st,R.orig_state)
    and ut.NNEQ((string)L.mname[1],(string)R.mname[1])
    and (regexfind(
      regexreplace(' +',r.fname,' ')
        ,regexreplace(' +',l.fname+' '+l.mname+' '+l.lname,' ')) or 
         regexfind(
      trim(r.fname,all)
           ,regexreplace(' +',l.fname+' '+l.mname+' '+l.lname,' ')))
    => R.did,L.did);
    
self := L;
    
end;
    
appndDID2 := join(appndDID,dedup(tbl_dls,dl_number,fname,all),
    left.did = 0 and 
    left.DRIVERS_LICENSE = right.dl_number and
       ut.NNEQ(left.drivers_license_st,right.orig_state) and
    ut.NNEQ((string)left.mname[1],(string)right.mname[1])
    and (regexfind(
      regexreplace(' +',right.fname,' ')
        ,regexreplace(' +',left.fname+' '+left.mname+' '+left.lname,' ')) or 
         regexfind(
      trim(right.fname,all)
           ,regexreplace(' +',left.fname+' '+left.mname+' '+left.lname,' '))),
    getDID2(left,right),left outer,hash);


natInq_all := appndDID2 + natInq_allothers :  persist('~thor_data400::persist::ecrash_ntlinq_did');								
sfShuffle := sequential(	
   fileservices.RemoveOwnedSubFiles('~thor_data400::base::ntlcrash_inquiry_delete',true),
	fileservices.addsuperfile('~thor_data400::base::ntlcrash_inquiry_delete','~thor_data400::base::ntlcrash_inquiry_grandfather',0,true),
	fileservices.startsuperfiletransaction(),
	fileservices.clearsuperfile('~thor_data400::base::ntlcrash_inquiry_grandfather'),
	fileservices.addsuperfile('~thor_data400::base::ntlcrash_inquiry_grandfather','~thor_data400::base::ntlcrash_inquiry_father',0,true),
	fileservices.clearsuperfile('~thor_data400::base::ntlcrash_inquiry_father'),
	fileservices.addsuperfile('~thor_data400::base::ntlcrash_inquiry_father','~thor_data400::base::ntlcrash_inquiry',0,true),
	fileservices.clearsuperfile('~thor_data400::base::ntlcrash_inquiry'),
	fileservices.addsuperfile('~thor_data400::base::ntlcrash_inquiry','~thor_data400::base::alpharetta::national_accidents_inquiry_'+filedate),
	fileservices.finishsuperfiletransaction()
	);
	
return
sequential(
output(dedup(natInq_all,
record,
all),,'~thor_data400::base::alpharetta::national_accidents_inquiry_'+filedate,overwrite,__compressed__)
,sfShuffle);
end;