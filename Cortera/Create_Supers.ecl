import tools, dx_Cortera;

export Create_Supers(string pKeyDatasetName = 'cortera') := tools.mod_Utilities.createallsupers(filenames().Input.dAll_filenames, filenames().Base.dAll_filenames + dx_Cortera.Keynames().dAll_filenames);
