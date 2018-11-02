IMPORT STD;
djDespray(string logicalname, string outfile) :=
	fileservices.Despray(logicalname,
		_Control.IPAddress.bctlpedata10,
		'/data/hds_3/DowJones/output/' + outfile +'.xml',
		allowoverwrite := true);

UnsprayReport(string lfn) :=
	STD.file.Despray(lfn,
		_Control.IPAddress.bctlpedata10,
		'/data/hds_3/DowJones/output/SanctionsReport.csv',
//		'/hds_3/DowJones/testdata/SanctionsReport.csv',
		allowoverwrite := true);
		
	dXg5 := SORT(DowJones.MakePersons & DowJones.MakeEntities, id, local)
							:	PERSIST('~thor::dowjones::persist::allrecords');					
	
dXgAFR := DowJones.RegionFilter(dXg5, 'COUNTRY_GROUP_AFR');
dXgASIA := DowJones.RegionFilter(dXg5, 'COUNTRY_GROUP_ASIA');
dXgCANADA := DowJones.RegionFilter(dXg5, 'COUNTRY_GROUP_CANADA');
dXgEUR := DowJones.RegionFilter(dXg5, 'COUNTRY_GROUP_EURO');
dXgME := DowJones.RegionFilter(dXg5, 'COUNTRY_GROUP_ME');
dXgNA := DowJones.RegionFilter(dXg5, 'COUNTRY_GROUP_NA');
dXgSA := DowJones.RegionFilter(dXg5, 'COUNTRY_GROUP_SA');
dXgUNK := DowJones.RegionFilter(dXg5, 'COUNTRY_GROUP_UNK');
dXgUSA := DowJones.RegionFilter(dXg5, 'COUNTRY_GROUP_USA');

EXPORT BuildAll := SEQUENTIAL(
	OUTPUT(COUNT(DowJones.File_Person)+COUNT(DowJones.File_Entity),named('inputcount')),
	OUTPUT(COUNT(dXg5),named('recordcount')),
	OUTPUT(DowJones.SanctionsReport,,'~thor::dowjones::xg::sanctionsreport.csv',CSV(HEADING(SINGLE),QUOTE('"'),TERMINATOR('\r\n')),OVERWRITE),
	PARALLEL(	
	DowJones.WriteXGFormat(dXgAFR,'djafr','COUNTRY_GROUP_AFR'),
	DowJones.WriteXGFormat(dXgASIA,'djasia','COUNTRY_GROUP_ASIA'),
	DowJones.WriteXGFormat(dXgCANADA,'djcanada','COUNTRY_GROUP_CANADA'),
	DowJones.WriteXGFormat(dXgEUR,'djeur','COUNTRY_GROUP_EURO'),
	DowJones.WriteXGFormat(dXgME,'djme','COUNTRY_GROUP_ME'),
	DowJones.WriteXGFormat(dXgNA,'djna','COUNTRY_GROUP_NA'),
	DowJones.WriteXGFormat(dXgSA,'djsa','COUNTRY_GROUP_SA'),
	DowJones.WriteXGFormat(dXgUNK,'djunk','COUNTRY_GROUP_UNK'),
	DowJones.WriteXGFormat(dXgUSA,'djusa','COUNTRY_GROUP_USA')
	),
	UnsprayReport('~thor::dowjones::xg::sanctionsreport.csv'),
	djDespray('~thor::dowjones::xg::djafr', 'FACTIVA PFA AFRICA'),
	djDespray('~thor::dowjones::xg::djasia', 'FACTIVA PFA ASIA'),
	djDespray('~thor::dowjones::xg::djcanada', 'FACTIVA PFA CANADA'),
	djDespray('~thor::dowjones::xg::djeur', 'FACTIVA PFA EUROPE'),
	djDespray('~thor::dowjones::xg::djme', 'FACTIVA PFA MIDDLE EAST'),
	djDespray('~thor::dowjones::xg::djna', 'FACTIVA PFA NORTH_AMERICA'),
	djDespray('~thor::dowjones::xg::djsa', 'FACTIVA PFA SOUTH AMERICA'),
	djDespray('~thor::dowjones::xg::djunk', 'FACTIVA PFA UNKNOWN'),
	djDespray('~thor::dowjones::xg::djusa', 'FACTIVA PFA USA')
);
