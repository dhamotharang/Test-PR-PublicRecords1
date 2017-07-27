// BWR_CountCompanyNamesAndDeSpray.ecl
bh:=sort(distribute(Business_Header.File_Business_Header,hash64(company_name)),company_name,local);
output(count(bh),named('size_of_bh'));

FreqCoNameRec := RECORD
   integer freq := count(group);
   bh.company_name;
END;

FreqCoNameDS := table(bh,FreqCoNameRec,company_name,local);
output(count(FreqCoNameDS),named('size_of_FreqCoNameDS'));
output(FreqCoNameDS,named('FreqCoNameDS'));

output(choosen(sort(FreqCoNameDS,-freq),1000000), ,'thumphrey::temp::FreqCoNameDS_csv',CSV(HEADING,SEPARATOR('|')),OVERWRITE);

FileServices.DeSpray(
    'thumphrey::temp::FreqCoNameDS_csv'
                ,'10.140.128.250'
    ,'/data/thumphrey/FreqCoNameDS_csv'
    ,-1,,,true
);
