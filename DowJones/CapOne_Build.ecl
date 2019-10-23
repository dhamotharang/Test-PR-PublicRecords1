import std, _control;

		dXg5 := SORT(DowJones.MakePersons & DowJones.MakeEntities, id, local)
							:	PERSIST('~thor::dowjones::persist::allrecords');		
							
		coDespray(string logicalname, string outfile) :=
			Std.File.Despray(logicalname,
				_Control.IPAddress.bctlpedata10,
				'/data/hds_3/DowJones/caponeout/' + outfile +'.xml',
				allowoverwrite := true);

// Segmentation Group 1
dXgDHDSNG 	:= DowJones.CapOneFilters.SegGroup1(dXg5, 1);
dXgDNGM		 	:= DowJones.CapOneFilters.SegGroup1(dXg5, 2);
dXgDMNL		 	:= DowJones.CapOneFilters.SegGroup1(dXg5, 3);
dXgDSCSNG	 	:= DowJones.CapOneFilters.SegGroup1(dXg5, 4);
dXgDSCSRG	 	:= DowJones.CapOneFilters.SegGroup1(dXg5, 5);
dXgDECS		 	:= DowJones.CapOneFilters.SegGroup1(dXg5, 6);
dXgDSMAF	 	:= DowJones.CapOneFilters.SegGroup1(dXg5, 7);
dXgDSMPS	 	:= DowJones.CapOneFilters.SegGroup1(dXg5, 8);
dXgDSMSS	 	:= DowJones.CapOneFilters.SegGroup1(dXg5, 9);
dXgDSMJ		 	:= DowJones.CapOneFilters.SegGroup1(dXg5, 10);
dXgDSCE		 	:= DowJones.CapOneFilters.SegGroup1(dXg5, 11);
dXgDSAO		 	:= DowJones.CapOneFilters.SegGroup1(dXg5, 12);
dXgDHDHRG 	:= DowJones.CapOneFilters.SegGroup1(dXg5, 13);
dXgDRGM		 	:= DowJones.CapOneFilters.SegGroup1(dXg5, 14);
dXgDRL		 	:= DowJones.CapOneFilters.SegGroup1(dXg5, 15);
dXgDPPO		 	:= DowJones.CapOneFilters.SegGroup1(dXg5, 16);
dXgDIOO		 	:= DowJones.CapOneFilters.SegGroup1(dXg5, 17);
dXgDCM		 	:= DowJones.CapOneFilters.SegGroup1(dXg5, 18);
dXgDPPLGO	 	:= DowJones.CapOneFilters.SegGroup1(dXg5, 19);
dXgDO			 	:= DowJones.CapOneFilters.SegGroup1(dXg5, 20);
//dXgDNNO		 	:= DowJones.CapOneFilters.SegGroup1(dXg5, 21);
dXgDSL		 	:= DowJones.CapOneFilters.SegGroup1(dXg5, 22);

// Segmentation Group 2
dXgFHDSNG 	:= DowJones.CapOneFilters.SegGroup2(dXg5, 1);
dXgFNGM		 	:= DowJones.CapOneFilters.SegGroup2(dXg5, 2);
dXgFMNL		 	:= DowJones.CapOneFilters.SegGroup2(dXg5, 3);
dXgFSCSNG	 	:= DowJones.CapOneFilters.SegGroup2(dXg5, 4);
dXgFSCSRG	 	:= DowJones.CapOneFilters.SegGroup2(dXg5, 5);
dXgFECS		 	:= DowJones.CapOneFilters.SegGroup2(dXg5, 6);
dXgFSMAF	 	:= DowJones.CapOneFilters.SegGroup2(dXg5, 7);
dXgFSMPS	 	:= DowJones.CapOneFilters.SegGroup2(dXg5, 8);
dXgFSMSS	 	:= DowJones.CapOneFilters.SegGroup2(dXg5, 9);
dXgFSMJ		 	:= DowJones.CapOneFilters.SegGroup2(dXg5, 10);
dXgFSCE		 	:= DowJones.CapOneFilters.SegGroup2(dXg5, 11);
dXgFSAO		 	:= DowJones.CapOneFilters.SegGroup2(dXg5, 12);
dXgFHDHRG 	:= DowJones.CapOneFilters.SegGroup2(dXg5, 13);
dXgFRGM		 	:= DowJones.CapOneFilters.SegGroup2(dXg5, 14);
dXgFRL		 	:= DowJones.CapOneFilters.SegGroup2(dXg5, 15);
dXgFPPO		 	:= DowJones.CapOneFilters.SegGroup2(dXg5, 16);
dXgFIOO		 	:= DowJones.CapOneFilters.SegGroup2(dXg5, 17);
dXgFCM		 	:= DowJones.CapOneFilters.SegGroup2(dXg5, 18);
dXgFPPLGO	 	:= DowJones.CapOneFilters.SegGroup2(dXg5, 19);
dXgFO			 	:= DowJones.CapOneFilters.SegGroup2(dXg5, 20);
//dXgFNNO		 	:= DowJones.CapOneFilters.SegGroup2(dXg5, 21);
dXgFSL		 	:= DowJones.CapOneFilters.SegGroup2(dXg5, 22);

// Segmentation Group 3
dXgGDL	 	:= DowJones.CapOneFilters.SegGroup3(dXg5);

