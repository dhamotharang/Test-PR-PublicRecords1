// convert to 2015 format
import ut, std, watchdog;

EXPORT ConvertTo2015(dataset(layouts_census.layout_out) ds2014) := FUNCTION

	hh := HH_Counts(ds2014);		// household counts
	
	pass1 := PROJECT(ds2014, TRANSFORM(Layout_2015,
							self.Age := if(left.dob='',0,
													AgeAsOf(left.dob[5..8] + left.dob[1..4], Ut.GetDate));
							self.fullname := STD.str.CleanSpaces(left.fname + ' ' + left.mname + ' ' + left.lname + ' ' + left.name_suffix);
							self.LexId := (unsigned6)left.link_id;
							//self.Housing_Tenure := AgeAsOf(left.addr_curr_dt_first_seen, Ut.GetDate);
							//self.listed_phone_status := IF(left.listed_phone_num='','','ACTIVE');
							self := left;
							self := [];
							));
	// add household counts
/*	pass2 := JOIN(pass1, hh, left.addr_curr_st=right.addr_curr_st AND left.addr_curr_zip=right.addr_curr_zip AND
							left.addr_curr_prim_name = right.addr_curr_prim_name AND left.addr_curr_prim_range=right.addr_curr_prim_range AND
							left.addr_curr_predir=right.addr_curr_predir AND left.addr_curr_suffix=right.addr_curr_suffix AND
							left.addr_curr_postdir=right.addr_curr_postdir AND left.addr_curr_sec_range=right.addr_curr_sec_range,
							TRANSFORM(Layout_2015,
								self.Housing_Population := right.n;
								self := LEFT;), LEFT OUTER, KEEP(1));
	*/							
	// get email addresses
	pass3 := Email_merge(pass1);
	
	// add missing genders
	dog := DISTRIBUTE(Watchdog.File_Best,did);
	pass4 := JOIN(DISTRIBUTE(pass3,LexId), dog, LEFT.Lexid=RIGHT.did, TRANSFORM(Layout_2015,
									self.gender := MAP(
																	left.gender<>'' => left.gender,
																	right.title='MR' => 'M',
																	right.title='MS' => 'F',
																	'U');
									self := left;), LEFT OUTER, KEEP(1), LOCAL) : PERSIST('~thor::csalvo::censusrfp::temp');
/*									
	pass5 := MergeLatLong(pass4,addr_hist1_st,addr_hist1_zip,addr_hist1_prim_name, addr_hist1_prim_range, 
										addr_hist1_predir, addr_hist1_suffix, addr_hist1_geo_lat, addr_hist1_geo_long);
	   
	pass6 := MergeLatLong(pass5,addr_hist2_st,addr_hist2_zip,addr_hist2_prim_name, addr_hist2_prim_range, 
										addr_hist2_predir, addr_hist2_suffix, addr_hist2_geo_lat, addr_hist2_geo_long);
*/
	final := PROJECT(pass4, xFinalLayout(LEFT));

	return final;

END;