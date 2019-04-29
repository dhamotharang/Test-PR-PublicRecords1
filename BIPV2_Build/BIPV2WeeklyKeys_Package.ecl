//Compile all keys in this package in one place
//easy to output this module to see if keys exist/are correct layout/etc
import tools;
EXPORT BIPV2WeeklyKeys_Package(

   string   pversion              = 'qa'
  ,boolean	pUseOtherEnvironment	= false

) :=
module

  shared knames     := keynames(pversion,puseotherenvironment);
  
  export contact_linkids       := tools.macf_FilesIndex('BIPV2_Build.key_contact_linkids.key         ' ,knames.contact_linkids);
  export contact_title_linkids := tools.macf_FilesIndex('BIPV2_Build.key_contact_title_linkids().key ' ,knames.contact_title_linkids);
  export dir_linkids           := tools.macf_FilesIndex('BIPV2_Build.key_directories_linkids.key     ' ,knames.directories_linkids);

  export outputpackage := 
  parallel(
     output('______________________________________________________________________________')
    ,output('BIPV2WeeklyKeys Package Follows')
    ,output(choosen(contact_linkids   .logical,100) ,named('contact_linkids'              ))
    ,output(choosen(contact_title_linkids   .logical,100) ,named('contact_title_linkids'              ))
    ,output(choosen(dir_linkids       .logical,100) ,named('dir_linkids'                  ))
  );

end;