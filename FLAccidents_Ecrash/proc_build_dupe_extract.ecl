/*2015-07-23T17:13:43Z (Srilatha Katukuri)
#173256 - removing EA and Adding TM in notification process
*/
/*2015-02-18T00:03:55Z (Ayeesha Kayttala)
bug# 173256 code review
*/
export proc_build_dupe_extract(string filedate,string timestamp):= function

import ut;

//state_report_number is unique for TF.
incident := project(FLAccidents_Ecrash.Infiles.incident(work_type_id in ['1', 'NULL','0'] and source_id in ['TF','EA']), 
                                                        transform({FLAccidents_Ecrash.Layout_Infiles.incident_new}, 
                                                                  self.case_identifier := if(left.source_id = 'TF', left.state_report_number, left.case_identifier);
																										                                        self:= left;));
																										 
allrecs := sort(distribute(incident,hash(case_identifier))
			,case_identifier,agency_id,loss_state_abbr,report_type_id,source_id,crash_date,Sent_to_HPCC_DateTime,report_id,local)(hash_key != '"Hash_Key"');
				
keepers := dedup(allrecs
			      ,case_identifier,agency_id,loss_state_abbr,report_type_id,source_id,crash_date,right,local);

allrecs trecs(allrecs L, keepers R) := transform
self :=L;
end;

dels := dedup(join(allrecs,keepers,
								left.incident_id = right.incident_id and
								left.case_identifier = right.case_identifier and 
								left.agency_id = right.agency_id and 
								left.loss_state_abbr = right.loss_state_abbr and 
								//left.work_type_id = right.work_type_id and 
								left.report_type_id = right.report_type_id and
								left.source_id = right.source_id and 
								left.crash_date = right.crash_date ,
								trecs(left,right),left only,hash),record,all);

outrec := record 

string filedate;
string flag;
string del_incident_id;
string add_incident_id;
end;

header_row := dataset(
[
{'filedate','flag','del_incident_id','add_incident_id'}
],outrec);

outrec trecs1(dels L, keepers R) := transform
self.filedate := filedate;

self.flag := if(L.corrected_incident = '1','U','D');	
self.del_incident_id  := L.incident_id;
self.add_incident_id	:= R.incident_id;
end;

alldupes := sort(join(dels,keepers,
								left.case_identifier = right.case_identifier and 
								left.agency_id = right.agency_id and 
								left.loss_state_abbr = right.loss_state_abbr and 
								//left.work_type_id = right.work_type_id and 
								left.report_type_id = right.report_type_id and 
								left.source_id = right.source_id and 
								left.crash_date = right.crash_date ,
								trecs1(left,right),left outer,hash),record);							


//Remove dupes already reported
dupehistory := dataset(ut.foreign_prod+'thor_data400::out::ecrash::dupes',outrec,csv(terminator('\n'), separator(',')));

alldupes trecs2(alldupes L, dupehistory R) := transform
self := L;
end;

newdupes := sort(join(distribute(alldupes,hash(del_incident_id)),
								 distribute(dupehistory,hash(del_incident_id)),
								left.del_incident_id = right.del_incident_id and
								left.add_incident_id = right.add_incident_id and 
								left.flag = right.flag,
							  trecs2(left,right),left only,local),del_incident_id,flag);

////////////////////////////////////////////////////////////////////////////////////
slim_layout := record
outrec;
string date_vendor_last_reported;
string incident_id;
string case_identifier; 
string agency_name;			
string loss_state_abbr; 
string work_type_id;   
string report_type_id;
string accident_location; 
string accident_street;
string accident_cross_street;
string fname;
string mname;
string lname;
string driver_license_nbr;
string tag_nbr;
string tag_nbr2;
string prim_range;
string prim_name;
string sec_range;
string p_city_name;
string st;
string z5;
string vin;
string vehicle_year;
string make_description;
string model_description;
string make_description2;
string model_description2;
string image_hash;
string1 changed_hashkey;
data data_lev1_key;
string1 changed_data_lev1;
//data data_lev2_key;
//string1 changed_data_lev2; //this level to be determined by customer
string1 notify_customer; //Y/N
string1 U_D; //update or duplicate flag
string2 report_code ; 
string agency_id; 
string ORI_Number; 
string11 report_id ; 
string11 super_report_id ; 
end;

base := FLAccidents_Ecrash.BaseFile;

slim_layout trecs_base(base L, newdupes R) := transform

self.case_identifier :=if(l.source_id = 'TF', l.state_report_number,l.case_identifier);
self.accident_location	:= map(L.loss_cross_street!='' and L.loss_cross_street!= 'N/A' => L.loss_street+' & '+L.loss_cross_street,L.loss_street);
self.accident_street		:= L.loss_street;
self.accident_cross_street	
												:= map(L.loss_cross_street!= 'N/A' => L.loss_cross_street,'');
