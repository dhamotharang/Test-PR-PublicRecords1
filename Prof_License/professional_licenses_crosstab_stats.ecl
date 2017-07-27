import Prof_License;

outf := Prof_License.File_Doxie;

d := distribute(outf,hash(source_st + profession_or_board + license_type));

stat_rec :=  record
'professional_licenses';
d.source_st,
d.profession_or_board,
d.license_type,
date_200301 := count(group,d.date_first_seen[1..6]='200301');
date_200302 := count(group,d.date_first_seen[1..6]='200302');
date_200303 := count(group,d.date_first_seen[1..6]='200303');
date_200304 := count(group,d.date_first_seen[1..6]='200304');
date_200305 := count(group,d.date_first_seen[1..6]='200305');
date_200306 := count(group,d.date_first_seen[1..6]='200306');
date_200307 := count(group,d.date_first_seen[1..6]='200307');
date_200308 := count(group,d.date_first_seen[1..6]='200308');
date_200309 := count(group,d.date_first_seen[1..6]='200309');
date_200310 := count(group,d.date_first_seen[1..6]='200310');
date_200311 := count(group,d.date_first_seen[1..6]='200311');
date_200312 := count(group,d.date_first_seen[1..6]='200312');
date_200401 := count(group,d.date_first_seen[1..6]='200401');
date_200402 := count(group,d.date_first_seen[1..6]='200402');
date_200403 := count(group,d.date_first_seen[1..6]='200403');
date_200404 := count(group,d.date_first_seen[1..6]='200404');
date_200405 := count(group,d.date_first_seen[1..6]='200405');
date_200406 := count(group,d.date_first_seen[1..6]='200406');
date_200407 := count(group,d.date_first_seen[1..6]='200407');
date_200408 := count(group,d.date_first_seen[1..6]='200408');
date_200409 := count(group,d.date_first_seen[1..6]='200409');
date_200410 := count(group,d.date_first_seen[1..6]='200410');
date_200411 := count(group,d.date_first_seen[1..6]='200411');
date_200412 := count(group,d.date_first_seen[1..6]='200412');
date_200501 := count(group,d.date_first_seen[1..6]='200501');
date_200502 := count(group,d.date_first_seen[1..6]='200502');
date_200503 := count(group,d.date_first_seen[1..6]='200503');
date_200504 := count(group,d.date_first_seen[1..6]='200504');
date_200505 := count(group,d.date_first_seen[1..6]='200505');
date_200506 := count(group,d.date_first_seen[1..6]='200506');
date_200507 := count(group,d.date_first_seen[1..6]='200507');
date_200508 := count(group,d.date_first_seen[1..6]='200508');
date_200509 := count(group,d.date_first_seen[1..6]='200509');
date_200510 := count(group,d.date_first_seen[1..6]='200510');
date_200511 := count(group,d.date_first_seen[1..6]='200511');
date_200512 := count(group,d.date_first_seen[1..6]='200512');
end;

stats := table(d,stat_rec,source_st,profession_or_board,license_type,few);

output(choosen(stats,10000));