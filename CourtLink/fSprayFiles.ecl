import Versioncontrol, _control;
export fSprayFiles(
				string		pServerIP	= _control.IPAddress.edata12
				,string     pDirectory	= '/hds_180/CourtLink/20090804'
				,string     pFilename	= 'docket.txt'
				,string     pversion
				,string     pGroupName	= _Dataset().groupname                                                    
				,boolean 	pIsTesting	= false
				,boolean 	pOverwrite	= false                                                                                           
					) := function
					
	FilesToSpray := DATASET([
							{pServerIP
							,pDirectory
							,pFilename
							,0
							,Filenames(pversion).input.Template
							,[ {Filenames(pversion).input.sprayed  }
							,{Filenames(pversion).input.root    }
							]
							,pGroupName
							,pversion
							,''
							,'VARIABLE'
							,''
							,400000
							,'\t'
							}
							], VersionControl.Layout_Sprays.Info);
							
	return VersionControl.fSprayInputFiles(FilesToSpray,,,pOverwrite,false,,pIsTesting,,_Dataset().Name + ' ' + pversion);
end;
