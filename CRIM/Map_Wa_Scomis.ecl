



import crim_common, Crim, Address,ut;



string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

// output thor_dell400::persist::crim_ok_adair_offender_clean etc
// thor_data400::in::crim_court::20070924::oh_tuscarawas.txt

// thor_data400::temp::john_test::i name these anything

// thor_data400::in::crim_court::20030306::wa_scomis_case
// thor_data400::in::crim_court::20030306::wa_scomis_charge

/*
layout_charge_dated := record
string8 filedate;
CRIM.Layout_WA_Scomis.layout_charge;
end;
*/

file_case := dataset('~thor_data400::in::crim_court::wa_scomis_case_superfile',CRIM.Layout_WA_Scomis.layout_case,thor);
file_charge := dataset('~thor_data400::in::crim_court::wa_scomis_charge_superfile',CRIM.Layout_WA_Scomis.layout_charge_dated,thor);




//output(file_case);
//output(file_charge);

/*
Crim_Common.Layout_In_Court_Offender
Crim_Common.Layout_In_Court_Offenses
Crim_Common.Layout_In_Court_Activity
*/




// spray the two files
// preprocess the files

// start with case file
// sort case file on superior court name, case number, and status date

file_case_sorted := distribute(sort(file_case,superior_court_name,case_number,status_date,local),hash(case_number));
file_case_deduped := dedup(file_case_sorted,case_number,superior_court_name,local);



layout_case_as_offender := record
string8		process_date;
string60	offender_key;
string2		vendor;
string2		state_origin;
string1		data_type;
string20	source_file;
string35	case_number;
string40	case_court;
string50	case_name;
string5		case_type;
string25	case_type_desc;
string8		case_filing_dt;
string56	pty_nm;
string1		pty_nm_fmt;
string20	orig_lname;
string20	orig_fname;
string20	orig_mname;
string10	orig_name_suffix;
string1		pty_typ;
string1		nitro_flag;
string9		orig_ssn;
string10	dle_num;
string9		fbi_num;
string10	doc_num;
string10	ins_num;
string15	id_num;
string25	dl_num;
string2		dl_state;
string2		citizenship;
string8		dob;
string8		dob_alias;
string2		place_of_birth;
string25	street_address_1;
string25	street_address_2;
string25	street_address_3;
string10	street_address_4;
string10	street_address_5;
string5		race;
string30	race_desc;
string1		sex;
string5		hair_color;
string25	hair_color_desc;
string5		eye_color;
string25	eye_color_desc;
string5		skin_color;
string25	skin_color_desc;
string3		height;
string3		weight;
string10	party_status;
string60	party_status_desc;
end;

layout_case_as_offender case_as_offender(CRIM.Layout_WA_Scomis.layout_case l) := transform
	self.process_date := ut.GetDate;
	self.vendor := '02';  
	self.state_origin := 'WA'; 
	self.data_type := '2';
	self.source_file := 'WA-SCOMIS-CRIM-COURT';
	self.offender_key := '02'+l.superior_court_name+l.case_number; 
	self.case_number := l.case_number;
	self.case_court := l.superior_court_name;
	self.case_name := l.case_title;
	self.case_type := l.case_type_code;
	self.case_type_desc := if(l.case_type_code ='C' , 'Criminal' ,
							if(l.case_type_code ='J' , 'Juvenile Offender' , ''));
	self.case_filing_dt :=		if(fSlashedMDYtoCYMD(l.case_filing_date)[1..2] between '19' and '20',
							fSlashedMDYtoCYMD(l.case_filing_date),
							'');	
							
							
	self.pty_nm := l.name_of_indiv;
	self.pty_nm_fmt := 'L';
	self.sex := l.gender;
	self.dob :=		if(fSlashedMDYtoCYMD(l.date_of_birth)[1..2] between '19' and '20',
							fSlashedMDYtoCYMD(l.date_of_birth),
							'');				
					
					
	self.pty_typ := '1';
