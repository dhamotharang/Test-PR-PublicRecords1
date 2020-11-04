import didville, Gong_v2, watchdog, phonesplus, mdr, Address, STD, PromoteSupers, _Control,$;
//DF-27472 added $ qualifier to function calls for cleanup

export Proc_build_base(string pversion,string emailList='', boolean isTest = false):=function
//-------Concatenate all Pplus sources in a common layout---------------------------------
pplus_sources := 
         $.Map_Cellphone_as_Phonesplus +
				 $.Map_GongH_as_Phonesplus +
				 $.Map_Header_as_Phonesplus +
				 $.Map_InfutorCid_as_Phonesplus +
				// $.Map_InfutorTracker_as_Phonesplus +
				 $.Map_Intrado_as_Phoneplus +
				 $.Map_Pcnsr_as_Phonesplus +
				 $.Map_TargusWP_as_Phonesplus +
				 $.Map_Utility_as_Phonesplus +
				 $.Map_WiredAssets_as_Phonesplus(true) + 
				 $.Map_InquiryAccLogs_as_Phonesplus +
				 // $.Map_IBehavior_as_Phonesplus +
				 $.Map_Thrive_as_Phonesplus +
				 $.Map_AlloyMedia_as_Phonesplus +
				 $.Map_NVerified_as_Phonesplus +
				 $.Map_NeustarWireless_as_Phonesplus //Jira: DF-24336
				 ;

pplus_royalty := $.Map_WiredAssets_as_Phonesplus(false);	

Remove_overlaping_royalty:= $.Fn_Remove_Overlap_Royalty(pplus_sources, pplus_royalty);
// ------ Remove EDA---------------------------------------------------------------------
no_EDA := $.Fn_Exclude_EDA(Remove_overlaping_royalty);
//-------Filter records where did is classfied as DEAD, NOISE or H_MERGE-------------------				 
Filter_on_DID_Class:= $.Fn_Filter_on_DID_Class(no_EDA);
//:persist('~thor_data400::persist::Phonesplus::Filter_on_DID_Class');

//-------Apply AID------------------------------------------------------------------------			 
Apply_AID:= $.Fn_Apply_AID(Filter_on_DID_Class);
//:persist('~thor_data400::persist::Phonesplus::Apply_AID');


//-------Append Temp did for records that don't have a did---------------------------------				 
Append_Temp_Did	 := $.Fn_Append_Temp_Did(Apply_AID);

//-------Append Data from Telecordia based on npa, nxx-------------------------------------
Append_Phone_Data:= $.Fn_Append_Phone_Data(Append_Temp_Did);

//-------Determine best area code for a group of records with same did, and phoneL7--------
Sync_Npa 		 := $.Fn_Sync_Npa(Append_Phone_Data);
//:persist('~thor_data400::persist::Phonesplus::Sync_Npa');

//DF-25784 - suppression of obscene words was moved to before rollup
IsObsceneWord(string word) := Address.SpecialNames.IsObsceneToken(Address.WordSplit(word));

suppress_obscene := Sync_Npa (cellphone not in $.Set_Supress.phone and
																 ~IsObsceneWord(origname) and 
																 ~IsObsceneWord(address1) and 
																 ~IsObsceneWord(address2)  and
																 ~IsObsceneWord(origcity) and
																 ~IsObsceneWord(fname) and
																 ~IsObsceneWord(mname) and
																 ~IsObsceneWord(lname)); 	



//DF-25784 
source_level := $.Fn_Apply_Opt_Out(suppress_obscene):persist('~thor_data400::persist::Phonesplus::source_level_detail'); 	
	
//-------Rollup records to have one record per combination of name, address, phoneL7--------
Rollup_Phplus 	 := $.Fn_Rollup_as_Phonesplus(source_level)
:persist('~thor_data400::persist::Phonesplus::Rollup_Phplus');

//-----Sync Phone Type
Sync_Phone_type := $.Fn_Sync_Phone_Type(Rollup_Phplus);

//-------Append non-published flags---------------------------------------------------------
Append_Non_Pub	 := $.Fn_Append_NonPub(Sync_Phone_type);

//-------Append eda match flag--------------------------------------------------------------
Append_Eda		 := $.Fn_Append_Gong(Append_Non_Pub);

//-------Append eda history match flag------------------------------------------------------
Append_Eda_Hist	 := $.Fn_Append_GongH(Append_Eda);

//-------Append feedback flags--------------------------------------------------------------
Append_Feedback  := $.Fn_Append_Feedback(Append_Eda_Hist);

