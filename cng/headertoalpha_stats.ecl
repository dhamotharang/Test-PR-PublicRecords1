import header;

#workunit('name', 'stats hdr transfer')

h2 := header.File_Headers;

lay_popcounts := record
   has_did := count(group, h2.did > 0);
   has_rid := count(group, h2.rid > 0);
   has_pflag1 := count(group, h2.pflag1 > '');
   has_pflag2 := count(group, h2.pflag2 > '');
   has_pflag3 := count(group, h2.pflag3 > '');
   has_src := count(group, h2.src > '');
   has_dt_first_seen := count(group, h2.dt_first_seen > 0);
   has_dt_last_seen := count(group, h2.dt_last_seen > 0);
   has_dt_vendor_last_reported := count(group, h2.dt_vendor_last_reported > 0);
   has_dt_vendor_first_reported := count(group, h2.dt_vendor_first_reported > 0);
   has_dt_nonglb_last_seen := count(group, h2.dt_nonglb_last_seen > 0);
   has_rec_type := count(group, h2.rec_type > '');
   has_vendor_id := count(group, h2.vendor_id > '');
   has_phone := count(group, h2.phone > '');
   has_ssn := count(group, h2.ssn > '');
   has_dob := count(group, h2.dob > 0);
   has_title := count(group, h2.title > '');
   has_fname := count(group, h2.fname > '');
   has_mname := count(group, h2.mname > '');
   has_lname := count(group, h2.lname > '');
   has_name_suffix := count(group, h2.name_suffix > '');
   has_prim_range := count(group, h2.prim_range > '');
   has_predir := count(group, h2.predir > '');
   has_prim_name := count(group, h2.prim_name > '');
   has_suffix := count(group, h2.suffix > '');
   has_postdir := count(group, h2.postdir > '');
   has_unit_desig := count(group, h2.unit_desig > '');
   has_sec_range := count(group, h2.sec_range > '');
   has_city_name := count(group, h2.city_name > '');
   has_st := count(group, h2.st > '');
   has_zip := count(group, h2.zip > '');
   has_zip4 := count(group, h2.zip4 > '');
   has_county := count(group, h2.county > '');
   has_geo_blk := count(group, h2.geo_blk > '');
   has_cbsa := count(group, h2.cbsa > '');
   has_tnt := count(group, h2.tnt > '');
   has_valid_SSN := count(group, h2.valid_SSN > '');
   has_jflag1 := count(group, h2.jflag1 > '');
   has_jflag2 := count(group, h2.jflag2 > '');
   has_jflag3 := count(group, h2.jflag3 > '');
end;

tb := table(h2, lay_popcounts , '1', few);

pop_forEmail := project(tb[1], transform({string oneline}, 
self.oneline := 
'POPULATIONS --- \n\n'+
	'   has_did:                        ' + left.has_did + '\n' +
	'   has_rid:                        ' + left.has_rid + '\n' +
	'   has_pflag1:                     ' + left.has_pflag1 + '\n' +
	'   has_pflag2:                     ' + left.has_pflag2 + '\n' +
	'   has_pflag3:                     ' + left.has_pflag3 + '\n' +
	'   has_src:                        ' + left.has_src + '\n' +
	'   has_dt_first_seen:              ' + left.has_dt_first_seen + '\n' +
	'   has_dt_last_seen:               ' + left.has_dt_last_seen + '\n' +
	'   has_dt_vendor_last_reported:    ' + left.has_dt_vendor_last_reported + '\n' +
	'   has_dt_vendor_first_reported:   ' + left.has_dt_vendor_first_reported + '\n' +
	'   has_dt_nonglb_last_seen:        ' + left.has_dt_nonglb_last_seen + '\n' +
	'   has_rec_type:                   ' + left.has_rec_type + '\n' +
	'   has_vendor_id:                  ' + left.has_vendor_id + '\n' +
	'   has_phone:                      ' + left.has_phone + '\n' +
	'   has_ssn:                        ' + left.has_ssn + '\n' +
	'   has_dob:                        ' + left.has_dob + '\n' +
	'   has_title:                      ' + left.has_title + '\n' +
	'   has_fname:                      ' + left.has_fname + '\n' +
	'   has_mname:                      ' + left.has_mname + '\n' +
	'   has_lname:                      ' + left.has_lname + '\n' +
	'   has_name_suffix:                ' + left.has_name_suffix + '\n' +
	'   has_prim_range:                 ' + left.has_prim_range + '\n' +
	'   has_predir:                     ' + left.has_predir + '\n' +
	'   has_prim_name:                  ' + left.has_prim_name + '\n' +
	'   has_suffix:                     ' + left.has_suffix + '\n' +
	'   has_postdir:                    ' + left.has_postdir + '\n' +
	'   has_unit_desig:                 ' + left.has_unit_desig + '\n' +
	'   has_sec_range:                  ' + left.has_sec_range + '\n' +
	'   has_city_name:                  ' + left.has_city_name + '\n' +
	'   has_st:                         ' + left.has_st + '\n' +
	'   has_zip:                        ' + left.has_zip + '\n' +
	'   has_zip4:                       ' + left.has_zip4 + '\n' +
	'   has_county:                     ' + left.has_county + '\n' +
	'   has_geo_blk:                    ' + left.has_geo_blk + '\n' +
	'   has_cbsa:                       ' + left.has_cbsa + '\n' +
	'   has_tnt:                        ' + left.has_tnt + '\n' +
	'   has_valid_SSN:                  ' + left.has_valid_SSN + '\n' +
	'   has_jflag1:                     ' + left.has_jflag1 + '\n' +
	'   has_jflag2:                     ' + left.has_jflag2 + '\n' +
	'   has_jflag3:                     ' + left.has_jflag3));

