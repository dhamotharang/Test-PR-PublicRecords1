IMPORT tools, dx_Infutor_NARB;

EXPORT Create_Supers := tools.mod_Utilities.createallsupers(
													 filenames().Input.dAll_filenames
                          ,filenames().dAll_filenames + dx_Infutor_NARB.keynames().dAll_filenames);