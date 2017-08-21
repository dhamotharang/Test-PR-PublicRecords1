version       := '20130329';
renameversion := version + 'a';

//////////////////////////////////////////////////////
// -- keynames
//////////////////////////////////////////////////////
keynames(string pversion = '') := 
module

  export testatt    := tools.mod_FilenamesBuild('~key::TestMod::@version@::testatt'  ,pversion );
  export testmtch   := tools.mod_FilenamesBuild('~key::TestMod::@version@::testmtch' ,pversion );

  export dall_filenames := 
        testatt.dall_filenames
      + testmtch.dall_filenames
  ;
end;

//////////////////////////////////////////////////////
// -- keys
//////////////////////////////////////////////////////
keys(string pversion = '') := 
module

  shared ds_testatt  := dataset([],{string1 keyfield,string2 payload});
  shared ds_testmtch := dataset([],{string1 keyfield,string2 payload});

  export testatt  := tools.macf_FilesIndex('ds_testatt ,{keyfield}	,{ds_testatt}'	,keynames(pversion).testatt );
  export testmtch := tools.macf_FilesIndex('ds_testmtch,{keyfield}	,{ds_testmtch}'	,keynames(pversion).testmtch);
  
end;

//////////////////////////////////////////////////////
// -- Build Keys
//////////////////////////////////////////////////////
writetestatt  := tools.macf_WriteIndex('keys(version).testatt.new' ); //build this logical key.  Will skip if already exists(good for resubmits to avoid doing work more than once)
writetestmtch := tools.macf_WriteIndex('keys(version).testmtch.new'); //build this logical key.  Will skip if already exists(good for resubmits to avoid doing work more than once)
  
import tools;
//////////////////////////////////////////////////////
// -- Promote Keys to supers.  Creates them if they don't exist
//////////////////////////////////////////////////////
lay_builds 	:= tools.Layout_FilenameVersions.builds;
Promote(
	 string								pversion				= 	''
	,string								pFilter					= 	''
	,boolean							pDelete					= 	false
	,boolean							pIsTesting			= 	false
	,dataset(lay_builds)	pBuildFilenames = 	keynames	(pversion).dAll_filenames
) := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pIsTesting);

//////////////////////////////////////////////////////
// -- Rename Keys
//////////////////////////////////////////////////////
Rename_Keys(
	 string									pversion
	,string									pFilter						= ''
	,boolean								pIsTesting				= false   	// set to false to actually rename the keys
	,dataset(lay_builds   )	pFilesToRename		= keynames	(pversion).dall_filenames
) := tools.fun_RenameBuildFiles(pversion,pFilesToRename,pIsTesting,,pFilter);

//////////////////////////////////////////////////////
// -- Do work
//////////////////////////////////////////////////////
sequential(
  parallel(
     writetestatt                         //build testatt key
    ,writetestmtch                        //build testmtch key
  )
  ,output(keys(version).testatt.new   )   //output the logical version of key, 20130329
  ,output(keys(version).testmtch.new  )   //output the logical version of key, 20130329
  ,promote(version,'testmtch').new2built  //promote just the testmtch key to built
  ,promote(version).new2built             //promote rest of keys to built(just 1 extra key in this case)
  ,output(keys().testatt.built        )   //output the built version of key
  ,output(keys().testmtch.built       )   //output the built version of key
  ,promote().built2qa                     //promote all keys from built to qa
  ,output(keys().testatt.qa           )   //output the qa version of key
  ,output(keys().testmtch.qa          )   //output the qa version of key
  ,rename_keys(renameversion)             //rename keys to new version
);