IMPORT _Control, corrections, data_services, Doxie_files, hygenics_crim, STD, Hygenics_SOff, hygenics_search, Data_Services, doxie_build, doxie, SexOffender, DOPS, SALT311; 

Export Salt_Report_Criminal(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)Std.Date.Today()) := function

//Define sources
//Criminal Offenders 
NonFCRA_CrimOffender	:= Hygenics_crim.File_Moxie_Crim_Offender2_Dev;	
FCRA_CrimOffender := Doxie_files.key_Offenders(true);					

//Criminal Court Offenses
NONFCRA_Court_Offense := Hygenics_crim.File_Moxie_Court_Offenses_Dev;           //doxie_files.Key_Court_Offenses();
FCRA_Court_Offense := doxie_files.Key_Court_Offenses(TRUE);

//DOC offenses
NONFCRA_DOC_Offense := Hygenics_crim.File_Moxie_DOC_Offenses_Dev;               //doxie_files.Key_Offenses();	
FCRA_DOC_Offense := doxie_files.Key_Offenses(TRUE);	

//SexOffender
NONFCRA_SOF_offender := Hygenics_SOff.File_Main;   	
FCRA_SOF_offender := SexOffender.Key_SexOffender_SPK(TRUE);

//Sex Offenses
NONFCRA_SOF_offenses := SexOffender.key_sexoffender_offenses(); 
FCRA_SOF_offenses := SexOffender.key_sexoffender_offenses(TRUE); 

//get version, work unit, report date 
CrimKeyCertVersion := dops.GetBuildVersion('DOCKeys','B','N','C'); // Boca , NonFCRA , Cert
CrimSubName := NOTHOR(STD.File.GetSuperFileSubName('~thor_data400::base::corrections_offenders_public', 1));
CrimCertWorkUnit := std.str.touppercase(CrimSubName[50..65]);
//p_date will be replaced by version and work unit number in cert
p_date := MAX(NonFCRA_CrimOffender,NonFCRA_CrimOffender.process_date);

//SOF
SOFKeyCertVersion := dops.GetBuildVersion('SexOffenderKeys','B','N','C'); // Boca , NonFCRA , Cert
SOFSubName := NOTHOR(STD.File.GetSuperFileSubName('~thor_data400::base::sex_offender_mainpublic', 1));
SOFCertWorkUnit := std.str.touppercase(SOFSubName[45..65]);
p_date_sof := MAX(NONFCRA_SOF_offender,NONFCRA_SOF_offender.dt_first_reported);

//date
filedate := today;

//Create Vendor Tables
crim_tbl_rec := record
	 NonFCRA_CrimOffender.data_type;
	 string data_type_desc := '';
	 NonFCRA_CrimOffender.vendor;
	 NonFCRA_CrimOffender.source_file;
	 string	vendor_desc := '';
	 NonFCRA_CrimOffender.src_upload_date;
	 String8 ReportDate := '';
	 String8 build_version := '';
	 String16 build_wu := '';
	 NonFCRA_CrimOffender.orig_state; 
	 string datafile := '';
	 integer vend_length := 0; 
end;

//Create NonFCRA Criminal Data Vendor File
crim_tbl_rec xadd_file(NonFCRA_CrimOffender le) := TRANSFORM
	self.data_type_desc := MAP(le.data_type = '1' => 'DOC', 
														 le.data_type = '2' => 'Crim Court', 
														 le.data_type = '5' => 'Arrest Log',
														 ''); 
//self.vendor_desc := hygenics_crim._functions.fn_vendorcode_sourcename(le.vendor, le.src_upload_date);
	self.vendor_desc := if(trim(hygenics_crim._functions.fn_vendorcode_sourcename(le.vendor, le.src_upload_date), left, right)<>'',
												 trim(hygenics_crim._functions.fn_vendorcode_sourcename(le.vendor, le.src_upload_date), left, right),
												 trim(le.source_file, left, right));
	                       trim_vendor := trim(le.vendor,left,right);
	self.vend_length := length(trim_vendor);
	self.datafile := MAP(le.src_upload_date IN ['','        '] => 'Direct',
											 self.vend_length=5 and le.vendor[1]='W' => 'CrimWise',
											 self.vend_length=5 and le.vendor[1]='I' => 'InnovEnt',
										   'CrimData');
											 
	self.ReportDate := filedate;		
	self.build_version := CrimKeyCertVersion;
	self.build_wu := CrimCertWorkUnit;
	self := le;
end;

//Create FCRA Criminal Data Vendor File
crim_tbl_rec xadd_filef(fcra_CrimOffender le) := TRANSFORM
	self.data_type_desc := MAP(le.data_type = '1' => 'DOC', 
														 le.data_type = '2' => 'Crim Court', 
														 le.data_type = '5' => 'Arrest Log',
														 ''); 
//self.vendor_desc := hygenics_crim._functions.fn_vendorcode_sourcename(le.vendor,le.src_upload_date);
	self.vendor_desc := if(trim(hygenics_crim._functions.fn_vendorcode_sourcename(le.vendor, le.src_upload_date), left, right)<>'',
												 trim(hygenics_crim._functions.fn_vendorcode_sourcename(le.vendor, le.src_upload_date), left, right),
												 trim(le.source_file, left, right));
	trim_vendor := trim(le.vendor,left,right);
	self.vend_length := length(trim_vendor);
	self.datafile := MAP(le.src_upload_date IN ['','        '] => 'Direct',
											 self.vend_length=5 and le.vendor[1]='W' => 'CrimWise',
											 self.vend_length=5 and le.vendor[1]='I' => 'InnovEnt',
										   'CrimData');
	self.ReportDate := (STRING8)Std.Date.Today();
	self.build_version := CrimKeyCertVersion;
	self.build_wu := CrimCertWorkUnit;
	self := le;
end;

prj_crim_off  := project(NonFCRA_CrimOffender, xadd_file(left)) : INDEPENDENT;
prj_crim_fcra := project(FCRA_CrimOffender, xadd_filef(left)) : INDEPENDENT;

crim_tbl_max_date_rec_prelim := record
	 prj_crim_off.vendor;
	 prj_crim_off.source_file;
	 prj_crim_off.vendor_desc; 
	 prj_crim_off.data_type;
	 prj_crim_off.data_type_desc;
	 prj_crim_off.ReportDate;
	 prj_crim_off.build_version;
	 prj_crim_off.build_wu ;
	 prj_crim_off.orig_state; 
	 prj_crim_off.datafile;
	 prj_crim_off.vend_length;
	 prj_crim_off.src_upload_date;
	 cnt := count(group); 
end;

NonFCRA_Crim_Vendor_tbl_prelim := Table(prj_crim_off, crim_tbl_max_date_rec_prelim, vendor, source_file, vendor_desc, data_type, data_type_desc, ReportDate, p_date, orig_state, datafile, vend_length, src_upload_date, few );


crim_tbl_max_date_rec_prelim_fcra := record
	 prj_crim_fcra.vendor;
	 prj_crim_fcra.source_file;
	 prj_crim_fcra.vendor_desc; 
	 prj_crim_fcra.data_type;
	 prj_crim_fcra.data_type_desc;
	 prj_crim_fcra.ReportDate;
	 prj_crim_fcra.build_version;
	 prj_crim_fcra.build_wu;
	 prj_crim_fcra.orig_state; 
	 prj_crim_fcra.datafile;
	 prj_crim_fcra.vend_length;
	 prj_crim_fcra.src_upload_date;
	 cnt := count(group); 
