import ut,lib_stringlib;
export proc_build_base := function

File_In := File_in_courtsearch;

CourtSearch.Layout_base_CourtSearch  tr_ctsearch(File_In l) := transform
self.jurisdiction := StringLib.Stringtouppercase(l.jurisdiction);
self.searchcode :=  StringLib.Stringtouppercase(l.searchcode);
self.St := StringLib.Stringtouppercase(l.Statecode);
self.searchDescription := StringLib.Stringtouppercase(l.searchDescription);
self.Price                   := StringLib.StringFilterOut(l.Price,'$')[1..5];
self.TurnAround             := StringLib.Stringtouppercase(l.TurnAround);
self.Misc                   := StringLib.Stringtouppercase(l.Misc);
self.SummaryDescription      := StringLib.Stringtouppercase(l.SummaryDescription);
self.crlf := '';
self := l;
end;

File_out := project(File_In,tr_ctsearch(LEFT));
//Build the base file

ut.MAC_SF_BuildProcess(File_out,'~thor_data400::base::courtsearch',courtsearch,3,false,false);

build_base := sequential(courtsearch);

return build_base;
end;