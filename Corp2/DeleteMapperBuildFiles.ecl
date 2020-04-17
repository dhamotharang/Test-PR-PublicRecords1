import tools,  lib_fileservices, STD;
state := '*';
#workunit('name','dataopsowner:reederkx Delete ' + state + ' old Corp Mapper Files');

currday := 	STD.Date.CurrentDate(True);
cutDay :=  STD.Date.AdjustDate(currday,0,-2,0);

//dsState := 	STD.FILE.LogicalFileList('thor_data400::in::corp2::'+ currday[1..3]+'*::*::'+state) ;
dsState := 	STD.FILE.LogicalFileList('thor_data400::in::corp2::20*'+state) ;

dsBuild	:= 	STD.FILE.LogicalFileList('thor_data400::in::corp2::'+ currday[1..2]+'*::main_'+state) + 
						STD.FILE.LogicalFileList('thor_data400::in::corp2::'+ currday[1..2]+'*::ar_'+state) + 
						STD.FILE.LogicalFileList('thor_data400::in::corp2::'+ currday[1..2]+'*::stock_'+state) +
						STD.FILE.LogicalFileList('thor_data400::in::corp2::'+ currday[1..2]+'*::event_'+state);
						
		

dsSprayLogs := STD.FILE.LogicalFileList('thor_data400::spraylogs::corp2::20*'+state) ;
						

dsALLSt	:=	dsBuild;
OwnerSet := ['svc_dly_srv_acct','kreeder_prod'];
IsOwnerStatus := dsALLSt.owner IN OwnerSet;


//this is the dataset
dsDEL1 := dsALLSt(IsOwnerStatus,(unsigned4)regexfind('[0-9]{8}', modified, 0) < cutDay);
dsDEL2 := dsBuild(IsOwnerStatus,(unsigned4)regexfind('[0-9]{8}', modified, 0) < cutDay);
dsDEL3 := dsSprayLogs(IsOwnerStatus,(unsigned4)regexfind('[0-9]{8}', modified, 0) < cutDay);


output((currday),named('currentDay'));
output((cutday),named('cutOffDay'));;
output(count(dsALLSt),named('CountallOldState'));
output((dsALLSt),named('allOldState'));
output((dsDEL1),named('delStateAsOwn')); 
output((dsBuild),named('allOldBuild'));
output((dsDEL2),named('delBuildAsOwn')); 

LayoutNames	:=	lib_fileservices.FsLogicalFileNameRecord;

NewLayout	:=	record
		string								subfilename;
		boolean								doessubfileexist;
		DATASET(LayoutNames)	dSubfileContainers;
end;

NewLayout tGetSuperOwners(LayoutNames l) := transform
		self.subfilename				:= if(l.name[1] != '~', '~' + l.name, l.name);
		self.doessubfileexist		:= fileservices.fileexists(self.subfilename);
		self.dSubfileContainers	:= if(self.doessubfileexist
		,fileservices.LogicalFileSuperOwners(self.subfilename)
		,dataset([], LayoutNames)
															);
end;
	
myStateSuperkeycontainers				:= nothor(global(project(dsDEL1, tGetSuperOwners(left)),few));
output(myStateSuperkeycontainers,all);
myBuildSuperkeycontainers				:= nothor(global(project(dsDEL2, tGetSuperOwners(left)),few));
output(myBuildSuperkeycontainers,all);


StateFilesToDelete	:=	myStateSuperkeycontainers(dSubfileContainers[1].name = '');
output((StateFilesToDelete),named('StateFilesToDelete'));

BuildFilesToDelete	:=	myBuildSuperkeycontainers(dSubfileContainers[1].name = '');
output((BuildFilesToDelete),named('BuildFilesToDelete'));

deleteOldState := APPLY(StateFilesToDelete, STD.FILE.DeleteLogicalFile('~' +StateFilesToDelete.subfilename)); 
deleteOldBuild := APPLY(BuildFilesToDelete, STD.FILE.DeleteLogicalFile('~' +BuildFilesToDelete.subfilename)); 
sequential( deleteOldState );
sequential( deleteOldBuild );