end;

FCRA_Crim_Vendor_tbl_prelim := Table(prj_crim_fcra, crim_tbl_max_date_rec_prelim_fcra, vendor, source_file, vendor_desc, data_type, data_type_desc, ReportDate, p_date, orig_state, datafile, vend_length, src_upload_date, few );

crim_tbl_max_date_rec_final := record
	 NonFCRA_Crim_Vendor_tbl_prelim.vendor;
	 NonFCRA_Crim_Vendor_tbl_prelim.source_file;
	 NonFCRA_Crim_Vendor_tbl_prelim.vendor_desc;
	 NonFCRA_Crim_Vendor_tbl_prelim.data_type;
	 NonFCRA_Crim_Vendor_tbl_prelim.data_type_desc;
	 NonFCRA_Crim_Vendor_tbl_prelim.ReportDate;
	 NonFCRA_Crim_Vendor_tbl_prelim.build_version;
	 NonFCRA_Crim_Vendor_tbl_prelim.build_wu;	 
	 NonFCRA_Crim_Vendor_tbl_prelim.orig_state; 
	 NonFCRA_Crim_Vendor_tbl_prelim.datafile;
	 NonFCRA_Crim_Vendor_tbl_prelim.vend_length;
 
	 src_upload_date := MAX(group,NonFCRA_Crim_Vendor_tbl_prelim.src_upload_date);
	 recs := Sum(group, NonFCRA_Crim_Vendor_tbl_prelim.cnt); 
	 CountGroup := count(group);
end;

NonFCRA_Crim_Vendor_tbl := Table(NonFCRA_Crim_Vendor_tbl_prelim, crim_tbl_max_date_rec_final, vendor, source_file, vendor_desc, data_type, data_type_desc, ReportDate, p_date, orig_state, datafile, vend_length, few );


crim_tbl_max_date_rec_final_fcra := record
	 FCRA_Crim_Vendor_tbl_prelim.vendor;
	 FCRA_Crim_Vendor_tbl_prelim.source_file;
	 FCRA_Crim_Vendor_tbl_prelim.vendor_desc;
	 FCRA_Crim_Vendor_tbl_prelim.data_type;
	 FCRA_Crim_Vendor_tbl_prelim.data_type_desc;
	 FCRA_Crim_Vendor_tbl_prelim.ReportDate;
	 FCRA_Crim_Vendor_tbl_prelim.build_version;
 	 FCRA_Crim_Vendor_tbl_prelim.build_wu;
	 FCRA_Crim_Vendor_tbl_prelim.orig_state; 
	 FCRA_Crim_Vendor_tbl_prelim.datafile;
	 FCRA_Crim_Vendor_tbl_prelim.vend_length;
	 
	 src_upload_date := MAX(group,FCRA_Crim_Vendor_tbl_prelim.src_upload_date);
	 recs := Sum(group, FCRA_Crim_Vendor_tbl_prelim.cnt); 
	 CountGroup := count(group);
end;


FCRA_Crim_Vendor_tbl := Table(FCRA_Crim_Vendor_tbl_prelim, crim_tbl_max_date_rec_final_fcra, vendor, source_file, vendor_desc, data_type, data_type_desc, ReportDate, p_date, orig_state, datafile, vend_length, few );

OUTPUT( NonFCRA_Crim_Vendor_tbl, NAMED('NonFCRA_Crim_Vendor_tbl'),ALL );
OUTPUT( FCRA_Crim_Vendor_tbl, NAMED('FCRA_Crim_Vendor_tbl'),ALL );

//Create Logical Thor File and Despray Actions for each Output file

//NonFCRA_Crim_Vendor_tbl
output_logical_file_NonFCRA_Crim_Vendor_tbl := output(NonFCRA_Crim_Vendor_tbl,,
					'~thor_data400::data_insight::data_metrics::salt::NonFCRA_Crim_Vendor_tbl_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_NonFCRA_Crim_Vendor_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::NonFCRA_Crim_Vendor_tbl_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_NonFCRA_Crim_Vendor_tbl_'+ filedate +'.csv'
																					,,,,true);

//FCRA_Crim_Vendor_tbl
output_logical_file_FCRA_Crim_Vendor_tbl := output(FCRA_Crim_Vendor_tbl,,
					'~thor_data400::data_insight::data_metrics::salt::FCRA_Crim_Vendor_tbl_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_FCRA_Crim_Vendor_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::FCRA_Crim_Vendor_tbl_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_FCRA_Crim_Vendor_tbl_'+ filedate +'.csv'
																					,,,,true);



//NONFCRA Sex Offender Vendor Table
soff_tbl_rec := record
	 NonFCRA_SOF_offender.orig_state_code;
	 NonFCRA_SOF_offender.orig_state;
	 NonFCRA_SOF_offender.source_file;
	 String8 build_version := '';
	 String16 build_wu := '';
	 String8 ReportDate := '';
	 string datafile := '';
end;

//define CrimWise SOF Files
set_CrimWise_files := 
   ['CO_BUREAU_OF_INVESTI',
   'CO_SOTAR_SOR',
   'AL_COUSHATTA_TRIBES_',
   'CHEYENNE_RIVER_SIOUX',
   'ESTRN_BAND_OF_CHEROK',
   'KAIBAB_PAIUTE_TRIBE_',
   'LUMMI_NATION_SOR',
   'MUSCOGEE_CREEK_NATIO',
   'PUEBLO_OF_SANTO_DOMI',
   'UTE_INDIAN_TRIBE_SOR',
   'YANKTON_SIOUX_TRIBE_'];

soff_tbl_rec tNSoff(NonFCRA_SOF_offender le) := TRANSFORM
	 self.datafile := IF(le.source_file IN set_CrimWise_files, 'CrimWise', 'CrimData');																				
	 Self.ReportDate := filedate;
	 Self.build_version := SOFKeyCertVersion;
	 Self.build_wu := SOFCertWorkUnit;		
	 Self := le;	 
end;

prj_nonf_soff := project(NonFCRA_SOF_offender, tNSoff(left));

//FCRA Sex Offender Vendor Table
fcra_soff_tbl_rec := record
	 FCRA_SOF_offender.orig_state_code;
	 FCRA_SOF_offender.orig_state;
	 FCRA_SOF_offender.source_file;
	 String8 build_version := '';
	 String16 build_wu := '';
	 String8 ReportDate := '';
	 string datafile := '';
end;

fcra_soff_tbl_rec tNSoff_FCRA(FCRA_SOF_offender le) := TRANSFORM
	 self.datafile := IF(le.source_file IN set_CrimWise_files, 'CrimWise', 'CrimData');																																						
	 Self.ReportDate := filedate;
	 Self.build_version := SOFKeyCertVersion;
	 Self.build_wu := SOFCertWorkUnit;																																									
	 Self := le;	 
end;

prj_fcra_soff := project(FCRA_SOF_offender, tNSoff_FCRA(left));

