/* Code Finds Changes from day to day
   
   base records before a specified day
   base records after a specified day
   
   records added between a time frame
   records deleted between a time frame
   
   base records added match/new when compared to the records deleted and lost records by phone and phone+name(fsn)
   records added match/new when compared to the records deleted and lost records by phone and phone+name(fsn)
   
   count of unique phones per vendor on day to day basis
   THIS HAS TO BE CHANGED IF YOU DO NOT WANT 07/2009 by developer
   STARTS AT line 189
   
   records with addresses changes (samples only use phones that appear once in gong that was current before specified day)
*/

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

export _fn_Gongreload_verification(string strld, string endrld, string rvendor, string bystate = '') := function
#workunit('name', 'reload stats for ' + rvendor)

baserecs_before_reload := if(bystate = '', gong_v2.file_gongmaster(vendor = rvendor and filedate[1..8] < strld and (deletion_date >= strld or current_record_flag = 'Y')),
							gong_v2.file_gongmaster(state = bystate and filedate[1..8] < strld and (deletion_date >= strld or current_record_flag = 'Y')));

baserecs_after_reload := if(bystate = '', gong_v2.file_gongmaster(vendor = rvendor and filedate[1..8] <= endrld and (deletion_date > endrld or current_record_flag = 'Y')),
							gong_v2.file_gongmaster(state = bystate and filedate[1..8] <= endrld and (deletion_date > endrld or current_record_flag = 'Y')));

addrecs_reload := if(bystate = '', gong_v2.file_gongmaster(vendor = rvendor and dt_first_seen between strld and endrld),
							gong_v2.file_gongmaster(state = bystate and dt_first_seen between strld and endrld));

delrecs_reload := if(bystate = '', gong_v2.file_gongmaster(vendor = rvendor and dt_last_seen between strld and endrld),
							gong_v2.file_gongmaster(state = bystate and dt_last_seen between strld and endrld));


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

added := if(bystate = '', gong_v2.file_gongmaster(vendor = rvendor and dt_first_seen between strld and endrld),
				gong_v2.file_gongmaster(state = bystate and dt_first_seen between strld and endrld));
deleted := if(bystate = '', gong_v2.file_gongmaster(vendor = rvendor and dt_last_seen between strld and endrld),
				gong_v2.file_gongmaster(state = bystate and dt_last_seen between strld and endrld));

addDED := dedup(added(phone10 <> '' and phone10[1..3] <> '000' and phone10[4..10] <> '0000000'), phone10,  all);
delDED := dedup(deleted(phone10 <> '' and phone10[1..3] <> '000' and phone10[4..10] <> '0000000'), phone10,  all);

lay := record string phone10; string flag; end;

jn := join(addDED, delDED, left.phone10 = right.phone10, 
							transform(lay, 
										   self.phone10 := if(left.phone10 <> '', left.phone10, right.phone10),
										   self.flag := if(left.phone10 = right.phone10, 'MATCH',
															if(left.phone10<>'', 'ADDED NOT EMPTY', 'DELETED NOT EMPTY')),
										   self := left), full outer);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

base_before_reload := if(bystate = '', dedup(gong_v2.file_gongmaster(vendor = rvendor and filedate[1..8] < strld and (deletion_date >= strld or current_record_flag = 'Y')), phone10, all),
							dedup(gong_v2.file_gongmaster(state = bystate and filedate[1..8] < strld and (deletion_date >= strld or current_record_flag = 'Y')), phone10, all));

base_after_reload := if(bystate = '', dedup(gong_v2.file_gongmaster(vendor = rvendor and filedate[1..8] <= endrld and (deletion_date > endrld or current_record_flag = 'Y')), phone10, all),
							dedup(gong_v2.file_gongmaster(state = bystate and filedate[1..8] <= endrld and (deletion_date > endrld or current_record_flag = 'Y')), phone10, all));

