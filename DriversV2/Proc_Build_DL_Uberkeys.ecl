import roxiekeybuild, ut;
export Proc_Build_DL_Uberkeys( string fileDate) :=function;
logicalFileName := Constants.autokey_logical(fileDate);

   
   RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_DL_UberWords,
   												Constants.autokey_keyname+'UberWords'
   											  ,logicalFileName+'UberWords',
   										   Dict_Key);
   RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Key_DL_UberRefs,
   												Constants.autokey_keyname+'UberRefs'
   												,logicalFileName+'UberRefs',
   										   Inv_Key);
   										   
   
   RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Constants.autokey_keyname+'UberWords'
   										    ,logicalFileName+'UberWords',
   										  mv_Dict_Key_to_built); 
   RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Constants.autokey_keyname+'UberRefs'
   												,logicalFileName+'UberRefs',
   										  mv_Inv_Key_to_built); 
    
   										  
   
   	RoxieKeyBuild.MAC_SK_Move_v2(Constants.autokey_keyname+'UberWords', 'Q', mv_Dict_Key_to_qa);
   
   	RoxieKeyBuild.MAC_SK_Move_v2(Constants.autokey_keyname+'UberRefs', 'Q', mv_Inv_Key_to_qa);
   	
   //builds payload, inversion key and dictionary key										  
   build_Files := SEQUENTIAL(					Dict_Key,
												Inv_Key,
   												mv_Dict_Key_to_built
   												,mv_Inv_Key_to_built
   												,mv_Dict_Key_to_qa
   												,mv_Inv_Key_to_qa
   												
   												);
												
												return build_Files;
												end;