
export Map_base_Iyetek(string filedate) := function

import FLAccidents, Address, ut, did_add, header_slimsort, driversv2, AID,lib_StringLib;

d :=distribute(FLAccidents_Ecrash.Infiles_Iyetek.cmbnd,hash(state_report_number));
dvina	:= FLAccidents.File_VINA;

////////////////////////////////////////////////////////////////////////////
//Clean names and addresses then append vina info
///////////////////////////////////////////////////////////////////////////
//Prep address fields for clean address macro to accept
temp_layout := record
d;
string temp_addr1 := '';
string temp_addr2 := '';
unsigned8 rawaid := 0;
end;

temp_layout trecs(d L) := transform
self.temp_addr1 := lib_StringLib.StringLib.StringCleanSpaces(trim(L.Address,left,right));
self.temp_addr2 := lib_StringLib.StringLib.StringCleanSpaces(L.CITY+ if(L.CITY <> '',', ',' ')+L.STATE+' '+L.zip[1..5]);
self := L;
end;
precs := project(d,trecs(left));

PrecsBlankAddr := precs(temp_addr1='' and temp_addr2 =''); 
PrecsNBlankAddr := precs(~(temp_addr1='' and temp_addr2 ='')); 

//Clean address
unsigned4 lAIDAppendFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;

AID.MacAppendFromRaw_2Line(PrecsNBlankAddr,temp_addr1,temp_addr2, rawaid,appndAddr,lAIDAppendFlags);

cleanAddr := appndAddr +project(PrecsBlankAddr, transform({appndAddr}, self := left, self:=[]));	

// Add name_type 

Address.Mac_Is_Business_Parsed(	cleanAddr,fPreclean,FIRST_NAME,MIDDLE_NAME,LAST_NAME,'',,name_type);

//Parse appended 182 byte clean address field and standardize data values
FLAccidents_Ecrash.Layout_metadata.base trecs2(fPreclean L, dvina R) := transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.date_vendor_first_reported := if(trim(L.Sent_to_HPCC_DateTime,left,right)[1..10] !='0000-00-00'
																				,stringlib.stringfilterout(trim(L.Sent_to_HPCC_DateTime,left,right)[1..10],'-')
																				,'');
self.date_vendor_last_reported  := if(trim(L.Sent_to_HPCC_DateTime,left,right)[1..10] !='0000-00-00'
																				,stringlib.stringfilterout(trim(L.Sent_to_HPCC_DateTime,left,right)[1..10],'-')
																				,'');
self.crash_date							    := if(trim(L.crash_date,left,right) !='0000-00-00'
																	,stringlib.stringfilterout(trim(L.crash_date,left,right),'-')
																				,'');
self.dt_first_seen					    := self.crash_date;
self.dt_last_seen						    := self.crash_date;
self.creation_date					    := if(trim(L.creation_date,left,right)[1..10] !='0000-00-00'
																	,stringlib.stringfilterout(trim(L.creation_date,left,right)[1..10],'-')
																				,'');

self.date_of_birth					    := map(regexfind('-',L.date_of_birth) and trim(L.date_of_birth,left,right)[1..10] !='0000-00-00'
																					=> stringlib.stringfilterout(trim(L.date_of_birth,left,right),'-'),
																	     regexfind('/',L.date_of_birth)=> fSlashedMDYtoCYMD(L.date_of_birth),'');
self.officer_report_date		    := if(trim(L.officer_report_date,left,right)[1..10] !='0000-00-00'
																	,stringlib.stringfilterout(trim(L.officer_report_date,left,right)[1..10],'-')
																				,'');																				
