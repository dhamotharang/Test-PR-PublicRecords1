import header, mdr, ut, doxie_build;

/* 

   HereÂ’s the current thinking:
   -	We donÂ’t want to pull anything over from the header, still only use it for sorting
   -	But can we set up a way to recognize where the displayed Infutor dates order stops making sense to the end user 
		(where what is displayed ends up not being sequential). Where this happens, could we:
	   o	Show the earliest date (e.g., first seen equivalent) from the Infutor file only, and if this still doesnÂ’t make sense,
	   o	Show the year from the Infutor file only, and if this still doesnÂ’t make sense
	   o	Then go with blank
   
*/

export fn_hdr_addrdate_blank(dataset(header.layout_header) pInfutor_Infile) := function

test_count := 0;

Comparison_Layout := record
	string		 matched_temp_src;
	boolean		 Has_Match 				:= false;
	unsigned 	 matched_addr_min_date	:= 0;
	unsigned 	 matched_addr_max_date	:= 0;
	unsigned 	 orig_valid_min_date	:= 0;
	unsigned 	 orig_valid_max_date	:= 0;
	boolean		 Only_One_Date_Valid	:= false;
	boolean		 Both_Dates_Valid		:= false;
	boolean		 First_Seen_Valid 		:= false;
	boolean		 Last_Seen_Valid 		:= false;
	boolean		 No_Dates_Avail 		:= false;
	
	boolean		blanked_outoforder := false;
end;

Orig_Match_Fields := record
	string 		 src;
	unsigned6 	 did;
	unsigned3    dt_first_seen;
	unsigned3    dt_last_seen;
	qstring10    prim_range;
	string2      predir;
	qstring28    prim_name;
	qstring4     suffix;
	string2      postdir;
	qstring10    unit_desig;
	qstring8     sec_range;
	qstring25    city_name;
	string2      st;
	qstring5     zip;
end;

SlimMatchLayout := record
	Comparison_Layout;
	Orig_Match_Fields;
end;

/////////////////////// COMBINED INCOMING FILES
/* Input file that needs to have the dates corrected and/or changed to earliest and lastest dates for did/address */
Infutor_Infile 	:= distribute(project(pInfutor_Infile, transform({Comparison_Layout.matched_temp_src, recordof(pInfutor_Infile)},
							self.matched_temp_src := map(left.src in [mdr.sourceTools.src_Gong_History, mdr.sourceTools.src_pcnsr, mdr.sourceTools.src_InfutorTRK] => left.src ,
														 'HD');
							self := left)), hash(did));

/////////////////////// FILES USED TO COMPARE DID/ADDRESS COMBINATIONS TO AND ASSIGN DATES
/* ONLY NON DPPA FOR DATE CHANGES - For Correcting dates for Infutor and PConsumer, use the non dppa dates in the header file */
//Header_InFile 	:= choosen(distribute(doxie_build.file_header_building(~mdr.sourcetools.SourceIsDPPA(src) and dt_last_seen > 0), hash(did)),
//							if(test_count > 0, test_count, choosen:ALL));
Header_InFile1 	:= fn_remove_outliers(doxie_build.file_header_building(~mdr.sourcetools.SourceIsDPPA(src) and dt_last_seen > 0));
Header_InFile := DISTRIBUTE(Header_InFile1, hash(did));
/* TRIM RECORDS used to verify dates */
trimmed_HdrDates := project(Header_InFile, // has dppa filtered out
						transform(SlimMatchLayout, 
							self.matched_addr_min_date := left.dt_first_seen;
							self.matched_addr_max_date := left.dt_last_seen;
							self.matched_temp_src := '';
							self := left));


/* TRIM RECORDS used to correct Infutor and PConsumer when no Header ~DPPA did/address matches */
trimmed_LastResort := project(Infutor_Infile,
						transform(SlimMatchLayout, 
							self.matched_addr_min_date := left.dt_first_seen;
							self.matched_addr_max_date := left.dt_last_seen;
							self := left));

slim_Records_For_Matching := trimmed_HdrDates + trimmed_LastResort;

/////////////////////// ROLLUP slim_Records_For_Matching TO GET THE EARLIEST AND LATEST DID/ADDRESS DATES - Matches comp report rollup
sortTrimFiles := sort(slim_Records_For_Matching, matched_temp_src, did, prim_range, prim_name, st, zip, sec_range, local);

