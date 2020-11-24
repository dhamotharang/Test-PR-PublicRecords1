import ut;

EXPORT BuildAll(string version) := FUNCTION

dsAdverseMedia 						:= ProcessFile(Files.srcAdverseMedia,false);
dsGlobalEnforcement 			:= ProcessFile(Files.srcGlobalEnforcement,false);
dsGlobalEdd 							:= ProcessFile(Files.srcGlobalEdd,false);
dsGlobalStateOwned 				:= ProcessFile(Files.srcGlobalStateOwned,false);
dsPep 										:= ProcessFile(Files.srcPep,false);
dsSanctionsAndEnforcement := ProcessFile(Files.srcSanctionsAndEnforcement,true);
dsSanctions 							:= ProcessFile(Files.srcSanctions,true);
dsNations 								:= ProcessCountryFile(Files.dsCountryEntities);
dsFull 										:= ProcessFile(Files.srcFull,true);
dsRegistrations 					:= ProcessFile(Files.srcRegistrations,false);

doit := SEQUENTIAL(
	PARALLEL(
		WriteXGFormat.OutputDataXMLFile('AM', 'WorldCompliance - Adverse Media.xml', version,
								dsAdverseMedia, Files.srcAdverseMedia),
		WriteXGFormat.OutputDataXMLFile('ENF', 'WorldCompliance - Enforcement.xml', version,
								dsGlobalEnforcement, Files.srcGlobalEnforcement),
		WriteXGFormat.OutputDataXMLFile('EDD', 'WorldCompliance - Expanded Due Diligence.xml', version,
								dsGlobalEdd, Files.srcGlobalEdd),
		WriteXGFormat.OutputDataXMLFile('SOE', 'WorldCompliance - State Owned Entities.xml', version,
								dsGlobalStateOwned, Files.srcGlobalStateOwned),
		WriteXGFormat.OutputDataXMLFile('PEP', 'WorldCompliance - Politically Exposed Persons.xml', version,
								dsPep, Files.srcPep),
		WriteXGFormat.OutputDataXMLFile('SAE', 'WorldCompliance - Sanctions and Enforcements.xml', version,
								dsSanctionsAndEnforcement, Files.srcSanctionsAndEnforcement,true),
		WriteXGFormat.OutputDataXMLFile('SAN', 'WorldCompliance - Sanctions.xml', version,
								dsSanctions, Files.srcSanctions,true),
		WriteXGFormat.OutputDataXMLFile('ALL', 'WorldCompliance - Full.xml', version,
								dsFull, Files.srcFull,true),
		worldcompliance.WriteXGFormat.OutputGeoXMLFile('CNT', 'WorldCompliance - Countries.xml', version,
								dsNations),
		WriteXGFormat.OutputDataXMLFile('REG', 'WorldCompliance - Registrations.xml', version,
   								dsRegistrations, Files.srcRegistrations)
	),
	Unspray('~thor::WorldCompliance::WorldCompliance - Adverse Media.xml', 'WorldCompliance - Adverse Media.xml'),
	Unspray('~thor::WorldCompliance::WorldCompliance - Enforcement.xml', 'WorldCompliance - Enforcement.xml'),
	Unspray('~thor::WorldCompliance::WorldCompliance - Expanded Due Diligence.xml', 'WorldCompliance - Expanded Due Diligence.xml'),
	Unspray('~thor::WorldCompliance::WorldCompliance - State Owned Entities.xml', 'WorldCompliance - State Owned Entities.xml'),
	Unspray('~thor::WorldCompliance::WorldCompliance - Politically Exposed Persons.xml', 'WorldCompliance - Politically Exposed Persons.xml'),
	Unspray('~thor::WorldCompliance::WorldCompliance - Sanctions and Enforcements.xml', 'WorldCompliance - Sanctions and Enforcements.xml'),
	Unspray('~thor::WorldCompliance::WorldCompliance - Sanctions.xml', 'WorldCompliance - Sanctions.xml'),
	Unspray('~thor::WorldCompliance::WorldCompliance - Full.xml', 'WorldCompliance - Full.xml'),
	Unspray('~thor::WorldCompliance::WorldCompliance - Countries.xml', 'WorldCompliance - Countries.xml'),
	Unspray('~thor::WorldCompliance::WorldCompliance - Registrations.xml', 'WorldCompliance - Registrations.xml')
);

return doit;

END;