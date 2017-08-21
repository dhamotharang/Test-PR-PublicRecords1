#workunit ('name', 'Emerges Hunt,Fish & Concealed Build ');
import ut, census_Data, PromoteSupers;

export make_hvc_output(string version_date) := function

	hvc0 := emerges.file_hvccw_building;

	withCounty := record
		hvc0;
		string18	county_name;
	end;

	//all records with a file_id = "HUNT" do not have to be hunt records, they can be hunt and/or fish
	withCounty getCounty(hvc0 L, census_data.File_Fips2County R) := transform
		self.hunt					:=	if(trim(l.ComboSuper + l.Sportsman + l.Trap + l.Archery + l.Muzzle + l.Drawing + l.Day1 + l.Day3 + 
																	l.Day7 + l.Day14to15 + l.DayFiller + l.SeasonAnnual + l.LifeTimePermit + l.Deer + l.Bear + l.Elk + 
																	l.Moose + l.Buffalo + l.Antelope + l.SikeBull + l.Bighorn + l.Javelina + l.Cougar + l.Anterless + 
																	l.Pheasant + l.Goose + l.Duck + l.Turkey + l.SnowMobile + l.BigGame + l.SkiPass + l.MigBird + 
																	l.SmallGame + l.Sturgeon2 + l.Gun + l.Bonus + l.Lottery + l.OtherBirds + l.hunt
																	) != '',
															'Y',
															''
														);
		self.fish  				:= if(trim(	l.ComboSuper + l.Sportsman + l.Salmon + l.Freshwater + l.Saltwater + l.LakesandResevoirs + 
																	l.SetLineFish + l.Trout + l.FallFishing + l.Steelhead + l.WhiteJubHerring + l.Sturgeon + 
																	l.ShellfishCrab + l.ShellfishLobster + l.fish
																) != '' or l.file_id = 'FISH',
														'Y',
														''
														);
		self.gender				:=	if(	stringlib.stringtouppercase(l.gender) = 'M' or
															stringlib.stringtouppercase(l.gender) = 'F' or
															stringlib.stringtouppercase(l.gender) = 'U',
															stringlib.stringtouppercase(l.gender),
															''
															);
		self.county_name	:=	R.county_name;
		self							:=	L;
	end;

	hvc	:=	join(	hvc0,
								census_data.File_Fips2County,
								left.county = right.county_fips and
								left.ace_fips_st = right.state_fips,
								getCounty(LEFT,RIGHT),
								left outer,
								lookup
							);

	/////////////////////////////////////////////////////////////////////////////////				
	// -- Convert to hunters layout
	/////////////////////////////////////////////////////////////////////////////////
	emerges.layout_hunters_out convert2Hunt(hvc l)	:=
	transform
		self.hunt									:=	map(l.hunt = 'Y' => 'Y', l.fish = 'Y' => '', 'Y'); 
		self.fish									:=	l.fish;
		self.license_type_mapped	:=	map(self.hunt = 'Y' and self.fish = 'Y' => 'Hunting and Fishing',
																			self.fish = 'Y' => 'Fishing',
																			'Hunting'
																			);
    self.process_date         :=  if(l.process_date='VERSION','20120411',l.process_date);																			
		self.dob									:=	l.dob_str;
		self.county_name					:=	l.county_name;
		self.source_voterid				:=	'';
		self.motorvoterid					:=	'';
		self.regsource						:=	'';
		self.prim_range						:=	l.AID_ResClean_prim_range;
		self.predir								:=	l.AID_ResClean_predir;
		self.prim_name						:=	l.AID_ResClean_prim_name;
		self.suffix								:=	l.AID_ResClean_addr_suffix;
		self.postdir							:=	l.AID_ResClean_postdir;
		self.unit_desig						:=	l.AID_ResClean_unit_desig;
		self.sec_range						:=	l.AID_ResClean_sec_range;
		self.p_city_name					:=	l.AID_ResClean_p_city_name;
		self.city_name						:=	l.AID_ResClean_v_city_name;
		self.st										:=	l.AID_ResClean_st;
		self.zip									:=	l.AID_ResClean_zip;
		self.zip4									:=	l.AID_ResClean_zip4;
		self.cart									:=	l.AID_ResClean_cart;
		self.cr_sort_sz						:=	l.AID_ResClean_cr_sort_sz;
		self.lot									:=	l.AID_ResClean_lot;
		self.lot_order						:=	l.AID_ResClean_lot_order;
		self.dpbc									:=	l.AID_ResClean_dpbc;
		self.chk_digit						:=	l.AID_ResClean_chk_digit;
		self.record_type					:=	l.AID_ResClean_record_type;
		self.ace_fips_st					:=	l.AID_ResClean_ace_fips_st;
		self.county								:=	l.AID_ResClean_fipscounty;
		self.geo_lat							:=	l.AID_ResClean_geo_lat;
		self.geo_long							:=	l.AID_ResClean_geo_long;
		self.msa									:=	l.AID_ResClean_msa;
		self.geo_blk							:=	l.AID_ResClean_geo_blk;
		self.geo_match						:=	l.AID_ResClean_geo_match;
		self.err_stat							:=	l.AID_ResClean_err_stat;
		self.mail_prim_range			:=	l.AID_MailClean_prim_range;
		self.mail_predir					:=	l.AID_MailClean_prim_range;
		self.mail_prim_name				:=	l.AID_MailClean_prim_name;
		self.mail_addr_suffix			:=	l.AID_MailClean_addr_suffix;
		self.mail_postdir					:=	l.AID_MailClean_postdir;
		self.mail_unit_desig			:=	l.AID_MailClean_unit_desig;
		self.mail_sec_range				:=	l.AID_MailClean_sec_range;
		self.mail_p_city_name			:=	l.AID_MailClean_p_city_name;
		self.mail_v_city_name			:=	l.AID_MailClean_v_city_name;
		self.mail_st							:=	l.AID_MailClean_st;
		self.mail_ace_zip					:=	l.AID_MailClean_zip;
		self.mail_zip4						:=	l.AID_MailClean_zip4;
		self.mail_cart						:=	l.AID_MailClean_cart;
		self.mail_cr_sort_sz			:=	l.AID_MailClean_cr_sort_sz;
		self.mail_lot							:=	l.AID_MailClean_lot;
		self.mail_lot_order				:=	l.AID_MailClean_lot_order;
		self.mail_dpbc						:=	l.AID_MailClean_dpbc;
		self.mail_chk_digit				:=	l.AID_MailClean_chk_digit;
		self.mail_record_type			:=	l.AID_MailClean_record_type;
		self.mail_ace_fips_st			:=	l.AID_MailClean_ace_fips_st;
		self.mail_fipscounty			:=	l.AID_MailClean_fipscounty;
		self.mail_geo_lat					:=	l.AID_MailClean_geo_lat;
		self.mail_geo_long				:=	l.AID_MailClean_geo_long;
		self.mail_msa							:=	l.AID_MailClean_msa;
		self.mail_geo_blk					:=	l.AID_MailClean_geo_blk;
		self.mail_geo_match				:=	l.AID_MailClean_geo_match;
		self.mail_err_stat				:=	l.AID_MailClean_err_stat;
		self											:=	l;
	end;

	hunt_temp	:=	project(hvc(file_id = 'HUNT' or file_id = 'FISH'), convert2Hunt(left));
	hunt_dist	:=	distribute(hunt_temp,hash(lname,lname,zip));

	hunt_srt	:=	sort(	hunt_dist,
											lname,
											zip,
											file_id,
											source_state,
											title, fname, mname, name_suffix,
											prim_range,prim_name,predir,postdir,suffix,sec_range,p_city_name,st,
											dob,
											regDate,
											gender,
											DateLicense,
											HuntFishPerm,
											Hunt,Fish,
											HomeState,
											race,
											-date_last_seen,
											date_first_seen,
											local
										);

	emerges.layout_hunters_out hunt_rollData(hunt_srt L, hunt_srt R) := transform
		self.date_first_seen	:=	if(r.date_first_seen < l.date_first_seen,r.date_first_seen,l.date_first_seen);
		self.date_last_seen		:=	if(r.date_last_seen > l.date_last_seen,r.date_last_seen,l.date_last_seen);
		self									:=	l;
	end;

	hunt_out	:=	rollup(	hunt_srt,
												left.lname								=	right.lname								and
												left.zip		=	right.zip	and
												left.file_id							=	right.file_id							and
												left.source_state					=	right.source_state				and
												left.title								=	right.title								and
												left.fname								=	right.fname								and
												left.mname								=	right.mname								and
												left.name_suffix					=	right.name_suffix					and
												left.prim_range						=	right.prim_range					and
												left.prim_name						=	right.prim_name						and
												left.predir								=	right.predir							and
												left.postdir							=	right.postdir							and
												left.suffix								=	right.suffix							and
												left.sec_range						=	right.sec_range						and
												left.p_city_name					=	right.p_city_name					and
												left.st										=	right.st									and
												left.dob									=	right.dob									and
												left.regDate							=	right.regDate							and
												left.gender								=	right.gender							and
												left.DateLicense					=	right.DateLicense					and
												left.HuntFishPerm					=	right.HuntFishPerm				and
												left.Hunt									=	right.Hunt								and 
												left.Fish									=	right.Fish								and
												left.HomeState						=	right.HomeState						and
												left.race									=	right.race,
												hunt_rollData(left,right),
												local
											);
	
	/////////////////////////////////////////////////////////////////////////////////
	// -- Convert to ccw layout
	/////////////////////////////////////////////////////////////////////////////////
	
	emerges.layout_ccw_out convert2Ccw(hvc l)	:=
	transform
		self.dob									:=	l.dob_str;
		self.source_voterid				:=	'';
		self.motorvoterid 				:=	'';
		self.regsource						:=	'';
		self.prim_range						:=	l.AID_ResClean_prim_range;
		self.predir								:=	l.AID_ResClean_predir;
		self.prim_name						:=	l.AID_ResClean_prim_name;
		self.suffix								:=	l.AID_ResClean_addr_suffix;
		self.postdir							:=	l.AID_ResClean_postdir;
		self.unit_desig						:=	l.AID_ResClean_unit_desig;
		self.sec_range						:=	l.AID_ResClean_sec_range;
		self.p_city_name					:=	l.AID_ResClean_p_city_name;
		self.city_name						:=	l.AID_ResClean_v_city_name;
		self.st										:=	l.AID_ResClean_st;
		self.zip									:=	l.AID_ResClean_zip;
		self.zip4									:=	l.AID_ResClean_zip4;
		self.cart									:=	l.AID_ResClean_cart;
		self.cr_sort_sz						:=	l.AID_ResClean_cr_sort_sz;
		self.lot									:=	l.AID_ResClean_lot;
		self.lot_order						:=	l.AID_ResClean_lot_order;
		self.dpbc									:=	l.AID_ResClean_dpbc;
		self.chk_digit						:=	l.AID_ResClean_chk_digit;
		self.record_type					:=	l.AID_ResClean_record_type;
		self.ace_fips_st					:=	l.AID_ResClean_ace_fips_st;
		self.county								:=	l.AID_ResClean_fipscounty;
		self.geo_lat							:=	l.AID_ResClean_geo_lat;
		self.geo_long							:=	l.AID_ResClean_geo_long;
		self.msa									:=	l.AID_ResClean_msa;
		self.geo_blk							:=	l.AID_ResClean_geo_blk;
		self.geo_match						:=	l.AID_ResClean_geo_match;
		self.err_stat							:=	l.AID_ResClean_err_stat;
		self.mail_prim_range			:=	l.AID_MailClean_prim_range;
		self.mail_predir					:=	l.AID_MailClean_prim_range;
		self.mail_prim_name				:=	l.AID_MailClean_prim_name;
		self.mail_addr_suffix			:=	l.AID_MailClean_addr_suffix;
		self.mail_postdir					:=	l.AID_MailClean_postdir;
		self.mail_unit_desig			:=	l.AID_MailClean_unit_desig;
		self.mail_sec_range				:=	l.AID_MailClean_sec_range;
		self.mail_p_city_name			:=	l.AID_MailClean_p_city_name;
		self.mail_v_city_name			:=	l.AID_MailClean_v_city_name;
		self.mail_st							:=	l.AID_MailClean_st;
		self.mail_ace_zip					:=	l.AID_MailClean_zip;
		self.mail_zip4						:=	l.AID_MailClean_zip4;
		self.mail_cart						:=	l.AID_MailClean_cart;
		self.mail_cr_sort_sz			:=	l.AID_MailClean_cr_sort_sz;
		self.mail_lot							:=	l.AID_MailClean_lot;
		self.mail_lot_order				:=	l.AID_MailClean_lot_order;
		self.mail_dpbc						:=	l.AID_MailClean_dpbc;
		self.mail_chk_digit				:=	l.AID_MailClean_chk_digit;
		self.mail_record_type			:=	l.AID_MailClean_record_type;
		self.mail_ace_fips_st			:=	l.AID_MailClean_ace_fips_st;
		self.mail_fipscounty			:=	l.AID_MailClean_fipscounty;
		self.mail_geo_lat					:=	l.AID_MailClean_geo_lat;
		self.mail_geo_long				:=	l.AID_MailClean_geo_long;
		self.mail_msa							:=	l.AID_MailClean_msa;
		self.mail_geo_blk					:=	l.AID_MailClean_geo_blk;
		self.mail_geo_match				:=	l.AID_MailClean_geo_match;
		self.mail_err_stat				:=	l.AID_MailClean_err_stat;
		self								:=	l;
	end;

	ccw_temp	:=	project(hvc(file_id = 'CCW '), convert2Ccw(left));
	ccw_dist	:=	distribute(ccw_temp,hash(lname,zip));

	ccw_srt		:=	sort(	ccw_dist,
											lname,
											zip,
											file_id,
											source_state,
											title,fname,mname,name_suffix,
											prim_range,prim_name,predir,postdir,suffix,sec_range,p_city_name,st,
											dob,
											regDate,
											gender,
											race,
											CCWPermNum,
											-date_last_seen,
											date_first_seen,
											local
										);

	emerges.layout_ccw_out ccw_rollData(ccw_srt L, ccw_srt R) := transform
		self.date_first_seen	:=	if(r.date_first_seen < l.date_first_seen,r.date_first_seen,l.date_first_seen);
		self.date_last_seen		:=	if(r.date_last_seen > l.date_last_seen,r.date_last_seen,l.date_last_seen);
		self									:=	l;
	end;

	ccw_rollup := rollup(	ccw_srt,
												left.lname								=	right.lname								and
												left.zip									=	right.zip									and
												left.file_id							=	right.file_id							and
												left.source_state					=	right.source_state				and
												left.title								=	right.title								and 
												left.fname								=	right.fname								and
												left.mname								=	right.mname								and
												left.name_suffix					=	right.name_suffix					and
												left.prim_range						=	right.prim_range					and
												left.prim_name						=	right.prim_name						and
												left.predir								=	right.predir							and
												left.postdir							=	right.postdir							and
												left.suffix								=	right.suffix							and
												left.sec_range						=	right.sec_range						and
												left.p_city_name					=	right.p_city_name					and
												left.st										=	right.st									and
												left.dob									=	right.dob									and 
												left.regDate							=	right.regDate							and
												left.gender								=	right.gender							and
												left.race									=	right.race								and
												left.CCWPermNum						=	right.CCWPermNum,
												ccw_rollData(left,right),
												local
											);

	// add unique id to ccw out file
	rCCWSeqNum_layout	:=
	record
		unsigned6	record_id	:=	0;
		emerges.layout_ccw_out;
	end;

	// Add unique record id
	rCCWSeqNum_layout AddRecordID(emerges.Layout_ccw_out	l)	:=
	transform
		self	:=	l;
	end;

	ccw_addrecid	:=	project(ccw_rollup,AddRecordID(left));

	ut.MAC_Sequence_Records(ccw_addrecid,record_id,ccw_Seq);

	emerges.layout_ccw_out formatout(rCCWSeqNum_layout	l)	:=
	transform
		self.unique_id	:=	intformat(l.record_id,8,1);
		self						:=	l;
	end;

	ccw_uniqueid	:=	project(ccw_Seq,formatout(left));

	ccw_out				:=	sort(ccw_uniqueid,unique_id);

	PromoteSupers.MAC_SF_BuildProcess(hunt_out,'~thor_data400::base::emerges_hunt',a,,,true);
	PromoteSupers.MAC_SF_BuildProcess(ccw_out,'~thor_data400::base::emerges_ccw',b,,,true);

	make_output := sequential(parallel(a,b),
														 parallel(emerges.Out_Base_Stats_Population_CCW(version_date),
																			emerges.Out_Base_Stats_Population_Hunters(version_date)
														 )
														);
															
	return make_output;
end;