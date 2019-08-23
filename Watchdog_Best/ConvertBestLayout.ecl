/*
Convert SALT output to Watchdog Layout
*/
import std;
EXPORT ConvertBestLayout(dataset($.Layouts.BestBy_did_best) infile) := FUNCTION

	// TO DO: create records by flavor
	b := PROJECT(infile, TRANSFORM($.Layouts.Layout_Best,
								self.ssn := left.ssnum_ssn;
								self.valid_ssn := left.ssnum_valid_ssn;
								// address
								self.prim_range := left.address_prim_range;
								self.predir := left.address_predir;
								self.prim_name := left.address_prim_name;
								self.suffix := left.address_suffix;
								self.postdir := left.address_postdir;
								self.unit_desig := left.address_unit_desig;
								self.sec_range := left.address_sec_range;
								self.city_name := left.address_city_name;
								self.st := left.address_st;
								self.zip := left.address_zip;
								self.zip4 := left.address_zip4;
								// address dates
								dates := Std.Str.SplitWords(left.address_alldates, '$', true);
								self.addr_dt_first_seen := (integer3)IF(left.address_method in [4,6], dates[3], dates[1]);
								self.addr_dt_last_seen := (integer3)IF(left.address_method in [4,6], dates[4], dates[2]);

								self := left;
							));
							
		allglb := $.fn_append_paw(
								$.fn_append_bankruptcy(
									$.fn_append_dl(
										$.fn_append_vehnum(
											$.fn_append_dod(
												$.fn_append_adl(b)
											)
										)
									)
								)
							);
							
		return allglb;

END;