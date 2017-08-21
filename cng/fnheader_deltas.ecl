#workunit('name', 'Header Delta Extract')

import header, ut, did_add;

////////////////////////////////////////////////////////////////////////////////////////////
/*
Definitions:
  new_ds - dataset who's unmatching records to comparison dataset would be considered as "new"
							must be in current header base file layout, no tilde in filename
  old_ds - dataset who's unmatching records to comparison dataset would be considered as "old"
							must be in current header base file layout, no tilde in filename
  mylimit - only run subset. blank is run all

Inputs:
 For Defaults - super base file vs super base file father
  header_deltas()
 Specify Inputs - new file vs old file
  header_deltas('new file logical name', 'old file logical name')
*/
////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////
export fnheader_deltas(string new_ds = 'thor_data400::base::header_prod', string old_ds = 'thor_data400::base::header_father', string version = '', unsigned8 MyLimit = 0) := function

hdrfileversion := if(version = '', did_add.get_EnvVariable('header_file_version'), version) : stored('shdrfileversion');

/* hash record for record compare */
layout_hashed := record
    string2	delta_flag := '';
	unsigned8 hash_key := 0;
	recordof(header.File_Headers);
	string20 changed_field := '';
end;

sample_curr := CHOOSEN(dataset('~' + new_ds, recordof(header.File_Headers), thor),IF(MyLimit<>0,MyLimit,CHOOSEN:ALL));
sample_prev := CHOOSEN(dataset('~' + old_ds, recordof(header.File_Headers), thor),IF(MyLimit<>0,MyLimit,CHOOSEN:ALL));

////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////

curr_file := project(sample_curr,
									transform(layout_hashed, 
															self.hash_key := hash64(left.did + 
																								left.rid + 
																								left.pflag1 + 
																								left.pflag2 + 
																								left.pflag3 + 
																								left.src + 
																								left.dt_first_seen + 
																								left.dt_last_seen + 
																								left.dt_vendor_last_reported + 
																								left.dt_vendor_first_reported + 
																								left.dt_nonglb_last_seen + 
																								left.rec_type + 
																								left.vendor_id + 
																								left.phone + 
																								left.ssn + 
																								left.dob + 
																								left.title + 
																								left.fname + 
																								left.mname + 
																								left.lname + 
																								left.name_suffix + 
																								left.prim_range + 
																								left.predir + 
																								left.prim_name + 
																								left.suffix + 
																								left.postdir + 
																								left.unit_desig + 
																								left.sec_range + 
																								left.city_name + 
																								left.st + 
																								left.zip + 
																								left.zip4 + 
																								left.county + 
																								left.geo_blk + 
																								left.cbsa + 
																								left.tnt + 
																								left.valid_SSN + 
																								left.jflag1 + 
																								left.jflag2 + 
																								left.jflag3 + 
																								left.rawaid + 
																								left.dodgy_tracking);
															self := left));
															
prev_file := project(sample_prev,
									transform(layout_hashed, 
															self.hash_key := hash64(left.did + 
																								left.rid + 
																								left.pflag1 + 
																								left.pflag2 + 
																								left.pflag3 + 
																								left.src + 
																								left.dt_first_seen + 
																								left.dt_last_seen + 
																								left.dt_vendor_last_reported + 
																								left.dt_vendor_first_reported + 
																								left.dt_nonglb_last_seen + 
																								left.rec_type + 
																								left.vendor_id + 
																								left.phone + 
																								left.ssn + 
																								left.dob + 
																								left.title + 
																								left.fname + 
																								left.mname + 
																								left.lname + 
																								left.name_suffix + 
																								left.prim_range + 
																								left.predir + 
																								left.prim_name + 
																								left.suffix + 
																								left.postdir + 
																								left.unit_desig + 
																								left.sec_range + 
																								left.city_name + 
																								left.st + 
																								left.zip + 
																								left.zip4 + 
																								left.county + 
																								left.geo_blk + 
																								left.cbsa + 
																								left.tnt + 
																								left.valid_SSN + 
																								left.jflag1 + 
																								left.jflag2 + 
																								left.jflag3 +
																								left.rawaid + 
																								left.dodgy_tracking),
															self := left));

