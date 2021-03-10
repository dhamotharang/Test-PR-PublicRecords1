import tools, dx_Cortera_Tradeline;

export Create_Supers := tools.mod_Utilities.createallsupers($.filenames().Input.dAll_filenames,$.filenames().Base.dAll_filenames + dx_Cortera_Tradeline.Keynames().dAll_filenames);
