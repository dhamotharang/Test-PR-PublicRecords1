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
output(count(dd(TDSMatch > 0)),named('UniqueTDSMatchCount'));
output(count(dd(PortMatch > 0)),named('UniquePortMatchCount'));

ddbelow := dedup(d(ConfidenceScore < 11),cellphone,all);
ddunq_below := count(below);
output(ddunq_below,named('unqBelow'));

ddabove := dedup(d(ConfidenceScore > 10),cellphone,all);
ddunq_above := count(ddabove);
output(ddunq_above,named('unqAbove'));
//--------------------------------------------------------------
layout_state:= record
ddabove.state;
total := count(group);
end;

stateStat := sort(table(ddabove,layout_state,state,few),state);

output(stateStat,named('unqAbovePerState'));
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

dd_d  := dedup(d(regexfind('[a-zA-Z]',vendor) = false),cellphone,all);

output(count(dd_d),named('TotalUniqueCellPhones'));

