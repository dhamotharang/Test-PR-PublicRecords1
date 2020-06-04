EXPORT BWR_BuildMedicaidSanctions(version, baseversion) := macro;
#OPTION('MultiplePersistInstances', false);
//version := '20191011';
//baseversion := '20190926';
root := '~thor::bridger::medicaid::hc_med_sanc_extract_' + baseversion + '.tab';

ds1 := dataset(root, MedicaidSanctions.Layout_Sanctions, 
							CSV(SEPARATOR('\t'),QUOTE('"'),TERMINATOR(['\n','\r\n','\n\r'])));

ds := ds1((last <> '' OR name <> ''), type_id<>'');			// valid entries
dsbad := ds1((last='' AND name='') OR type_id='');

mapped := MedicaidSanctions.MapFields(ds);

SEQUENTIAL(
	//***** spray file here
	OUTPUT(COUNT(ds), named('n_records')),
	OUTPUT(CHOOSEN(ds, 250), named('samples')),
	OUTPUT(COUNT(dsbad), named('n_rejectedrecords')),
	OUTPUT(CHOOSEN(dsbad, 100), named('rejected_samples')),
	MedicaidSanctions.WriteXGFormat.OutputDataXMLFile(version, mapped),
	// despray XML file
	MedicaidSanctions.Unspray(
				'~thor::medicaidsanctions::' + version,
				'medicaidsanctions_' + version + '.xml')

);
endmacro;
	