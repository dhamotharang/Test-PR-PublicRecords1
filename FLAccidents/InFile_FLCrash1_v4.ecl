/* 11/22/11 - new layout *slucero
*/
import FLAccidents,STD;

flc1_v4_in := dataset('~thor_data400::sprayed::flcrash1'
									,FLAccidents.Layout_FLCrash1_v4, csv(Heading(1),separator(','),terminator(['\n','\r\n'])));
									
flc2_v4_in := dataset('~thor_data400::sprayed::flcrash2v'
									,FLAccidents.Layout_FLCrash2v_v4, csv(Heading(1),separator(','),terminator(['\n','\r\n'])));

flc1_v4_rec := FLAccidents.Layout_FLCrash1;

// string8     fSlashedMDYtoCYMD(string pDateIn) :=
			// intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),4,1)
// +     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1)
// +     intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),2,1);

flc1_v4_rec flc1_convert_to_old(flc1_v4_in l) := transform
   self.rec_type_1          := '1';
//   tempReportDte						:= norm_date3(l.report_date)
//   self.report_date         := fSlashedMDYtoCYMD(tempReportDte);
  self.report_date        := STD.date.ConvertDateFormat( l.report_date, '%Y%m%d','%m/%d/%Y');
	temp_hr_notified				:= regexfind('([0-9]+):(.*)',l.notified_date,1);
	temp_min_notified				:= regexfind('([0-9]+):(.*)',l.notified_date,2);
	self.hr_off_notified		:= IF(temp_hr_notified <> '00', temp_hr_notified,'');	
	self.min_off_notified		:= IF(temp_min_notified <> '00', temp_min_notified,'');
	temp_hr_off_arrived			:= regexfind('([0-9]+):([0-9]+)',l.arrived_date,1); 
	temp_min_off_arrived		:= regexfind('([0-9]+):([0-9]+)',l.arrived_date,2);
	self.hr_off_arrived			:= IF(temp_hr_off_arrived <> '00',temp_hr_off_arrived,'');
	self.min_off_arrived		:= IF(temp_min_off_arrived <> '00', temp_min_off_arrived,'');
  self.city_nbr           := trim(l.county_code,left,right) + trim(l.city_code,left,right);
  
   // self.alcohol_drug           := map(l.alcohol_drug = '1' => 'A',
                                       // l.alcohol_drug = '2' => 'D',
									   // l.alcohol_drug = '3' => 'B',
									   // l.alcohol_drug = '4' => 'U',
									   // l.alcohol_drug = '0' => 'N','');
   
   self.invest_complete     := map(l.invest_complete = '1' => 'Y',
                                   l.invest_complete = '2' => 'N','');
   // self.first_aid_name         := map(l.first_aid_name_code = '1' => 'Physician',
                                      // l.first_aid_name_code = '2' => 'EMT',
									  // l.first_aid_name_code = '3' => 'Police Officer',
									  // l.first_aid_name_code = '4' => 'Certified 1st Aider',
									  // l.first_aid_name_code = '5' => 'Other','');
   // self.injured_taken_to       := map(l.injured_taken_to_code = '1' => 'Y',
                                       // l.injured_taken_to_code = '0' => 'N',''); 
	// self.location_type         :=  map(l.location_type = '1' => 'B',
                                       // l.location_type = '2' => 'R',
									   // l.location_type = '3' => 'O','');
	self.site_loc := IF(trim(l.site_loc) = ' ','00',
											IF(length(trim(l.site_loc,left,right))<2,'0'+trim(l.site_loc,left,right),
													trim(l.site_loc,left,right)));
	self.first_harmful_event := IF(trim(l.first_harmful_event) = ' ','00',
																IF(length(trim(l.first_harmful_event,left,right))<2,'0'+trim(l.first_harmful_event,left,right),
																	 trim(l.first_harmful_event,left,right)));
	self.subs_harmful_event	:= '00';
	self.light_condition	:= IF(trim(l.light_condition) = ' ','00',
															IF(length(trim(l.light_condition,left,right))<2,'0'+trim(l.light_condition,left,right),
																trim(l.light_condition,left,right)));
	self.weather	:= IF(trim(l.weather) = ' ','00',
											IF(length(trim(l.weather,left,right))<2,'0'+trim(l.weather,left,right),
												trim(l.weather,left,right)));
	self.rd_surface_type := '00';
	self.type_shoulder	:= IF(trim(l.type_shoulder) = ' ','00',
														IF(length(trim(l.type_shoulder,left,right))<2,'0'+trim(l.type_shoulder,left,right),
																trim(l.type_shoulder,left,right)));
 	self.rd_surface_condition	:= map(trim(l.rd_surface_condition,left,right) = '5' => '03',
																		trim(l.rd_surface_condition,left,right) = '6' => '01',
																		trim(l.rd_surface_condition,left,right) = '7' => '01',
																		trim(l.rd_surface_condition,left,right) = '8' => '02',
																		trim(l.rd_surface_condition,left,right,left,right) = ' ' => '00',
																		length(trim(l.rd_surface_condition))<2 => '0'+trim(l.rd_surface_condition,left,right),
																		trim(l.rd_surface_condition,left,right));
	self.first_contrib_cause	:=	map(trim(l.rd_condition_primary,left,right) = '10' => '77',
																		 trim(l.rd_condition_primary,left,right) = '11' => '03',
																		 trim(l.rd_condition_primary,left,right) = '12' => '03',
																		 trim(l.rd_condition_primary,left,right) = '13' => '77',
																		 trim(l.rd_condition_primary,left,right) = '14' => '77',
																		 trim(l.rd_condition_primary,left,right) = ' ' => '00',
																		 length(trim(l.rd_condition_primary,left,right))<2 => '0'+trim(l.rd_condition_primary,left,right),
																		 trim(l.rd_condition_primary,left,right));
	self.second_contrib_cause	:=	map(trim(l.rd_condition_secondary,left,right) = '10' => '77',
																		 trim(l.rd_condition_secondary,left,right) = '11' => '03',
																		 trim(l.rd_condition_secondary,left,right) = '12' => '03',
																		 trim(l.rd_condition_secondary,left,right) = '13' => '77',
																		 trim(l.rd_condition_secondary,left,right) = '14' => '77',
																		 trim(l.rd_condition_secondary,left,right) = ' ' => '00',
																		 length(trim(l.rd_condition_secondary,left,right))<2 => '0'+trim(l.rd_condition_secondary,left,right),
																		 trim(l.rd_condition_secondary,left,right));
	self.first_contrib_envir	:=	map(trim(l.vision_obstructed_primary,left,right) = '4' => '10',
																			trim(l.vision_obstructed_primary,left,right) = '5' => '77',
																			trim(l.vision_obstructed_primary,left,right) = '88' => '00',
																			trim(l.vision_obstructed_primary,left,right) = ' ' => '00',
																			length(trim(l.vision_obstructed_primary,left,right))<2 => '0'+trim(l.vision_obstructed_primary,left,right),
																			trim(l.vision_obstructed_primary,left,right));
	self.second_contrib_envir :=   map(trim(l.vision_obstructed_secondary,left,right) = '4' => '10',
																			trim(l.vision_obstructed_secondary,left,right) = '5' => '77',
																			trim(l.vision_obstructed_secondary,left,right) = '88' => '00',
																			trim(l.vision_obstructed_secondary,left,right) = ' ' => '00',
																			length(trim(l.vision_obstructed_secondary,left,right))<2 => '0'+trim(l.vision_obstructed_secondary,left,right),
																			trim(l.vision_obstructed_secondary,left,right));
	self.rd_sys_id	:= IF(trim(l.rd_sys_id) = ' ','00',
												IF(length(trim(l.rd_sys_id,left,right))<2,'0'+trim(l.rd_sys_id,left,right),
													trim(l.rd_sys_id,left,right)));
	self.invest_name := trim(l.invest_fname,left,right) +' '+trim(l.invest_mname,left,right) +' '+ trim(l.invest_lname ,left,right);
	self.invest_agency := l.invest_agency_type ; 
	//self.invest_agency_desc := l.invest_agency; dept_name is blank for all records as of 201212 so mapping agency name to dept_name
	self.dept_name           := l.invest_agency; //PD name in coming in invest_agency after layout change
	self                			:= l;
	self                      := [];

