import Versioncontrol, _control;
export fSprayFiles(
    string     pDirectory  = '/prod_data_build_13/eval_data/experian_national_business/'
   ,string     pversion
   ,string     pServerIP   = _control.IPAddress.edata10
   ,string     pFilename   = 'natbus.txt'
   ,string     pGroupName  = _dataset.groupname                                                    
   ,boolean 	 pIsTesting  = false
   ,boolean 	 pOverwrite  = false                                                                                            
) :=
function
   FilesToSpray := DATASET([
      {pServerIP
      ,pDirectory
      ,pFilename
      ,sizeof(layouts.input.sprayed)
      ,Filenames(pversion).input.Template
      ,[ {Filenames(pversion).input.sprayed  }
         ,{Filenames(pversion).input.root    }
      ]
      ,pGroupName
      ,pversion
      }
   ], VersionControl.Layout_Sprays.Info);
   
	 return VersionControl.fSprayInputFiles(FilesToSpray,,,pOverwrite,,,pIsTesting,,_Dataset.Name + ' ' + pversion);
end;
