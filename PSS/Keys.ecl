import doxie, tools,autokeyb2;

export Keys(

	 string		pversion									= ''
	,boolean	pUseOtherEnvironment			= false
	,boolean	pFileUseOtherEnvironment	= false

) :=
module
 shared key_phone_status := ['A', 'B', 'C' ,'D'];
	shared Base					:= Files(pversion,pFileUseOtherEnvironment).Base.Built(response_phone_1_status in key_phone_status or response_phone_2_status in key_phone_status);
	//
  shared dkeybuild		:= project(Base, transform(layouts.keybuild,  self := left));
	shared dKeybuildnorm := Normalize_Phone(pversion,pFileUseOtherEnvironment) (response_phone_status in key_phone_status);
	//
	shared FilterBdids	:= dkeybuild(bdid	!= 0);
	shared FilterBdidsNorm	:= dKeybuildnorm(bdid	!= 0);
	shared FilterDids		:= dkeybuild(did	!= 0);   
	
	tools.mac_FilesIndex('FilterBdids				,{bdid}	  										,{FilterBdids				}'	,keynames(pversion,pUseOtherEnvironment).Bdid							,Bdid 						);
	tools.mac_FilesIndex('FilterDids				,{did	}	  										,{FilterDids				}'	,keynames(pversion,pUseOtherEnvironment).Did							,Did	 						);
	tools.mac_FilesIndex('FilterBdidsNorm		,{bdid,response_company_phone},{FilterBdidsNorm		}'	,keynames(pversion,pUseOtherEnvironment).Bdid_phone				,Bdid_phone	 			);
end;