end;

FLCrash1_v4_cnvrt		:= project(flc1_v4_in,flc1_convert_to_old(left));

flc1_v4_rec join_FLCrash2_v4(FLCrash1_v4_cnvrt l, flc2_v4_in r)	:= transform
	self.first_traffic_control	:= map(trim(r.traffic_control,left,right) = '13' => '77',
																			trim(r.traffic_control,left,right) = '88' => '00',
																			trim(r.traffic_control,left,right) = ' ' => '00',
																			length(trim(r.traffic_control,left,right))<2	=> '0'+trim(r.traffic_control,left,right),
																			trim(r.traffic_control,left,right));
	self.second_traffic_control	:= '00';
	self.trafficway_char		:= map(trim(r.trafficway_char,left,right) = '1' and trim(r.road_alignment,left,right) = '1' => '01',
																	trim(r.trafficway_char,left,right) = '1' and trim(r.road_alignment,left,right) = '2' => '03',
																	trim(r.trafficway_char,left,right) = '1' and trim(r.road_alignment,left,right) = '3' => '03',
																	trim(r.trafficway_char,left,right) = '2' and trim(r.road_alignment,left,right) = '1' => '02',
																	trim(r.trafficway_char,left,right) = '2' and trim(r.road_alignment,left,right) = '2' => '04',
																	trim(r.trafficway_char,left,right) = '2' and trim(r.road_alignment,left,right) = '3' => '04',
																	trim(r.trafficway_char,left,right) = '3' and trim(r.road_alignment,left,right) = '1' => '02',
																	trim(r.trafficway_char,left,right) = '3' and trim(r.road_alignment,left,right) = '2' => '04',
																	trim(r.trafficway_char,left,right) = '3' and trim(r.road_alignment,left,right) = '3' => '04',
																	trim(r.trafficway_char,left,right) = '4' and trim(r.road_alignment,left,right) = '1' => '02',
																	trim(r.trafficway_char,left,right) = '4' and trim(r.road_alignment,left,right) = '2' => '04',
																	trim(r.trafficway_char,left,right) = '4' and trim(r.road_alignment,left,right) = '3' => '04',
																	trim(r.trafficway_char,left,right) = '5' and trim(r.road_alignment,left,right) = '1' => '01',
																	trim(r.trafficway_char,left,right) = '5' and trim(r.road_alignment,left,right) = '2' => '03',
																	trim(r.trafficway_char,left,right) = '5' and trim(r.road_alignment,left,right) = '3' => '03',
																	trim(r.trafficway_char,left,right) = ' ' and trim(r.road_alignment,left,right) = '1' => '01',
																	trim(r.trafficway_char,left,right) = ' ' and trim(r.road_alignment,left,right) = '2' => '03',
																	trim(r.trafficway_char,left,right) = ' ' and trim(r.road_alignment,left,right) = '3' => '03',
																	trim(r.trafficway_char,left,right) = ' ' and trim(r.road_alignment,left,right) = ' ' => '00',
																	length(trim(r.trafficway_char,left,right))<2 => '0'+trim(r.trafficway_char,left,right),
																	trim(r.trafficway_char,left,right));
	self.nbr_lanes					:= r.nbr_lanes;
	self				:= l;
end;

export InFile_FLCrash1_v4 := join(FLCrash1_v4_cnvrt, flc2_v4_in,
																	left.accident_nbr = right.accident_nbr,
																	join_FLCrash2_v4(left,right),left outer,lookup);