import lib_fileservices;
EXPORT hasSupers(string filename) := function
	string l_filename := if (filename[1..1] = '~',filename, '~'+filename);
	return if (fileservices.fileexists(l_filename),
								if (count(fileservices.logicalfilesuperowners(l_filename)) > 0, true, false),
								true
								);
end;