set_ptype := ['P1','P2','P3','P4','P5','P6','P7','P8','P9'];
self.person_type 						:= if(L.person_type in set_ptype,'PASSENGER', L.person_type);
self.report_code						:= 'TM';
self.report_category				:= CASE(L.report_type_id
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

self.report_code_desc				:= CASE(L.report_type_id
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
									
									
	self.rawaid		 				:= L.AIDWork_RawAID;
	self.prim_range 				:= L.AIDWork_ACECache.prim_range;
	self.predir 					:= L.AIDWork_ACECache.predir;
	self.prim_name 					:= L.AIDWork_ACECache.prim_name;
	self.addr_suffix 				:= L.AIDWork_ACECache.addr_suffix;
	self.postdir 					:= L.AIDWork_ACECache.postdir;
	self.unit_desig 				:= L.AIDWork_ACECache.unit_desig;
	self.sec_range 					:= L.AIDWork_ACECache.sec_range;
	self.p_city_name 				:= L.AIDWork_ACECache.p_city_name;
	self.v_city_name 				:= L.AIDWork_ACECache.v_city_name;
	self.st 						:= if(L.AIDWork_ACECache.st = '',ziplib.ZipToState2(L.AIDWork_ACECache.zip5),L.AIDWork_ACECache.st);
	self.z5 						:= L.AIDWork_ACECache.zip5;
	self.z4 						:= L.AIDWork_ACECache.zip4;
	self.cart 						:= L.AIDWork_ACECache.cart;
	self.cr_sort_sz 				:= L.AIDWork_ACECache.cr_sort_sz;
	self.lot 						:= L.AIDWork_ACECache.lot;
	self.lot_order 					:= L.AIDWork_ACECache.lot_order;
	self.dpbc						:= L.AIDWork_ACECache.dbpc;
	self.chk_digit 					:= L.AIDWork_ACECache.chk_digit;
	self.rec_type 					:= L.AIDWork_ACECache.rec_type;
	self.county_code        := L.AIDWork_ACECache.county;
	self.geo_lat 					:= L.AIDWork_ACECache.geo_lat;
	self.geo_long 					:= L.AIDWork_ACECache.geo_long;
	self.msa 						:= L.AIDWork_ACECache.msa;
	self.geo_blk 					:= L.AIDWork_ACECache.geo_blk;
	self.geo_match 					:= L.AIDWork_ACECache.geo_match;
	self.err_stat 					:= L.AIDWork_ACECache.err_stat;
	
//Parse 73 byte clean name field
//CleanName							:= if (l.name_type <> 'B', Address.CleanPersonFML73(regexreplace(' +',L.FIRST_NAME+' '+L.MIDDLE_NAME+' '+L.LAST_NAME,' ')),'');
CleanName							:= Address.CleanPersonFML73(regexreplace(' +',L.FIRST_NAME+' '+L.MIDDLE_NAME+' '+L.LAST_NAME,' '));

self.nameType							:= l.name_type;										
self.title							:= CleanName[1..5];
self.fname							:= if(CleanName[6..25]='UNKNOWN','',CleanName[6..25]);
self.mname							:= if(CleanName[26..45]='UNKNOWN','',CleanName[26..45]);
self.lname							:= if(CleanName[46..65]='UNKNOWN','',CleanName[46..65]);
self.suffix 					  := CleanName[66..70];
self.name_score						:= CleanName[71..73];
self.cname             := if (l.name_type = 'B',L.FIRST_NAME+' '+L.MIDDLE_NAME+' '+L.LAST_NAME,'');

self.orig_fname := l.FIRST_NAME;
self.orig_lname :=l.last_name;
self.orig_mname :=l.middle_name;
 
// populated by Vina File
self.vehicle_seg					:= map(L.vin = R.vin_input => R.variable_segment,'');	
self.vehicle_seg_type				:= map(L.vin = R.vin_input => R.veh_type,'');	
self.model_year						:= map(L.vin = R.vin_input => R.model_year,'');	
self.body_style_code				:= map(L.vin = R.vin_input => R.vina_body_style,'');	
self.engine_size					:= map(L.vin = R.vin_input => R.engine_size,'');	
self.fuel_code						:= map(L.vin = R.vin_input => R.fuel_code,'');	
self.number_of_driving_wheels		:= map(L.vin = R.vin_input => R.vp_tilt_wheel,'');	
self.steering_type					:= map(L.vin = R.vin_input => R.vp_power_steering,'');		
self.vina_series					:= map(L.vin = R.vin_input => R.vina_series,'');	
self.vina_model						:= map(L.vin = R.vin_input => R.vina_model,'');	
self.vina_make						:= map(L.vin = R.vin_input => R.make_description,'');	
self.vina_body_style				:= map(L.vin = R.vin_input => R.vina_body_style,'');		
self.make_description				:= map(L.vin = R.vin_input => R.make_description,L.make);			
self.model_description				:= map(L.vin = R.vin_input => R.model_description,L.model);		
self.series_description				:= map(L.vin = R.vin_input => R.series_description,'');	
self.car_cylinders					:= map(L.vin = R.vin_input => R.number_of_cylinders,'');	
self := L;
self := [];
end;


jrecs := join(distribute(fPreclean(vin!=''),hash(vin)),distribute(dvina,hash(vin_input)),
				left.vin = right.vin_input,
				trecs2(left,right),left outer,local);

FLAccidents_Ecrash.Layout_metadata.base trecs3(fPreclean L) := transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.date_vendor_first_reported := if(trim(L.Sent_to_HPCC_DateTime,left,right)[1..10] !='0000-00-00'
																				,stringlib.stringfilterout(trim(L.Sent_to_HPCC_DateTime,left,right)[1..10],'-')
																				,'');
self.date_vendor_last_reported  := if(trim(L.Sent_to_HPCC_DateTime,left,right)[1..10] !='0000-00-00'
																				,stringlib.stringfilterout(trim(L.Sent_to_HPCC_DateTime,left,right)[1..10],'-')
																				,'');
self.crash_date							    := if(trim(L.crash_date,left,right) !='0000-00-00'
																	,stringlib.stringfilterout(trim(L.crash_date,left,right),'-')
																				,'');
self.dt_first_seen					    := self.crash_date;
self.dt_last_seen						    := self.crash_date;
self.creation_date					    := if(trim(L.creation_date,left,right)[1..10] !='0000-00-00'
																	,stringlib.stringfilterout(trim(L.creation_date,left,right)[1..10],'-')
																				,'');

self.date_of_birth					    := map(regexfind('-',L.date_of_birth) and trim(L.date_of_birth,left,right)[1..10] !='0000-00-00'
																					=> stringlib.stringfilterout(trim(L.date_of_birth,left,right),'-'),
																	     regexfind('/',L.date_of_birth)=> fSlashedMDYtoCYMD(L.date_of_birth),'');
self.officer_report_date		    := if(trim(L.officer_report_date,left,right)[1..10] !='0000-00-00'
																	,stringlib.stringfilterout(trim(L.officer_report_date,left,right)[1..10],'-')
																				,'');																				
set_ptype := ['P1','P2','P3','P4','P5','P6','P7','P8','P9'];
self.person_type 						:= if(L.person_type in set_ptype,'PASSENGER', L.person_type);
self.report_code						:= 'TM';
self.report_category				:= CASE(L.report_type_id
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

self.report_code_desc				:= CASE(L.report_type_id
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

	self.rawaid		 				:= L.AIDWork_RawAID;
	self.prim_range 				:= L.AIDWork_ACECache.prim_range;
	self.predir 					:= L.AIDWork_ACECache.predir;
	self.prim_name 					:= L.AIDWork_ACECache.prim_name;
	self.addr_suffix 				:= L.AIDWork_ACECache.addr_suffix;
	self.postdir 					:= L.AIDWork_ACECache.postdir;
	self.unit_desig 				:= L.AIDWork_ACECache.unit_desig;
	self.sec_range 					:= L.AIDWork_ACECache.sec_range;
	self.p_city_name 				:= L.AIDWork_ACECache.p_city_name;
	self.v_city_name 				:= L.AIDWork_ACECache.v_city_name;
	self.st 						:= if(L.AIDWork_ACECache.st = '',ziplib.ZipToState2(L.AIDWork_ACECache.zip5),L.AIDWork_ACECache.st);
	self.z5 						:= L.AIDWork_ACECache.zip5;
	self.z4 						:= L.AIDWork_ACECache.zip4;
	self.cart 						:= L.AIDWork_ACECache.cart;
	self.cr_sort_sz 				:= L.AIDWork_ACECache.cr_sort_sz;
	self.lot 						:= L.AIDWork_ACECache.lot;
	self.lot_order 					:= L.AIDWork_ACECache.lot_order;
	self.dpbc						:= L.AIDWork_ACECache.dbpc;
	self.chk_digit 					:= L.AIDWork_ACECache.chk_digit;
	self.rec_type 					:= L.AIDWork_ACECache.rec_type;
	self.county_code        := L.AIDWork_ACECache.county;
	self.geo_lat 					:= L.AIDWork_ACECache.geo_lat;
	self.geo_long 					:= L.AIDWork_ACECache.geo_long;
	self.msa 						:= L.AIDWork_ACECache.msa;
	self.geo_blk 					:= L.AIDWork_ACECache.geo_blk;
	self.geo_match 					:= L.AIDWork_ACECache.geo_match;
	self.err_stat 					:= L.AIDWork_ACECache.err_stat;
									
//Parse 73 byte clean name field
//CleanName							:= if(l.name_type <>'B', Address.CleanPersonFML73(regexreplace(' +',L.FIRST_NAME+' '+L.MIDDLE_NAME+' '+L.LAST_NAME,' ')),'');
CleanName							:=  Address.CleanPersonFML73(regexreplace(' +',L.FIRST_NAME+' '+L.MIDDLE_NAME+' '+L.LAST_NAME,' '));
self.nameType							:= l.name_type;											
self.title							:= CleanName[1..5];
self.fname							:= if(CleanName[6..25]='UNKNOWN','',CleanName[6..25]);
self.mname							:= if(CleanName[26..45]='UNKNOWN','',CleanName[26..45]);
self.lname							:= if(CleanName[46..65]='UNKNOWN','',CleanName[46..65]);
self.suffix 					  := CleanName[66..70];
self.name_score						:= CleanName[71..73];
self.cname                := if(l.name_type ='B', L.FIRST_NAME+' '+L.MIDDLE_NAME+' '+L.LAST_NAME,''); 
self.orig_fname := l.FIRST_NAME;
self.orig_lname :=l.last_name;
self.orig_mname :=l.middle_name;
self:= l;
self := []; 
end; 
precs2 := project(fPreclean(vin=''),trecs3(left));

cmbndRecs := jrecs+precs2:persist('~thor_data400::persist::iyetek_metadata_clean')	;	

ut.mac_flipnames(cmbndRecs,fname,mname,lname,PreDIDFile);
/////////////////////////////////////////////////////////////////////////////
//append DID 
did_matchset := ['A','D','Z','G'];
did_add.MAC_Match_Flex(PreDIDFile,did_matchset,
                       '',date_of_birth,fname,mname,lname,suffix,
				   prim_range,prim_name,sec_range,z5,st,nophone,
				   did,PreDIDFile,true,did_score,75,did_recs);
/////////////////////////////////////////////////////////////////////////////
// Return to original layout 
cmbndRecs tr(did_recs L) := transform
self := L;
end;

p_recs := project(did_recs,tr(left));

////////////////////////////////////////////////////////////////////////////////////////////////////
//Append DID using lfname and dl match --bug # 48839
////////////////////////////////////////////////////////////////////////////////////////////////////
eAcc_noDID:= p_recs(did=0 and Drivers_License_Number != '');
eAcc_allothers:= p_recs(did!=0 or Drivers_License_Number = '');
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

tbl_dls := table(dlf,slim_dl,lname,fname,mname,dl_number,orig_state,did,few): persist('~thor_200::persist::tbl_dl');

eAcc_noDID getDID(eAcc_noDID L, tbl_dls R) :=transform
self.did := map(L.Drivers_License_Number = R.dl_number 
    and ut.NNEQ(L.Driver_License_jurisdiction,R.orig_state) 
    and (regexfind(
      regexreplace(' +',r.lname,' ')
        ,regexreplace(' +',l.fname+' '+l.mname+' '+l.lname,' ')) or 
         regexfind(
      trim(r.lname,all)
           ,regexreplace(' +',l.fname+' '+l.mname+' '+l.lname,' ')))
    => R.did,L.did);
    
self := L;
    
end;
    
appndDID := join(eAcc_noDID,dedup(tbl_dls,dl_number,lname,all),
    left.Drivers_License_Number = right.dl_number and
       ut.NNEQ(left.Driver_License_jurisdiction,right.orig_state) and
			 
    (regexfind(
      regexreplace(' +',right.lname,' ')
        ,regexreplace(' +',left.fname+' '+left.mname+' '+left.lname,' ')) or 
         regexfind(
      trim(right.lname,all)
           ,regexreplace(' +',left.fname+' '+left.mname+' '+left.lname,' '))),
    getDID(left,right),left outer,hash);

appndDID getDID2(appndDID L, tbl_dls R) :=transform

self.did := map(L.did = 0 
    and L.Drivers_License_Number = R.dl_number 
    and ut.NNEQ(L.Driver_License_jurisdiction,R.orig_state)
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
    left.Drivers_License_Number = right.dl_number and
       ut.NNEQ(left.Driver_License_jurisdiction,right.orig_state) and
    ut.NNEQ((string)left.mname[1],(string)right.mname[1])
    and (regexfind(
      regexreplace(' +',right.fname,' ')
        ,regexreplace(' +',left.fname+' '+left.mname+' '+left.lname,' ')) or 
         regexfind(
      trim(right.fname,all)
           ,regexreplace(' +',left.fname+' '+left.mname+' '+left.lname,' '))),
    getDID2(left,right),left outer,hash);

eAcc_all := appndDID2 + eAcc_allothers :  persist('~thor_data400::persist::iyetek_metadata_did');				

sfShuffle := sequential(
	fileservices.addsuperfile('~thor_data400::base::iyetek_metadata_delete','~thor_data400::base::iyetek_metadata_grandfather',0,true),
		fileservices.clearsuperfile('~thor_data400::base::iyetek_metadata_grandfather'),
	fileservices.deletesuperfile('~thor_data400::base::iyetek_metadata_delete',true),
	fileservices.startsuperfiletransaction(),
	fileservices.createsuperfile('~thor_data400::base::iyetek_metadata_delete'),
	fileservices.addsuperfile('~thor_data400::base::iyetek_metadata_grandfather','~thor_data400::base::iyetek_metadata_father',0,true),
	fileservices.clearsuperfile('~thor_data400::base::iyetek_metadata_father'),
	fileservices.addsuperfile('~thor_data400::base::iyetek_metadata_father','~thor_data400::base::iyetek_metadata',0,true),
	fileservices.clearsuperfile('~thor_data400::base::iyetek_metadata'),
	fileservices.addsuperfile('~thor_data400::base::iyetek_metadata','~thor_data400::base::iyetek_metadata_'+filedate),
	fileservices.finishsuperfiletransaction()
	);
	
return 
			sequential(
					output(dedup(eAcc_all,record,all),,'~thor_data400::base::iyetek_metadata_'+filedate,overwrite,__compressed__)
					,sfShuffle

);

end;