soff_src_tbl := table(prj_nonf_soff, {orig_state_code, orig_state, source_file, p_date, ReportDate, datafile, cnt:=count(group)}, orig_state_code, orig_state, source_file, p_date, ReportDate, datafile, few);
fcra_soff_src_tbl := table(prj_fcra_soff, {orig_state_code, orig_state, source_file, p_date, ReportDate, datafile, cnt:=count(group)}, orig_state_code, orig_state, source_file, p_date, ReportDate, datafile, few);

output(sort(soff_src_tbl, orig_state_code), all, named('NonFCRASexOffender_Vendor_Table'));
output(sort(fcra_soff_src_tbl, orig_state_code), all, named('FCRASexOffender_Vendor_Table'));

//NonFCRASexOffender_Vendor_Table
output_logical_file_NonFCRASexOffender_Vendor_Table := output(sort(soff_src_tbl, orig_state_code),,
					'~thor_data400::data_insight::data_metrics::salt::NonFCRASexOffender_Vendor_Table_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_NonFCRASexOffender_Vendor_Table := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::NonFCRASexOffender_Vendor_Table_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_NonFCRASexOffender_Vendor_Table_'+ filedate +'.csv'
																					,,,,true);

//FCRASexOffender_Vendor_Table
output_logical_file_FCRASexOffender_Vendor_Table := output(sort(fcra_soff_src_tbl, orig_state_code),,
					'~thor_data400::data_insight::data_metrics::salt::FCRASexOffender_Vendor_Table_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_FCRASexOffender_Vendor_Table := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::FCRASexOffender_Vendor_Table_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_FCRASexOffender_Vendor_Table_'+ filedate +'.csv'
																					,,,,true);

//inverted summary NonFCRA_CrimOffender
NonFCRA_CrimOffender_mod := SALT311.MOD_Profile(NonFCRA_CrimOffender, out_prefix := 'NonFCRA_CrimOffender');

invSummary_NonFCRA_CrimOffender := 
  PROJECT(
    NonFCRA_CrimOffender_mod.invSummary,
    TRANSFORM( { RECORDOF(NonFCRA_CrimOffender_mod.invSummary), STRING8 ReportDate, String8 build_version, String16 build_wu },
      SELF.ReportDate := (STRING8)Std.Date.Today(),
	    Self.build_version := CrimKeyCertVersion,
	    Self.build_wu := CrimCertWorkUnit,
      SELF := LEFT
    )
  );

OUTPUT( invSummary_NonFCRA_CrimOffender, NAMED('NonFCRA_CrimOffender'),ALL );

//NonFCRA_CrimOffender invSummary output file and despray actions
output_logical_file_NonFCRA_CrimOffender := output(invSummary_NonFCRA_CrimOffender,,
					'~thor_data400::data_insight::data_metrics::salt::NonFCRA_CrimOffender_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_NonFCRA_CrimOffender := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::NonFCRA_CrimOffender_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_NonFCRA_CrimOffender_'+ filedate +'.csv'
																					,,,,true);

//inverted summary NonFCRA_CrimOffender grouped by vendor  //SALT311.MAC_Profile(ds_file,,vendor,0,,0)

NonFCRA_CrimOffender_mod_grouped := SALT311.MOD_Profile(NonFCRA_CrimOffender, , vendor, out_prefix := 'NonFCRA_CrimOffender_grouped');

//add source stats from vendor table
rec_join_sum := record
	RECORDOF(NonFCRA_CrimOffender_mod_grouped.invSummary);
  RECORDOF(NonFCRA_Crim_Vendor_tbl) AND NOT [vend_length, recs, countgroup]; 
end;	
	
rec_join_sum xjoin(NonFCRA_CrimOffender_mod_grouped.invSummary le, NonFCRA_Crim_Vendor_tbl ri) := TRANSFORM
	self := le;
	self := ri;
end;

invSummary_NonFCRA_CrimOffender_grouped := join(NonFCRA_CrimOffender_mod_grouped.invSummary, NonFCRA_Crim_Vendor_tbl, 
								left.vendor = right.vendor  
								, xjoin(left,right));

OUTPUT( invSummary_NonFCRA_CrimOffender_grouped,NAMED('NonFCRA_CrimOffender_grouped'));

//invSummary_NonFCRA_CrimOffender_grouped output file and despray actions
output_logical_file_NonFCRA_CrimOffender_grouped := output(invSummary_NonFCRA_CrimOffender_grouped,,
					'~thor_data400::data_insight::data_metrics::salt::NonFCRA_CrimOffender_grouped_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_NonFCRA_CrimOffender_grouped := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::NonFCRA_CrimOffender_grouped_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_NonFCRA_CrimOffender_grouped_'+ filedate +'.csv'
																					,,,,true);

//inverted summary FCRA_CrimOffender
FCRA_CrimOffender_mod := SALT311.MOD_Profile(FCRA_CrimOffender, out_prefix := 'FCRA_CrimOffender');

invSummary_FCRA_CrimOffender := 
  PROJECT(
    FCRA_CrimOffender_mod.invSummary,
    TRANSFORM( { RECORDOF(FCRA_CrimOffender_mod.invSummary), STRING8 ReportDate, String8 build_version, String16 build_wu },
      SELF.ReportDate := (STRING8)Std.Date.Today(),
	    Self.build_version := CrimKeyCertVersion,
	    Self.build_wu := CrimCertWorkUnit,
      SELF := LEFT
    )
  );

OUTPUT( invSummary_FCRA_CrimOffender, NAMED('FCRA_CrimOffender'),ALL );

//invSummary_FCRA_CrimOffender output file and despray actions
output_logical_file_invSummary_FCRA_CrimOffender := output(invSummary_FCRA_CrimOffender,,
					'~thor_data400::data_insight::data_metrics::salt::invSummary_FCRA_CrimOffender_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_invSummary_FCRA_CrimOffender := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::invSummary_FCRA_CrimOffender_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_invSummary_FCRA_CrimOffender_'+ filedate +'.csv'
																					,,,,true);

//inverted summary FCRA_CrimOffender grouped by vendor
FCRA_CrimOffender_mod_grouped := SALT311.MOD_Profile(FCRA_CrimOffender, , vendor, out_prefix := 'FCRA_CrimOffender_grouped');

//add source stats from vendor table
rec_join_sum xjoin_fcra(FCRA_CrimOffender_mod_grouped.invSummary le, FCRA_Crim_Vendor_tbl ri) := TRANSFORM
	self := le;
	self := ri;
end;

invSummary_FCRA_CrimOffender_grouped := join(FCRA_CrimOffender_mod_grouped.invSummary, FCRA_Crim_Vendor_tbl, 
								left.vendor = right.vendor  
								, xjoin_fcra(left,right));

OUTPUT( invSummary_FCRA_CrimOffender_grouped, NAMED('FCRA_CrimOffender_grouped') );

//invSummary_FCRA_CrimOffender_grouped output file and despray actions
output_logical_file_invSummary_FCRA_CrimOffender_grouped := output(invSummary_FCRA_CrimOffender_grouped,,
					'~thor_data400::data_insight::data_metrics::salt::invSummary_FCRA_CrimOffender_grouped_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_invSummary_FCRA_CrimOffender_grouped := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::invSummary_FCRA_CrimOffender_grouped_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_invSummary_FCRA_CrimOffender_grouped_'+ filedate +'.csv'
																					,,,,true);

