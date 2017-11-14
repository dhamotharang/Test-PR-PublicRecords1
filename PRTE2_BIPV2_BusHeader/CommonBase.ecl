// This module publishes the common BASE layout that gets passed from step to step
// during the internal linking process.
//
// It also publishes a set of SuperFiles representing the final result after all
// internal linking steps have completed.
//
// The three main exports in this module are...
//
// 1. BIPV2.CommonBase.Layout
// 2. BIPV2.CommonBase.DS_BASE
// 2. BIPV2.CommonBase.DS_CLEAN
//
// Going forward, we'll want anybody who needs the header layout to reference #1. 
// Almost everyone who needs the header should reference #3.  #2 feeds back around
// as the base file for the next build.

IMPORT ut, BIPV2, BIPV2_Company_Names, AID, _Control, Suppress, Data_Services;

EXPORT CommonBase := MODULE

	// layout currently used for linking
	EXPORT Layout_Dynamic := BIPV2.CommonBase_mod.Layout_Derived;
	
	// layout for the last build completed/committed
	EXPORT Layout_Static := BIPV2.CommonBase_mod.Layout_Static;
	
	// default layout
	EXPORT Layout := #IF(BIPV2._Config.BASE_LAYOUT_DYNAMIC)
		Layout_Dynamic;
	#ELSE
		Layout_Static;
	#END
	
	
	// Files and datasets
	EXPORT filePrefix				:= 'prte::base::Bipv2_Business_Header::';
	
	EXPORT FILE_LOCAL_BUILT	      := '~' + filePrefix + 'built' 			+ '::internal_linking';
	//EXPORT FILE_LOCAL				      := '~' + filePrefix + 'base'  			+ '::internal_linking';
	//EXPORT FILE_FATHER_LOCAL      := '~' + filePrefix + 'father' 			+ '::internal_linking';
	//EXPORT FILE_GRANDFATHER_LOCAL	:= '~' + filePrefix + 'grandfather' + '::internal_linking';
  
	EXPORT FILE_BUILT				      := FILE_LOCAL_BUILT;
	//EXPORT FILE_BASE				      := FILE_LOCAL      ;
  //EXPORT FILE_FATHER            := FILE_FATHER_LOCAL;
  //EXPORT FILE_GRANDFATHER       := FILE_GRANDFATHER_LOCAL;
	
	EXPORT DS_LOCAL_BUILT  	      := DATASET(FILE_LOCAL_BUILT  ,Layout         ,THOR ,OPT);
	//EXPORT DS_LOCAL  				      := DATASET(FILE_LOCAL        ,Layout         ,THOR ,OPT);
	//EXPORT DS_FATHER  			      := DATASET(FILE_FATHER       ,Layout         ,THOR ,OPT);
	//EXPORT DS_GRANDFATHER 	      := DATASET(FILE_GRANDFATHER  ,Layout         ,THOR ,OPT);
	//EXPORT DS_BASE  				      := DATASET(FILE_BASE         ,Layout         ,THOR ,OPT);
	EXPORT DS_BUILT  		          := DATASET(FILE_BUILT        ,Layout         ,THOR ,OPT); //used within the build to reference newly built file.  DO NOT use outside of the BIP build.
  
	//EXPORT DS_STATIC 				      := DATASET(FILE_BASE        ,Layout_Static  ,THOR ,OPT);
	//EXPORT DS_LOCAL_STATIC 				:= DATASET(FILE_LOCAL       ,Layout_Static  ,THOR ,OPT);
	//EXPORT DS_FATHER_STATIC       := DATASET(FILE_FATHER      ,Layout_Static  ,THOR ,OPT);
	//EXPORT DS_GRANDFATHER_STATIC  := DATASET(FILE_GRANDFATHER ,Layout_Static  ,THOR ,OPT);
	
  // -- Allow specific versions to be accessed directly(logical files)
  import tools;
  export Common_Base        (string pversion = '') := tools.macf_FilesBase(PRTE2_BIPV2_BusHeader.Filenames(pversion).base.LinkingBase ,Layout       );
  export Common_Base_Static (string pversion = '') := tools.macf_FilesBase(PRTE2_BIPV2_BusHeader.Filenames(pversion).base.LinkingBase ,Layout_Static);
	
	// Apply any necessary post-processing to the header, before things like XLink pick it up
	EXPORT clean(ds) := FUNCTIONMACRO
		IMPORT Suppress;
		ds_exorcise := ds(ingest_status<>'Old'); // Exorcise all ghosts, which _can_ remove cluster base records!
		ds_exclude  := ds_exorcise(BIPV2.mod_sources.srcInBase(source));
		//ds_reg      := Suppress.applyRegulatory.applyBIPV2(ds_exclude);
		ds_reg      := ds_exclude;
		RETURN ds_reg;
	ENDMACRO;
  
	EXPORT DS_CLEAN                 := clean(DS_BUILT         );//USED INSIDE OF THE BIP BUILD TO ACCESS THE NEWLY CREATED FILE.
	//EXPORT DS_CLEAN_BASE            := clean(DS_BASE          );//USED OUTSIDE OF THE BUILD  
	//EXPORT DS_FATHER_CLEAN          := clean(DS_FATHER        );
	//EXPORT DS_FATHER_STATIC_CLEAN   := clean(DS_FATHER_STATIC );	
	
	EXPORT xlink(ds) := FUNCTIONMACRO
		IMPORT Suppress;
		ds_exorcise := ds(ingest_status<>'Old'); // Exorcise all ghosts, which _can_ remove cluster base records!
		ds_exclude  := ds_exorcise(BIPV2.mod_sources.srcInXlink(source));
		//ds_reg      := Suppress.applyRegulatory.applyBIPV2(ds_exclude);
		ds_reg      := ds_exclude;
		RETURN ds_reg;
	ENDMACRO;

	EXPORT DS_XLINK                 := xlink(DS_BUILT      );//USE NEWLY CREATED BASE FILE
	
	// Never ever ever reference DS_OMNI in production code!  This exists solely
	// to allow developers to do weird stuff during development and testing.
	EXPORT DS_OMNI(in_loc='', in_ver='', in_rec='') := FUNCTIONMACRO
		IMPORT ut;
		
		LOCAL loc := CASE(
			StringLib.StringToLowerCase(#TEXT(in_loc)),
			''					=> '~',
			'local'			=> '~',
			'dataland'	=> Data_Services.foreign_dataland,
			'prod'			=> Data_Services.foreign_prod,
			ERROR('BIPV2.CommonBase.DS_OMNI -- bad location'));
		
		LOCAL ver := CASE(
			StringLib.StringToLowerCase(#TEXT(in_ver)),
			''						=> 'base',
			'base'				=> 'base',
			'father'			=> 'father',
			'grandfather'	=> 'grandfather',
			ERROR('BIPV2.CommonBase.DS_OMNI -- bad version'));
		
		LOCAL rec_text := CASE(
			StringLib.StringToLowerCase(#TEXT(in_rec)),
			''				=> 'BIPV2.CommonBase.Layout',
			'static'	=> 'BIPV2.CommonBase.Layout_Static',
			'dynamic'	=> 'BIPV2.CommonBase.Layout_Dynamic',
			'BIPV2.CommonBase_mod.Layout_' + #TEXT(in_rec));
		
		LOCAL rec := #EXPAND(rec_text);
		
		LOCAL fname := loc + PRTE2_BIPV2_BusHeader.CommonBase.filePrefix + ver : DEPRECATED('DS_OMNI is not intended for production use');
		
		RETURN DATASET(fname, rec, THOR);
	ENDMACRO;
	
/*	
	// Superfile updates
	EXPORT updateSuperfiles(STRING inFile) :=
		FileServices.PromoteSuperFileList([FILE_BASE], inFile);
	EXPORT revertSuperfiles :=
		FileServices.PromoteSuperFileList([FILE_BASE]);
	EXPORT clearSuperfiles :=
		PARALLEL(
			FileServices.ClearSuperFile(FILE_BASE),
			//FileServices.ClearSuperFile(FILE_FATHER),
			//FileServices.ClearSuperFile(FILE_GRANDFATHER)
		);
*/
END;