self.orig_lname :='';
self.orig_fname :='';
self.orig_mname :='';
self.orig_name_suffix :='';	
self.nitro_flag :='';
self.orig_ssn :='';
self.dle_num :='';
self.fbi_num :='';
self.doc_num :='';
self.ins_num :='';
self.id_num :='';
self.dl_num :='';
self.dl_state :='';
self.citizenship :='';
self.dob_alias :='';
self.place_of_birth :='';
self.street_address_1 :='';
self.street_address_2 :='';
self.street_address_3 :='';
self.street_address_4 :='';
self.street_address_5 :='';
self.race :='';
self.race_desc :='';
self.hair_color :='';
self.hair_color_desc :='';
self.eye_color :='';
self.eye_color_desc :='';
self.skin_color :='';
self.skin_color_desc :='';
self.height :='';
self.weight :='';
self.party_status :='';
self.party_status_desc :='';

 							
end;

file_case_as_offender := project(file_case_deduped,case_as_offender(left));




////// these sorts and dedupes need to be looked at very carefully
////// they probably can go, or at least be changed

// map case file
file_case_as_offender_sorted := sort(file_case_as_offender,
			process_date,offender_key,vendor,state_origin,data_type,
			source_file,case_number,case_court,case_name,case_type,
			case_type_desc,case_filing_dt,pty_nm,pty_nm_fmt,orig_lname,
			orig_fname,orig_mname,orig_name_suffix,pty_typ,nitro_flag,
			orig_ssn,dle_num,fbi_num,doc_num,ins_num,id_num,dl_num,
			dl_state,citizenship,dob,dob_alias,place_of_birth,street_address_1,
			street_address_2,street_address_3,street_address_4,street_address_5,
			race,race_desc,sex,hair_color,hair_color_desc,eye_color,eye_color_desc,
			skin_color,skin_color_desc,height,weight,party_status,party_status_desc);
// this is courtoffender_wa_scomis_crim.d00			
file_case_as_offender_deduped := dedup(file_case_as_offender_sorted,
			process_date,offender_key,vendor,state_origin,data_type,source_file,
			case_number,case_court,case_name,case_type,case_type_desc,case_filing_dt,
			pty_nm,pty_nm_fmt,orig_lname,orig_fname,orig_mname,orig_name_suffix,
			pty_typ,nitro_flag,orig_ssn,dle_num,fbi_num,doc_num,ins_num,id_num,
			dl_num,dl_state,citizenship,dob,dob_alias,place_of_birth,street_address_1,
			street_address_2,street_address_3,street_address_4,street_address_5,
			race,race_desc,sex,hair_color,hair_color_desc,eye_color,eye_color_desc,
			skin_color,skin_color_desc,height,weight,party_status,party_status_desc);


// file_case_deduped   input for big reformat

layout_court_crim_activity := record
  string8	process_date;
  string60	offender_key;
  string2	vendor;
  string2	state_origin;
  string20	source_file;
  string4     off_comp;
  string35	case_number;
  string2     event_type;
  string9	event_sort_order;
  string8	event_date;
  string10    event_location_code;
  string50    event_location_desc;
  string8     event_desc_code;
  string50    event_desc_1;
  string50    event_desc_2;
end;



layout_court_crim_activity norm_activity(CRIM.Layout_WA_Scomis.layout_case l,counterr) := transform
// common stuff
  self.process_date := ut.GetDate;   
  self.vendor := '02';  
  self.state_origin := 'WA'; 
  self.source_file := 'WA-SCOMIS-CRIM-COURT'; 
  self.offender_key := '02'+l.superior_court_name+l.case_number;
  self.event_location_desc := l.superior_court_name;
  self.case_number := l.case_number;
  self.event_type := choose(counterr,'CD','CD','CS','CF');
  
  self.event_desc_code := choose(counterr,l.resolution_code,l.completion_code,l.status_code,'');
  
  self.event_desc_1 := choose(counterr,'Case Resolution','Case Completion','Case Status','Case Filed');
  
  self.event_desc_2 := choose(counterr,l.resolution_description,l.completion_description,l.status_description,'');
  
  self.event_sort_order := choose(counterr,'1','2','3','4');
			
  self.event_date := 		choose(counterr,
							if(fSlashedMDYtoCYMD(l.resolution_date)[1..2] between '19' and '20',
							fSlashedMDYtoCYMD(l.resolution_date ),
							''),  
							if(fSlashedMDYtoCYMD(l.completion_date)[1..2] between '19' and '20',
							fSlashedMDYtoCYMD(l.completion_date ),
							''), 
							if(fSlashedMDYtoCYMD(l.status_date)[1..2] between '19' and '20',
							fSlashedMDYtoCYMD(l.status_date ),
							''),					
							if(fSlashedMDYtoCYMD(l.case_filing_date)[1..2] between '19' and '20',
							fSlashedMDYtoCYMD(l.case_filing_date),
							''));
							