jflag1 := table(h2, {string20 field := 'jflag1:', val := (string10)jflag1, string12 ct := (string12)intformat(count(group), 12, 0)}, jflag1, few);
jflag2 := table(h2, {string20 field := 'jflag2:', val := (string10)jflag2, string12 ct := (string12)intformat(count(group), 12, 0)}, jflag2, few);
jflag3 := table(h2, {string20 field := 'jflag3:', val := (string10)jflag3, string12 ct := (string12)intformat(count(group), 12, 0)}, jflag3, few);


pflag1 := table(h2, {string20 field := 'pflag1:', val := (string10)pflag1, string12 ct := (string12)intformat(count(group), 12, 0)}, pflag1, few);
pflag2 := table(h2, {string20 field := 'pflag2:', val := (string10)pflag2, string12 ct := (string12)intformat(count(group), 12, 0)}, pflag2, few);
pflag3 := table(h2, {string20 field := 'pflag3:', val := (string10)pflag3, string12 ct := (string12)intformat(count(group), 12, 0)}, pflag3, few);

tnt := table(h2, {string20 field := 'tnt:', val := (string10)tnt, string12 ct := (string12)intformat(count(group), 12, 0)}, tnt, few);


title := table(h2, {string20 field := 'title:', val := (string10)title, string12 ct := (string12)intformat(count(group), 12, 0)}, title, few);


dt_last_seen := table(h2, {string20 field := 'dt_last_seen:', val := (string10)dt_last_seen, string12 ct := (string12)intformat(count(group), 12, 0)}, dt_last_seen, few);

distrAll := jflag1 & jflag2 & jflag3 & pflag1 & pflag2 & pflag3 & tnt & title & dt_last_seen;

rllfmt := record, maxlength(250000) string field, string val, string ct, end;

srtdistrAll := project(sort(jflag1 & jflag2 & jflag3 & pflag1 & pflag2 & pflag3 & tnt & title & dt_last_seen, -field, -val), transform(rllfmt, self := left));

distr_forEmail := rollup(srtdistrAll, transform(recordof(srtdistrAll), self.field := trim(right.field + '\t' + right.val +'\t' +  right.ct + '\n' + left.field +'\t' +  left.val +'\t' +  left.ct + '\n', left, right);  
																																					self := []), '1')[1] ;
stats := 	
parallel(
output('STATS');
output(tb, named('populations'));

output(jflag1, named('jflag1'));
output(jflag2, named('jflag2'));
output(jflag3, named('jflag3'));
output(pflag1, named('pflag1'));
output(pflag2, named('pflag2'));
output(pflag3, named('pflag3'));
output(tnt, named('tnt'));
output(title, named('title'));

output(dt_last_seen, all, named('date_last_seen'));

output(distrAll, all, named('all'));

output(count(h2(jflag1 > '')), named('jflag1popcntcheck'));

output(enth(h2, 100), named('sample_recs'));

fileservices.sendemail('cecelie.guyton@lexisnexis.com', 'Boca Header Complete - POC ' + thorlib.wuid(), 
													fileservices.SuperFileContents('~thor_data400::base::header_prod')[1].name +
													POP_forEmail.oneline));

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



