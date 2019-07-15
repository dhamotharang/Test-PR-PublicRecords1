EXPORT MAC_RangeFieldYYYYMMDD_By_UID_optimized(infile,ufield,infield,low_infield,high_infield,null_field,outfile) := MACRO

/* The File_Sample data has imperfect dates (some MM , DD parts are 0, or not realistic).
I used the following function (appplied on (UNSIGNED6)low/high_infield) in the %infile_parse%
Need to use this function in this macro - atleast for using on File_Sample data. If I dont use this function, 
then idata_prepped has some seriously messed up df/ls_lo/high_day/month values(eg month = 4294967295),
which affects the count parameter of Normalize , while counting dates 

We need to decide if this cleaning stays for production, can we blindly assume that the dates already come cleaned? OR
sperately enforce cleaning on rangefield through hygiene.
*/

UNSIGNED6 clean_yyyymmdd(UNSIGNED6 yyyymmdd) := FUNCTION
ypart := yyyymmdd  DIV 10000;
mpart := (yyyymmdd DIV 100)%100;
dpart := yyyymmdd % 100;
mpart_cleaned := IF(mpart <1 OR mpart >12, 6, mpart);
dpart_cleaned := IF(dpart < 1 OR dpart >31, 28, dpart); //not perfect cleaning - can refine later - shouldnt matter if dates come cleaned
RETURN ypart * 10000 + mpart_cleaned * 100 + dpart_cleaned;
END;

#uniquename(infile_parse)
%infile_parse% := RECORD
  SALT311.UIDType ufield := infile.ufield;
	UNSIGNED6 dfs := clean_yyyymmdd((UNSIGNED6)infile.low_infield);
  UNSIGNED8 dls := clean_yyyymmdd((UNSIGNED6)infile.high_infield);
  UNSIGNED4 dfs_year := clean_yyyymmdd((UNSIGNED6)infile.low_infield) DIV 10000;
  UNSIGNED4 dfs_month := (clean_yyyymmdd((UNSIGNED6)infile.low_infield) DIV 100) % 100;
  UNSIGNED4 dfs_day := clean_yyyymmdd((UNSIGNED6)infile.high_infield) % 100;
  UNSIGNED4 dls_year := clean_yyyymmdd((UNSIGNED6)infile.high_infield) DIV 10000;
  UNSIGNED4 dls_month := (clean_yyyymmdd((UNSIGNED6)infile.high_infield) DIV 100) % 100;// If month is 00 - convert to 6?
  UNSIGNED4 dls_day := clean_yyyymmdd((UNSIGNED6)infile.high_infield) % 100;// If day is 00 - convert to 15?
END;
#uniquename(idata_parsed)
// Presently we do not handle open ended ranges (well)
// We also need to make sure that all dates are in 8 digits (YYYYMMDD)
%idata_parsed% := TABLE(infile((UNSIGNED6)low_infield<>null_field,(UNSIGNED6)high_infield<>null_field,(UNSIGNED6)low_infield>10000000,(UNSIGNED6)high_infield>10000000, low_infield <= high_infield), %infile_parse%);

/* Function: end_of_month_day - computes the last date of a given YYYYMM
	@param: month - MM part 
	@param:year - YYYY part
*/
UNSIGNED4 end_of_month_day(UNSIGNED4 month, UNSIGNED4 year) := FUNCTION 
	leap := year % 4 = 0;
	RETURN IF(leap AND month = 2, 29, CASE(month, 1 => 31, 2 => 28, 3 => 31, 4 => 30, 5 => 31, 6 => 30, 7 => 31, 8 => 31, 9 =>30, 10 => 31, 11 => 30, 12 =>31,30));
