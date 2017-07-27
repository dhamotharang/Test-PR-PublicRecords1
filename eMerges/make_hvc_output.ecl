#workunit ('name', 'Make emerges output files ' + emerges.version);
import ut,census_Data,codes;

hvc0 := emerges.file_hvccw_building;

withCounty := record
	hvc0;
	string18	county_name;
end;

//all records with a file_id = "HUNT" do not have to be hunt records, they can be hunt and/or fish
withCounty getCounty(hvc0 L, census_data.File_Fips2County R) := transform
 self.hunt := if(trim(l.ComboSuper + l.Sportsman + l.Trap + l.Archery + l.Muzzle + l.Drawing + l.Day1 + l.Day3 + 
				l.Day7 + l.Day14to15 + l.DayFiller + l.SeasonAnnual + l.LifeTimePermit + l.Deer + l.Bear + l.Elk + 
				l.Moose + l.Buffalo + l.Antelope + l.SikeBull + l.Bighorn + l.Javelina + l.Cougar + l.Anterless + 
				l.Pheasant + l.Goose + l.Duck + l.Turkey + l.SnowMobile + l.BigGame + l.SkiPass + l.MigBird + 
				l.SmallGame + l.Sturgeon2 + l.Gun + l.Bonus + l.Lottery + l.OtherBirds + l.hunt) != '', 'Y', '');
 self.fish  := if(trim(l.ComboSuper + l.Sportsman + l.Salmon + l.Freshwater + l.Saltwater + l.LakesandResevoirs + 
				l.SetLineFish + l.Trout + l.FallFishing + l.Steelhead + l.WhiteJubHerring + l.Sturgeon + 
				l.ShellfishCrab + l.ShellfishLobster + l.fish) != '' or l.file_id = 'FISH', 'Y', '');

	self.county_name := R.county_name;
	self := L;
end;

hvc := join(hvc0,census_data.File_Fips2County,left.county = right.county_fips and
				left.ace_fips_st = right.state_code,getCounty(LEFT,RIGHT),
				left outer, lookup);

/////////////////////////////////////////////////////////////////////////////////				
// -- Convert to hunters layout
/////////////////////////////////////////////////////////////////////////////////				

emerges.layout_hunters_out convert2Hunt(hvc l):= transform
 self.hunt := map(l.hunt = 'Y' => 'Y', l.fish = 'Y' => '', 'Y'); 
 self.fish := l.fish;
 self.license_type_mapped := map(self.hunt = 'Y' and self.fish = 'Y' => 'Hunting and Fishing',
						   self.fish = 'Y' => 'Fishing',
						   'Hunting');
 self.dob := L.dob_str;
 self := l;
end;

hunt_temp := project(hvc(file_id = 'HUNT' or file_id = 'FISH'),convert2Hunt(left));
hunt_dist := distribute(hunt_temp,hash(lname,zip));

hunt_srt := sort(hunt_dist,lname, zip, file_id, source_state, title, fname, mname,
name_suffix, prim_range,prim_name, predir,postdir, unit_desig,sec_range,
p_city_name, st,dob, regDate, gender, DateLicense, 
HuntFishPerm, Hunt, Fish,HomeState, race, -date_last_seen,
date_first_seen, local);

emerges.layout_hunters_out hunt_rollData(hunt_srt L, hunt_srt R) := transform
self.date_first_seen := if(r.date_first_seen < l.date_first_seen,r.date_first_seen,l.date_first_seen);
self.date_last_seen := if(r.date_last_seen > l.date_last_seen,r.date_last_seen,l.date_last_seen);
self := l; 
end;

hunt_out := rollup(hunt_srt,left.lname=right.lname and left.zip=right.zip and 
left.file_id=right.file_id and left.source_state=right.source_state and left.title=right.title and 
left.fname=right.fname and left.mname=right.mname and left.name_suffix=right.name_suffix and 
left.prim_range=right.prim_range and left.prim_name=right.prim_name and left.predir=right.predir and
left.postdir=right.postdir and left.unit_desig=right.unit_desig and left.sec_range=right.sec_range and
left.p_city_name=right.p_city_name and left.st=right.st and left.dob=right.dob and 
left.regDate=right.regDate and left.gender=right.gender and 
left.DateLicense=right.DateLicense and left.HuntFishPerm=right.HuntFishPerm and left.Hunt=right.Hunt and 
left.Fish=right.Fish and left.HomeState=right.HomeState and left.race=right.race,
						hunt_rollData(left,right),local);
						


/////////////////////////////////////////////////////////////////////////////////
// -- Convert to voters layout
/////////////////////////////////////////////////////////////////////////////////
string2 fixpoliparty(string2 poliparty) :=
	map((integer)poliparty > 0 and (integer)poliparty < 10 => (string1)(integer)poliparty + ' ',
	    (integer)poliparty > 9 and (integer)poliparty < 61 => (string2)(integer)poliparty,
		' ');

emerges.layout_voters_out convert2Vote(hvc l):= transform
 self.dob := L.dob_str;
 self.poliparty_mapped := '';
 self.voterstatus_mapped := '';
 self.active_status_mapped := '';
 self.poliparty := fixpoliparty(l.poliparty);
 self := l;
end;

vote_temp := project(hvc(file_id = 'VOTE'),convert2Vote(left));

vote_temp map_party(vote_temp L, codes.File_Codes_V3_In R) := transform
	self.poliparty_mapped := R.long_desc;
	self := L;
end;

vote_temp2 := join(vote_temp,codes.File_Codes_V3_In(file_name = 'EMERGES_HVC' and field_name = 'POLITICALPARTY'),
			trim((string)(integer)left.poliparty) = trim((string)(integer)right.code),map_party(LEFT,RIGHT),left outer,lookup);
			
