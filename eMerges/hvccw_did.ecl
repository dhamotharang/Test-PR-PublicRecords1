import DID_Add, watchdog;


hv := file_hvccw_in; // + file_hvccw_base;

dist := distribute(hv,hash(lname,zip));

/*srt := sort(dist,lname_in, res_zip, file_id, source_state, title_in, fname_in, mname_in,
maiden_prior, name_suffix_in, resAddr1, resAddr2, res_city, res_state,
dob_str, LastDayVote, regDate, gender, DateLicense, HuntFishPerm, Hunt, Fish,
HomeState, race, CCWPermNum, -date_last_seen,date_first_seen, local);*/
srt := sort(dist,lname, zip, file_id, source_state, title, fname, mname,
name_suffix, prim_range,prim_name, predir,postdir, unit_desig,sec_range,
p_city_name, st,dob_str_in, LastDayVote, regDate_in, gender, DateLicense,
HuntFishPerm, Hunt, Fish,HomeState, race, CCWPermNum, -date_last_seen,
date_first_seen, local);

emerges.Layout_eMerge_In rollData(srt L, srt R) := transform
self.date_first_seen := if(r.date_first_seen < l.date_first_seen,r.date_first_seen,l.date_first_seen);
self.date_last_seen := if(r.date_last_seen > l.date_last_seen,r.date_last_seen,l.date_last_seen);
self := l;
end;

final_delta := rollup(srt,left.lname=right.lname and left.zip=right.zip and
left.file_id=right.file_id and left.source_state=right.source_state and left.title=right.title and
left.fname=right.fname and left.mname=right.mname and left.name_suffix=right.name_suffix and
left.prim_range=right.prim_range and left.prim_name=right.prim_name and left.predir=right.predir and
left.postdir=right.postdir and left.unit_desig=right.unit_desig and left.sec_range=right.sec_range and
left.p_city_name=right.p_city_name and left.st=right.st and left.dob_str_in=right.dob_str_in and
left.LastDayVote=right.LastDayVote and left.regDate_in=right.regDate_in and left.gender=right.gender and
left.DateLicense=right.DateLicense and left.HuntFishPerm=right.HuntFishPerm and left.Hunt=right.Hunt and
left.Fish=right.Fish and left.HomeState=right.HomeState and left.race=right.race and
left.CCWPermNum=right.CCWPermNum,
						rollData(left,right),local);

bt_rec := record
  unsigned6 did := 0;
  unsigned2 did_score := 0;
  Layout_emerge_in;
end;

bt_rec addDID(layout_emerge_in L):= transform
 self := l;
end;

hv_did := project(final_delta,addDID(left));

matchset := ['A','D','P','Z','G'];

//DID file
DID_Add.MAC_Match_Flex(hv_did,matchset,junk,dob_str_in,fname,mname,
	lname,name_suffix,prim_range,prim_name,sec_range,zip,st,phone,
	did,bt_rec,true,did_score,
	75,hv_out)

outrec := layout_emerge_in;

// add functions to fix regdate 20040318
string8 fixregdate(string8 date, string8 mydob, integer4 legal_age) :=
  map(date <> '18000101' and date <> '19000101' and date <> '' and
	  length(stringlib.StringFilterOut(date, '0123456789 ')) = 0 =>
	map((integer)(date[1..4]) >= ((integer)(mydob[1..4]) + legal_age) and
		date[1..8] <= stringlib.getdateyyyymmdd()[1..8] and date[1..4] >= '1776' =>
		map((integer)(date[5..6]) >= 1 and (integer)(date[5..6]) <= 12 =>
			map((integer)(date[7..8]) >= 1 and (integer)(date[7..8]) <= 31 => stringlib.StringFindReplace(date,' ','0'), stringlib.StringFindReplace(date[1..6] + '00',' ','0')),
		date[1..4] + '0000'),
	map((integer)(date[5..8]) >= ((integer)(mydob[1..4]) + legal_age) and
		(date[5..8] + date[1..4]) <= stringlib.getdateyyyymmdd()[1..8] and date[5..8] >= '1776' =>
		map((integer)(date[1..2]) >= 1 and (integer)(date[1..2]) <= 12 =>
			map((integer)(date[3..4]) >= 1 and (integer)(date[3..4]) <= 31 => stringlib.StringFindReplace(date[5..8] + date[1..4], ' ','0'), stringlib.StringFindReplace(date[5..8] + date[1..2] + '00',' ','0')),
		date[5..8] + '0000'), '        ')), '        ');

