EXPORT ReadMe := 

// Process need to run based on different scenarios
//1. Create and Update Receive Item during spray which is outside of build scope ( Base and Keys).Run these process in sequential
//   Sequential ( Orbit3.proc_Create_Receive_LoadItem , Orbit3.proc_Orbit3_CreateBuild_AddItems_InFile)
//        -- Usage --> This will create and update receive item status to LOADED and output to the file with buildname and build vs as filename and the field is receiveinstanceid which is need to reconcile the items later once build is completed
 // 2.Create and Update Receive Item and add the item to the build -- all in one go
 // Orbit3.proc_CreateBuild_Item_AddItem
 // -- Usage -->  This will create item ,create build instance and add the item to the build instance