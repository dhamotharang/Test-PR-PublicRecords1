
import FLAccidents, lib_AddrClean;

EXPORT Map_FLAccidents(
	dataset(recordof(FLAccidents.layout_flaccidents))	ds_FLaccidents)	:=
MODULE

ValidRecType			:=	['0','1','2','3','4','5','6','7','8'];
EXPORT InvalidRecords	:=	ds_FLaccidents(rec_type not in ValidRecType);

//flcrash0 time & location	#############################################
r_FLCrash0_in		:=	record
	rec_type_0				:=	ds_FLaccidents.rec_type[	1	..	1	];
	accident_nbr			:=	ds_FLaccidents.data_[	1	..	9	];
	filler1					:=	ds_FLaccidents.data_[	10	..	13	];
	microfilm_nbr			:=	ds_FLaccidents.data_[	14	..	24	];
	st_road_accident		:=	ds_FLaccidents.data_[	25	..	25	];
	accident_date			:=	ds_FLaccidents.data_[	26	..	33	];
	county_nbr				:=	ds_FLaccidents.data_[	34	..	35	];
	city_nbr				:=	ds_FLaccidents.data_[	36	..	37	];
	ft_city_town			:=	ds_FLaccidents.data_[	38	..	41	];
	miles_city_town			:=	ds_FLaccidents.data_[	42	..	45	];
	direction_city_town		:=	ds_FLaccidents.data_[	46	..	46	];
	city_town_name			:=	ds_FLaccidents.data_[	47	..	63	];
	county_name				:=	ds_FLaccidents.data_[	64	..	75	];
	at_node_nbr				:=	ds_FLaccidents.data_[	76	..	80	];
	ft_from_node			:=	ds_FLaccidents.data_[	81	..	84	];
	miles_from_node			:=	ds_FLaccidents.data_[	85	..	88	];
	from_node_nbr			:=	ds_FLaccidents.data_[	89	..	93	];
	next_node_rdwy			:=	ds_FLaccidents.data_[	94	..	98	];
	st_road_hhwy_name		:=	ds_FLaccidents.data_[	99	..	134	];
	at_intersect_of			:=	ds_FLaccidents.data_[	135	..	170	];
	ft_from_intersect		:=	ds_FLaccidents.data_[	171	..	174	];
	miles_from_intersect	:=	ds_FLaccidents.data_[	175	..	178	];
	intersect_dir_of		:=	ds_FLaccidents.data_[	179	..	179	];
	of_intersect_of			:=	ds_FLaccidents.data_[	180	..	215	];
	codeable_noncodeable	:=	ds_FLaccidents.data_[	216	..	216	];
	type_fr_case			:=	ds_FLaccidents.data_[	217	..	217	];
	action_code				:=	ds_FLaccidents.data_[	218	..	218	];
	filler2					:=	ds_FLaccidents.data_[	219	..	219	];
	dot_type_facility		:=	ds_FLaccidents.data_[	220	..	220	];
	dot_road_type			:=	ds_FLaccidents.data_[	221	..	221	];
	dot_nbr_lanes			:=	ds_FLaccidents.data_[	222	..	223	];
	dot_site_loc			:=	ds_FLaccidents.data_[	224	..	225	];
	dot_district_ind		:=	ds_FLaccidents.data_[	226	..	226	];
	dot_county				:=	ds_FLaccidents.data_[	227	..	228	];
	dot_section_nbr			:=	ds_FLaccidents.data_[	229	..	231	];
	dot_skid_resistance		:=	ds_FLaccidents.data_[	232	..	233	];
	dot_friction_coarse		:=	ds_FLaccidents.data_[	234	..	234	];
	dot_avg_daily_traffic	:=	ds_FLaccidents.data_[	235	..	240	];
	dot_node_nbr			:=	ds_FLaccidents.data_[	241	..	245	];
	dot_distance_node		:=	ds_FLaccidents.data_[	246	..	250	];
	dot_dir_from_node		:=	ds_FLaccidents.data_[	251	..	251	];
	dot_st_road_nbr			:=	ds_FLaccidents.data_[	252	..	257	];
	dot_us_road_nbr			:=	ds_FLaccidents.data_[	258	..	262	];
	dot_milepost			:=	ds_FLaccidents.data_[	263	..	268	];
	dot_hhwy_loc			:=	ds_FLaccidents.data_[	269	..	269	];
	dot_subsection			:=	ds_FLaccidents.data_[	270	..	272	];
	dot_system_type			:=	ds_FLaccidents.data_[	273	..	273	];
	dot_travelway			:=	ds_FLaccidents.data_[	274	..	274	];
	dot_node_type			:=	ds_FLaccidents.data_[	275	..	276	];
	dot_fixture_type		:=	ds_FLaccidents.data_[	277	..	278	];
	dot_side_of_road		:=	ds_FLaccidents.data_[	279	..	279	];
	dot_accident_severity	:=	ds_FLaccidents.data_[	280	..	280	];
	dot_lane_id				:=	ds_FLaccidents.data_[	281	..	281	];
	filler3					:=	ds_FLaccidents.data_[	282	..	379	];
	dhsmv_veh_crash_ind		:=	ds_FLaccidents.data_[	380	..	380	];
	acc_key_online_update	:=	ds_FLaccidents.data_[	381	..	395	];
	form_type				:=	ds_FLaccidents.data_[	396	..	396	];
	update_nbr				:=	ds_FLaccidents.data_[	397	..	398	];
	accident_error			:=	ds_FLaccidents.data_[	399	..	399	];
end;

ds_FLCrash0_in		:=	table(ds_FLaccidents(rec_type='0'),r_FLCrash0_in);

ds_srtd_ddup_out	:= dedup(sort(distribute(ds_FLCrash0_in,hash(accident_nbr))
												,rec_type_0
												,accident_nbr
												,filler1
												,microfilm_nbr
												,st_road_accident
												,accident_date
												,county_nbr
												,city_nbr
												,ft_city_town
												,miles_city_town
												,direction_city_town
												,city_town_name
												,county_name
												,at_node_nbr
												,from_node_nbr
												,next_node_rdwy
												,st_road_hhwy_name
												,at_intersect_of
												,intersect_dir_of
												,of_intersect_of
												,codeable_noncodeable
												,type_fr_case
												,action_code
												,filler2
												,dot_type_facility
												,dot_road_type
												,dot_nbr_lanes
												,dot_site_loc
												,dot_district_ind
												,dot_county
												,dot_section_nbr
												,dot_skid_resistance
												,dot_friction_coarse
												,dot_avg_daily_traffic
												,dot_node_nbr
												,dot_distance_node
												,dot_dir_from_node
												,dot_st_road_nbr
												,dot_us_road_nbr
												,dot_milepost
												,dot_hhwy_loc
												,dot_subsection
												,dot_system_type
												,dot_travelway
												,dot_node_type
												,dot_fixture_type
												,dot_side_of_road
												,dot_accident_severity
												,dot_lane_id
												,filler3
												,dhsmv_veh_crash_ind
												,acc_key_online_update
												,form_type
												,update_nbr
												,accident_error
												,local),local);


EXPORT FLCrash0_layout  := ds_srtd_ddup_out;


