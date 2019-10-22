IMPORT tools,dx_Database_USA;

EXPORT Create_Supers := tools.mod_Utilities.createallsupers(
													 filenames().Input.dAll_filenames
                          ,filenames().dAll_filenames + dx_Database_USA.Names().dAll_filenames); 