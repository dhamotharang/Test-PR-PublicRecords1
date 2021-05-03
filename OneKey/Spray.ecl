IMPORT tools, _control, OneKey;

EXPORT Spray(STRING pversion        = ''
            ,STRING pServerIP       = _control.IPAddress.bctlpedata11
            ,STRING pDirectory      = '/data/prod_data_build_10/production_data/business_headers/onekey/data/'+ pversion
            ,STRING pFilenameA      = '*A.csv'  //Ex. 'OneKey_LexisNexisA.csv'
            ,STRING pFilenameB      = '*B.csv'  //Ex. 'OneKey_LexisNexisB.csv'
            ,STRING pLogicalFileA   = OneKey.Filenames(pversion).InputA.logical
            ,STRING pLogicalFileB   = OneKey.Filenames(pversion).InputB.logical
            ,STRING pSuperFileA     = OneKey.Filenames().InputA.sprayed
            ,STRING pSuperFileB     = OneKey.Filenames().InputB.sprayed
            ,STRING pGroupName      = OneKey._Dataset().groupname																		
            ,BOOLEAN pIsTesting     = FALSE
            ,BOOLEAN pOverwrite     = FALSE
            ,BOOLEAN pExistSprayedA = OneKey._Flags.ExistCurrentSprayedA
            ,BOOLEAN pExistSprayedB = OneKey._Flags.ExistCurrentSprayedB
            ,STRING pNameOutput     = OneKey._Constants().Name + ' Spray Info') := FUNCTION

  FileToSpray  := DATASET([{pServerIP
                           ,pDirectory
                           ,pFilenameA
                           ,0
                           ,pLogicalFileA
                           ,[ {pSuperFileA	}	]
                           ,pGroupName
                           ,''
                           ,'[0-9]{8}'
                           ,'VARIABLE'
                           ,''
                           ,OneKey._Constants().max_record_size
                           ,'\t'
                           },
                           {pServerIP
                           ,pDirectory
                           ,pFilenameB
                           ,0
                           ,pLogicalFileB
                           ,[ {pSuperFileB	}	]
                           ,pGroupName
                           ,''
                           ,'[0-9]{8}'
                           ,'VARIABLE'
                           ,''
                           ,OneKey._Constants().max_record_size
                           ,'\t'
                           }], tools.Layout_Sprays.Info);

  RETURN IF(pDirectory = '',
            FAIL('Spray function was passed an empty remote directory!'),
            IF(NOT pExistSprayedA OR pOverwrite,
               tools.fun_Spray(FileToSpray, , , pOverwrite, , FALSE, pIsTesting, , OneKey._Constants().Name + ' ' + pversion, pNameOutput),
               OUTPUT('Input files will not be sprayed.')
              )
           );

END;
