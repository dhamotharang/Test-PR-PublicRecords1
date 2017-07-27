export Build_Base(version) := function
//-------Concatenate all Email sources in a common layout-


entiera_src := Map_Entiera_as_Email(version);
Impulse_src := Map_Impulse_as_Email(version) ;
WiredAssets_src := Map_WiredAssets_as_Email(version) ;
AcquireWeb_src := Map_AcquireWeb_as_Email(version) ;
MediaOne_src := Map_MediaOne_as_Email(version) ;
OutwardMedia_src := Map_OutwardMedia_as_Email(version) ;

email_sources := entiera_src +
				 Impulse_src +
				 WiredAssets_src +
				 AcquireWeb_src +
				 MediaOne_src +
				 OutwardMedia_src;	
//-------Rollup records with the same email, name, address
rollup_email        := Fn_Rollup_Email_Data(email_sources);
//-------Append data from Watchdog
append_best_data    := Fn_Append_Best (rollup_email);
//-------Append HHID
append_hhid         := Fn_Append_Hhid(append_best_data); 
//------Propagate sources for records with the same email-did or same email and simillar name (when did = 0)
propagate_src_email := Fn_Propagate_Src(append_hhid);
//-----Propagate did to records with same email simillar name
propagate_did   		:= Fn_Propagate_Did(propagate_src_email);
//-----Concatenate current base and previous base to create a final base with histor
rollup_with_history := Fn_Rollup_Base_History(propagate_did);

return rollup_with_history;
end;
