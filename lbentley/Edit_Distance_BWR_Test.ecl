dedit1s				:= lbentley.Edit_Distance_Baseline().dedit1;
countdedit1s	:= count(dedit1s);
dedit2s				:= lbentley.Edit_Distance_Baseline().dedit2;
countdedit2s	:= count(dedit2s);

dnewedit1s				:= lbentley.Edit_Distance_NewBaseLine().dedit1s;
countdnewedit1s		:= count(dnewedit1s);
dnewedit2s				:= lbentley.Edit_Distance_NewBaseLine().dedit2s;
countdnewedit2s		:= count(dnewedit2s);

dedit1s_table := sort(table(dnewedit1s	,{iter	,unsigned8 cnt := count(group)	,real8 pct	:= count(group) / countdedit1s * 100.0}	,iter,few),iter);
dedit2s_table := sort(table(dnewedit2s	,{iter	,unsigned8 cnt := count(group)	,real8 pct	:= count(group) / countdedit2s * 100.0}	,iter,few),iter);

dMissingEdit1s := join(dedit1s	,dnewedit1s	,left.company_name1 = right.company_name1 and left.company_name2 = right.company_name2	,transform(recordof(left),self := left),left only);
dMissingEdit2s := join(dedit2s	,dnewedit2s	,left.company_name1 = right.company_name1 and left.company_name2 = right.company_name2	,transform(recordof(left),self := left),left only);

output(enth(dedit1s	,500)	,named('dedit1s'),all);
output(countdedit1s				,named('countdedit1s'),all);
output(enth(dedit2s	,500)	,named('dedit2s'),all);
output(countdedit2s				,named('countdedit2s'),all);

output(enth(dnewedit1s	,500)	,named('dnewedit1s'),all);
output(countdnewedit1s				,named('countdnewedit1s'),all);
output(enth(dnewedit2s	,500)	,named('dnewedit2s'),all);
output(countdnewedit2s				,named('countdnewedit2s'),all);

output(dedit1s_table	,named('dedit1s_table'));
output(dedit2s_table	,named('dedit2s_table'));

output(countdnewedit1s / countdedit1s * 100.0	,named('dPctEdit1s'));
output(countdnewedit2s / countdedit2s * 100.0	,named('dPctEdit2s'));

output(enth(dMissingEdit1s	,500)	,named('dMissingEdit1s'),all);
output(enth(dMissingEdit2s	,500)	,named('dMissingEdit2s'),all);
