import doxie;
rels := sort(group(doxie.relative_summary(~relative)), person2, if(aka, 0, 1), -cnt);
export associate_summary := dedup(rels, person2);