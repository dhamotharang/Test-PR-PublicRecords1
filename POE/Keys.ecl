import doxie, tools,autokeyb2, mdr;

export Keys(

	 string		pversion									= ''
	,boolean	pUseOtherEnvironment			= false
	,boolean	pFileUseOtherEnvironment	= false

) :=
module

	shared Base					:= Files(pversion,pFileUseOtherEnvironment).Base.Built;
	shared dSourceHier	:= File_Source_Hierarchy;
	//
  shared dkeybuild		:= project(Base, transform(layouts.keybuild, self.subject_ssn := if(mdr.sourceTools.sourceIsUtility(left.source), 0, left.subject_ssn),self := left));
	shared dkeybuild_appends := Append_Supp(dkeybuild) ;
	//
	shared FilterBdids	:= dkeybuild_appends(bdid	!= 0);
	shared FilterDids		:= dkeybuild_appends(did	!= 0);
	
	tools.mac_FilesIndex('FilterBdids				,{bdid}	  						,{FilterBdids				}'	,keynames(pversion,pUseOtherEnvironment).Bdid							,Bdid 						);
	tools.mac_FilesIndex('FilterDids				,{did	}	  						,{FilterDids				}'	,keynames(pversion,pUseOtherEnvironment).Did							,Did	 						);
	tools.mac_FilesIndex('dkeybuild_appends	,{unsigned6 FakeID	}	,{dkeybuild_appends	}'	,keynames(pversion,pUseOtherEnvironment).Payload					,Payload					);	//autokey payload key
	tools.mac_FilesIndex('dSourceHier				,{source}	 						,{dSourceHier				}'	,keynames(pversion,pUseOtherEnvironment).Source_Hierarchy	,Source_Hierarchy	);
	
end;