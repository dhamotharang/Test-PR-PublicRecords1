//Compile all keys in this package in one place
//easy to output this module to see if keys exist/are correct layout/etc
import tools,prte,bipv2,_control;
EXPORT PRTE_BIPV2WeeklyKeys_Package(

   string   pversion              = 'qa'
  ,boolean	pUseOtherEnvironment	= false

) :=
module

  shared knames     := keynames(pversion,puseotherenvironment);
  shared toPRTE(string pfilename) := regexreplace('thor_data400',pfilename,'prte',nocase);

  shared dkeybuild := dataset([],recordof(BIPV2_Build.key_contact_linkids.dkeybuild));
  
  BIPV2.IDmacros.mac_IndexWithXLinkIDs(dkeybuild, k, toPRTE(knames.contact_linkids    .logical))
  export contact_linkids := k;


  // export contact_linkids   := index(BIPV2_Build.key_contact_linkids.key       ,toPRTE(knames.contact_linkids    .logical));
  
  shared concat_them := dataset([],recordof(BIPV2_Build.key_directories_linkids.concat_them));
  BIPV2.IDmacros.mac_IndexWithXLinkIDs(concat_them, k, toPRTE(knames.directories_linkids.logical))
  export dir_linkids := k;
  
  // export dir_linkids       := index(BIPV2_Build.key_directories_linkids.key   ,toPRTE(knames.directories_linkids.logical));

  export outputpackage := 
  parallel(
     output('______________________________________________________________________________')
    ,output('BIPV2WeeklyKeys Package Follows')
    ,output(choosen(contact_linkids   ,100) ,named('contact_linkids'              ))
    ,output(choosen(dir_linkids       ,100) ,named('dir_linkids'                  ))
  );

  export build_keys := 
  parallel(
     build(contact_linkids ,update)
    ,build(dir_linkids     ,update)
    ,PRTE.UpdateVersion(
      'BIPV2WeeklyKeys'											//	Package name
      ,pversion												      //	Package version
      ,_control.MyInfo.EmailAddressNormal	 	//	Who to email with specifics
      ,'B'																	//	B = Boca, A = Alpharetta
      ,'N'																	//	N = Non-FCRA, F = FCRA
      ,'N'                                 	//	N = Do not also include boolean, Y = Include boolean, too
    ) 	//end PRTE.UpdateVersion

  );
  
end;