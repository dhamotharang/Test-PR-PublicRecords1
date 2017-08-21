#workunit ('name', 'Yellow Pages Post Process cleanup ' + yellowpages.YellowPages_Build_Date);

cleanup(STRING file) := IF(FileServices.FileExists(file),
	FileServices.DeleteLogicalFile(file), OUTPUT('File "' + file + '" does not exist.'));

apply(Persistnames.dAll_persistnames, cleanup(name));
