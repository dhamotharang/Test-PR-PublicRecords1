version := '20190605';
root := '~thor::bridger::medicaid::hc_med_sanc_extract_20190605.tab';

ds1 := dataset(root, MedicaidSanctions.Layout_Sanctions, CSV);

ds := ds1(last<>'');			// valid entries
dsbad := ds1(last='');
mapped := MedicaidSanctions.MapFields(ds);

SEQUENTIAL(
	//***** spray file here
	OUTPUT(COUNT(dsbad), named('n_rejectedrecords')),
	OUTPUT(CHOOSEN(dsbad, 100), named('rejected_samples')),
	MedicaidSanctions.WriteXGFormat.OutputDataXMLFile(version, mapped, ds)
	// despray XML file
);
	