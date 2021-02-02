// IMPORT ADV3_0 as ADV;
IMPORT Data_Services;

EXPORT MOD_PersonHeader_Key := MODULE
	SHARED KeyName 			:= 'PersonHeaderKeys';
	SHARED Environment	:= 'Q';
	SHARED LocationName	:= 'B';
	SHARED ClusterName	:= 'N';
	SHARED Layout := RECORD
		unsigned6 s_did;
		unsigned6 did;
		unsigned6 rid;
		string1 pflag1;
		string1 pflag2;
		string1 pflag3;
		string2 src;
		unsigned3 dt_first_seen;
		unsigned3 dt_last_seen;
		unsigned3 dt_vendor_last_reported;
		unsigned3 dt_vendor_first_reported;
		unsigned3 dt_nonglb_last_seen;
		string1 rec_type;
		qstring18 vendor_id;
		qstring10 phone;
		qstring9 ssn;
		integer4 dob;
		qstring5 title;
		qstring20 fname;
		qstring20 mname;
		qstring20 lname;
		qstring5 name_suffix;
		qstring10 prim_range;
		string2 predir;
		qstring28 prim_name;
		qstring4 suffix;
		string2 postdir;
		qstring10 unit_desig;
		qstring8 sec_range;
		qstring25 city_name;
		string2 st;
		qstring5 zip;
		qstring4 zip4;
		string3 county;
		qstring7 geo_blk;
		qstring5 cbsa;
		string1 tnt;
		string1 valid_ssn;
		string1 jflag1;
		string1 jflag2;
		string1 jflag3;
		unsigned8 rawaid;
		unsigned8 persistent_record_id;
		// unsigned4 global_sid;
		// unsigned8 record_sid;
		string1 valid_dob;
		unsigned6 hhid;
		string18 county_name;
		string120 listed_name;
		string10 listed_phone;
		unsigned4 dod;
		string1 death_code;
		unsigned4 lookup_did;
	END;


	EXPORT BuildVersion := zz_kreddy.MOD_GetCurrentBuildVersion.File (
															datasetname		= KeyName and 
															envment				= Environment and 
															location 			= LocationName and 
															cluster 			= ClusterName )[1].buildversion;

	EXPORT SourceName := 'PersonHeader_Key';	

	SHARED headerempty := dataset([], Layout);

	// EXPORT LogicalFileName := 'thor_data400::key::header::' + BuildVersion  + '::data';
	EXPORT LogicalFileName := 'thor_data400::key::header_qa';
		
	// EXPORT File := index(headerempty, {s_did}, Layout - {s_did},Data_Services.foreign_prod  + LogicalFileName);
	EXPORT File := DATASET(Data_Services.foreign_prod + 'thor_data400::key::header_qa', layout, thor);
	
	EXPORT FileSize   := COUNT(File);
	
	EXPORT FatherFile := DATASET(Data_Services.foreign_prod + 'thor_data400::key::header_pb', layout, thor);

	SHARED SampleSize := 50000;
	
	SHARED NewSample := CHOOSEN(File(dt_vendor_last_reported = (INTEGER)BuildVersion[1..6]),40000);
	
	SHARED OldSample  := CHOOSEN(File, 10000);

	EXPORT SampleFile := DISTRIBUTE(NewSample + OldSample);

	EXPORT StaticRules := DATASET('~ens::qa::adv::rulesPersonHeaderKey1', ADV.MOD_Layouts.Rules, XML('dataset/record'));

	EXPORT NullRules   := ADV.FN_GetNullRules(SampleFile);

	EXPORT Rules       := StaticRules + NullRules;

END;