//////// OPEN THIS AS A BWR. HIT GO.

import liensv2, bankruptcyv2, crim, oshair;

#workunit('name', 'Oshair Coverage Stats')

main := oshair.file_out_inspection_cleaned;

new_layout := record, maxlength(4096)
inspection_opening_date := '';
source_file := 'OSHAIR';
process_date := '00000000';
DID := '';
end;

new_layout reformat(main m) := transform
	self.inspection_opening_date := (string8)m.inspection_opening_date;
end;

infile := project(main, reformat(left));

CRIM.mac_CoverageReport(infile,inspection_opening_date,CoverageReport);

CoverageReport;