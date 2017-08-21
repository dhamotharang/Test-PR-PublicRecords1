//Generate Coverage Report for Official Records

import official_records;

inputfile := official_records.File_Moxie_Party_Dev(state_origin[1..2]<>'tu');

official_records.mac_CoverageReport(inputfile,doc_filed_dt,coverageReport)

coverageReport
