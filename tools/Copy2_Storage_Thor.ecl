IMPORT STD, ut,wk_ut,tools,WsDFU;
//works on thor and hthor now
export  Copy2_Storage_Thor(

   string  filename       
  ,string  tempname          = ''
  ,string  pCluster          = 'thor400_24_store'
  ,boolean pDeleteSourceFile = false
  ,string  pEclserver        = 'prod_esp.br.seisint.com'//10.241.20.202
  ,string  pSourceDali       = 'prod_dali.br.seisint.com'
) := 
Function

  #uniquename(tempcopyname)
  
  lfilename   := filename : independent;  //stop this from being reevaluated if necessary.
  
  // -- Setup DFU command
  lTempname   := if(tempname = '' ,lfilename + %'tempcopyname'% ,tempname)    ;
  serv        := 'server=http://' + pEclserver + ':8010 '                          ;
  nsplit      := ' nosplit=1 '                                                ;
  dstcluster  := 'dstcluster=thor400_24_store '                               ;
  over        := 'overwrite=1 '                                               ;
  repl        := 'replicate=1 '                                               ;
  comp        := 'compress=1 ';//if (ut.isCompressed(lfilename),'compress=1 ','compressed=0 '); 
  action      := 'action=copy '                                               ;
  wrap        := 'wrap=1 '                                                    ;
  srcname     := 'srcname='+lfilename + ' '                                   ;
  dstname     := 'dstname='+lTempname + ' '                                   ;
  srcdali     := 'srcdali=' + pSourceDali                                     ;
  
  copyfilecmd := serv + over + repl + action + dstcluster + dstname + srcname + nsplit + wrap + comp + srcdali;
                    
  getorigcreatewuid := WsDFU.GetFileCreationWuid(lfilename);
  copywuid          := workunit                         ;

  // -- Execute command
  docopy            := STD.File.DfuPlusExec(copyfilecmd): independent;
  
  return if(trim(filename) != '~' and trim(filename) != ''
    ,sequential(
       output(dstname       ,named('copy_destination_name')  ,overwrite)
      ,output(copyfilecmd   ,named('copy_file_cmd'        )  ,overwrite)
      ,nothor(global(docopy))
      ,std.file.setfiledescription(lTempname,
            std.file.getfiledescription(lfilename)   + '\n'
          + 'Orig create wuid: ' + getorigcreatewuid + '\n' 
          + 'Copy wuid       : ' + copywuid
       )
      ,nothor(apply(fileservices.LogicalFileSuperOwners(lfilename)  ,std.file.removesuperfile('~' + name,lfilename),std.file.addsuperfile('~' + name,lTempname)))
      ,if(pDeleteSourceFile 
        ,sequential(
           nothor(std.file.deletelogicalfile(lfilename)  )
          ,if(exists(nothor(fileservices.LogicalFileSuperOwners(lTempname) )) 
            ,tools.fun_RenameFiles(dataset([{'~' + nothor(fileservices.LogicalFileSuperOwners(lTempname)[1].name),lfilename}],Tools.Layout_SuperFilenames.InputLayout)  ,false,,,lTempname)
            ,nothor(std.file.renamelogicalfile(lTempname,lfilename))
          )
        )
      )
    )
  );
	   															
END;
