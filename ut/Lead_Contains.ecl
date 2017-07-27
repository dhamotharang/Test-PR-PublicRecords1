lb(string l, string r) := length(trim(l)) > length(trim(r));
export Lead_contains(string l, string r) := if(lb(l,r),r=l[1..length(trim(r))],l=r[1..length(trim(l))]);