import 	BankruptcyV3;						

isFCRA := true;

bkSearchKey := pull(BankruptcyV3.key_bankruptcyv3_search_full_bip(isFCRA));

key_name := BankruptcyV3.BuildKeyName(isFCRA, 'search::tmsid_linkids');	

sc 	:= nothor(fileservices.superfilecontents(key_name)[1].name);

findex 	:= stringlib.stringfind(sc, '::20', 1)+2;

vKey :=  sc[findex..findex+7]:INDEPENDENT;

export buildversion := vKey;


