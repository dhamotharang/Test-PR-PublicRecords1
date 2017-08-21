import ut;
royalty_f := Map_WiredAssets_as_Phonesplus(false);	
//-------Remove records that overlap with phonesplus---------------------------------------
Remove_Overlap := Fn_Remove_Royalty_Overlap(royalty_f);
//-------Filter records where did is classfied NOISE or H_MERGE----------------------------				 
Filter_on_DID_Class	:= Fn_Filter_on_DID_Class(Remove_Overlap);
//-------Append Data from Telecordia based on npa, nxx-------------------------------------
Append_Phone_Data		:= Fn_Append_Phone_Data(Filter_on_DID_Class);
//-------Rollup records to have one record per combination of name, address, phoneL7--------
//-----Sync Phone Type
Sync_Phone_type 		:= Fn_Sync_Phone_Type(Append_Phone_Data);
//-------Append non-published flags---------------------------------------------------------
Append_Non_Pub	 := Fn_Append_NonPub(Sync_Phone_type);
//-------Append eda match flag--------------------------------------------------------------
Append_Eda		 			:= Fn_Append_Gong(Append_Non_Pub);
//-------Append eda history match flag------------------------------------------------------
Append_Eda_Hist	 		:= Fn_Append_GongH(Append_Eda);
//-------Append feedback flags--------------------------------------------------------------
Append_Feedback  := Fn_Append_Feedback(Append_Eda_Hist);
//-------Append best address match flag-----------------------------------------------------
Append_Best		 := Fn_Apppend_Best(Append_Feedback);
//-------Append ported match flag-----------------------------------------------------------
Append_Ported	 := Fn_Append_Ported(Append_Best);
//-------append hhid-----------------------------------------------------------------------
Append_HHId	    := Fn_Append_HHId(Append_Ported);
//-------Append phone ownership stats-------------------------------------------------------
Append_Ownership := Fn_Append_Phone_Ownership(Append_HHId);
//-------Map v2 fields---------------------------------------------------------------------
Map_v1_Fields := Fn_Map_v1_Fields(Append_Ownership);
//-------Apply EDA exclusion rule-----------------------------------------------------------
Apply_EDA	   := Fn_Exclude_EDA(Map_v1_Fields);
//-------Rollup previous base file and current file
Rollup_base := Fn_Rollup_Base(Apply_EDA	, 'royalty');
ut.MAC_SF_BuildProcess(Rollup_base,'~thor_data400::base::phonesplusv2_royalty',pplus_royalty_v2_base,3,,true, Phonesplus_v2.version);
export Proc_Build_Royalty_Base := sequential(pplus_royalty_v2_base);