//flcrash1 accident char	#############################################
r_FLCrash1_in		:=	record
	rec_type_1					:=	ds_FLaccidents.rec_type[	1	..	1	];
	accident_nbr				:=	ds_FLaccidents.data_[	1	..	9	];
	filler1						:=	ds_FLaccidents.data_[	10	..	13	];
	day_week					:=	ds_FLaccidents.data_[	14	..	14	];
	hr_accident					:=	ds_FLaccidents.data_[	15	..	16	];
	min_accident				:=	ds_FLaccidents.data_[	17	..	18	];
	accident_am_pm				:=	ds_FLaccidents.data_[	19	..	19	];
	hr_off_notified				:=	ds_FLaccidents.data_[	20	..	21	];
	min_off_notified			:=	ds_FLaccidents.data_[	22	..	23	];
	notified_am_pm				:=	ds_FLaccidents.data_[	24	..	24	];
	hr_off_arrived				:=	ds_FLaccidents.data_[	25	..	26	];
	min_off_arrived				:=	ds_FLaccidents.data_[	27	..	28	];
	arrived_am_pm				:=	ds_FLaccidents.data_[	29	..	29	];
	filler_old_county_nbr		:=	ds_FLaccidents.data_[	30	..	31	];
	filler_old_city_nbr			:=	ds_FLaccidents.data_[	32	..	33	];
	pop_code					:=	ds_FLaccidents.data_[	34	..	34	];
	rural_urban_code			:=	ds_FLaccidents.data_[	35	..	35	];
	site_loc						:=	ds_FLaccidents.data_[	36	..	37	];
	filler_old_first_harmful_event	:=	ds_FLaccidents.data_[	38	..	39	];
	filler_old_subs_harmful_event	:=	ds_FLaccidents.data_[	40	..	41	];
	on_off_roadway				:=	ds_FLaccidents.data_[	42	..	42	];
	light_condition				:=	ds_FLaccidents.data_[	43	..	44	];
	weather						:=	ds_FLaccidents.data_[	45	..	46	];
	rd_surface_type				:=	ds_FLaccidents.data_[	47	..	48	];
	type_shoulder				:=	ds_FLaccidents.data_[	49	..	50	];
	rd_condition_primary		:=	ds_FLaccidents.data_[	51	..	52	];
	rd_condition_secondary		:=	ds_FLaccidents.data_[	53	..	54	];
	vision_obstructed_primary	:=	ds_FLaccidents.data_[	55	..	56	];
	vision_obstructed_secondary	:=	ds_FLaccidents.data_[	57	..	58	];
	first_traffic_control		:=	ds_FLaccidents.data_[	59	..	60	];
	second_traffic_control		:=	ds_FLaccidents.data_[	61	..	62	];
	trafficway_char				:=	ds_FLaccidents.data_[	63	..	64	];
	nbr_lanes					:=	ds_FLaccidents.data_[	65	..	66	];
	divided_undivided			:=	ds_FLaccidents.data_[	67	..	67	];
	rd_sys_id					:=	ds_FLaccidents.data_[	68	..	69	];
	invest_agency				:=	ds_FLaccidents.data_[	70	..	70	];
	stuff						:=	ds_FLaccidents.data_[	71	..	72	];
	accident_injury_severity	:=	ds_FLaccidents.data_[	73	..	73	];
	accident_damage_severity	:=	ds_FLaccidents.data_[	74	..	74	];
	accident_insur_code			:=	ds_FLaccidents.data_[	75	..	75	];
	accident_fault_code			:=	ds_FLaccidents.data_[	76	..	76	];
	alcohol_drug				:=	ds_FLaccidents.data_[	77	..	77	];
	total_tar_damage			:=	ds_FLaccidents.data_[	78	..	84	];
	total_vehicle_damage		:=	ds_FLaccidents.data_[	85	..	91	];
	total_prop_damage_amt		:=	ds_FLaccidents.data_[	92	..	98	];
	total_nbr_persons			:=	ds_FLaccidents.data_[	99	..	102	];
	total_nbr_drivers			:=	ds_FLaccidents.data_[	103	..	104	];
	total_nbr_vehicles			:=	ds_FLaccidents.data_[	105	..	106	];
	total_nbr_fatalities		:=	ds_FLaccidents.data_[	107	..	109	];
	total_nbr_non_traffic_fatal	:=	ds_FLaccidents.data_[	110	..	111	];
	total_nbr_injuries			:=	ds_FLaccidents.data_[	112	..	114	];
	total_nbr_pedestrian		:=	ds_FLaccidents.data_[	115	..	116	];
	total_nbr_pedalcyclist		:=	ds_FLaccidents.data_[	117	..	118	];
	invest_agy_rpt_nbr			:=	ds_FLaccidents.data_[	119	..	133	];
	invest_name					:=	ds_FLaccidents.data_[	134	..	158	];
	filler2						:=	ds_FLaccidents.data_[	159	..	171	];
	invest_rank					:=	ds_FLaccidents.data_[	172	..	175	];
	invest_id_badge_nbr			:=	ds_FLaccidents.data_[	176	..	181	];
	dept_name					:=	ds_FLaccidents.data_[	182	..	206	];
	invest_maede				:=	ds_FLaccidents.data_[	207	..	207	];
	invest_complete				:=	ds_FLaccidents.data_[	208	..	208	];
	report_date					:=	ds_FLaccidents.data_[	209	..	214	];
	photos_taken				:=	ds_FLaccidents.data_[	215	..	215	];
	photos_taken_whom			:=	ds_FLaccidents.data_[	216	..	216	];
	first_aid_name				:=	ds_FLaccidents.data_[	217	..	241	];
	filler3						:=	ds_FLaccidents.data_[	242	..	257	];
	first_aid_person_type		:=	ds_FLaccidents.data_[	258	..	258	];
	injured_taken_to			:=	ds_FLaccidents.data_[	259	..	299	];
	injured_taken_by			:=	ds_FLaccidents.data_[	300	..	324	];
	type_driver_accident		:=	ds_FLaccidents.data_[	325	..	325	];
	hr_ems_notified				:=	ds_FLaccidents.data_[	326	..	327	];
	min_ems_notified			:=	ds_FLaccidents.data_[	328	..	329	];
	ems_notified_am_pm			:=	ds_FLaccidents.data_[	330	..	330	];
	hr_ems_arrived				:=	ds_FLaccidents.data_[	331	..	332	];
	min_ems_arrived				:=	ds_FLaccidents.data_[	333	..	334	];
	ems_arrived_am_pm			:=	ds_FLaccidents.data_[	335	..	335	];
	injured_taken_to_code		:=	ds_FLaccidents.data_[	336	..	336	];
	location_type				:=	ds_FLaccidents.data_[	337	..	337	];
	filler4						:=	ds_FLaccidents.data_[	338	..	399	];
end;

ds_FLCrash1_in		:=	table(ds_FLaccidents(rec_type='1'),r_FLCrash1_in);

ds_srtd_ddup_out	:= dedup(sort(distribute(ds_FLCrash1_in,hash(accident_nbr))
												,rec_type_1
												,accident_nbr
												,filler1
												,day_week
												,hr_accident
												,min_accident
												,accident_am_pm
												,hr_off_notified
												,min_off_notified
												,notified_am_pm
												,hr_off_arrived
												,min_off_arrived
												,arrived_am_pm
												,filler_old_county_nbr
												,filler_old_city_nbr
												,pop_code
												,rural_urban_code
												,site_loc
												,filler_old_first_harmful_event
												,filler_old_subs_harmful_event
												,on_off_roadway
												,light_condition
												,weather
												,rd_surface_type
												,type_shoulder
												,rd_condition_primary
												,rd_condition_secondary
												,vision_obstructed_primary
												,vision_obstructed_secondary
												,first_traffic_control
												,second_traffic_control
												,trafficway_char
												,nbr_lanes
												,divided_undivided
												,rd_sys_id
												,invest_agency
												,stuff
												,accident_injury_severity
												,accident_damage_severity
												,accident_insur_code
												,accident_fault_code
												,alcohol_drug
												,total_tar_damage
												,total_vehicle_damage
												,total_prop_damage_amt
												,total_nbr_persons
												,total_nbr_drivers
												,total_nbr_vehicles
												,total_nbr_fatalities
												,total_nbr_non_traffic_fatal
												,total_nbr_injuries
												,total_nbr_pedestrian
												,total_nbr_pedalcyclist
												,invest_agy_rpt_nbr
												,invest_name
												,filler2
												,invest_rank
												,invest_id_badge_nbr
												,dept_name
												,invest_maede
												,invest_complete
												,report_date
												,photos_taken
												,photos_taken_whom
												,first_aid_name
												,filler3
												,first_aid_person_type
												,injured_taken_to
												,injured_taken_by
												,type_driver_accident
												,hr_ems_notified
												,min_ems_notified
												,ems_notified_am_pm
												,hr_ems_arrived
												,min_ems_arrived
												,ems_arrived_am_pm
												,injured_taken_to_code
												,location_type
												,filler4
												,local),local);

EXPORT FLCrash1_layout  := ds_srtd_ddup_out;

