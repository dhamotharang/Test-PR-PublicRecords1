import tools,  lib_fileservices, STD;
#workunit('name','dataopsowner:reederkx Delete Corp Mapper Files');

currday := 	STD.Date.CurrentDate(True);
cutDay :=  STD.Date.AdjustDate(currday,0,0,+1);
state := 'al';
dsState := 	STD.FILE.LogicalFileList('thor_data400::in::corp2::'+ currday[1..3]+'*::*::'+state) ;
						
dsALL	:=	dsState;

dsDEL := dsALL(owner='kreeder_prod',(unsigned4)regexfind('[0-9]{8}', modified, 0) < cutDay);

output(currday);
output(cutday);
output(dsAll);
output(dsDEL); 

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
	
mySuperkeycontainers				:= nothor(global(project(dsDEL, tGetSuperOwners(left)),few));
output(mySuperkeycontainers,all);

FilesToDelete	:=	mySuperkeycontainers(dSubfileContainers[1].name = '');
output(FilesToDelete);

deleteOld := APPLY(FilesToDelete, STD.FILE.DeleteLogicalFile('~' +FilesToDelete.subfilename)); 

sequential( deleteOld );