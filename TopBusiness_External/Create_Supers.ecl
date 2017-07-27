import tools;

export Create_Supers := sequential(
	tools.mod_Utilities.createsupers(filenames().dAll_filenames),
	tools.mod_Utilities.createsupers(keynames().dAll_filenames));