//inverted summary NONFCRA_Court_Offense
invSummary_court_offenses := SALT311.MOD_Profile(NONFCRA_Court_Offense, out_prefix := 'NONFCRA_Court_Offenses');

NONFCRA_Court_Offense_inv_sum := 
  PROJECT(
    invSummary_court_offenses.invSummary,
    TRANSFORM( { RECORDOF(invSummary_court_offenses.invSummary), STRING8 ReportDate, String8 build_version, String16 build_wu },
      SELF.ReportDate := (STRING8)Std.Date.Today(),
	    Self.build_version := CrimKeyCertVersion,
	    Self.build_wu := CrimCertWorkUnit,
      SELF := LEFT
    )
  );

OUTPUT( NONFCRA_Court_Offense_inv_sum, NAMED('NONFCRA_Court_Offenses') );

//NONFCRA_Court_Offense_inv_sum output file and despray actions
output_logical_file_NONFCRA_Court_Offenses := output(NONFCRA_Court_Offense_inv_sum,,
					'~thor_data400::data_insight::data_metrics::salt::NONFCRA_Court_Offenses_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_NONFCRA_Court_Offenses := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::NONFCRA_Court_Offenses_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_NONFCRA_Court_Offenses_'+ filedate +'.csv'
																					,,,,true);


//inverted summary NONFCRA_Court_Offense grouped by vendor
NonFCRA_Court_Offense_mod_grouped := SALT311.MOD_Profile(NONFCRA_Court_Offense, , vendor, out_prefix := 'NONFCRA_Court_Offense_grouped');

//add source stats from vendor table
rec_join_offense := record
	RECORDOF(NonFCRA_Court_Offense_mod_grouped.invSummary);
  RECORDOF(NonFCRA_Crim_Vendor_tbl) AND NOT [vend_length, recs, countgroup]; 
end;	
	

rec_join_offense xjoin_offense(NonFCRA_Court_Offense_mod_grouped.invSummary le, NonFCRA_Crim_Vendor_tbl ri) := TRANSFORM
	self := le;
	self := ri;
end;

invSummary_NonFCRA_Court_Offense_grouped := join(NonFCRA_Court_Offense_mod_grouped.invSummary, NonFCRA_Crim_Vendor_tbl, 
								left.vendor = right.vendor  
								, xjoin_offense(left,right));

OUTPUT( invSummary_NonFCRA_Court_Offense_grouped, NAMED('NonFCRA_Court_Offense_grouped') );

//invSummary_NonFCRA_Court_Offense_grouped output file and despray actions
output_logical_file_NonFCRA_Court_Offense_grouped := output(invSummary_NonFCRA_Court_Offense_grouped,,
					'~thor_data400::data_insight::data_metrics::salt::NonFCRA_Court_Offense_grouped_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_invSummary_NonFCRA_Court_Offense_grouped := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::NonFCRA_Court_Offense_grouped_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_NonFCRA_Court_Offense_grouped_'+ filedate +'.csv'
																					,,,,true);

//inverted summary FCRA_Court_Offense 
invSummary_court_offenses_fcra := SALT311.MOD_Profile(FCRA_Court_Offense, out_prefix := 'FCRA_Court_Offenses');

FCRA_Court_Offense_inv_sum := 
  PROJECT(
    invSummary_court_offenses_fcra.invSummary,
    TRANSFORM( { RECORDOF(invSummary_court_offenses_fcra.invSummary), STRING8 ReportDate, String8 build_version, String16 build_wu },
      SELF.ReportDate := (STRING8)Std.Date.Today(),
	    Self.build_version := CrimKeyCertVersion,
	    Self.build_wu := CrimCertWorkUnit,
      SELF := LEFT
    )
  );

OUTPUT( FCRA_Court_Offense_inv_sum, NAMED('FCRA_Court_Offenses') );

//FCRA_Court_Offense_inv_sum output file and despray actions
output_logical_file_FCRA_Court_Offenses := output(FCRA_Court_Offense_inv_sum,,
					'~thor_data400::data_insight::data_metrics::salt::FCRA_Court_Offenses_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_invSummary_FCRA_Court_Offenses := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::FCRA_Court_Offenses_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_FCRA_Court_Offenses_'+ filedate +'.csv'
																					,,,,true);


//inverted summary FCRA_Court_Offense grouped by vendor
FCRA_Court_Offense_mod_grouped := SALT311.MOD_Profile(FCRA_Court_Offense, , vendor, out_prefix := 'FCRA_Court_Offense_grouped');

rec_join_offense xjoin_offense_fcra(FCRA_Court_Offense_mod_grouped.invSummary le, FCRA_Crim_Vendor_tbl ri) := TRANSFORM
	self := le;
	self := ri;
end;

invSummary_FCRA_Court_Offense_grouped := join(FCRA_Court_Offense_mod_grouped.invSummary, FCRA_Crim_Vendor_tbl, 
								left.vendor = right.vendor  
								, xjoin_offense_fcra(left,right));

OUTPUT( invSummary_FCRA_Court_Offense_grouped, NAMED('FCRA_Court_Offense_grouped') );

//FCRA_Court_Offense_inv_sum output file and despray actions
output_logical_file_FCRA_Court_Offense_grouped := output(invSummary_FCRA_Court_Offense_grouped,,
					'~thor_data400::data_insight::data_metrics::salt::FCRA_Court_Offense_grouped_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_invSummary_FCRA_Court_Offense_grouped := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::FCRA_Court_Offense_grouped_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_FCRA_Court_Offenses_'+ filedate +'.csv'
																					,,,,true);


//inverted summary NONFCRA DOC offenses 
invSummary_DOC_offenses := SALT311.MOD_Profile(NONFCRA_DOC_Offense, out_prefix := 'NONFCRA_DOC_Offenses');

NONFCRA_DOC_Offense_inv_sum := 
  PROJECT(
    invSummary_DOC_offenses.invSummary,
    TRANSFORM( { RECORDOF(invSummary_DOC_offenses.invSummary), STRING8 ReportDate, String8 build_version, String16 build_wu },
      SELF.ReportDate := (STRING8)Std.Date.Today(),
	    Self.build_version := CrimKeyCertVersion,
	    Self.build_wu := CrimCertWorkUnit,
      SELF := LEFT
    )
  );

OUTPUT( NONFCRA_DOC_Offense_inv_sum, NAMED('NONFCRA_DOC_Offenses') );

//NONFCRA_DOC_Offense_inv_sum output file and despray actions
output_logical_file_NONFCRA_DOC_Offenses := output(NONFCRA_DOC_Offense_inv_sum,,
					'~thor_data400::data_insight::data_metrics::salt::NONFCRA_DOC_Offenses_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_NONFCRA_DOC_Offenses := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::NONFCRA_DOC_Offenses_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_NONFCRA_DOC_Offenses_'+ filedate +'.csv'
																					,,,,true);


//inverted summary NONFCRA_DOC_Offense grouped by vendor
NonFCRA_DOC_Offense_mod_grouped := SALT311.MOD_Profile(NONFCRA_DOC_Offense, , vendor, out_prefix := 'NONFCRA_DOC_Offense_grouped');

