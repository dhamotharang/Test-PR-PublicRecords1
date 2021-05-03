IMPORT _control, Property, data_services, STD; 
export ChartsGeoMaps_Foreclosure(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function

/*cleo needs these outputs:
•	tbl_all_by_state
•	tbl_doct_typ
•	LisPendens_by_Fips_And_Year
•	NODs_by_Fips_And_Year
•	tbl_deed_cat
•	Foreclosure_by_Fips_And_Year
tbl_ChartsGeoMaps_Foreclosure_All_By_Category_ByState_filedate.csv //REMOVE THIS ONE 
tbl_ChartsGeoMaps_Foreclosure_All_by_State_And_Year_filedate.csv //REMOVE THIS ONE
tbl_ChartsGeoMaps_Foreclosure_All_By_Fips_And_Year_filedate.csv //REMOVE THIS ONE*/

filedate := today;

//NOD & Foreclosure file now includes data from CL and BKS; source codes:  FR - CL NOD/Foreclosure; B7 - BKS NOD (incl Lis Pendens, etc); I5 - BKS REO (bank owned)
nod_base := Property.File_Foreclosure_Base_v2;
nod_norm := Property.File_Foreclosure_Normalized;

//---NOTE-- BKS records are not categorized the same as FR source which may lead to skewed stats; may reach out to dev team to revisit
//---NOTE-- there are many recs with blank document description from FR source; may need to review/revisit...
//populate deed category where missing for two known codes
nod_base_cats := PROJECT(nod_base,TRANSFORM({nod_base},
						self.deed_desc := MAP(left.deed_category = 'Q' => 'Quit Claim',
												left.deed_category = 'X' => 'Multi County/State - Open End Mortgage',
												left.deed_desc);
												 self := left));

//------------- Below code is used in "By Deed Description" & "By Document Type" Reports ------------- //
tbl_all_by_state := sort(table(nod_base_cats, {property_state_1, total:=count(group)}, property_state_1, few),property_state_1);
tbl_nod_by_state := sort(table(nod_base_cats(deed_category='N'), {property_state_1, total:=count(group)}, property_state_1, few),property_state_1);
tbl_lis_by_state := sort(table(nod_base_cats(deed_category='L'), {property_state_1, total:=count(group)}, property_state_1, few),property_state_1);
tbl_for_by_state := sort(table(nod_base_cats(deed_category='U'), {property_state_1, total:=count(group)}, property_state_1, few),property_state_1);

tbl_doct_typ := sort(table(nod_base_cats, {document_desc, total:=count(group)}, document_desc, few),document_desc);
tbl_deed_cat := sort(table(nod_base_cats, {deed_desc, total:=count(group)}, deed_desc, few),deed_desc);
tbl_cat_type := sort(table(nod_base_cats, {deed_desc, document_desc, total:=count(group)}, deed_desc, document_desc, few),deed_desc, document_desc);

//All combinations from above including source
srt_nod := sort(distribute(nod_base_cats, hash(source, deed_category, deed_desc, document_type, document_desc)),
																							 source, deed_category, deed_desc, document_type, document_desc,local,skew(1.0));

nod_tbl_src_cat_type := sort(table(srt_nod, {source, deed_category, deed_desc, document_type, document_desc, cnt:=count(group)}, 
																						 source, deed_category, deed_desc, document_type, document_desc, many),
																						 source, deed_category, deed_desc);

//------------- Below code is used in Data Analysis by State/County/Historical reports ------------- //
rFIPS := RECORD
		string5 fips;
		string2 state_abbr :=''; 
		string county_desc :='';
		string4 recording_yr;
		nod_base_cats;
	END;

rFIPS xFIPS(nod_base_cats pInput) := TRANSFORM
		SELF.fips := TRIM(pInput.state, LEFT, RIGHT) + TRIM(pInput.county, LEFT, RIGHT);
		SELF.recording_yr := pInput.recording_date[1..4];
		SELF := pInput;
	END;

File_Base_Forecl_Fips := PROJECT(nod_base_cats, xFIPS(LEFT));
OUTPUT( CHOOSEN( File_Base_Forecl_Fips,100 ), NAMED('Sample_File_Base_Forecl_fips_recyr') );

prj_ds_Forecl := File_Base_Forecl_Fips(fips IN DI_Metrics.fips_code_list); //zz_CDKelly.fips_code_list);
ds_Forecl := sort(distribute(prj_ds_Forecl, hash(fips)),fips,local, skew(1.0)); 

rFIPS x_fips_stcnty(ds_Forecl L, DI_Metrics.File_FIPS_lookup R) := TRANSFORM //zz_CDKelly.File_FIPS_lookup R) := TRANSFORM
		SELF.state_abbr := R.state_code;
		SELF.county_desc := R.county_name;
		SELF := L;
		SELF := R;
	END;

ds_Forecl_fips := JOIN(ds_Forecl, DI_Metrics.File_FIPS_lookup, //zz_CDKelly.File_FIPS_lookup, 
													LEFT.fips = RIGHT.fips_code,
													x_fips_stcnty(LEFT, RIGHT),
													LEFT OUTER);
OUTPUT( CHOOSEN( ds_Forecl_fips,100 ), NAMED('Sample_ds_Forecl_fips') );

// output(TABLE(ds_Forecl_st_cnty, {deed_category,deed_desc,document_type, document_desc, rec_count := count(group)},
																 // deed_category,deed_desc,document_type, document_desc,few),all,named('All_Forecl_DeedCat_Doc_Type'));

//Record Counts By State --> tab labeled "REC_COUNTS"
NOD := ds_Forecl_fips(deed_category = 'N');
LisPendens := ds_Forecl_fips(deed_category = 'L');
Foreclosures := ds_Forecl_fips(deed_category = 'U');

nod_st_tbl := sort(table(NOD, {state, state_abbr, total:=count(group)}, state, few), state, skew(1.0));
lis_st_tbl := sort(table(LisPendens, {state, state_abbr, total:=count(group)}, state, few), state, skew(1.0));
for_st_tbl := sort(table(Foreclosures, {state, state_abbr, total:=count(group)}, state, few), state, skew(1.0));
all_st_tbl := sort(table(ds_Forecl_fips, {deed_category, state_abbr, total:=count(group)}, deed_category, state_abbr, many), deed_category, state_abbr, skew(1.0));

//By State last 8 Years --> tab labeled "REC_COUNTS_8_YRS"
rDates := RECORD
		ds_Forecl_fips.state_abbr;
		ds_Forecl_fips.deed_category;
		ds_Forecl_fips.deed_desc;
		rec_count := COUNT(GROUP);
		Null := sum(group,if(ds_Forecl_fips.recording_yr = '' OR ds_Forecl_fips.recording_yr = '0000',1,0));
		prior_1990 := sum(group,if(ds_Forecl_fips.recording_yr between '0001' and '1989',1,0));
		value_1990 := sum(group,if(ds_Forecl_fips.recording_yr = '1990',1,0));
		value_1991 := sum(group,if(ds_Forecl_fips.recording_yr = '1991',1,0));
		value_1992 := sum(group,if(ds_Forecl_fips.recording_yr = '1992',1,0));
		value_1993 := sum(group,if(ds_Forecl_fips.recording_yr = '1993',1,0));
		value_1994 := sum(group,if(ds_Forecl_fips.recording_yr = '1994',1,0));
		value_1995 := sum(group,if(ds_Forecl_fips.recording_yr = '1995',1,0));
		value_1996 := sum(group,if(ds_Forecl_fips.recording_yr = '1996',1,0));
		value_1997 := sum(group,if(ds_Forecl_fips.recording_yr = '1997',1,0));
		value_1998 := sum(group,if(ds_Forecl_fips.recording_yr = '1998',1,0));
		value_1999 := sum(group,if(ds_Forecl_fips.recording_yr = '1999',1,0));
		value_2000 := sum(group,if(ds_Forecl_fips.recording_yr = '2000',1,0));
		value_2001 := sum(group,if(ds_Forecl_fips.recording_yr = '2001',1,0));
		value_2002 := sum(group,if(ds_Forecl_fips.recording_yr = '2002',1,0));
		value_2003 := sum(group,if(ds_Forecl_fips.recording_yr = '2003',1,0));
		value_2004 := sum(group,if(ds_Forecl_fips.recording_yr = '2004',1,0));
		value_2005 := sum(group,if(ds_Forecl_fips.recording_yr = '2005',1,0));
		value_2006 := sum(group,if(ds_Forecl_fips.recording_yr = '2006',1,0));
		value_2007 := sum(group,if(ds_Forecl_fips.recording_yr = '2007',1,0));
		value_2008 := sum(group,if(ds_Forecl_fips.recording_yr = '2008',1,0));
		value_2009 := sum(group,if(ds_Forecl_fips.recording_yr = '2009',1,0));
		value_2010 := sum(group,if(ds_Forecl_fips.recording_yr = '2010',1,0));
		value_2011 := sum(group,if(ds_Forecl_fips.recording_yr = '2011',1,0));
		value_2012 := sum(group,if(ds_Forecl_fips.recording_yr = '2012',1,0));
		value_2013 := sum(group,if(ds_Forecl_fips.recording_yr = '2013',1,0));
		value_2014 := sum(group,if(ds_Forecl_fips.recording_yr = '2014',1,0));
		value_2015 := sum(group,if(ds_Forecl_fips.recording_yr = '2015',1,0));
		value_2016 := sum(group,if(ds_Forecl_fips.recording_yr = '2016',1,0));
		value_2017 := sum(group,if(ds_Forecl_fips.recording_yr = '2017',1,0));
		value_2018 := sum(group,if(ds_Forecl_fips.recording_yr = '2018',1,0));
		value_2019 := sum(group,if(ds_Forecl_fips.recording_yr = '2019',1,0));
		post_2019  := sum(group,if(ds_Forecl_fips.recording_yr > '2019',1,0));
		END;

tDates_state := sort(table(ds_Forecl_fips, rDates, state_abbr, FEW), state_abbr, skew(1.0));

tDates_state_N := tDates_state(deed_category = 'N');
tDates_state_L := tDates_state(deed_category = 'L');
tDates_state_U := tDates_state(deed_category = 'U');

//we’ll have to update the ECL code to account for 2020 as such (and not as “post_2019”), whenever that’s possible. I sent a calendar invite
//to Cleo so we do this the first week of every January. we ought to look for a way to change this file so that it generates the datasets
//dynamically instead of modifying it each month. Let’s discuss during our next ECL automation meeting.

//By FIPS last 8 Years --> tab labeled "REC_COUNTS_BY_COUNTY"
rDates_deed_category :=	RECORD
		ds_Forecl_fips.state_abbr;
		ds_Forecl_fips.county_desc;
		ds_Forecl_fips.fips;
		ds_Forecl_fips.deed_category;
		ds_Forecl_fips.deed_desc;
		rec_count := COUNT(GROUP);
		Null := sum(group,if(ds_Forecl_fips.recording_yr = '' OR ds_Forecl_fips.recording_yr = '0000',1,0));
		prior_1990 := sum(group,if(ds_Forecl_fips.recording_yr between '0001' and '1989',1,0));
		value_1990 := sum(group,if(ds_Forecl_fips.recording_yr = '1990',1,0));
		value_1991 := sum(group,if(ds_Forecl_fips.recording_yr = '1991',1,0));
		value_1992 := sum(group,if(ds_Forecl_fips.recording_yr = '1992',1,0));
		value_1993 := sum(group,if(ds_Forecl_fips.recording_yr = '1993',1,0));
		value_1994 := sum(group,if(ds_Forecl_fips.recording_yr = '1994',1,0));
		value_1995 := sum(group,if(ds_Forecl_fips.recording_yr = '1995',1,0));
		value_1996 := sum(group,if(ds_Forecl_fips.recording_yr = '1996',1,0));
		value_1997 := sum(group,if(ds_Forecl_fips.recording_yr = '1997',1,0));
		value_1998 := sum(group,if(ds_Forecl_fips.recording_yr = '1998',1,0));
		value_1999 := sum(group,if(ds_Forecl_fips.recording_yr = '1999',1,0));
		value_2000 := sum(group,if(ds_Forecl_fips.recording_yr = '2000',1,0));
		value_2001 := sum(group,if(ds_Forecl_fips.recording_yr = '2001',1,0));
		value_2002 := sum(group,if(ds_Forecl_fips.recording_yr = '2002',1,0));
		value_2003 := sum(group,if(ds_Forecl_fips.recording_yr = '2003',1,0));
		value_2004 := sum(group,if(ds_Forecl_fips.recording_yr = '2004',1,0));
		value_2005 := sum(group,if(ds_Forecl_fips.recording_yr = '2005',1,0));
		value_2006 := sum(group,if(ds_Forecl_fips.recording_yr = '2006',1,0));
		value_2007 := sum(group,if(ds_Forecl_fips.recording_yr = '2007',1,0));
		value_2008 := sum(group,if(ds_Forecl_fips.recording_yr = '2008',1,0));
		value_2009 := sum(group,if(ds_Forecl_fips.recording_yr = '2009',1,0));
		value_2010 := sum(group,if(ds_Forecl_fips.recording_yr = '2010',1,0));
		value_2011 := sum(group,if(ds_Forecl_fips.recording_yr = '2011',1,0));
		value_2012 := sum(group,if(ds_Forecl_fips.recording_yr = '2012',1,0));
		value_2013 := sum(group,if(ds_Forecl_fips.recording_yr = '2013',1,0));
		value_2014 := sum(group,if(ds_Forecl_fips.recording_yr = '2014',1,0));
		value_2015 := sum(group,if(ds_Forecl_fips.recording_yr = '2015',1,0));
		value_2016 := sum(group,if(ds_Forecl_fips.recording_yr = '2016',1,0));
		value_2017 := sum(group,if(ds_Forecl_fips.recording_yr = '2017',1,0));
		value_2018 := sum(group,if(ds_Forecl_fips.recording_yr = '2018',1,0));
		value_2019 := sum(group,if(ds_Forecl_fips.recording_yr = '2019',1,0));
		post_2019  := sum(group,if(ds_Forecl_fips.recording_yr > '2019',1,0));
		END;

tDates_fips_category := sort(table(ds_Forecl_fips, rDates_deed_category, fips, deed_category,deed_desc, FEW), fips, skew(1.0));

tDates_fips_N := tDates_fips_category(deed_category = 'N');
tDates_fips_L := tDates_fips_category(deed_category = 'L');
tDates_fips_U := tDates_fips_category(deed_category = 'U');

//Despray CSV to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_tbl_all_by_state := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_all_by_state_'+ filedate +'.csv',
																			 pHostname, 
																			 pTarget + '/tbl_ChartsGeoMaps_all_by_state_'+ filedate +'.csv'
																			 ,,,,true);