getHeader_addr_dates := 
		rollup(sortTrimFiles,
			left.matched_temp_src = right.matched_temp_src and
			left.did = right.did and
			left.prim_range = right.prim_range and
			left.prim_name = right.prim_name and
			left.st = right.st and
			left.zip = right.zip and
			ut.Sec_range_eq(left.sec_range, right.sec_range) < 10,
			
			transform(SlimMatchLayout,
						self.sec_range := left.sec_range;
						self.matched_addr_min_date := ut.min2(left.matched_addr_min_date,right.matched_addr_min_date);
						self.matched_addr_max_date := max(left.matched_addr_max_date, right.matched_addr_max_date);
						self := right), local);

/////////////////////// JOIN RECORDS from the INCOMING FILE to the ROLLED UP SLIM FILE to APPEND DATES
{Comparison_Layout - matched_temp_src, recordof(Infutor_Infile)} tJnToHeader(recordof(Infutor_Infile) le, recordof(getHeader_addr_dates) ri) := transform

				/* IF and PN should only have blanks when no Header ~DPPA match. All other records should have a match */
				self.dt_first_seen 	 	 := if(ri.matched_addr_min_date > 0, ri.matched_addr_min_date, ri.matched_addr_max_date);
				self.dt_last_seen 	 	 := if(ri.matched_addr_max_date > 0, ri.matched_addr_max_date, ri.matched_addr_min_date);

				/* Flag fields for testing purposes and date assignment*/
				self.Has_Match 	 		 := ri.did > 0;
				self.First_Seen_Valid 	 := le.dt_first_seen between self.dt_first_seen and self.dt_last_seen;
				self.Last_Seen_Valid 	 := le.dt_last_seen between self.dt_first_seen and self.dt_last_seen;
				self.Only_One_Date_Valid := (self.First_Seen_Valid and ~self.Last_Seen_Valid) or (~self.First_Seen_Valid and self.Last_Seen_Valid);
				self.Both_Dates_Valid 	 := self.First_Seen_Valid and self.Last_Seen_Valid;

				/* Assign valid dates */
/* new */		self.dt_vendor_first_reported   := map(self.First_Seen_Valid or self.dt_first_seen = 0 => le.dt_first_seen, //if valid or no header match keep date
												   self.Last_Seen_Valid or self.dt_last_seen = 0 => le.dt_last_seen,    //see if last is available
												   0);
/* new */		self.dt_vendor_last_reported    := map(self.Last_Seen_Valid or self.dt_last_seen = 0 => le.dt_last_seen,    //if valid or no header match keep date
												   self.First_Seen_Valid or self.dt_first_seen = 0 => le.dt_first_seen, //see if first is available
												   0);
				self.orig_valid_min_date			:= self.dt_vendor_first_reported;
				self.orig_valid_max_date			:= self.dt_vendor_last_reported;
				self.No_Dates_Avail 			:= ri.matched_addr_min_date + ri.matched_addr_max_date + le.dt_first_seen + le.dt_last_seen = 0;
				
				self.matched_addr_min_date := ri.matched_addr_min_date;
				self.matched_addr_max_date := ri.matched_addr_max_date;

				self := le;
				end;

JnToHeader := join(Infutor_Infile,getHeader_addr_dates(matched_temp_src = ''), 
							left.did = right.did and
							left.prim_range = right.prim_range and
							left.prim_name = right.prim_name and
							ut.Sec_range_eq(left.sec_range,right.sec_range) < 10 and
							left.zip = right.zip,
							tJnToHeader(left, right), left outer, keep(1), local);


/////////////////////// JOIN RECORDS that have NO MATCH to HEADER ~DPPA to itself to get DATES
recordof(JnToHeader) tJnForLastResort(recordof(JnToHeader) le, recordof(getHeader_addr_dates) ri) := transform
							self.matched_addr_min_date := ri.matched_addr_min_date;
							self.matched_addr_max_date := ri.matched_addr_max_date;
							
							self.dt_first_seen 	 	 := if(ri.matched_addr_min_date > 0, ri.matched_addr_min_date, ri.matched_addr_max_date);
							self.dt_last_seen 	 	 := if(ri.matched_addr_max_date > 0, ri.matched_addr_max_date, ri.matched_addr_min_date);

			/* new */		self.dt_vendor_first_reported   := ut.min2(le.dt_vendor_first_reported, le.dt_vendor_last_reported);
			/* new */		self.dt_vendor_last_reported    := max(le.dt_vendor_first_reported, le.dt_vendor_last_reported);
												   
							self.No_Dates_Avail 	 := ri.matched_addr_min_date + ri.matched_addr_max_date + le.dt_first_seen + le.dt_last_seen = 0;
							self.orig_valid_min_date := self.dt_first_seen;
							self.orig_valid_max_date := self.dt_last_seen;							
							self := le;
							end;

