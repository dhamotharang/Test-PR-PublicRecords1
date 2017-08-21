export Ingenix := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20100713a';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

export rthor_data400__key__ingenix_dea__providerid	:=
record
	unsigned6 l_providerid;
	string filetyp;
	string processdate;
	string providerid;
	string addressid;
	string deanumber;
	string deanumbercompanycount;
	string deanumbertiertypeid;
	string8 dt_first_seen;
	string8 dt_last_seen;
	string8 dt_vendor_first_reported;
	string8 dt_vendor_last_reported;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__ingenix_degree__providerid	:=
record
	unsigned6 l_providerid;
	string filetyp;
	string processdate;
	string providerid;
	string degree;
	string degreecompanycount;
	string degreetiertypeid;
	string8 dt_first_seen;
	string8 dt_last_seen;
	string8 dt_vendor_first_reported;
	string8 dt_vendor_last_reported;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__ingenix_group__providerid	:=
record
	unsigned6 l_providerid;
	string12 bdid;
	string3 bdid_score;
	string filetyp;
	string processdate;
	string providerid;
	string addressid;
	string grouppracticeid;
	string groupnamecompanycount;
	string groupnametiertypeid;
	string groupname;
	string address;
	string city;
	string state;
	string zip;
	string extzip;
	string latitude;
	string longitude;
	string phonenumber;
	string faxnumber;
	string taxid;
	string websiteaddress;
	string officeemail;
	string acceptmedicare;
	string acceptmedicaid;
	string seasonalhours;
	string handicapaccess;
	string wellandsickrooms;
	string publictransportation;
	string offstreetparking;
	string paymenttypes;
	string emrenabled;
	string onlinelabresults;
	string8 dt_first_seen;
	string8 dt_last_seen;
	string8 dt_vendor_first_reported;
	string8 dt_vendor_last_reported;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__ingenix_hospital__providerid	:=
record
	unsigned6 l_providerid;
	string12 bdid;
	string3 bdid_score;
	string filetyp;
	string processdate;
	string providerid;
	string addressid;
	string hospitalid;
	string hospitalnamecompanycount;
	string hospitalnametiertypeid;
	string hospitalname;
	string address;
	string city;
	string state;
	string zip;
	string extzip;
	string latitude;
	string longitude;
	string phonenumber;
	string ahaidnumber;
	string medicareproviderid;
	string taxid;
	string servicecodedescription;
	string totalbeds;
	string8 dt_first_seen;
	string8 dt_last_seen;
	string8 dt_vendor_first_reported;
	string8 dt_vendor_last_reported;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__ingenix_language__providerid	:=
record
	unsigned6 l_providerid;
	string filetyp;
	string processdate;
	string providerid;
	string language;
	string languagecompanycount;
	string languagetiertypeid;
	string8 dt_first_seen;
	string8 dt_last_seen;
	string8 dt_vendor_first_reported;
	string8 dt_vendor_last_reported;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__ingenix_license__providerid	:=
record
	unsigned6 l_providerid;
	string filetyp;
	string processdate;
	string providerid;
	string licensenumber;
	string licensestate;
	string effective_date;
	string termination_date;
	string licensenumbercompanycount;
	string licensenumbertiertypeid;
	string8 dt_first_seen;
	string8 dt_last_seen;
	string8 dt_vendor_first_reported;
	string8 dt_vendor_last_reported;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__ingenix_medschool__providerid	:=
record
	unsigned6 l_providerid;
	string12 bdid;
	string3 bdid_score;
	string8 dt_first_seen;
	string8 dt_last_seen;
	string8 dt_vendor_first_reported;
	string8 dt_vendor_last_reported;
	string filetyp;
	string processdate;
	string providerid;
	string medschoolname;
	string graduationyear;
	string medschoolcompanycount;
	string medschooltiertypeid;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__ingenix_npi__providerid	:=
record
	unsigned6 l_providerid;
	string filetyp;
	string processdate;
	string providerid;
	string npi;
	string enumerationdate;
	string npicompanycount;
	string npitiertypeid;
	string taxonomycode;
	string primaryindicator;
	string8 dt_first_seen;
	string8 dt_last_seen;
	string8 dt_vendor_first_reported;
	string8 dt_vendor_last_reported;
	unsigned8 __internal_fpos__;
end;

export dthor_data400__key__ingenix_dea__providerid 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ingenix_dea__' + lCSVVersion + '__providerid.csv', rthor_data400__key__ingenix_dea__providerid, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ingenix_degree__providerid 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ingenix_degree__' + lCSVVersion + '__providerid.csv', rthor_data400__key__ingenix_degree__providerid, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ingenix_group__providerid 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ingenix_group__' + lCSVVersion + '__providerid.csv', rthor_data400__key__ingenix_group__providerid, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ingenix_hospital__providerid 		:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ingenix_hospital__' + lCSVVersion + '__providerid.csv', rthor_data400__key__ingenix_hospital__providerid, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ingenix_language__providerid 		:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ingenix_language__' + lCSVVersion + '__providerid.csv', rthor_data400__key__ingenix_language__providerid, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ingenix_license__providerid 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ingenix_license__' + lCSVVersion + '__providerid.csv', rthor_data400__key__ingenix_license__providerid, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ingenix_medschool__providerid 		:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ingenix_medschool__' + lCSVVersion + '__providerid.csv', rthor_data400__key__ingenix_medschool__providerid, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ingenix_npi__providerid 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ingenix_npi__' + lCSVVersion + '__providerid.csv', rthor_data400__key__ingenix_npi__providerid, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;