// BWR_MakeAndDeSprayBusinessHeaderSample.ecl
bh:=distribute(Business_Header.File_Business_Header,hash64(bdid));
output(count(bh),named('size_of_bh'));

bh_sample := ENTH(bh,1,996,1,local);
output(count(bh_sample),named('size_of_bh_sample'));

output(bh_sample, ,'thumphrey::temp::business_header_sample1000732_csv',CSV(HEADING,SEPARATOR('|')),OVERWRITE);

FileServices.DeSpray(
    'thumphrey::temp::business_header_sample1000732_csv'
                ,'10.140.128.250'
    ,'/data/thumphrey/business_header_sample1000732_csv'
    ,-1,,,true
);