self.driver_license_nbr	:= if(regexfind('[0-9]',L.drivers_license_number),L.drivers_license_number,'');
self.tag_nbr						:= L.License_Plate;
self.tag_nbr2						:= L.Other_Unit_License_Plate;

year					              := trim(L.model_yr,left,right);																																															
self.vehicle_year						:= map(length(year) = 2 and year>'50' => '19'+ year,
																	 length(year) = 2 and year<='50' => '20'+ year,year);
self.make_description				:= L.make_description;
self.model_description			:= L.model_description;
self.make_description2			:= L.other_make_description;
self.model_description2			:= L.other_model_description;
self.IMAGE_HASH					    := L.HASH_Key;
self.data_lev1_key					:= 
hashmd5(
trim(self.accident_location,all)+
trim(self.accident_street,all)+
trim(self.accident_cross_street,all)+
trim(L.fname,all)+
trim(L.mname,all)+
trim(L.lname,all)+
trim(l.crash_date,all)+
trim(self.driver_license_nbr,all)+
trim(self.tag_nbr,all)+
trim(self.tag_nbr2,all)+
trim(L.prim_range,all)+
trim(L.prim_name,all)+
trim(L.sec_range,all)+
trim(L.p_city_name,all)+
trim(L.st,all)+
trim(L.z5,all)+
trim(L.vin,all)+
trim(self.vehicle_year,all)+
trim(L.make_description,all)+
trim(L.model_description,all)+
trim(self.make_description2,all)+
trim(self.model_description2,all));

self := R;
self := L;
self := [];
end;

jrecs_base := join(base(report_code <>'TM'),sort(newdupes, - del_incident_id),
								left.incident_id = right.add_incident_id,
								trecs_base(left,right),lookup);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////								
prevbase:= dataset('~thor_data400::base::ecrash_father',FLAccidents_Ecrash.Layout_Basefile,thor);
		
									 
slim_layout trecs_prev(prevbase L, newdupes R) := transform
self.case_identifier :=if(l.source_id = 'TF', l.state_report_number,l.case_identifier);
self.accident_location	:= map(L.loss_cross_street!='' and L.loss_cross_street!= 'N/A' => L.loss_street+' & '+L.loss_cross_street,L.loss_street);
self.accident_street		:= L.loss_street;
self.accident_cross_street	
												:= map(L.loss_cross_street!= 'N/A' => L.loss_cross_street,'');
self.driver_license_nbr	:= if(regexfind('[0-9]',L.drivers_license_number),L.drivers_license_number,'');
self.tag_nbr						:= L.License_Plate;
self.tag_nbr2						:= L.Other_Unit_License_Plate;

year					              := trim(L.model_yr,left,right);																																															
self.vehicle_year						:= map(length(year) = 2 and year>'50' => '19'+ year,
																	 length(year) = 2 and year<='50' => '20'+ year,year);
self.make_description				:= L.make_description;
self.model_description			:= L.model_description;
self.make_description2			:= L.other_make_description;
self.model_description2			:= L.other_model_description;
self.IMAGE_HASH				      := L.HASH_Key;
self.data_lev1_key					:= 
hashmd5(
trim(self.accident_location,all)+
trim(self.accident_street,all)+
trim(self.accident_cross_street,all)+
trim(L.fname,all)+
trim(L.mname,all)+
trim(L.lname,all)+
trim(l.crash_date,all)+
trim(self.driver_license_nbr,all)+
trim(self.tag_nbr,all)+
trim(self.tag_nbr2,all)+
trim(L.prim_range,all)+
trim(L.prim_name,all)+
trim(L.sec_range,all)+
trim(L.p_city_name,all)+
trim(L.st,all)+
trim(L.z5,all)+
trim(L.vin,all)+
trim(self.vehicle_year,all)+
trim(L.make_description,all)+
trim(L.model_description,all)+
trim(self.make_description2,all)+
trim(self.model_description2,all));
self := R;
self := L;
self := [];
end;

jrecs_prevbase := join(prevbase(report_code <>'TM'),sort(newdupes, - del_incident_id),
								left.incident_id = right.del_incident_id,
								trecs_prev(left,right),lookup);
		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//get differences

jrecs_base trecs3(jrecs_base L, jrecs_prevbase R) := transform
self.changed_hashkey := map(L.del_incident_id = R.del_incident_id and L.image_hash != R.image_hash => 'Y','');
self.changed_data_lev1:= map(L.del_incident_id = R.del_incident_id and L.data_lev1_key != R.data_lev1_key => 'Y','');
self.flag := map(self.changed_hashkey = 'Y' and self.changed_data_lev1 = 'Y' => 'U','D');

