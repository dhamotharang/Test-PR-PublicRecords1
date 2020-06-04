import std, prte2_ecrash;

layouts.search 	convert_file2(files.base_ecrash2v l) 
	:= transform
  // self.accident_date 	:= L.accident_date;
	self.name_suffix 		:= l.suffix;
	self.record_type 		:= 'VEHICLE OWNER';
	self.vin 						:= STD.Str.CleanSpaces(l.vehicle_id_nbr);
	self.driver_license_nbr := STD.Str.CleanSpaces(l.vehicle_owner_dl_nbr);
	self.tag_nbr 				:= STD.Str.CleanSpaces(l.vehicle_tag_nbr);
	self.orig_full_name := l.vehicle_owner_name;
	self := l;
	self := [];
end; 

search_file2 := project(files.base_ecrash2v, convert_file2(left));

layouts.search 	convert_file4(files.base_ecrash4 l) := transform
  // self.accident_date 			:= '';
	self.name_suffix 				:= l.suffix;
	self.record_type 				:= 'VEHICLE DRIVER';
	self.vin 								:= '';
	self.driver_license_nbr := STD.Str.CleanSpaces(l.driver_dl_nbr);
	self.tag_nbr 						:= '';
	self.orig_full_name 		:= l.driver_full_name;
	self := l;
	self := [];
end; 

search_file4 := project(files.base_ecrash4, convert_file4(left));

layouts.search 	convert_file5(files.base_ecrash5 l) := transform
  self.accident_date := '';
	self.name_suffix := l.suffix;
	self.record_type := 'PASSENGER';
	self.vin := '';
	self.driver_license_nbr := '';
	self.tag_nbr := '';
	self.orig_full_name := l.passenger_full_name;
	self := l;
end; 

search_file5 := project(files.base_ecrash5, convert_file5(left));

layouts.search 	convert_file6(files.base_ecrash6 l) := transform
  self.accident_date := '';
	self.name_suffix 	:= l.suffix;
	self.record_type 	:= 'PEDESTRIAN';
	self.vin 					:= '';
	self.driver_license_nbr := '';
	self.tag_nbr := '';
	self.orig_full_name := l.pedest_full_name;
	self := l;
end; 

search_file6 := project(files.base_ecrash6, convert_file6(left));

layouts.search 	convert_file7(files.base_ecrash7 l) := transform
  self.accident_date := '';
	self.name_suffix := l.suffix;
	self.record_type := 'PROPERTY OWNER';
	self.vin := '';
	self.driver_license_nbr := '';
	self.tag_nbr := '';
	self.orig_full_name := l.prop_owner_name;
	self := l;
end; 

search_file7 := project(files.base_ecrash7, convert_file7(left));

layouts.search 	convert_file9(files.base_ecrash9 l) := transform
  self.accident_date := '';
	self.name_suffix := l.suffix;
	self.record_type := 'WITNESS';
	self.vin := '';
	self.driver_license_nbr := '';
	self.tag_nbr := '';
	self.orig_full_name := l.witness_full_name;
	self := l;
end; 

search_file9 := project(files.base_ecrash9, convert_file9(left));

flc_search_file :=		search_file2
					+	search_file4
					+	search_file5
					+	search_file6
					+	search_file7
					+ search_file9;

dst_base_file0 := distribute(files.base_ecrash0, hash(accident_nbr, accident_date));
srt_base_file0 := sort(dst_base_file0, accident_nbr, -(unsigned4)accident_date,local);	
dep_base_file0 := dedup(srt_base_file0, accident_nbr,local);							
								
layouts.search 	get_acc_date(flc_search_file l, dep_base_file0 r) := transform
	self.accident_date := r.accident_date;
	self := l;
end;				 
				 
flc_search_out := join(flc_search_file, dep_base_file0, 
                       left.accident_nbr = right.accident_nbr,
				   get_acc_date(left,right), left outer, hash);

file_Build_did := dedup(flc_search_out,all);