//flcrash2 vehicle		#############################################
r_FLCrash2a_in		:=	record
	rec_type_2				:=	ds_FLaccidents.rec_type[	1	..	1	];
	accident_nbr			:=	ds_FLaccidents.data_[	1	..	9	];
	section_nbr				:=	ds_FLaccidents.data_[	10	..	11	];
	filler1					:=	ds_FLaccidents.data_[	12	..	13	];
	vehicle_owner_driver_code	:=	ds_FLaccidents.data_[	14	..	14	];
	vehicle_driver_action	:=	ds_FLaccidents.data_[	15	..	15	];
	vehicle_year			:=	ds_FLaccidents.data_[	16	..	19	];
	vehicle_make			:=	ds_FLaccidents.data_[	20	..	23	];
	vehicle_type			:=	ds_FLaccidents.data_[	24	..	25	];
	vehicle_tag_nbr			:=	ds_FLaccidents.data_[	26	..	35	];
	vehicle_reg_state		:=	ds_FLaccidents.data_[	36	..	37	];
	vehicle_id_nbr			:=	ds_FLaccidents.data_[	38	..	59	];
	vehicle_travel_on		:=	ds_FLaccidents.data_[	60	..	95	];
	direction_travel		:=	ds_FLaccidents.data_[	96	..	96	];
	est_vehicle_speed		:=	ds_FLaccidents.data_[	97	..	99	];
	posted_speed			:=	ds_FLaccidents.data_[	100	..	101	];
	est_vehicle_damage		:=	ds_FLaccidents.data_[	102	..	108	];
	damage_type				:=	ds_FLaccidents.data_[	109	..	109	];
	ins_company_name		:=	ds_FLaccidents.data_[	110	..	150	];
	ins_policy_nbr			:=	ds_FLaccidents.data_[	151	..	175	];
	vehicle_removed_by		:=	ds_FLaccidents.data_[	176	..	200	];
	how_removed_code		:=	ds_FLaccidents.data_[	201	..	201	];
	vehicle_owner_firstname	:=	ds_FLaccidents.data_[	202	..	214	];
	vehicle_owner_middle_int	:=	ds_FLaccidents.data_[	215	..	215	];
	vehicle_owner_lastname	:=	ds_FLaccidents.data_[	216	..	240	];
	work_area				:=	ds_FLaccidents.data_[	241	..	242	];
	vehicle_owner_suffix	:=	ds_FLaccidents.data_[	243	..	243	];
	vehicle_owner_address	:=	ds_FLaccidents.data_[	244	..	269	];
	vehicle_owner_city		:=	ds_FLaccidents.data_[	270	..	283	];
	filler3					:=	ds_FLaccidents.data_[	284	..	301	];
	vehicle_owner_st		:=	ds_FLaccidents.data_[	302	..	303	];
	vehicle_owner_zip		:=	ds_FLaccidents.data_[	304	..	312	];
	vehicle_owner_forge_asterisk	:=	ds_FLaccidents.data_[	313	..	313	];
	vehicle_owner_dl_nbr	:=	ds_FLaccidents.data_[	314	..	328	];
	vehicle_owner_dob		:=	ds_FLaccidents.data_[	329	..	336	];
	vehicle_owner_sex		:=	ds_FLaccidents.data_[	337	..	337	];
	vehicle_owner_race		:=	ds_FLaccidents.data_[	338	..	338	];
	point_of_impact			:=	ds_FLaccidents.data_[	339	..	340	];
	vehicle_movement		:=	ds_FLaccidents.data_[	341	..	342	];
	vehicle_function   		:=	ds_FLaccidents.data_[	343	..	343	];
	filler4					:=	ds_FLaccidents.data_[	344	..	344	];
	vehs_first_defect		:=	ds_FLaccidents.data_[	345	..	346	];
	vehs_second_defect		:=	ds_FLaccidents.data_[	347	..	348	];
	vehicle_modified		:=	ds_FLaccidents.data_[	349	..	350	];
	vehicle_roadway_loc		:=	ds_FLaccidents.data_[	351	..	352	];
	hazard_material_transport	:=	ds_FLaccidents.data_[	353	..	353	];
	total_occu_vehicle		:=	ds_FLaccidents.data_[	354	..	356	];
	total_occu_saf_equip	:=	ds_FLaccidents.data_[	357	..	359	];
	moving_violation		:=	ds_FLaccidents.data_[	360	..	360	];
	vehicle_insur_code		:=	ds_FLaccidents.data_[	361	..	361	];
	vehicle_fault_code		:=	ds_FLaccidents.data_[	362	..	362	];
	vehicle_cap_code		:=	ds_FLaccidents.data_[	363	..	364	];
	vehicle_fr_code			:=	ds_FLaccidents.data_[	365	..	365	];
	vehicle_use				:=	ds_FLaccidents.data_[	366	..	367	];
	placarded				:=	ds_FLaccidents.data_[	368	..	368	];
	dhsmv_vehicle_ind		:=	ds_FLaccidents.data_[	369	..	369	];
	placard_name_numer		:=	ds_FLaccidents.data_[	370	..	386	];
	DHSMV					:=	ds_FLaccidents.data_[	387	..	387	];
	event_1					:=	ds_FLaccidents.data_[	388	..	389	];
	event_2					:=	ds_FLaccidents.data_[	390	..	391	];
	event_3					:=	ds_FLaccidents.data_[	392	..	393	];
	event_4					:=	ds_FLaccidents.data_[	394	..	395	];
	filler_spaces			:=	ds_FLaccidents.data_[	396	..	399	];
end;

ds_FLCrash2a_in		:=	table(ds_FLaccidents(rec_type='2'),r_FLCrash2a_in);

r_FLCrash2b_in		:=	record
	ds_FLCrash2a_in;

	string10 prim_range;
	string2 predir;
	string28 prim_name;
	string4 addr_suffix;
	string2 postdir;
	string10 unit_desig;
	string8 sec_range;
	string25 p_city_name;
	string25 v_city_name;
	string2 st;
	string5 zip;
	string4 zip4;
	string4 cart;
	string1 cr_sort_sz;
	string4 lot;
	string1 lot_order;
	string2 dpbc;
	string1 chk_digit;
	string2 rec_type;
	string2 ace_fips_st;
	string3 county;
	string10 geo_lat;
	string11 geo_long;
	string4 msa;
	string7 geo_blk;
	string1 geo_match;
	string4 err_stat;

	string5 title;
	string20 fname;
	string20 mname;
	string20 lname;
	string5 suffix;
	string3 score;

	string25	cname;
end;

r_FLCrash2b_in	tr_FLCrash2b_in(ds_FLCrash2a_in le) := transform

	string182	address_	:=			le.vehicle_owner_city
								+ ' ' + le.vehicle_owner_st
								+ ' ' + le.vehicle_owner_zip;

	string182	caddress_	:=	AddrCleanLib.CleanAddress182(le.vehicle_owner_address,address_);

	string73	name_		:=			le.vehicle_owner_firstname
								+ ' ' +	le.vehicle_owner_middle_int
								+ ' ' +	le.vehicle_owner_lastname
								+ ' ';

	string73	cname		:=	if(le.vehicle_owner_suffix <> 'C',AddrCleanLib.CleanPersonFML73(name_),'');

	string73	cname_		:=	map(le.vehicle_owner_suffix = 'J'	=> cname[1..65] + 'JR   ' + cname[71..73],
									le.vehicle_owner_suffix = 'S'	=> cname[1..65] + 'SR   ' + cname[71..73],
									le.vehicle_owner_suffix = '1'	=> cname[1..65] + 'I    ' + cname[71..73],
									le.vehicle_owner_suffix = '2'	=> cname[1..65] + 'II   ' + cname[71..73],
									le.vehicle_owner_suffix = '3'	=> cname[1..65] + 'III  ' + cname[71..73],
									le.vehicle_owner_suffix = '4'	=> cname[1..65] + 'IV   ' + cname[71..73],
									le.vehicle_owner_suffix = 'C'	=> cname[1..65] + '     ' + cname[71..73],
									cname[1..65] + (string5)le.vehicle_owner_suffix + cname[71..73]);

	self.prim_range		:= caddress_[	1	..	10	];
	self.predir			:= caddress_[	11	..	12	];
	self.prim_name		:= caddress_[	13	..	40	];
	self.addr_suffix	:= caddress_[	41	..	44	];
	self.postdir		:= caddress_[	45	..	46	];
	self.unit_desig		:= caddress_[	47	..	56	];
	self.sec_range		:= caddress_[	57	..	64	];
	self.p_city_name	:= caddress_[	65	..	89	];
	self.v_city_name	:= caddress_[	90	..	114	];
	self.st				:= caddress_[	115	..	116	];
	self.zip			:= caddress_[	117	..	121	];
	self.zip4			:= caddress_[	122	..	125	];
	self.cart			:= caddress_[	126	..	129	];
	self.cr_sort_sz		:= caddress_[	130	..	130	];
	self.lot			:= caddress_[	131	..	134	];
	self.lot_order		:= caddress_[	135	..	135	];
	self.dpbc			:= caddress_[	136	..	137	];
	self.chk_digit		:= caddress_[	138	..	138	];
	self.rec_type		:= caddress_[	139	..	140	];
	self.ace_fips_st	:= caddress_[	141	..	142	];
	self.county			:= caddress_[	143	..	145	];
	self.geo_lat		:= caddress_[	146	..	155	];
	self.geo_long		:= caddress_[	156	..	166	];
	self.msa			:= caddress_[	167	..	170	];
	self.geo_blk		:= caddress_[	171	..	177	];
	self.geo_match		:= caddress_[	178	..	178	];
	self.err_stat		:= caddress_[	179	..	182	];

	self.title	:= cname_[	1	..	5	];
	self.fname	:= cname_[	6	..	25	];
	self.mname	:= cname_[	26	..	45	];
	self.lname	:= cname_[	46	..	65	];
	self.suffix	:= cname_[	66	..	70	];
	self.score	:= cname_[	71	..	73	];

	self.cname			:=	if(le.vehicle_owner_suffix = 'C',le.vehicle_owner_lastname,'');

	self   				:= le;

end;

ds_FLCrash2b_in := project(ds_FLCrash2a_in,tr_FLCrash2b_in(left));

