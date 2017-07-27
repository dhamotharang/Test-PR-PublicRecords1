IMPORT RoxieKeyBuild, address;
//
// Process the sprayed MBSi exported files and create a base file
//
EXPORT BuildBase(string bFileName, string build_date) := FUNCTION
/*
** contractor build
*/
l_contract_s     	:= LayoutExports.CONTRACTOR;
l_contract       	:= Layout.CONTRACTOR;// Reusing original layout rather new ones
Sprayedcontract  	:= DATASET(Constants(bFileName).spray_subfile,l_contract_s,
														 CSV(SEPARATOR(Constants().FieldSeparator),TERMINATOR(Constants().RecordTerminator), Quote(Constants().QuoteBack), MAXLENGTH(Constants().MAX_RECORD_SIZE)));
l_contract contractConversion (l_contract_s L) := TRANSFORM
	SELF.ID						:= StringLib.StringToUpperCase (L.ID);
	SELF.FULLNAME			:= StringLib.StringToUpperCase (L.FULLNAME);
	SELF.CompanyName	:= StringLib.StringToUpperCase (L.CompanyName);
	SELF.CompanyDesc	:= StringLib.StringToUpperCase (L.CompanyDesc);
	SELF.PHONE				:= StringLib.StringToUpperCase (L.PHONE);
	SELF.RADDRESS1		:= StringLib.StringToUpperCase (L.RADDRESS1);
	SELF.RADDRESS2		:= StringLib.StringToUpperCase (L.RADDRESS2);
	SELF.RCITY				:= StringLib.StringToUpperCase (L.RCITY);
	SELF.RSTATE				:= StringLib.StringToUpperCase (L.RSTATE);
	SELF.RZIP					:= StringLib.StringToUpperCase (L.RZIP);
	SELF.EMAIL				:= StringLib.StringToUpperCase (L.EMAIL);
	SELF.TRADE				:= StringLib.StringToUpperCase (L.TRADE);
	SELF.EXTRAFIELDS	:= StringLib.StringToUpperCase (L.EXTRAFIELDS);
	SELF							:= L;
	SELF							:= [];
END;
contract         	:= PROJECT(Sprayedcontract,contractConversion(LEFT));

RoxieKeyBuild.Mac_SF_BuildProcess_V2(contract(ID <> 'ID'), FILES.BASE_PREFIX_NAME, bFileName, build_date, contractBase, 3, false, true);//Skip header row
/*
** Inspection build
*/
l_inspection_s   	:= LayoutExports.INSPECTION;
l_inspection     	:= Layout.inspection;// Reusing original layout rather new ones
Sprayedinspection	:= DATASET(Constants(bFileName).spray_subfile,l_inspection_s,
														 CSV(SEPARATOR(Constants().FieldSeparator),TERMINATOR(Constants().RecordTerminator), Quote(Constants().QuoteBack), MAXLENGTH(Constants().MAX_RECORD_SIZE)));
l_inspection inspectionConversion (l_inspection_s L) := TRANSFORM

	SELF.ID						:= StringLib.StringToUpperCase (L.ID);
	SELF.PermitID			:= StringLib.StringToUpperCase (L.PermitID);
	SELF.PermitRecNum	:= StringLib.StringToUpperCase (L.PermitRecNum);
	SELF.InspType			:= StringLib.StringToUpperCase (L.InspType);
	SELF.Description	:= StringLib.StringToUpperCase (L.Description);
	SELF.SpecialInstructions	:= StringLib.StringToUpperCase (L.SpecialInstructions);
	SELF.Final				:= StringLib.StringToUpperCase (L.Final);
	SELF.Result				:= StringLib.StringToUpperCase (L.Result);
	SELF.ReInspection	:= StringLib.StringToUpperCase (L.ReInspection);
	SELF.InspectionNotes	:= StringLib.StringToUpperCase (L.InspectionNotes);
	SELF.ExtraFields	:= StringLib.StringToUpperCase (L.ExtraFields);
	SELF            	:= L;
END;
inspection       		:= PROJECT(Sprayedinspection,inspectionConversion(LEFT));

