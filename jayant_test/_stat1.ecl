inds:=uniqueSO_relative;
statTable1:=TABLE(inds,{inds.so_did,inds.st,relcount:=COUNT(GROUP),inds.re_st},inds.so_did,inds.st,inds.re_st, LOCAL);
statTable2:=TABLE(sort(statTable1,relcount),{relcount,SOcnt:=count(GROUP)},relcount);
//output(statTable2);
export _stat1 := statTable1;