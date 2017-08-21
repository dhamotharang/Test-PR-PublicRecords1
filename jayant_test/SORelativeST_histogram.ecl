intable:=sort(distribute(_stat1,HASH(_stat1.st)),_stat1.st,_stat1.re_st,local);
statTable2 := TABLE(intable,{intable.st,intable.re_st,relstcnt:=COUNT(GROUP)},intable.st,intable.re_st,LOCAL);

export SORelativeST_histogram := sort(statTable2,statTable2.st,statTable2.re_st,FEW) : persist('SO_relativeST_histogram');
