import dops,_control;
export Proc_Copy_Keys_To_Alpha(string filedate) := function
	dsname := 'CodesV3Keys';
	ds := dops.GetRoxieKeys(dsname,'B','N','N');
	
	string_rec := record, maxlength(50000)
		string superkeys;
		string logicalkeys;
	end;
	
	string_rec replacedate(ds l) := transform
		string modfilename := regexreplace(dsname+'_DATE','~'+l.logicalkeys,filedate);
		string tempfilename := modfilename[1..length(modfilename)-1];
		self.superkeys := l.superkeys;
		self.logicalkeys := if(fileservices.fileexists(tempfilename),tempfilename,modfilename);
	end;
	
	tempds := project(ds,replacedate(left));
	
	outds := output(tempds,named('copyfiles'));//,'~thor_data400::out::'+dsname+'::alpha::copy',overwrite);
	ds1 := dataset(workunit('copyfiles'),string_rec);
	copyfiles := nothor(apply(ds1,if(fileservices.fileexists(logicalkeys),
							if(count(FileServices.logicalfilelist('*'+regexreplace('~',logicalkeys,'')+'*',,,,'10.194.12.1')) > 0,
							output(logicalkeys + ' already exists in 10.194.2.1'),
							sequential(output('Copying '+logicalkeys + ' to 10.194.12.2'),
							fileservices.Copy(logicalkeys,'thor400_64',logicalkeys,_control.IPAddress.prod_thor_dali,
												,'http://10.194.12.2:8010/FileSpray',,true,true))),
							output(logicalkeys+' does not exist'))
							));
	return sequential(outds,copyfiles);
	
end;