layout_header_delta.combined tcapturedeltas(layout_hashed le, layout_hashed ri) := transform
	self.delta_flag := if(le.hash_key = ri.hash_key and le.hash_key > 0, 'S', 
											if(le.rid = ri.rid, 'C', 
											 if(le.rid > 0, 'A', 'R')));
	// self.hash_key := if(le.hash_key > 0,le.hash_key, ri.hash_key);
	self.rid := if(le.rid > 0, le.rid, ri.rid);
	self.changed_field :=
					map(self.delta_flag = 'C' and le.did <> ri.did => 'did|', '') +
					map(self.delta_flag = 'C' and le.pflag1 <> ri.pflag1 => 'pflag1|', '') +
					map(self.delta_flag = 'C' and le.pflag2 <> ri.pflag2 => 'pflag2|', '') +
					map(self.delta_flag = 'C' and le.pflag3 <> ri.pflag3 => 'pflag3|', '') +
					map(self.delta_flag = 'C' and le.src <> ri.src => 'src|', '') +
					map(self.delta_flag = 'C' and le.dt_first_seen <> ri.dt_first_seen => 'dt_first_seen|', '') +
					map(self.delta_flag = 'C' and le.dt_last_seen <> ri.dt_last_seen => 'dt_last_seen|', '') +
					map(self.delta_flag = 'C' and le.dt_vendor_last_reported <> ri.dt_vendor_last_reported => 'dt_vendor_last_reported|', '') +
					map(self.delta_flag = 'C' and le.dt_vendor_first_reported <> ri.dt_vendor_first_reported => 'dt_vendor_first_reported|', '') +
					map(self.delta_flag = 'C' and le.dt_nonglb_last_seen <> ri.dt_nonglb_last_seen => 'dt_nonglb_last_seen|', '') +
					map(self.delta_flag = 'C' and le.rec_type <> ri.rec_type => 'rec_type|', '') +
					map(self.delta_flag = 'C' and le.vendor_id <> ri.vendor_id => 'vendor_id|', '') +
					map(self.delta_flag = 'C' and le.phone <> ri.phone => 'phone|', '') +
					map(self.delta_flag = 'C' and le.ssn <> ri.ssn => 'ssn|', '') +
					map(self.delta_flag = 'C' and le.dob <> ri.dob => 'dob|', '') +
					map(self.delta_flag = 'C' and le.title <> ri.title => 'title|', '') +
					map(self.delta_flag = 'C' and le.fname <> ri.fname => 'fname|', '') +
					map(self.delta_flag = 'C' and le.mname <> ri.mname => 'mname|', '') +
					map(self.delta_flag = 'C' and le.lname <> ri.lname => 'lname|', '') +
					map(self.delta_flag = 'C' and le.name_suffix <> ri.name_suffix => 'name_suffix|', '') +
					map(self.delta_flag = 'C' and le.prim_range <> ri.prim_range => 'prim_range|', '') +
					map(self.delta_flag = 'C' and le.predir <> ri.predir => 'predir|', '') +
					map(self.delta_flag = 'C' and le.prim_name <> ri.prim_name => 'prim_name|', '') +
					map(self.delta_flag = 'C' and le.suffix <> ri.suffix => 'suffix|', '') +
					map(self.delta_flag = 'C' and le.postdir <> ri.postdir => 'postdir|', '') +
					map(self.delta_flag = 'C' and le.unit_desig <> ri.unit_desig => 'unit_desig|', '') +
					map(self.delta_flag = 'C' and le.sec_range <> ri.sec_range => 'sec_range|', '') +
					map(self.delta_flag = 'C' and le.city_name <> ri.city_name => 'city_name|', '') +
					map(self.delta_flag = 'C' and le.st <> ri.st => 'st|', '') +
					map(self.delta_flag = 'C' and le.zip <> ri.zip => 'zip|', '') +
					map(self.delta_flag = 'C' and le.zip4 <> ri.zip4 => 'zip4|', '') +
					map(self.delta_flag = 'C' and le.county <> ri.county => 'county|', '') +
					map(self.delta_flag = 'C' and le.geo_blk <> ri.geo_blk => 'geo_blk|', '') +
					map(self.delta_flag = 'C' and le.cbsa <> ri.cbsa => 'cbsa|', '') +
					map(self.delta_flag = 'C' and le.tnt <> ri.tnt => 'tnt|', '') +
					map(self.delta_flag = 'C' and le.valid_SSN <> ri.valid_SSN => 'valid_SSN|', '') +
					map(self.delta_flag = 'C' and le.jflag1 <> ri.jflag1 => 'jflag1|', '') +
					map(self.delta_flag = 'C' and le.jflag2 <> ri.jflag2 => 'jflag2|', '') +
					map(self.delta_flag = 'C' and le.jflag3 <> ri.jflag3 => 'jflag3|', '') +
					map(self.delta_flag = 'C' and le.rawaid <> ri.rawaid => 'rawaid|', '') +
					map(self.delta_flag = 'C' and le.dodgy_tracking <> ri.dodgy_tracking => 'dodgy_tracking|', '');
	self.changed_value :=
					map(self.delta_flag = 'C' and le.did <> ri.did => (string)le.did + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.pflag1 <> ri.pflag1 => le.pflag1 + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.pflag2 <> ri.pflag2 => le.pflag2 + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.pflag3 <> ri.pflag3 => le.pflag3 + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.src <> ri.src => le.src + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.dt_first_seen <> ri.dt_first_seen => (string)le.dt_first_seen + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.dt_last_seen <> ri.dt_last_seen => (string)le.dt_last_seen + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.dt_vendor_last_reported <> ri.dt_vendor_last_reported => (string)le.dt_vendor_last_reported + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.dt_vendor_first_reported <> ri.dt_vendor_first_reported => (string)le.dt_vendor_first_reported + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.dt_nonglb_last_seen <> ri.dt_nonglb_last_seen => (string)le.dt_nonglb_last_seen + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.rec_type <> ri.rec_type => le.rec_type + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.vendor_id <> ri.vendor_id => le.vendor_id + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.phone <> ri.phone => le.phone + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.ssn <> ri.ssn => le.ssn + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.dob <> ri.dob => (string)le.dob + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.title <> ri.title => le.title + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.fname <> ri.fname => le.fname + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.mname <> ri.mname => le.mname + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.lname <> ri.lname => le.lname + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.name_suffix <> ri.name_suffix => le.name_suffix + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.prim_range <> ri.prim_range => le.prim_range + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.predir <> ri.predir => le.predir + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.prim_name <> ri.prim_name => le.prim_name + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.suffix <> ri.suffix => le.suffix + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.postdir <> ri.postdir => le.postdir + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.unit_desig <> ri.unit_desig => le.unit_desig + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.sec_range <> ri.sec_range => le.sec_range + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.city_name <> ri.city_name => le.city_name + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.st <> ri.st => le.st + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.zip <> ri.zip => le.zip + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.zip4 <> ri.zip4 => le.zip4 + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.county <> ri.county => le.county + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.geo_blk <> ri.geo_blk => le.geo_blk + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.cbsa <> ri.cbsa => le.cbsa + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.tnt <> ri.tnt => le.tnt + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.valid_SSN <> ri.valid_SSN => le.valid_SSN + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.jflag1 <> ri.jflag1 => le.jflag1 + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.jflag2 <> ri.jflag2 => le.jflag2 + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.jflag3 <> ri.jflag3 => le.jflag3 + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.rawaid <> ri.rawaid => le.rawaid + '|changed_values|', '') +
					map(self.delta_flag = 'C' and le.dodgy_tracking <> ri.dodgy_tracking => le.dodgy_tracking + '|changed_values|', '');
	self := le;
