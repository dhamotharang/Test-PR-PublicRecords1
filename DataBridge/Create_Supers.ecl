IMPORT tools, dx_DataBridge;

EXPORT Create_Supers := tools.mod_Utilities.createallsupers(
													 filenames().Input.dAll_filenames
                          ,filenames().dAll_filenames + dx_DataBridge.Names().dAll_filenames); 