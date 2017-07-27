voters := emerges.file_voters_base(active_status_mapped = '');
//output(voters);

layout_voters_slim := record
voters.active_status_mapped;
end;

voters_slim := table(voters, layout_voters_slim);

layout_voter_stat := record
voters_slim.active_status_mapped;
integer4 cnt := count(group);
end;

voter_stats := table(voters_slim, layout_voter_stat, active_status_mapped);

count(voter_stats);

layout_voter_stat_out := record
voters.active_status_mapped;
string9 cnt_out := ' ';
string1 lf := '\n';
end;

layout_voter_stat_out convert2out(voter_stats L) := transform
self := L;
self.cnt_out := intformat(L.cnt,9,1);
end;

voter_stat_out := project(voter_stats, convert2out(left));


output(voter_stat_out,,'thor_data400::out::voter_poliparty_stats',OVERWRITE);