rec_join_offense xjoin_doc_offense(NonFCRA_DOC_Offense_mod_grouped.invSummary le, NonFCRA_Crim_Vendor_tbl ri) := TRANSFORM
	self := le;
	self := ri;
end;

invSummary_NonFCRA_DOC_Offense_grouped := join(FCRA_Court_Offense_mod_grouped.invSummary, NonFCRA_Crim_Vendor_tbl, 
								left.vendor = right.vendor  
								, xjoin_doc_offense(left,right));

OUTPUT( invSummary_NonFCRA_DOC_Offense_grouped, NAMED('NonFCRA_DOC_Offense_grouped') );

//NONFCRA_DOC_Offense_inv_sum output file and despray actions
output_logical_file_NonFCRA_DOC_Offense_grouped := output(invSummary_NonFCRA_DOC_Offense_grouped,,
					'~thor_data400::data_insight::data_metrics::salt::NonFCRA_DOC_Offense_grouped_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_invSummary_NonFCRA_DOC_Offense_grouped := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::NonFCRA_DOC_Offense_grouped_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_NonFCRA_DOC_Offense_grouped_'+ filedate +'.csv'
																					,,,,true);

//FCRA_DOC_Offense 
invSummary_DOC_offenses_fcra := SALT311.MOD_Profile(FCRA_DOC_Offense, out_prefix := 'FCRA_DOC_Offenses');

FCRA_DOC_Offense_inv_sum := 
  PROJECT(
    invSummary_DOC_offenses_fcra.invSummary,
    TRANSFORM( { RECORDOF(invSummary_DOC_offenses_fcra.invSummary), STRING8 ReportDate, String8 build_version, String16 build_wu },
      SELF.ReportDate := (STRING8)Std.Date.Today(),
	    Self.build_version := CrimKeyCertVersion,
	    Self.build_wu := CrimCertWorkUnit,
      SELF := LEFT
    )
  );

OUTPUT( FCRA_DOC_Offense_inv_sum, NAMED('FCRA_DOC_Offenses') );

//FCRA_DOC_Offense_inv_sum output file and despray actions
output_logical_file_FCRA_DOC_Offenses := output(FCRA_DOC_Offense_inv_sum,,
					'~thor_data400::data_insight::data_metrics::salt::FCRA_DOC_Offenses_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_FCRA_DOC_Offenses := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::FCRA_DOC_Offenses_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_FCRA_DOC_Offenses_'+ filedate +'.csv'
																					,,,,true);


//inverted summary FCRA_DOC_Offense grouped by vendor
FCRA_DOC_Offense_mod_grouped := SALT311.MOD_Profile(FCRA_DOC_Offense, , vendor, out_prefix := 'FCRA_DOC_Offense_grouped');

rec_join_offense xjoin_doc_offense_fcra(FCRA_DOC_Offense_mod_grouped.invSummary le, FCRA_Crim_Vendor_tbl ri) := TRANSFORM
	self := le;
	self := ri;
end;

invSummary_FCRA_DOC_Offense_grouped := join(FCRA_DOC_Offense_mod_grouped.invSummary, FCRA_Crim_Vendor_tbl, 
								left.vendor = right.vendor  
								, xjoin_doc_offense_fcra(left,right));

OUTPUT( invSummary_FCRA_DOC_Offense_grouped, NAMED('FCRA_DOC_Offense_grouped') );

//invSummary_FCRA_DOC_Offense_grouped output file and despray actions
output_logical_file_FCRA_DOC_Offense_grouped := output(invSummary_FCRA_DOC_Offense_grouped,,
					'~thor_data400::data_insight::data_metrics::salt::FCRA_DOC_Offense_grouped_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_invSummary_FCRA_DOC_Offense_grouped := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::FCRA_DOC_Offense_grouped_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_FCRA_DOC_Offense_grouped_'+ filedate +'.csv'
																					,,,,true);


//NONFCRA_SOF_offender 
NONFCRA_SOF_offender_mod := SALT311.MOD_Profile(NONFCRA_SOF_offender, out_prefix := 'NONFCRA_SOF_offender');

invSummary_NONFCRA_SOF_offender := 
  PROJECT(
    NONFCRA_SOF_offender_mod.invSummary,
    TRANSFORM( { RECORDOF(NONFCRA_SOF_offender_mod.invSummary), STRING8 ReportDate, String8 build_version, String16 build_wu },
      SELF.ReportDate := (STRING8)Std.Date.Today(),
	    Self.build_version := SOFKeyCertVersion,
	    Self.build_wu := SOFCertWorkUnit,
      SELF := LEFT
    )
  );

OUTPUT( invSummary_NONFCRA_SOF_offender, NAMED('NONFCRA_SOF_offender') );

//invSummary_NONFCRA_SOF_offender output file and despray actions
output_logical_file_NONFCRA_SOF_offender := output(invSummary_NONFCRA_SOF_offender,,
					'~thor_data400::data_insight::data_metrics::salt::NONFCRA_SOF_offender_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_invSummary_NONFCRA_SOF_offender := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::NONFCRA_SOF_offender_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_NONFCRA_SOF_offender_'+ filedate +'.csv'
																					,,,,true);

//inverted summary NONFCRA_SOF_offender grouped by vendor
NONFCRA_SOF_offender_mod_grouped := SALT311.MOD_Profile(NONFCRA_SOF_offender, , source_file, out_prefix := 'NONFCRA_SOF_offender_grouped');

//add source stats from vendor table
rec_join_sof := record
	RECORDOF(NONFCRA_SOF_offender_mod_grouped.invSummary);
  RECORDOF(soff_src_tbl) AND NOT [cnt]; 
end;	
	

rec_join_sof xjoin_sof(NONFCRA_SOF_offender_mod_grouped.invSummary le, soff_src_tbl ri) := TRANSFORM
	self := le;
	self := ri;
end;

invSummary_NonFCRA_SOF_Offender_grouped := join(NONFCRA_SOF_offender_mod_grouped.invSummary, soff_src_tbl, 
								left.source_file = right.source_file  
								, xjoin_sof(left,right));

OUTPUT( invSummary_NonFCRA_SOF_Offender_grouped, NAMED('NonFCRA_SOF_Offender_grouped') );

//invSummary_NonFCRA_SOF_Offender_grouped output file and despray actions
output_logical_file_NonFCRA_SOF_Offender_grouped := output(invSummary_NonFCRA_SOF_Offender_grouped,,
					'~thor_data400::data_insight::data_metrics::salt::NonFCRA_SOF_Offender_grouped_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_invSummary_NonFCRA_SOF_Offender_grouped := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::NonFCRA_SOF_Offender_grouped_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_NonFCRA_SOF_Offender_grouped_'+ filedate +'.csv'
																					,,,,true);


//FCRA_SOF_offender 
FCRA_SOF_offender_mod := SALT311.MOD_Profile(FCRA_SOF_offender, out_prefix := 'FCRA_SOF_offender');

invSummary_FCRA_SOF_offender := 
  PROJECT(
    FCRA_SOF_offender_mod.invSummary,
    TRANSFORM( { RECORDOF(FCRA_SOF_offender_mod.invSummary), STRING8 ReportDate, String8 build_version, String16 build_wu },
      SELF.ReportDate := (STRING8)Std.Date.Today(),
	    Self.build_version := SOFKeyCertVersion,
	    Self.build_wu := SOFCertWorkUnit,
      SELF := LEFT
    )
  );