//-------Append best address match flag-----------------------------------------------------
Append_Best		 := $.Fn_Apppend_Best(Append_Feedback);

//-------Append ported match flag-----------------------------------------------------------
Append_Ported	 := $.Fn_Append_Ported(Append_Best);

//-------append hhid-----------------------------------------------------------------------
Append_HHId	    := $.Fn_Append_HHId(Append_Ported);
//:persist('~thor_data400::persist::Phonesplus::Append_HHid');

//-------Append phone ownership stats-------------------------------------------------------
Append_Ownership := $.Fn_Append_Phone_Ownership(Append_HHId);
//:persist('~thor_data400::persist::Phonesplus::Append_Phone_Ownership');

//-------Flag EDA History(neutral rule------------------------------------------------------
Apply_EDA_History:= $.Fn_Flag_EDA_History(Append_Ownership);

//-------Apply Rules------------------------------------------------------------------------	
Apply_Rules := $.Fn_Apply_Rules(Apply_EDA_History);

//-------Propagate Rules--------------------------------------------------------------------
Propagate_rules := $.Fn_Propagate_Rules(Apply_Rules);

//-------Place cellphones with DID  where current above the line doesn't have one 
Add_dids := $.Fn_Add_Cellphone_Did(Propagate_rules);

//-------Propagate Rules Again---------------------------------------------------------------
Propagate_rules2 := $.Fn_Propagate_Rules(Add_dids);

//-------Reformat layout to be the same as old layout----------------------------------------
Eliminate_duplications := $.Fn_Eliminate_Duplications(Propagate_rules2);
//:persist('~thor_data400::persist::Phonesplus::eliminate_duplications');

//-------Verify with Insurance and File One 
Verify_With_Ins_File1 := $.Fn_Phone_Verification(Eliminate_duplications, pversion);

//-------Add other household members for landlines------------------------------------------
Add_Header_Household := $.Fn_Add_Header_Household(Verify_With_Ins_File1);

//DF-25784 - suppression of obscene words was moved to before rollup

//-------Map v2 fields---------------------------------------------------------------------
Map_v1_Fields := $.Fn_Map_v1_Fields(Add_Header_Household);
//:persist('~thor_data400::persist::Phonesplus::Map_v1_Fields');

//DF-27472 update rules field for detail records
//non-royalty records only, add household record to detail
source_level_detail				:= $.Fn_Sync_Phone_Type(source_level); //DF-28420: Sync Source Level Base Phone Fields
source_level_non_royalty 	:= source_level_detail(source <> mdr.sourceTools.src_wired_assets_royalty) 
														+ Map_v1_Fields(household_flag = true and ~$.Translation_Codes.fFlagIsOn(src_all, $.Translation_Codes.source_bitmap_code(mdr.sourceTools.src_wired_assets_royalty)));
											 
dist_source_level  := sort(distribute(source_level_non_royalty, hash32(cellphoneidkey)), cellphoneidkey, household_flag, local);
dist_dedup_summary := dedup(sort(distribute(Map_v1_Fields, hash32(cellphoneidkey)), cellphoneidkey, household_flag, local), cellphoneidkey, household_flag, local);
	
$.Layout_In_Phonesplus.Layout_In_Common updateRulesDetail($.Layout_In_Phonesplus.Layout_In_Common detail, $.Layout_In_Phonesplus.Layout_In_Common summary) := TRANSFORM
	self.rules := summary.rules,
	self := detail
END;	
	
source_level_rules_updated := join(dist_source_level,
																			dist_dedup_summary,
																			left.cellphoneidkey = right.cellphoneidkey
																			and left.household_flag = right.household_flag,
																			updateRulesDetail(LEFT,RIGHT),
																			left outer,																			
																			local);

//DF-24903 remove Nuestar Wireless rules that may have been propagated to non-nuestar wireless sources
recordof(Map_v1_Fields) t_n2_clean(Map_v1_Fields le) := transform 
	self.rules 	:= if(~$.Translation_Codes.fFlagIsOn(le.src_all, $.Translation_Codes.source_bitmap_code(mdr.sourceTools.src_NeustarWireless)),
										$.Translation_codes.fClearNeustarRules(le.rules),
										le.rules);
							
  self := le;
end;

Neustar_Wireless_Rules_Cleanup := project(Map_v1_Fields, t_n2_clean(left))
:persist('~thor_data400::persist::Phonesplus::Neustar_Wireless_Rules_Cleanup');
													
//apply virtual global sid
apply_virtual_global_sid :=   MDR.macGetGlobalSid(Neustar_Wireless_Rules_Cleanup, 'PhonesplusV2_Virtual', '', 'global_sid');	
v2_base := Project(apply_virtual_global_sid, $.Layout_PhonesPlus_Base);

