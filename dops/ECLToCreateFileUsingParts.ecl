import STD;
EXPORT ECLToCreateFileUsingParts(
											string infilename
											,string inlayout
											,string esp
											,string incluster) := function

	filename := regexreplace('~',infilename,'');
	dFileParts := sort(dops.GetFilePartInfo(filename,esp), partnumber) : independent;
	dMissingParts := sort(dops.GetXRef(esp).LostFiles(incluster)(name = filename),Num);
	
	sMaxPartNo := (string)count(dFileParts) : independent;
	
	rBuildECL := record,maxlength(30000)
		string eclstring;
	end;
	
	rBuildECL xBuildEcl(dFileParts l, dMissingParts r) := transform
		prefix := '/var/lib/HPCCSystems/hpcc-data/thor/';
		externalfilename := STD.File.ExternalLogicalFileName(l.node,prefix + '/' + regexreplace('::',filename,'/')+'._'+l.partnumber+'_of_'+sMaxPartNo);
		self.eclstring := 'dataset(\''+externalfilename+'\','+ inlayout +',flat) + ';
	end;
	
	dbuildECL := join(dFileParts
										,dMissingParts
										,(integer)left.partnumber = (integer)right.Num
										,xBuildEcl(left,right)
										,left only);
	
	totRecords := count(dbuildECL);
	
	rBuildECL xFinalECL(dbuildECL l, integer c) := transform
		self.eclstring := if (c = 1
													,'ds := ' + l.eclstring
													, if (c = totRecords
																,regexreplace('\\+',l.eclstring,'') + ';' + '\noutput(ds,,\'~'+filename+'_withoutmissingfileparts\', overwrite);'
																,l.eclstring
																)
													);
		
	end;
	
	dFinalECl := project(dbuildECL,xFinalECL(left,counter));
	
	return output(choosen(dFinalECl,all));
	
end;