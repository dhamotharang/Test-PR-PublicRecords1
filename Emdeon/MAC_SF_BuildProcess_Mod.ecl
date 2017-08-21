/*2010-05-06T15:11:04Z (Krishna Gummadi)

*/
EXPORT	MAC_SF_BuildProcess_Mod(	thedataset,
															basename,
															seq_name,
															numgenerations = '3',
															csvout = 'FALSE',
															pCompress = 'FALSE',
															pVersion	=	'\'\'',
															pSeparator	=	'\',\''
														)	:=
MACRO

/*
thedataset is the dataset to be written to disk
basename is 'base::xxxx'
numgenerations is currently to be just 2 or 3
*/

#UNIQUENAME(ng)
%ng% := (INTEGER)numgenerations;

#UNIQUENAME(fileVersion)
%fileVersion%	:=	IF(pVersion	!=	'',pVersion,thorlib.wuid());

#UNIQUENAME(todelete)
%todelete% := IF(%ng% = 3,basename	+	'_Grandfather',basename	+	'_father');

#UNIQUENAME(sptr)
%sptr% := pSeparator;

//only works on resubmit
#UNIQUENAME(workalreadydone)


%workalreadydone%(STRING	sub) := 

	IF(	pVersion	!=	'',
				SUB[((LENGTH(sub)-LENGTH(pversion))+1)..LENGTH(sub)] =	pVersion,
				SUB[(LENGTH(sub)-14)..LENGTH(sub)] = thorlib.wuid()[2..16]
			);	//OUTPUT file was added to basename

seq_name	:=	IF(	%ng% NOT IN [2,3],
									FAIL('ut.MAC_SF_BuildProcess failure, numgenerations NOT in [2,3]'),
									IF(	%workalreadydone%(FileServices.GetSuperFileSubName(basename,1)),
											OUTPUT(basename	+	' work done in previous submission of this WU. ' + pVersion),
											SEQUENTIAL(	#IF(csvout	!=	TRUE)
																		#IF(pCompress != TRUE)
																			OUTPUT(thedataset,,basename + '_'	+	%fileVersion%,overwrite),
																		#ELSE
																			OUTPUT(thedataset,,basename + '_'	+	%fileVersion%,overwrite,__compressed__),
																		#END
																	#ELSE
																		#IF(pCompress != TRUE)
																			OUTPUT(thedataset,,basename	+	'_'	+	%fileVersion%,overwrite,CSV(separator(%sptr%),quote(''))),
																		#ELSE
																			OUTPUT(thedataset,,basename	+	'_'	+	%fileVersion%,compressed,overwrite,CSV(separator(%sptr%),quote(''))),
																		#END
																	#END
																	FileServices.StartSuperFileTransaction(),
																	FileServices.AddSuperFile(basename	+	'_Delete',%todelete%,,TRUE),
																	#IF(%ng%	=	3)
																		FileServices.ClearSuperFile(basename	+	'_Grandfather'),
																		FileServices.AddSuperFile(basename	+	'_Grandfather',basename	+	'_father',,TRUE),
																	#END
																	FileServices.ClearSuperFile(basename	+	'_father'),
																	FileServices.AddSuperFile(basename	+	'_father',basename,,TRUE),
																	FileServices.ClearSuperFile(basename),
																	FileServices.AddSuperFile(basename,basename	+	'_'	+	%fileVersion%), 
																	FileServices.FinishSuperFileTransaction(),
																	FileServices.RemoveOwnedSubFiles(basename	+	'_Delete',TRUE),
																	FileServices.ClearSuperFile(basename	+	'_Delete')
																)
										)
								);
ENDMACRO;