END;
#uniquename(idata_prep)
%idata_prep% := RECORD
 %idata_parsed%;
 BOOLEAN count_year := %idata_parsed%.dls_year - %idata_parsed%.dfs_year >= 2;//only if one full year in between
 UNSIGNED4 year_low :=  %idata_parsed%.dfs_year + 1;
 UNSIGNED4 year_high := %idata_parsed%.dls_year - 1; 
 
 BOOLEAN count_f_month := (%idata_parsed%.dls_year - %idata_parsed%.dfs_year > 0 AND %idata_parsed%.dfs_month <> 12) OR (%idata_parsed%.dls_month - %idata_parsed%.dfs_month >= 2);//year is different OR atleast one month in between
 UNSIGNED4 dfs_month_low := %idata_parsed%.dfs_month + 1;
 UNSIGNED4 dfs_month_high := IF(%idata_parsed%.dls_year - %idata_parsed%.dfs_year > 0 AND %idata_parsed%.dfs_month < 12, 12, %idata_parsed%.dls_month - 1); 

 BOOLEAN count_l_month := (%idata_parsed%.dls_year - %idata_parsed%.dfs_year > 0 AND %idata_parsed%.dls_month > 1); // same year case was handled in count_f_month
 UNSIGNED4 dls_month_low := 1;
 UNSIGNED4 dls_month_high := %idata_parsed%.dls_month - 1;
 
 UNSIGNED4 dfs_day_low := %idata_parsed%.dfs_day;
 UNSIGNED4 dfs_day_high := IF(%idata_parsed%.dfs_year = %idata_parsed%.dls_year AND %idata_parsed%.dfs_month = %idata_parsed%.dls_month, %idata_parsed%.dls_day, end_of_month_day(%idata_parsed%.dfs_month, %idata_parsed%.dfs_year));
 
 BOOLEAN count_l_day := %idata_parsed%.dfs_year <> %idata_parsed%.dls_year OR %idata_parsed%.dfs_month <> %idata_parsed%.dls_month;
 UNSIGNED4 dls_day_low := 1;
 UNSIGNED4 dls_day_high := %idata_parsed%.dls_day;
END;
#uniquename(idata_prepped)
%idata_prepped% := TABLE(%idata_parsed%,%idata_prep%);

#uniquename(idata_prep_days)
%idata_prep_days% := RECORD
 %idata_prepped%;
 UNSIGNED4 dfs_int_low  := SALT311.fn_YYYYMMDD_to_Int(%idata_prepped%.dfs);
 UNSIGNED4 dfs_int_high := SALT311.fn_YYYYMMDD_to_Int((UNSIGNED8)(%idata_prepped%.dfs_year * 10000 + %idata_prepped%.dfs_month * 100 + %idata_prepped%.dfs_day_high));

 UNSIGNED4 dls_int_low  := SALT311.fn_YYYYMMDD_to_Int((UNSIGNED8)(%idata_prepped%.dls_year * 10000 + %idata_prepped%.dls_month * 100 + 1));
 UNSIGNED4 dls_int_high := SALT311.fn_YYYYMMDD_to_Int(%idata_prepped%.dls);
END;
#uniquename(idata_prepped_days)
%idata_prepped_days% := TABLE(%idata_prepped%,%idata_prep_days%);

/*
If you need to debug, you can encapsulate range_ent_rec to YYYYMM_range_ent_rec := RECORD UNSIGNED6 YYYY; UNSIGNED6 YYYYMM; range_ent_rec; END;
and use this format to output the normalized table
*/
#uniquename(range_ent_rec)
%range_ent_rec% := RECORD 
	UNSIGNED8 infield_beg; //reporteddate of the first day of a given year/ month
	UNSIGNED8 infield_end; //reporteddate of the last day of a given year/ month
	//UNSIGNED8 YYYY; // Uncomment to debug 
	//UNSIGNED8 YYYYMM; // Uncomment to debug
	SALT311.UIDType ufield;
END;

// List entities that span a whole year
#uniquename(tr_YYYY)
%range_ent_rec% %tr_YYYY%(%idata_prepped% le,INTEGER c) := TRANSFORM
	SELF.infield_beg := SALT311.fn_YYYYMMDD_to_Int(c* 10000 + 101); // Jan 1st of this year
	SELF.infield_end := SALT311.fn_YYYYMMDD_to_Int(c* 10000 + 1231); // Dec 31st of this year
	//SELF.YYYY := c; //Get the cth year0000 from given date (dt_first_seen) - Assumes all dates are in YYYYMMDD format = 8 digits
	//SELF.YYYYMM := 0; //dummy field in this context
	SELF.ufield := le.ufield;
  END;
#uniquename(n_year)
%n_year% := NORMALIZE(%idata_prepped%(count_year), LEFT.year_high - LEFT.year_low + 1,%tr_YYYY%(LEFT,COUNTER-1+LEFT.year_low)); //Consider only those records where the dfs/ dls years are not same or adjacent. There is atleast one full year between them//No. of years exactly between dfs and dls (excluding dfs & dls years)

