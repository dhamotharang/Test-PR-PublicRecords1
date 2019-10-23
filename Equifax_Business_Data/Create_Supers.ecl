IMPORT tools, dx_Equifax_Business_Data;

EXPORT Create_Supers := tools.mod_Utilities.createallsupers(
													 Equifax_Business_Data.filenames().Input.dAll_filenames
                          ,Equifax_Business_Data.filenames().dAll_filenames + dx_Equifax_Business_Data.keynames().dAll_filenames);