end;

jn := join(distribute(curr_file,hash(rid)), distribute(prev_file, hash(rid)), left.rid = right.rid, tcapturedeltas(left, right), full outer, hash);

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////GENERATE STATS////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

cntcurri :=   count(sample_curr);
cntprevi :=   count(sample_prev);
cntsamei :=   count(dataset('~thor_data400::out::header::deltas', layout_header_delta.combined, thor)(delta_flag = 'S'));
cntnewi  :=   count(file_header_delta.adds);
cntremi :=    count(file_header_delta.rems);
cntchgdnmi := count(dedup(file_header_delta.chgs, rid, local));

/* produce stats for emails and alerts */
cntcurr := ut.IntWithCommas(cntcurri);
cntprev := ut.IntWithCommas(cntprevi);
cntsame := ut.IntWithCommas(cntsamei);
cntnew  := ut.IntWithCommas(cntnewi);
cntrem  := ut.IntWithCommas(cntremi);
cntchan := ut.IntWithCommas(cntchgdnmi);
samepct := ut.IntWithCommas((cntsamei/cntcurri)*100);
newpct  := ut.IntWithCommas((cntnewi/cntcurri)*100);
chanpct := ut.IntWithCommas((cntchgdnmi/cntcurri)*100);
rempct  := ut.IntWithCommas((cntremi/cntprevi)*100);

