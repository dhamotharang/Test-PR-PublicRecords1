Import tools;

export Create_SuperFiles := tools.mod_Utilities.createallsupers( filenames().Input.dAll_filenames
																																,filenames().dAll_filenames + keynames().dAll_filenames
																																);