OUTPUT( invSummary_FCRA_SOF_offender, NAMED('FCRA_SOF_offender') );

//invSummary_FCRA_SOF_offender output file and despray actions
output_logical_file_FCRA_SOF_offender := output(invSummary_FCRA_SOF_offender,,
					'~thor_data400::data_insight::data_metrics::salt::FCRA_SOF_offender_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_invSummary_FCRA_SOF_offender := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::FCRA_SOF_offender_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_FCRA_SOF_offender_'+ filedate +'.csv'
																					,,,,true);

//inverted summary FCRA_SOF_offender grouped by vendor
FCRA_SOF_offender_mod_grouped := SALT311.MOD_Profile(FCRA_SOF_offender, , source_file, out_prefix := 'FCRA_SOF_offender_grouped');

rec_join_sof xjoin_sof_fcra(FCRA_SOF_offender_mod_grouped.invSummary le, fcra_soff_src_tbl ri) := TRANSFORM
	self := le;
	self := ri;
end;

invSummary_FCRA_SOF_Offender_grouped := join(FCRA_SOF_offender_mod_grouped.invSummary, fcra_soff_src_tbl, 
								left.source_file = right.source_file  
								, xjoin_sof_fcra(left,right));

OUTPUT( invSummary_FCRA_SOF_offender_grouped, NAMED('FCRA_SOF_offender_grouped') );

//invSummary_FCRA_SOF_offender_grouped output file and despray actions
output_logical_file_FCRA_SOF_offender_grouped := output(invSummary_FCRA_SOF_offender_grouped,,
					'~thor_data400::data_insight::data_metrics::salt::FCRA_SOF_offender_grouped_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_invSummary_FCRA_SOF_offender_grouped := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::FCRA_SOF_offender_grouped_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_FCRA_SOF_offender_grouped_'+ filedate +'.csv'
																					,,,,true);

//NONFCRA_SOF_offenses 
invSummary_SOF_offenses := SALT311.MOD_Profile(NONFCRA_SOF_offenses, out_prefix := 'NONFCRA_SOF_offenses');

NONFCRA_SOF_Offense_inv_sum := 
  PROJECT(
    invSummary_SOF_offenses.invSummary,
    TRANSFORM( { RECORDOF(invSummary_SOF_offenses.invSummary), STRING8 ReportDate, String8 build_version, String16 build_wu },
      SELF.ReportDate := (STRING8)Std.Date.Today(),
	    Self.build_version := SOFKeyCertVersion,
	    Self.build_wu := SOFCertWorkUnit,
      SELF := LEFT
    )
  );

OUTPUT( NONFCRA_SOF_Offense_inv_sum, NAMED('NONFCRA_SOF_offenses') );

//NONFCRA_SOF_Offense_inv_sum output file and despray actions
output_logical_file_NONFCRA_SOF_Offense_inv_sum := output(NONFCRA_SOF_Offense_inv_sum,,
					'~thor_data400::data_insight::data_metrics::salt::NONFCRA_SOF_offenses_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_NONFCRA_SOF_Offense_inv_sum := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::NONFCRA_SOF_offenses_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_NONFCRA_SOF_offenses_'+ filedate +'.csv'
																					,,,,true);

//inverted summary NONFCRA_SOF_offences grouped by vendor
//SOF offenses do not have the source file field, so we need to get it by joining to SOF offender first

rec_sof_source_offender_file := record
		NONFCRA_SOF_offender.seisint_primary_key;
		NONFCRA_SOF_offender.source_file;
		Cnt := COUNT(GROUP);
end;

SOF_Offender_slim_tbl := Table(NONFCRA_SOF_offender, rec_sof_source_offender_file, seisint_primary_key, source_file, many);
//output(count(slim_tbl));  //828,308

//add source data to sof offenses 
rec_sof_offenses_with_source_file := record
	RECORDOF(NONFCRA_SOF_offenses);
  RECORDOF(SOF_Offender_slim_tbl) AND NOT [Cnt]; 
end;	

//get the joined file
rec_sof_offenses_with_source_file xjoin_sof_offenses_with_source(NONFCRA_SOF_offenses le, SOF_Offender_slim_tbl ri) := TRANSFORM
	self := le;
	self := ri;
end;

NonFCRA_SOF_Offenses_with_source_file := join(NONFCRA_SOF_offenses, SOF_Offender_slim_tbl, 
								left.seisint_primary_key = right.seisint_primary_key  
								, xjoin_sof_offenses_with_source(left,right));

NONFCRA_SOF_offenses_mod_grouped := SALT311.MOD_Profile(NonFCRA_SOF_Offenses_with_source_file, , source_file, out_prefix := 'NONFCRA_SOF_offenses_grouped');

//add source stats from vendor table
rec_join_sof_offense := record
	RECORDOF(NONFCRA_SOF_offenses_mod_grouped.invSummary);
  RECORDOF(soff_src_tbl) AND NOT [cnt]; 
end;	
	
rec_join_sof_offense xjoin_sof_offenses(NONFCRA_SOF_offenses_mod_grouped.invSummary le, soff_src_tbl ri) := TRANSFORM
	self := le;
	self := ri;
end;

invSummary_NonFCRA_SOF_Offenses_grouped := join(NONFCRA_SOF_offenses_mod_grouped.invSummary, soff_src_tbl, 
								left.source_file = right.source_file  
								, xjoin_sof_offenses(left,right));

OUTPUT( invSummary_NonFCRA_SOF_Offenses_grouped, NAMED('NonFCRA_SOF_Offenses_grouped') );

//invSummary_NonFCRA_SOF_Offenses_grouped output file and despray actions
output_logical_file_NonFCRA_SOF_Offenses_grouped := output(invSummary_NonFCRA_SOF_Offenses_grouped,,
					'~thor_data400::data_insight::data_metrics::salt::NonFCRA_SOF_Offenses_grouped_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_invSummary_NonFCRA_SOF_Offenses_grouped := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::NonFCRA_SOF_Offenses_grouped_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_NonFCRA_SOF_Offenses_grouped_'+ filedate +'.csv'
																					,,,,true);


//FCRA_SOF_offenses 
invSummary_SOF_offenses_fcra := SALT311.MOD_Profile(FCRA_SOF_offenses, out_prefix := 'FCRA_SOF_offenses');

FCRA_SOF_Offenses_inv_sum := 
  PROJECT(
    invSummary_SOF_offenses_fcra.invSummary,
    TRANSFORM( { RECORDOF(invSummary_SOF_offenses_fcra.invSummary), STRING8 ReportDate, String8 build_version, String16 build_wu },
      SELF.ReportDate := (STRING8)Std.Date.Today(),
	    Self.build_version := SOFKeyCertVersion,
	    Self.build_wu := SOFCertWorkUnit,
      SELF := LEFT
    )
  );

OUTPUT( FCRA_SOF_Offenses_inv_sum, NAMED('FCRA_SOF_offenses') );

//FCRA_SOF_Offenses_inv_sum output file and despray actions
output_logical_file_FCRA_SOF_offenses := output(FCRA_SOF_Offenses_inv_sum,,
					'~thor_data400::data_insight::data_metrics::salt::FCRA_SOF_offenses_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_FCRA_SOF_Offenses_inv_sum := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::FCRA_SOF_offenses_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_FCRA_SOF_offenses_'+ filedate +'.csv'
																					,,,,true);

