import Bankrupt,lib_keylib,lib_fileservices, Property;

Liens_stat_dis := Bankrupt.File_Liens_service(filing_date <> '' or filing_date <> '00000000');

//Liens_stat_dis := distribute(Liens_file,hash(courtid));

/*Liens_stat_rec :=  record
 Liens_stat_dis.county;
 total := count(group);
 Max_filing_date := MAX(group,Liens_stat_dis.filing_date);
 Min_filing_date := MIN(group,Liens_stat_dis.filing_date);
 Liens_stat_courtid := count(group, Liens_stat_dis.courtid <> '');
 Liens_stat_indivbusun := count(group,Liens_stat_dis.indivbusun <> '');
 Liens_stat_aka_yn:= count(group,Liens_stat_dis.aka_yn <> '');
 Liens_stat_assoccode:= count(group,Liens_stat_dis.assoccode <> '');
 Liens_stat_court_desc := count(group,Liens_stat_dis.court_desc <> '');
 Liens_stat_filetypeid := count(group,Liens_stat_dis.filetypeid <> '');
 Liens_stat_filingtype_desc := count(group,Liens_stat_dis.filingtype_desc <> '');
 Liens_stat_casenumber := count(group,Liens_stat_dis.casenumber <> '');
 Liens_stat_book := count(group,Liens_stat_dis.book <> '');
 Liens_stat_page := count(group,Liens_stat_dis.page <> '');
 Liens_stat_release_date := count(group,Liens_stat_dis.release_date <> '');
 Liens_stat_amount := count(group,Liens_stat_dis.amount <> '');
 Liens_stat_assets := count(group,Liens_stat_dis.assets <> '');
 Liens_stat_plaintiff := count(group,Liens_stat_dis.plaintiff <> '');
 Liens_stat_othercase := count(group,Liens_stat_dis.othercase <> '');
 Liens_stat_orig_ssn := count(group,Liens_stat_dis.orig_ssn <> '');
 Liens_stat_defname := count(group,Liens_stat_dis.defname <> '');
 Liens_stat_generation := count(group,Liens_stat_dis.generation <> '');
 Liens_stat_address := count(group,Liens_stat_dis.address <> '');
 Liens_stat_orig_city := count(group,Liens_stat_dis.orig_city <> '');
 Liens_stat_orig_state := count(group,Liens_stat_dis.orig_state <> '');
 Liens_stat_orig_zip := count(group,Liens_stat_dis.orig_zip <> '');
 Liens_stat_uploaddate := count(group,Liens_stat_dis.uploaddate <> '');
 Liens_stat_unlawdetyn := count(group,Liens_stat_dis.unlawdetyn <> '');
 Liens_stat_origcase := count(group,Liens_stat_dis.origcase <> '');
 Liens_stat_origbook := count(group,Liens_stat_dis.origbook <> '');
 Liens_stat_origpage := count(group,Liens_stat_dis.origpage <> '');
 Liens_stat_actiontype := count(group,Liens_stat_dis.actiontype <> '');
 Liens_stat_stl_type := count(group,Liens_stat_dis.stl_type <> '');
 Liens_stat_rmsid := count(group,Liens_stat_dis.rmsid <> '');
 Liens_stat_def_title := count(group,Liens_stat_dis.def_title <> '');
 Liens_stat_def_fname := count(group,Liens_stat_dis.def_fname <> '');
 Liens_stat_def_mname := count(group,Liens_stat_dis.def_mname <> '');
 Liens_stat_def_lname := count(group,Liens_stat_dis.def_lname <> '');
 Liens_stat_def_name_suffix := count(group,Liens_stat_dis.def_name_suffix <> '');
 Liens_stat_def_name_score := count(group,Liens_stat_dis.def_name_score <> '');
 Liens_stat_def_company := count(group,Liens_stat_dis.def_company <> '');
 Liens_stat_plain_title := count(group,Liens_stat_dis.plain_title <> '');
 Liens_stat_plain_fname := count(group,Liens_stat_dis.plain_fname <> '');
 Liens_stat_plain_mname := count(group,Liens_stat_dis.plain_mname <> '');
 Liens_stat_plain_lname := count(group,Liens_stat_dis.plain_lname <> '');
 Liens_stat_plain_name_suffix := count(group,Liens_stat_dis.plain_name_suffix <> '');
 Liens_stat_plain_name_score := count(group,Liens_stat_dis.plain_name_score <> '');
 Liens_stat_plain_company := count(group,Liens_stat_dis.plain_company <> '');
 Liens_stat_prim_range := count(group,Liens_stat_dis.prim_range <> '');
 Liens_stat_predir := count(group,Liens_stat_dis.predir <> '');
 Liens_stat_prim_name := count(group,Liens_stat_dis.prim_name <> '');
 Liens_stat_suffix := count(group,Liens_stat_dis.suffix <> '');
 Liens_stat_postdir := count(group,Liens_stat_dis.postdir <> '');
 Liens_stat_unit_desig := count(group,Liens_stat_dis.unit_desig <> '');
 Liens_stat_sec_range := count(group,Liens_stat_dis.sec_range <> '');
 Liens_stat_p_city_name := count(group,Liens_stat_dis.p_city_name <> '');
 Liens_stat_v_city_name := count(group,Liens_stat_dis.v_city_name <> '');
 Liens_stat_state := count(group,Liens_stat_dis.state <> '');
 Liens_stat_zip := count(group,Liens_stat_dis.zip <> '');
 Liens_stat_zip4 := count(group,Liens_stat_dis.zip4 <> '');
 Liens_stat_cart := count(group,Liens_stat_dis.cart <> '');
 Liens_stat_cr_sort_sz := count(group,Liens_stat_dis.cr_sort_sz <> '');
 Liens_stat_lot := count(group,Liens_stat_dis.lot <> '');
 Liens_stat_lot_order := count(group,Liens_stat_dis.lot_order <> '');
 Liens_stat_dbpc := count(group,Liens_stat_dis.indivbusun <> '');
 Liens_stat_chk_digit := count(group,Liens_stat_dis.chk_digit <> '');
 Liens_stat_rec_type := count(group,Liens_stat_dis.rec_type <> '');
 Liens_stat_geo_lat := count(group,Liens_stat_dis.geo_lat <> '');
 Liens_stat_geo_long := count(group,Liens_stat_dis.geo_long <> '');
 Liens_stat_msa := count(group,Liens_stat_dis.msa <> '');
 Liens_stat_geo_blk := count(group,Liens_stat_dis.geo_blk <> '');
 Liens_stat_geo_match := count(group,Liens_stat_dis.geo_match <> '');
 Liens_stat_err_stat := count(group,Liens_stat_dis.err_stat <> '');
 Liens_stat_did := count(group,Liens_stat_dis.did <> '');
 Liens_stat_did_score := count(group,Liens_stat_dis.did_score <> '');
 Liens_stat_ssn_appended := count(group,Liens_stat_dis.ssn_appended <> '');
 Liens_stat_bdid := count(group,Liens_stat_dis.bdid <> '');
 Liens_stat_glb_flag := count(group,Liens_stat_dis.glb_flag <> ''); 
end;

Liens_stats := table(Liens_stat_dis,Liens_stat_rec,Liens_stat_dis.county,few);

Liens_perc_rec := record
 string7 stat1_courtid := '';
 string10 stat1_total := '';
 string8 stat1_Max_Filing_Date := '';
 string8 stat1_Min_Filing_Date := '';
 string10 stat1_indivbusun := '';
 string10 stat1_aka_yn:= '';
 string10 stat1_assoccode:= '';
 string10 stat1_court_desc := '';
 string10 stat1_filetypeid := '';
 string10 stat1_filingtype_desc := '';
 string10 stat1_casenumber := '';
 string10 stat1_book := '';
 string10 stat1_page := '';
 string10 stat1_filing_date := '';
 string10 stat1_release_date := '';
 string10 stat1_amount := '';
 string10 stat1_assets := '';
 string10 stat1_plaintiff := '';
 string10 stat1_othercase := '';
 string10 stat1_orig_ssn := '';
 string10 stat1_defname := '';
 string10 stat1_generation := '';
 string10 stat1_address := '';
 string10 stat1_orig_city := '';
 string10 stat1_orig_state := '';
 string10 stat1_orig_zip := '';
 string10 stat1_uploaddate := '';
 string10 stat1_unlawdetyn := '';
 string10 stat1_origcase := '';
 string10 stat1_origbook := '';
 string10 stat1_origpage := '';
 string10 stat1_actiontype := '';
 string10 stat1_stl_type := '';
 string10 stat1_rmsid := '';
 string10 stat1_def_title := '';
 string10 stat1_def_fname := '';
 string10 stat1_def_mname := '';
 string10 stat1_def_lname := '';
 string10 stat1_def_name_suffix := '';
 string10 stat1_def_name_score := '';
 string10 stat1_def_company := '';
 string10 stat1_plain_title := '';
 string10 stat1_plain_fname := '';
 string10 stat1_plain_mname := '';
 string10 stat1_plain_lname := '';
 string10 stat1_plain_name_suffix := '';
 string10 stat1_plain_name_score := '';
 string10 stat1_plain_company := '';
 string10 stat1_prim_range := '';
 string10 stat1_predir := '';
 string10 stat1_prim_name := '';
 string10 stat1_suffix := '';
 string10 stat1_postdir := '';
 string10 stat1_unit_desig := '';
 string10 stat1_sec_range := '';
 string10 stat1_p_city_name := '';
 string10 stat1_v_city_name := '';
 string10 stat1_state := '';
 string10 stat1_zip := '';
 string10 stat1_zip4 := '';
 string10 stat1_cart := '';
 string10 stat1_cr_sort_sz := '';
 string10 stat1_lot := '';
 string10 stat1_lot_order := '';
 string10 stat1_dbpc := '';
 string10 stat1_chk_digit := '';
 string10 stat1_rec_type := '';
 string10 stat1_county := '';		
 string10 stat1_geo_lat := '';
 string10 stat1_geo_long := '';
 string10 stat1_msa := '';
 string10 stat1_geo_blk := '';
 string10 stat1_geo_match := '';
 string10 stat1_err_stat := '';
 string10 stat1_did := '';
 string10 stat1_did_score := '';
 string10 stat1_ssn_appended := '';
 string10 stat1_bdid := '';
 string10 stat1_glb_flag := ''; 
 string2 crlf := '\r\n';
end;

Liens_perc_rec GetPerc(Liens_stats L) := TRANSFORM
 self.stat1_county := L.county;
 self.stat1_total := (string10)L.total;
 self.stat1_Max_Filing_Date := L.Max_filing_date;
 self.stat1_Min_Filing_Date := L.Min_filing_date;
self.stat1_indivbusun := (string10)((decimal5_2)((L.Liens_stat_indivbusun*100)/L.total));
self.stat1_courtid := (string10)((decimal5_2)((L.Liens_stat_courtid*100)/L.total));
self.stat1_aka_yn := (string10)((decimal5_2)((L.Liens_stat_aka_yn*100)/L.total));
self.stat1_assoccode := (string10)((decimal5_2)((L.Liens_stat_assoccode*100)/L.total));
self.stat1_court_desc := (string10)((decimal5_2)((L.Liens_stat_court_desc*100)/L.total));
self.stat1_filetypeid := (string10)((decimal5_2)((L.Liens_stat_filetypeid*100)/L.total));
self.stat1_filingtype_desc := (string10)((decimal5_2)((L.Liens_stat_filingtype_desc*100)/L.total));
self.stat1_casenumber := (string10)((decimal5_2)((L.Liens_stat_casenumber*100)/L.total));
self.stat1_book := (string10)((decimal5_2)((L.Liens_stat_book*100)/L.total));
self.stat1_page := (string10)((decimal5_2)((L.Liens_stat_page*100)/L.total));
self.stat1_release_date := (string10)((decimal5_2)((L.Liens_stat_release_date*100)/L.total));
self.stat1_amount := (string10)((decimal5_2)((L.Liens_stat_amount*100)/L.total));
self.stat1_assets := (string10)((decimal5_2)((L.Liens_stat_assets*100)/L.total));
self.stat1_plaintiff := (string10)((decimal5_2)((L.Liens_stat_plaintiff*100)/L.total));
self.stat1_othercase := (string10)((decimal5_2)((L.Liens_stat_othercase*100)/L.total));
self.stat1_orig_ssn := (string10)((decimal5_2)((L.Liens_stat_orig_ssn*100)/L.total));
self.stat1_defname := (string10)((decimal5_2)((L.Liens_stat_defname*100)/L.total));
self.stat1_generation := (string10)((decimal5_2)((L.Liens_stat_generation*100)/L.total));
self.stat1_address := (string10)((decimal5_2)((L.Liens_stat_address*100)/L.total));
self.stat1_orig_city := (string10)((decimal5_2)((L.Liens_stat_orig_city*100)/L.total));
self.stat1_orig_state := (string10)((decimal5_2)((L.Liens_stat_orig_state*100)/L.total));
self.stat1_orig_zip := (string10)((decimal5_2)((L.Liens_stat_orig_zip*100)/L.total));
self.stat1_uploaddate := (string10)((decimal5_2)((L.Liens_stat_uploaddate*100)/L.total));
self.stat1_unlawdetyn := (string10)((decimal5_2)((L.Liens_stat_unlawdetyn*100)/L.total));
self.stat1_origcase := (string10)((decimal5_2)((L.Liens_stat_origcase*100)/L.total));
self.stat1_origbook := (string10)((decimal5_2)((L.Liens_stat_origbook*100)/L.total));
self.stat1_origpage := (string10)((decimal5_2)((L.Liens_stat_origpage*100)/L.total));
self.stat1_actiontype := (string10)((decimal5_2)((L.Liens_stat_actiontype*100)/L.total));
self.stat1_stl_type := (string10)((decimal5_2)((L.Liens_stat_stl_type*100)/L.total));
self.stat1_rmsid := (string10)((decimal5_2)((L.Liens_stat_rmsid*100)/L.total));
self.stat1_def_title := (string10)((decimal5_2)((L.Liens_stat_def_title*100)/L.total));
self.stat1_def_fname := (string10)((decimal5_2)((L.Liens_stat_def_fname*100)/L.total));
self.stat1_def_mname := (string10)((decimal5_2)((L.Liens_stat_def_mname*100)/L.total));
self.stat1_def_lname := (string10)((decimal5_2)((L.Liens_stat_def_lname*100)/L.total));
self.stat1_def_name_suffix := (string10)((decimal5_2)((L.Liens_stat_def_name_suffix*100)/L.total));
self.stat1_def_name_score := (string10)((decimal5_2)((L.Liens_stat_def_name_score*100)/L.total));
self.stat1_def_company := (string10)((decimal5_2)((L.Liens_stat_def_company*100)/L.total));
self.stat1_plain_title := (string10)((decimal5_2)((L.Liens_stat_plain_title*100)/L.total));
self.stat1_plain_fname := (string10)((decimal5_2)((L.Liens_stat_plain_fname*100)/L.total));
self.stat1_plain_mname := (string10)((decimal5_2)((L.Liens_stat_plain_mname*100)/L.total));
self.stat1_plain_lname := (string10)((decimal5_2)((L.Liens_stat_plain_lname*100)/L.total));
self.stat1_plain_name_suffix := (string10)((decimal5_2)((L.Liens_stat_plain_name_suffix*100)/L.total));
self.stat1_plain_name_score := (string10)((decimal5_2)((L.Liens_stat_plain_name_score*100)/L.total));
self.stat1_plain_company := (string10)((decimal5_2)((L.Liens_stat_plain_company*100)/L.total));
self.stat1_prim_range := (string10)((decimal5_2)((L.Liens_stat_prim_range*100)/L.total));
self.stat1_predir := (string10)((decimal5_2)((L.Liens_stat_predir*100)/L.total));
self.stat1_prim_name := (string10)((decimal5_2)((L.Liens_stat_prim_name*100)/L.total));
self.stat1_suffix := (string10)((decimal5_2)((L.Liens_stat_suffix*100)/L.total));
self.stat1_postdir := (string10)((decimal5_2)((L.Liens_stat_postdir*100)/L.total));
self.stat1_unit_desig := (string10)((decimal5_2)((L.Liens_stat_unit_desig*100)/L.total));
self.stat1_sec_range := (string10)((decimal5_2)((L.Liens_stat_sec_range*100)/L.total));
self.stat1_p_city_name := (string10)((decimal5_2)((L.Liens_stat_p_city_name*100)/L.total));
self.stat1_v_city_name := (string10)((decimal5_2)((L.Liens_stat_v_city_name*100)/L.total));
self.stat1_state := (string10)((decimal5_2)((L.Liens_stat_state*100)/L.total));
self.stat1_zip := (string10)((decimal5_2)((L.Liens_stat_zip*100)/L.total));
self.stat1_zip4 := (string10)((decimal5_2)((L.Liens_stat_zip4*100)/L.total));
self.stat1_cart := (string10)((decimal5_2)((L.Liens_stat_cart*100)/L.total));
self.stat1_cr_sort_sz := (string10)((decimal5_2)((L.Liens_stat_cr_sort_sz*100)/L.total));
self.stat1_lot := (string10)((decimal5_2)((L.Liens_stat_lot*100)/L.total));
self.stat1_lot_order := (string10)((decimal5_2)((L.Liens_stat_lot_order*100)/L.total));
self.stat1_dbpc := (string10)((decimal5_2)((L.Liens_stat_dbpc*100)/L.total));
self.stat1_chk_digit := (string10)((decimal5_2)((L.Liens_stat_chk_digit*100)/L.total));
self.stat1_rec_type := (string10)((decimal5_2)((L.Liens_stat_rec_type*100)/L.total));
self.stat1_geo_lat := (string10)((decimal5_2)((L.Liens_stat_geo_lat*100)/L.total));
self.stat1_geo_long := (string10)((decimal5_2)((L.Liens_stat_geo_long*100)/L.total));
self.stat1_msa := (string10)((decimal5_2)((L.Liens_stat_msa*100)/L.total));
self.stat1_geo_blk := (string10)((decimal5_2)((L.Liens_stat_geo_blk*100)/L.total));
self.stat1_geo_match := (string10)((decimal5_2)((L.Liens_stat_geo_match*100)/L.total));
self.stat1_err_stat := (string10)((decimal5_2)((L.Liens_stat_err_stat*100)/L.total));
self.stat1_did := (string10)((decimal5_2)((L.Liens_stat_did*100)/L.total));
self.stat1_did_score := (string10)((decimal5_2)((L.Liens_stat_did_score*100)/L.total));
self.stat1_ssn_appended := (string10)((decimal5_2)((L.Liens_stat_ssn_appended*100)/L.total));
self.stat1_bdid := (string10)((decimal5_2)((L.Liens_stat_bdid*100)/L.total));
self.stat1_glb_flag := (string10)((decimal5_2)((L.Liens_stat_glb_flag*100)/L.total));
end;

Liens_perc_rec_proj := project(Liens_stats,GetPerc(LEFT));

Liens_stats_sort := sort(Liens_perc_rec_proj,stat1_courtid);

output(Liens_stats_sort(stat1_courtid <> '   SCHU' and stat1_courtid <> '  Signa' and (stat1_Max_Filing_Date <> '' or stat1_Min_Filing_Date <> '')),,'out::Liens_full_service_stats',overwrite);
*/

