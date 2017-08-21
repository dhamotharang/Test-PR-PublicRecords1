#option('outputLimit', 100);

f := Business_Risk.BDID_Risk_Table;

count(f);
output(f(bdid=18039411));

layout_score := record
f.PRScore;
end;

fslim := table(f, layout_score);

layout_stat := record
fslim.PRScore;
cnt := count(group);
end;

fstat := table(fslim, layout_stat, PRScore, few);

output(fstat, all);

output(enth(f(PRScore = 100),100) +
enth(f(PRScore = 95),100) +
enth(f(PRScore = 90),100) +
enth(f(PRScore = 85),100) +
enth(f(PRScore = 80),100) +
enth(f(PRScore = 75),100) +
enth(f(PRScore = 70),100) +
enth(f(PRScore = 65),100) +
enth(f(PRScore = 60),100) +
enth(f(PRScore = 55),100) +
enth(f(PRScore = 50),100),all);

