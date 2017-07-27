dsorig  := dataset('~thor_data400::bipv2_sele::building::20140217' ,BIPV2.CommonBase.Layout,flat);
dsorigA := dataset('~thor_data400::bipv2_sele::building::20140217a',BIPV2.CommonBase.Layout,flat);
dsorigB := bipv2.CommonBase.DS_CLEAN;

dsbase  := table(dsorig ,{DotID,EmpID,POWID,ProxID,SELEID,LGID3,OrgID,UltID}) : independent;
dsbaseA := table(dsorigA,{DotID,EmpID,POWID,ProxID,SELEID,LGID3,OrgID,UltID}) : independent;
dsbaseB := table(dsorigB,{DotID,EmpID,POWID,ProxID,SELEID,LGID3,OrgID,UltID}) : independent;

dspops  := project(strata.macf_pops(dsbase ),transform({string file, recordof(left)},self.file := '20140217' ,self := left));
dspopsA := project(strata.macf_pops(dsbaseA),transform({string file, recordof(left)},self.file := '20140217a',self := left));
dspopsB := project(strata.macf_pops(dsbaseB),transform({string file, recordof(left)},self.file := '20140217b',self := left));

output(dspops + dspopsA + dspopsB ,named('Pops'));

dsuniquess  := project(strata.macf_uniques(dsbase ),transform({string file, recordof(left)},self.file := '20140217' ,self := left));
dsuniquessA := project(strata.macf_uniques(dsbaseA),transform({string file, recordof(left)},self.file := '20140217a',self := left));
dsuniquessB := project(strata.macf_uniques(dsbaseB),transform({string file, recordof(left)},self.file := '20140217b',self := left));

output(dsuniquess + dsuniquessA + dsuniquessB ,named('Uniques'));