despray_tbl_doct_typ := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_doct_typ_'+ filedate +'.csv',
																			  pHostname, 
																			  pTarget+ '/tbl_ChartsGeoMaps_doct_typ_'+ filedate +'.csv'
																			  ,,,,true);

despray_tbl_deed_cat := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_deed_cat_'+ filedate +'.csv',
																			  pHostname, 
																			  pTarget+ '/tbl_ChartsGeoMaps_deed_cat_'+ filedate +'.csv'
																			  ,,,,true);

despray_LisPendens_by_Fips_And_Year := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_LisPendens_by_Fips_And_Year_'+ filedate +'.csv',
																			   pHostname, 
																			   pTarget+ '/tbl_ChartsGeoMaps_LisPendens_by_Fips_And_Year_'+ filedate +'.csv'
																			   ,,,,true);

despray_NODs_by_Fips_And_Year := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_NODs_by_Fips_And_Year_'+ filedate +'.csv',
																			 pHostname, 
																			 pTarget+ '/tbl_ChartsGeoMaps_NODs_by_Fips_And_Year_'+ filedate +'.csv'
																			 ,,,,true);

despray_Foreclosure_by_Fips_And_Year := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_Foreclosure_by_Fips_And_Year_'+ filedate +'.csv',
																			   pHostname, 
																			   pTarget+ '/tbl_ChartsGeoMaps_Foreclosure_by_Fips_And_Year_'+ filedate +'.csv'
																			   ,,,,true);																			   