jn2 := join(base_before_reload, base_after_reload, left.phone10 = right.phone10, 
							transform(lay, 
										   self.phone10 := if(left.phone10 <> '', left.phone10, right.phone10),
										   self.flag := if(left.phone10 = right.phone10, 'MATCH',
															if(left.phone10 <> '', 'BEFORE NOT EMPTY', 'AFTER NOT EMPTY')),
										   self := left), full outer); 

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

addNMDED := dedup(distribute(added(phone10 <> '' and fsn <> ''), hash(phone10)), phone10, fsn, all);
delNMDED := dedup(distribute(deleted(phone10 <> '' and fsn <> ''), hash(phone10)), phone10, fsn, all);

laynm := record string phone10; string fsn; string flag; end;

jnnm := join(addNMDED, delNMDED, left.phone10 = right.phone10 and left.fsn = right.fsn, 
							transform(laynm,self.fsn := if(left.fsn <> '', left.fsn, right.fsn),
										   self.phone10 := if(left.phone10 <> '', left.phone10, right.phone10),
										   self.flag := if(left.phone10 = right.phone10 and left.fsn = right.fsn, 'MATCH',
															if(left.phone10 <> '' and left.fsn <> '', 'ADDED NOT EMPTY', 'DELETED NOT EMPTY')),
										   self := left), full outer);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

base_before_reloadnm := if(bystate = '', dedup(distribute(gong_v2.file_gongmaster(phone10 <> '' and phone10[1..3] <> '000' and phone10[4..10] <> '0000000' and fsn <> '' and vendor = rvendor and filedate[1..8] < strld and (deletion_date >= strld or deletion_date = '')), hash(phone10, fsn)), phone10, fsn, all),
							dedup(distribute(gong_v2.file_gongmaster(phone10 <> '' and phone10[1..3] <> '000' and phone10[4..10] <> '0000000' and fsn <> '' and bystate = state and filedate[1..8] < strld and (deletion_date >= strld or deletion_date = '')), hash(phone10, fsn)), phone10, fsn, all));
base_after_reloadnm := if(bystate = '', dedup(distribute(gong_v2.file_gongmaster(phone10 <> '' and phone10[1..3] <> '000' and phone10[4..10] <> '0000000' and fsn <> '' and vendor = rvendor and filedate[1..8] <= endrld and (deletion_date > endrld or deletion_date = '')), hash(phone10, fsn)), phone10, fsn, all),
							dedup(distribute(gong_v2.file_gongmaster(phone10 <> '' and phone10[1..3] <> '000' and phone10[4..10] <> '0000000' and fsn <> '' and bystate = state and filedate[1..8] <= endrld and (deletion_date > endrld or deletion_date = '')), hash(phone10, fsn)), phone10, fsn, all));


jn2nm := join(base_before_reloadnm, base_after_reloadnm, left.phone10 = right.phone10 AND left.fsn = right.fsn, 
							transform(laynm, 
										   self.phone10 := if(left.phone10 <> '', left.phone10, right.phone10),
										   self.fsn := if(left.fsn <> '', left.fsn, right.fsn),
										   self.flag := if(left.phone10 = right.phone10 and left.fsn = right.fsn, 'MATCH',
															if(left.phone10 <> '' and left.fsn <> '', 'BEFORE NOT EMPTY', 'AFTER NOT EMPTY')),
										   self := left), full outer);
										   
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


findthemadds := gong_v2.File_GongMaster(dt_first_seen between strld and endrld and if(bystate = '', vendor = rvendor, state = bystate));

uniquephones_deleted := table(gong_v2.File_GongMaster(dt_last_seen between strld and endrld and if(bystate = '', vendor = rvendor, state = bystate) and phone10 <> ''  and phone10[1..3] <>  '000' and phone10[4..10] <> '0000000'), 
		{dt_first_seen, dt_last_seen, vendor, fsn, phone10, hseno,  hsesx,  strt,  locnm,  state,  zip,  orig_loc,  orig_state,  orig_hseno,  orig_hsesx,  orig_strt,  orig_zip, ct := count(group)}, phone10)(ct = 1);

