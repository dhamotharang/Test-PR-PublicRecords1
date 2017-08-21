#workunit('name', 'Create All Yellowpages Superfiles/keys');

createsuper(STRING file) := IF(FileServices.FileExists(file),
	output(file + ' already exists, not created'), fileservices.createsuperfile(trim(file)));

nothor(apply(yellowpages.Filenames.dAll_superfilenames,				createsuper(trim(name))));
nothor(apply(yellowpages.Keynames.newconvention.dAll_superfilenames,	createsuper(trim(name))));