RoxieKeyBuild.Mac_SF_BuildProcess_V2(inspection(ID <> 'ID'), FILES.BASE_PREFIX_NAME, bFileName, build_date, inspectionBase, 3, false, true);//Skip header row
/*
** Corrections build
*/
l_correction_s  	:= LayoutExports.CORRECTION;
l_correction     	:= Layout.correction;// Reusing original layout rather new ones
Sprayedcorrection	:= DATASET(Constants(bFileName).spray_subfile,l_correction_s,
														 CSV(SEPARATOR(Constants().FieldSeparator),TERMINATOR(Constants().RecordTerminator), Quote(Constants().QuoteBack), MAXLENGTH(Constants().MAX_RECORD_SIZE)));
l_correction correctionConversion (l_correction_s L) := TRANSFORM
	SELF.ID						:= StringLib.StringToUpperCase (L.ID);
	SELF.PROPERTYID		:= StringLib.StringToUpperCase (L.PROPERTYID);
	SELF.PROPERTYRECNUM		:= StringLib.StringToUpperCase (L.PROPERTYRECNUM);
	SELF.CORRECTEDADDRESS1:= StringLib.StringToUpperCase (L.CORRECTEDADDRESS1);
	SELF.CORRECTEDADDRESS2:= StringLib.StringToUpperCase (L.CORRECTEDADDRESS2);
	SELF.CORRECTEDCITY		:= StringLib.StringToUpperCase (L.CORRECTEDCITY);
	SELF.CORRECTEDSTATE		:= StringLib.StringToUpperCase (L.CORRECTEDSTATE);
	SELF.CORRECTEDZIP	:= StringLib.StringToUpperCase (L.CORRECTEDZIP);
	SELF            	:= L;
	SELF							:= [];
END;
correction	      	:= PROJECT(Sprayedcorrection,correctionConversion(LEFT));

RoxieKeyBuild.Mac_SF_BuildProcess_V2(correction(ID <> 'ID'), FILES.BASE_PREFIX_NAME, bFileName, build_date, correctionBase, 3, false, true);//Skip header row

/*
** Permits build
*/
l_permit_s		  	:= LayoutExports.PERMIT;
l_permit	    		:= Layout.permit;// Reusing original layout rather new ones
Sprayedpermit			:= DATASET(Constants(bFileName).spray_subfile,l_permit_s,
														 CSV(SEPARATOR(Constants().FieldSeparator),TERMINATOR(Constants().RecordTerminator), Quote(Constants().QuoteBack), MAXLENGTH(Constants().MAX_RECORD_SIZE)));
