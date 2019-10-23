IMPORT tools;

EXPORT Create_Supers := tools.mod_Utilities.createallsupers(
													 filenames().InputAddr.dAll_filenames + 
													 filenames().InputTrans.dAll_filenames
                          ,filenames().dAll_filenames );
																														
