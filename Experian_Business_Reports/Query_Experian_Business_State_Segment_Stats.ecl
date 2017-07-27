#workunit('name', 'Experian Business State Segment Stats');

fheader := Experian_Business_Reports.File_Header_Records_In;

layout_header_slim := record
fheader.FILE_NUMBER;
fheader.STATE_CODE;
end;

fheader_slim := table(fheader, layout_header_slim);
fheader_slim_dedup := dedup(fheader_slim, FILE_NUMBER, all);

fall := Experian_Business_Reports.File_All_Segments_In;

layout_all_slim := record
fall.FILE_NUMBER;
fall.SEGMENT_CODE;
string2 STATE_CODE := '';
end;

fall_slim := table(fall, layout_all_slim);

// Append state codes to segment records
fseg := join(fall_slim,
             fheader_slim_dedup,
		   left.FILE_NUMBER = right.FILE_NUMBER,
		   transform(layout_all_slim, self.state_code := right.state_code, self := left),
		   hash);

layout_stat := record
fseg.STATE_CODE;
fseg.SEGMENT_CODE;
cnt := count(group);
end;

fstat := table(fseg, layout_stat, STATE_CODE, SEGMENT_CODE, few);

output(fstat, all);