addrlay := record 
     string addrM;
     string removed;
     string added;
     string phone10;
     string fsn;
     string hseno, 
     string right_hseno, 
     string hsesx, 
     string right_hsesx, 
     string strt, 
     string right_strt, 
     string locnm, 
     string right_locnm, 
     string state, 
     string right_state, 
     string zip, 
     string right_zip, 
     string orig_loc, 
     string right_orig_loc, 
     string orig_state, 
     string right_orig_state, 
     string orig_hseno, 
     string right_orig_hseno, 
     string orig_hsesx, 
     string right_orig_hsesx, 
     string orig_strt, 
     string right_orig_strt, 
     string orig_zip,
     string right_orig_zip 
end;


jn_uniquephonesbefore_to_adds := join(uniquephones_deleted, findthemadds,
						left.fsn = right.fsn and left.phone10 = right.phone10,
						transform(addrlay, 
						self.addrM := if(
						left.hseno <> right.hseno or 
						left.hsesx <> right.hsesx or 
						left.strt <> right.strt or 
						left.locnm <> right.locnm or 
						left.state <> right.state or 
						left.zip <> right.zip or 
						left.orig_loc <> right.orig_loc or 
						left.orig_state <> right.orig_state or 
						left.orig_hseno <> right.orig_hseno or 
						left.orig_hsesx <> right.orig_hsesx or 
						left.orig_strt <> right.orig_strt or 
						left.orig_zip <> right.orig_zip, 'C', 'S'),
						self.removed := left.dt_last_seen;
						self.added := right.dt_first_seen;
						self.right_hseno := right.hseno; 
						self.right_hsesx := right.hsesx; 
						self.right_strt := right.strt; 
						self.right_locnm := right.locnm; 
						self.right_state := right.state; 
						self.right_zip := right.zip; 
						self.right_orig_loc := right.orig_loc; 
						self.right_orig_state := right.orig_state; 
						self.right_orig_hseno := right.orig_hseno; 
						self.right_orig_hsesx := right.orig_hsesx; 
						self.right_orig_strt := right.orig_strt; 
						self.right_orig_zip := right.orig_zip;
						self := left));

srtjnaddrreloads := sort(jn_uniquephonesbefore_to_adds, record);

tbaddr := table(srtjnaddrreloads, {nomatch_hseno  := count(group, hseno   <> right_hseno), 
						 nomatch_hsesx  := count(group, hsesx   <> right_hsesx), 
						 nomatch_strt  := count(group, strt   <> right_strt), 
						 nomatch_locnm  := count(group, locnm   <> right_locnm), 
						 nomatch_state  := count(group, state   <> right_state), 
						 nomatch_zip  := count(group, zip   <> right_zip), 
						 nomatch_orig_loc  := count(group, orig_loc   <> right_orig_loc), 
						 nomatch_orig_state  := count(group, orig_state   <> right_orig_state), 
						 nomatch_orig_hseno  := count(group, orig_hseno   <> right_orig_hseno), 
						 nomatch_orig_hsesx  := count(group, orig_hsesx   <> right_orig_hsesx), 
						 nomatch_orig_strt  := count(group, orig_strt   <> right_orig_strt), 
						 nomatch_orig_zip := count(group, orig_zip  <> right_orig_zip)}, few);



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

