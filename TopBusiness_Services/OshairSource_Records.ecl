//=================================================================================
// ======  RETURNS Oshair DATA FOR A GIVEN Linkids or Activity Numner        ======
// ================================================================================
//
IMPORT BIPV2, iesp, Oshair_Services, TopBusiness_Services;

EXPORT OshairSource_Records(
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
	SourceService_Layouts.OptionsLayout inoptions,
  boolean IsFCRA = false
) := MODULE

	SHARED oshair_layout_wLinkIds := RECORD
		Layouts.rec_input_ids_wSrc;
		Oshair_Services.Layouts.SourceOutput;
	END;
  
  // For in_docids records that don't have IdValues (activity_numbers) retrieve them from linkid file
	in_docs_linkonly := PROJECT(in_docids(IdValue = ''),TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
	
	// *** Key fetch to get oshair activity id's
  ds_oshairkeys := PROJECT(TopBusiness_Services.Key_Fetches(in_docs_linkonly,inoptions.fetch_level,
	                                                        TopBusiness_Services.Constants.SlimKeepLimit
													                                 ).ds_osha_linkidskey_recs,
													 TRANSFORM(Layouts.rec_input_ids_wSrc,
															SELF.IdValue := (STRING) LEFT.activity_number,
															SELF := LEFT,
															SELF := []));
	
	oshair_keys_comb := in_docids+ds_oshairkeys;
	
	oshair_keys := PROJECT(oshair_keys_comb(IdValue != ''),TRANSFORM(Oshair_Services.layouts.id,SELF.activity_number := (INTEGER) LEFT.IdValue,SELF := []));
  
	oshair_keys_dedup := DEDUP(oshair_keys,ALL);
	
	// Get report via activity_number
	oshair_sourceview := Oshair_Services.Raw.Source_View.by_id(oshair_keys_dedup);

	SHARED oshair_sourceview_wLinkIds := JOIN(oshair_sourceview,oshair_keys_comb,
																		// Compare as interger to strip preceding zeroes
																		(INTEGER) LEFT.activity_number = (INTEGER) RIGHT.IdValue,
																		TRANSFORM(oshair_layout_wLinkIds,
																							SELF := RIGHT,
																							SELF := LEFT),
																		KEEP(1));   // For cases in which a idvalue has multiple linkids
	
	iesp.osha.t_IndustryCode xform_industry(Oshair_Services.Layouts.industry_class L) := TRANSFORM
	  SELF.DUNSNumber 						:= (STRING) L.DUNS_Number;
	  SELF.SICCode 								:= L.sic_code;
		SELF.SicCodeDesc 						:= L.sic_code_desc;
		SELF.SecondarySIC 					:= L.secondary_sic;
		SELF.SecondarySicCodeDesc		:= L.secondary_sic_desc;
		
		SELF.NAICSCodeDescs	:= PROJECT(CHOOSEN(L.naics,iesp.Constants.OSHAIR.MaxNaics),TRANSFORM(iesp.osha.t_CodeDescription,
																				SELF.Name := LEFT.name,
																				SELF.Code := LEFT.code,
																				SELF.Description := LEFT.description));
		SELF := [];
  END;
	
	iesp.osha.t_Violation xform_violations(Oshair_Services.Layouts.Violation L) := TRANSFORM
	  SELF.DeleteFlag 						:= L.Delete_Flag;
	  SELF.IssuanceDate 					:= iesp.ECL2ESP.toDate(L.Issuance_Date);
		SELF.IdNumber								:= L.id_number;
		SELF.CitationNumber 				:= L.Citation_Number;
		SELF.ItemNumber 						:= L.Item_Number;
		SELF.CurrentPenalty					:= L.Current_Penalty;
		SELF.InitialPenalty					:= L.Initial_Penalty;
		SELF.ViolationType					:= L.Violation_Type;
		SELF.InitialViolationType		:= L.Initial_Violation_Type;
		SELF.FedStateStandard				:= L.Fed_State_Standard;
		SELF.AbatementDate					:= iesp.ECL2ESP.toDate(L.Abatement_Date);
		SELF.AbatementComplete			:= L.Abatement_Complete;
		SELF.FinalOrderDate					:= iesp.ECL2ESP.toDate(L.Final_Order_Date);
		SELF.DispositionEvent				:= L.Disposition_Event;
		SELF.FailureToAbatePenalty	:= L.FTA_Penalty;
		SELF.FailureToAbateIssuanceDate		:= iesp.ECL2ESP.toDate(L.FTA_Issuance_Date);
		SELF.AbatementVerifyDate		:= iesp.ECL2ESP.toDate(L.Abatement_Verify_Date);
		SELF.ViolationContest				:= L.Violation_Contest_Desc;
		SELF.ViolationDesc					:= L.Violation_Desc;
		SELF.RelatedEventDesc				:= L.Related_Event_Desc;
		SELF.AbatementCompDesc			:= L.Abatement_Comp_Desc;
		SELF.DispositionEventDesc		:= L.Disposition_Event_Desc;
		SELF.FailureToAbateDispositionEventDesc		:= L.FTA_Disposition_Event_Desc;
		SELF := [];
  END;
	
	iesp.osha.t_HazardSubstance xform_substances(Oshair_Services.Layouts.Hazardous_Substance L) := TRANSFORM
	  SELF.CitationNumber 				:= L.Citation_Number;
	  SELF.ItemNumber 						:= L.Item_Number;
		SELF.ItemGroup 							:= L.Item_group;
		SELF.CodeDescriptions	:= PROJECT(CHOOSEN(L.substance,iesp.Constants.OSHAIR.MaxHazardCodes),TRANSFORM(iesp.osha.t_CodeDescription,
																				SELF.Name := '',
																				SELF.Code := LEFT.code,
																				SELF.Description := LEFT.description));
		SELF := [];
  END;
	
	iesp.osha.t_Accident xform_accidents(Oshair_Services.Layouts.Accident L) := TRANSFORM
		SELF.Name												:= L.Name;
		SELF.RelatedInspectionNumber		:= L.Related_Inspection_Number;
	  SELF.Sex				 								:= L.sex_desc;
	  SELF.Age 												:= L.Age;
		SELF.DegreeOfInjury 						:= L.Degree_of_Injury;
		SELF.NatureOfInjury							:= L.Nature_of_Injury;
		SELF.PartOfBody									:= L.Part_of_Body;
	  SELF.SourceOfInjury							:= L.Source_of_Injury;
	  SELF.EventType									:= L.Event_Type;
		SELF.EnvironmentalFactor				:= L.Environmental_Factor;
		SELF.HumanFactor								:= L.Human_Factor;
		SELF.TaskAssigned								:= L.Task_Assigned;
	  SELF.HazardousSubstance					:= L.Hazardous_Substance;
	  SELF.OccupationCode							:= L.Occupation_Code;
		SELF.DegOfInjuryDesc 						:= L.Deg_of_Injury_Desc;
		SELF.NatOfInjDesc								:= L.Nat_of_Inj_Desc;
		SELF.PartOfBodyDesc							:= L.Part_of_Body_Desc;
	  SELF.SrcOfInjDesc								:= L.Src_of_Inj_Desc;
	  SELF.EventDesc									:= L.Event_Desc;
		SELF.EnvironmentalFactorDesc		:= L.Env_Factor_Desc;
		SELF.HumanFactorDesc						:= L.Human_Factor_Desc;
		SELF.ReportTaskDesc							:= L.Task_Assigned_Desc;
	  SELF.HazardousSubDesc						:= L.Hazardous_Sub_Desc;
	  SELF.OccupationDesc							:= L.Occupation_Desc;
		SELF.Victim.VictimName					:= iesp.ECL2ESP.setName(L.victim.fname,L.victim.mname,
																												L.victim.lname,L.victim.name_suffix,'','');
		SELF.Victim.NameScore						:= L.victim.name_score;
		SELF := [];
  END;
	
	// Convert to other source iesp layout. (Eventually needs converted to oshair iesp layout).
	iesp.osha.t_OSHAReportRecord toOut(oshair_layout_wLinkIds L) := TRANSFORM
		IDmacros.mac_IespTransferLinkids(UseIdValue:=true)
		SELF.ActivityNumber 						:= (INTEGER) L.Activity_Number;
		SELF.LastActivityDate						:= iesp.ECL2ESP.toDate(L.Last_Activity_Date);
		SELF.PreviousActivityType				:= L.Previous_Activity_Type;
		SELF.PrevActivityTypeDesc				:= L.Prev_Activity_Type_Desc;
		SELF.PreviousActivityNumber 		:= L.Previous_Activity_Number;
		SELF.ReportId										:= L.report_id;
		SELF.ComplianceOfficer.Id				:= L.Compliance_Officer_ID;
		SELF.ComplianceOfficer.JobTitle				:= L.Compliance_Officer_Job_Title;
		SELF.ComplianceOfficer.JobTitleDesc		:= L.Compl_Officer_Job_Title_Desc;
		SELF.InspectedSite							:= L.Inspected_Site_Name;
		SELF.InspectedSiteAddress				:= iesp.ECL2ESP.setAddress(L.address.prim_name,L.address.prim_range,
																				L.address.predir,L.address.postdir,L.address.addr_suffix,L.address.unit_desig,
																				L.address.sec_range,L.address.v_city_name,L.address.st,L.address.zip5,L.address.zip4,L.address.county);
		SELF.HostEstablishmentKey				:= L.Host_Establishment_key;
		SELF.OwnerType									:= L.Owner_Type;
		SELF.OwnTypeDesc								:= L.Own_Type_Desc;
		SELF.OwnerCode									:= L.Owner_Code;
		SELF.AdvanceNoticeFlag					:= L.Advance_Notice_Flag;
		SELF.AdvanceNoticeDesc					:= L.Advance_Notice_Desc;
		SELF.InspectionOpeningDate			:= iesp.ECL2ESP.toDate(L.Inspection_Opening_Date);
		SELF.InspectionCloseDate				:= iesp.ECL2ESP.toDate(L.Inspection_Close_Date);
		SELF.InspectionTypeDesc					:= L.Insp_Type_Desc;
		SELF.InspectionScopeDesc				:= L.Insp_Scope_Desc;
		SELF.SafetyHealthFlag						:= L.Safety_Health_Flag;
		SELF.SafetyHealthDesc						:= L.Safety_Health_Desc;
		SELF.NumberInEstablishment			:= L.Number_In_Establishment;
		SELF.NumberCovered							:= L.Number_Covered;
		SELF.NumberTotalEmployees				:= L.Number_Total_Employees;
		SELF.WalkAroundDesc							:= L.Walk_Around_desc;
		SELF.EmployeesInterviewedDesc		:= L.Employees_Interviewed_desc;
		SELF.UnionFlag									:= L.Union_Flag_desc;
		SELF.ClosedCaseFlag							:= L.Closed_Case_Flag;
		SELF.WhyNoInspDesc							:= L.Why_No_Insp_Desc;
		SELF.CloseCaseDate							:= iesp.ECL2ESP.toDate(L.Close_Case_Date);
		SELF.AnticServed								:= L.Antic_Served;
		SELF.FirstDenialDate						:= iesp.ECL2ESP.toDate(L.First_Denial_Date);
		SELF.LastReenterDate						:= iesp.ECL2ESP.toDate(L.Last_Reenter_Date);
		SELF.BLSLossWorkdayInjuryRate		:= L.bls_Loss_Workday_Injury_Rate;
		
		SELF.IndustryCodes				:= PROJECT(L.industry_codes,xform_industry(LEFT));
		SELF.Classification				:= PROJECT(CHOOSEN(L.classification,iesp.Constants.OSHAIR.MaxClassifications),
																											TRANSFORM(iesp.share.t_StringArrayItem,
																																SELF.value := LEFT.description));
																																
		SELF.HoursOfInspections		:= PROJECT(CHOOSEN(L.inspection_hours,iesp.Constants.OSHAIR.MaxHoursInspection),
																											TRANSFORM(iesp.osha.t_HoursOfInspection,
																																SELF.Category := LEFT.category,
																																SELF.Hours		:= LEFT.hours));
		
		SELF.Violations						:= PROJECT(CHOOSEN(L.violations,iesp.Constants.OSHAIR.MaxViolations),xform_violations(LEFT));
		
		SELF.HazardSubstances			:= PROJECT(CHOOSEN(L.substances,iesp.Constants.OSHAIR.MaxHazardSubstances),xform_substances(LEFT));
		SELF.Accidents						:= PROJECT(CHOOSEN(L.accidents,iesp.Constants.OSHAIR.MaxAccidents),xform_accidents(LEFT));
		SELF := [];
	END;

	EXPORT SourceView_Recs := PROJECT(oshair_sourceview_wLinkIds, toOut(left));
  EXPORT SourceView_RecCount := COUNT(oshair_sourceview_wLinkIds);
	
END;