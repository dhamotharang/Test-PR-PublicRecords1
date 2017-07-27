// mbld is to be used in conjunction with ut.MAC_SK_Move_v2 option 'QM' for a multi-build option.
//*Header in Header.build_source_key is the only build using this option
export	Mac_SK_Move_to_Built_v2(superkeyname,lkeyname,seq_name,one_node = 'false',diffing = 'false',mbld = 'false')	:=
macro

#uniquename(todelete)
%todelete%	:=	RoxieKeybuild.Check_Replace_Version(superkeyname,'built');

#uniquename(deleted)
%deleted%	:=	RoxieKeybuild.Check_Replace_Version(superkeyname,'delete');

#uniquename(superdiffname)
%superdiffname%	:=	RoxieKeybuild.Check_Replace_Version(lkeyname,'diff');

#uniquename(difftodelete)
%difftodelete%	:=	RoxieKeybuild.Check_Replace_Version(lkeyname,'diff::built');

#uniquename(diffdeleted)
%diffdeleted%	:=	RoxieKeybuild.Check_Replace_Version(lkeyname,'diff::delete');

#uniquename(inqa)
%inqa%	:=	RoxieKeybuild.Check_Replace_Version(superkeyname,'qa');


#uniquename(workalreadydone)
%workalreadydone%(string	sub) :=	sub	=	lkeyname;	//output key was added to superkey

seq_name	:=	sequential(	if(~fileservices.superfileexists(%deleted%),fileservices.createsuperfile(%deleted%)),
													if(~fileservices.superfileexists(%todelete%),fileservices.createsuperfile(%todelete%)),
													if(~fileservices.superfileexists(%inqa%),fileservices.createsuperfile(%inqa%)),
													if(mbld and ~fileservices.superfileexists(%todelete%+'1'),fileservices.createsuperfile(%todelete%+'1')),
													if(mbld and ~fileservices.superfileexists(%todelete%+'2'),fileservices.createsuperfile(%todelete%+'2')),
													if(mbld and ~fileservices.superfileexists(%todelete%+'3'),fileservices.createsuperfile(%todelete%+'3')),
													if(mbld and ~fileservices.superfileexists(%todelete%+'4'),fileservices.createsuperfile(%todelete%+'4')),
													if(diffing	and	~fileservices.superfileexists(%diffdeleted%),fileservices.createsuperfile(%diffdeleted%)),
													if(diffing	and	~fileservices.superfileexists(%difftodelete%),fileservices.createsuperfile(%difftodelete%)),
													if(	mbld,
														if(%workalreadydone%('~'+FileServices.GetSuperFileSubName(%todelete%,1))
														or %workalreadydone%('~'+FileServices.GetSuperFileSubName(%todelete%+'1',1))
														or %workalreadydone%('~'+FileServices.GetSuperFileSubName(%todelete%+'2',1))
														or %workalreadydone%('~'+FileServices.GetSuperFileSubName(%todelete%+'3',1))
														or %workalreadydone%('~'+FileServices.GetSuperFileSubName(%todelete%+'4',1))
														or %workalreadydone%('~'+FileServices.GetSuperFileSubName(%inqa%,1))
																,output(superkeyname + ' work done in previous submission of this WU.')
																,sequential(FileServices.StartSuperFileTransaction()
																						,if(FileServices.GetSuperFileSubName(%todelete%,1)=''
																							,FileServices.AddSuperFile(%todelete%,lkeyname)
																							,if(FileServices.GetSuperFileSubName(%todelete%+'1',1)=''
																								,FileServices.AddSuperFile(%todelete%+'1',lkeyname)
																								,if(FileServices.GetSuperFileSubName(%todelete%+'2',1)=''
																									,FileServices.AddSuperFile(%todelete%+'2',lkeyname)
																									,if(FileServices.GetSuperFileSubName(%todelete%+'3',1)=''
																										,FileServices.AddSuperFile(%todelete%+'3',lkeyname)
																										,if(FileServices.GetSuperFileSubName(%todelete%+'4',1)=''
																											,FileServices.AddSuperFile(%todelete%+'4',lkeyname)
																											,output('Too many builds to maintain.  Please, delete the oldest one')
																								)))))
																						,FileServices.FinishSuperFileTransaction()
																					)
															)
														),
														if(~mbld,
															if(%workalreadydone%('~'+FileServices.GetSuperFileSubName(%todelete%,1))
															or %workalreadydone%('~'+FileServices.GetSuperFileSubName(%inqa%,1)),
																output(superkeyname + ' work done in previous submission of this WU.'),
																sequential(	FileServices.StartSuperFileTransaction(),
																						FileServices.AddSuperFile(%deleted%,%todelete%,,true),
																						if(diffing,FileServices.AddSuperFile(%diffdeleted%,%difftodelete%,,true)),
																						FileServices.ClearSuperfile(%todelete%),
																						FileServices.AddSuperFile(%todelete%,lkeyname),
																						if(diffing,FileServices.ClearSuperfile(%difftodelete%)),
																						if(diffing,FileServices.AddSuperFile(%difftodelete%,%superdiffname%)),
																						FileServices.FinishSuperFileTransaction(),
																						Fileservices.RemoveOwnedSubFiles(%deleted%,true),
																						Fileservices.clearsuperfile(%deleted%), // this is needed because removeownedsubfiles does not clear super if owned by another super
																						
																						if(diffing,FileServices.RemoveOwnedSubFiles( %diffdeleted%,true))
																					)
															)
														)
												);
endmacro;