EXPORT fn_company_name_prefix(string company_name) := //wanted to pass in unsigned1 numchars = 5, but that must already be known when we build the set_too_common
FUNCTION
import ut;
// return company_name[1..numchars];//old, simple behavior
set_too_common := ['MAIL ','FATCO','AIRGA','1ST C','PENTA','A T &','SOUTH','AMERI','FIRST','DATCU','INTER','NATIO','NORTH','THOR ','CITY ','LEGAC','CAPIT','NICHO','GREEN','THE N','SCHNE','DTG O','CITIZ','TGI F','CORNI','COSTC','UNITE','PINE ','TAMPA','WEST ','GREAT','COMMU','RIVER','THE C','STATE','PLUM ','ADVAN','NABIS','MERCH','BP PR','DAVID','SEVEN','HOUST','WILLI','MARRI','FRANK','CENTR','HOMES','ROBER','THE T','PINNA','BUSH ','JOHN ','THE P'];
//these are so common that they never do us any good
//so if it is too common, lets just jump over to the second word and try it instead
word1 := ut.Word(company_name, 1, ' ');
word2 := ut.Word(company_name, 2, ' ');
first5_too_common := company_name[1..5] in set_too_common;
word2_start_pos := length(word1) + 2;
pf :=
if(
  word2 <> '' AND first5_too_common,
  company_name[word2_start_pos..(word2_start_pos+4)],
  company_name[1..5]
);
return pf;
END;

