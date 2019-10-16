IMPORT STD, _Control;

djDespray(string logicalname, string outfile) :=
	fileservices.Despray(logicalname,
		_Control.IPAddress.bctlpedata10,
		'/data/hds_3/DowJones/output/' + outfile +'delta.xml',
		allowoverwrite := true);

UnsprayReport(string lfn) :=
	STD.file.Despray(lfn,
		_Control.IPAddress.bctlpedata10,
		'/data/hds_3/DowJones/output/SanctionsReport_delta.csv',
		allowoverwrite := true);
        
		
	dXg5 := SORT(DowJones.MakePersons+DowJones.MakeEntities, id, local)
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

EXPORT BuildDelta := SEQUENTIAL(
	OUTPUT(COUNT(DowJones.File_Person)+COUNT(DowJones.File_Entity),named('inputcount')),
	OUTPUT(COUNT(dXg5),named('recordcount')),
	OUTPUT(DowJones.SanctionsReport,,'~thor::dowjones::xg::sanctionsreport_d.csv',CSV(HEADING(SINGLE),QUOTE('&quot;'),TERMINATOR('\r\n')),OVERWRITE),
	PARALLEL(	
	DowJones.WriteXGFormatDelta(dXgAFR,'djafr_d','COUNTRY_GROUP_AFR'),
	DowJones.WriteXGFormatDelta(dXgASIA,'djasia_d','COUNTRY_GROUP_ASIA'),
	DowJones.WriteXGFormatDelta(dXgCANADA,'djcanada_d','COUNTRY_GROUP_CANADA'),
	DowJones.WriteXGFormatDelta(dXgEUR,'djeur_d','COUNTRY_GROUP_EURO'),
	DowJones.WriteXGFormatDelta(dXgME,'djme_d','COUNTRY_GROUP_ME'),
	DowJones.WriteXGFormatDelta(dXgNA,'djna_d','COUNTRY_GROUP_NA'),
	DowJones.WriteXGFormatDelta(dXgSA,'djsa_d','COUNTRY_GROUP_SA'),
	DowJones.WriteXGFormatDelta(dXgUNK,'djunk_d','COUNTRY_GROUP_UNK'),
	DowJones.WriteXGFormatDelta(dXgUSA,'djusa_d','COUNTRY_GROUP_USA')
	),
	UnsprayReport('~thor::dowjones::xg::sanctionsreport_d.csv'),
	djDespray('~thor::dowjones::xg::djafr_d', 'FACTIVA PFA AFRICA'),
	djDespray('~thor::dowjones::xg::djasia_d', 'FACTIVA PFA ASIA'),
	djDespray('~thor::dowjones::xg::djcanada_d', 'FACTIVA PFA CANADA'),
	djDespray('~thor::dowjones::xg::djeur_d', 'FACTIVA PFA EUROPE'),
	djDespray('~thor::dowjones::xg::djme_d', 'FACTIVA PFA MIDDLE EAST'),
	djDespray('~thor::dowjones::xg::djna_d', 'FACTIVA PFA NORTH_AMERICA'),
	djDespray('~thor::dowjones::xg::djsa_d', 'FACTIVA PFA SOUTH AMERICA'),
	djDespray('~thor::dowjones::xg::djunk_d', 'FACTIVA PFA UNKNOWN'),
	djDespray('~thor::dowjones::xg::djusa_d', 'FACTIVA PFA USA')
);