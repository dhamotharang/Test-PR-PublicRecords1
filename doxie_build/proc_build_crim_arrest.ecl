import crim, ut, doxie_files;
boolean daily_file := false : stored('daily');

input_files := crim.FL_as_Arrests;
		     //crim.PA_as_Arrests;

ut.MAC_SF_BuildProcess(input_files,'~thor_data400::base::CrimHist_Arrest_'+doxie_build.buildstate,executer,2);

//if daily file build key too.
out_daily := output(input_files,,'~thor_data400::base::CrimHist_Arrests_'+buildstate+thorlib.wuid(),overwrite);
add_daily := fileservices.addsuperfile('~thor_data400::base::CrimHist_Arrest_'+buildstate,'~thor_data400::base::CrimHist_Arrests_'+buildstate+thorlib.wuid());
key_daily := buildindex(doxie_files.Key_Crim_Arrest,'~thor_data400::key::CrimHist_Arrests_'+buildstate+thorlib.wuid());
add_key := fileservices.addsuperfile('~thor_data400::key::CrimHist_Arrests_'+buildstate,'~thor_data400::key::CrimHist_Arrests_'+buildstate+thorlib.wuid());

daily_stuff := sequential(out_daily,add_daily,key_daily,add_key);

export proc_build_crim_arrest := if(daily_file,daily_stuff,executer);