/************************************************************/
layouts.SrchServ 	xf2(file_Build_did l, files.base_ecrash2v r) := transform
	self.dlnbr_st    := '',
	self.tagnbr_st   := if(r.vehicle_tag_nbr<>'',STD.Str.CleanSpaces(r.vehicle_reg_state),''),
	self.b_did       := r.b_did,
	self.ultid       := r.ultid,
  self.orgid       := r.orgid,
  self.seleid      := r.seleid,
  self.proxid      := r.proxid,
  self.powid       := r.powid,
  self.empid       := r.empid,
  self.dotid       := r.dotid,
  self.ultscore    := r.ultscore,
  self.orgscore    := r.orgscore,
  self.selescore   := r.selescore,
  self.proxscore   := r.proxscore,
  self.powscore    := r.powscore,
  self.empscore    := r.empscore,
  self.dotscore    := r.dotscore,
  self.ultweight   := r.ultweight,
  self.orgweight   := r.orgweight,
  self.seleweight  := r.seleweight,
  self.proxweight  := r.proxweight,
  self.powweight   := r.powweight,
  self.empweight   := r.empweight,
  self.dotweight   := r.dotweight,	
	self             := l,
end;

base_did2 := join(file_Build_did, files.base_ecrash2v, 
                       left.accident_nbr = right.accident_nbr and
                       left.record_type = 'VEHICLE OWNER' and
											 left.vin = right.vehicle_id_nbr,
				   xf2(left,right), left outer, keep(1), hash);


layouts.SrchServ 	xf4(base_did2 l, files.base_ecrash4 r) := transform
	self.dlnbr_st := if(r.driver_dl_nbr <> '', STD.Str.CleanSpaces(r.driver_lic_st),l.dlnbr_st),
	self          := l,
end;

base_did4 := join(base_did2, files.base_ecrash4, 
                       left.accident_nbr = right.accident_nbr and
                       left.record_type = 'VEHICLE DRIVER' and
											 left.driver_license_nbr = right.driver_dl_nbr,
				   xf4(left,right), left outer, keep(1), hash);


layouts.SrchServ 	xf7(base_did4 l, files.base_ecrash7 r) := transform
	self.b_did       := if(r.b_did<>'',r.b_did,l.b_did),
	self.ultid       := if(r.ultid      <> 0, r.ultid     , 0),
  self.orgid       := if(r.orgid      <> 0, r.orgid     , 0),
  self.seleid      := if(r.seleid     <> 0, r.seleid    , 0),
  self.proxid      := if(r.proxid     <> 0, r.proxid    , 0),
  self.powid       := if(r.powid      <> 0, r.powid     , 0),
  self.empid       := if(r.empid      <> 0, r.empid     , 0),
  self.dotid       := if(r.dotid      <> 0, r.dotid     , 0),
  self.ultscore    := if(r.ultscore   <> 0, r.ultscore  , 0),
  self.orgscore    := if(r.orgscore	  <> 0, r.orgscore 	, 0),
  self.selescore   := if(r.selescore	<> 0, r.selescore	, 0),
  self.proxscore   := if(r.proxscore  <> 0, r.proxscore , 0),
  self.powscore    := if(r.powscore	  <> 0, r.powscore 	, 0),
  self.empscore    := if(r.empscore	  <> 0, r.empscore 	, 0),
  self.dotscore    := if(r.dotscore	  <> 0, r.dotscore 	, 0),
  self.ultweight   := if(r.ultweight  <> 0, r.ultweight , 0),
  self.orgweight   := if(r.orgweight  <> 0, r.orgweight , 0),
  self.seleweight  := if(r.seleweight	<> 0, r.seleweight, 0),
  self.proxweight  := if(r.proxweight	<> 0, r.proxweight, 0),
  self.powweight   := if(r.powweight  <> 0, r.powweight	, 0),
  self.empweight   := if(r.empweight 	<> 0, r.empweight	, 0),
  self.dotweight   := if(r.dotweight 	<> 0, r.dotweight , 0),
	self             := l,
end;

base_did7 := join(base_did4, files.base_ecrash7, 
                       left.accident_nbr = right.accident_nbr and
                       left.record_type = 'PROPERTY OWNER' and
											 left.cname = right.prop_owner_name,
														xf7(left,right), left outer, keep(1), hash);


layouts.SrchServ 	xf9(base_did7 l, files.base_ecrash9 r) := transform
	self             := l,
end;

base_did9 := join(base_did7, files.base_ecrash9, 
                       left.accident_nbr = right.accident_nbr and
                       left.record_type = 'WITNESS',
													xf9(left,right), left outer, keep(1), hash);

EXPORT file_BuildSS := base_did9;