/*Liens_file_despray := lib_fileservices.fileservices.Despray('~thor_dell400_2::out::Liens_full_stats','192.168.0.39',
 									'/thor_back5/liens/stats/fullstats/Liens_stats.d00',,,,TRUE);*/

// Query to create a crosstab with counts by county name from the
// Fares_Foreclosure property file

//bankruptcy_service := DATASET(property.File_Fares_Foreclosure, property.Layout_Fares_Foreclosure, THOR);

County_Rec := RECORD
	string2 state;
	string3 fips_county_code;
	string10 min_filing_date;
END;

County_Rec GetCountyCodes(Liens_stat_dis L) := TRANSFORM
	SELF.state := L.state;
	SELF.fips_county_code := L.county;
	self.min_filing_date := l.filing_date;
END;
	
Layout_County_Stat := PROJECT(Liens_stat_dis,GetCountyCodes(LEFT));

// Crosstab to count occurrences of each unique county code
Layout_County_Code_Stat := RECORD
	Layout_County_Stat.fips_county_code;
	Layout_County_Stat.state;
	string10 m_filing_date := min(group, Layout_County_Stat.min_filing_date);
	reccnt := COUNT(GROUP);	
END;

County_Codes_Stat := TABLE(Layout_County_Stat, Layout_County_Code_Stat, state, fips_county_code, FEW);




// Join to County Code Name file to get names
Layout_County_Names := RECORD
	Layout_County_Code_Stat;
	string2 layout_state;
	STRING18 county_name;
END;

// Join to County Code Name file to get names
Layout_County_Names GetCountyNames(Layout_County_Code_Stat L, Property.Layout_County_Code_Names R) := TRANSFORM
	SELF.county_name := R.county_name;
	SELF.layout_state := R.state;
	SELF := L;
END;

Fares_Foreclosure_County_Names := JOIN(County_Codes_Stat,
                                 Property.File_County_Code_Names,
								 LEFT.state = RIGHT.state_fips AND
                                 (INTEGER)LEFT.fips_county_code = (INTEGER)RIGHT.fips_county_code,
                                 GetCountyNames(LEFT, RIGHT));
								 
OUTPUT(CHOOSEN(Fares_Foreclosure_County_Names,ALL));

