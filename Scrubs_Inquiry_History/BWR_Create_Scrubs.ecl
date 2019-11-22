
// create folder "Scrubs_<<module_name_and/or_dataset>>"
// Add a new BWR_Create_Scrubs attribute (copy code from another module/folder)
// Create "In_File"
// correct references below and comment everything besides gen_init_spec_file
// run gen_init_spec_file (W20160126-124253)
// create SPC file (salt attribute) and copy output of previous step to SPC. Make changes (eg folder name) and save
// Provided you have integrated SALT into the IDE - the additional modules will be created and added to the module
// create layout_file
// run the hygene (W20160126-131211)
// continue to uncomment the sequential at the end of this BWR and its dependent definitions
// create default field validation for scrubs (W20160126-131338)
// create orbit probile prior to submit the report (you can use the output of degault profile rules (W20160126-131838)
IMPORT SALT311;
#WORKUNIT('name','Scrubs_Inquiry_History');
#OPTION('multiplePersistInstances',FALSE);
// ********************************************************************************************
// Configuration																		<-- STEP 0 (setup only)
IMPORT Scrubs_Inquiry_History as S;
F := Scrubs_Inquiry_History.In_File: independent;		// input file
o := 'Scrubs_Inquiry_AccLogs_Update';		// orbit profile
v := '20160321a';									// orbit report version (for submission)
// ********************************************************************************************
// Generates default specification file            	<-- STEP 1 (setup only)
SALT311.MAC_Default_SPC(F, output_spc); 

gen_init_spec_file := output(choosen(output_spc,500));
// ********************************************************************************************
// Hygiene reports																	<-- STEP 2
// h := S.hygiene(F);											
// m := h.Summary('SummaryReport');
// zz_gmarcan.MAC_TransposeDS_1Row(m,_m);
// p := h.allprofiles;
// gen_hyg_report := sequential(
	// OUTPUT(_m,NAMED('SummaryReport'),ALL),  // Generate population profile for all fields
	// OUTPUT(p,NAMED('AllProfiles')  ,ALL)); // Generate detailed profile of every field	
// ********************************************************************************************
// Genrates basic/intial fieldtypes for each field	<-- STEP 3 (setup only)
// gen_init_field_type := output(SALT32.MAC_Character_counts.fieldtypes(p, 99.9), named('Types'));
// ********************************************************************************************
// Create the scrubs stats													<-- STEP 4 (Will create up-to-date scrub)
// N := S.Scrubs.FromNone(F); // Generate the error flags
// B := N.BitmapInfile;
//output(B,,'~thor_data::scrubs_equifax_bits_test', overwrite, compressed);
//output(S.Scrubs.FromBits(B));
// U := S.Scrubs.FromExpanded(N.ExpandedInFile); // Pass the expanded error flags into the Expanded module
// disp_scrubs_report := sequential(
	// output(U.SummaryStats,							named('ErrorSummary')),      // Show errors by field and type
	// output(choosen(U.AllErrors, 1000),	named('EyeballSomeErrors')), // Just eyeball some errors
	// output(choosen(U.BadValues, 1000),	named('SomeErrorValues')));  // See my error field values
// ********************************************************************************************
// Create the scrubs orbit report										<-- STEP 5 (Will create up-to-date orbit report)
// orbitStats := U.OrbitStats() : persist('~persist::_scrubs_rpt::'+o+'::'+v);;
// disp_orbit_report := output(orbitStats,all,named('OrbitReport'));
// ********************************************************************************************
// Generate a CSV to upload the rule sets to Orbit 	<-- STEP 6 (setup only)
// Create the orbit prfolile and upload the rules
// In creating the profile, generate 'scrubs' layout (see documentation)
// gen_init_orbit_rules := Scrubs.OrbitProfileStats(,,orbitStats).ProfileAlertsTemplate;
// ********************************************************************************************
//Submits stats to Orbit														<-- STEP 7 (submit up-to-date report)
// submitStats:=Scrubs.OrbitProfileStats(o,'ScrubsAlerts',orbitStats,v,o).SubmitStats;
// ********************************************************************************************
SEQUENTIAL(
						  gen_init_spec_file,    // once-off
						  // gen_hyg_report,				// takes a bit of time - but good for analysis // full field profile commented out
						  // gen_init_field_type,   // once-off
				      // disp_scrubs_report,		// output - but good for debug
						  // disp_orbit_report,		 	// optional
						  // gen_init_orbit_rules,  // once-off / or for updates
				      // submitStats,
						  // STD.System.Log.addWorkunitInformation('DONE!')
);

// CHEAT SHEET FOR SETTING UP ORBIT PROFILE:
// Download default rules result as xls
// Open in excel remove file position column
// Remove HPCC heading row
// Left append an empty 'id' column. 
// Save as csv
// Open in text editor and remove "
// ---
// On Orbit, go to another profie and export "output file layout" to csv
// Blank out the content of the 'id' column (leave the heading), and change profile name to match your new profile name
// Import the layout (you will get a failure message, but the layout will load). If not, try setting ids to '0'.
// Import rules (you will see errors, but the rules will be loaded)