count_changes := sort(table(file_header_delta.chgs, {string line := '', changed_field, count_ := count(group)},changed_field, few), changed_field);

recordof(count_changes) tChangedRoll(recordof(count_changes) le,recordof(count_changes) ri) := transform
 self.line := le.line + '\n' + ri.changed_field + (string15)(intformat(ri.count_, 15, 0));
 self := ri;
end;

count_changes_r := iterate(count_changes,tChangedRoll(left, right));		
count_changes_email_body := count_changes_r[count(count_changes_r)].line;

oldem := if(old_ds = 'thor_data400::base::header_father', '~' + fileservices.SuperFileContents('~thor_data400::base::header_father')[1].name, old_ds);
newem := if(new_ds = 'thor_data400::base::header_prod', '~' + fileservices.SuperFileContents('~thor_data400::base::header_prod')[1].name, new_ds);

email_body := 
	'View Workunit:                                        ' + thorlib.wuid() + '\n\n' +
	'Counts and Percentages' + '\n\n' +

	'Base Files\' Counts:                                      \n' +
	' Current File:                                           ' + cntcurr + '\t 100.00%\n' +
	' Previous File:                                          ' + cntprev + '\t 100.00%\n' +
	'SAME - Current Records Found In Previous:                ' + cntsame + '\t' + samepct + '% of Current\n' +
	'NEW - Current RIDs not found in Previous:                ' + cntnew + '\t' + newpct + '% of Current\n' +
	'CHANGED - RIDs with Changed Values:                      ' + cntchan + '\t' + chanpct + '% of Current\n' +
	'REMOVED - Previous RIDs not found in Current:            ' + cntrem + '\t' + rempct + '% of Previous\n\n' +
	'Changed Field List Distribution:\n' 						+ count_changes_email_body + '\n\n' +
	'Files Used:\n' 					                       	+ 
	'  OLD - ' + oldem + '\n'                                 +
	'  NEW - ' + newem;

email_subject := 'Header Deltas Complete: ' + hdrfileversion;



/////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////

/* DECIDE IF Time to build files for export */


current_delta_filename := fileservices.SuperFileContents('~thor_data400::out::header::deltas_adds')[1].name;
current_delta_filedate := current_delta_filename[stringlib.stringfind(current_delta_filename, '::', 4) + 2..];

iscurrent := hdrfileversion = current_delta_filedate;

run_delta_output := 
	if(~iscurrent,
		sequential(
			output(jn,,'~thor_data400::out::header::deltas', overwrite, __compressed__),
			fndelta_output(hdrfileversion),
			parallel(
				output(cntcurr, named('Count_Current_Records'));
				output(cntprev, named('Count_Previous_Records'));
				output(cntsame, named('Count_Unchanged_Records'));
				output(cntnew, named('Count_Add_Records'));
				output(cntrem, named('Count_Removed_Records'));
				output(cntchan, named('Count_Changed_Records'));
				output(count_changes, named('Count_Changed_Fields'));
				fileservices.sendemail('cecelie.guyton@lexisnexis.com',email_subject, email_body))
			;cng.fndelta_despray(hdrfileversion).adds
			;cng.fndelta_despray(hdrfileversion).rems
			;cng.fndelta_despray(hdrfileversion).chgs
			),
		output('Header Delta Outfiles are Current with Header Prod Files - Version ' + hdrfileversion, named('_')));

testing := 
	sequential(
			output(jn,,'~thor_data400::out::header::deltas', overwrite, __compressed__),
			fndelta_output(hdrfileversion),
			parallel(
				output(cntcurr, named('Count_Current_Records'));
				output(cntprev, named('Count_Previous_Records'));
				output(cntsame, named('Count_Unchanged_Records'));
				output(cntnew, named('Count_Add_Records'));
				output(cntrem, named('Count_Removed_Records'));
				output(cntchan, named('Count_Changed_Records'));
				output(count_changes, named('Count_Changed_Fields'));
				fileservices.sendemail('cecelie.guyton@lexisnexis.com',email_subject, email_body))
			;cng.fndelta_despray(hdrfileversion).adds
			;cng.fndelta_despray(hdrfileversion).rems
			;cng.fndelta_despray(hdrfileversion).chgs
	);



// return testing; //testing only
return run_delta_output;
end;