l_permit permitConversion (l_permit_s L) := TRANSFORM
	SELF.PreferredDate	:= StringLib.StringFindReplace (L.PreferredDate,'-','');
	SELF.AppliedDate		:= StringLib.StringFindReplace (L.AppliedDate,'-','');
	SELF.IssuedDate			:= StringLib.StringFindReplace (L.IssuedDate,'-','');
	SELF.ExpiresDate		:= StringLib.StringFindReplace (L.ExpiresDate,'-','');
	SELF.CoIssuedDate		:= StringLib.StringFindReplace (L.CoIssuedDate,'-','');
	SELF.CompletedDate	:= StringLib.StringFindReplace (L.CompletedDate,'-','');
	SELF.HoldDate				:= StringLib.StringFindReplace (L.HoldDate,'-','');
	SELF.VoidDate				:= StringLib.StringFindReplace (L.VoidDate,'-','');
	SELF.StatusDate			:= StringLib.StringFindReplace (L.StatusDate,'-','');
	SELF.ID							:= StringLib.StringToUpperCase (L.ID);

	SELF.PropertyID			:= StringLib.StringToUpperCase (L.PropertyID);
	SELF.Jurisdiction		:= StringLib.StringToUpperCase (L.Jurisdiction);
	SELF.PermitNum			:= StringLib.StringToUpperCase (L.PermitNum);
	SELF.PermitClass		:= StringLib.StringToUpperCase (L.PermitClass);
	SELF.MasterPermitNum:= StringLib.StringToUpperCase (L.MasterPermitNum);
	SELF.WorkClass			:= StringLib.StringToUpperCase (L.WorkClass);
	SELF.ProposedUse		:= StringLib.StringToUpperCase (L.ProposedUse);
	SELF.PermitStatus		:= StringLib.StringToUpperCase (L.PermitStatus);
	SELF.ValuationAmount:= StringLib.StringToUpperCase (L.ValuationAmount);
	SELF.ValuationAmountDecimal	:= StringLib.StringToUpperCase (L.ValuationAmountDecimal);
	SELF.ProjectName		:= StringLib.StringToUpperCase (L.ProjectName);
	SELF.PermitType			:= StringLib.StringToUpperCase (L.PermitType);
	SELF.PermitTypeDescription	:= StringLib.StringToUpperCase (L.PermitTypeDescription);
	SELF.PermitTypePreferred		:= StringLib.StringToUpperCase (L.PermitTypePreferred);
	SELF.PermitTypeCombined			:= StringLib.StringToUpperCase (L.PermitTypeCombined);
	SELF.ProjectID			:= StringLib.StringToUpperCase (L.ProjectID);
	SELF.TotalSqFt			:= StringLib.StringToUpperCase (L.TotalSqFt);
	SELF.TotalFinishedSqFt			:= StringLib.StringToUpperCase (L.TotalFinishedSqFt);
	SELF.TotalUnfinishedSqFt		:= StringLib.StringToUpperCase (L.TotalUnfinishedSqFt);
	SELF.TotalHeatedSqFt:= StringLib.StringToUpperCase (L.TotalHeatedSqFt);
	SELF.TotalAccSqFt		:= StringLib.StringToUpperCase (L.TotalAccSqFt);
	SELF.Description		:= StringLib.StringToUpperCase (L.Description);
	SELF.ExtraFields		:= StringLib.StringToUpperCase (L.ExtraFields);
	SELF								:= L;
END;
permit       			:= PROJECT(Sprayedpermit,permitConversion(LEFT));

RoxieKeyBuild.Mac_SF_BuildProcess_V2(permit(ID <> 'ID'), FILES.BASE_PREFIX_NAME, bFileName, build_date, permitBase, 3, false, true);//Skip header row

/*
** permitandcontractor build
*/
l_permAndCont_s		:= LayoutExports.permitcontractor;
l_permAndCont	    := Layout.permitcontractor;// Reusing original layout rather new ones
SprayedpermAndCont:= DATASET(Constants(bFileName).spray_subfile,l_permAndCont_s,
														 CSV(SEPARATOR(Constants().FieldSeparator),TERMINATOR(Constants().RecordTerminator), Quote(Constants().QuoteBack), MAXLENGTH(Constants().MAX_RECORD_SIZE)));
l_permAndCont permAndContConversion (l_permAndCont_s L) := TRANSFORM
	SELF.ContractorID	:= StringLib.StringToUpperCase (L.ContractorID);
	SELF.ID					:= StringLib.StringToUpperCase (L.ID);
	SELF.PermitID		:= StringLib.StringToUpperCase (L.PermitID);
	SELF            := L;
END;
permAndCont       := PROJECT(SprayedpermAndCont,permAndContConversion(LEFT));

RoxieKeyBuild.Mac_SF_BuildProcess_V2(permAndCont(ID <> 'ID'), FILES.BASE_PREFIX_NAME, bFileName, build_date, permAndContBase, 3, false, true);//Skip header row
/*
** Property build
*/
updateProperty		:= updateProperties(bFileName, build_date);
/*
** Jurisdiction build
*/
l_Jurisdiction_s  := LayoutExports.Jurisdiction;
l_Jurisdiction    := Layout.Jurisdiction;// Reusing original layout rather new ones
SprayedJurisdiction	:= DATASET(Constants(bFileName).spray_subfile,l_Jurisdiction_s,
															CSV(SEPARATOR(Constants().FieldSeparator),TERMINATOR(Constants().RecordTerminator), Quote(Constants().QuoteBack), MAXLENGTH(Constants().MAX_RECORD_SIZE)));
