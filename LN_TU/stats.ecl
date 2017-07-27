d := distribute(ln_tu.File_In_Header_2001_part2,hash(orig_state));

stat_rec :=  record
d.orig_state;
d.orig_record_type;
total := count(group);
end;

stats := table(d,stat_rec,orig_state,orig_record_type);

output(stats)