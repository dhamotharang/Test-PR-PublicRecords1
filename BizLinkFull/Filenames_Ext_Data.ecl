
IMPORT Data_Services,tools;

EXPORT Filenames_Ext_Data := MODULE

// Files and datasets
	EXPORT filePrefix				:= 'thor_data400::BizLinkFull::Ext_Data::';
	
	EXPORT FILE_LOCAL				      := '~' + filePrefix + 'base'        ;
	EXPORT FILE_FATHER_LOCAL      := '~' + filePrefix + 'father'      ;
	EXPORT FILE_GRANDFATHER_LOCAL	:= '~' + filePrefix + 'grandfather' ;

	EXPORT FILE_PROD				      := Data_Services.foreign_prod      + filePrefix + 'base'         ;
	EXPORT FILE_FATHER_PROD	      := Data_Services.foreign_prod      + filePrefix + 'father'       ;
	EXPORT FILE_GRANDFATHER_PROD	:= Data_Services.foreign_prod      + filePrefix + 'grandfather'  ;
  
	EXPORT FILE_BASE				      := FILE_LOCAL;//IF(_Control.ThisEnvironment.Name = 'Prod_Thor' ,FILE_LOCAL               ,FILE_PROD              );
  EXPORT FILE_FATHER            := FILE_FATHER_LOCAL;//IF(_Control.ThisEnvironment.Name = 'Prod_Thor' ,FILE_FATHER_LOCAL        ,FILE_FATHER_PROD       );
  EXPORT FILE_GRANDFATHER       := FILE_GRANDFATHER_LOCAL;//IF(_Control.ThisEnvironment.Name = 'Prod_Thor' ,FILE_GRANDFATHER_LOCAL   ,FILE_GRANDFATHER_PROD  );


	EXPORT BaseLF(string version)  := tools.mod_FilenamesBuild('~' + filePrefix + '@version@::Data',version);

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