ds_srtd_ddup_out	:= dedup(sort(distribute(ds_FLCrash2b_in,hash(accident_nbr))
											,rec_type_2
											,accident_nbr
											,section_nbr
											,filler1
											,vehicle_owner_driver_code
											,vehicle_driver_action
											,vehicle_year
											,vehicle_make
											,vehicle_type
											,vehicle_tag_nbr
											,vehicle_reg_state
											,vehicle_id_nbr
											,vehicle_travel_on
											,direction_travel
											,est_vehicle_speed
											,posted_speed
											,est_vehicle_damage
											,damage_type
											,ins_company_name
											,ins_policy_nbr
											,vehicle_removed_by
											,how_removed_code
											,vehicle_owner_firstname
											,vehicle_owner_middle_int
											,vehicle_owner_lastname
											,work_area
											,vehicle_owner_suffix
											,vehicle_owner_address
											,vehicle_owner_city
											,filler3
											,vehicle_owner_st
											,vehicle_owner_zip
											,vehicle_owner_forge_asterisk
											,vehicle_owner_dl_nbr
											,vehicle_owner_dob
											,vehicle_owner_sex
											,vehicle_owner_race
											,point_of_impact
											,vehicle_movement
											,vehicle_function
											,filler4
											,vehs_first_defect
											,vehs_second_defect
											,vehicle_modified
											,vehicle_roadway_loc
											,hazard_material_transport
											,total_occu_vehicle
											,total_occu_saf_equip
											,moving_violation
											,vehicle_insur_code
											,vehicle_fault_code
											,vehicle_cap_code
											,vehicle_fr_code
											,vehicle_use
											,placarded
											,dhsmv_vehicle_ind
											,placard_name_numer
											,DHSMV
											,event_1
											,event_2
											,event_3
											,event_4
											,filler_spaces
											,local),local);

EXPORT FLCrash2_layout  := ds_srtd_ddup_out;


//flcrash3 towed trailer_veh		#############################################
r_FLCrash3_in		:=	record
	rec_type_3					:=	ds_FLaccidents.rec_type[	1	..	1	];
	accident_nbr				:=	ds_FLaccidents.data_[	1	..	9	];
	section_nbr					:=	ds_FLaccidents.data_[	10	..	11	];
	filler1						:=	ds_FLaccidents.data_[	12	..	13	];
	towed_trlr_veh_yr			:=	ds_FLaccidents.data_[	14	..	17	];
	towed_trlr_make				:=	ds_FLaccidents.data_[	18	..	21	];
	towed_trailer_type			:=	ds_FLaccidents.data_[	22	..	23	];
	towed_trlr_veh_tag_nbr		:=	ds_FLaccidents.data_[	24	..	33	];
	towed_trlr_veh_state		:=	ds_FLaccidents.data_[	34	..	35	];
	towed_trlr_veh_id_nbr		:=	ds_FLaccidents.data_[	36	..	57	];
	towed_trlr_veh_est_damage	:=	ds_FLaccidents.data_[	58	..	64	];
	towed_trlr_veh_owner_name	:=	ds_FLaccidents.data_[	65	..	77	];
	middle_int					:=	ds_FLaccidents.data_[	78	..	78	];
	last_name					:=	ds_FLaccidents.data_[	79	..	103	];
	filler2						:=	ds_FLaccidents.data_[	104	..	105	];
	towed_trlr_veh_owner_name_suffix	:=	ds_FLaccidents.data_[	106	..	106	];
	towed_trlr_veh_owner_st_city		:=	ds_FLaccidents.data_[	107	..	132	];
	owner_city					:=	ds_FLaccidents.data_[	133	..	146	];
	filler3						:=	ds_FLaccidents.data_[	147	..	164	];
	towed_trlr_veh_owner_st		:=	ds_FLaccidents.data_[	165	..	166	];
	towed_trlr_veh_owner_zip	:=	ds_FLaccidents.data_[	167	..	175	];
	towed_trlr_fr_cap_code		:=	ds_FLaccidents.data_[	176	..	177	];
	filler4						:=	ds_FLaccidents.data_[	178	..	399	];
end;

ds_FLCrash3_in		:=	table(ds_FLaccidents(rec_type='3'),r_FLCrash3_in);

ds_srtd_ddup_out	:= dedup(sort(distribute(ds_FLCrash3_in,hash(accident_nbr))
												,rec_type_3
												,accident_nbr
												,section_nbr
												,filler1
												,towed_trlr_veh_yr
												,towed_trlr_make
												,towed_trailer_type
												,towed_trlr_veh_tag_nbr
												,towed_trlr_veh_state
												,towed_trlr_veh_id_nbr
												,towed_trlr_veh_est_damage
												,towed_trlr_veh_owner_name
												,filler2
												,towed_trlr_veh_owner_name_suffix
												,towed_trlr_veh_owner_st_city
												,filler3
												,towed_trlr_veh_owner_st
												,towed_trlr_veh_owner_zip
												,towed_trlr_fr_cap_code
												,filler4
												,local),local);

EXPORT FLCrash3_layout  := ds_srtd_ddup_out;

//flcrash4 driver		#############################################
r_FLCrash4a_in		:=	record
	rec_type_4					:=	ds_FLaccidents.rec_type[	1	..	1	];
	accident_nbr				:=	ds_FLaccidents.data_[	1	..	9	];
	section_nbr					:=	ds_FLaccidents.data_[	10	..	11	];
	filler1						:=	ds_FLaccidents.data_[	12	..	13	];
	driver_first_name			:=	ds_FLaccidents.data_[	14	..	26	];
	middle_int					:=	ds_FLaccidents.data_[	27	..	27	];
	last_name					:=	ds_FLaccidents.data_[	28	..	52	];
	filler2						:=	ds_FLaccidents.data_[	53	..	54	];
	driver_name_suffix			:=	ds_FLaccidents.data_[	55	..	55	];
	driver_address				:=	ds_FLaccidents.data_[	56	..	81	];
	driver_st_city				:=	ds_FLaccidents.data_[	82	..	95	];
	filler3						:=	ds_FLaccidents.data_[	96	..	113	];
	driver_resident_state		:=	ds_FLaccidents.data_[	114	..	115	];
	driver_zip					:=	ds_FLaccidents.data_[	116	..	124	];
	driver_dob					:=	ds_FLaccidents.data_[	125	..	132	];
	driver_dl_force_asterisk	:=	ds_FLaccidents.data_[	133	..	133	];
	driver_dl_nbr				:=	ds_FLaccidents.data_[	134	..	158	];
	driver_lic_st				:=	ds_FLaccidents.data_[	159	..	160	];
	driver_lic_type				:=	ds_FLaccidents.data_[	161	..	161	];
	driver_bac_test_type		:=	ds_FLaccidents.data_[	162	..	162	];
	driver_bac_force_code		:=	ds_FLaccidents.data_[	163	..	163	];
	driver_bac_test_results		:=	ds_FLaccidents.data_[	164	..	166	];
	filler4						:=	ds_FLaccidents.data_[	167	..	168	];
	driver_alco_drug_code		:=	ds_FLaccidents.data_[	169	..	169	];
	driver_physical_defects		:=	ds_FLaccidents.data_[	170	..	170	];
	driver_residence			:=	ds_FLaccidents.data_[	171	..	171	];
	driver_race					:=	ds_FLaccidents.data_[	172	..	172	];
	driver_sex					:=	ds_FLaccidents.data_[	173	..	173	];
	driver_injury_severity		:=	ds_FLaccidents.data_[	174	..	174	];
	first_driver_safety			:=	ds_FLaccidents.data_[	175	..	175	];
	second_driver_safety		:=	ds_FLaccidents.data_[	176	..	176	];
	driver_eject_code			:=	ds_FLaccidents.data_[	177	..	177	];
	recommand_reexam			:=	ds_FLaccidents.data_[	178	..	178	];
	driver_phone_nbr			:=	ds_FLaccidents.data_[	179	..	188	];
	first_contrib_cause			:=	ds_FLaccidents.data_[	189	..	190	];
	second_contrib_cause		:=	ds_FLaccidents.data_[	191	..	192	];
	third_contrib_cause			:=	ds_FLaccidents.data_[	193	..	194	];
	first_offense_charged		:=	ds_FLaccidents.data_[	195	..	202	];
	first_frdl_sys_charge_code	:=	ds_FLaccidents.data_[	203	..	204	];
	second_offense_charged		:=	ds_FLaccidents.data_[	205	..	212	];
	second_frdl_sys_charge_code	:=	ds_FLaccidents.data_[	213	..	214	];
	third_offense_charged		:=	ds_FLaccidents.data_[	215	..	222	];
	third_frdl_sys_charge_code	:=	ds_FLaccidents.data_[	223	..	224	];
	first_citation_nbr			:=	ds_FLaccidents.data_[	225	..	231	];
	second_citation_nbr			:=	ds_FLaccidents.data_[	232	..	238	];
	third_citation_nbr			:=	ds_FLaccidents.data_[	239	..	245	];
	driver_fr_injury_cap_code	:=	ds_FLaccidents.data_[	246	..	247	];
	dl_nbr_good_bad				:=	ds_FLaccidents.data_[	248	..	248	];
	fourth_offense_charged		:=	ds_FLaccidents.data_[	249	..	256	];
	fourth_frdl_sys_charge_code	:=	ds_FLaccidents.data_[	257	..	258	];
	fifth_offense_charged		:=	ds_FLaccidents.data_[	259	..	266	];
	fifth_frdl_sys_charge_code	:=	ds_FLaccidents.data_[	267	..	268	];
	sixth_offense_charged		:=	ds_FLaccidents.data_[	269	..	276	];
	sixth_frdl_sys_charge_code	:=	ds_FLaccidents.data_[	277	..	278	];
	seveth_offense_charged		:=	ds_FLaccidents.data_[	279	..	286	];
	seveth_frdl_sys_charge_code	:=	ds_FLaccidents.data_[	287	..	288	];
	eighth_offense_charged		:=	ds_FLaccidents.data_[	289	..	296	];
	eighth_frdl_sys_charge_code	:=	ds_FLaccidents.data_[	297	..	298	];
	fourth_citation_nbr			:=	ds_FLaccidents.data_[	299	..	305	];
	fifth_citation_nbr			:=	ds_FLaccidents.data_[	306	..	312	];
	sixth_citation_nbr			:=	ds_FLaccidents.data_[	313	..	319	];
	seventh_citation_nbr		:=	ds_FLaccidents.data_[	320	..	326	];
	eighth_citation_nbr			:=	ds_FLaccidents.data_[	327	..	333	];
	req_endorsement				:=	ds_FLaccidents.data_[	334	..	334	];
	oos_dl_nbr					:=	ds_FLaccidents.data_[	335	..	359	];
	filler5						:=	ds_FLaccidents.data_[	360	..	399	];
