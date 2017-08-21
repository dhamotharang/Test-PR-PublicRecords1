/* W20080312-104032
Concealed Carry Weapons
*/

shared ConcWpns  := emerges.file_ccw_base;

ut.macGetCoverageDates(ConcWpns,'Concealed Weapons', date_first_seen, date_first_seen, ConcWpns_coverage, true );

output(ConcWpns_coverage);