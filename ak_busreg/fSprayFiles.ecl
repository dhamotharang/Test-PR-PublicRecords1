import Versioncontrol, _control;
export fSprayFiles(
    string     pServerIP      = _control.IPAddress.edata10
   ,string     pDirectory  = '/prod_data_build_10/production_data/business_headers/ak_busreg/'
   ,string     pFilename      = 'ak_busreg*d00'
   ,string     pversion
   ,string     pGroupName  = _Dataset().groupname                                                    
   ,boolean pIsTesting  = false
   ,boolean pOverwrite  = false                                                                                            
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
   return VersionControl.fSprayInputFiles(FilesToSpray,,,pOverwrite,false,,pIsTesting,,_Dataset().Name + ' ' + pversion);
end;