self := L;

end;
jrecs_diffs := join(jrecs_base,jrecs_prevbase,
								left.del_incident_id = right.del_incident_id and 
								left.report_code = right.report_code,
								trecs3(left,right),left outer,lookup)(flag ='U');
			
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//create alerts file

layout_corrections := record
string entity_type;
string entity_id;
string entity_id2;
string entity_id3; 
string create_date;
string extra_data; 
string super_report_id; 
end;

//Notify if TM DE matches with TF/EA report type id recieved after TM DE 

//TFDE := base (report_code ='TF' and report_type_id = 'DE'); 

TFDE := dedup(Sort(distribute(base (report_code ='TF' and report_type_id = 'DE' ), hash64(incident_id)),incident_id, crash_date,state_report_number, Agency_name, Loss_state_abbr, creation_date), incident_id, crash_date,state_report_number, Agency_name, Loss_state_abbr, creation_date, local);

//TM_TF_A := base(report_code in ['TM','TF'] and report_type_id = 'A'); 
TM_TF_A := dedup(Sort(distribute(base(report_code in ['TM','TF'] and report_type_id = 'A' ), hash64(incident_id)),incident_id, crash_date,state_report_number, Agency_name, Loss_state_abbr, creation_date), incident_id, crash_date,state_report_number, Agency_name, Loss_state_abbr, creation_date, local);



NotifyDE := join (TFDE , TM_TF_A , //left.ReportLinkID = right.ReportLinkID and 
														trim(left.state_report_number, left,right) = trim(Right.State_report_number, left,right) and
														trim(left.Agency_name, left,right) = trim(Right.Agency_name, left,right) and
														trim(left.Loss_state_Abbr, left,right) = trim(Right.Loss_state_Abbr, left,right) and
														trim(left.crash_date, left,right) = trim(Right.crash_date, left,right) and
														trim(left.incident_id, left,right) < trim(Right.incident_id, left,right) 
														,	transform(layout_corrections ,
self.entity_type  := 'DE-rpt';
self.entity_id    := Left.state_report_number; 
self.entity_id2   := Left.loss_state_abbr;
self.entity_id3   := Left.Agency_Name;
self.create_date  := Left.date_vendor_last_reported[1..4]+'-'+Left.date_vendor_last_reported[5..6]+'-'+Left.date_vendor_last_reported[7..8];
self.extra_data   := Left.hash_key; 
self.super_report_id := left.super_report_id ; 
) );

dup_NotifyDE := dedup(NotifyDE, all, local);

layout_corrections trecs4(jrecs_diffs L) := transform
self.entity_type  := 'ecr-rpt';
self.entity_id    := L.Case_Identifier; 
self.entity_id2   := L.loss_state_abbr;
self.entity_id3   := L.Agency_Name;
self.create_date  := L.date_vendor_last_reported[1..4]+'-'+L.date_vendor_last_reported[5..6]+'-'+L.date_vendor_last_reported[7..8];
self.extra_data   := L.IMAGE_HASH; 
self              := L;
end;

precs := project(dedup(jrecs_diffs(case_identifier!='' and agency_name !='' and work_type_id in ['1', 'NULL','0']),case_identifier,IMAGE_HASH,all),trecs4(left));
       

string fd := filedate;

return

sequential(

	 output(dedup(precs+dup_NotifyDE,record,all)(extra_data <> ''),,'~thor_data400::out::ecrash::'+fd+'::report_update'
												,csv(terminator('\n')
												,separator(','),quote('"'))
												,overwrite) 
	,fileservices.Despray('~thor_data400::out::ecrash::'+filedate+'::report_update'
												, Constants.LandingZone
												, '/data/super_credit/ecrash/account_monitoring/toprocess/ecrash_'
																+filedate[1..4]+'-'+filedate[5..6]+'-'+filedate[7..8]+'_'+ 
																timestamp[1..2]+'_'+timestamp[3..4]+'_'+timestamp[5..6]+'_report-update.csv'),
			output(header_row+newdupes,,'~thor_data400::out::ecrash::'+fd+'::extract::caseDupes'
												 ,csv(terminator('\n')
												 ,separator(','))
												 ,overwrite,__compressed__)
				 ,fileservices.addsuperfile('~thor_data400::out::ecrash::dupes','~thor_data400::out::ecrash::'+filedate+'::extract::caseDupes')
				 ,fileservices.Despray('~thor_data400::out::ecrash::'+filedate+'::extract::caseDupes'
												  , Constants.LandingZone
												  , '/data/super_credit/ecrash/despray/dbdupes/ecrash_'+filedate+'_'+timestamp+'_extract_casedupes.csv',,,,true)
					 );					

end;




								
								
								
								