// Segmentation Group 4 -- Persons
dXgSIPC		:= DowJones.CapOneFilters.SegGroup4(dXg5, 'Corruption');
dXgSIPFC	:= DowJones.CapOneFilters.SegGroup4(dXg5, 'Financial Crime');
dXgSIPOC	:= DowJones.CapOneFilters.SegGroup4(dXg5, 'Organised Crime');
dXgSIPTC	:= DowJones.CapOneFilters.SegGroup4(dXg5, 'Trafficking');
dXgSIPT		:= DowJones.CapOneFilters.SegGroup4(dXg5, 'Terror');
// Segmentation Group 4 -- Entities
dXgSIEC		:= DowJones.CapOneFilters.SegGroup4e(dXg5, 'Corruption');
dXgSIEFC	:= DowJones.CapOneFilters.SegGroup4e(dXg5, 'Financial Crime');
dXgSIEOC	:= DowJones.CapOneFilters.SegGroup4e(dXg5, 'Organised Crime');
dXgSIETC	:= DowJones.CapOneFilters.SegGroup4e(dXg5, 'Trafficking');
dXgSIET		:= DowJones.CapOneFilters.SegGroup4e(dXg5, 'Terror');

// add associates out write output file
OutputFIle(dataset(recordof(dXg5)) infile, string code, boolean FilterDeceased=true, boolean includeAssoc=true) := FUNCTION
			
			assoc := DowJones.CPAddAssociates(infile, dXg5, FilterDeceased);
			result := if(includeAssoc, infile + assoc, infile);
			return CPWriteXGFormat(result, code);
END;

BuildFiles := PARALLEL(
// Segmentation Group 1
	OutputFile(dXgDHDSNG,'PEP_DHDSNG'),
	OutputFile(dXgDNGM,'PEP_DNGM'),
	OutputFile(dXgDMNL,'PEP_DMNL'),
	OutputFile(dXgDSCSNG,'PEP_DSCSNG'),
	OutputFile(dXgDSCSRG,'PEP_DSCSRG'),
	
	OutputFile(dXgDECS,'PEP_DECS'),	
	OutputFile(dXgDSMAF,'PEP_DSMAF'),
	OutputFile(dXgDSMPS,'PEP_DSMPS'),
	OutputFile(dXgDSMSS,'PEP_DSMSS'),
	OutputFile(dXgDSMJ,'PEP_DSMJ'),
	
	OutputFile(dXgDSCE,'PEP_DSCE'),
	OutputFile(dXgDSAO,'PEP_DSAO'),
	OutputFile(dXgDHDHRG,'PEP_DHDHRG'),
	OutputFile(dXgDRGM,'PEP_DRGM'),
	OutputFile(dXgDRL,'PEP_DRL'),
	
	OutputFile(dXgDPPO,'PEP_DPPO'),
	OutputFile(dXgDIOO,'PEP_DIOO'),
	OutputFile(dXgDCM,'PEP_DCM'),
	OutputFile(dXgDPPLGO,'PEP_DPPLGO'),
	OutputFile(dXgDO,'PEP_DO'),
	
	//OutputFile(dXgDNNO,'PEP_DNNO'),
	OutputFile(dXgDSL,'PEP_DSL'),
	
// Segmentation Group 2
	OutputFile(dXgFHDSNG,'PEP_FHDSNG'),
	OutputFile(dXgFNGM,'PEP_FNGM'),
	OutputFile(dXgFMNL,'PEP_FMNL'),
	OutputFile(dXgFSCSNG,'PEP_FSCSNG'),
	OutputFile(dXgFSCSRG,'PEP_FSCSRG'),
	
	OutputFile(dXgFECS,'PEP_FECS'),	
	OutputFile(dXgFSMAF,'PEP_FSMAF'),
	OutputFile(dXgFSMPS,'PEP_FSMPS'),
	OutputFile(dXgFSMSS,'PEP_FSMSS'),
	OutputFile(dXgFSMJ,'PEP_FSMJ'),
	
	OutputFile(dXgFSCE,'PEP_FSCE'),
	OutputFile(dXgFSAO,'PEP_FSAO'),
	OutputFile(dXgFHDHRG,'PEP_FHDHRG'),
	OutputFile(dXgFRGM,'PEP_FRGM'),
	OutputFile(dXgFRL,'PEP_FRL'),
	
	OutputFile(dXgFPPO,'PEP_FPPO'),
	OutputFile(dXgFIOO,'PEP_FIOO'),
	OutputFile(dXgFCM,'PEP_FCM'),
	OutputFile(dXgFPPLGO,'PEP_FPPLGO'),
	OutputFile(dXgFO,'PEP_FO'),
	
	//OutputFile(dXgFNNO,'PEP_FNNO'),
	OutputFile(dXgFSL,'PEP_FSL'),

// Segmentation Group 3
	OutputFile(dXgGDL,'PEP_GDL',false),
	
// Segmentation Group 4
	OutputFile(dXgSIPC,'SIP_C',true,false),
	OutputFile(dXgSIPFC,'SIP_FC',true,false),
	OutputFile(dXgSIPOC,'SIP_OC',true,false),
	OutputFile(dXgSIPTC,'SIP_TC',true,false),
	OutputFile(dXgSIPT,'SIP_T',true,false),
	
	OutputFile(dXgSIEC,'SIE_C',true,false),
	OutputFile(dXgSIEFC,'SIE_FC',true,false),
	OutputFile(dXgSIEOC,'SIE_OC',true,false),
	OutputFile(dXgSIETC,'SIE_TC',true,false),
	OutputFile(dXgSIET,'SIE_T',true,false)	
);

files := DowJones.CapOne_Dictionary.files;

desprayFiles := NOTHOR(APPLY(files, coDespray( lfn, filename)));

						
EXPORT CapOne_Build := 
	SEQUENTIAL
	(
		BuildFiles,
		desprayFiles
	);
