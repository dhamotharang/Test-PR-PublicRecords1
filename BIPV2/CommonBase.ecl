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
	EXPORT Layout := BIPV2.CommonBase_mod.Layout;
	
	
	// Files and datasets
	EXPORT filePrefix				:= 'thor_data400::bipv2::internal_linking::';
	
	EXPORT FILE_LOCAL_BUILT	      := '~' + filePrefix + 'built'    ;
	EXPORT FILE_LOCAL				      := '~' + filePrefix + 'base'        ;
	EXPORT FILE_FATHER_LOCAL      := '~' + filePrefix + 'father'      ;
	EXPORT FILE_GRANDFATHER_LOCAL	:= '~' + filePrefix + 'grandfather' ;

	EXPORT FILE_PROD_BUILT		    := Data_Services.foreign_prod      + filePrefix + 'built'     ;
	EXPORT FILE_PROD				      := Data_Services.foreign_prod      + filePrefix + 'base'         ;
	EXPORT FILE_FATHER_PROD	      := Data_Services.foreign_prod      + filePrefix + 'father'       ;
	EXPORT FILE_GRANDFATHER_PROD	:= Data_Services.foreign_prod      + filePrefix + 'grandfather'  ;
	EXPORT FILE_DATALAND		      := Data_Services.foreign_dataland  + filePrefix + 'base'         ;
  
	EXPORT FILE_BUILT				      := IF(_Control.ThisEnvironment.Name = 'Prod_Thor' ,FILE_LOCAL_BUILT         ,FILE_PROD_BUILT        );
	EXPORT FILE_BASE				      := IF(_Control.ThisEnvironment.Name = 'Prod_Thor' ,FILE_LOCAL               ,FILE_PROD              );
  EXPORT FILE_FATHER            := IF(_Control.ThisEnvironment.Name = 'Prod_Thor' ,FILE_FATHER_LOCAL        ,FILE_FATHER_PROD       );
  EXPORT FILE_GRANDFATHER       := IF(_Control.ThisEnvironment.Name = 'Prod_Thor' ,FILE_GRANDFATHER_LOCAL   ,FILE_GRANDFATHER_PROD  );
	
	EXPORT DS_LOCAL_BUILT  	      := DATASET(FILE_LOCAL_BUILT  ,Layout         ,THOR ,OPT);
	EXPORT DS_LOCAL  				      := DATASET(FILE_LOCAL        ,Layout         ,THOR ,OPT);
	EXPORT DS_FATHER  			      := DATASET(FILE_FATHER       ,Layout         ,THOR ,OPT);
	EXPORT DS_GRANDFATHER 	      := DATASET(FILE_GRANDFATHER  ,Layout         ,THOR ,OPT);
	EXPORT DS_BASE  				      := DATASET(FILE_BASE         ,Layout         ,THOR ,OPT);
	EXPORT DS_BUILT  		          := DATASET(FILE_BUILT        ,Layout         ,THOR ,OPT); //used within the build to reference newly built file.  DO NOT use outside of the BIP build.
  
	EXPORT DS_PROD_BUILT  		    := DATASET(FILE_PROD_BUILT  ,Layout         ,THOR ,OPT);
	EXPORT DS_PROD  				      := DATASET(FILE_PROD        ,Layout_Static  ,THOR ,OPT);
	EXPORT DS_DATALAND			      := DATASET(FILE_DATALAND    ,Layout_Static  ,THOR ,OPT);
	EXPORT DS_STATIC 				      := DATASET(FILE_BASE        ,Layout_Static  ,THOR ,OPT);
	EXPORT DS_LOCAL_STATIC 				:= DATASET(FILE_LOCAL       ,Layout_Static  ,THOR ,OPT);
	EXPORT DS_FATHER_STATIC       := DATASET(FILE_FATHER      ,Layout_Static  ,THOR ,OPT);
	EXPORT DS_GRANDFATHER_STATIC  := DATASET(FILE_GRANDFATHER ,Layout_Static  ,THOR ,OPT);
	
  // -- Allow specific versions to be accessed directly(logical files)
  import tools;
  export Common_Base        (string pversion = '') := tools.macf_FilesBase(BIPV2.Filenames(pversion).Common_Base ,Layout       );
  export Common_Base_Static (string pversion = '') := tools.macf_FilesBase(BIPV2.Filenames(pversion).Common_Base ,Layout_Static);
	
	// Apply any necessary post-processing to the header, before things like XLink pick it up
	EXPORT clean(ds) := FUNCTIONMACRO
		IMPORT Suppress;
		IMPORT Bipv2_Suppression;
		ds_exorcise := ds(ingest_status<>'Old'); // Exorcise all ghosts, which _can_ remove cluster base records!
		ds_exclude  := ds_exorcise(BIPV2.mod_sources.srcInBase(source));
		ds_suppress := Bipv2_Suppression.suppressClean(ds_exclude);
		ds_reg      := Suppress.applyRegulatory.applyBIPV2(ds_suppress);
		RETURN ds_reg;
	ENDMACRO;
  
	EXPORT DS_CLEAN                 := clean(DS_BUILT         );//USED INSIDE OF THE BIP BUILD TO ACCESS THE NEWLY CREATED FILE.
	EXPORT DS_CLEAN_BASE            := clean(DS_BASE          );//USED OUTSIDE OF THE BUILD  
	EXPORT DS_FATHER_CLEAN          := clean(DS_FATHER        );
	EXPORT DS_FATHER_STATIC_CLEAN   := clean(DS_FATHER_STATIC );
	EXPORT DS_PROD_CLEAN  	        := clean(DS_PROD          );
	EXPORT DS_LOCAL_CLEAN           := clean(DS_LOCAL         );
	EXPORT DS_LOCAL_STATIC_CLEAN    := clean(DS_LOCAL_STATIC  );
	
	EXPORT xlink(ds) := FUNCTIONMACRO
		IMPORT Suppress;
		ds_exorcise := ds(ingest_status<>'Old'); // Exorcise all ghosts, which _can_ remove cluster base records!
		ds_exclude  := ds_exorcise(BIPV2.mod_sources.srcInXlink(source));
		ds_reg      := Suppress.applyRegulatory.applyBIPV2(ds_exclude);
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
		
		LOCAL fname := loc + BIPV2.CommonBase.filePrefix + ver : DEPRECATED('DS_OMNI is not intended for production use');
		
		RETURN DATASET(fname, rec, THOR);
	ENDMACRO;
	
	
	// Superfile updates
	EXPORT updateSuperfiles(STRING inFile) :=
		FileServices.PromoteSuperFileList([FILE_BASE,FILE_FATHER,FILE_GRANDFATHER], inFile);
	EXPORT revertSuperfiles :=
		FileServices.PromoteSuperFileList([FILE_GRANDFATHER,FILE_FATHER,FILE_BASE]);
	EXPORT clearSuperfiles :=
		PARALLEL(
			FileServices.ClearSuperFile(FILE_BASE),
			FileServices.ClearSuperFile(FILE_FATHER),
			FileServices.ClearSuperFile(FILE_GRANDFATHER)
		);

END;