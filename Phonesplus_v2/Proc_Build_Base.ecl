import didville, Gong_v2, watchdog, phonesplus, ut, mdr, Address, STD;

export Proc_build_base(string pversion,string emailList=''):=function
//-------Concatenate all Pplus sources in a common layout---------------------------------
pplus_sources := 
         Map_Cellphone_as_Phonesplus +
				 Map_GongH_as_Phonesplus +
				 Map_Header_as_Phonesplus +
				 Map_InfutorCid_as_Phonesplus +
				// Map_InfutorTracker_as_Phonesplus +
				 Map_Intrado_as_Phoneplus +
				 Map_Pcnsr_as_Phonesplus +
				 Map_TargusWP_as_Phonesplus +
				 Map_Utility_as_Phonesplus +
				 Map_WiredAssets_as_Phonesplus(true) + 
				 Map_InquiryAccLogs_as_Phonesplus +
				 // Map_IBehavior_as_Phonesplus +
				 Map_Thrive_as_Phonesplus +
				 Map_AlloyMedia_as_Phonesplus +
				 Map_NVerified_as_Phonesplus;

pplus_royalty := Map_WiredAssets_as_Phonesplus(false);	

Remove_overlaping_royalty:= Fn_Remove_Overlap_Royalty(pplus_sources, pplus_royalty);
// ------ Remove EDA---------------------------------------------------------------------
no_EDA := Fn_Exclude_EDA(Remove_overlaping_royalty);
//-------Filter records where did is classfied as DEAD, NOISE or H_MERGE-------------------				 
Filter_on_DID_Class:= Fn_Filter_on_DID_Class(no_EDA)
:persist('~thor_data400::persist::Phonesplus::Filter_on_DID_Class');

//-------Apply AID------------------------------------------------------------------------			 
Apply_AID:= phonesplus_v2.Fn_Apply_AID(Filter_on_DID_Class)
:persist('~thor_data400::persist::Phonesplus::Apply_AID');


//-------Append Temp did for records that don't have a did---------------------------------				 
Append_Temp_Did	 := Fn_Append_Temp_Did(Apply_AID);

//-------Append Data from Telecordia based on npa, nxx-------------------------------------
Append_Phone_Data:= Fn_Append_Phone_Data(Append_Temp_Did);

//-------Determine best area code for a group of records with same did, and phoneL7--------
Sync_Npa 		 := Fn_Sync_Npa(Append_Phone_Data)
:persist('~thor_data400::persist::Phonesplus::Sync_Npa');
										  
//-------Rollup records to have one record per combination of name, address, phoneL7--------
Rollup_Phplus 	 := Fn_Rollup_as_Phonesplus(Sync_Npa)
:persist('~thor_data400::persist::Phonesplus::Rollup_Phplus');

//-----Sync Phone Type
Sync_Phone_type := Fn_Sync_Phone_Type(Rollup_Phplus);

//-------Append non-published flags---------------------------------------------------------
Append_Non_Pub	 := Fn_Append_NonPub(Sync_Phone_type);

//-------Append eda match flag--------------------------------------------------------------
Append_Eda		 := Fn_Append_Gong(Append_Non_Pub);

//-------Append eda history match flag------------------------------------------------------
Append_Eda_Hist	 := Fn_Append_GongH(Append_Eda);

//-------Append feedback flags--------------------------------------------------------------
Append_Feedback  := Fn_Append_Feedback(Append_Eda_Hist);

//-------Append best address match flag-----------------------------------------------------
Append_Best		 := Fn_Apppend_Best(Append_Feedback);

//-------Append ported match flag-----------------------------------------------------------
Append_Ported	 := Fn_Append_Ported(Append_Best);

//-------append hhid-----------------------------------------------------------------------
Append_HHId	    := Fn_Append_HHId(Append_Ported)
:persist('~thor_data400::persist::Phonesplus::Append_HHid');

//-------Append phone ownership stats-------------------------------------------------------
Append_Ownership := Fn_Append_Phone_Ownership(Append_HHId)
:persist('~thor_data400::persist::Phonesplus::Append_Phone_Ownership');

//-------Flag EDA History(neutral rule------------------------------------------------------
Apply_EDA_History:= Fn_Flag_EDA_History(Append_Ownership);