JnToLastResort 		:= join(JnToHeader(~Has_Match),
					   getHeader_addr_dates(matched_temp_src <> ''), 
							left.matched_temp_src = right.matched_temp_src and
							left.did = right.did and
							left.prim_range = right.prim_range and
							left.prim_name = right.prim_name and
							ut.Sec_range_eq(left.sec_range,right.sec_range) < 10 and
							left.zip = right.zip
							,tJnForLastResort(left, right), left outer, keep(1), local);

concatenate_files 	:= JnToLastResort + JnToHeader(Has_Match);

srtByDates := group(sort(concatenate_files, did, -dt_last_seen, -dt_first_seen, -dt_vendor_last_reported, -dt_vendor_first_reported, local), did, local);


grabBestVendorPreviousDate := iterate(srtByDates, transform(recordof(srtByDates),
									temp_dt_vendor_last_reported 	:= map(left.did <> right.did and right.dt_vendor_last_reported = 0 => 99999999,  // first date is blank
																   left.did <> right.did and right.dt_vendor_last_reported > 0 => right.dt_vendor_last_reported, // first date 
																   left.did = right.did and right.dt_vendor_last_reported = 0 and left.dt_vendor_last_reported > 0 => left.dt_vendor_last_reported,
																   left.did = right.did and right.dt_vendor_last_reported = 0 and left.dt_vendor_first_reported > 0 => left.dt_vendor_first_reported,
																   left.did = right.did and right.dt_vendor_last_reported <= left.dt_vendor_first_reported => right.dt_vendor_last_reported,
																   left.did = right.did and right.dt_vendor_last_reported <= left.dt_vendor_last_reported => right.dt_vendor_last_reported,
																   0);
									temp_dt_vendor_first_reported 	:= map(left.did <> right.did and right.dt_vendor_first_reported = 0 => 99999999,  // first date is blank
																   left.did <> right.did and right.dt_vendor_first_reported > 0 => right.dt_vendor_first_reported, // first date 
																   left.did = right.did and right.dt_vendor_first_reported = 0 and left.dt_vendor_first_reported > 0 => left.dt_vendor_first_reported,
																   left.did = right.did and right.dt_vendor_first_reported <= left.dt_vendor_last_reported => right.dt_vendor_first_reported,
																   left.did = right.did and (string)right.dt_vendor_first_reported[..4] <= (string)left.dt_vendor_last_reported[..4] => (unsigned6)((string)right.dt_vendor_first_reported[..4]+'00'),
																   0);
									self.dt_vendor_last_reported 	:= map(temp_dt_vendor_last_reported > 0 => temp_dt_vendor_last_reported,
																		temp_dt_vendor_first_reported > 0 => temp_dt_vendor_first_reported,
																		left.dt_vendor_last_reported);
									self.dt_vendor_first_reported 	:= map(temp_dt_vendor_first_reported > 0 => temp_dt_vendor_first_reported,
																		temp_dt_vendor_last_reported > 0 => temp_dt_vendor_first_reported,
																		left.dt_vendor_first_reported);
									self := right));

placeBestDates := ungroup(project(grabBestVendorPreviousDate, transform(recordof(grabBestVendorPreviousDate),
							self.dt_vendor_last_reported	:= map(left.dt_vendor_last_reported = left.orig_valid_max_date => left.dt_vendor_last_reported,
																   left.dt_vendor_last_reported = left.orig_valid_min_date => left.dt_vendor_last_reported,
																   ((string)left.dt_vendor_last_reported)[..4] = ((string)left.orig_valid_min_date)[..4] => left.dt_vendor_last_reported,
																   0);
							self.dt_vendor_first_reported	:= map(left.dt_vendor_first_reported = left.orig_valid_max_date => left.dt_vendor_first_reported,
																   left.dt_vendor_first_reported = left.orig_valid_min_date => left.dt_vendor_first_reported,
																   ((string)left.dt_vendor_first_reported)[..4] = ((string)left.orig_valid_min_date)[..4] => left.dt_vendor_first_reported,
																   0);
														
							self := left)));

into_inputfile_layout := project(placeBestDates, recordof(pInfutor_Infile));


return into_inputfile_layout;
end;