end;

ds_FLCrash4a_in		:=	table(ds_FLaccidents(rec_type='4'),r_FLCrash4a_in);

r_FLCrash4b_in		:=	record
	ds_FLCrash4a_in;

	string10 prim_range;
	string2 predir;
	string28 prim_name;
	string4 addr_suffix;
	string2 postdir;
	string10 unit_desig;
	string8 sec_range;
	string25 p_city_name;
	string25 v_city_name;
	string2 st;
	string5 zip;
	string4 zip4;
	string4 cart;
	string1 cr_sort_sz;
	string4 lot;
	string1 lot_order;
	string2 dpbc;
	string1 chk_digit;
	string2 rec_type;
	string2 ace_fips_st;
	string3 county;
	string10 geo_lat;
	string11 geo_long;
	string4 msa;
	string7 geo_blk;
	string1 geo_match;
	string4 err_stat;

	string5 title;
	string20 fname;
	string20 mname;
	string20 lname;
	string5 suffix;
	string3 score;

	string25	cname;
end;

r_FLCrash4b_in	tr_FLCrash4b_in(ds_FLCrash4a_in le) := transform

	string182	address_	:=			le.driver_st_city
								+ ' ' + le.driver_resident_state
								+ ' ' + le.driver_zip;

	string182	caddress_	:=	AddrCleanLib.CleanAddress182(le.driver_address,address_);

	string73	name_		:=			le.driver_first_name
								+ ' ' +	le.middle_int
								+ ' ' +	le.last_name
								+ ' ';

	string73	cname		:=	if(le.driver_name_suffix <> 'C',AddrCleanLib.CleanPersonFML73(name_),'');

	string73	cname_		:=	map(le.driver_name_suffix = 'J'	=> cname[1..65] + 'JR   ' + cname[71..73],
									le.driver_name_suffix = 'S'	=> cname[1..65] + 'SR   ' + cname[71..73],
									le.driver_name_suffix = '1'	=> cname[1..65] + 'I    ' + cname[71..73],
									le.driver_name_suffix = '2'	=> cname[1..65] + 'II   ' + cname[71..73],
									le.driver_name_suffix = '3'	=> cname[1..65] + 'III  ' + cname[71..73],
									le.driver_name_suffix = '4'	=> cname[1..65] + 'IV   ' + cname[71..73],
									le.driver_name_suffix = 'C'	=> cname[1..65] + '     ' + cname[71..73],
									cname[1..65] + (string5)le.driver_name_suffix + cname[71..73]);

	self.prim_range		:= caddress_[	1	..	10	];
	self.predir			:= caddress_[	11	..	12	];
	self.prim_name		:= caddress_[	13	..	40	];
	self.addr_suffix	:= caddress_[	41	..	44	];
	self.postdir		:= caddress_[	45	..	46	];
	self.unit_desig		:= caddress_[	47	..	56	];
	self.sec_range		:= caddress_[	57	..	64	];
	self.p_city_name	:= caddress_[	65	..	89	];
	self.v_city_name	:= caddress_[	90	..	114	];
	self.st				:= caddress_[	115	..	116	];
	self.zip			:= caddress_[	117	..	121	];
	self.zip4			:= caddress_[	122	..	125	];
	self.cart			:= caddress_[	126	..	129	];
	self.cr_sort_sz		:= caddress_[	130	..	130	];
	self.lot			:= caddress_[	131	..	134	];
	self.lot_order		:= caddress_[	135	..	135	];
	self.dpbc			:= caddress_[	136	..	137	];
	self.chk_digit		:= caddress_[	138	..	138	];
	self.rec_type		:= caddress_[	139	..	140	];
	self.ace_fips_st	:= caddress_[	141	..	142	];
	self.county			:= caddress_[	143	..	145	];
	self.geo_lat		:= caddress_[	146	..	155	];
	self.geo_long		:= caddress_[	156	..	166	];
	self.msa			:= caddress_[	167	..	170	];
	self.geo_blk		:= caddress_[	171	..	177	];
	self.geo_match		:= caddress_[	178	..	178	];
	self.err_stat		:= caddress_[	179	..	182	];

	self.title	:= cname_[	1	..	5	];
	self.fname	:= cname_[	6	..	25	];
	self.mname	:= cname_[	26	..	45	];
	self.lname	:= cname_[	46	..	65	];
	self.suffix	:= cname_[	66	..	70	];
	self.score	:= cname_[	71	..	73	];

	self.cname			:=	if(le.driver_name_suffix  = 'C',le.last_name,'');

	self   				:= le;

end;

ds_FLCrash4b_in		:= project(ds_FLCrash4a_in,tr_FLCrash4b_in(left));

ds_srtd_ddup_out	:= dedup(sort(distribute(ds_FLCrash4b_in,hash(accident_nbr))
												,rec_type_4
												,accident_nbr
												,section_nbr
												,filler1
												,driver_first_name
												,middle_int
												,last_name
												,filler2
												,driver_name_suffix
												,driver_address
												,driver_st_city
												,filler3
												,driver_resident_state
												,driver_zip
												,driver_dob
												,driver_dl_force_asterisk
												,driver_dl_nbr
												,driver_lic_st
												,driver_lic_type
												,driver_bac_test_type
												,driver_bac_force_code
												,driver_bac_test_results
												,driver_alco_drug_code
												,driver_physical_defects
												,driver_residence
												,driver_race
												,driver_sex
												,driver_injury_severity
												,first_driver_safety
												,second_driver_safety
												,driver_eject_code
												,recommand_reexam
												,driver_phone_nbr
												,first_contrib_cause
												,second_contrib_cause
												,third_contrib_cause
												,first_offense_charged
												,first_frdl_sys_charge_code
												,second_offense_charged
												,second_frdl_sys_charge_code
												,third_offense_charged
												,third_frdl_sys_charge_code
												,first_citation_nbr
												,second_citation_nbr
												,third_citation_nbr
												,driver_fr_injury_cap_code
												,dl_nbr_good_bad
												,fourth_offense_charged
												,fourth_frdl_sys_charge_code
												,fifth_offense_charged
												,fifth_frdl_sys_charge_code
												,sixth_offense_charged
												,sixth_frdl_sys_charge_code
												,seveth_offense_charged
												,seveth_frdl_sys_charge_code
												,eighth_offense_charged
												,eighth_frdl_sys_charge_code
												,fourth_citation_nbr
												,fifth_citation_nbr
												,sixth_citation_nbr
												,seventh_citation_nbr
												,eighth_citation_nbr
												,req_endorsement
												,oos_dl_nbr
												,filler5
												,local),local);

EXPORT FLCrash4_layout  := ds_srtd_ddup_out;

