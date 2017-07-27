import Business_Header;
import text;

// BWR_MakeAndDeSprayBusinessHeaderSample.ecl
bh:=distribute(Business_Header.File_Business_Header,hash64(company_name));
output(count(bh),named('size_of_bh'));

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

CompanyNamesAndAddresses := project(bh, CompanyNameAndAddress_rec);

CompanyNamesAndAddressesDe := dedup(sort(CompanyNamesAndAddresses,company_name,local), left.company_name = right.company_name, local);

biterm_populated_cities1 := CompanyNameAnalysis.biterm_populated_cities;
multi_term_cities0 := CompanyNameAnalysis.multi_term_cities;
long_1term_cities1 := CompanyNameAnalysis.long_1term_cities;
pattern city := ( biterm_populated_cities1 | multi_term_cities0 | long_1term_cities1 );

StateAbbr1 := CompanyNameAnalysis.StateAbbr;
my_full_state_name1 := CompanyNameAnalysis.my_full_state_name;
pattern state := ( StateAbbr1 | my_full_state_name1 );

pattern zip := repeat( text.Digit, 5) opt( '-' repeat(text.Digit,4) );

pattern runon_address := city state opt(' ' zip) opt(' '+) LAST;

CompanyNameAndAddress_rec getConamesContainingRunonAddresses(CompanyNameAndAddress_rec c)
      := TRANSFORM
  SELF := c;
END;

CompanyNamesWithRunonAddresses := 
      PARSE(
             CompanyNamesAndAddressesDe
             ,company_name
             ,runon_address
             ,getConamesContainingRunonAddresses(left)
             ,FIRST
           ) : PERSIST('thumphrey::RunonAddresses::CompanyNames');

output(count(CompanyNamesWithRunonAddresses),named('size_of_CompanyNamesWithRunonAddresses'));
output(CompanyNamesWithRunonAddresses,named('CompanyNamesWithRunonAddresses'));

output(
       CompanyNamesWithRunonAddresses
       ,
       ,'thumphrey::temp::RunonAddresses::CompanyNames_CSV'
       ,CSV(HEADING,SEPARATOR('|'))
       ,OVERWRITE
      );
