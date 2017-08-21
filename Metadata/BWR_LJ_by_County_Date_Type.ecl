//L&J for state/county with totals and min/max filing dates
//Provided by Ayeesha Kaytala
//Saved 4/6/07 by N.Martinez
//Run on thor_dell400_2
//Date evaluation code added by Ananth 5/8/07
//LJ by County Date Type 20071211 jjb

file_in :=LiensV2.file_liens_main(orig_filing_date <> '') ;

dLiens := distribute(LiensV2.file_liens_main
  /*(orig_filing_date<>'' AND (filing_jurisdiction='PA' OR agency_state='PA')*/,
  hash32(filing_type_desc));

rdev := record
  file_in.agency_state ;
  file_in.agency_county ;
  integer4 Total  := count(group);
  string8 MaxVal_filing_date := max(group,file_in.orig_filing_date);
  string8 MinVal_filing_date := min(group,file_in.orig_filing_date);
end;

dDevTable := table(file_in(orig_filing_date > '19000101' and orig_filing_date <= ut.GetDate),rdev,agency_state,agency_county,few);
dDevTable_sort := sort(dDevTable,agency_state,agency_county) ;

//W20070926-121303 AL Liens by Doctype
//W20070926-141828 Liens by Doctypes
output(table(file_in,{filing_type_desc,count(group)},filing_type_desc),all);
output(table(file_in,{tax_code,count(group)},tax_code),all);

//W20070926-155750 W20071126-181529 W20071211-135812 Liens by County Doctype (e.g. Tax Liens)
output(table(file_in,
  {agency_state,agency_county,filing_type_desc,
   (string8)min(group,file_in.orig_filing_date),
   (string8)max(group,file_in.orig_filing_date),
   count(group)},
  agency_state,agency_county,filing_type_desc),all);

//W20071019-161308 W20071115-1015022 Distributed Liens by State Doctype
output(table(distributed(dLiens,hash32(filing_type_desc)),
  {filing_type_desc,count(group)},
  filing_type_desc),all);