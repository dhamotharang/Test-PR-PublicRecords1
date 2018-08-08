export Build_Base(version) := module
//-------Concatenate all Email sources in a common layout-
#option('multiplePersistInstances',FALSE);

export entiera_src := Map_Entiera_as_Email(version);
export Impulse_src := Map_Impulse_as_Email(version) ;
export WiredAssets_src := Map_WiredAssets_as_Email(version) ;
export AcquireWeb_src := Map_AcquireWeb_as_Email(version) ;
export MediaOne_src := Map_MediaOne_as_Email(version) ;
//Bug 130671 
//export OutwardMedia_src := Map_OutwardMedia_as_Email(version) ;
export Thrive_src := Map_Thrive_as_Email(version) ;
export AlloyMedia_src := Map_AlloyMedia_as_Email(version);
export SalesChannel_src	:= Map_SalesChannel_As_Email(version);
export Datagence_src	:= Map_Datagence_As_Email(version);
export InfutorNARE_src	:= Map_InfutorNARE_As_Email(version);
export	Anchor_src	:= Map_Anchor_As_Email(version);
export RealSource_src	:= Map_RealSource_As_Email(version);

export email_sources := entiera_src +
				 Impulse_src +
				 WiredAssets_src +
				 AcquireWeb_src +
				 MediaOne_src +
				 //Bug 130671
				 //OutwardMedia_src +
				 Thrive_src +
				 AlloyMedia_src +
				 SalesChannel_src +
				 Datagence_src +
				 InfutorNARE_src +
				 Anchor_src	+
				 RealSource_src;

//-------Append data from Watchdog
export append_best_data    := Fn_Append_Best (email_sources);
//-------Append HHID
export append_hhid         := Fn_Append_Hhid(append_best_data) : persist('~persist::email_data::before_rollup'); 
//-------Rollup records with the same email, name, address
export rollup_email_orig   := Fn_Rollup_Email_Data_orig(append_hhid);
//-------Rollup records with the same email, name, address
export rollup_email        := Fn_Rollup_Email_Data(rollup_email_orig);
//------Propagate sources for records with the same email-did or same email and simillar name (when did = 0)
export propagate_src_email := Fn_Propagate_Src(rollup_email ) ;
//-----Propagate did to records with same email simillar name
export propagate_did   		:= Fn_Propagate_Did(propagate_src_email);
//-----Concatenate current base and previous base to create a final base with histor
export rollup_with_history := Fn_Rollup_Base_History(propagate_did);
//-----Concatenate current base and previoubase to create a final base with histor and misc emails
export rollup_with_history_misc := Fn_Append_Misc(rollup_with_history) ;  

end;