string8 fixdobdate(string8 date) :=
	map((integer)(date[1..4]) >= 1776 and
		date[1..8] <= stringlib.getdateyyyymmdd()[1..8] and
		length(stringlib.StringFilterOut(date, '0123456789')) = 0 =>
		map((integer)(date[5..6]) >= 1 and (integer)(date[5..6]) <= 12 =>
			map((integer)(date[7..8]) >= 1 and (integer)(date[7..8]) <= 31 => stringlib.StringFindReplace(date,' ','0'), stringlib.StringFindReplace(date[1..6] + '00',' ','0')),
		date[1..4] + '0000'),
	map((integer)(date[5..8]) >= 1776 and
		(date[5..8] + date[1..4]) <= stringlib.getdateyyyymmdd()[1..8] and
		length(stringlib.StringFilterOut(date, '0123456789')) = 0 =>
		map((integer)(date[1..2]) >= 1 and (integer)(date[1..2]) <= 12 =>
			map((integer)(date[3..4]) >= 1 and (integer)(date[3..4]) <= 31 => stringlib.StringFindReplace(date[5..8] + date[1..4], ' ','0'), stringlib.StringFindReplace(date[5..8] + date[1..2] + '00',' ','0')),
		date[5..8] + '0000'), '        '));

string8 fixotherdate(string8 date, string8 mydob, integer4 legal_age) :=
  map(date <> '18000101' and date <> '19000101' and date <> '' and
	  length(stringlib.StringFilterOut(date, '0123456789 ')) = 0 =>
	map((integer)(date[1..4]) >= ((integer)(mydob[1..4]) + legal_age) and date[1..4] >= '1776' and
		date[1..8] <= stringlib.getdateyyyymmdd()[1..8] =>
				map((integer)(date[5..6]) >= 1 and (integer)(date[5..6]) <= 12 =>
					map((integer)(date[7..8]) >= 1 and (integer)(date[7..8]) <= 31 =>
						date,
						stringlib.StringFindReplace(date[1..6] + '00',' ','0')),
		date[1..4]), ' '), '        ');

outrec forthem(bt_rec l) := transform
	self.DID_out := if (l.did = 0,'',intformat(l.did, 12, 1));
	self.score := intformat(l.did_score,3,1);
	self.best_ssn := '';
	self.regDate := fixregdate(l.regDate_in,fixdobdate(l.dob_str_in),
					map(trim(l.file_id) = 'VOTE' => 17, trim(l.file_id) = 'HUNT' => 0,
						trim(l.file_id) = 'CCW' => 17, trim(l.file_id) = 'CENS' => 0, 0));
	self.dob_str  := fixdobdate(l.dob_str_in);
	self.DateOfContr := fixotherdate(l.DateOfContr_in,fixdobdate(l.dob_str_in),
					map(trim(l.file_id) = 'VOTE' => 17, trim(l.file_id) = 'HUNT' => 0,
						trim(l.file_id) = 'CCW' => 17, trim(l.file_id) = 'CENS' => 0, 0));
    self.LastDayVote := fixotherdate(l.LastDayVote_in,fixdobdate(l.dob_str_in),
					map(trim(l.file_id) = 'VOTE' => 17, trim(l.file_id) = 'HUNT' => 0,
						trim(l.file_id) = 'CCW' => 17, trim(l.file_id) = 'CENS' => 0, 0));
    self.DateLicense := fixotherdate(l.DateLicense_in,fixdobdate(l.dob_str_in),
					map(trim(l.file_id) = 'VOTE' => 17, trim(l.file_id) = 'HUNT' => 0,
						trim(l.file_id) = 'CCW' => 17, trim(l.file_id) = 'CENS' => 0, 0));
    self.RegExpDate := l.RegExpDate_in;
    self.CCWRegDate := fixotherdate(l.CCWRegDate_in,fixdobdate(l.dob_str_in),
					map(trim(l.file_id) = 'VOTE' => 17, trim(l.file_id) = 'HUNT' => 0,
						trim(l.file_id) = 'CCW' => 17, trim(l.file_id) = 'CENS' => 0, 0));
    self.CCWExpDate := l.CCWExpDate_in;
	self := l;
end;

withdid_yes := project(hv_out(did <> 0), forthem(left));
withdid_no := project(hv_out(did = 0), forthem(left));

dw := watchdog.File_Best;

outrec getssn(dw L, withdid_yes R) := transform
	self.best_ssn := intformat((integer)L.ssn,9,1);
	self := R;
end;

export hvccw_did := join(distribute(dw,hash(did)),distribute(withdid_yes,hash((integer)did_out)),left.did = (integer)right.did_out,getssn(LEFT,RIGHT),local) +
					withdid_no;
