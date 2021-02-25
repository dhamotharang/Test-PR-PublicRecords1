/*
	-----------------------------------------------------------------------------------------
	-- mac_Patch_SPC
	-- This macro patches in the real calculated specificities(and number of records) to the SPC attribute and saves(sandboxes) it.  This makes it much easier
	-- to do this work especially for datasets with many fields.  
	-- Notes:
	-- 	it does not(at least in Boca Dataland) trigger the automatic SALT code generation once it saves the new SPC attribute(soap limitation). 
	--	If you do not want this macro to save the attribute for you, you can set pUpdateSPC to false, and it will output the new SPC as a string which can be 
	-- 	copy/pasted into the SPC attribute.
	-- 	The output when saving the attribute is the error message from the soapcall.  If it is blank, it worked.
	--	One thing to keep in mind is that by default, it will pull the sandboxed version of the SPC attribute specified.  If this is not wanted, 
	-- 	pSandbox can be set to false to pull the checked in version.  Keep in mind that one of those versions could be blank(if not checked in, etc).
	-- 	If the pOutSPCAttribute is populated, it will save the new SPC file to that attribute.  If the new SPC attribute does not exist, it will create it,
	--	but at the moment it will not create it as a SALT attribute, so if that is preferred, the attribute should be created beforehand as a SALT attribute.
	-- Example of its use(in boca dataland):
mspecs 		:= test.specificities(test.In_Base);
patchspc	:= SALTTOOLS4.mac_Patch_SPC(mspecs.Specificities,'test._SPC',test.In_Base,_control.MyInfo.UserID,_control.MyInfo.Password,'10.241.3.242:8145');
OUTPUT(mspecs.Specificities	,NAMED('Specificities'	));
OUTPUT(mspecs.SpcShift			,NAMED('SpcShift'				));
output(patchspc							,NAMED('SPCPatchOutput'	));
	-----------------------------------------------------------------------------------------	
*/
EXPORT mac_Patch_SPC(
	 pInSpecificities																// Input Specificities dataset
	,pSPCAttribute																	// Input SPC attribute
	,pInputFile																			// Input file specificities are built on
	,pConst						= 'SALT44._Config.Constants'	// Cluster-specific constants
	,pSandbox					= 'true'											// Get Sandboxed version?
	,pUpdateSPC				= 'true'											// should save the updated SPC file?  If true, saves it to repository and gives output of soapcall.  If false, outputs the updated SPC file
	,pOutSPCAttribute	= '\'\''											// use this if you want the output spc file attribute with the specificities appended to be different than the input SPC file attribute
) :=
functionmacro
	import SALTTOOLS4,SALT44;
	
	LOCAL pESP := pConst.attr_server; // ESP server & port for your environment(for soapcalls), e.g. Boca dataland is '10.241.3.242:8145'
	
	//Parse In SPC file
	LOCAL lindex 			:= stringlib.stringfind(pSPCAttribute,'.',1);
	LOCAL lmodule 		:= pSPCAttribute[1..(lindex - 1)];
	LOCAL lattribute 	:= pSPCAttribute[(lindex + 1)..];
	
	//Parse Out SPC file
	LOCAL OutSPCAttribute := if(pOutSPCAttribute = ''	,pSPCAttribute	,pOutSPCAttribute);
	LOCAL loutindex 			:= stringlib.stringfind(OutSPCAttribute,'.',1);
	LOCAL loutmodule 			:= OutSPCAttribute[1..(loutindex - 1)];
	LOCAL loutattribute 	:= OutSPCAttribute[(loutindex + 1)..];
	
	//Soapcall to Get SPC attribute
	LOCAL datts_raw := SALTTOOLS4.mod_Soapcalls.fFindAttributes(lmodule,lattribute,pESP,true,pIsSandbox := pSandbox);
	LOCAL spcString := datts_raw[1].text;
	LOCAL newSPC := SALTTOOLS4.mac_Patch_spcString(pInSpecificities, pInputFile, spcString, loutmodule);	
	
	//Soapcall to Save attribute to repository
	LOCAL updateSPC := SALTTOOLS4.mod_Soapcalls.fSaveAttribute(loutmodule,loutattribute,newSPC,pESP);
	return iff(pUpdateSPC = true	and trim(newSPC) != ''	, updateSPC[1].exception_msg	
   			,iff(trim(newSPC)  = ''												, 'Your SPC File was blank.  Try setting the pSandbox parameter to ' + if(pSandbox	,'false.','true.')
   			,																												 	 		newSPC
  ));
endmacro;