tbphones := table(dedup(gong_v2.File_GongMaster, vendor, phone10, all), {string1 reload_flag := if(vendor in ['0x09','0x0a','0x14','0x6e','0x86','0x8c','0x1e'], 'x', ''), 
											string6 vendor := vendor, 
											curr_before_20090715_applied := count(group, filedate[1..8] < '20090715' and (deletion_date > '20090715' or current_record_flag = 'Y')),
											curr_after_20090715_applied := count(group, filedate[1..8] <= '20090715' and (deletion_date > '20090715' or current_record_flag = 'Y')),
											deleted_on_20090715 := count(group, filedate[1..8] <= '20090715' and (deletion_date = '20090715')),

											curr_before_20090716_applied := count(group, filedate[1..8] < '20090716' and (deletion_date > '20090716' or current_record_flag = 'Y')),
											curr_after_20090716_applied := count(group, filedate[1..8] <= '20090716' and (deletion_date > '20090716' or current_record_flag = 'Y')),
											deleted_on_20090716 := count(group, filedate[1..8] <= '20090716' and (deletion_date = '20090716')),

											curr_before_20090717_applied := count(group, filedate[1..8] < '20090717' and (deletion_date > '20090717' or current_record_flag = 'Y')),
											curr_after_20090717_applied := count(group, filedate[1..8] <= '20090717' and (deletion_date > '20090717' or current_record_flag = 'Y')),
											deleted_on_20090717 := count(group, filedate[1..8] <= '20090717' and (deletion_date = '20090717')),

											curr_before_20090720_applied := count(group, filedate[1..8] < '20090720' and (deletion_date > '20090720' or current_record_flag = 'Y')),
											curr_after_20090720_applied := count(group, filedate[1..8] <= '20090720' and (deletion_date > '20090720' or current_record_flag = 'Y')),
											deleted_on_20090720 := count(group, filedate[1..8] <= '20090720' and (deletion_date = '20090720')),

											curr_before_20090721_applied := count(group, filedate[1..8] < '20090721' and (deletion_date > '20090721' or current_record_flag = 'Y')),
											curr_after_20090721_applied := count(group, filedate[1..8] <= '20090721' and (deletion_date > '20090721' or current_record_flag = 'Y')),
											deleted_on_20090721 := count(group, filedate[1..8] <= '20090721' and (deletion_date = '20090721')),

											curr_before_20090722_applied := count(group, filedate[1..8] < '20090722' and (deletion_date > '20090722' or current_record_flag = 'Y')),
											curr_after_20090722_applied := count(group, filedate[1..8] <= '20090722' and (deletion_date > '20090722' or current_record_flag = 'Y')),
											deleted_on_20090722 := count(group, filedate[1..8] <= '20090722' and (deletion_date = '20090722')),

											curr_before_20090723_applied := count(group, filedate[1..8] < '20090723' and (deletion_date > '20090723' or current_record_flag = 'Y')),
											curr_after_20090723_applied := count(group, filedate[1..8] <= '20090723' and (deletion_date > '20090723' or current_record_flag = 'Y')),
											deleted_on_20090723 := count(group, filedate[1..8] <= '20090723' and (deletion_date = '20090723')),

											curr_before_20090724_applied := count(group, filedate[1..8] < '20090724' and (deletion_date > '20090724' or current_record_flag = 'Y')),
											curr_after_20090724_applied := count(group, filedate[1..8] <= '20090724' and (deletion_date > '20090724' or current_record_flag = 'Y')),
											deleted_on_20090724 := count(group, filedate[1..8] <= '20090724' and (deletion_date = '20090724')),

											curr_before_20090727_applied := count(group, filedate[1..8] < '20090727' and (deletion_date > '20090727' or current_record_flag = 'Y')),
											curr_after_20090727_applied := count(group, filedate[1..8] <= '20090727' and (deletion_date > '20090727' or current_record_flag = 'Y')),
											deleted_on_20090727 := count(group, filedate[1..8] <= '20090727' and (deletion_date = '20090727')),

											curr_before_20090728_applied := count(group, filedate[1..8] < '20090728' and (deletion_date > '20090728' or current_record_flag = 'Y')),
											curr_after_20090728_applied := count(group, filedate[1..8] <= '20090728' and (deletion_date > '20090728' or current_record_flag = 'Y')),
											deleted_on_20090728 := count(group, filedate[1..8] <= '20090728' and (deletion_date = '20090728')),

											curr_before_20090729_applied := count(group, filedate[1..8] < '20090729' and (deletion_date > '20090729' or current_record_flag = 'Y')),
											curr_after_20090729_applied := count(group, filedate[1..8] <= '20090729' and (deletion_date > '20090729' or current_record_flag = 'Y')),
											deleted_on_20090729 := count(group, filedate[1..8] <= '20090729' and (deletion_date = '20090729')),

											curr_before_20090730_applied := count(group, filedate[1..8] < '20090730' and (deletion_date > '20090730' or current_record_flag = 'Y')),
											curr_after_20090730_applied := count(group, filedate[1..8] <= '20090730' and (deletion_date > '20090730' or current_record_flag = 'Y')),
											deleted_on_20090730 := count(group, filedate[1..8] <= '20090730' and (deletion_date = '20090730')),

											curr_before_20090731_applied := count(group, filedate[1..8] < '20090731' and (deletion_date > '20090731' or current_record_flag = 'Y')),
											curr_after_20090731_applied := count(group, filedate[1..8] <= '20090731' and (deletion_date > '20090731' or current_record_flag = 'Y')),
											deleted_on_20090731 := count(group, filedate[1..8] <= '20090731' and (deletion_date = '20090731')),

											curr_before_20090801_applied := count(group, filedate[1..8] < '20090801' and (deletion_date > '20090801' or current_record_flag = 'Y')),
											curr_after_20090801_applied := count(group, filedate[1..8] <= '20090801' and (deletion_date > '20090801' or current_record_flag = 'Y')),
											deleted_on_20090801 := count(group, filedate[1..8] <= '20090801' and (deletion_date = '20090801')),

											curr_before_20090803_applied := count(group, filedate[1..8] < '20090803' and (deletion_date > '20090803' or current_record_flag = 'Y')),
											curr_after_20090803_applied := count(group, filedate[1..8] <= '20090803' and (deletion_date > '20090803' or current_record_flag = 'Y')),
											deleted_on_20090803 := count(group, filedate[1..8] <= '20090803' and (deletion_date = '20090803')),

											curr_before_20090804_applied := count(group, filedate[1..8] < '20090804' and (deletion_date > '20090804' or current_record_flag = 'Y')),
											curr_after_20090804_applied := count(group, filedate[1..8] <= '20090804' and (deletion_date > '20090804' or current_record_flag = 'Y')),
											deleted_on_20090804 := count(group, filedate[1..8] <= '20090804' and (deletion_date = '20090804')),

											curr_before_20090805_applied := count(group, filedate[1..8] < '20090805' and (deletion_date > '20090805' or current_record_flag = 'Y')),
											curr_after_20090805_applied := count(group, filedate[1..8] <= '20090805' and (deletion_date > '20090805' or current_record_flag = 'Y')),
											deleted_on_20090805 := count(group, filedate[1..8] <= '20090805' and (deletion_date = '20090805')),

											curr_before_20090806_applied := count(group, filedate[1..8] < '20090806' and (deletion_date > '20090806' or current_record_flag = 'Y')),
											curr_after_20090806_applied := count(group, filedate[1..8] <= '20090806' and (deletion_date > '20090806' or current_record_flag = 'Y')),
											deleted_on_20090806 := count(group, filedate[1..8] <= '20090806' and (deletion_date = '20090806')),

											curr_before_20090807_applied := count(group, filedate[1..8] < '20090807' and (deletion_date > '20090807' or current_record_flag = 'Y')),
											curr_after_20090807_applied := count(group, filedate[1..8] <= '20090807' and (deletion_date > '20090807' or current_record_flag = 'Y')),
											deleted_on_20090807 := count(group, filedate[1..8] <= '20090807' and (deletion_date = '20090807')),

											curr_before_20090808_applied := count(group, filedate[1..8] < '20090808' and (deletion_date > '20090808' or current_record_flag = 'Y')),
											curr_after_20090808_applied := count(group, filedate[1..8] <= '20090808' and (deletion_date > '20090808' or current_record_flag = 'Y')),
											deleted_on_20090808 := count(group, filedate[1..8] <= '20090808' and (deletion_date = '20090808')),
											
											curr_before_20090810_applied := count(group, filedate[1..8] < '20090810' and (deletion_date > '20090810' or current_record_flag = 'Y')),
											curr_after_20090810_applied := count(group, filedate[1..8] <= '20090810' and (deletion_date > '20090810' or current_record_flag = 'Y')),
											deleted_on_20090810 := count(group, filedate[1..8] <= '20090810' and (deletion_date = '20090810')),
											
											curr_before_20090811_applied := count(group, filedate[1..8] < '20090811' and (deletion_date > '20090811' or current_record_flag = 'Y')),
											curr_after_20090811_applied := count(group, filedate[1..8] <= '20090811' and (deletion_date > '20090811' or current_record_flag = 'Y')),
											deleted_on_20090811 := count(group, filedate[1..8] <= '20090811' and (deletion_date = '20090811')),
											
											NV_curr_before_20090807_applied := count(group, st = 'NV' and filedate[1..8] < '20090807' and (deletion_date > '20090807' or current_record_flag = 'Y')),
											NV_curr_after_20090807_applied := count(group, st = 'NV' and  filedate[1..8] <= '20090807' and (deletion_date > '20090807' or current_record_flag = 'Y')),
											NV_deleted_on_20090807 := count(group, st = 'NV' and  filedate[1..8] <= '20090807' and (deletion_date = '20090807')),
											
											NV_curr_before_20090808_applied := count(group, st = 'NV' and filedate[1..8] < '20090808' and (deletion_date > '20090808' or current_record_flag = 'Y')),
											NV_curr_after_20090808_applied := count(group, st = 'NV' and  filedate[1..8] <= '20090808' and (deletion_date > '20090808' or current_record_flag = 'Y')),
											NV_deleted_on_20090808 := count(group, st = 'NV' and  filedate[1..8] <= '20090808' and (deletion_date = '20090808')),

											CA_curr_before_20090807_applied := count(group, st = 'CA' and filedate[1..8] < '20090807' and (deletion_date > '20090807' or current_record_flag = 'Y')),
											CA_curr_after_20090807_applied := count(group, st = 'CA' and  filedate[1..8] <= '20090807' and (deletion_date > '20090807' or current_record_flag = 'Y')),
											CA_deleted_on_20090807 := count(group, st = 'CA' and  filedate[1..8] <= '20090807' and (deletion_date = '20090807')),

											CA_curr_before_20090808_applied := count(group, st = 'CA' and filedate[1..8] < '20090808' and (deletion_date > '20090808' or current_record_flag = 'Y')),
											CA_curr_after_20090808_applied := count(group, st = 'CA' and  filedate[1..8] <= '20090808' and (deletion_date > '20090808' or current_record_flag = 'Y')),
											CA_deleted_on_20090808 := count(group, st = 'CA' and  filedate[1..8] <= '20090808' and (deletion_date = '20090808'))

											}, vendor, few);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