//FCRA SOF Offenses grouped by source file
//need to get source file by joining to offender file first

rec_sof_source_offender_file_fcra := record
	FCRA_SOF_offender.seisint_primary_key;
	FCRA_SOF_offender.source_file;
	Cnt := COUNT(GROUP);
end;

FCRA_SOF_Offender_slim_tbl := Table(FCRA_SOF_offender, rec_sof_source_offender_file_fcra, seisint_primary_key, source_file, many);

//add source data to fcra sof offenses 
rec_sof_offenses_with_source_file_fcra := record
	RECORDOF(FCRA_SOF_offenses);
  RECORDOF(FCRA_SOF_Offender_slim_tbl) AND NOT [Cnt]; 
end;	

rec_sof_offenses_with_source_file_fcra xjoin_sof_offenses_with_source_fcra(FCRA_SOF_offenses le, FCRA_SOF_Offender_slim_tbl ri) := TRANSFORM
	self := le;
	self := ri;
end;

FCRA_SOF_Offenses_with_source_file := join(FCRA_SOF_offenses, FCRA_SOF_Offender_slim_tbl, 
								left.seisint_primary_key = right.seisint_primary_key  
								, xjoin_sof_offenses_with_source_fcra(left,right));
//choosen(FCRA_SOF_Offenses_with_source_file, 100);  

FCRA_SOF_offenses_mod_grouped := SALT311.MOD_Profile(FCRA_SOF_Offenses_with_source_file, , source_file, out_prefix := 'FCRA_SOF_offenses_grouped');
	
rec_join_sof_offense xjoin_sof_offenses_fcra(FCRA_SOF_offenses_mod_grouped.invSummary le, fcra_soff_src_tbl ri) := TRANSFORM
	self := le;
	self := ri;
end;

invSummary_FCRA_SOF_Offenses_grouped := join(FCRA_SOF_offenses_mod_grouped.invSummary, fcra_soff_src_tbl, 
								left.source_file = right.source_file  
								, xjoin_sof_offenses_fcra(left,right));

OUTPUT( invSummary_FCRA_SOF_Offenses_grouped, NAMED('FCRA_SOF_Offenses_grouped') );

//invSummary_FCRA_SOF_Offenses_grouped output file and despray actions
output_logical_file_FCRA_SOF_Offenses_grouped := output(invSummary_FCRA_SOF_Offenses_grouped,,
					'~thor_data400::data_insight::data_metrics::salt::FCRA_SOF_Offenses_grouped_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_invSummary_FCRA_SOF_Offenses_grouped := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::FCRA_SOF_Offenses_grouped_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_FCRA_SOF_Offenses_grouped_'+ filedate +'.csv'
																					,,,,true);

Output(dops.GetReleaseHistory('B','N','DOCKeys'),named('DOPS_Crim'));

//dops ReleaseHistory output file and despray actions
output_logical_file_DOPS_Crim := output(dops.GetReleaseHistory('B','N','DOCKeys'),,
					'~thor_data400::data_insight::data_metrics::salt::DOPS_Crim_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_DOPS_Crim := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::DOPS_Crim_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_DOPS_Crim_'+ filedate +'.csv'
																					,,,,true);

Output(dops.GetReleaseHistory('B','N','SexOffenderKeys'),named('DOPS_SexOffenders'));

//DOPS_SexOffenders output file and despray actions
output_logical_file_DOPS_SexOffenders := output(dops.GetReleaseHistory('B','N','SexOffenderKeys'),,
					'~thor_data400::data_insight::data_metrics::salt::DOPS_SexOffenders_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_DOPS_SexOffenders := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::DOPS_SexOffenders_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_DOPS_SexOffenders_'+ filedate +'.csv'
																					,,,,true);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// We have a function macro that generages All Profiles Salt as a flat file, for example: fnmac_All_Profiles_Flat(NonFCRA_CrimOffender);
//Create Logical Thor File and Despray Actions for each Output file

//NonFCRA_CrimOffender_AllProfiles
output_logical_file_NonFCRA_CrimOffender_AllProfiles := output(fnmac_All_Profiles_Flat(NonFCRA_CrimOffender),,
					'~thor_data400::data_insight::data_metrics::salt::NonFCRA_CrimOffender_AllProfiles_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_NonFCRA_CrimOffender_AllProfiles := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::NonFCRA_CrimOffender_AllProfiles_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_NonFCRA_CrimOffender_AllProfiles_'+ filedate +'.csv'
																					,,,,true);

//FCRA_CrimOffender_AllProfiles
output_logical_file_FCRA_CrimOffender_AllProfiles := output(fnmac_All_Profiles_Flat(FCRA_CrimOffender),,
					'~thor_data400::data_insight::data_metrics::salt::FCRA_CrimOffender_AllProfiles_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_FCRA_CrimOffender_AllProfiles := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::FCRA_CrimOffender_AllProfiles_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_FCRA_CrimOffender_AllProfiles_'+ filedate +'.csv'
																					,,,,true);


//NONFCRA_Court_Offense
output_logical_file_NONFCRA_Court_Offense_AllProfiles := output(fnmac_All_Profiles_Flat(NONFCRA_Court_Offense),,
					'~thor_data400::data_insight::data_metrics::salt::NONFCRA_Court_Offense_AllProfiles_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_NONFCRA_Court_Offense_AllProfiles := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::NONFCRA_Court_Offense_AllProfiles_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_NONFCRA_Court_Offense_AllProfiles_'+ filedate +'.csv'
																					,,,,true);


//FCRA_Court_Offense
output_logical_file_FCRA_Court_Offense_AllProfiles := output(fnmac_All_Profiles_Flat(FCRA_Court_Offense),,
					'~thor_data400::data_insight::data_metrics::salt::FCRA_Court_Offense_AllProfiles_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_FCRA_Court_Offense_AllProfiles := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::FCRA_Court_Offense_AllProfiles_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_FCRA_Court_Offense_AllProfiles_'+ filedate +'.csv'
																					,,,,true);


//NONFCRA_DOC_Offense
output_logical_file_NONFCRA_DOC_Offense_AllProfiles := output(fnmac_All_Profiles_Flat(NONFCRA_DOC_Offense),,
					'~thor_data400::data_insight::data_metrics::salt::NONFCRA_DOC_Offense_AllProfiles_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_NONFCRA_DOC_Offense_AllProfiles := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::NONFCRA_DOC_Offense_AllProfiles_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_NONFCRA_DOC_Offense_AllProfiles_'+ filedate +'.csv'
																					,,,,true);

//FCRA_DOC_Offense
output_logical_file_FCRA_DOC_Offense_AllProfiles := output(fnmac_All_Profiles_Flat(FCRA_DOC_Offense),,
					'~thor_data400::data_insight::data_metrics::salt::FCRA_DOC_Offense_AllProfiles_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_FCRA_DOC_Offense_AllProfiles := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::FCRA_DOC_Offense_AllProfiles_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_FCRA_DOC_Offense_AllProfiles_'+ filedate +'.csv'
																					,,,,true);