// List entities that span a whole month (the month can be before the spanning year/s or after)

#uniquename(tr_YYYYMM_dfs)
%range_ent_rec% %tr_YYYYMM_dfs%(%idata_prepped% le,INTEGER c) := TRANSFORM
	SELF.infield_beg := SALT311.fn_YYYYMMDD_to_Int(le.dfs_year * 10000 + c * 100 + 1 ); // 1st of this month
	SELF.infield_end := SALT311.fn_YYYYMMDD_to_Int(le.dfs_year * 10000 + c * 100 + end_of_month_day(c,le.dfs_year)); // Last date of this month
	//SELF.YYYYMM := le.dfs_year * 100 + c; //Get the cth year0000 from given date (dt_first_seen) - Assumes all dates are in YYYYMMDD format = 8 digits
	//SELF.YYYY := 0; //dummy field for this context
	SELF.ufield := le.ufield;
  END;
#uniquename(n_month_dfs)
%n_month_dfs% := NORMALIZE(%idata_prepped%(count_f_month), LEFT.dfs_month_high - LEFT.dfs_month_low + 1,%tr_YYYYMM_dfs%(LEFT,COUNTER-1+LEFT.dfs_month_low)); //Consider only those records where the dfs/ dls years are not same or adjacent. There is atleast one full year between them//No. of years exactly between dfs and dls (excluding dfs & dls years)

#uniquename(tr_YYYYMM_dls)
%range_ent_rec% %tr_YYYYMM_dls%(%idata_prepped% le,INTEGER c) := TRANSFORM
	SELF.infield_beg := SALT311.fn_YYYYMMDD_to_Int(le.dls_year * 10000 + c * 100 + 1 ); // 1st of this month
	SELF.infield_end := SALT311.fn_YYYYMMDD_to_Int(le.dls_year * 10000 + c * 100+ end_of_month_day(c,le.dls_year)); // Last date of this month
	SELF.ufield := le.ufield;
	//SELF.YYYYMM := le.dls_year * 100 + c; //Get the cth year0000 from given date (dt_first_seen) - Assumes all dates are in YYYYMMDD format = 8 digits
	//SELF.YYYY := 0; //dummy field for this context
  END;
#uniquename(n_month_dls)	
%n_month_dls% := NORMALIZE(%idata_prepped%(count_l_month), LEFT.dls_month_high - LEFT.dls_month_low + 1,%tr_YYYYMM_dls%(LEFT,COUNTER-1+LEFT.dls_month_low)); //Consider only those records where the dfs/ dls years are not same or adjacent. There is atleast one full year between them//No. of years exactly between dfs and dls (excluding dfs & dls years)
 
// List all entities that dont split a month by day 
#uniquename(infield_ent_rec)	
%infield_ent_rec% := RECORD
  UNSIGNED8 infield;
	SALT311.UIDType ufield;
END;
#uniquename(tr_days)
%infield_ent_rec% %tr_days% (%idata_prepped_days% le, INTEGER c) := TRANSFORM
 SELF.infield := c;
 SELF.ufield := le.ufield;
END;
#uniquename(n_dfs)
%n_dfs% := NORMALIZE(%idata_prepped_days%, LEFT.dfs_int_high - LEFT.dfs_int_low + 1, %tr_days%(LEFT,COUNTER-1+LEFT.dfs_int_low)); //from dfs to one day before beggining of next month
#uniquename(n_dls)
%n_dls% := NORMALIZE(%idata_prepped_days%(count_l_day), LEFT.dls_int_high - LEFT.dls_int_low + 1, %tr_days%(LEFT,COUNTER-1 +LEFT.dls_int_low)); //from 1st day of ls month to dls

//Count year, month and day entities
#uniquename(range_ent_cnt_rec)
%range_ent_cnt_rec% := RECORD //here cnt is record count
	%range_ent_rec%;
	UNSIGNED8 cnt;
