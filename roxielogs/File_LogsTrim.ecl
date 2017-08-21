
import ut;
export File_LogsTrim := 
MODULE

export foreign_super_file_name := ut.foreign_logs + 'thor_data400::base::logs::roxie';
export super_file_name := 'thor_data400::base::logs::roxie_log';

shared layout_raw := 
record
	string11 query_id; //int(11) in mysql
	string20 roxie_ip;
	string60 filepath;
	string10 position;
	string20 receivetime; //datetime in mysql
	string20 pid;
	string30 tid;
	string30 instance_id;
	string30 source_ip;
	string200 queryname;
	string10000 querytext; //longtext in mysql
	string2 isblind; //bit(1) in mysql
	string2 issoap; //bit(1) in mysql
	string20 finishtime; //datetime in mysql
	string11 secondstaken;
	string11 timetaken;
	string11 memory;
	string11 priority;
	string11 slavesreply;
	string11 resultsize;
	string11 continue1;
end;

// ***** WE ARE NOT ALLOWED TO USE THESE 'RAW' DATASETS ON DATALAND.  YOU MAY ONLY ACCESS 'RECORDS' BELOW.  EMAIL CHAD MORTON WITH PROBLEMS. *****
export ds_raw(string lfn) := 
dataset(
	lfn,
	layout_raw,
	CSV(
		SEPARATOR(['\t']),
		TERMINATOR(['|||']),
		QUOTE('\''),
		maxlength(500000)
	)
);

shared records_raw := ds_raw(foreign_super_file_name);


//THEN DO THE TRIMMING

export layout := 
record
	layout_raw - [source_ip];
end;

export dataset(layout) scrub(dataset(layout_raw) inf) :=
FUNCTION

	r0 := inf;
	roxielogs.mac_XML_Parser(r0, r1, _ClientIP, querytext, true)		//removes _ClientIP value from querytext
	roxielogs.mac_XML_Parser(r1, r2, _LoginId, querytext, true)			//removes _LoginId value from querytext
	roxielogs.mac_XML_Parser(r2, r3, _CompanyId, querytext, true)		//removes _CompanyId value from querytext

	nosrcip := project(r3, layout); //removes source_ip field

	dist := distribute(nosrcip, hash(random())) : independent; //better to dist after read from smaller thor.  independent here so that refresh doesnt lock up the filename too long.

	return dist;
	
END;

scrubbed := scrub(records_raw);

good := length(scrubbed.querytext) <> length(trim(scrubbed.querytext)); //this is temporary to filter out records where querytext is overflowing

export records_fresh := scrubbed(good); //you have the option of reading across the whole thing

export records := dataset('~' + super_file_name, layout, thor, __COMPRESSED__); //so we're not reading the whole file across every time.  gets updated nightly by roxielogs.BWR_ScheduleFileXFer1 and 2

roxielogs.mac_ParseAllFields(records, records_parsed0)
export records_parsed_fat := records_parsed0;

shared rec_parsed := record
	recordof(records_parsed_fat) - [querytext];
end;

export records_parsed := project(records_parsed_fat,rec_parsed);

END;