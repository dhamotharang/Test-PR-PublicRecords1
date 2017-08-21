import hygenics_crim;

EXPORT fn_OffenseLevCheck(string poffensedegree, string poffensetype, string poffenseclass, String psourcename, string pcasetype, string temp_offense, string pfinaloffense,string temp_case_number,string pclassification_code) := function

pvendor:= hygenics_crim._functions.fn_sourcename_to_vendor(psourcename, '');

result:=hygenics_crim._fns_offenseLev.court_off_lev(poffensedegree,poffensetype,poffenseclass,pvendor,psourcename,pcasetype,temp_offense,pfinaloffense,temp_case_number,pclassification_code);

return if(result='' and poffensedegree<>'' and poffensetype<>'' and poffenseclass<>'',0,1);

end;