import tools;

export Keynames(

	 string  pversion	= '',
   boolean pUseProd = false,
   boolean pIsFull  = false

) :=
module

	export lFileTemplate := _Dataset(pUseProd).thor_cluster_files + 'key::' + _Dataset(pUseProd, pIsFull).name + '::@version@::'	;
	
  //----------------------------------------------------------------------------------------------------------
  // KEY_SEARCH index
  //----------------------------------------------------------------------------------------------------------
	shared lSearch := lFileTemplate + 'search';
	export Search := tools.mod_FilenamesBuild(lSearch, pversion, pnGenerations:=2);

  //----------------------------------------------------------------------------------------------------------
  // KEY_SEARCH_ID index
  //----------------------------------------------------------------------------------------------------------
	shared lSearch_ID := lFileTemplate + 'search_id';
  
  export Search_ID := 
      tools.mod_FilenamesBuild
      (
          lSearch_ID, 
          pversion, 
          pnGenerations:=2
      );

  //----------------------------------------------------------------------------------------------------------
	shared lSearch_ID_1 := lFileTemplate + 'search_id_1';

	export Search_ID_1 := 
      tools.mod_FilenamesBuild
      (
          lSearch_ID, 
          pversion,
          lSearch_ID_1,
          2
      );
  
  //----------------------------------------------------------------------------------------------------------
	shared lSearch_ID_2 := lFileTemplate + 'search_id_2';

	export Search_ID_2 := 
      tools.mod_FilenamesBuild
      (
          lSearch_ID,
          pversion,
          lSearch_ID_2,
          2
      );

	export dAll_filenames := 

      Search.dAll_filenames +
      Search_ID_1.dAll_filenames +
      Search_ID_2.dAll_filenames
  ;
  
end;