self.off_comp := '';
self.event_location_code := '';						
		
end;


file_as_activity := normalize(file_case_deduped,4,norm_activity(left,counter)); // fix me  1

file_as_activity_sorted := sort(file_as_activity,
			process_date, offender_key, event_sort_order, vendor, state_origin, source_file, off_comp,
			case_number, event_type, event_date, event_location_code, event_location_desc, event_desc_code,
			event_desc_1, event_desc_2);
file_as_activity_deduped_seq := dedup(file_as_activity_sorted(event_date != '' or event_desc_2 != ''),
			process_date, offender_key, event_sort_order, vendor, state_origin, source_file, off_comp,
			case_number, event_type, event_date, event_location_code, event_location_desc, event_desc_code,
			event_desc_1, event_desc_2);
/*
layout_court_crim_activity Sequence(layout_court_crim_activity l, layout_court_crim_activity r) := TRANSFORM
	SELF.event_sort_order := IF(l.event_sort_order = '0', '1', // fix me  integer cast to string
				if(l.offender_key = r.offender_key, l.event_sort_order,l.event_sort_order + '1'));
	SELF := r;
END;

file_as_activity_deduped_seq := ITERATE(file_as_activity_deduped, Sequence(LEFT, RIGHT));
*/
// third line

//file_old_charge := dataset('~thor_data400::in::crim_court::persistant::wa_scomis_charge_persistant',CRIM.Layout_WA_Scomis.layout_charge,thor);
// remove this later

// comment me out after first run
//output(file_charge(superior_court_name = '123456789'),,'~thor_data400::in::crim_court::persistant::wa_scomis_charge_persistant',overwrite);

file_charge_sorted := distribute(sort(file_charge,superior_court_name,case_number,
		entry_sequance_number,count_number,filedate,local),hash(case_number));  
		
file_new_charge_sorted := sort(file_charge,superior_court_name,case_number, 
		entry_sequance_number,count_number,filedate,local);
///////// add dedup

file_new_charge_deduped := dedup(file_new_charge_sorted,superior_court_name,case_number,
								entry_sequance_number,count_number,local);
//lets drop the filedate now

CRIM.Layout_WA_Scomis.layout_charge drop_date(CRIM.Layout_WA_Scomis.layout_charge_dated  l) := transform

self:=l;

end;


file_new_charge := project(file_new_charge_deduped,drop_date(left));								
							



///////// delete start here
/*
CRIM.Layout_WA_Scomis.layout_charge join_dedup(CRIM.Layout_WA_Scomis.layout_charge l,CRIM.Layout_WA_Scomis.layout_charge r) := transform
self := if(r.superior_court_name + r.case_number + r.entry_sequance_number + r.count_number <> '' ,r,l);


end;

file_charge_tobeprocessed := join(file_new_charge_sorted,file_charge_sorted,
					left.superior_court_name = right.superior_court_name and 
					left.case_number = right.case_number and
					left.entry_sequance_number = right.entry_sequance_number and
					left.count_number = right.count_number,
					join_dedup(left,right),full outer,hash,local);

output(file_charge_tobeprocessed,,'~thor_data400::in::crim_court::persistant::wa_scomis_charge_persistant_copy',overwrite);

output(file_charge_tobeprocessed, named('ChargeToBeProcessed'));


*/
/////////// end delete

layout_joined_wa_scomis := record

CRIM.Layout_WA_Scomis.layout_case;
//CRIM.Layout_WA_Scomis.layout_charge;  
   string12 ch_superior_court_name;
   string9 ch_case_number;
   string5 ch_entry_sequance_number;
   string10 ch_violation_date;
   string3 ch_count_number;
   string15 ch_law_number;
   string40 ch_law_descritpion;
   string2 ch_rcw_category;
   string1 ch_rcw_class;
   string2 ch_charge_result_code;
   string2 ch_charge_weapon_result_code;
   string15 ch_charge_weapon_code;
   string15 ch_charge_modified_code;
   string15 ch_charge_other1_code;
   string15 ch_charge_other2_code;
   string15 ch_charge_other3_code;
   string11 ch_unkown;
   string2 ch_crlf;

