import dops,_Control,STD;
// datasetname = get dataset name from DOPS
// environment = 'Q' - QA/Cert Roxie; 'P' - Prod Roxie
// loc = 'B' - Boca; 'A' - Alpharetta
// roxiedali = roxie dali IP to pull files from
// thorclustertocopy = thor clustername IMPORTANT: DO NOT USE HTHOR
// thoresp = thor eclwatch
export CopyKeysFromRoxie(string datasetname
														,string versiontocopy
														,string environment
														,string loc
														,string roxiedali
														,string thorclustertocopy
														,string thoresp = _Control.IPAddress.prod_thor_esp) := function	

clusterprefix := '~';

datasetds := dops.GetRoxieKeys(datasetname,loc,environment,'N');

buildindex_rec := record,maxlength(30000)
	
	string cmd;
end;

buildindex_rec buildindex_code(datasetds l,integer cnt) := transform
	//wordtoreplace := ut.Word(regexreplace('[\r\n]',l.logicalkey,''),1,'::');
	
	prteindex := regexreplace(datasetname+'_DATE',l.logicalkey,versiontocopy,nocase);
	
	serv := 'server=http://'+thoresp+':8010 ';
		nsplit := ' nosplit=1 ';
		dstcluster := 'dstcluster=' +thorclustertocopy+ ' ';
		over := 'overwrite=1 ';
		repl := 'replicate=1 ';
		action := 'action=copy ';
		wrap := 'wrap=1 ';
		transferbuffersize := 'transferbuffersize=100000 ';
		connect := 'connect=200 ';
		
		srcname := 'srcname='+clusterprefix+prteindex + ' ';
		dstname := 'dstname=~'+prteindex + ' ';
		srcdali := 'srcdali='+roxiedali + ' ';
		self.cmd := serv + over + repl + action + dstcluster + dstname + srcname + nsplit + wrap + srcdali + transferbuffersize;
	
end;

prteds := project(datasetds,buildindex_code(left,counter));

return apply(global(prteds,few),
						STD.File.DfuPlusExec(cmd)
							);

end;