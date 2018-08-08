IMPORT tools;

EXPORT Create_Supers := tools.mod_Utilities.createallsupers(
													 filenames().Input.dAll_filenames
                          ,filenames().dAll_filenames + keynames().dAll_filenames);