l_Jurisdiction jurisdictionConversion (l_Jurisdiction_s L) := TRANSFORM
	// SELF.GoLiveDate				:= StringLib.StringFindReplace (L.GoLiveDate,'/','');
	// SELF.PreferredDate		:= StringLib.StringFindReplace (L.PreferredDate,'-','');
	// SELF.MinDate					:= StringLib.StringFindReplace (L.MinDate,'-','');
	// SELF.ExclusionMinDate	:= StringLib.StringFindReplace (L.ExclusionMinDate,'-','');
	// SELF.MaxDate					:= StringLib.StringFindReplace (L.MaxDate,'-','');
	// SELF.ExclusionMaxDate	:= StringLib.StringFindReplace (L.ExclusionMaxDate,'-','');
	// SELF.LastUpdateTime		:= StringLib.StringFindReplace (L.LastUpdateTime,'-','');
	SELF.Jurisdiction			:= StringLib.StringToUpperCase (L.Jurisdiction);
	SELF.JurisdictionName	:= StringLib.StringToUpperCase (L.JurisdictionName);
	SELF.OfficialName			:= StringLib.StringToUpperCase (L.OfficialName);
	SELF.StreetAddress		:= StringLib.StringToUpperCase (L.StreetAddress);
	SELF.City							:= StringLib.StringToUpperCase (L.City);
	SELF.ZIP							:= StringLib.StringToUpperCase (L.ZIP);
	SELF.Fax							:= StringLib.StringToUpperCase (L.Fax);
	SELF.Office						:= StringLib.StringToUpperCase (L.Office);
	SELF.OtherPhone				:= StringLib.StringToUpperCase (L.OtherPhone);
	SELF.County						:= StringLib.StringToUpperCase (L.County);
	SELF									:= L;
END;
Jurisdiction       			:= PROJECT(SprayedJurisdiction,jurisdictionConversion(LEFT));

RoxieKeyBuild.Mac_SF_BuildProcess_V2(Jurisdiction(Jurisdiction <> 'JURISDICTION'), FILES.BASE_PREFIX_NAME, bFileName, build_date, JurisdictionBase, 3, false, true);//Skip header row

/*
** StreetLookup build
*/
l_StreetLookup_s  := LayoutExports.StreetLookup;
l_StreetLookup    := Layout.StreetLookup;// Reusing original layout rather new ones
SprayedStreetLookup	:= DATASET(Constants(bFileName).spray_subfile,l_StreetLookup_s,
															CSV(SEPARATOR(Constants().FieldSeparator),TERMINATOR(Constants().RecordTerminator), Quote(Constants().QuoteBack), MAXLENGTH(Constants().MAX_RECORD_SIZE)));
l_StreetLookup StreetLookupConversion (l_StreetLookup_s L) := TRANSFORM
	SELF.STREET			:= StringLib.StringToUpperCase (L.STREET);
	SELF.CITY				:= StringLib.StringToUpperCase (L.CITY);
	SELF.STATE			:= StringLib.StringToUpperCase (L.STATE);
	SELF.ZIP				:= StringLib.StringToUpperCase (L.ZIP);
	SELF.Jurisdiction	:= StringLib.StringToUpperCase (L.Jurisdiction);
END;
StreetLookup       := PROJECT(SprayedStreetLookup,StreetLookupConversion(LEFT));

RoxieKeyBuild.Mac_SF_BuildProcess_V2(StreetLookup, FILES.BASE_PREFIX_NAME, bFileName, build_date, StreetLookupBase, 3, false, true);

RETURN MAP (bFileName = Constants().CONTRACTOR => contractBase,
						bFileName = Constants().INSPECTION => inspectionBase, 
						bFileName = Constants().CORRECTION => correctionBase, 
						bFileName = Constants().PERMIT => permitBase, 
						bFileName = Constants().PROPERTY => updateProperty, 
						bFileName = Constants().permitcontractor => permAndContBase, 
						bFileName = Constants().Jurisdiction => JurisdictionBase, 
						bFileName = Constants().StreetLookup => StreetLookupBase, 
						FAIL(bFileName + ' is not supported for build base and key'));
END;