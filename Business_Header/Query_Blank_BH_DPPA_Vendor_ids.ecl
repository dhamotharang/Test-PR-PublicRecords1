bh := business_header.File_Business_Header;

output(count(bh), named('TotalBusinessHeaderRecords'));
output(count(bh(dppa = true)), named('TotalBusinessHeaderDppaRecords'));
output(count(bh(dppa = true and vendor_id = '')), named('TotalBusinessHeaderDppaRecordsWithBlankVendorid'));
output('There should be a very small percentage of DPPA records with blank vendor ids');