vote_temp2 map_status(vote_temp2 L, codes.File_Codes_V3_In R) := transform
	self.voterStatus_Mapped := R.long_desc;
	self := l;
end;

vote_temp3 := join(vote_temp2,codes.File_Codes_V3_In(file_name = 'EMERGES_HVC' and
				field_name = 'VOTERSTATUS'), trim((string)(integer)left.voterstatus) = trim((string)(integer)right.code),
				map_status(LEFT,RIGHT),left outer,lookup);
				
vote_temp3 map_act_status(vote_temp3 L, codes.file_codes_v3_in R) := transform
	self.active_status_mapped := R.long_desc;
	self := l;
end;

vote_temp4 := join(vote_temp3,codes.File_Codes_V3_In(file_name ='EMERGES_HVC' and
				field_name = 'ACTIVEORINACTIVE'),
				trim(stringlib.stringtouppercase(left.active_status)) = trim(right.code),
				map_act_status(LEFT,RIGHT),left outer, lookup);
				
			
vote_dist := distribute(vote_temp4,hash(lname,zip));

vote_srt := sort(vote_dist,lname, zip, file_id, source_state, title, fname, mname,
name_suffix, prim_range,prim_name, predir,postdir, unit_desig,sec_range,
p_city_name, st,dob, LastDayVote, regDate, gender, 
race, -date_last_seen,date_first_seen, local);

emerges.layout_voters_out vote_rollData(emerges.layout_voters_out L, emerges.layout_voters_out R) := transform
self.date_first_seen := if(r.date_first_seen < l.date_first_seen,r.date_first_seen,l.date_first_seen);
self.date_last_seen := if(r.date_last_seen > l.date_last_seen,r.date_last_seen,l.date_last_seen);
self := l; 
end;

vote_out := rollup(vote_srt,left.lname=right.lname and left.zip=right.zip and 
left.file_id=right.file_id and left.source_state=right.source_state and left.title=right.title and 
left.fname=right.fname and left.mname=right.mname and left.name_suffix=right.name_suffix and 
left.prim_range=right.prim_range and left.prim_name=right.prim_name and left.predir=right.predir and
left.postdir=right.postdir and left.unit_desig=right.unit_desig and left.sec_range=right.sec_range and
left.p_city_name=right.p_city_name and left.st=right.st and left.dob=right.dob and 
left.LastDayVote=right.LastDayVote and left.regDate=right.regDate and left.gender=right.gender and 
left.race=right.race,
						vote_rollData(left,right),local);





/////////////////////////////////////////////////////////////////////////////////
// -- Convert to ccw layout
/////////////////////////////////////////////////////////////////////////////////
emerges.layout_ccw_out convert2Ccw(hvc l):= transform
 self.dob := l.dob_str;
 self := l;
end;

ccw_temp := project(hvc(file_id = 'CCW '),convert2Ccw(left));
ccw_dist := distribute(ccw_temp,hash(lname,zip));

ccw_srt := sort(ccw_dist,lname, zip, file_id, source_state, title, fname, mname,
name_suffix, prim_range,prim_name, predir,postdir, unit_desig,sec_range,
p_city_name, st,dob, regDate, gender, race, CCWPermNum, -date_last_seen,
date_first_seen, local);

emerges.layout_ccw_out ccw_rollData(ccw_srt L, ccw_srt R) := transform
self.date_first_seen := if(r.date_first_seen < l.date_first_seen,r.date_first_seen,l.date_first_seen);
self.date_last_seen := if(r.date_last_seen > l.date_last_seen,r.date_last_seen,l.date_last_seen);
self := l; 
end;

ccw_rollup := rollup(ccw_srt,left.lname=right.lname and left.zip=right.zip and 
left.file_id=right.file_id and left.source_state=right.source_state and left.title=right.title and 
left.fname=right.fname and left.mname=right.mname and left.name_suffix=right.name_suffix and 
left.prim_range=right.prim_range and left.prim_name=right.prim_name and left.predir=right.predir and
left.postdir=right.postdir and left.unit_desig=right.unit_desig and left.sec_range=right.sec_range and
left.p_city_name=right.p_city_name and left.st=right.st and left.dob=right.dob and 
left.regDate=right.regDate and left.gender=right.gender and 
left.race=right.race and left.CCWPermNum=right.CCWPermNum,
			ccw_rollData(left,right),local);
// add unique id to ccw out file
Layout_ccw_Local := RECORD
UNSIGNED6 record_id := 0;
emerges.layout_ccw_out;
END;

// Add unique record id to DNB file
Layout_ccw_Local AddRecordID(emerges.Layout_ccw_out L) := TRANSFORM
SELF := L;
END;

ccw_addrecid := PROJECT(ccw_rollup, AddRecordID(LEFT));

ut.MAC_Sequence_Records(ccw_addrecid, record_id, ccw_Seq)

emerges.layout_ccw_out formatout(Layout_ccw_Local L) := TRANSFORM
self.unique_id := intformat(l.record_id,8,1);
SELF := L;
END;

ccw_uniqueid := PROJECT(ccw_Seq, formatout(LEFT));
ccw_out := sort(ccw_uniqueid,unique_id);

ut.MAC_SF_BuildProcess(hunt_out,'~thor_data400::base::emerges_hunt',a);
ut.MAC_SF_BuildProcess(vote_out,'~thor_data400::base::emerges_voters',b);
ut.MAC_SF_BuildProcess(ccw_out,'~thor_data400::base::emerges_ccw',c);

export make_hvc_output := parallel(a,b,c);