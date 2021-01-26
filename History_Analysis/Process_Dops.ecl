Import STD, _control, dops, History_Analysis, PromoteSupers, ut;

Export process_dops( string pVersion, string datasetname, string location, string cluster, string fromdate, string todate, string dopsenv ) := Module
 
// file from 2 year history 
KeysizedHistory := History_Analysis.Files(pVersion).keysizedhistory_report;

// datasetname = dataset name from dops
// location = 'B' for boca or 'A' for alpharetta or '' or '*'
// cluster = 'N' for nonfcra or 'F' for fcra or '' or '*' or 'S' - Customer Support or 'FS' - FCRA Customer Support or 'T' - Customer Test
// environment = 'Q' for qa or 'P' for prod; this variable represents data in prod or qa roxie
// start date of ten day range
// end date of ten day range
// dopsenv = 'dev' or 'prod'; dev - points to dev or prod DOPS DB
fcraData := dops.GetHistoricalKeyInfo(datasetname, location, 'F', fromdate, todate, dopsenv );

nonfcraData := dops.GetHistoricalKeyInfo(datasetname, location, 'N' , fromdate, todate, dopsenv );

Shared addBothInputs := (fcraData + nonfcraData );

//from 2018-02-14 15:25:13 to 2/20/2020 1:45:05 AM
fn_format_date (string date) := Function

	time:= date[12..19];
	hour := (unsigned4)date[12..13];
	formatted_hour := map(    
					hour = 24 => '12',
					hour = 23 => '11',
					hour = 22 => '10',
					hour = 21 => '9',
					hour = 20 => '8',
					hour = 19 => '7',
					hour = 18 => '6',
					hour = 17 => '5',
					hour = 16 => '4',
			        hour = 15 => '3', 
					hour = 14 => '2', 
					hour = 13 => '1', 
					hour < 13 => (string4) hour, '');
	AMPM := if( hour > 11, ' PM', ' AM');
	
	finalDate := date[6..7] + '/' + date[9..10]  + '/' + date[1..4] + ' ' + trim(formatted_hour) + ':' + date[15..16] + ':' + date[18..19] +  AMPM;

	filterFinal := if(date = 'NA', 'NA', finalDate);

	return filterFinal;
	
End;


Shared dops_service := project(addBothInputs, transform(History_Analysis.Layouts.layout_dopsservice,
								self.datasetname := trim(left.datasetname,right, whitespace );
								self.clusterflag := trim(left.clusterflag,right, whitespace );
							    self.whenqalive := trim(fn_format_date(left.whenqalive),right, whitespace );
								self.whenprodlive :=  trim(fn_format_date(left.whenprodlive),right, whitespace ); 
								self.buildversion := trim(left.buildversion, right, whitespace );
								self.superkey := trim(ut.fn_RemoveSpecialChars(left.superkey), right, whitespace );
								self.logicalkey := trim(ut.fn_RemoveSpecialChars(left.logicalkey), right, whitespace ); // templatelogicalkey for KeysizedHistory
								self.size := (integer)left.size;
                                self.recordcount := (integer)left.recordcount;
								self.updateflag := trim(left.updateflag,right, whitespace );
                                self.statuscode := trim(left.statuscode, right, whitespace ); // '' for KeysizedHistory
                                self.statusdescription := trim(left.statusdescription, right, whitespace );// '' for KeysizedHistory
                                ));

						

Export processed_dops := output(dops_service,,History_Analysis.Filenames(pVersion).DopsServiceData, csv(heading(single),separator(','),quote('"')), overwrite, __compressed__ );

old_data := History_Analysis.Files(pVersion).keysizedhistory_rawdata;

dd_dataset := (old_data + dops_service );

dedup_dataset := dedup(dd_dataset, datasetname, buildversion, whenqalive, whenprodlive, clusterflag, updateflag, superkey, logicalkey, size, recordcount, statuscode, statusdescription, all );

sorted_dataset := sort(dedup_dataset(datasetname<>''), datasetname, superkey, -buildversion, whenqalive, whenprodlive );

PromoteSupers.Mac_SF_BuildProcess(sorted_dataset,'~thor_data400::history_analysis::in::raw_data', build_AggregateFile, 3,true,true);

Export appendRawdata := ordered(processed_dops, build_AggregateFile );

End;