//flcrash5 passenger		#############################################
r_FLCrash5a_in		:=	record
	rec_type_5				:=	ds_FLaccidents.rec_type[	1	..	1	];
	accident_nbr			:=	ds_FLaccidents.data_[	1	..	9	];
	section_nbr				:=	ds_FLaccidents.data_[	10	..	11	];
	passenger_nbr			:=	ds_FLaccidents.data_[	12	..	13	];
	passenger_first_name	:=	ds_FLaccidents.data_[	14	..	26	];
	middle_int				:=	ds_FLaccidents.data_[	27	..	27	];
	passenger_last_name		:=	ds_FLaccidents.data_[	28	..	52	];
	filler1					:=	ds_FLaccidents.data_[	53	..	54	];
	passenger_name_suffix	:=	ds_FLaccidents.data_[	55	..	55	];
	passenger_st_address	:=	ds_FLaccidents.data_[	56	..	81	];
	passenger_city			:=	ds_FLaccidents.data_[	82	..	95	];
	filler2					:=	ds_FLaccidents.data_[	96	..	113	];
	passenger_state			:=	ds_FLaccidents.data_[	114	..	115	];
	passenger_zip			:=	ds_FLaccidents.data_[	116	..	124	];
	passenger_age			:=	ds_FLaccidents.data_[	125	..	126	];
	passenger_location		:=	ds_FLaccidents.data_[	127	..	127	];
	passenger_injury_sev	:=	ds_FLaccidents.data_[	128	..	128	];
	first_passenger_safe	:=	ds_FLaccidents.data_[	129	..	129	];
	second_passenger_safe	:=	ds_FLaccidents.data_[	130	..	130	];
	passenger_eject_code	:=	ds_FLaccidents.data_[	131	..	131	];
	passenger_fr_cap_code	:=	ds_FLaccidents.data_[	132	..	133	];
	passenger_dob			:=	ds_FLaccidents.data_[	134	..	141	];
	passenger_race			:=	ds_FLaccidents.data_[	142	..	142	];
	passenger_sex			:=	ds_FLaccidents.data_[	143	..	143	];
	filler3					:=	ds_FLaccidents.data_[	144	..	399	];
end;

ds_FLCrash5a_in		:=	table(ds_FLaccidents(rec_type='5'),r_FLCrash5a_in);

r_FLCrash5b_in		:=	record
	ds_FLCrash5a_in;

	string10 prim_range;
	string2 predir;
	string28 prim_name;
	string4 addr_suffix;
	string2 postdir;
	string10 unit_desig;
	string8 sec_range;
	string25 p_city_name;
	string25 v_city_name;
	string2 st;
	string5 zip;
	string4 zip4;
	string4 cart;
	string1 cr_sort_sz;
	string4 lot;
	string1 lot_order;
	string2 dpbc;
	string1 chk_digit;
	string2 rec_type;
	string2 ace_fips_st;
	string3 county;
	string10 geo_lat;
	string11 geo_long;
	string4 msa;
	string7 geo_blk;
	string1 geo_match;
	string4 err_stat;

	string5 title;
	string20 fname;
	string20 mname;
	string20 lname;
	string5 suffix;
	string3 score;

	string25	cname;
end;

r_FLCrash5b_in	tr_FLCrash5b_in(ds_FLCrash5a_in le) := transform

	string182	address_	:=			le.passenger_city
								+ ' ' + le.passenger_state
								+ ' ' + le.passenger_zip;

	string182	caddress_	:=	AddrCleanLib.CleanAddress182(le.passenger_st_address,address_);


	string73	name_		:=			le.passenger_first_name
								+ ' ' +	le.middle_int
								+ ' ' +	le.passenger_last_name
								+ ' ';

	string73	cname		:=	if(le.passenger_name_suffix <> 'C',AddrCleanLib.CleanPersonFML73(name_),'');

	string73	cname_		:=	map(le.passenger_name_suffix = 'J'	=> cname[1..65] + 'JR   ' + cname[71..73],
									le.passenger_name_suffix = 'S'	=> cname[1..65] + 'SR   ' + cname[71..73],
									le.passenger_name_suffix = '1'	=> cname[1..65] + 'I    ' + cname[71..73],
									le.passenger_name_suffix = '2'	=> cname[1..65] + 'II   ' + cname[71..73],
									le.passenger_name_suffix = '3'	=> cname[1..65] + 'III  ' + cname[71..73],
									le.passenger_name_suffix = '4'	=> cname[1..65] + 'IV   ' + cname[71..73],
									le.passenger_name_suffix = 'C'	=> cname[1..65] + '     ' + cname[71..73],
									cname[1..65] + (string5)le.passenger_name_suffix + cname[71..73]);

	self.prim_range		:= caddress_[	1	..	10	];
	self.predir			:= caddress_[	11	..	12	];
	self.prim_name		:= caddress_[	13	..	40	];
	self.addr_suffix	:= caddress_[	41	..	44	];
	self.postdir		:= caddress_[	45	..	46	];
	self.unit_desig		:= caddress_[	47	..	56	];
	self.sec_range		:= caddress_[	57	..	64	];
	self.p_city_name	:= caddress_[	65	..	89	];
	self.v_city_name	:= caddress_[	90	..	114	];
	self.st				:= caddress_[	115	..	116	];
	self.zip			:= caddress_[	117	..	121	];
	self.zip4			:= caddress_[	122	..	125	];
	self.cart			:= caddress_[	126	..	129	];
	self.cr_sort_sz		:= caddress_[	130	..	130	];
	self.lot			:= caddress_[	131	..	134	];
	self.lot_order		:= caddress_[	135	..	135	];
	self.dpbc			:= caddress_[	136	..	137	];
	self.chk_digit		:= caddress_[	138	..	138	];
	self.rec_type		:= caddress_[	139	..	140	];
	self.ace_fips_st	:= caddress_[	141	..	142	];
	self.county			:= caddress_[	143	..	145	];
	self.geo_lat		:= caddress_[	146	..	155	];
	self.geo_long		:= caddress_[	156	..	166	];
	self.msa			:= caddress_[	167	..	170	];
	self.geo_blk		:= caddress_[	171	..	177	];
	self.geo_match		:= caddress_[	178	..	178	];
	self.err_stat		:= caddress_[	179	..	182	];

	self.title	:= cname_[	1	..	5	];
	self.fname	:= cname_[	6	..	25	];
	self.mname	:= cname_[	26	..	45	];
	self.lname	:= cname_[	46	..	65	];
	self.suffix	:= cname_[	66	..	70	];
	self.score	:= cname_[	71	..	73	];

	self.cname			:=	if(le.passenger_name_suffix  = 'C',le.passenger_last_name,'');

	self   				:= le;

end;

ds_FLCrash5b_in		:= project(ds_FLCrash5a_in,tr_FLCrash5b_in(left));

ds_srtd_ddup_out	:= dedup(sort(distribute(ds_FLCrash5b_in,hash(accident_nbr))
												,rec_type_5
												,accident_nbr
												,section_nbr
												,passenger_nbr
												,passenger_first_name
												,middle_int
												,passenger_last_name
												,filler1
												,passenger_name_suffix
												,passenger_st_address
												,passenger_city
												,filler2
												,passenger_state
												,passenger_zip
												,passenger_age
												,passenger_location
												,passenger_injury_sev
												,first_passenger_safe
												,second_passenger_safe
												,passenger_eject_code
												,passenger_fr_cap_code
												,filler3
												,local),local);

EXPORT FLCrash5_layout  := ds_srtd_ddup_out;