end;


layout_joined_wa_scomis join_files(CRIM.Layout_WA_Scomis.layout_charge l, CRIM.Layout_WA_Scomis.layout_case r) := transform
self := r;

self.ch_superior_court_name := l.superior_court_name;
self.ch_case_number := l.case_number;
self.ch_entry_sequance_number := l.entry_sequance_number;
self.ch_violation_date := l.violation_date;
self.ch_count_number := l.count_number;
self.ch_law_number := l.law_number;
self.ch_law_descritpion := l.law_descritpion;
self.ch_rcw_category := l.rcw_category;
self.ch_rcw_class := l.rcw_class;
self.ch_charge_result_code := l.charge_result_code;
self.ch_charge_weapon_result_code := l.charge_weapon_result_code;
self.ch_charge_weapon_code := l.charge_weapon_code;
self.ch_charge_modified_code := l.charge_modified_code;
self.ch_charge_other1_code := l.charge_other1_code;
self.ch_charge_other2_code := l.charge_other2_code;
self.ch_charge_other3_code := l.charge_other3_code;
self.ch_unkown := l.unkown;
self.ch_crlf := l.crlf;


end;

charge_joined := join(file_new_charge,file_case_deduped,
					left.superior_court_name = right.superior_court_name and 
					left.case_number = right.case_number,// and
					join_files(left,right)); 
// yes means they potentilly get populated




layout_as_offense := record

  string8 process_date;		 //yes
  string60 offender_key;	 //yes
  string2 vendor;			 //yes
  string2 state_origin;		 //yes
  string20 source_file;		 //yes
  string4 off_comp;			 //yes
  string1 off_delete_flag;
  string8 off_date;			 //yes
  string8 arr_date;
  string3 num_of_counts;
  string10 le_agency_cd;
  string50 le_agency_desc;
  string35 le_agency_case_number;
  string35 traffic_ticket_number;
  string25 traffic_dl_no;
  string2 traffic_dl_st;
  string20 arr_off_code;
  string75 arr_off_desc_1;
  string50 arr_off_desc_2;
  string5 arr_off_type_cd;
  string30 arr_off_type_desc;
  string5 arr_off_lev;
  string20 arr_statute;
  string70 arr_statute_desc;
  string8 arr_disp_date;
  string5 arr_disp_code;
  string30 arr_disp_desc_1;
  string30 arr_disp_desc_2;
  string10 pros_refer_cd;
  string50 pros_refer;
  string10 pros_assgn_cd;
  string50 pros_assgn;
  string1 pros_chg_rej;
  string20 pros_off_code;
  string75 pros_off_desc_1;
  string50 pros_off_desc_2;
  string5 pros_off_type_cd;
  string30 pros_off_type_desc;
  string5 pros_off_lev;
  string30 pros_act_filed;
  string35 court_case_number;	 //yes
  string10 court_cd;
  string40 court_desc;			 //yes
  string1 court_appeal_flag;	 //yes
  string30 court_final_plea;
  string20 court_off_code;
  string75 court_off_desc_1;
  string50 court_off_desc_2;
  string5 court_off_type_cd;	 //yes
  string30 court_off_type_desc;	 //yes
  string5 court_off_lev;		 //yes
  string20 court_statute;		 //yes
  string50 court_additional_statutes; //yes
  string70 court_statute_desc;	 //yes
  string8 court_disp_date;
  string5 court_disp_code;		 //yes
  string40 court_disp_desc_1;	 //yes
  string40 court_disp_desc_2;	 //yes
  string8 sent_date;
  string50 sent_jail;
  string50 sent_susp_time;
  string8 sent_court_cost;
  string9 sent_court_fine;
  string9 sent_susp_court_fine;
  string50 sent_probation;
  string5 sent_addl_prov_code;
  string40 sent_addl_prov_desc_1;
  string40 sent_addl_prov_desc_2;
  string2 sent_consec;
  string10 sent_agency_rec_cust_ori;
  string50 sent_agency_rec_cust;
  string8 appeal_date;
  string40 appeal_off_disp;
  string40 appeal_final_decision;
