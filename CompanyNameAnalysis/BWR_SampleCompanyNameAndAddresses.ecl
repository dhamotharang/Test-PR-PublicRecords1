import NGBDL2, Business_Header;

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

my_biz_header := DATASET(
              '~thumphrey::base::business_header_qa',
	            business_header.Layout_Business_Header_Base, FLAT
						);


CompanyNameAndAddress_rec out_transform(business_header.Layout_Business_Header_Base l) := TRANSFORM
	 self := l;
END;

CompanyNamesAndAddresses := project(my_biz_header, out_transform(LEFT));

CompanyNamesAndAddressesDe := dedup(CompanyNamesAndAddresses, left.company_name = right.company_name);

sample_CompanyNamesAndAddressesDe := sample(CompanyNamesAndAddressesDe,4779,100000) : PERSIST('thumphrey::sample::CompanyNamesAndAddresses');

output(COUNT(CompanyNamesAndAddressesDe),NAMED('c_CompanyNamesAndAddressesDe'));

output(COUNT(sample_CompanyNamesAndAddressesDe),NAMED('c_sample_CompanyNamesAndAddressesDe'));
output(
       sample_CompanyNamesAndAddressesDe
			 ,
			 ,'thumphrey::temp::sample_CompanyNamesAndAddressesDe::CSV'
			 ,CSV(HEADING,SEPARATOR('|'))
			 ,OVERWRITE
			);

FileServices.DeSpray(
    'thumphrey::temp::sample_CompanyNamesAndAddressesDe::CSV'
		,'10.140.128.250'
    ,'/data/thumphrey/thumphrey/sample_CompanyNameAndAddressesDe_csv'
    ,-1,,,true
);

