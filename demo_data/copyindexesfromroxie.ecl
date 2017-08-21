import dops,ut,STD;
export copyindexesfromroxie(string datasetname,string certprtedate, string environment,string loc, string l_srcdali = '10.173.2.13') := function	

clusterprefix := '~';

datasetds := dops.GetRoxieKeys(datasetname,loc,environment,'N');

buildindex_rec := record,maxlength(30000)
	
	string cmd;
end;

buildindex_rec buildindex_code(datasetds l,integer cnt) := transform
	wordtoreplace := ut.Word(regexreplace('[\r\n]',l.logicalkey,''),1,'::');
	
	prteindex := if (regexfind('thor',wordtoreplace),regexreplace(datasetname+'_DATE',regexreplace(wordtoreplace,regexreplace('[\r\n]',l.logicalkey,''),'prte'),certprtedate),regexreplace(datasetname+'_DATE','prte::'+l.logicalkey,certprtedate));
	
	serv := 'server=http://10.241.20.202:8010 ';
		nsplit := ' nosplit=1 ';
		dstcluster := 'dstcluster=thor400_30 ';
		over := 'overwrite=1 ';
		repl := 'replicate=1 ';
		action := 'action=copy ';
		wrap := 'wrap=1 ';
		transferbuffersize := 'transferbuffersize=100000 ';
		connect := 'connect=200 ';
		
		srcname := 'srcname='+clusterprefix+prteindex + ' ';
		dstname := 'dstname=~'+prteindex + ' ';
		srcdali := 'srcdali='+l_srcdali+' ';
		self.cmd := serv + over + repl + action + dstcluster + dstname + srcname + nsplit + wrap + srcdali + transferbuffersize;
	
end;

prteds := project(datasetds,buildindex_code(left,counter));

return apply(global(prteds,few),
						STD.File.DfuPlusExec(cmd)
							);

end;