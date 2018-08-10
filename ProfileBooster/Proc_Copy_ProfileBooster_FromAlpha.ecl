import std,_control;

EXPORT Proc_Copy_ProfileBooster_FromAlpha(string Version) := FUNCTION

//******************************************************************************************************************
//**                                Copy Profile Booster Data from Alpa to Boca
// Copy(const varstring sourceLogicalName, const varstring destinationGroup, const varstring destinationLogicalName, const varstring sourceDali='', integer4 timeOut=-1, const varstring espServerIpPort=GETENV('ws_fs_server'), integer4 maxConnections=-1, boolean allowoverwrite=false, boolean replicate=false, boolean asSuperfile=false, boolean compress=false, boolean forcePush=false, integer4 transferBufferSize=0, boolean preserveCompression=true) : c,action,context,entrypoint='fsCopy_v2'; 
//******************************************************************************************************************

srce 				:= '~in::marketmagnifier::profileboosterin::' + Version;
destGrp 		:= 'thor400_44';
destsrce 		:= '~in::marketmagnifier::profileboosterin::' + Version;
sourceDali 	:= '10.194.112.105';
      

 mycopy := fileservices.Copy(srce           // const varstring sourceLogicalName,                        
                 ,destGrp         // const varstring destinationGroup,                         
                 ,destsrce        // const varstring destinationLogicalName,                   
                 ,sourceDali      // const varstring sourceDali='',                            
                 ,-1              // integer4 timeOut=-1,                                      
                 ,	         			// const varstring espServerIpPort=GETENV('ws_fs_server'),   
                 ,-1              // integer4 maxConnections=-1,                               
                 ,true            // boolean allowoverwrite=false,                             
                 ,true            // boolean replicate=false,                                  
                 ,false	      		// !!!! boolean asSuperfile=false,                                
                 ,true	          // boolean compress=false,                                 
                 ,	             	// boolean forcePush=false,                                
                 ,                // integer4 transferBufferSize=0,                          
                 ,true		   			// boolean preserveCompression=true
                 );
								 


Return mycopy;

END;