bushdr	:= business_header.File_Business_Header(fein != 0);

btable := dedup(bushdr, fein, bdid, company_name, all);

btable_dedup := table(btable, {fein, company_name, unsigned8 cnt := count(group)}, fein, company_name);

btable2 := table(btable_dedup, {fein, unsigned8 cnt := count(group)}, fein) : persist('~thor_data400::persist::lbentley::bug_30999');

filter_baddies := btable2(regexfind('([[:digit:]])\\1\\1\\1\\1\\1\\1|([[:digit:]]{3})\\2\\2', (string)fein, nocase));

top500 := topn(filter_baddies, 500, -cnt);

output(top500, ,named('TopFeinsAcrossCompanyNamesCount'), all);

top500set := set(top500, fein);

bestbadfeins := business_header.files().base.business_header_best.qa(fein in top500set);

bestbadfeins_deduped := table(bestbadfeins, {fein, company_name}, fein, company_name);

output(bestbadfeins_deduped, named('BadFeins'), all);


//