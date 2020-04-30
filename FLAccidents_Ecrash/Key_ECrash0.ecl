Import Data_Services, doxie, FLAccidents, STD;

/////////////////////////////////////////////////////////////////
//Expand Florida file 
/////////////////////////////////////////////////////////////////
flc0 	:= FLAccidents.basefile_flcrash0;
xpnd_layout := record
       string2 report_code;
       string25 report_category;
       string65 report_code_desc;
	   string1    rec_type_o,
       string40    accident_nbr,
       string4    filler1,
       string11   microfilm_nbr,
       string1    st_road_accident,
       string8    accident_date,
       string4    city_nbr,
       string4    ft_city_town,
       string2    miles_city_town,
       string1    direction_city_town,
       string50   city_town_name,
       string50   county_name,
       string5    at_node_nbr,
       string4    ft_miles_node,
       string1    ft_miles_code1,
       string5    from_node_nbr,
       string5    next_node_rdwy,
       string36   st_road_hhwy_name,
       string36   at_intersect_of,
       string4    ft_miles_from_intersect,
       string1    ft_miles_code2,
       string1    intersect_dir_of,
       string36   of_intersect_of,
       string1    codeable_noncodeable,
       string1    type_fr_case,
       string1    action_code,
       string1    filler2,
       string1    dot_type_facility,
       string1    dot_road_type,
       string2    dot_nbr_lanes,
       string2    dot_site_loc,
       string1    dot_district_ind,
       string2    dot_county,
       string3    dot_section_nbr,
       string2    dot_skid_resistance,
       string1    dot_friction_coarse,
       string6    dot_avg_daily_traffic,
       string5    dot_node_nbr,
       string5    dot_distance_node,
       string1    dot_dir_from_node,
       string6    dot_st_road_nbr,
       string5    dot_us_road_nbr,
       string6    dot_milepost,
       string1    dot_hhwy_loc,
       string3    dot_subsection,
       string1    dot_system_type,
       string1    dot_travelway,
       string2    dot_node_type,
       string2    dot_fixture_type,
       string1    dot_side_of_road,
       string1    dot_accident_severity,
       string1    dot_lane_id,
       string98   filler3,
       string1    dhsmv_veh_crash_ind,
       string15   acc_key_online_update,
       string1    form_type,
       string2    update_nbr,
       string1    accident_error,
			 string40   orig_accnbr, 
       string8    filler4
  end;
xpnd_layout xpndrecs(flc0 L) := transform
self.report_code					:= 'FA';
self.report_category				:= 'Auto Report';
self.report_code_desc				:= 'Auto Accident';
self.accident_nbr           := STD.Str.Filter(l.accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
self.orig_accnbr           := l.accident_nbr; 
self 								:= L;
end;

pflc0 := project(flc0,xpndrecs(left));
  
/////////////////////////////////////////////////////////////////
//Slim National file 
/////////////////////////////////////////////////////////////////  
ntlFile := FLAccidents.BaseFile_NtlAccidents_Alpharetta;

pflc0 slimrec(ntlFile L) := transform

string8     fSlashedMDYtoCYMD(string pDateIn) :=
								intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
					+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
					+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.rec_type_o 			:= '0';
t_accident_nbr 			:= (string40)((unsigned6)L.vehicle_incident_id+10000000000);
t_scrub := STD.Str.Filter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
self.accident_nbr := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.vehicle_incident_id,t_scrub);  
self.orig_accnbr := t_accident_nbr; 
self.accident_date						:= fSlashedMDYtoCYMD(L.loss_date[1..10]);
self.city_town_name 		:= stringlib.stringtouppercase(L.inc_city);

       
self						:= L;
self						:= [];
end;

pntl := project(ntlFile,slimrec(left));

// inquiry file 

inqFile := FLAccidents_Ecrash.File_CRU_inquiries; 

pflc0 slimrecinq(inqFile L) := transform

string8     fSlashedMDYtoCYMD(string pDateIn) :=
intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.rec_type_o 			:= '0';
t_accident_nbr := if(L.vehicle_incident_id[1..3] = 'OID',
													(string40)((unsigned6)L.vehicle_incident_id[4..11]+100000000000),
													(string40)((unsigned6)L.vehicle_incident_id+10000000000));

t_scrub := STD.Str.Filter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
self.accident_nbr := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.vehicle_incident_id,t_scrub);  
self.orig_accnbr := t_accident_nbr; 

self.accident_date			:= fSlashedMDYtoCYMD(L.loss_date[1..10]);
self.city_town_name 		:= STD.Str.ToUpperCase(L.city);
self.report_code					:= 'I'+ L.report_code;
self						:= L;
self						:= [];
end;

pInq := project(inqFile,slimrecinq(left));

// ecrash 

ecrashFile := eCrashBaseAgencyExclusion;

pflc0 slimrececrash(ecrashFile L) := transform

self.rec_type_o 			:= '0';
t_accident_nbr 			:= if(l.source_id in['TM','TF'],L.state_report_number, L.case_identifier);
t_scrub := STD.Str.Filter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
self.accident_nbr := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.incident_id,t_scrub);
self.orig_accnbr := t_accident_nbr;
self.accident_date 			:= if(L.incident_id[1..9] ='188188188','20100901',L.crash_date);
self.city_town_name 		:= STD.Str.ToUpperCase(L.crash_city);
self.county_name        := l.crash_county; 
self.ft_miles_node := l.distance_from_node_miles;
self.dot_milepost := l.milepost1;
self.at_intersect_of := l.intersection_related ; 
self.st_road_hhwy_name :=l.state_highway_related; 
self.city_nbr := l.city_code; 
self						:= L;
self						:= [];
end;

pecrash := project(ecrashFile,slimrececrash(left));

//iyetek
/*
metadata := FLAccidents_Ecrash.BaseFile_Iyetek; 

pflc0 slimiyetek(metadata L) := transform

self.rec_type_o 			:= '0';
t_scrub := STD.Str.Filter(L.state_report_number,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
self.accident_nbr := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.incident_id,t_scrub);  
self.orig_accnbr := L.state_report_number; 
self.accident_date 			:= L.crash_date;
self.city_town_name 		:= STD.Str.ToUpperCase(L.Crash_City);
self.county_name        := l.crash_county; 
self						:= L;
self						:= [];
end;
piyetek := project(metadata,slimiyetek(left));*/

allrecs :=dedup(pflc0+pntl+pInq+pecrash/*+piyetek*/,record,all): persist('~thor_data400::persist::ecrash0');

export Key_ECrash0 := index(allrecs
                            ,{string40 l_acc_nbr :=accident_nbr}
							,{allrecs}
							,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrash0_' + doxie.Version_SuperKey);
						 	 