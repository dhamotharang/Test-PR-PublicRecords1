import tools,bipv2_proxid,bipv2_proxid_mj6,BIPV2_Best,TopBusiness_BIPV2,BIPV2_PostProcess,BIPv2_HRCHY,BIPV2;

EXPORT filenames(

   string   pversion              = ''
  ,boolean	pUseOtherEnvironment	= false
) :=
module

	shared lfileprefix		:= _Config(pUseOtherEnvironment).GenericTemplate	;

  // -- Ingest Stats
	export Gold_Seleid_Orgid_Persistence := tools.mod_FilenamesBuild(lfileprefix             + 'Gold_Seleid_Orgid_Persistence' ,pversion);

  export dall_filenames := 
      Gold_Seleid_Orgid_Persistence               .dall_filenames
    ;   

end;