results := parallel(
output(count(baserecs_before_reload), named('count_base_records_before_reload'));
output(count(baserecs_after_reload), named('count_base_records_after_reload'));
output(count(addrecs_reload), named('count_add_records_during_reload'));
output(count(delrecs_reload), named('count_dels_records_during_reload'));
output('--------------');
output(count(addDED), named('total_phone_add_records_during_reload_dates'));
output(count(delDED), named('total_phone_del_records_during_reload_dates'));

output(count(dedup(jn(flag = 'MATCH'), phone10, all)), named('count_same_phone_in_add_and_del'));
output(choosen(jn(flag = 'MATCH'), 150000), all, named('sample_same_phone_in_add_and_del'));

output(count(dedup(jn(flag = 'ADDED NOT EMPTY'), phone10, all)), named('count_phone_no_match_in_delete'));
output(choosen(jn(flag = 'ADDED NOT EMPTY'), 150000), all, named('sample_phone_no_match_in_delete'));

output(count(dedup(jn(flag = 'DELETED NOT EMPTY'), phone10, all)), named('count_phone_no_match_in_add'));
output(choosen(jn(flag = 'DELETED NOT EMPTY'), 150000), all, named('sample_phone_no_match_in_add'));
output('--------------');
output(count(base_before_reload), named('Unique_Phones_In_Base_Before_Reload'));
output(count(base_after_reload), named('Unique_Phones_In_Base_After_Reload'));

output(count(dedup(jn2(flag = 'MATCH'), phone10, all)), named('in_base_before_and_after_reload'));
output(choosen(jn2(flag = 'MATCH'), 150000), all, named('sample_in_base_before_and_after_reload'));

output(count(dedup(jn2(flag = 'BEFORE NOT EMPTY'), phone10, all)), named('count_phone_before_with_nomatch'));
output(choosen(jn2(flag = 'BEFORE NOT EMPTY'), 150000), all, named('sample_phone_before_with_nomatch'));

output(count(dedup(jn2(flag = 'AFTER NOT EMPTY'), phone10, all)), named('count_phone_after_with_nomatch'));
output(choosen(jn2(flag = 'AFTER NOT EMPTY'), 150000), all, named('sample_phone_after_with_nomatch'));
output('--------------');
output(count(addnmDED), named('total_phonenm_adds_for_reload'));
output(count(delnmDED), named('total_phonenm_dels_for_reload'));

output(count(dedup(jnnm(flag = 'MATCH'), phone10, all)), named('count_same_phonenm_in_add_and_del'));
output(choosen(jnnm(flag = 'MATCH'), 150000), all, named('sample_same_phonenm_in_add_and_del'));

output(count(dedup(jnnm(flag = 'ADDED NOT EMPTY'), phone10, all)), named('count_phonenm_no_match_in_delete'));
output(choosen(jnnm(flag = 'ADDED NOT EMPTY'), 150000), all, named('sample_phonenm_no_match_in_delete'));

output(count(dedup(jnnm(flag = 'DELETED NOT EMPTY'), phone10, all)), named('count_phonenm_no_match_in_add'));
output(choosen(jnnm(flag = 'DELETED NOT EMPTY'), 150000), all, named('sample_phonenm_no_match_in_add'));
output('--------------');
output(count(base_before_reloadnm), named('Unique_PhonesNM_In_Base_Before_Reload'));
output(count(base_after_reloadnm), named('Unique_PhonesNM_In_Base_After_Reload'));

output(count(dedup(jn2nm(flag = 'MATCH'), phone10, fsn, all)), named('in_base_before_and_after_reloadNM'));
output(choosen(jn2nm(flag = 'MATCH'), 150000), all, named('sample_in_base_before_and_after_reloadNM'));

output(count(dedup(jn2nm(flag = 'BEFORE NOT EMPTY'), phone10, fsn, all)), named('count_phoneNM_before_with_nomatch'));
output(choosen(jn2nm(flag = 'BEFORE NOT EMPTY'), 150000), all, named('sample_phoneNM_before_with_nomatch'));

output(count(dedup(jn2nm(flag = 'AFTER NOT EMPTY'), phone10, fsn, all)), named('count_phoneNM_after_with_nomatch'));
output(choosen(jn2nm(flag = 'AFTER NOT EMPTY'), 150000), all, named('sample_phoneNM_after_with_nomatch'));
output('--------------');
output(count(dedup(srtjnaddrreloads, phone10, fsn, all)), named('ct_uniquephones_and_names_found'));
output(count(dedup(srtjnaddrreloads(addrM = 'C'), phone10, fsn, all)), named('ct_uniquephones_and_names_marked_change'));
output(tbaddr, named('changes_by_addr_field'));
output(choosen(srtjnaddrreloads, 1000), named('sample_changes'));
output('--------------');
output(tbphones, named('day_to_day_unique_phone_cnts')));

return results;
end;