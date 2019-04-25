// EXPORT SALT_profile_header := 'todo';

import ut;

input_lay := RECORD
  unsigned6 did;
  unsigned6 rid;
  string1 pflag1;
  string1 pflag2;
  string1 pflag3;
  string2 src;
  unsigned3 dt_first_seen;
  unsigned3 dt_last_seen;
  unsigned3 dt_vendor_last_reported;
  unsigned3 dt_vendor_first_reported;
  unsigned3 dt_nonglb_last_seen;
  string1 rec_type;
  qstring18 vendor_id;
  qstring10 phone;
  qstring9 ssn;
  integer4 dob;
  qstring5 title;
  qstring20 fname;
  qstring20 mname;
  qstring20 lname;
  qstring5 name_suffix;
  qstring10 prim_range;
  string2 predir;
  qstring28 prim_name;
  qstring4 suffix;
  string2 postdir;
  qstring10 unit_desig;
  qstring8 sec_range;
  qstring25 city_name;
  string2 st;
  qstring5 zip;
  qstring4 zip4;
  string3 county;
  qstring7 geo_blk;
  qstring5 cbsa;
  string1 tnt;
  string1 valid_ssn;
  string1 jflag1;
  string1 jflag2;
  string1 jflag3;
  unsigned8 rawaid;
  string5 dodgy_tracking;
  unsigned8 nid;
  unsigned2 address_ind;
  unsigned2 name_ind;
  unsigned8 persistent_record_id;
  unsigned8 uid;
 END;

// ds_temp := choosen(dataset(ut.foreign_prod + 'thor400_data::new_header_records_20140721', input_lay, thor), 5000, 10000000000);
// ds_temp2 := ds_temp;
ds_temp := dataset(ut.foreign_prod + 'thor400_data::new_header_records_20140721', input_lay, thor);
// /*
ds1 := CHOOSEN(ds_temp, 1000000);
ds2 := CHOOSEN(ds_temp, 1000000, 1000000000);
ds3 := CHOOSEN(ds_temp, 1000000, 2000000000);
ds4 := CHOOSEN(ds_temp, 1000000, 3000000000);
ds5 := CHOOSEN(ds_temp, 1000000, 4000000000);
ds6 := CHOOSEN(ds_temp, 1000000, 5000000000);
ds7 := CHOOSEN(ds_temp, 1000000, 6000000000);
ds8 := CHOOSEN(ds_temp, 1000000, 7000000000);
ds9 := CHOOSEN(ds_temp, 1000000, 8000000000);
ds10 := CHOOSEN(ds_temp, 1000000, 9000000000);
ds11 := CHOOSEN(ds_temp, 1000000, 10000000000);
ds12 := CHOOSEN(ds_temp, 1000000, 11000000000);
ds13 := CHOOSEN(ds_temp, 1000000, 12000000000);
ds14 := CHOOSEN(ds_temp, 1000000, 13000000000);
// */
/*
ds1 := CHOOSEN(ds_temp, 1000);
ds2 := CHOOSEN(ds_temp, 1000, 1000000000);
ds3 := CHOOSEN(ds_temp, 1000, 2000000000);
ds4 := CHOOSEN(ds_temp, 1000, 3000000000);
ds5 := CHOOSEN(ds_temp, 1000, 4000000000);
ds6 := CHOOSEN(ds_temp, 1000, 5000000000);
ds7 := CHOOSEN(ds_temp, 1000, 6000000000);
ds8 := CHOOSEN(ds_temp, 1000, 7000000000);
ds9 := CHOOSEN(ds_temp, 1000, 8000000000);
ds10 := CHOOSEN(ds_temp, 1000, 9000000000);
ds11 := CHOOSEN(ds_temp, 1000, 10000000000);
ds12 := CHOOSEN(ds_temp, 1000, 11000000000);
ds13 := CHOOSEN(ds_temp, 1000, 12000000000);
ds14 := CHOOSEN(ds_temp, 1000, 13000000000);
*/
ds_temp2 :=	ds1 +
						ds2 +
						ds3 +
						ds4 +
						ds5 +
						ds6 +
						ds7 +
						ds8 +
						ds9 +
						ds10 +
						ds11 +
						ds12 +
						ds13 +
						ds14;
// */
ds := distribute(ds_temp2, random() ) : persist('~nkoubsky::temp::header_data_set', expire(20));
// output(choosen(ds, 10), named('raw_file'));
// ds := distribute(ds_temp2, random() );