/* -------- Final WUIDs from Jessica to update DMP reports -------- //
Foreclosure - W20190219-131441
by Doc Type (top 10) - W20190219-131343
by deed category descr - W20190219-131246
NODs, LisPendens, Foreclosures by state & Year, Lis Pendens by state & Year, Foreclosures by state & Yr: 
 rec counts: W20190204-151449 (Dataland)
 rec Counts 8 yrs: W20190205-091651 (Dataland)
 rec counts by county: W20190204-134748 (dataland)
*/

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					 output(tbl_all_by_state,,'~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_all_by_state_'+ filedate +'.csv', CSV(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,output(tbl_doct_typ,,'~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_doct_typ_'+ filedate +'.csv', CSV(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))					
					,output(tbl_deed_cat,,'~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_deed_cat_'+ filedate +'.csv', CSV(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))										
					,output(sort(tDates_fips_L, fips, deed_category),,'~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_LisPendens_by_Fips_And_Year_'+ filedate +'.csv', CSV(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))					
					,output(sort(tDates_fips_N, fips, deed_category),,'~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_NODs_by_Fips_And_Year_'+ filedate +'.csv', CSV(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))										
					,output(sort(tDates_fips_U, deed_category),,'~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_Foreclosure_by_Fips_And_Year_'+ filedate +'.csv', CSV(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))										
					,despray_tbl_all_by_state 
					,despray_tbl_doct_typ 
					,despray_tbl_deed_cat 
					,despray_LisPendens_by_Fips_And_Year 					
					,despray_NODs_by_Fips_And_Year 
					,despray_Foreclosure_by_Fips_And_Year):
					Success(FileServices.SendEmail(pContact, 'ChartsGeoMaps Group: ChartsGeoMaps_Foreclosure Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'ChartsGeoMaps Group: ChartsGeoMaps_Foreclosure Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
					);
return email_alert;

end;