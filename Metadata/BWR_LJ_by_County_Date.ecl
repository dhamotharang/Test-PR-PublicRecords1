//L&J for state/county with totals and min/max filing dates
//Provided by Ayeesha Kaytala
//Saved 4/6/07 by N.Martinez
//Run on thor_dell400_2
//Date evaluation code added by Ananth 5/8/07
//W20080118-103350 by jjb

file_in :=LiensV2.file_liens_main(orig_filing_date <> '') ;

rdev := record
  file_in.agency_state ;
  file_in.agency_county ;
  integer4 Total  := count(group);
  string8 MaxVal_filing_date := max(group,file_in.orig_filing_date);
  string8 MinVal_filing_date := min(group,file_in.orig_filing_date);
end;

//dDevTable := table(file_in,rdev,agency_state,agency_county,few);
//dDevTable_sort := sort(dDevTable,agency_state,agency_county);

dDevTable := table(file_in(orig_filing_date > '19000101' and orig_filing_date <= ut.GetDate),rdev,agency_state,agency_county,few);
dDevTable_sort := sort(dDevTable,agency_state,agency_county);

output(dDevTable_sort,all);