// *** SALT profile on whole dataset
// zz_Koubsky_SALT.mac_profile(ds);



// ********** The following section to be used for a macro *************

// *** Global definitions for calculations
ds_count := count(ds);

valid_sources := ['?E' ,'TR' ,'YD' ,'BW' ,'7W' ,'DD' ,'YW' ,'2W' ,'6W' ,'.E' ,'%W' ,'HE' ,'NT' ,'TW' ,'8X' ,'CD' ,'VD' ,'QW' ,'PE' ,'@E' ,'JE' ,'1V' ,'5X' ,'NV' ,'1W' ,'D9' ,'MI' ,
									'SL' ,'ZE' ,'DS' ,'DW' ,'1X' ,'NE' ,'LI' ,'KW' ,'BD' ,'SE' ,'LV' ,'L2' ,'VO' ,'ZT' ,'4W' ,'6X' ,'ME' ,'9X' ,'JW' ,'E2' ,'KE' ,'TV' ,'WE' ,'MD' ,'SD' ,'#W' ,'D@' ,
									'RE' ,'RV' ,'IE' ,'YV' ,'FW' ,'RW' ,'WW' ,'BA' ,'EN' ,'EQ' ,'!W' ,'ED' ,'2V' ,'UT' ,'D7' ,'WD' ,'NW' ,'CG' ,'BX' ,'GW' ,'D%' ,'EL' ,'FV' ,'D0' ,'WP' ,'LP' ,'OV' ,
									'PD' ,'[W' ,'AR' ,'LE' ,'YE' ,'3W' ,'7X' ,'ND' ,'DA' ,'PV' ,'IW' ,'CW' ,'!E' ,'CY' ,'OE' ,'HW' ,'E4' ,'4X' ,'FA' ,'AV' ,'E1' ,'EE' ,'FD' ,'GE' ,'^W' ,'@W' ,'IV' ,
									'LA' ,'CE' ,'AE' ,'AK' ,'XW' ,'GD' ,'FR' ,'AM' ,'WV' ,'FF' ,'SW' ,'EM' ,'TD' ,'UW' ,'XE' ,'EB' ,'QE' ,'PL' ,'EV' ,'D3' ,'&E' ,'D!' ,'5W' ,'KD' ,'DE' ,'TE' ,'AD' ,
									'AY' ,'3X' ,'BE' ,'2X' ,'OB' ,'SV' ,'OW' ,'LW' ,'#E' ,'KV' ,'+E' ,'MW' ,'ID' ,'D2' ,'OD' ,'FP' ,'ZW' ,'ZX' ,'QV' ,'VW' ,'MV' ,'PW' ,'XX' ,'ZK' ,'FE' ,'$E' ,'FB' ,
									'E3' ,'9W' ,'UE' ,'VE' ,'XV' ,'EW'];
valid_year_low := 1900;
valid_year_high := (integer)(string)ut.getdate[1..4];
valid_month := [00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12];
valid_day := [01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31];

// Count all sources in the src field and distributions
src_lay := record
	 ds.src;
	 integer src_count := count(group);
	 decimal5_2 src_percent := (count(group) / ds_count) * 100;
	 boolean valid_source := ds.src in valid_sources;
end;

src_table := sort(table(ds, src_lay, ds.src, few), -src_count);
output(src_table, all, named('top_sources'));
output(src_table(valid_source = false), named('failed_sources'));

					// output( count(ds(dt_first_seen = 0)));
					// output( count(ds(dt_first_seen = 0000000)));
					// output( count(ds(dt_first_seen <> 0)));
// /*


