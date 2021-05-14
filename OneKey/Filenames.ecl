IMPORT  tools, lib_fileservices, OneKey;

EXPORT Filenames(STRING  pversion              = ''
                ,BOOLEAN pUseOtherEnvironment  = FALSE) := MODULE

  SHARED lversiondate        := pversion;

  SHARED lInputRoot          := OneKey._Constants(pUseOtherEnvironment).InputTemplate;
  SHARED lBaseRoot           := OneKey._Constants(pUseOtherEnvironment).FileTemplate;

  EXPORT InputA              := tools.mod_FilenamesInput(lInputRoot + 'InputA', lversiondate);
  EXPORT InputB              := tools.mod_FilenamesInput(lInputRoot + 'InputB', lversiondate);
  EXPORT Base                := tools.mod_FilenamesBuild(lBaseRoot  + 'Data',   lversiondate);
		     
  EXPORT dAll_Inputfilenames := InputA.dAll_filenames + InputB.dAll_filenames;
  EXPORT dAll_Basefilenames  := Base.dAll_filenames;

  //Persist Filenames
  EXPORT lPersistRoot               := OneKey._Constants(pUseOtherEnvironment).Thor_Cluster_Persists + 'persist::' + OneKey._Constants().Name;
	
  EXPORT PersistStandardizeInputA   := lPersistRoot + '::standardize_InputA';
  EXPORT PersistStandardizeInputB   := lPersistRoot + '::standardize_InputB';
  EXPORT PersistStandardizeNameAddr := lPersistRoot + '::standardize_NameAddr';
  EXPORT PersistAppendIds           := lPersistRoot + '::Append_Ids.Bdid_xlinkids';

  EXPORT dAll_Persist_Filenames := DATASET([{PersistStandardizeInputA}
                                           ,{PersistStandardizeInputB}
                                           ,{PersistStandardizeNameAddr}
                                           ,{PersistAppendIds}], lib_fileservices.FsLogicalFileNameRecord);

END;