import NGBDL2, Business_Header;

CompanyNames_rec := RECORD
  integer my_count;
	qstring120 company_name;
END;

my_biz_header := DATASET(
                          '~thumphrey::base::business_header_qa'
	                        , business_header.Layout_Business_Header_Base
													, FLAT
						);

CompanyNames_rec out_transform(business_header.Layout_Business_Header_Base l) := TRANSFORM
	 self.my_count := 1;
	 self := l;
END;

CompanyNames := project(my_biz_header, out_transform(LEFT));

sortedCompanyNames := sort(CompanyNames, company_name);

countedCompanyNames_rec := RECORD
  integer my_count;
	string company_name;
END;

CompanyNames_rec countCompanyNameOccurrences(CompanyNames_rec L, CompanyNames_rec R) := TRANSFORM
	 self.my_count := IF( L.company_name=R.Company_name, L.my_count+1, 1);
	 self := R;
END;

countedCompanyNames := rollup(
                               sortedCompanyNames
		  										     , LEFT.company_name=RIGHT.company_name
													     , countCompanyNameOccurrences(LEFT, RIGHT)
			  								     );
														 
output(COUNT(countedCompanyNames),NAMED('c_countedCompanyNames'));

FrequentCompanyNames := countedCompanyNames( my_count>=100);
output(COUNT(FrequentCompanyNames),NAMED('c_FrequentCompanyNames'));
output(sort(FrequentCompanyNames, company_name),NAMED('FrequentCompanyNames'));

output(
       FrequentCompanyNames
			 ,
			 ,'thumphrey::temp::FrequentCompanyNames::CSV'
			 ,CSV(HEADING,SEPARATOR('|'))
			 ,OVERWRITE
			);

FileServices.DeSpray(
    'thumphrey::temp::FrequentCompanyNames::CSV'
		,'10.140.128.250'
    ,'/data/thumphrey/thumphrey/FrequentCompanyNames_csv'
    ,-1,,,true
);

