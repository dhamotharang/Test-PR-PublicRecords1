glb_cand := project(Did_Rules0(header.match_candidates).result,header.Layout_PairMatch);

outfile := header.fn_Did_Rules1(glb_cand);

export Did_Rules1 := outfile : persist('Did_Rules1');