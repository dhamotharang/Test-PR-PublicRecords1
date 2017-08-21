#workunit('name','Phonesplus Build Stats');
d  := Phonesplus.file_phonesplus_base;

below := d(ConfidenceScore < 11);
ct_below := count(below);
output(ct_below,named('ctBelow'));

above := d(ConfidenceScore > 10);
ct_above := count(above);
output(ct_above,named('ctAbove'));
//--------------------------------------------------------------

dd := dedup(d,CellPhone,all);

ddbelow := dd(ConfidenceScore < 11);
ddunq_below := count(below);
output(ddunq_below,named('unqBelow'));

ddabove := dd(ConfidenceScore > 10);
ddunq_above := count(ddabove);
output(ddunq_above,named('unqAbove'));
//--------------------------------------------------------------

stat_rec := record
below.sourcefile;
total := count(group);
end;

stat := table(below,stat_rec,sourcefile,few);
s_stat := sort(stat,sourcefile);
output(s_stat,all,named('BelowPerSource'));
//--------------------------------------------------------------
ddstat_rec := record
above.sourcefile;
total := count(group);
end;

ddstat := table(above,ddstat_rec,sourcefile,few);
dds_stat := sort(ddstat,sourcefile);
output(dds_stat,all,named('AbovePerSource'));
//--------------------------------------------------------------
ConfidenceScorestat_rec := record
d.ConfidenceScore;
total := count(group);
end;

ConfidenceScorestat := table(d,ConfidenceScorestat_rec,ConfidenceScore,few);
ConfidenceScores_stat := sort(ConfidenceScorestat,ConfidenceScore);
output(ConfidenceScores_stat,all);
//--------------------------------------------------------------

//output(count(d(TargusMatch > 0)));
//--------------------------------------------------------------