end;

layout_as_offense proc_as_offense(layout_joined_wa_scomis l) := transform

  self.process_date :=		 ut.GetDate;  
  self.offender_key:=	 '02' + l.ch_superior_court_name + l.ch_case_number;
  self.vendor :=			 '02';
  self.state_origin:=		 'WA';
  self.source_file:=		'WA-SCOMIS-CRIM-COURT';
  self.off_comp := 			map(  
							l.ch_entry_sequance_number ='00001' => 'A',
							l.ch_entry_sequance_number ='00002' => 'B',
							l.ch_entry_sequance_number ='00003' => 'C',
							l.ch_entry_sequance_number ='00004' => 'D',
							l.ch_entry_sequance_number ='00005' => 'E',
							l.ch_entry_sequance_number ='00006' => 'F',
							l.ch_entry_sequance_number ='00007' => 'G',
							l.ch_entry_sequance_number ='00008' => 'H',
							l.ch_entry_sequance_number ='00009' => 'I',
							l.ch_entry_sequance_number ='00010' => 'J','') + l.ch_count_number;  
  
  
  
  self.off_date:= 			if(fSlashedMDYtoCYMD(l.ch_violation_date )[1..2] between '19' and '20',
							fSlashedMDYtoCYMD(l.ch_violation_date  ),
							'');

  self.court_case_number:=	 l.ch_case_number;
  self.court_desc:=			 l.ch_superior_court_name;
  self.court_appeal_flag:=	 l.clj_appeal_flag;
  self.court_off_type_cd:=	 l.ch_rcw_category;
  self.court_off_type_desc:= map(
				l.ch_rcw_category ='00' => 'Non-Charge' , 
				l.ch_rcw_category ='01' => 'Homicide' , 
				l.ch_rcw_category ='02' => 'Sex Crime' , 
				l.ch_rcw_category ='03' => 'Robbery' , 
				l.ch_rcw_category ='04' => 'Assault' , 
				l.ch_rcw_category ='05' => 'Burglary' , 
				l.ch_rcw_category ='06' => 'Theft/Burglary' , 
				l.ch_rcw_category ='07' => 'Motor Vehicle Theft' , 
				l.ch_rcw_category ='08' => 'Controlled Substance' , 
				l.ch_rcw_category ='09' => 'Other Felony' , 
				l.ch_rcw_category ='10' => 'Misdemeanor/Gross Misdemeanor' , 
				l.ch_rcw_category ='11' => 'Lower Court Appeal' , 
				l.ch_rcw_category ='98' => 'Deadly Weapon' ,  '');
  self.court_off_lev:=		 map(
				l.ch_rcw_class ='M' => 'M' , 
				l.ch_rcw_class ='G' => 'G' ,
				l.ch_rcw_class ='F' => 'F' ,
				l.ch_rcw_class ='C' => 'C' , '');
  self.court_statute:=		 l.ch_law_number;
  

self.court_additional_statutes := 
  if(l.ch_charge_modified_code <> '' , l.ch_charge_modified_code + ',', '') +
  if(l.ch_charge_weapon_code   <> '' , l.ch_charge_weapon_code   + ',', '') +
  if(l.ch_charge_other1_code   <> '' , l.ch_charge_other1_code   + ',', '') +
  if(l.ch_charge_other2_code   <> '' , l.ch_charge_other2_code   + ',', '') +
  if(l.ch_charge_other3_code   <> '' , l.ch_charge_other3_code   + ',', '');
  
  
  self.court_statute_desc := l.ch_law_descritpion;
  self.court_disp_code :=	 l.ch_charge_result_code + l.ch_charge_weapon_result_code;
  self.court_disp_desc_1 := map(
	l.ch_charge_result_code ='CV' => 'Change of venue',
	l.ch_charge_result_code ='D' => 'Dismissed', 
	l.ch_charge_result_code ='G' => 'Guilty', 
	l.ch_charge_result_code ='N' => 'Noncharge', 
	l.ch_charge_result_code ='NG' => 'Acquitted/Not guilty', 
	l.ch_charge_result_code ='P' => 'Pending', 
	l.ch_charge_result_code ='TR' => 'Transfer',
	l.ch_charge_result_code ='V' => 'Vacated' , '');
	
  self.court_disp_desc_2 := map(
	l.ch_charge_weapon_result_code ='CV' => 'Weapon Charge-Change of venue',
	l.ch_charge_weapon_result_code ='D' => 'Weapon Charge-Dismissed',
	l.ch_charge_weapon_result_code ='G' => 'Weapon Charge-Guilty',
	l.ch_charge_weapon_result_code ='N' => 'Weapon Charge-Noncharge',
	l.ch_charge_weapon_result_code ='NG' => 'Weapon Charge-Acquitted/Not guilty',
	l.ch_charge_weapon_result_code ='P' => 'Weapon Charge-Charge-Pending',
	l.ch_charge_weapon_result_code ='TR' => 'Weapon Charge-Transfer',
	l.ch_charge_weapon_result_code ='V' => 'Weapon Charge-Vacated', '');  
	
