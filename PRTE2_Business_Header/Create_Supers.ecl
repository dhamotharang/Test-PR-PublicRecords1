import tools;

//export Create_Supers := tools.mod_Utilities.createsupers(PRTE2_Business_Header.Filenames().base.dAll_filenames);
export Create_Supers := tools.mod_Utilities.createallsupers(filenames().Input.dAll_filenames,filenames().base.dAll_filenames + keynames().dAll_filenames);