// *********** Profile dates *******************
get_date_stats (d_set, attr_name) := functionmacro
		
		first_seen_lay := record
				string attribute_name;
				string rule_name;
				integer fs_count;
				decimal5_2 fs_percent;
				string threshold_;
				boolean is_valid;
		end;

		first_seen_lay fs_zero_trans(first_seen_lay le) := transform
				self.attribute_name := attr_name;
				self.rule_name := 'zero_date';
					zero_count := count(d_set(#expand(attr_name) = 0));
				self.fs_count := zero_count;
					zero_percent :=  (zero_count / ds_count) * 100;
				self.fs_percent := zero_percent;
				self.threshold_ := '<_5%';
				self.is_valid := zero_percent < 5;
		end;

		first_seen_lay fs_current_trans(first_seen_lay le) := transform
				self.attribute_name := attr_name;
				self.rule_name := 'twelve_mo_date';
					current_count := count(d_set(#expand(attr_name) <= (integer)(string)ut.getdate[1..6] and #expand(attr_name) > (integer)((string)ut.getdate[1..6]) - 100 ));
				self.fs_count := current_count;
					current_percent := (current_count / ds_count) * 100;
				self.fs_percent := current_percent;
				self.threshold_ := '>_10%';
				self.is_valid := current_percent > 10;
		end;

		first_seen_lay fs_hundred_trans(first_seen_lay le) := transform
				self.attribute_name := attr_name;
				self.rule_name := 'hundred_year_date';
					hundred_count := count(d_set(#expand(attr_name) <= (integer)((string)ut.getdate[1..6]) - 100 and #expand(attr_name) > (integer)((string)ut.getdate[1..6]) - 10100 ));
				self.fs_count := hundred_count;
					hundred_percent := (hundred_count / ds_count) * 100;
				self.fs_percent := hundred_percent;
				self.threshold_ := '>_50%';
				self.is_valid := hundred_percent > 50;
		end;

		first_seen_lay fs_is_valid_trans(first_seen_lay le) := transform
				self.attribute_name := attr_name;
				self.rule_name := 'not_valid_format';
					is_valid_count := count(d_set(			(integer) ((string) #expand(attr_name)[1..4]) between valid_year_low and valid_year_high
																					or	(integer) ((string) #expand(attr_name)[5..6]) not in valid_month
																					// or 	(integer) ((string) #expand(attr_name)[7..8]) not in valid_day 
																					));
				self.fs_count := is_valid_count;
					is_valid_percent := (is_valid_count / ds_count) * 100;
				self.fs_percent := is_valid_percent;
				self.threshold_ := '<_1%';
				self.is_valid := is_valid_percent < 1;
		end;

		temp_set := project(ut.ds_oneRecord, transform(first_seen_lay, self := []));

		ds_fs := 	project(temp_set, fs_zero_trans(left)) +
							project(temp_set, fs_current_trans(left)) +
							project(temp_set, fs_hundred_trans(left)) +
							project(temp_set, fs_is_valid_trans(left));

		return ds_fs;
		
endmacro;
//********* END OF MACRO *********************



date_set := 	get_date_stats(ds, 'dt_first_seen') +
							get_date_stats(ds, 'dt_last_seen') +
							get_date_stats(ds, 'dt_vendor_first_reported') +
							get_date_stats(ds, 'dt_vendor_last_reported') +
							get_date_stats(ds, 'dt_nonglb_last_seen');

output(date_set, named('date_results'));


ssn_lay := record
			string attribute_name;
			string rule_name;
			integer fs_count;
			decimal5_2 fs_percent;
			string threshold_;
			boolean is_valid;
end;

ssn_lay ssn_valid_format (ssn_lay le) := transform
		self.attribute_name := 'ssn';
		self.rule_name := 'ssn_valid';
			// ssn_valid_count := count(ds(regexfind('^([0-9]{4})$', ssn)) );
			ssn_valid_count := count(ds(regexfind('^([0-9]{4})$', ssn)) );
		self.fs_count := ssn_valid_count;
			ssn_valid_percent :=  (ssn_valid_count / ds_count) * 100;
		self.fs_percent := ssn_valid_percent;
		self.threshold_ := '>_90%';
		self.is_valid := ssn_valid_percent > 90;
end;

// isNineBits := LENGTH(StringLib.StringFilter(SSN, '0123456789'));

ssn_lay ssn_invalid_format (ssn_lay le) := transform
		self.attribute_name := 'ssn';
		self.rule_name := 'ssn_invalid';
			ssn_invalid_count := count(ds( not regexfind('^([0-9]{4})$', ssn)) );
		self.fs_count := ssn_invalid_count;
			ssn_invalid_percent :=  (ssn_invalid_count / ds_count) * 100;
		self.fs_percent := ssn_invalid_percent;
		self.threshold_ := '<_10%';
		self.is_valid := ssn_invalid_percent < 10;
end;


temp_set_2 := project(ut.ds_oneRecord, transform(ssn_lay, self := []) );

ssn_set := 	project(temp_set_2, ssn_valid_format(left) ) +
						project(temp_set_2, ssn_invalid_format(left) );

output( ssn_set, named('ssn_matches') );
