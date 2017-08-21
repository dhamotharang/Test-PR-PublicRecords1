import OIG;

export File_OIG_raw_in := dataset(OIG.Cluster +'raw_base::OIG',OIG.Layouts.Raw_OIG_Layout,CSV(heading(1),maxlength(999999), quote('"'), TERMINATOR(['\r\n', '\n'])));