//flcrash6 pedestrian		#############################################
r_FLCrash6a_in		:=	record
	rec_type_6					:=	ds_FLaccidents.rec_type[	1	..	1	];
	accident_nbr				:=	ds_FLaccidents.data_[	1	..	9	];
	section_nbr					:=	ds_FLaccidents.data_[	10	..	11	];
	filler1						:=	ds_FLaccidents.data_[	12	..	13	];
	pedest_first_name			:=	ds_FLaccidents.data_[	14	..	26	];
	middle_int					:=	ds_FLaccidents.data_[	27	..	27	];
	last_name					:=	ds_FLaccidents.data_[	28	..	52	];
	work_area					:=	ds_FLaccidents.data_[	53	..	54	];
	ped_name_suffix				:=	ds_FLaccidents.data_[	55	..	55	];
	ped_st_address				:=	ds_FLaccidents.data_[	56	..	81	];
	driver_city					:=	ds_FLaccidents.data_[	82	..	95	];
	filler3						:=	ds_FLaccidents.data_[	96	..	113	];
	ped_state					:=	ds_FLaccidents.data_[	114	..	115	];
	ped_zip						:=	ds_FLaccidents.data_[	116	..	124	];
	ded_dob						:=	ds_FLaccidents.data_[	125	..	132	];
	ped_bac_test_type			:=	ds_FLaccidents.data_[	133	..	133	];
	ped_bac_force_code			:=	ds_FLaccidents.data_[	134	..	134	];
	ped_bac_results				:=	ds_FLaccidents.data_[	135	..	137	];
	filler4						:=	ds_FLaccidents.data_[	138	..	138	];
	ped_alco_drugs				:=	ds_FLaccidents.data_[	139	..	139	];
	ped_physical_defect			:=	ds_FLaccidents.data_[	140	..	140	];
	ped_residence				:=	ds_FLaccidents.data_[	141	..	141	];
	ped_race					:=	ds_FLaccidents.data_[	142	..	142	];
	ped_sex						:=	ds_FLaccidents.data_[	143	..	143	];
	ped_injury_sev				:=	ds_FLaccidents.data_[	144	..	144	];
	ped_first_contrib_cause		:=	ds_FLaccidents.data_[	145	..	146	];
	ped_second_contrib_cause	:=	ds_FLaccidents.data_[	147	..	148	];
	ped_third_contrib_cause		:=	ds_FLaccidents.data_[	149	..	150	];
	ped_action					:=	ds_FLaccidents.data_[	151	..	152	];
	first_offense_charged		:=	ds_FLaccidents.data_[	153	..	160	];
	first_frdl_sys_charge_code	:=	ds_FLaccidents.data_[	161	..	162	];
	second_offense_charged		:=	ds_FLaccidents.data_[	163	..	170	];
	second_frdl_sys_charge_code	:=	ds_FLaccidents.data_[	171	..	172	];
	third_offense_charged		:=	ds_FLaccidents.data_[	173	..	180	];
	third_frdl_sys_charge_code	:=	ds_FLaccidents.data_[	181	..	182	];
	first_citation_nbr			:=	ds_FLaccidents.data_[	183	..	189	];
	second_citation_nbr			:=	ds_FLaccidents.data_[	190	..	196	];
	third_citation_nbr			:=	ds_FLaccidents.data_[	197	..	203	];
	ped_fr_injury_cap			:=	ds_FLaccidents.data_[	204	..	205	];
	fourth_offense_charged		:=	ds_FLaccidents.data_[	206	..	213	];
	fourth_frdl_sys_charge_code	:=	ds_FLaccidents.data_[	214	..	215	];
	fifth_offense_charged		:=	ds_FLaccidents.data_[	216	..	223	];
	fifth_frdl_sys_charge_code	:=	ds_FLaccidents.data_[	224	..	225	];
	sixth_offense_charged		:=	ds_FLaccidents.data_[	226	..	233	];
	sixth_sys_charge_code		:=	ds_FLaccidents.data_[	234	..	235	];
	seventh_offense_charged		:=	ds_FLaccidents.data_[	236	..	243	];
	seventh_sys_charge_code		:=	ds_FLaccidents.data_[	244	..	245	];
	eighth_offense_charged		:=	ds_FLaccidents.data_[	246	..	253	];
	eighth_sys_charge_code		:=	ds_FLaccidents.data_[	254	..	255	];
	fourth_citation_issued		:=	ds_FLaccidents.data_[	256	..	262	];
	fifth_citation_issued		:=	ds_FLaccidents.data_[	263	..	269	];
	sixth_citation_issued		:=	ds_FLaccidents.data_[	270	..	276	];
	seventh_citation_issued		:=	ds_FLaccidents.data_[	277	..	283	];
	eighth_citation_issued		:=	ds_FLaccidents.data_[	284	..	290	];
	ped_dl_nbr					:=	ds_FLaccidents.data_[	291	..	305	];
	filler5						:=	ds_FLaccidents.data_[	306	..	399	];
end;

ds_FLCrash6a_in		:=	table(ds_FLaccidents(rec_type='6'),r_FLCrash6a_in);

r_FLCrash6b_in		:=	record
	ds_FLCrash6a_in;

	string10 prim_range;
	string2 predir;
	string28 prim_name;
	string4 addr_suffix;
	string2 postdir;
	string10 unit_desig;
	string8 sec_range;
	string25 p_city_name;
	string25 v_city_name;
	string2 st;
	string5 zip;
	string4 zip4;
	string4 cart;
	string1 cr_sort_sz;
	string4 lot;
	string1 lot_order;
	string2 dpbc;
	string1 chk_digit;
	string2 rec_type;
	string2 ace_fips_st;
	string3 county;
	string10 geo_lat;
	string11 geo_long;
	string4 msa;
	string7 geo_blk;
	string1 geo_match;
	string4 err_stat;

	string5 title;
	string20 fname;
	string20 mname;
	string20 lname;
	string5 suffix;
	string3 score;

	string25	cname;
end;

r_FLCrash6b_in	tr_FLCrash6b_in(ds_FLCrash6a_in le) := transform

	string182	address_	:=			le.driver_city
								+ ' ' + le.ped_state
								+ ' ' + le.ped_zip;

	string182	caddress_	:=	AddrCleanLib.CleanAddress182(le.ped_st_address,address_);

	string73	name_		:=			le.pedest_first_name
								+ ' ' +	le.middle_int
								+ ' ' +	le.last_name
								+ ' ';

	string73	cname		:=	if(le.ped_name_suffix <> 'C',AddrCleanLib.CleanPersonFML73(name_),'');

	string73	cname_		:=	map(le.ped_name_suffix = 'J'	=> cname[1..65] + 'JR   ' + cname[71..73],
									le.ped_name_suffix = 'S'	=> cname[1..65] + 'SR   ' + cname[71..73],
									le.ped_name_suffix = '1'	=> cname[1..65] + 'I    ' + cname[71..73],
									le.ped_name_suffix = '2'	=> cname[1..65] + 'II   ' + cname[71..73],
									le.ped_name_suffix = '3'	=> cname[1..65] + 'III  ' + cname[71..73],
									le.ped_name_suffix = '4'	=> cname[1..65] + 'IV   ' + cname[71..73],
									le.ped_name_suffix = 'C'	=> cname[1..65] + '     ' + cname[71..73],
									cname[1..65] + (string5)le.ped_name_suffix + cname[71..73]);


	self.prim_range		:= caddress_[	1	..	10	];
	self.predir			:= caddress_[	11	..	12	];
	self.prim_name		:= caddress_[	13	..	40	];
	self.addr_suffix	:= caddress_[	41	..	44	];
	self.postdir		:= caddress_[	45	..	46	];
	self.unit_desig		:= caddress_[	47	..	56	];
	self.sec_range		:= caddress_[	57	..	64	];
	self.p_city_name	:= caddress_[	65	..	89	];
	self.v_city_name	:= caddress_[	90	..	114	];
	self.st				:= caddress_[	115	..	116	];
	self.zip			:= caddress_[	117	..	121	];
	self.zip4			:= caddress_[	122	..	125	];
	self.cart			:= caddress_[	126	..	129	];
	self.cr_sort_sz		:= caddress_[	130	..	130	];
	self.lot			:= caddress_[	131	..	134	];
	self.lot_order		:= caddress_[	135	..	135	];
	self.dpbc			:= caddress_[	136	..	137	];
	self.chk_digit		:= caddress_[	138	..	138	];
	self.rec_type		:= caddress_[	139	..	140	];
	self.ace_fips_st	:= caddress_[	141	..	142	];
	self.county			:= caddress_[	143	..	145	];
	self.geo_lat		:= caddress_[	146	..	155	];
	self.geo_long		:= caddress_[	156	..	166	];
	self.msa			:= caddress_[	167	..	170	];
	self.geo_blk		:= caddress_[	171	..	177	];
	self.geo_match		:= caddress_[	178	..	178	];
	self.err_stat		:= caddress_[	179	..	182	];

	self.title	:= cname_[	1	..	5	];
	self.fname	:= cname_[	6	..	25	];
	self.mname	:= cname_[	26	..	45	];
	self.lname	:= cname_[	46	..	65	];
	self.suffix	:= cname_[	66	..	70	];
	self.score	:= cname_[	71	..	73	];

	self.cname			:=	if(le.ped_name_suffix  = 'C',le.last_name,'');

	self   				:= le;

end;

ds_FLCrash6b_in		:= project(ds_FLCrash6a_in,tr_FLCrash6b_in(left));

ds_srtd_ddup_out	:= dedup(sort(distribute(ds_FLCrash6b_in,hash(accident_nbr))
												,rec_type_6
												,accident_nbr
												,section_nbr
												,filler1
												,pedest_first_name
												,middle_int
												,last_name
												,work_area
												,ped_name_suffix
												,ped_st_address
												,driver_city
												,filler3
												,ped_state
												,ped_zip
												,ded_dob
												,ped_bac_test_type
												,ped_bac_force_code
												,ped_bac_results
												,filler4
												,ped_alco_drugs
												,ped_physical_defect
												,ped_residence
												,ped_race
												,ped_sex
												,ped_injury_sev
												,ped_first_contrib_cause
												,ped_second_contrib_cause
												,ped_third_contrib_cause
												,ped_action
												,first_offense_charged
												,first_frdl_sys_charge_code
												,second_offense_charged
												,second_frdl_sys_charge_code
												,third_offense_charged
												,third_frdl_sys_charge_code
												,first_citation_nbr
												,second_citation_nbr
												,third_citation_nbr
												,ped_fr_injury_cap
												,fourth_offense_charged
												,fourth_frdl_sys_charge_code
												,fifth_offense_charged
												,fifth_frdl_sys_charge_code
												,sixth_offense_charged
												,sixth_sys_charge_code
												,seventh_offense_charged
												,seventh_sys_charge_code
												,eighth_offense_charged
												,eighth_sys_charge_code
												,fourth_citation_issued
												,fifth_citation_issued
												,sixth_citation_issued
												,seventh_citation_issued
												,eighth_citation_issued
												,ped_dl_nbr
												,filler5
												,local),local);

