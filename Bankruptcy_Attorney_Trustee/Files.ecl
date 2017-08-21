import ut;
export Files := module

export Attorneys_In := dataset(Superfile_List.Source_File_Attorney_In, layouts.layout_attorneys_in, csv(heading(1), separator(','), terminator(['\n','\r\n']), quote('"')));
export Trustees_In := dataset(Superfile_List.Source_File_Trustee_In , layouts.layout_trustees_in, csv(heading(1), separator(','), terminator(['\n','\r\n']), quote('"')));

export Attorneys_Base := dataset(Superfile_List.Base_File_Attorney_Out, layouts.layout_attorneys_out, thor);
export Trustees_Base := dataset(Superfile_List.Base_File_Trustee_Out, layouts.layout_trustees_out, thor);

end;