//------Invoke Scrubs---------------------------------------------------------------------
scrubscall := $.Fn_Invoke_scrubs(v2_base, pversion,emailList); 
//-------Rollup previous base file and current file

split_Phonesplus := v2_base(~($.Translation_Codes.fFlagIsOn(src_all, $.Translation_Codes.source_bitmap_code(mdr.sourceTools.src_wired_assets_royalty))));

split_Royalty := v2_base($.Translation_Codes.fFlagIsOn(src_all, $.Translation_Codes.source_bitmap_code(mdr.sourceTools.src_wired_assets_royalty)));

Rollup_base := $.Fn_Rollup_Base(split_Phonesplus, 'phonesplus_main', pversion);

Rollup_royalty_base := $.Fn_Rollup_Base(split_Royalty, 'royalty', pversion);

Transform_to_old_layout := $.Fn_Transform_to_Old_Layout(Rollup_base);

//DF-25784 - build source level detail base file
	//only keep records that match the ones in the final rolled-up dataset
	source_level_dist  := sort(distribute(source_level_rules_updated, hash32(cellphoneidkey)), cellphoneidkey, local);
	dedup_summary_dist := dedup(sort(distribute(Rollup_base(current_rec=true), hash32(cellphoneidkey)), cellphoneidkey, local), cellphoneidkey, local);
	
$.Layout_Source_Level_Base doJoin($.Layout_In_Phonesplus.Layout_In_Common detail, $.Layout_PhonesPlus_Base summary) := TRANSFORM
		self.did := if (detail.pdid = 0, detail.did, 0),
		self.current_rec := true,
		self.first_build_date := (unsigned)pversion,
    self.last_build_date := (unsigned)pversion,
		self := detail;
	END;	
	
	source_level_prep := join(source_level_dist,
														dedup_summary_dist,
														left.cellphoneidkey = right.cellphoneidkey,
														doJoin(LEFT,RIGHT),
														local);
										 
	IngestModDetail			:= 	 $.Ingest_Source_Level_Base(infile:=source_level_prep);
		
	// Project output of ingest process to base an populate current_rec based the _typ tag added by the ingest process
	// Unknown = 1 Ancient = 2 Old = 3 Unchanged = 4 Updated = 5 New = 6
	source_level_base_after_ingest	:=  Project(IngestModDetail.AllRecords, TRANSFORM($.Layout_Source_Level_Base, self.ingest_tpe := LEFT.__Tpe; self.current_rec := IF(LEFT.__Tpe in [2,3],FALSE,TRUE); self := LEFT; SELF:= [];));
//																																																														

																
PromoteSupers.MAC_SF_BuildProcess(Rollup_base,$.Names.phonesplusv2_base,pplusv2_base,3,,true, pversion);
PromoteSupers.MAC_SF_BuildProcess(Rollup_royalty_base,$.Names.phonesplusv2_royalty_base,pplus_royalty_v2_base,3,,true, pversion);
PromoteSupers.MAC_SF_BuildProcess(Transform_to_old_layout,$.Names.phonesplus_base,pplus_base,3,,true, pversion);
PromoteSupers.Mac_SF_BuildProcess(source_level_base_after_ingest, $.Names.source_level_base, promote_source_level_detail_base,3,,true,pVersion);//DF-25784 
	
create_base_files_and_promote := sequential(scrubscall, pplus_base,	pplusv2_base, pplus_royalty_v2_base, promote_source_level_detail_base);

pplusv2_base_test := output(Rollup_base,,$.Names.phonesplusv2_base+'_test_' + pversion,overwrite,compressed);
pplus_royalty_v2_base_test := output(Rollup_royalty_base,,$.Names.phonesplusv2_royalty_base+'_test_' + pversion,overwrite,compressed);
pplus_base_test := output(Transform_to_old_layout,,$.Names.phonesplus_base+'_test_' + pversion,overwrite,compressed);
source_level_detail_base_test 	:= output(source_level_base_after_ingest,,$.Names.source_level_base + '_test_' + pversion,overwrite,compressed);//DF-25784 

create_test_files := sequential(pplusv2_base_test, pplus_royalty_v2_base_test, pplus_base_test, source_level_detail_base_test);
									
RETURN  SEQUENTIAL(
										if(isTest, create_test_files, create_base_files_and_promote),
											 //DF-25784 - produce stats for source level base file
											 IngestModDetail.DoStats,
											 IngestModDetail.ValidityStats
										);

end;
								