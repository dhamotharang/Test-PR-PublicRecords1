EXPORT Build_Base(version) := MODULE
//-------Concatenate all Email sources in a common layout-
#OPTION('multiplePersistInstances',FALSE);

EXPORT RealSource_src	:= Map_RealSource_As_Email(version);
EXPORT AcquireWeb_src := Map_AcquireWeb_as_Email(version);
EXPORT AcquireWeb_Plus_src := Map_AcquireWebPlus_As_Email(version);
EXPORT Anchor_src	:= Map_Anchor_As_Email(version);
EXPORT Datagence_src	:= Map_Datagence_As_Email(version);
EXPORT SalesChannel_src	:= Map_SalesChannel_As_Email(version);
EXPORT InfutorNARE_src	:= Map_InfutorNARE_As_Email(version);
EXPORT Thrive_src := Map_Thrive_as_Email(version);
EXPORT AlloyMedia_src := Map_AlloyMedia_as_Email(version);
EXPORT MediaOne_src := Map_MediaOne_as_Email(version);
EXPORT entiera_src := Map_Entiera_as_Email(version);
EXPORT Impulse_src := Map_Impulse_as_Email(version);
EXPORT WiredAssets_src := Map_WiredAssets_as_Email(version);

EXPORT email_sources := RealSource_src +
												AcquireWeb_src +
												AcquireWeb_Plus_src +
												Anchor_src	+
												Datagence_src +
												SalesChannel_src +
												InfutorNARE_src +
												Thrive_src +
												AlloyMedia_src +
												MediaOne_src +
												entiera_src +
												Impulse_src +
												WiredAssets_src;

//Set Filtering Rules
EXPORT set_rules					:= Fn_Apply_Rules(email_sources);
//-------Append data from Watchdog --Removing as new requirements do not want cross contamination of data
//EXPORT append_best_data   := Fn_Append_Best(set_rules);
//-------Append HHID
EXPORT append_hhid        := Fn_Append_Hhid(set_rules);
//-----Propagate did to records with same email simillar name
EXPORT propagate_did   		:= Fn_Propagate_Did(append_hhid);
//-----Rollup current and previous base file --Rollup includes source code to not have cross contamination of data across sources
EXPORT rollup_with_history	:= Fn_Rollup_Base(propagate_did);

END;