#workunit('Name','Big test of isVanityName');

import CompanyNameAnalysis;

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
output(COUNT(sample_CompanyNamesAndAddresses),NAMED('c_sample_CompanyNamesAndAddresses'));

seqed_company_names_rec := RECORD
  string company_name;
	integer sequence_no;
END;

seqed_company_names_rec sequencer(CompanyNameAndAddress_rec l, C) := transform
 self.sequence_no := C;
 self := l;
end;

seqed_company_names_ds := project(sample_CompanyNamesAndAddresses, sequencer(left, counter));
output(COUNT(seqed_company_names_ds),NAMED('c_seqed_company_names_ds'));

CompanyNameAnalysis.MAC_isVanityName(seqed_company_names_ds, company_name, vanity_company_names, company_name_token_patterns);

output(COUNT(company_name_token_patterns),NAMED('c_company_name_token_patterns'));
output(COUNT(vanity_company_names),NAMED('c_vanity_company_names'));

varstring token_patterns_filename := 'thumphrey::temp::company_name_token_patterns::XML';
// Output and deSpray company names and their token patterns
output(
       company_name_token_patterns
			 ,
			 ,token_patterns_filename
			 ,XML
			 ,OVERWRITE
			);

varstring vanity_filename := 'thumphrey::temp::vanity_company_names::XML';

// Output and deSpray vanity company names
output(
       vanity_company_names
			 ,
			 ,vanity_filename
			 ,XML
			 ,OVERWRITE
			);