//NONFCRA_SOF_offender
output_logical_file_NONFCRA_SOF_offender_AllProfiles := output(fnmac_All_Profiles_Flat(NONFCRA_SOF_offender),,
					'~thor_data400::data_insight::data_metrics::salt::NONFCRA_SOF_offender_AllProfiles_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_NONFCRA_SOF_offender_AllProfiles := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::NONFCRA_SOF_offender_AllProfiles_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_NONFCRA_SOF_offender_AllProfiles_'+ filedate +'.csv'
																					,,,,true);
																					
//FCRA_SOF_offender
output_logical_file_FCRA_SOF_offender_AllProfiles := output(fnmac_All_Profiles_Flat(FCRA_SOF_offender),,
					'~thor_data400::data_insight::data_metrics::salt::FCRA_SOF_offender_AllProfiles_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_FCRA_SOF_offender_AllProfiles := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::FCRA_SOF_offender_AllProfiles_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_FCRA_SOF_offender_AllProfiles_'+ filedate +'.csv'
																					,,,,true);																					
																					
//NONFCRA_SOF_offenses
output_logical_file_NONFCRA_SOF_offenses_AllProfiles := output(fnmac_All_Profiles_Flat(NONFCRA_SOF_offenses),,
					'~thor_data400::data_insight::data_metrics::salt::NONFCRA_SOF_offenses_AllProfiles_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_NONFCRA_SOF_offenses_AllProfiles := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::NONFCRA_SOF_offenses_AllProfiles_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_NONFCRA_SOF_offenses_AllProfiles_'+ filedate +'.csv'
																					,,,,true);	

//FCRA_SOF_offenses
output_logical_file_FCRA_SOF_offenses_AllProfiles := output(fnmac_All_Profiles_Flat(FCRA_SOF_offenses),,
					'~thor_data400::data_insight::data_metrics::salt::FCRA_SOF_offenses_AllProfiles_'+ filedate +'.csv', 
					csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


despray_FCRA_SOF_offenses_AllProfiles := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::salt::FCRA_SOF_offenses_AllProfiles_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/SALT_FCRA_SOF_offenses_AllProfiles_'+ filedate +'.csv'
																					,,,,true);	

// SEQUENTIAL Output actions to create logical files and despray them
email_alert := SEQUENTIAL(
					
          //vendor tables
					output_logical_file_NonFCRA_Crim_Vendor_tbl,
					despray_NonFCRA_Crim_Vendor_tbl,
					output_logical_file_NonFCRASexOffender_Vendor_Table,
					despray_NonFCRASexOffender_Vendor_Table,
					output_logical_file_FCRASexOffender_Vendor_Table,
					despray_FCRASexOffender_Vendor_Table,

					//inverted summaries
					output_logical_file_NonFCRA_CrimOffender,
					despray_NonFCRA_CrimOffender,
					output_logical_file_NonFCRA_CrimOffender_grouped,
					despray_NonFCRA_CrimOffender_grouped,
					output_logical_file_invSummary_FCRA_CrimOffender,
					despray_invSummary_FCRA_CrimOffender,
					output_logical_file_invSummary_FCRA_CrimOffender_grouped,
					despray_invSummary_FCRA_CrimOffender_grouped,
					output_logical_file_NONFCRA_Court_Offenses,
					despray_NONFCRA_Court_Offenses,
					output_logical_file_NonFCRA_Court_Offense_grouped,
					despray_invSummary_NonFCRA_Court_Offense_grouped,
					output_logical_file_FCRA_Court_Offenses,
					despray_invSummary_FCRA_Court_Offenses,
					output_logical_file_FCRA_Court_Offense_grouped,
					despray_invSummary_FCRA_Court_Offense_grouped,
					output_logical_file_NONFCRA_DOC_Offenses,
			  	despray_NONFCRA_DOC_Offenses,
					output_logical_file_NonFCRA_DOC_Offense_grouped,
					despray_invSummary_NonFCRA_DOC_Offense_grouped,
					output_logical_file_FCRA_DOC_Offenses,
				  despray_FCRA_DOC_Offenses,
					output_logical_file_FCRA_DOC_Offense_grouped,
					despray_invSummary_FCRA_DOC_Offense_grouped,

					//SOF
					output_logical_file_NONFCRA_SOF_offender,
					despray_invSummary_NONFCRA_SOF_offender,
					output_logical_file_NonFCRA_SOF_Offender_grouped,
					despray_invSummary_NonFCRA_SOF_Offender_grouped,
					output_logical_file_FCRA_SOF_offender,
					despray_invSummary_FCRA_SOF_offender,
					output_logical_file_FCRA_SOF_offender_grouped,
					despray_invSummary_FCRA_SOF_offender_grouped,
					output_logical_file_NONFCRA_SOF_Offense_inv_sum,
					despray_NONFCRA_SOF_Offense_inv_sum,
					output_logical_file_NonFCRA_SOF_Offenses_grouped,
					despray_invSummary_NonFCRA_SOF_Offenses_grouped,
					output_logical_file_FCRA_SOF_offenses,
					despray_FCRA_SOF_Offenses_inv_sum,
					output_logical_file_FCRA_SOF_Offenses_grouped,
					despray_invSummary_FCRA_SOF_Offenses_grouped,

					//DOPS
					output_logical_file_DOPS_Crim,
					despray_DOPS_Crim,
					output_logical_file_DOPS_SexOffenders,
					despray_DOPS_SexOffenders,					
					
					//All Profiles Flat
					output_logical_file_NonFCRA_CrimOffender_AllProfiles, 
					despray_NonFCRA_CrimOffender_AllProfiles,
					output_logical_file_FCRA_CrimOffender_AllProfiles, 
					despray_FCRA_CrimOffender_AllProfiles, 
					output_logical_file_NONFCRA_Court_Offense_AllProfiles,
					despray_NONFCRA_Court_Offense_AllProfiles, 
					output_logical_file_FCRA_Court_Offense_AllProfiles,
					despray_FCRA_Court_Offense_AllProfiles, 
					output_logical_file_NONFCRA_DOC_Offense_AllProfiles,
					despray_NONFCRA_DOC_Offense_AllProfiles, 
					output_logical_file_FCRA_DOC_Offense_AllProfiles, 
					despray_FCRA_DOC_Offense_AllProfiles,
					output_logical_file_NONFCRA_SOF_offender_AllProfiles,
					despray_NONFCRA_SOF_offender_AllProfiles,
					output_logical_file_FCRA_SOF_offender_AllProfiles,
					despray_FCRA_SOF_offender_AllProfiles,
					output_logical_file_NONFCRA_SOF_offenses_AllProfiles,
					despray_NONFCRA_SOF_offenses_AllProfiles,
					output_logical_file_FCRA_SOF_offenses_AllProfiles,
					despray_FCRA_SOF_offenses_AllProfiles	
					):
					Success(FileServices.SendEmail(pContact, 'SALT Reports Group: SALT_Reports_Criminal Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'SALT Reports Group: SALT_Reports_Criminal Build Failed', workunit + filedate + '\n' + FAILMESSAGE));

return email_alert;

end;


//W20210311-215826







//output only - but cannot be passed to a transform, use mod_off.invSummary instead
//mod_off.out_invSummary;
//mod.out_AllProfiles;


