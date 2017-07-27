#workunit ('name', 'Yellow Pages Post Process cleanup ' + yellowpages.YellowPages_Build_Date);

cleanup(STRING file) := IF(FileServices.FileExists(file),
	FileServices.DeleteLogicalFile(file), OUTPUT('File "' + file + '" does not exist.'));
cleanup('~thor_data400::temp::yellowpages_base_gong');
cleanup('~thor_data400::temp::yellowpages_base_yp');
cleanup('~thor_data400::out::yellowpages_' + yellowpages.YellowPages_Build_Date);