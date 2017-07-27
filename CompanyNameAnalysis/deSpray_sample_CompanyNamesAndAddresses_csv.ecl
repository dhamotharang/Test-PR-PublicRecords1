CompanyNameAndAddress_rec := RECORD
  qstring120 company_name;
  qstring10 prim_range;
  string2   predir;
  qstring28 prim_name;
  qstring4  addr_suffix;
  string2   postdir;
  qstring5  unit_desig;
  qstring8  sec_range;
  qstring25 city;
  string2   state;
  unsigned3 zip;
END;

sample_CompanyNamesAndAddresses := dataset('thumphrey::sample::CompanyNamesAndAddresses', CompanyNameAndAddress_rec,THOR);

output(
       sample_CompanyNamesAndAddresses
			 ,
			 ,'thumphrey::temp::sample_CompanyNamesAndAddresses::CSV'
			 ,CSV(HEADING,SEPARATOR('|'))
			 ,OVERWRITE
			);

FileServices.DeSpray(
    'thumphrey::temp::sample_CompanyNamesAndAddresses::CSV'
		,'10.140.128.250'
    ,'/data/thumphrey/thumphrey/sample_CompanyNameAndAddresses_csv'
    ,-1,,,true
);
