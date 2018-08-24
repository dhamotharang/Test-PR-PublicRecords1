import tools,bipv2_proxid,bipv2_proxid_mj6,BIPV2_Best,TopBusiness_BIPV2,BIPV2_PostProcess,BIPv2_HRCHY,BIPV2;

EXPORT filenames(

   string   pversion              = ''
  ,boolean	pUseOtherEnvironment	= false
  
) :=
module

	shared lfileprefix		  := _Constants(pUseOtherEnvironment).FileTemplate	  ;
	shared lwkhistprefix		:= _Constants(pUseOtherEnvironment).GenericTemplate	;
	shared lprefix	        := _Constants(pUseOtherEnvironment).prefix			;

	export Space_Usage      := tools.mod_FilenamesBuild(lfileprefix + 'SpaceUsage'	     ,pversion);
	export Dashboard        := tools.mod_FilenamesBuild(lfileprefix + 'Dashboard'	       ,pversion);
	export Best_Flat        := tools.mod_FilenamesBuild(lfileprefix + 'Best_Flat'	       ,pversion);
	export BIP_Owners       := tools.mod_FilenamesBuild(lfileprefix + 'BIP_Owners'	     ,pversion);
	export workunit_history := tools.mod_FilenamesBuild(lwkhistprefix + 'workunit_history' ,pversion);
	export contact_linkids  := tools.mod_FilenamesBuild(lprefix + 'thor_data400::base::bipv2::business_header::@version@::contact_linkids'            ,pversion    );
// bipv2_build::qa::workunit_history
// ~thor_data400::base::BIPV2_Build::qa::workunit_history
// ~BIPV2_Build::qa::workunit_history

  export dall_filenames := 
      Space_Usage     .dall_filenames
    + Dashboard       .dall_filenames
    + Best_Flat       .dall_filenames
    + BIP_Owners      .dall_filenames
    + contact_linkids .dall_filenames
    + BIPV2.Filenames            (pversion,pUseOtherEnvironment).dall_filenames
    + bipv2_proxid.filenames     (pversion,pUseOtherEnvironment).dall_filenames
    + bipv2_proxid_mj6._filenames(pversion,pUseOtherEnvironment).dall_filenames
    + BIPv2_HRCHY.filenames      (pversion,pUseOtherEnvironment).dall_filenames
    + BIPV2_PostProcess.filenames(pversion,pUseOtherEnvironment).dall_filenames
    + BIPV2_Best.filenames       (pversion                     ).dall_filenames
    + TopBusiness_BIPV2.filenames(pversion,pUseOtherEnvironment).dall_filenames
    ;
    

end;