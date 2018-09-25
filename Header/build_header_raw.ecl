import ut,mdr,PromoteSupers;
export build_header_raw(string filedate = Header.version_build,boolean incremental = FALSE) := function

h:=distribute(header.Header_Joined(filedate).final,hash(did));

basename:='~thor_data400::base::header_raw';
basenamei:='~thor_data400::base::header_raw_incremental';
fname:=basename+'_'+filedate;

s1:=output(h,,fname,compressed);

built:=basename+'_built';
prod:=basename+'_prod';
workalreadydone(string	sub) :=	sub	=	fname;

d:=dataset([{fname}],{string75 lfn});
PromoteSupers.MAC_SF_BuildProcess(d,'~thor_data400::flag::header_raw',PostUpdate,3,,true,pVersion:=filedate);

s2:=parallel(
						if(~fileservices.superfileexists(built),fileservices.createsuperfile(built))
						,if(~fileservices.superfileexists(built+'1'),fileservices.createsuperfile(built+'1'))
						,if(~fileservices.superfileexists(built+'2'),fileservices.createsuperfile(built+'2'))
						,if(~fileservices.superfileexists(built+'3'),fileservices.createsuperfile(built+'3'))
						,if(~fileservices.superfileexists(built+'4'),fileservices.createsuperfile(built+'4'))
						);

s3:=map(   workalreadydone('~'+FileServices.GetSuperFileSubName(basename,1))
				or workalreadydone('~'+FileServices.GetSuperFileSubName(built,1))
				or workalreadydone('~'+FileServices.GetSuperFileSubName(built+'1',1))
				or workalreadydone('~'+FileServices.GetSuperFileSubName(built+'2',1))
				or workalreadydone('~'+FileServices.GetSuperFileSubName(built+'3',1))
				or workalreadydone('~'+FileServices.GetSuperFileSubName(built+'4',1))
								=> output(basename + ' work done in previous submission of this WU.')
				,sequential(FileServices.StartSuperFileTransaction()
										,if(FileServices.GetSuperFileSubName(basename,1)=''
											,FileServices.AddSuperFile(basename,fname)
											,if(FileServices.GetSuperFileSubName(built,1)=''
												,FileServices.AddSuperFile(built,fname)
												,if(FileServices.GetSuperFileSubName(built+'1',1)=''
													,FileServices.AddSuperFile(built+'1',fname)
													,if(FileServices.GetSuperFileSubName(built+'2',1)=''
														,FileServices.AddSuperFile(built+'2',fname)
														,if(FileServices.GetSuperFileSubName(built+'3',1)=''
															,FileServices.AddSuperFile(built+'3',fname)
															,if(FileServices.GetSuperFileSubName(built+'4',1)=''
																,FileServices.AddSuperFile(built+'4',fname)
																,output('Too many builds to maintain.  Please, delete the oldest one')
													))))))
											,FileServices.FinishSuperFileTransaction()
										)
			);

s4:=if ( fileservices.getsuperfilesubname(built,1) <> fileservices.getsuperfilesubname(basename,1)
				,sequential(
										FileServices.StartSuperFileTransaction()
										,FileServices.ClearSuperFile(basename)
										,FileServices.AddSuperFile(basename,built,,true)
										,FileServices.FinishSuperFileTransaction()
										)
				);

full_ := sequential(
									 s1
									,nothor(s2)
									,nothor(s3)
									,nothor(s4)
									,PostUpdate
									);

PromoteSupers.MAC_SF_BuildProcess( h
                                  ,basenamei
                                  ,incremental_
                                  ,numgenerations:=2
                                  ,pVersion:=filedate
                                  ,pCompress:=true
                                 );

updateLatest := sequential(
                fileservices.clearsuperfile(header.File_header_raw_latest.fileName),
                fileservices.addsuperfile(header.File_header_raw_latest.fileName,
                                            if(incremental,basenamei, basename)+'_'+filedate));
                                            
return sequential( 
                   // Header.fn_blanked_pii(filedate)
				  if(incremental,incremental_,full_)
				  ,updateLatest);

end;