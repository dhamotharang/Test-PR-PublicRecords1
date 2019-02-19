import doxie, VersionControl;

export Build_Keys
(
    string pversion, 
    boolean pUseProd = false,
    boolean pIsFull = false
) 
:= module

  //----------------------------------------------------------------------------------------------------------
	EXPORT FUNC_TMX_AddToSuperfile (string pSuperfileDest, string pSuperfileSource) := FUNCTION

    retValue := IF
    (
        fileservices.fileexists(pSuperfileSource)
        AND FileServices.FindSuperFileSubName(pSuperfileDest, pSuperfileSource) = 0,
        sequential
        (
            fileservices.StartSuperFileTransaction(),
            fileservices.addsuperfile(pSuperfileDest, pSuperfileSource),
            fileservices.finishSuperFileTransaction()
        )
    );
    
    RETURN retValue;

  END;


  //----------------------------------------------------------------------------------------------------------
  // Build the keys...
  //----------------------------------------------------------------------------------------------------------
  // KEY_SEARCH
	VersionControl.macBuildNewLogicalKey
  (
      Keys(pversion, pUseProd, pIsFull).Search.New, 
      BuildKeySearch
  );
  
  //----------------------------------------------------------------------------------------------------------
  // KEY_SEARCH_ID - Build two logical files by splitting up into ODD / EVEN sample sets to keep the 
  // 
  //----------------------------------------------------------------------------------------------------------

  // KEY_SEARCH_ID_1
  EXPORT Key_Search_ID_1 := Keys(pversion, pUseProd, pIsFull).Search_ID_1.New;
  
	VersionControl.macBuildNewLogicalKey
  (
      Key_Search_ID_1, 
      BuildKeySearch_ID_1
  );
																		  
  // KEY_SEARCH_ID_2
  EXPORT Key_Search_ID_2 := Keys(pversion, pUseProd, pIsFull).Search_ID_2.New;
  
	VersionControl.macBuildNewLogicalKey
  (
      Key_Search_ID_2, 
      BuildKeySearch_ID_2
  );
  																		  
	export full_build :=
      sequential
      (
          BuildKeySearch,
          BuildKeySearch_ID_1,
          BuildKeySearch_ID_2,

          // Creates files for BUILT via PROMOTE... 
          INQL_TMX.Promote
          (
              pversion, 
              pUseProd, 
              pIsFull,,,,
              keynames(pversion, pUseProd, pIsFull).Search_ID_1.dAll_filenames
              
          ).buildfiles.New2Built,  

          // AFTER creating BUILT physical files with ID_1 BUILT physical file in the master superfile, 
          // now add ID_2 BUILT physical file to the same singular master superfile.
          FUNC_TMX_AddToSuperfile
          (
              INQL_TMX.Keynames(pversion, pUseProd, pIsFull).Search_ID_1.built,
              INQL_TMX.Keynames(pversion, pUseProd, pIsFull).Search_ID_2.new
          ),
         
          // Creates files for QA via PROMOTE... 
          INQL_TMX.Promote
          (
              pversion, 
              pUseProd, 
              pIsFull,,,,
              INQL_TMX.Keynames(pversion, pUseProd, pIsFull).Search_ID_1.dAll_filenames
              
          ).buildfiles.Built2qa,

          // AFTER creating QA physical files with ID_1 QA physical file in the master superfile, 
          // now add ID_2 QA physical file to the same singular master superfile.
          FUNC_TMX_AddToSuperfile
          (
              INQL_TMX.Keynames(pversion, pUseProd, pIsFull).Search_ID_1.qa,
              INQL_TMX.Keynames(pversion, pUseProd, pIsFull).Search_ID_2.new
          )
      );
		
	export All :=
      if(VersionControl.IsValidVersion(pversion),
          full_build,
          output('Build_Keys - No Valid version parameter passed, skipping TMX.Build_Keys atribute...')
      );

end;