EXPORT FLCrash6_layout  := ds_srtd_ddup_out;

//flcrash7 property		#############################################
r_FLCrash7a_in		:=	record
	rec_type_7					:=	ds_FLaccidents.rec_type[	1	..	1	];
	accident_nbr				:=	ds_FLaccidents.data_[	1	..	9	];
	prop_damage_code			:=	ds_FLaccidents.data_[	10	..	11	];
	prop_damage_nbr				:=	ds_FLaccidents.data_[	12	..	13	];
	prop_damaged				:=	ds_FLaccidents.data_[	14	..	38	];
	prop_damage_amount			:=	ds_FLaccidents.data_[	39	..	45	];
	prop_owner_firstname		:=	ds_FLaccidents.data_[	46	..	58	];
	middle_int					:=	ds_FLaccidents.data_[	59	..	59	];
	prop_last_name				:=	ds_FLaccidents.data_[	60	..	84	];
	filler1						:=	ds_FLaccidents.data_[	85	..	86	];
	prop_owner_suffix			:=	ds_FLaccidents.data_[	87	..	87	];
	prop_owner_st_address		:=	ds_FLaccidents.data_[	88	..	113	];
	city						:=	ds_FLaccidents.data_[	114	..	127	];
	filler2						:=	ds_FLaccidents.data_[	128	..	145	];
	prop_owner_state			:=	ds_FLaccidents.data_[	146	..	147	];
	prop_owner_zip				:=	ds_FLaccidents.data_[	148	..	156	];
	fr_fixed_object_cap_code	:=	ds_FLaccidents.data_[	157	..	158	];
	filler3						:=	ds_FLaccidents.data_[	159	..	399	];
end;

ds_FLCrash7a_in		:=	table(ds_FLaccidents(rec_type='7'),r_FLCrash7a_in);

r_FLCrash7b_in		:=	record
	ds_FLCrash7a_in;

	string10 prim_range;
	string2 predir;
	string28 prim_name;
	string4 addr_suffix;
	string2 postdir;
	string10 unit_desig;
	string8 sec_range;
	string25 p_city_name;
	string25 v_city_name;
	string2 st;
	string5 zip;
	string4 zip4;
	string4 cart;
	string1 cr_sort_sz;
	string4 lot;
	string1 lot_order;
	string2 dpbc;
	string1 chk_digit;
	string2 rec_type;
	string2 ace_fips_st;
	string3 county;
	string10 geo_lat;
	string11 geo_long;
	string4 msa;
	string7 geo_blk;
	string1 geo_match;
	string4 err_stat;

	string5 title;
	string20 fname;
	string20 mname;
	string20 lname;
	string5 suffix;
	string3 score;

	string25	cname;
end;

r_FLCrash7b_in	tr_FLCrash7b_in(ds_FLCrash7a_in le) := transform

	string182	address_	:=			le.city
								+ ' ' + le.prop_owner_state
								+ ' ' + le.prop_owner_zip;

	string182	caddress_	:=	AddrCleanLib.CleanAddress182(le.prop_owner_st_address,address_);

	string73	name_		:=			le.prop_owner_firstname
								+ ' ' +	le.middle_int
								+ ' ' +	le.prop_last_name
								+ ' ';

	string73	cname		:=	if(le.prop_owner_suffix <> 'C',AddrCleanLib.CleanPersonFML73(name_),'');

	string73	cname_		:=	map(le.prop_owner_suffix = 'J'	=> cname[1..65] + 'JR   ' + cname[71..73],
									le.prop_owner_suffix = 'S'	=> cname[1..65] + 'SR   ' + cname[71..73],
									le.prop_owner_suffix = '1'	=> cname[1..65] + 'I    ' + cname[71..73],
									le.prop_owner_suffix = '2'	=> cname[1..65] + 'II   ' + cname[71..73],
									le.prop_owner_suffix = '3'	=> cname[1..65] + 'III  ' + cname[71..73],
									le.prop_owner_suffix = '4'	=> cname[1..65] + 'IV   ' + cname[71..73],
									le.prop_owner_suffix = 'C'	=> cname[1..65] + '     ' + cname[71..73],
									cname[1..65] + (string5)le.prop_owner_suffix + cname[71..73]);

	self.prim_range		:= caddress_[	1	..	10	];
	self.predir			:= caddress_[	11	..	12	];
	self.prim_name		:= caddress_[	13	..	40	];
	self.addr_suffix	:= caddress_[	41	..	44	];
	self.postdir		:= caddress_[	45	..	46	];
	self.unit_desig		:= caddress_[	47	..	56	];
	self.sec_range		:= caddress_[	57	..	64	];
	self.p_city_name	:= caddress_[	65	..	89	];
	self.v_city_name	:= caddress_[	90	..	114	];
	self.st				:= caddress_[	115	..	116	];
	self.zip			:= caddress_[	117	..	121	];
	self.zip4			:= caddress_[	122	..	125	];
	self.cart			:= caddress_[	126	..	129	];
	self.cr_sort_sz		:= caddress_[	130	..	130	];
	self.lot			:= caddress_[	131	..	134	];
	self.lot_order		:= caddress_[	135	..	135	];
	self.dpbc			:= caddress_[	136	..	137	];
	self.chk_digit		:= caddress_[	138	..	138	];
	self.rec_type		:= caddress_[	139	..	140	];
	self.ace_fips_st	:= caddress_[	141	..	142	];
	self.county			:= caddress_[	143	..	145	];
	self.geo_lat		:= caddress_[	146	..	155	];
	self.geo_long		:= caddress_[	156	..	166	];
	self.msa			:= caddress_[	167	..	170	];
	self.geo_blk		:= caddress_[	171	..	177	];
	self.geo_match		:= caddress_[	178	..	178	];
	self.err_stat		:= caddress_[	179	..	182	];

	self.title	:= cname_[	1	..	5	];
	self.fname	:= cname_[	6	..	25	];
	self.mname	:= cname_[	26	..	45	];
	self.lname	:= cname_[	46	..	65	];
	self.suffix	:= cname_[	66	..	70	];
	self.score	:= cname_[	71	..	73	];

	self.cname			:=	if(le.prop_owner_suffix  = 'C',le.prop_last_name,'');

	self   				:= le;

end;

ds_FLCrash7b_in		:= project(ds_FLCrash7a_in,tr_FLCrash7b_in(left));

ds_srtd_ddup_out	:= dedup(sort(distribute(ds_FLCrash7b_in,hash(accident_nbr))
												,rec_type_7
												,accident_nbr
												,prop_damage_code
												,prop_damage_nbr
												,prop_damaged
												,prop_damage_amount
												,prop_owner_firstname
												,middle_int
												,prop_last_name
												,filler1
												,prop_owner_suffix
												,prop_owner_st_address
												,city
												,filler2
												,prop_owner_state
												,prop_owner_zip
												,fr_fixed_object_cap_code
												,filler3
												,local),local);

EXPORT FLCrash7_layout  := ds_srtd_ddup_out;

//flcrash8 carrier		#############################################
r_FLCrash8_in		:=	record
	rec_type_8				:=	ds_FLaccidents.rec_type[	1	..	1	];
	accident_nbr			:=	ds_FLaccidents.data_[	1	..	9	];
	section_no				:=	ds_FLaccidents.data_[	10	..	11	];
	filler					:=	ds_FLaccidents.data_[	12	..	13	];
	carrier_name			:=	ds_FLaccidents.data_[	14	..	53	];
	carrier_address			:=	ds_FLaccidents.data_[	54	..	93	];
	carrier_city			:=	ds_FLaccidents.data_[	94	..	113	];
	carrier_state			:=	ds_FLaccidents.data_[	114	..	115	];
	carrier_zip				:=	ds_FLaccidents.data_[	116	..	124	];
	us_dot_or_icc_id_nums	:=	ds_FLaccidents.data_[	125	..	132	];
	source_or_carrier_info	:=	ds_FLaccidents.data_[	133	..	133	];
	filler3					:=	ds_FLaccidents.data_[	134	..	399	];
end;

ds_FLCrash8_in		:=	table(ds_FLaccidents(rec_type='8'),r_FLCrash8_in);

ds_srtd_ddup_out	:= dedup(sort(distribute(ds_FLCrash8_in,hash(accident_nbr))
												,rec_type_8
												,accident_nbr
												,section_no
												,filler
												,carrier_name
												,carrier_address
												,carrier_city
												,carrier_state
												,carrier_zip
												,us_dot_or_icc_id_nums
												,source_or_carrier_info
												,filler3
												,local),local);

EXPORT FLCrash8_layout  := ds_srtd_ddup_out;


END;