self.off_delete_flag :='';
self.arr_date :='';
self.num_of_counts :='';
self.le_agency_cd :='';
self.le_agency_desc :='';
self.le_agency_case_number :='';
self.traffic_ticket_number :='';
self.traffic_dl_no :='';
self.traffic_dl_st :='';
self.arr_off_code :='';
self.arr_off_desc_1 :='';
self.arr_off_desc_2 :='';
self.arr_off_type_cd :='';
self.arr_off_type_desc :='';
self.arr_off_lev :='';
self.arr_statute :='';
self.arr_statute_desc :='';
self.arr_disp_date :='';
self.arr_disp_code :='';
self.arr_disp_desc_1 :='';
self.arr_disp_desc_2 :='';
self.pros_refer_cd :='';
self.pros_refer :='';
self.pros_assgn_cd :='';
self.pros_assgn :='';
self.pros_chg_rej :='';
self.pros_off_code :='';
self.pros_off_desc_1 :='';
self.pros_off_desc_2 :='';
self.pros_off_type_cd :='';
self.pros_off_type_desc :='';
self.pros_off_lev :='';
self.pros_act_filed :='';
self.court_cd :='';
self.court_final_plea :='';
self.court_off_code :='';
self.court_off_desc_1 :='';
self.court_off_desc_2 :='';
self.court_disp_date :='';
self.sent_date :='';
self.sent_jail :='';
self.sent_susp_time :='';
self.sent_court_cost :='';
self.sent_court_fine :='';
self.sent_susp_court_fine :='';
self.sent_probation :='';
self.sent_addl_prov_code :='';
self.sent_addl_prov_desc_1 :='';
self.sent_addl_prov_desc_2 :='';
self.sent_consec :='';
self.sent_agency_rec_cust_ori :='';
self.sent_agency_rec_cust :='';
self.appeal_date :='';
self.appeal_off_disp :='';
self.appeal_final_decision :='';	
	
	
	
end;




file_as_offense := project(charge_joined,proc_as_offense(left));

CRIM.Crim_clean(file_case_as_offender_deduped,file_case_as_offender_cleaned);


fCAOffend := dedup(sort(distribute(file_case_as_offender_cleaned,hash(offender_key)),
			offender_key,case_number,case_court,pty_nm,pty_nm_fmt,pty_typ,dob,local),
			offender_key,pty_nm,pty_typ,local,left): 
			PERSIST('~thor_dell400::persist::Crim_WA_Scomis_Offender_Clean');



fWAOffense:= dedup(sort(distribute(file_as_offense,hash(offender_key)),
									offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_desc_1,source_file,local),
									offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_desc_1,local,left):
									PERSIST('~thor_dell400::persist::Crim_WA_Scomis_Offenses_Clean');
// fields are wrong
fWAActivity:= distribute(file_as_activity_deduped_seq,hash(offender_key)):
									PERSIST('~thor_dell400::persist::Crim_WA_Scomis_Activity_Clean');



export Map_Wa_Scomis := 
sequential(

output(fCAOffend,named('asOffender')),
output(fWAOffense,named('asOffense')),
output(fWAActivity,named('asActivity')),

// these can go
output(count(fCAOffend), named('CountasOffender')),
output(count(fWAActivity), named('countasActivity')),
output(count(fWAOffense), named('countasOffense'))
);


