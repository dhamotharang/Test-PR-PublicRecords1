export file_reference := MODULE
 export misc_file := dataset('~thor_data400::in::cnldfacilities::affcode.csv',CNLD_Facilities.layout_reference.rfile,csv(SEPARATOR(','),heading(1)))
												+dataset('~thor_data400::in::cnldfacilities::factype.csv',CNLD_Facilities.layout_reference.rfile,csv(SEPARATOR(','),heading(1)))
												+dataset('~thor_data400::in::cnldfacilities::ownertype.csv',CNLD_Facilities.layout_reference.rfile,csv(SEPARATOR(','),heading(1)));
												
			rfile := dataset('~thor_data400::in::cnld::cmvlictype::lookup',CNLD_Facilities.layout_reference.rlookup,CSV(heading(1),separator(','),quote('"')));
 export lictype := rfile(trim(lic_type) in ['PME','MOP','5303','PHY','7200NRP','P22','08 02','IRF','PHR','A9','CMTY','UN']);
END;

