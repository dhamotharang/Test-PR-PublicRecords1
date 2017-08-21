//////// OPEN THIS AS A BWR. HIT GO.

import liensv2, bankruptcyv2, crim;

#workunit('name', 'BankruptcyV2 Coverage Stats')

main := bankruptcyv2.file_bankruptcy_main;
party := bankruptcyv2.file_bankruptcy_search;

comb_layout := record, maxlength(4096)
bankruptcyV2.Layout_bankruptcy_main.layout_bankruptcy_main_filing;
string filing_date;
string source_file;
end;

comb_layout reformat(main m) := transform
	self := m;
	self.filing_date := if(m.orig_filing_date > '', m.orig_filing_date, m.date_filed);
	self.source_file := m.court_name;
end;

infile := project(distribute(main, hash(tmsid)), reformat(left));

output(infile);

CRIM.mac_CoverageReport(infile,filing_date,CoverageReport);

CoverageReport;

// output(bankruptcyv2.file_bankruptcy_main);