import tools, pfs;

export Files(string pversion = '', boolean pUseProd = false) := module

    export pfsComposite := dataset(Filenames(pversion,pUseProd).pfs_lInputTemplate, pfs.layouts.layout_pfs_record, csv(separator(','),heading(1), terminator(['\n','\r\n']),quote('"')));	

end;			