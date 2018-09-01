export	MAC_SF_BuildProcess(	thedataset,
															basename,
															seq_name,
															numgenerations = '3',
															csvout = 'false',
															pCompress = 'false',
															pVersion	=	'\'\'',
															pSeparator	=	'\',\'',
															pQuote	=	'\'"\'',
															pTerminator	=	'\'\\n\'',
															pHeading = '\'single\''
														)	:=
macro

/*
thedataset is the dataset to be written to disk
basename is 'base::xxxx'
numgenerations is currently to be just 2 or 3
*/

#uniquename(ng)
%ng% := (integer)numgenerations;

#uniquename(fileVersion)
%fileVersion%	:=	if(pVersion	!=	'',pVersion,thorlib.wuid());

#uniquename(todelete)
%todelete% := if(%ng% = 3,basename	+	'_Grandfather',basename	+	'_father');

#uniquename(sptr)
%sptr% := pSeparator;
#uniquename(qte)
%qte% := pQuote;
#uniquename(term)
%term% := pTerminator;
#uniquename(hdr)
%hdr% := pHeading;
//only works on resubmit
#uniquename(workalreadydone)
%workalreadydone%(string	sub)	:=	if(	pVersion	!=	'',
																				sub[((length(sub)-length(pversion))+1)..length(sub)]	=	pVersion,
																				sub[(length(sub)-14)..length(sub)] = thorlib.wuid()[2..16]
																			);	//output file was added to basename

seq_name	:=	if(	%ng%	not in	[2,3],
									fail('ut.MAC_SF_BuildProcess failure, numgenerations not in [2,3]'),
									if(	%workalreadydone%(FileServices.GetSuperFileSubName(basename,1)),
											output(basename	+	' work done in previous submission of this WU.'),
											sequential(	#if(csvout	!=	true)
																		#if(pCompress != true)
																			output(thedataset,,basename + '_'	+	%fileVersion%,overwrite),
																		#else
																			output(thedataset,,basename + '_'	+	%fileVersion%,overwrite,__compressed__),
																		#end
																	#else
																		#if(pCompress != true)
																			output(thedataset,,basename	+	'_'	+	%fileVersion%,           overwrite,csv(heading(#expand(%hdr%)),separator(%sptr%),quote(%qte%),terminator(%term%))),
																		#else
																			output(thedataset,,basename	+	'_'	+	%fileVersion%,compressed,overwrite,csv(heading(#expand(%hdr%)),separator(%sptr%),quote(%qte%),terminator(%term%))),
																		#end
																	#end
																	FileServices.StartSuperFileTransaction(),
																	FileServices.AddSuperFile(basename	+	'_Delete',%todelete%,,true),
																	#if(%ng%	=	3)
																		FileServices.ClearSuperFile(basename	+	'_Grandfather'),
																		FileServices.AddSuperFile(basename	+	'_Grandfather',basename	+	'_father',,true),
																	#end
																	FileServices.ClearSuperFile(basename	+	'_father'),
																	FileServices.AddSuperFile(basename	+	'_father',basename,,true),
																	FileServices.ClearSuperFile(basename),
																	FileServices.AddSuperFile(basename,basename	+	'_'	+	%fileVersion%), 
																	FileServices.FinishSuperFileTransaction(),
																	FileServices.RemoveOwnedSubFiles(basename	+	'_Delete',true)
																)
										)
								);
endmacro;