END;
#uniquename(outfile_year)
%outfile_year% := TABLE(%n_year%,{infield_beg,infield_end/*,YYYY*/,ufield,Cnt := COUNT(GROUP)},infield_beg,infield_end/*,YYYY*/,ufield,LOCAL); // this can give you year counts 
#uniquename(outfile_month_dfs)
%outfile_month_dfs% := TABLE( %n_month_dfs%,{infield_beg,infield_end/*,YYYYMM*/,ufield,Cnt := COUNT(GROUP)},infield_beg,infield_end/*,YYYYMM*/,ufield,LOCAL); // this can give you year counts 
#uniquename(outfile_month_dls)
%outfile_month_dls% := TABLE( %n_month_dls%,{infield_beg,infield_end/*,YYYYMM*/,ufield,Cnt := COUNT(GROUP)},infield_beg,infield_end/*,YYYYMM*/,ufield,LOCAL); // this can give you year counts 
#uniquename(outfile_dfs)
%outfile_dfs% := TABLE( %n_dfs%,{infield,ufield,UNSIGNED8 Cnt := COUNT(GROUP)},infield,ufield,LOCAL);
#uniquename(outfile_dls)
%outfile_dls% := TABLE( %n_dls%,{infield,ufield,UNSIGNED8 Cnt := COUNT(GROUP)},infield,ufield,LOCAL);
 
// Convert month and year spanning entity lists to {reporteddate, entity} format
#uniquename(infield_ent_cnt_rec)
%infield_ent_cnt_rec% := RECORD // format from MAC_Field_Count_UID
  UNSIGNED8 infield; //fieldvals.infield
	SALT311.UIDType ufield;
  UNSIGNED8 cnt; // this is record count!
END;

#uniquename(expand_YYYY)
%infield_ent_cnt_rec% %expand_YYYY%(%outfile_year% le, INTEGER c) := TRANSFORM
	SELF.infield := c;
	SELF.ufield := le.ufield;
	SELF.cnt := le.cnt;
END;
#uniquename(outfile_year_infield)
%outfile_year_infield% := SORT(NORMALIZE(%outfile_year%, LEFT.infield_end - LEFT.infield_beg +1, %expand_YYYY% (LEFT,COUNTER-1+LEFT.infield_beg)), infield, ufield);

#uniquename(expand_YYYYMM_dfs)
%infield_ent_cnt_rec% %expand_YYYYMM_dfs%(%outfile_month_dfs% le, INTEGER c) := TRANSFORM
	SELF.infield := c;
	SELF.ufield := le.ufield;
	SELF.cnt := le.cnt;
END;
#uniquename(outfile_month_dfs_infield)
%outfile_month_dfs_infield% := SORT(NORMALIZE(%outfile_month_dfs%, LEFT.infield_end - LEFT.infield_beg +1, %expand_YYYYMM_dfs% (LEFT,COUNTER-1+LEFT.infield_beg)), infield, ufield);

#uniquename(expand_YYYYMM_dls)
%infield_ent_cnt_rec% %expand_YYYYMM_dls%(%outfile_month_dls% le, INTEGER c) := TRANSFORM
	SELF.infield := c;
	SELF.ufield := le.ufield;
	SELF.cnt := le.cnt;
END;
#uniquename(outfile_month_dls_infield)
%outfile_month_dls_infield% := SORT(NORMALIZE(%outfile_month_dls%, LEFT.infield_end - LEFT.infield_beg +1, %expand_YYYYMM_dls% (LEFT,COUNTER-1+LEFT.infield_beg)), infield, ufield);

// Combine all outfiles and dedup by infield,did, Cnt := COUNT(GROUP)
#uniquename(outfile_set)
%outfile_set% := [SORTED(%outfile_year_infield%) ,SORTED(%outfile_month_dfs_infield%), SORTED(%outfile_month_dls_infield%), SORTED(%outfile_dfs%), SORTED(%outfile_dls%)];
#uniquename(tr_roll)
%infield_ent_cnt_rec% %tr_roll%(%infield_ent_cnt_rec% le, %infield_ent_cnt_rec% ri):= TRANSFORM
	SELF.infield := le.infield;
	SELF.ufield := le.ufield;
	SELF.cnt := le.cnt + ri.cnt;
END;
outfile := ROLLUP(MERGE(%outfile_set%,infield,ufield,SORTED(infield,ufield)),LEFT.infield = RIGHT.infield AND LEFT.ufield = RIGHT.ufield, %tr_roll%(LEFT,RIGHT));
  ENDMACRO;
