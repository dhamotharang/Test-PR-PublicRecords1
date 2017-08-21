import didville, Gong_v2, watchdog, phonesplus, ut;

//-------Concatenate all Pplus sources in a common layout---------------------------------
pplus_sources := Map_Cellphone_as_Phonesplus +
				 Map_GongH_as_Phonesplus +
				 Map_Header_as_Phonesplus +
				 Map_InfutorCid_as_Phonesplus +
				 //Map_InfutorTracker_as_Phonesplus +
				 Map_Intrado_as_Phoneplus +
				 Map_Pcnsr_as_Phonesplus +
				 Map_TargusWP_as_Phonesplus +
				 Map_Utility_as_Phonesplus ;	
				 
//-------Apply AID------------------------------------------------------------------------			 
Apply_AID:= phonesplus_v2.Fn_Apply_AID(pplus_sources)
:persist('~thor_data400::persist::Phonesplus::Apply_AID');
				 
//-------Filter records where did is classfied as DEAD, NOISE or H_MERGE-------------------				 
Filter_on_DID_Class:= Fn_Filter_on_DID_Class(Apply_AID)
:persist('~thor_data400::persist::Phonesplus::Filter_on_DID_Class');
		
//-------Append Temp did for records that don't have a did---------------------------------				 
Append_Temp_Did	 := Fn_Append_Temp_Did(Filter_on_DID_Class);

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
												
//-------Apply EDA exclusion rule-----------------------------------------------------------
Apply_EDA	   := Fn_Exclude_EDA(Append_Ownership)
:persist('~thor_data400::persist::Phonesplus::Score_EDA');

//-------Flag EDA History(neutral rule------------------------------------------------------
Apply_EDA_History:= Fn_Flag_EDA_History(Apply_EDA);
				
//------Apply Basic Exclusion rules---------------------------------------------------------
Apply_Basic_Exclusion := Fn_Apply_Basic_Exclusion_Rules(Apply_EDA_History);

//------Apply Basic Inclusion rules---------------------------------------------------------
Apply_Basic_Inclusion := Fn_Apply_Basic_Inclusion_Rules(Apply_Basic_Exclusion);

//------Apply Exclussion rule for Non-pub assigned to someone else---------------------------
Apply_NonPub_Exclusion := Fn_Apply_NonPub_Exclusion_Rule(Apply_Basic_Inclusion );
//------Apply Inclusion Source Last Resort --------------------------------------------------
Apply_Last_Resort := Fn_Apply_Last_Resort_Inclusion_Rules(Apply_NonPub_Exclusion)
:persist('~thor_data400::persist::Phonesplus::Source_Last_resort');

//------Apply Inclusion Vendor Conf Type Last Resort -----------------------------------------
Apply_Last_Resort_Vendor_Conf := Fn_Apply_Vendor_Conf_Last_Resort_Rule(Apply_Last_Resort)
:persist('~thor_data400::persist::Phonesplus::Vendor_Conf_Last_resort');

//-------Propagate inclusion/exclusion flag for indivs----------------------------------------
Propagate_Indiv := Fn_Propagate_Indiv(Apply_Last_Resort_Vendor_Conf);


//-------Propagate inclusion/exclusion flag for hhid------------------------------------------
Propagate_Household := Fn_Propagate_Household(Propagate_Indiv);

//-------Propagate inclusion/exclusion flag for indivs pass 2---------------------------------
Propagate_Indiv2 := Fn_Propagate_Indiv(Propagate_Household);


//------Flag records not included because phone already included for someone else------------
Already_Incuded_for_Someone_else := Fn_Flag_Phone_Already_Included(Propagate_Indiv2);

//-------Reformat layout to be the same as old layout----------------------------------------
Eliminate_duplications := Fn_Eliminate_Duplications(Already_Incuded_for_Someone_else)
:persist('~thor_data400::persist::Phonesplus::eliminate_duplications');

//-------Add other household members for landlines------------------------------------------
Add_Header_Household := Fn_Add_Header_Household(Eliminate_duplications);

//-------Rollup previous base file and current file
Rollup_base := Fn_Rollup_Base(Add_Header_Household);
ut.MAC_SF_BuildProcess(Rollup_base,'~thor_data400::base::phonesplusv2',pplusv2_base,3,,true, Phonesplus.version);
//-------Add other household members for landlines------------------------------------------
Transform_to_old_layout := Fn_Transform_to_Old_Layout(Rollup_base);

export Proc_build_base := sequential(pplusv2_base,
																		 output(Transform_to_old_layout,,'~thor_data400::out::phonesplus_did_' + Phonesplus.version,overwrite,__compressed__));
																		 
																		 
					