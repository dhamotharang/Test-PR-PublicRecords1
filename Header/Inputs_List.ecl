import ut, lib_stringlib, lib_fileservices;

rWithSuperFileName
 :=
  record, maxlength(10000)
	FsLogicalFileNameRecord;
	dataset(FsLogicalFileNameRecord) SubFileName;
  end
 ;

dHeaderBuildingSuperFiles		:= FileServices.LogicalFileList('*base::*header_building',false,true);

/*Added to capture Orbit entries*/
dOtherFiles := 	FileServices.LogicalFileList('thor_data400::base::watchdog_best',false,true)
							+ FileServices.LogicalFileList('thor_data400::key::new_suppression::qa::link_type_link_id',false,true)
							;


dHeaderBuildingSuperFilesNoBiz	:=	dHeaderBuildingSuperFiles(StringLib.StringFind(Name,'business',1)=0
                                                          and StringLib.StringFind(Name,'base::ebr',1)=0
                                                          and StringLib.StringFind(Name,'quickheader',1)=0
                                                          and StringLib.StringFind(Name,'base::propd',1)=0
                                                          and StringLib.StringFind(Name,'base::propa',1)=0
                                                          and StringLib.StringFind(Name,'base::props',1)=0
                                                          and StringLib.StringFind(Name,'fcra',1)=0
                                                          and StringLib.StringFind(Name,'experianwpheader',1)=0
                                                          and StringLib.StringFind(Name,'tucreditheader',1)=0
														     )
						          + dOtherFiles
								  ;

rWithSuperFileName	tPreLoadSuperFileNames(dHeaderBuildingSuperFilesNoBiz pInput)
 :=
  transform
	self.Name			:=	pInput.Name[1..100];
	self.SubFileName	:=	Lib_FileServices.FileServices.SuperFileContents('~' + pInput.Name,true)[count(Lib_FileServices.FileServices.SuperFileContents('~' + pInput.Name,true))-50..];
  end
 ;

dPreLoadSuperFileNames	:=	nothor(project(dHeaderBuildingSuperFilesNoBiz,tPreLoadSuperFileNames(left)));
export Inputs_List		:=	output(sort(dPreLoadSuperFileNames,name),all,named('Header_Inputs'));