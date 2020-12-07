Import STD, _control, dops, History_Analysis, PromoteSupers;

Export process_dops( string pVersion, string datasetname, string location, string cluster, string enviroment, string start_date, string end_date, string dopsenv ) := Module
 
// file from 2 year history 

KeysizedHistory := History_Analysis.Files(pversion).keysizedhistory_report;

//layouts
layout := History_Analysis.Layouts.layout_dopsservice;


// datasetname = dataset name from dops
// location = 'B' for boca or 'A' for alpharetta or '' or '*'
// cluster = 'N' for nonfcra or 'F' for fcra or '' or '*' or 'S' - Customer Support or 'FS' - FCRA Customer Support or 'T' - Customer Test
// environment = 'Q' for qa or 'P' for prod; this variable represents data in prod or qa roxie
// start date of ten day range
// end date of ten day range
// dopsenv = 'dev' or 'prod'; dev - points to dev or prod DOPS DB
fcraData := dops.GetHistoricalKeyInfo(datasetname, location, 'N',enviroment , start_date, end_date, dopsenv );

nonfcraData := dops.GetHistoricalKeyInfo(datasetname, location, 'F',enviroment , start_date, end_date, dopsenv );

addBothInputs := (fcraData + nonfcraData );

//from 2018-02-14 15:25:13 to 2/20/2020 1:45:05 AM
fn_format_date (string date) := Function

	time:= date[12..19];
	hour := (unsigned4)date[12..13];
	formatted_hour := map(    
					hour = 24 => '12',
					hour = 23 => '11',
					hour = 22 => '10',
					hour = 21 => '09',
					hour = 20 => '08',
					hour = 19 => '07',
					hour = 18 => '06',
					hour = 17 => '05',
					hour = 16 => '04',
			        hour = 15 => '03', 
					hour = 14 => '02', 
					hour = 13 => '01', 
					hour < 13 => (string4) hour, '');
	AMPM := if( hour > 11, ' PM', ' AM');
	
	return date[6..7] + '/' + date[9..10]  + '/' + date[1..4] + ' ' + trim(formatted_hour) + ':' + date[15..16] + ':' + date[18..19] +  AMPM;
End;


Shared dops_service := project(addBothInputs, transform(layout,
								self.datasetname := left.datasetname;
								self.clusterflag := left.clusterflag;
							    self.whenlive := left.whenlive;  // use fn_format_date(left.whenlive); for KeysizedHistory
								self.buildversion := left.buildversion;
								self.superkey := left.superkey;
								self.logicalkey := left.logicalkey; // templatelogicalkey for KeysizedHistory
								self.size := (integer)left.size;
                                self.recordcount := (integer)left.recordcount;
								self.updateflag := left.updateflag;
                                self.statuscode := left.statuscode;  // '' for KeysizedHistory
                                self.statusdescription := left.statusdescription; // '' for KeysizedHistory
                                ));


Export processed_dops := output(dops_service,,History_Analysis.Filenames(pversion).dopsServiceData, named('dopsnewest_servicedata'), thor, overwrite, __compressed__);

old_data := History_Analysis.Files(pversion).keysizedhistory_rawdata;

dd_dataset := old_data + dops_service;

dedup_dataset := dedup(dd_dataset, datasetname, buildversion, whenlive, clusterflag, updateflag, superkey, logicalkey, size, recordcount, statuscode, statusdescription, all );

sorted_dataset := sort(dedup_dataset(datasetname<>''), datasetname, superkey, whenlive );

PromoteSupers.Mac_SF_BuildProcess(sorted_dataset,'~thor_data400::history_analysis::in::raw_data', build_AggregateFile, 3,,true);

Export appendRawdata := ordered(processed_dops, build_AggregateFile );

End;