IMPORT tools;

EXPORT Create_Supers :=
  tools.mod_Utilities.createallsupers(Filenames().Input.dAll_filenames,
		                                  Filenames().dAll_filenames + Keynames().dAll_filenames);
