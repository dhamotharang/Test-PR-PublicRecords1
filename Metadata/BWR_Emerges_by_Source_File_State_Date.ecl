//Emerges by Source File State Date by John J. Bulten 20070530-20070612
//Using Jason's selections for best dates and hand-search for thresholds
//Selected thresholds: CCW, CENS, FISH 20; HUNT 30; VOTE 80 over two years
//And first date within each threshold year: W20070814-171756, W20070815-095713-111131
//LA Voters: W20071031-161718
//Change lastdatevote to lastdayvote: W20080409-103805

states_to_include := [
'AK','AL','AR','AZ','CA','CO','CT','DE','FL','GA',
'HI','IA','ID','IL','IN','KS','KY','LA','MA','MD',
'ME','MI','MN','MO','MS','MT','NC','ND','NE','NH',
'NJ','NM','NV','NY','OH','OK','OR','PA','RI','SC',
'SD','TN','TX','UT','VA','VT','WA','WI','WV','WY',
'DC','VI'];

d1 := 15010101;
d2 := 20070612;

dCCW  := emerges.file_hvccw_base(source_state IN states_to_include,file_id='CCW');
dCens := emerges.file_hvccw_base(source_state IN states_to_include,file_id='CENS');
dFish := emerges.file_hvccw_base(source_state IN states_to_include,file_id='FISH');
dHunt := emerges.file_hvccw_base(source_state IN states_to_include,file_id='HUNT');
dVote := emerges.file_hvccw_base(source_state IN states_to_include,file_id='VOTE');

rCCW := record
  dCCW.source;
  dCCW.file_id;
  dCCW.source_state;
  if((integer)dCCW.ccwexpdate between d1 and d2,dCCW.ccwexpdate,dCCW.ccwregdate);
  count(group);
end;

rCens := record
  dCens.source;
  dCens.file_id;
  dCens.source_state;
  dCens.regdate;
  count(group);
end;

rFish := record
  dFish.source;
  dFish.file_id;
  dFish.source_state;
  dFish.datelicense;
  count(group);
end;

rHunt := record
  dHunt.source;
  dHunt.file_id;
  dHunt.source_state;
  if((integer)dHunt.datelicense between d1 and d2,dVote.datelicense,dVote.regdate);
  count(group);
end;

rVote := record
  dVote.source;
  dVote.file_id;
  dVote.source_state;
  if((integer)dVote.regdate between d1 and d2,dVote.regdate,dVote.lastdayvote);
  count(group);
end;

output(choosen(table(dCCW,rCCW,source,file_id,source_state,
  if((integer)dCCW.ccwexpdate between d1 and d2,dCCW.ccwexpdate,dCCW.ccwregdate)),all));
output(choosen(table(dCens,rCens,source,file_id,source_state,regdate),10000));
output(choosen(table(dFish,rFish,source,file_id,source_state,datelicense),10000));
output(choosen(table(dHunt,rHunt,source,file_id,source_state,
  if((integer)dHunt.datelicense between d1 and d2,dHunt.datelicense,dHunt.regdate)),all));
output(choosen(table(dVote,rVote,source,file_id,source_state,
  if((integer)dVote.regdate between d1 and d2,dVote.regdate,dVote.lastdayvote)),all));

output(table(dCCW,{source_state,count(group),
  max(group,if((integer)dCCW.ccwexpdate between d1 and d2,dCCW.ccwexpdate,dCCW.ccwregdate))},source_state));
output(table(dCens,{source_state,count(group),max(group,dCens.regdate)},source_state));
output(table(dFish,{source_state,count(group),max(group,dFish.datelicense)},source_state));
output(table(dHunt,{source_state,count(group),
  max(group,if((integer)dHunt.datelicense between d1 and d2,dHunt.datelicense,dHunt.regdate))},source_state));
output(table(dVote,{source_state,count(group),
  max(group,if((integer)dVote.regdate between d1 and d2,dVote.regdate,dVote.lastdayvote))},source_state));