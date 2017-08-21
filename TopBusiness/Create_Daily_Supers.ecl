import tools,TopBusiness_External,TopBusiness_Search;

export Create_Daily_Supers := sequential(
	tools.mod_Utilities.createsupers(filenamesDaily().dAll_filenames),
	tools.mod_Utilities.createsupers(keynamesDaily().dAll_filenames));