//-------Apply Rules------------------------------------------------------------------------	
Apply_Rules := Fn_Apply_Rules(Apply_EDA_History);

//-------Propagate Rules--------------------------------------------------------------------
Propagate_rules := Fn_Propagate_Rules(Apply_Rules);

//-------Place cellphones with DID  where current above the line doesn't have one 
Add_dids := Fn_Add_Cellphone_Did(Propagate_rules);

//-------Propagate Rules Again---------------------------------------------------------------
Propagate_rules2 := Phonesplus_v2.Fn_Propagate_Rules(Add_dids);

//-------Reformat layout to be the same as old layout----------------------------------------
Eliminate_duplications := Fn_Eliminate_Duplications(Propagate_rules2)
:persist('~thor_data400::persist::Phonesplus::eliminate_duplications');

//-------Verify with Insurance and File One 
Verify_With_Ins_File1 := Fn_Phone_Verification(Eliminate_duplications, pversion);

//-------Add other household members for landlines------------------------------------------
Add_Header_Household := Fn_Add_Header_Household(Verify_With_Ins_File1);

IsObsceneWord(string word) := Address.SpecialNames.IsObsceneToken(Address.WordSplit(word));

supress_data := Add_Header_Household (cellphone not in Phonesplus_v2.Set_Supress.phone and
																 /*~Address.SpecialNames.IsObsceneToken(STD.STr.SplitWords(origname,' ')) and 
																 ~Address.SpecialNames.IsObsceneToken(STD.STr.SplitWords(address1,' ')) and 
																 ~Address.SpecialNames.IsObsceneToken(STD.STr.SplitWords(address2,' '))  and
																 ~Address.SpecialNames.IsObsceneToken(STD.STr.SplitWords(origcity,' ')) and
																 ~Address.SpecialNames.IsObsceneToken(STD.STr.SplitWords(fname,' ')) and
																 ~Address.SpecialNames.IsObsceneToken(STD.STr.SplitWords(mname,' ')) and
																 ~Address.SpecialNames.IsObsceneToken(STD.STr.SplitWords(lname,' ')));*/
																 ~IsObsceneWord(origname) and 
																 ~IsObsceneWord(address1) and 
																 ~IsObsceneWord(address2)  and
																 ~IsObsceneWord(origcity) and
																 ~IsObsceneWord(fname) and
																 ~IsObsceneWord(mname) and
																 ~IsObsceneWord(lname));
//-------Map v2 fields---------------------------------------------------------------------
Map_v1_Fields := Fn_Map_v1_Fields(supress_data);

//------Invoke Scrubs---------------------------------------------------------------------l

scrubscall := Phonesplus_v2.Fn_Invoke_scrubs(Map_v1_Fields, pversion,emailList); 
//-------Rollup previous base file and current file

split_Phonesplus := Map_v1_Fields(~(Translation_Codes.fFlagIsOn(src_all, Translation_Codes.source_bitmap_code(mdr.sourceTools.src_wired_assets_royalty))));

split_Royalty := Map_v1_Fields(Translation_Codes.fFlagIsOn(src_all, Translation_Codes.source_bitmap_code(mdr.sourceTools.src_wired_assets_royalty)));

Rollup_base := Fn_Rollup_Base(split_Phonesplus, 'phonesplus_main', pversion);

Rollup_royalty_base := Fn_Rollup_Base(split_Royalty, 'royalty', pversion);

Transform_to_old_layout := Fn_Transform_to_Old_Layout(Rollup_base);

ut.MAC_SF_BuildProcess(Rollup_base ,'~thor_data400::base::phonesplusv2',pplusv2_base,3,,true, pversion);
ut.MAC_SF_BuildProcess(Rollup_royalty_base,'~thor_data400::base::phonesplusv2_royalty',pplus_royalty_v2_base,3,,true, pversion);
ut.MAC_SF_BuildProcess(Transform_to_old_layout,'~thor_data400::base::phonesplus',pplus_base,3,,true, pversion);

return sequential(scrubscall,
                                     pplus_base,
																		 pplusv2_base, pplus_royalty_v2_base);
end;
																		