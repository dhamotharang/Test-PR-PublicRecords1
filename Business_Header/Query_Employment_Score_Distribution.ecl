// People at Work Score Distribution
//paw := Business_Header.File_Employment_Out;
paw := Business_Header.File_Business_Contacts_Stats(NOT Business_Header.CheckUCC(source, company_name, fname, mname, lname, name_suffix));

layout_score := record
//unsigned1 score := (unsigned1)paw.score;
unsigned1 score := (unsigned1)paw.combined_score;
end;

paw_score := table(paw, layout_score);

layout_score_stat := record
paw_score.score;
cnt := count(group);
end;

paw_score_stat := table(paw_score, layout_score_stat, score, few);

output(paw_score_stat,all);