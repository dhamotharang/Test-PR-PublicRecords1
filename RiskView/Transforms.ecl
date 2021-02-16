IMPORT risk_indicators, RiskView, iesp, STD, Models;

EXPORT Transforms := module


EXPORT Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus_LnJ GetLnJInfo (
 Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus	le,
 Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus_LJ_withAttrs ri) := TRANSFORM
						SELF.lnj_recent_unreleased_count              := ri.lnj_recent_unreleased_count             ;
						SELF.lnj_historical_unreleased_count          := ri.lnj_historical_unreleased_count         ;
						SELF.lnj_unreleased_count12                   := ri.lnj_unreleased_count12                  ;
						SELF.lnj_recent_released_count                := ri.lnj_recent_released_count               ;
						SELF.lnj_historical_released_count            := ri.lnj_historical_released_count           ;
						SELF.lnj_released_count12                     := ri.lnj_released_count12                    ;
						SELF.lnj_last_unreleased_date                 := ri.lnj_last_unreleased_date                ;
						SELF.lnj_last_released_date                   := ri.lnj_last_released_date                  ;
						SELF.lnj_eviction_count                       := ri.lnj_eviction_count                      ;
						SELF.lnj_eviction_count12                     := ri.lnj_eviction_count12                    ;
						SELF.lnj_last_eviction_date                   := ri.lnj_last_eviction_date                  ;
						SELF.lnj_eviction_recent_unreleased_count     := ri.lnj_eviction_recent_unreleased_count    ;
						SELF.lnj_eviction_historical_unreleased_count := ri.lnj_eviction_historical_unreleased_count;
						SELF.lnj_eviction_recent_released_count       := ri.lnj_eviction_recent_released_count       ;
						SELF.lnj_eviction_historical_released_count   := ri.lnj_eviction_historical_released_count   ;
						SELF.lnj_unreleased_civil_judgment_cnt        := ri.lnj_unreleased_civil_judgment_cnt        ;
						SELF.lnj_unreleased_civil_judgment_amt        := ri.lnj_unreleased_civil_judgment_amt        ;
						SELF.lnj_released_civil_judgment_cnt          := ri.lnj_released_civil_judgment_cnt          ;
						SELF.lnj_released_civil_judgment_amt          := ri.lnj_released_civil_judgment_amt          ;
						SELF.lnj_unreleased_federal_tax_cnt           := ri.lnj_unreleased_federal_tax_cnt           ;
						SELF.lnj_unreleased_federal_tax_amt           := ri.lnj_unreleased_federal_tax_amt           ;
						SELF.lnj_released_federal_tax_cnt             := ri.lnj_released_federal_tax_cnt             ;
						SELF.lnj_released_federal_tax_amt             := ri.lnj_released_federal_tax_amt             ;
						SELF.lnj_unreleased_foreclosure_cnt           := ri.lnj_unreleased_foreclosure_cnt           ;
						SELF.lnj_unreleased_foreclosure_amt           := ri.lnj_unreleased_foreclosure_amt           ;
						SELF.lnj_released_foreclosure_cnt             := ri.lnj_released_foreclosure_cnt             ;
						SELF.lnj_released_foreclosure_amt             := ri.lnj_released_foreclosure_amt             ;
						SELF.lnj_unreleased_landlord_tenant_cnt       := ri.lnj_unreleased_landlord_tenant_cnt       ;
						SELF.lnj_unreleased_landlord_tenant_amt       := ri.lnj_unreleased_landlord_tenant_amt       ;
						SELF.lnj_released_landlord_tenant_cnt         := ri.lnj_released_landlord_tenant_cnt         ;
						SELF.lnj_released_landlord_tenant_amt         := ri.lnj_released_landlord_tenant_amt         ;
						SELF.lnj_unreleased_lispendens_cnt            := ri.lnj_unreleased_lispendens_cnt            ;
						// SELF.lnj_unreleased_lispendens_amt            := ri.lnj_unreleased_lispendens_amt            ;
						SELF.lnj_released_lispendens_cnt              := ri.lnj_released_lispendens_cnt              ;
						// SELF.lnj_released_lispendens_amt              := ri.lnj_released_lispendens_amt              ;
						SELF.lnj_unreleased_other_lj_cnt              := ri.lnj_unreleased_other_lj_cnt              ;
						SELF.lnj_unreleased_other_lj_amt              := ri.lnj_unreleased_other_lj_amt              ;
						SELF.lnj_released_other_lj_cnt                := ri.lnj_released_other_lj_cnt                ;
						SELF.lnj_released_other_lj_amt                := ri.lnj_released_other_lj_amt                ;
						SELF.lnj_unreleased_other_tax_cnt             := ri.lnj_unreleased_other_tax_cnt             ;
						SELF.lnj_unreleased_other_tax_amt             := ri.lnj_unreleased_other_tax_amt             ;
						SELF.lnj_released_other_tax_cnt               := ri.lnj_released_other_tax_cnt               ;
						SELF.lnj_released_other_tax_amt               := ri.lnj_released_other_tax_amt               ;
						SELF.lnj_unreleased_small_claims_cnt          := ri.lnj_unreleased_small_claims_cnt          ;
						SELF.lnj_unreleased_small_claims_amt          := ri.lnj_unreleased_small_claims_amt          ;
						SELF.lnj_released_small_claims_cnt            := ri.lnj_released_small_claims_cnt            ;
						SELF.lnj_released_small_claims_amt            := ri.lnj_released_small_claims_amt            ;
						// SELF.lnj_unreleased_Mechanics_cnt             := ri.lnj_unreleased_Mechanics_cnt             ;
						// SELF.lnj_unreleased_Mechanics_amt             := ri.lnj_unreleased_Mechanics_amt             ;
						// SELF.lnj_released_Mechanics_cnt               := ri.lnj_released_Mechanics_cnt               ;
						// SELF.lnj_released_Mechanics_amt               := ri.lnj_released_Mechanics_amt               ;
						SELF.lnj_lien_cnt                             := ri.lnj_lien_cnt                             ;
						SELF.lnj_lien_total                           := ri.lnj_lien_total                           ;
						SELF.lnj_last_lien_unreleased_date            := ri.lnj_last_lien_unreleased_date             ;
						SELF.lnj_last_lien_released_date              := ri.lnj_last_lien_released_date              ;
						SELF.lnj_liens_unreleased_all_tax_cnt         := ri.lnj_liens_unreleased_all_tax_cnt         ;
						SELF.lnj_liens_unreleased_all_tax_amt         := ri.lnj_liens_unreleased_all_tax_amt         ;
						SELF.lnj_liens_released_all_tax_cnt           := ri.lnj_liens_released_all_tax_cnt           ;
						SELF.lnj_liens_released_all_tax_amt           := ri.lnj_liens_released_all_tax_amt           ;
						SELF.lnj_last_allTax_unreleased_date          := ri.lnj_last_allTax_unreleased_date           ;
						SELF.lnj_last_allTax_released_date            := ri.lnj_last_allTax_released_date            ;
						SELF.lnj_liens_unreleased_state_tax_cnt       := ri.lnj_liens_unreleased_state_tax_cnt       ;
						SELF.lnj_liens_unreleased_state_tax_amt       := ri.lnj_liens_unreleased_state_tax_amt       ;
						SELF.lnj_liens_released_state_tax_cnt         := ri.lnj_liens_released_state_tax_cnt         ;
						SELF.lnj_liens_released_state_tax_amt         := ri.lnj_liens_released_state_tax_amt         ;
						SELF.lnj_last_state_unreleased_date           := ri.lnj_last_state_unreleased_date            ;
						SELF.lnj_last_state_released_date             := ri.lnj_last_state_released_date             ;
						SELF.lnj_liens_unreleased_federal_tax_cnt     := ri.lnj_liens_unreleased_federal_tax_cnt     ;
						SELF.lnj_liens_unreleased_federal_tax_amt     := ri.lnj_liens_unreleased_federal_tax_amt     ;
						SELF.lnj_liens_released_federal_tax_cnt       := ri.lnj_liens_released_federal_tax_cnt       ;
						SELF.lnj_liens_released_federal_tax_amt       := ri.lnj_liens_released_federal_tax_amt       ;
						SELF.lnj_last_federal_unreleased_date         := ri.lnj_last_federal_unreleased_date          ;
						SELF.lnj_last_federal_released_date		        := ri.lnj_last_federal_released_date		      ;
						SELF.lnj_jgmt_cnt	                            := ri.lnj_jgmt_cnt	                          ;
						SELF.lnj_last_jgmt_unreleased_date            := ri.lnj_last_jgmt_unreleased_date             ;
						SELF.lnj_last_jgmt_released_date              := ri.lnj_last_jgmt_released_date              ;
						SELF.lnj_jgmt_total                           := ri.lnj_jgmt_total                           ;
						SELF.LnJLiens := ri.LnJLiens;
						SELF.LnJJudgments := ri.LnJJudgments;
						SELF := le;
END;

EXPORT SetCSID(unsigned CSID) := function
			csIdTmp := if(CSId = 0, (string) '', (string)CSID);
			return  trim(csIdTmp, left, right);
		end;

EXPORT RiskView.Layouts.layout_riskview5_batch_response FormatBatch(
RiskView.Layouts.layout_riskview_input le, 
RiskView.Layouts.layout_riskview5_search_results ri,
BOOLEAN IncludeStatusRefreshChecks = FALSE,
BOOLEAN ExcludeStatusRefresh = FALSE) := TRANSFORM

    suppress_condition := IF((STD.Str.ToLowerCase(ri.Message) = STD.Str.ToLowerCase(Riskview.Constants.Deferred_request_desc) OR STD.Str.ToLowerCase(ri.Exception_Code) = STD.Str.ToLowerCase(Riskview.Constants.DTEError) OR STD.Str.ToLowerCase(ri.Exception_Code) = STD.Str.ToLowerCase(Riskview.Constants.OKCError)) AND ExcludeStatusRefresh = FALSE AND IncludeStatusRefreshChecks = TRUE, TRUE, FALSE);
    SELF.acctno := le.acctno;
    // don't log the lexid if the person got a noscore
    SELF.inquiry_lexid := if(riskview.constants.noScoreAlert in [ri.Alert1,ri.Alert2,ri.Alert3,ri.Alert4,ri.Alert5,ri.Alert6,ri.Alert7,ri.Alert8,ri.Alert9,ri.Alert10] OR suppress_condition, '', ri.LexID);
    SELF.Exception_Code := MAP(ri.Exception_Code = Riskview.Constants.OKCError => '22',
                               ri.Exception_Code IN Riskview.Constants.generalErrorCodes => ri.Exception_Code,
                               ri.Exception_Code IN Riskview.Constants.DTEErrorCodes => '41',
                               ri.Status_Code = '801' => ri.Status_Code,
                               '');
    SELF.Exception_Message := MAP(ri.Exception_Code = Riskview.Constants.OKCError => RiskView.Constants.StatusRefresh_error_desc,
                                  ri.Exception_Code IN Riskview.Constants.generalErrorCodes => RiskView.Constants.MLA_error_desc(ri.Exception_Code),
                                  ri.Exception_Code IN Riskview.Constants.DTEErrorCodes  => RiskView.Constants.DTE_error_desc,
                                  ri.Status_Code = '801' => RiskView.Constants.Deferred_request_desc,
                                  '');
    SELF.Liens1_Seq:= IF(~suppress_condition, ri.LnJliens[1].Seq, '');
    SELF.Liens1_DateFiled:= IF(~suppress_condition, ri.LnJliens[1].DateFiled, '');
    SELF.Liens1_LienTypeID := IF(~suppress_condition, ri.LnJliens[1].LienTypeID, '');
    SELF.Liens1_LienType := IF(~suppress_condition, ri.LnJliens[1].LienType, '');
    SELF.Liens1_Amount := IF(~suppress_condition, ri.LnJliens[1].Amount, '');
    SELF.Liens1_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[1].ReleaseDate, '');
    SELF.Liens1_DateLastSeen := IF(~suppress_condition, ri.LnJliens[1].DateLastSeen, '');
    SELF.Liens1_FilingNumber := IF(~suppress_condition, ri.LnJliens[1].FilingNumber, '');
    SELF.Liens1_FilingBook := IF(~suppress_condition, ri.LnJliens[1].FilingBook, '');
    SELF.Liens1_FilingPage := IF(~suppress_condition, ri.LnJliens[1].FilingPage, '');
    SELF.Liens1_Agency := IF(~suppress_condition, ri.LnJliens[1].Agency, '');
    SELF.Liens1_AgencyCounty := IF(~suppress_condition, ri.LnJliens[1].AgencyCounty, '');
    SELF.Liens1_AgencyState:= IF(~suppress_condition, ri.LnJliens[1].AgencyState, '');
    SELF.Liens1_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[1].ConsumerStatementId), '');
    SELF.Liens1_orig_rmsid := IF(~suppress_condition, ri.LnJliens[1].orig_rmsid, '');
    SELF.Liens2_Seq:= IF(~suppress_condition, ri.LnJliens[2].Seq, '');
    SELF.Liens2_DateFiled:= IF(~suppress_condition, ri.LnJliens[2].DateFiled, '');
    SELF.Liens2_LienTypeID := IF(~suppress_condition, ri.LnJliens[2].LienTypeID, '');
    SELF.Liens2_LienType := IF(~suppress_condition, ri.LnJliens[2].LienType, '');
    SELF.Liens2_Amount := IF(~suppress_condition, ri.LnJliens[2].Amount, '');
    SELF.Liens2_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[2].ReleaseDate, '');
    SELF.Liens2_DateLastSeen := IF(~suppress_condition, ri.LnJliens[2].DateLastSeen, '');
    SELF.Liens2_FilingNumber := IF(~suppress_condition, ri.LnJliens[2].FilingNumber, '');
    SELF.Liens2_FilingBook := IF(~suppress_condition, ri.LnJliens[2].FilingBook, '');
    SELF.Liens2_FilingPage := IF(~suppress_condition, ri.LnJliens[2].FilingPage, '');
    SELF.Liens2_Agency := IF(~suppress_condition, ri.LnJliens[2].Agency, ''); 
    SELF.Liens2_AgencyCounty := IF(~suppress_condition, ri.LnJliens[2].AgencyCounty, '');
    SELF.Liens2_AgencyState:= IF(~suppress_condition, ri.LnJliens[2].AgencyState, '');
    SELF.Liens2_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[2].ConsumerStatementId), '');
    SELF.Liens2_orig_rmsid := IF(~suppress_condition, ri.LnJliens[2].orig_rmsid, '');
    SELF.Liens3_Seq:= IF(~suppress_condition, ri.LnJliens[3].Seq, '');
    SELF.Liens3_DateFiled:= IF(~suppress_condition, ri.LnJliens[3].DateFiled, '');
    SELF.Liens3_LienTypeID := IF(~suppress_condition, ri.LnJliens[3].LienTypeID, '');
    SELF.Liens3_LienType := IF(~suppress_condition, ri.LnJliens[3].LienType, '');
    SELF.Liens3_Amount := IF(~suppress_condition, ri.LnJliens[3].Amount, '');
    SELF.Liens3_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[3].ReleaseDate, '');
    SELF.Liens3_DateLastSeen := IF(~suppress_condition, ri.LnJliens[3].DateLastSeen, '');
    SELF.Liens3_FilingNumber := IF(~suppress_condition, ri.LnJliens[3].FilingNumber, '');
    SELF.Liens3_FilingBook := IF(~suppress_condition, ri.LnJliens[3].FilingBook, '');
    SELF.Liens3_FilingPage := IF(~suppress_condition, ri.LnJliens[3].FilingPage, ''); 
    SELF.Liens3_Agency := IF(~suppress_condition, ri.LnJliens[3].Agency, ''); 
    SELF.Liens3_AgencyCounty := IF(~suppress_condition, ri.LnJliens[3].AgencyCounty, '');
    SELF.Liens3_AgencyState:= IF(~suppress_condition, ri.LnJliens[3].AgencyState, '');
    SELF.Liens3_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[3].ConsumerStatementId), '');
    SELF.Liens3_orig_rmsid := IF(~suppress_condition, ri.LnJliens[3].orig_rmsid, '');
    SELF.Liens4_Seq:= IF(~suppress_condition, ri.LnJliens[4].Seq, '');
    SELF.Liens4_DateFiled:= IF(~suppress_condition, ri.LnJliens[4].DateFiled, '');
    SELF.Liens4_LienTypeID := IF(~suppress_condition, ri.LnJliens[4].LienTypeID, '');
    SELF.Liens4_LienType := IF(~suppress_condition, ri.LnJliens[4].LienType, '');
    SELF.Liens4_Amount := IF(~suppress_condition, ri.LnJliens[4].Amount, '');
    SELF.Liens4_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[4].ReleaseDate, '');
    SELF.Liens4_DateLastSeen := IF(~suppress_condition, ri.LnJliens[4].DateLastSeen, '');
    SELF.Liens4_FilingNumber := IF(~suppress_condition, ri.LnJliens[4].FilingNumber, '');
    SELF.Liens4_FilingBook := IF(~suppress_condition, ri.LnJliens[4].FilingBook, '');
    SELF.Liens4_FilingPage := IF(~suppress_condition, ri.LnJliens[4].FilingPage, '');
    SELF.Liens4_Agency := IF(~suppress_condition, ri.LnJliens[4].Agency, ''); 
    SELF.Liens4_AgencyCounty := IF(~suppress_condition, ri.LnJliens[4].AgencyCounty, '');
    SELF.Liens4_AgencyState:= IF(~suppress_condition, ri.LnJliens[4].AgencyState, '');
    SELF.Liens4_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[4].ConsumerStatementId), '');
    SELF.Liens4_orig_rmsid := IF(~suppress_condition, ri.LnJliens[4].orig_rmsid, '');
    SELF.Liens5_Seq:= IF(~suppress_condition, ri.LnJliens[5].Seq, '');
    SELF.Liens5_DateFiled:= IF(~suppress_condition, ri.LnJliens[5].DateFiled, '');
    SELF.Liens5_LienTypeID := IF(~suppress_condition, ri.LnJliens[5].LienTypeID, '');
    SELF.Liens5_LienType := IF(~suppress_condition, ri.LnJliens[5].LienType , '');
    SELF.Liens5_Amount := IF(~suppress_condition, ri.LnJliens[5].Amount , '');
    SELF.Liens5_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[5].ReleaseDate, '');
    SELF.Liens5_DateLastSeen := IF(~suppress_condition, ri.LnJliens[5].DateLastSeen , '');
    SELF.Liens5_FilingNumber := IF(~suppress_condition, ri.LnJliens[5].FilingNumber , '');
    SELF.Liens5_FilingBook := IF(~suppress_condition, ri.LnJliens[5].FilingBook , '');
    SELF.Liens5_FilingPage := IF(~suppress_condition, ri.LnJliens[5].FilingPage , '');
    SELF.Liens5_Agency := IF(~suppress_condition, ri.LnJliens[5].Agency , '');
    SELF.Liens5_AgencyCounty := IF(~suppress_condition, ri.LnJliens[5].AgencyCounty , '');
    SELF.Liens5_AgencyState:= IF(~suppress_condition, ri.LnJliens[5].AgencyState, '');
    SELF.Liens5_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[5].ConsumerStatementId), '');
    SELF.Liens5_orig_rmsid := IF(~suppress_condition, ri.LnJliens[5].orig_rmsid, '');
    SELF.Liens6_Seq:= IF(~suppress_condition, ri.LnJliens[6].Seq, '');
    SELF.Liens6_DateFiled:= IF(~suppress_condition, ri.LnJliens[6].DateFiled, '');
    SELF.Liens6_LienTypeID := IF(~suppress_condition, ri.LnJliens[6].LienTypeID, '');
    SELF.Liens6_LienType := IF(~suppress_condition, ri.LnJliens[6].LienType , '');
    SELF.Liens6_Amount := IF(~suppress_condition, ri.LnJliens[6].Amount , '');
    SELF.Liens6_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[6].ReleaseDate, '');
    SELF.Liens6_DateLastSeen := IF(~suppress_condition, ri.LnJliens[6].DateLastSeen , '');
    SELF.Liens6_FilingNumber := IF(~suppress_condition, ri.LnJliens[6].FilingNumber , '');
    SELF.Liens6_FilingBook := IF(~suppress_condition, ri.LnJliens[6].FilingBook , '');
    SELF.Liens6_FilingPage := IF(~suppress_condition, ri.LnJliens[6].FilingPage , '');
    SELF.Liens6_Agency := IF(~suppress_condition, ri.LnJliens[6].Agency , '');
    SELF.Liens6_AgencyCounty := IF(~suppress_condition, ri.LnJliens[6].AgencyCounty , '');
    SELF.Liens6_AgencyState:= IF(~suppress_condition, ri.LnJliens[6].AgencyState, '');
    SELF.Liens6_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[6].ConsumerStatementId), '');
    SELF.Liens6_orig_rmsid := IF(~suppress_condition, ri.LnJliens[6].orig_rmsid, '');
    SELF.Liens7_Seq:= IF(~suppress_condition, ri.LnJliens[7].Seq, '');
    SELF.Liens7_DateFiled:= IF(~suppress_condition, ri.LnJliens[7].DateFiled, '');
    SELF.Liens7_LienTypeID := IF(~suppress_condition, ri.LnJliens[7].LienTypeID, '');
    SELF.Liens7_LienType := IF(~suppress_condition, ri.LnJliens[7].LienType , '');
    SELF.Liens7_Amount := IF(~suppress_condition, ri.LnJliens[7].Amount , '');
    SELF.Liens7_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[7].ReleaseDate, '');
    SELF.Liens7_DateLastSeen := IF(~suppress_condition, ri.LnJliens[7].DateLastSeen , '');
    SELF.Liens7_FilingNumber := IF(~suppress_condition, ri.LnJliens[7].FilingNumber , '');
    SELF.Liens7_FilingBook := IF(~suppress_condition, ri.LnJliens[7].FilingBook , '');
    SELF.Liens7_FilingPage := IF(~suppress_condition, ri.LnJliens[7].FilingPage , '');
    SELF.Liens7_Agency := IF(~suppress_condition, ri.LnJliens[7].Agency , '');
    SELF.Liens7_AgencyCounty := IF(~suppress_condition, ri.LnJliens[7].AgencyCounty , '');
    SELF.Liens7_AgencyState:= IF(~suppress_condition, ri.LnJliens[7].AgencyState, '');
    SELF.Liens7_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[7].ConsumerStatementId), '');
    SELF.Liens7_orig_rmsid := IF(~suppress_condition, ri.LnJliens[7].orig_rmsid, '');
    SELF.Liens8_Seq:= IF(~suppress_condition, ri.LnJliens[8].Seq, '');
    SELF.Liens8_DateFiled:= IF(~suppress_condition, ri.LnJliens[8].DateFiled, '');
    SELF.Liens8_LienTypeID := IF(~suppress_condition, ri.LnJliens[8].LienTypeID, '');
    SELF.Liens8_LienType := IF(~suppress_condition, ri.LnJliens[8].LienType , '');
    SELF.Liens8_Amount := IF(~suppress_condition, ri.LnJliens[8].Amount , '');
    SELF.Liens8_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[8].ReleaseDate, '');
    SELF.Liens8_DateLastSeen := IF(~suppress_condition, ri.LnJliens[8].DateLastSeen , '');
    SELF.Liens8_FilingNumber := IF(~suppress_condition, ri.LnJliens[8].FilingNumber , '');
    SELF.Liens8_FilingBook := IF(~suppress_condition, ri.LnJliens[8].FilingBook , '');
    SELF.Liens8_FilingPage := IF(~suppress_condition, ri.LnJliens[8].FilingPage , '');
    SELF.Liens8_Agency := IF(~suppress_condition, ri.LnJliens[8].Agency , '');
    SELF.Liens8_AgencyCounty := IF(~suppress_condition, ri.LnJliens[8].AgencyCounty , '');
    SELF.Liens8_AgencyState:= IF(~suppress_condition, ri.LnJliens[8].AgencyState, '');
    SELF.Liens8_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[8].ConsumerStatementId), '');
    SELF.Liens8_orig_rmsid := IF(~suppress_condition, ri.LnJliens[8].orig_rmsid, '');
    SELF.Liens9_Seq:= IF(~suppress_condition, ri.LnJliens[9].Seq, '');
    SELF.Liens9_DateFiled:= IF(~suppress_condition, ri.LnJliens[9].DateFiled, '');
    SELF.Liens9_LienTypeID := IF(~suppress_condition, ri.LnJliens[9].LienTypeID, '');
    SELF.Liens9_LienType := IF(~suppress_condition, ri.LnJliens[9].LienType , '');
    SELF.Liens9_Amount := IF(~suppress_condition, ri.LnJliens[9].Amount , '');
    SELF.Liens9_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[9].ReleaseDate, '');
    SELF.Liens9_DateLastSeen := IF(~suppress_condition, ri.LnJliens[9].DateLastSeen , '');
    SELF.Liens9_FilingNumber := IF(~suppress_condition, ri.LnJliens[9].FilingNumber , '');
    SELF.Liens9_FilingBook := IF(~suppress_condition, ri.LnJliens[9].FilingBook , '');
    SELF.Liens9_FilingPage := IF(~suppress_condition, ri.LnJliens[9].FilingPage , '');
    SELF.Liens9_Agency := IF(~suppress_condition, ri.LnJliens[9].Agency , '');
    SELF.Liens9_AgencyCounty := IF(~suppress_condition, ri.LnJliens[9].AgencyCounty , '');
    SELF.Liens9_AgencyState:= IF(~suppress_condition, ri.LnJliens[9].AgencyState, '');
    SELF.Liens9_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[9].ConsumerStatementId), '');
    SELF.Liens9_orig_rmsid := IF(~suppress_condition, ri.LnJliens[9].orig_rmsid, '');
    SELF.Liens10_Seq:= IF(~suppress_condition, ri.LnJliens[10].Seq , '');
    SELF.Liens10_DateFiled:= IF(~suppress_condition, ri.LnJliens[10].DateFiled , '');
    SELF.Liens10_LienTypeID := IF(~suppress_condition, ri.LnJliens[10].LienTypeID, '');
    SELF.Liens10_LienType := IF(~suppress_condition, ri.LnJliens[10].LienType, '');
    SELF.Liens10_Amount := IF(~suppress_condition, ri.LnJliens[10].Amount, '');
    SELF.Liens10_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[10].ReleaseDate , '');
    SELF.Liens10_DateLastSeen := IF(~suppress_condition, ri.LnJliens[10].DateLastSeen, '');
    SELF.Liens10_FilingNumber := IF(~suppress_condition, ri.LnJliens[10].FilingNumber, '');
    SELF.Liens10_FilingBook := IF(~suppress_condition, ri.LnJliens[10].FilingBook, '');
    SELF.Liens10_FilingPage := IF(~suppress_condition, ri.LnJliens[10].FilingPage, '');
    SELF.Liens10_Agency := IF(~suppress_condition, ri.LnJliens[10].Agency, '');
    SELF.Liens10_AgencyCounty := IF(~suppress_condition, ri.LnJliens[10].AgencyCounty, '');
    SELF.Liens10_AgencyState:= IF(~suppress_condition, ri.LnJliens[10].AgencyState , '');
    SELF.Liens10_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[10].ConsumerStatementId), '');
    SELF.Liens10_orig_rmsid := IF(~suppress_condition, ri.LnJliens[10].orig_rmsid, '');
    SELF.Liens11_Seq:= IF(~suppress_condition, ri.LnJliens[11].Seq, '');
    SELF.Liens11_DateFiled:= IF(~suppress_condition, ri.LnJliens[11].DateFiled, '');
    SELF.Liens11_LienTypeID := IF(~suppress_condition, ri.LnJliens[11].LienTypeID, '');
    SELF.Liens11_LienType := IF(~suppress_condition, ri.LnJliens[11].LienType, '');
    SELF.Liens11_Amount := IF(~suppress_condition, ri.LnJliens[11].Amount, '');
    SELF.Liens11_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[11].ReleaseDate, '');
    SELF.Liens11_DateLastSeen := IF(~suppress_condition, ri.LnJliens[11].DateLastSeen, '');
    SELF.Liens11_FilingNumber := IF(~suppress_condition, ri.LnJliens[11].FilingNumber, '');
    SELF.Liens11_FilingBook := IF(~suppress_condition, ri.LnJliens[11].FilingBook, '');
    SELF.Liens11_FilingPage := IF(~suppress_condition, ri.LnJliens[11].FilingPage, '');
    SELF.Liens11_Agency := IF(~suppress_condition, ri.LnJliens[11].Agency , '');
    SELF.Liens11_AgencyCounty := IF(~suppress_condition, ri.LnJliens[11].AgencyCounty, '');
    SELF.Liens11_AgencyState:= IF(~suppress_condition, ri.LnJliens[11].AgencyState, '');
    SELF.Liens11_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[11].ConsumerStatementId), '');
    SELF.Liens11_orig_rmsid := IF(~suppress_condition, ri.LnJliens[11].orig_rmsid, '');
    SELF.Liens12_Seq:= IF(~suppress_condition, ri.LnJliens[12].Seq, '');
    SELF.Liens12_DateFiled:= IF(~suppress_condition, ri.LnJliens[12].DateFiled, '');
    SELF.Liens12_LienTypeID := IF(~suppress_condition, ri.LnJliens[12].LienTypeID, '');
    SELF.Liens12_LienType := IF(~suppress_condition, ri.LnJliens[12].LienType, '');
    SELF.Liens12_Amount := IF(~suppress_condition, ri.LnJliens[12].Amount, '');
    SELF.Liens12_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[12].ReleaseDate, '');
    SELF.Liens12_DateLastSeen := IF(~suppress_condition, ri.LnJliens[12].DateLastSeen, '');
    SELF.Liens12_FilingNumber := IF(~suppress_condition, ri.LnJliens[12].FilingNumber, '');
    SELF.Liens12_FilingBook := IF(~suppress_condition, ri.LnJliens[12].FilingBook, '');
    SELF.Liens12_FilingPage := IF(~suppress_condition, ri.LnJliens[12].FilingPage, '');
    SELF.Liens12_Agency := IF(~suppress_condition, ri.LnJliens[12].Agency, ''); 
    SELF.Liens12_AgencyCounty := IF(~suppress_condition, ri.LnJliens[12].AgencyCounty, '');
    SELF.Liens12_AgencyState:= IF(~suppress_condition, ri.LnJliens[12].AgencyState, '');
    SELF.Liens12_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[12].ConsumerStatementId), '');
    SELF.Liens12_orig_rmsid := IF(~suppress_condition, ri.LnJliens[12].orig_rmsid, '');
    SELF.Liens13_Seq:= IF(~suppress_condition, ri.LnJliens[13].Seq, '');
    SELF.Liens13_DateFiled:= IF(~suppress_condition, ri.LnJliens[13].DateFiled, '');
    SELF.Liens13_LienTypeID := IF(~suppress_condition, ri.LnJliens[13].LienTypeID, '');
    SELF.Liens13_LienType := IF(~suppress_condition, ri.LnJliens[13].LienType, '');
    SELF.Liens13_Amount := IF(~suppress_condition, ri.LnJliens[13].Amount, '');
    SELF.Liens13_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[13].ReleaseDate, '');
    SELF.Liens13_DateLastSeen := IF(~suppress_condition, ri.LnJliens[13].DateLastSeen, '');
    SELF.Liens13_FilingNumber := IF(~suppress_condition, ri.LnJliens[13].FilingNumber, '');
    SELF.Liens13_FilingBook := IF(~suppress_condition, ri.LnJliens[13].FilingBook, '');
    SELF.Liens13_FilingPage := IF(~suppress_condition, ri.LnJliens[13].FilingPage, '');
    SELF.Liens13_Agency := IF(~suppress_condition, ri.LnJliens[13].Agency, ''); 
    SELF.Liens13_AgencyCounty := IF(~suppress_condition, ri.LnJliens[13].AgencyCounty, '');
    SELF.Liens13_AgencyState:= IF(~suppress_condition, ri.LnJliens[13].AgencyState, '');
    SELF.Liens13_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[13].ConsumerStatementId), '');
    SELF.Liens13_orig_rmsid := IF(~suppress_condition, ri.LnJliens[13].orig_rmsid, '');
    SELF.Liens14_Seq:= IF(~suppress_condition, ri.LnJliens[14].Seq, '');
    SELF.Liens14_DateFiled:= IF(~suppress_condition, ri.LnJliens[14].DateFiled, '');
    SELF.Liens14_LienTypeID := IF(~suppress_condition, ri.LnJliens[14].LienTypeID, '');
    SELF.Liens14_LienType := IF(~suppress_condition, ri.LnJliens[14].LienType, '');
    SELF.Liens14_Amount := IF(~suppress_condition, ri.LnJliens[14].Amount, '');
    SELF.Liens14_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[14].ReleaseDate, '');
    SELF.Liens14_DateLastSeen := IF(~suppress_condition, ri.LnJliens[14].DateLastSeen, '');
    SELF.Liens14_FilingNumber := IF(~suppress_condition, ri.LnJliens[14].FilingNumber, '');
    SELF.Liens14_FilingBook := IF(~suppress_condition, ri.LnJliens[14].FilingBook, '');
    SELF.Liens14_FilingPage := IF(~suppress_condition, ri.LnJliens[14].FilingPage, '');
    SELF.Liens14_Agency := IF(~suppress_condition, ri.LnJliens[14].Agency, ''); 
    SELF.Liens14_AgencyCounty := IF(~suppress_condition, ri.LnJliens[14].AgencyCounty, '');
    SELF.Liens14_AgencyState:= IF(~suppress_condition, ri.LnJliens[14].AgencyState, '');
    SELF.Liens14_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[14].ConsumerStatementId), '');
    SELF.Liens14_orig_rmsid := IF(~suppress_condition, ri.LnJliens[14].orig_rmsid, '');
    SELF.Liens15_Seq:= IF(~suppress_condition, ri.LnJliens[15].Seq, '');
    SELF.Liens15_DateFiled:= IF(~suppress_condition, ri.LnJliens[15].DateFiled, '');
    SELF.Liens15_LienTypeID := IF(~suppress_condition, ri.LnJliens[15].LienTypeID, '');
    SELF.Liens15_LienType := IF(~suppress_condition, ri.LnJliens[15].LienType , '');
    SELF.Liens15_Amount := IF(~suppress_condition, ri.LnJliens[15].Amount , '');
    SELF.Liens15_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[15].ReleaseDate, '');
    SELF.Liens15_DateLastSeen := IF(~suppress_condition, ri.LnJliens[15].DateLastSeen , '');
    SELF.Liens15_FilingNumber := IF(~suppress_condition, ri.LnJliens[15].FilingNumber , '');
    SELF.Liens15_FilingBook := IF(~suppress_condition, ri.LnJliens[15].FilingBook , '');
    SELF.Liens15_FilingPage := IF(~suppress_condition, ri.LnJliens[15].FilingPage , '');
    SELF.Liens15_Agency := IF(~suppress_condition, ri.LnJliens[15].Agency , '');
    SELF.Liens15_AgencyCounty := IF(~suppress_condition, ri.LnJliens[15].AgencyCounty , '');
    SELF.Liens15_AgencyState:= IF(~suppress_condition, ri.LnJliens[15].AgencyState, '');
    SELF.Liens15_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[15].ConsumerStatementId), '');
    SELF.Liens15_orig_rmsid := IF(~suppress_condition, ri.LnJliens[15].orig_rmsid, '');
    SELF.Liens16_Seq:= IF(~suppress_condition, ri.LnJliens[16].Seq, '');
    SELF.Liens16_DateFiled:= IF(~suppress_condition, ri.LnJliens[16].DateFiled, '');
    SELF.Liens16_LienTypeID := IF(~suppress_condition, ri.LnJliens[16].LienTypeID, '');
    SELF.Liens16_LienType := IF(~suppress_condition, ri.LnJliens[16].LienType , '');
    SELF.Liens16_Amount := IF(~suppress_condition, ri.LnJliens[16].Amount , '');
    SELF.Liens16_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[16].ReleaseDate, '');
    SELF.Liens16_DateLastSeen := IF(~suppress_condition, ri.LnJliens[16].DateLastSeen , '');
    SELF.Liens16_FilingNumber := IF(~suppress_condition, ri.LnJliens[16].FilingNumber , '');
    SELF.Liens16_FilingBook := IF(~suppress_condition, ri.LnJliens[16].FilingBook , '');
    SELF.Liens16_FilingPage := IF(~suppress_condition, ri.LnJliens[16].FilingPage , '');
    SELF.Liens16_Agency := IF(~suppress_condition, ri.LnJliens[16].Agency , '');
    SELF.Liens16_AgencyCounty := IF(~suppress_condition, ri.LnJliens[16].AgencyCounty , '');
    SELF.Liens16_AgencyState:= IF(~suppress_condition, ri.LnJliens[16].AgencyState, '');
    SELF.Liens16_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[16].ConsumerStatementId), '');
    SELF.Liens16_orig_rmsid := IF(~suppress_condition, ri.LnJliens[16].orig_rmsid, '');
    SELF.Liens17_Seq:= IF(~suppress_condition, ri.LnJliens[17].Seq, '');
    SELF.Liens17_DateFiled:= IF(~suppress_condition, ri.LnJliens[17].DateFiled, '');
    SELF.Liens17_LienTypeID := IF(~suppress_condition, ri.LnJliens[17].LienTypeID, '');
    SELF.Liens17_LienType := IF(~suppress_condition, ri.LnJliens[17].LienType , '');
    SELF.Liens17_Amount := IF(~suppress_condition, ri.LnJliens[17].Amount , '');
    SELF.Liens17_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[17].ReleaseDate, '');
    SELF.Liens17_DateLastSeen := IF(~suppress_condition, ri.LnJliens[17].DateLastSeen , '');
    SELF.Liens17_FilingNumber := IF(~suppress_condition, ri.LnJliens[17].FilingNumber , '');
    SELF.Liens17_FilingBook := IF(~suppress_condition, ri.LnJliens[17].FilingBook , '');
    SELF.Liens17_FilingPage := IF(~suppress_condition, ri.LnJliens[17].FilingPage , '');
    SELF.Liens17_Agency := IF(~suppress_condition, ri.LnJliens[17].Agency , '');
    SELF.Liens17_AgencyCounty := IF(~suppress_condition, ri.LnJliens[17].AgencyCounty , '');
    SELF.Liens17_AgencyState:= IF(~suppress_condition, ri.LnJliens[17].AgencyState, '');
    SELF.Liens17_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[17].ConsumerStatementId), '');
    SELF.Liens17_orig_rmsid := IF(~suppress_condition, ri.LnJliens[17].orig_rmsid, '');
    SELF.Liens18_Seq:= IF(~suppress_condition, ri.LnJliens[18].Seq, '');
    SELF.Liens18_DateFiled:= IF(~suppress_condition, ri.LnJliens[18].DateFiled, '');
    SELF.Liens18_LienTypeID := IF(~suppress_condition, ri.LnJliens[18].LienTypeID, '');
    SELF.Liens18_LienType := IF(~suppress_condition, ri.LnJliens[18].LienType , '');
    SELF.Liens18_Amount := IF(~suppress_condition, ri.LnJliens[18].Amount , '');
    SELF.Liens18_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[18].ReleaseDate, '');
    SELF.Liens18_DateLastSeen := IF(~suppress_condition, ri.LnJliens[18].DateLastSeen , '');
    SELF.Liens18_FilingNumber := IF(~suppress_condition, ri.LnJliens[18].FilingNumber , '');
    SELF.Liens18_FilingBook := IF(~suppress_condition, ri.LnJliens[18].FilingBook , '');
    SELF.Liens18_FilingPage := IF(~suppress_condition, ri.LnJliens[18].FilingPage , '');
    SELF.Liens18_Agency := IF(~suppress_condition, ri.LnJliens[18].Agency , '');
    SELF.Liens18_AgencyCounty := IF(~suppress_condition, ri.LnJliens[18].AgencyCounty , '');
    SELF.Liens18_AgencyState:= IF(~suppress_condition, ri.LnJliens[18].AgencyState, '');
    SELF.Liens18_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[18].ConsumerStatementId), '');
    SELF.Liens18_orig_rmsid := IF(~suppress_condition, ri.LnJliens[18].orig_rmsid, '');
    SELF.Liens19_Seq:= IF(~suppress_condition, ri.LnJliens[19].Seq, '');
    SELF.Liens19_DateFiled:= IF(~suppress_condition, ri.LnJliens[19].DateFiled, '');
    SELF.Liens19_LienTypeID := IF(~suppress_condition, ri.LnJliens[19].LienTypeID, '');
    SELF.Liens19_LienType := IF(~suppress_condition, ri.LnJliens[19].LienType , '');
    SELF.Liens19_Amount := IF(~suppress_condition, ri.LnJliens[19].Amount , '');
    SELF.Liens19_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[19].ReleaseDate, '');
    SELF.Liens19_DateLastSeen := IF(~suppress_condition, ri.LnJliens[19].DateLastSeen , '');
    SELF.Liens19_FilingNumber := IF(~suppress_condition, ri.LnJliens[19].FilingNumber , '');
    SELF.Liens19_FilingBook := IF(~suppress_condition, ri.LnJliens[19].FilingBook , '');
    SELF.Liens19_FilingPage := IF(~suppress_condition, ri.LnJliens[19].FilingPage , '');
    SELF.Liens19_Agency := IF(~suppress_condition, ri.LnJliens[19].Agency , '');
    SELF.Liens19_AgencyCounty := IF(~suppress_condition, ri.LnJliens[19].AgencyCounty , '');
    SELF.Liens19_AgencyState:= IF(~suppress_condition, ri.LnJliens[19].AgencyState, '');
    SELF.Liens19_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[19].ConsumerStatementId), '');
    SELF.Liens19_orig_rmsid := IF(~suppress_condition, ri.LnJliens[19].orig_rmsid, '');
    SELF.Liens20_Seq:= IF(~suppress_condition, ri.LnJliens[20].Seq , '');
    SELF.Liens20_DateFiled:= IF(~suppress_condition, ri.LnJliens[20].DateFiled , '');
    SELF.Liens20_LienTypeID := IF(~suppress_condition, ri.LnJliens[20].LienTypeID, '');
    SELF.Liens20_LienType := IF(~suppress_condition, ri.LnJliens[20].LienType, '');
    SELF.Liens20_Amount := IF(~suppress_condition, ri.LnJliens[20].Amount, '');
    SELF.Liens20_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[20].ReleaseDate , '');
    SELF.Liens20_DateLastSeen := IF(~suppress_condition, ri.LnJliens[20].DateLastSeen, '');
    SELF.Liens20_FilingNumber := IF(~suppress_condition, ri.LnJliens[20].FilingNumber, '');
    SELF.Liens20_FilingBook := IF(~suppress_condition, ri.LnJliens[20].FilingBook, '');
    SELF.Liens20_FilingPage := IF(~suppress_condition, ri.LnJliens[20].FilingPage, '');
    SELF.Liens20_Agency := IF(~suppress_condition, ri.LnJliens[20].Agency, '');
    SELF.Liens20_AgencyCounty := IF(~suppress_condition, ri.LnJliens[20].AgencyCounty, '');
    SELF.Liens20_AgencyState:= IF(~suppress_condition, ri.LnJliens[20].AgencyState , '');
    SELF.Liens20_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[20].ConsumerStatementId), '');
    SELF.Liens20_orig_rmsid := IF(~suppress_condition, ri.LnJliens[20].orig_rmsid, '');
    SELF.Liens21_Seq:= IF(~suppress_condition, ri.LnJliens[21].Seq, '');
    SELF.Liens21_DateFiled:= IF(~suppress_condition, ri.LnJliens[21].DateFiled, '');
    SELF.Liens21_LienTypeID := IF(~suppress_condition, ri.LnJliens[21].LienTypeID, '');
    SELF.Liens21_LienType := IF(~suppress_condition, ri.LnJliens[21].LienType, '');
    SELF.Liens21_Amount := IF(~suppress_condition, ri.LnJliens[21].Amount, '');
    SELF.Liens21_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[21].ReleaseDate, '');
    SELF.Liens21_DateLastSeen := IF(~suppress_condition, ri.LnJliens[21].DateLastSeen, '');
    SELF.Liens21_FilingNumber := IF(~suppress_condition, ri.LnJliens[21].FilingNumber, '');
    SELF.Liens21_FilingBook := IF(~suppress_condition, ri.LnJliens[21].FilingBook, '');
    SELF.Liens21_FilingPage := IF(~suppress_condition, ri.LnJliens[21].FilingPage, '');
    SELF.Liens21_Agency := IF(~suppress_condition, ri.LnJliens[21].Agency , '');
    SELF.Liens21_AgencyCounty := IF(~suppress_condition, ri.LnJliens[21].AgencyCounty, '');
    SELF.Liens21_AgencyState:= IF(~suppress_condition, ri.LnJliens[21].AgencyState, '');
    SELF.Liens21_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[21].ConsumerStatementId), '');
    SELF.Liens21_orig_rmsid := IF(~suppress_condition, ri.LnJliens[21].orig_rmsid, '');
    SELF.Liens22_Seq:= IF(~suppress_condition, ri.LnJliens[22].Seq, '');
    SELF.Liens22_DateFiled:= IF(~suppress_condition, ri.LnJliens[22].DateFiled, '');
    SELF.Liens22_LienTypeID := IF(~suppress_condition, ri.LnJliens[22].LienTypeID, '');
    SELF.Liens22_LienType := IF(~suppress_condition, ri.LnJliens[22].LienType, '');
    SELF.Liens22_Amount := IF(~suppress_condition, ri.LnJliens[22].Amount, '');
    SELF.Liens22_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[22].ReleaseDate, '');
    SELF.Liens22_DateLastSeen := IF(~suppress_condition, ri.LnJliens[22].DateLastSeen, '');
    SELF.Liens22_FilingNumber := IF(~suppress_condition, ri.LnJliens[22].FilingNumber, '');
    SELF.Liens22_FilingBook := IF(~suppress_condition, ri.LnJliens[22].FilingBook, '');
    SELF.Liens22_FilingPage := IF(~suppress_condition, ri.LnJliens[22].FilingPage, '');
    SELF.Liens22_Agency := IF(~suppress_condition, ri.LnJliens[22].Agency, ''); 
    SELF.Liens22_AgencyCounty := IF(~suppress_condition, ri.LnJliens[22].AgencyCounty, '');
    SELF.Liens22_AgencyState:= IF(~suppress_condition, ri.LnJliens[22].AgencyState, '');
    SELF.Liens22_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[22].ConsumerStatementId), '');
    SELF.Liens22_orig_rmsid := IF(~suppress_condition, ri.LnJliens[22].orig_rmsid, '');
    SELF.Liens23_Seq:= IF(~suppress_condition, ri.LnJliens[23].Seq, '');
    SELF.Liens23_DateFiled:= IF(~suppress_condition, ri.LnJliens[23].DateFiled, '');
    SELF.Liens23_LienTypeID := IF(~suppress_condition, ri.LnJliens[23].LienTypeID, '');
    SELF.Liens23_LienType := IF(~suppress_condition, ri.LnJliens[23].LienType, '');
    SELF.Liens23_Amount := IF(~suppress_condition, ri.LnJliens[23].Amount, '');
    SELF.Liens23_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[23].ReleaseDate, '');
    SELF.Liens23_DateLastSeen := IF(~suppress_condition, ri.LnJliens[23].DateLastSeen, '');
    SELF.Liens23_FilingNumber := IF(~suppress_condition, ri.LnJliens[23].FilingNumber, '');
    SELF.Liens23_FilingBook := IF(~suppress_condition, ri.LnJliens[23].FilingBook, '');
    SELF.Liens23_FilingPage := IF(~suppress_condition, ri.LnJliens[23].FilingPage, ''); 
    SELF.Liens23_Agency := IF(~suppress_condition, ri.LnJliens[23].Agency, ''); 
    SELF.Liens23_AgencyCounty := IF(~suppress_condition, ri.LnJliens[23].AgencyCounty, '');
    SELF.Liens23_AgencyState:= IF(~suppress_condition, ri.LnJliens[23].AgencyState, '');
    SELF.Liens23_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[23].ConsumerStatementId), '');
    SELF.Liens23_orig_rmsid := IF(~suppress_condition, ri.LnJliens[23].orig_rmsid, '');
    SELF.Liens24_Seq:= IF(~suppress_condition, ri.LnJliens[24].Seq, '');
    SELF.Liens24_DateFiled:= IF(~suppress_condition, ri.LnJliens[24].DateFiled, '');
    SELF.Liens24_LienTypeID := IF(~suppress_condition, ri.LnJliens[24].LienTypeID, '');
    SELF.Liens24_LienType := IF(~suppress_condition, ri.LnJliens[24].LienType, '');
    SELF.Liens24_Amount := IF(~suppress_condition, ri.LnJliens[24].Amount, '');
    SELF.Liens24_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[24].ReleaseDate, '');
    SELF.Liens24_DateLastSeen := IF(~suppress_condition, ri.LnJliens[24].DateLastSeen, '');
    SELF.Liens24_FilingNumber := IF(~suppress_condition, ri.LnJliens[24].FilingNumber, '');
    SELF.Liens24_FilingBook := IF(~suppress_condition, ri.LnJliens[24].FilingBook, '');
    SELF.Liens24_FilingPage := IF(~suppress_condition, ri.LnJliens[24].FilingPage, '');
    SELF.Liens24_Agency := IF(~suppress_condition, ri.LnJliens[24].Agency, ''); 
    SELF.Liens24_AgencyCounty := IF(~suppress_condition, ri.LnJliens[24].AgencyCounty, '');
    SELF.Liens24_AgencyState:= IF(~suppress_condition, ri.LnJliens[24].AgencyState, '');
    SELF.Liens24_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[24].ConsumerStatementId), '');
    SELF.Liens24_orig_rmsid := IF(~suppress_condition, ri.LnJliens[24].orig_rmsid, '');
    SELF.Liens25_Seq:= IF(~suppress_condition, ri.LnJliens[25].Seq, '');
    SELF.Liens25_DateFiled:= IF(~suppress_condition, ri.LnJliens[25].DateFiled, '');
    SELF.Liens25_LienTypeID := IF(~suppress_condition, ri.LnJliens[25].LienTypeID, '');
    SELF.Liens25_LienType := IF(~suppress_condition, ri.LnJliens[25].LienType , '');
    SELF.Liens25_Amount := IF(~suppress_condition, ri.LnJliens[25].Amount , '');
    SELF.Liens25_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[25].ReleaseDate, '');
    SELF.Liens25_DateLastSeen := IF(~suppress_condition, ri.LnJliens[25].DateLastSeen , '');
    SELF.Liens25_FilingNumber := IF(~suppress_condition, ri.LnJliens[25].FilingNumber , '');
    SELF.Liens25_FilingBook := IF(~suppress_condition, ri.LnJliens[25].FilingBook , '');
    SELF.Liens25_FilingPage := IF(~suppress_condition, ri.LnJliens[25].FilingPage , '');
    SELF.Liens25_Agency := IF(~suppress_condition, ri.LnJliens[25].Agency , '');
    SELF.Liens25_AgencyCounty := IF(~suppress_condition, ri.LnJliens[25].AgencyCounty , '');
    SELF.Liens25_AgencyState:= IF(~suppress_condition, ri.LnJliens[25].AgencyState, '');
    SELF.Liens25_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[25].ConsumerStatementId), '');
    SELF.Liens25_orig_rmsid := IF(~suppress_condition, ri.LnJliens[25].orig_rmsid, '');
    SELF.Liens26_Seq:= IF(~suppress_condition, ri.LnJliens[26].Seq, '');
    SELF.Liens26_DateFiled:= IF(~suppress_condition, ri.LnJliens[26].DateFiled, '');
    SELF.Liens26_LienTypeID := IF(~suppress_condition, ri.LnJliens[26].LienTypeID, '');
    SELF.Liens26_LienType := IF(~suppress_condition, ri.LnJliens[26].LienType , '');
    SELF.Liens26_Amount := IF(~suppress_condition, ri.LnJliens[26].Amount , '');
    SELF.Liens26_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[26].ReleaseDate, '');
    SELF.Liens26_DateLastSeen := IF(~suppress_condition, ri.LnJliens[26].DateLastSeen , '');
    SELF.Liens26_FilingNumber := IF(~suppress_condition, ri.LnJliens[26].FilingNumber , '');
    SELF.Liens26_FilingBook := IF(~suppress_condition, ri.LnJliens[26].FilingBook , '');
    SELF.Liens26_FilingPage := IF(~suppress_condition, ri.LnJliens[26].FilingPage , '');
    SELF.Liens26_Agency := IF(~suppress_condition, ri.LnJliens[26].Agency , '');
    SELF.Liens26_AgencyCounty := IF(~suppress_condition, ri.LnJliens[26].AgencyCounty , '');
    SELF.Liens26_AgencyState:= IF(~suppress_condition, ri.LnJliens[26].AgencyState, '');
    SELF.Liens26_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[26].ConsumerStatementId), '');
    SELF.Liens26_orig_rmsid := IF(~suppress_condition, ri.LnJliens[26].orig_rmsid, '');
    SELF.Liens27_Seq:= IF(~suppress_condition, ri.LnJliens[27].Seq, '');
    SELF.Liens27_DateFiled:= IF(~suppress_condition, ri.LnJliens[27].DateFiled, '');
    SELF.Liens27_LienTypeID := IF(~suppress_condition, ri.LnJliens[27].LienTypeID, '');
    SELF.Liens27_LienType := IF(~suppress_condition, ri.LnJliens[27].LienType , '');
    SELF.Liens27_Amount := IF(~suppress_condition, ri.LnJliens[27].Amount , '');
    SELF.Liens27_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[27].ReleaseDate, '');
    SELF.Liens27_DateLastSeen := IF(~suppress_condition, ri.LnJliens[27].DateLastSeen , '');
    SELF.Liens27_FilingNumber := IF(~suppress_condition, ri.LnJliens[27].FilingNumber , '');
    SELF.Liens27_FilingBook := IF(~suppress_condition, ri.LnJliens[27].FilingBook , '');
    SELF.Liens27_FilingPage := IF(~suppress_condition, ri.LnJliens[27].FilingPage , '');
    SELF.Liens27_Agency := IF(~suppress_condition, ri.LnJliens[27].Agency , '');
    SELF.Liens27_AgencyCounty := IF(~suppress_condition, ri.LnJliens[27].AgencyCounty , '');
    SELF.Liens27_AgencyState:= IF(~suppress_condition, ri.LnJliens[27].AgencyState, '');
    SELF.Liens27_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[27].ConsumerStatementId), '');
    SELF.Liens27_orig_rmsid := IF(~suppress_condition, ri.LnJliens[27].orig_rmsid, '');
    SELF.Liens28_Seq:= IF(~suppress_condition, ri.LnJliens[28].Seq, '');
    SELF.Liens28_DateFiled:= IF(~suppress_condition, ri.LnJliens[28].DateFiled, '');
    SELF.Liens28_LienTypeID := IF(~suppress_condition, ri.LnJliens[28].LienTypeID, '');
    SELF.Liens28_LienType := IF(~suppress_condition, ri.LnJliens[28].LienType , '');
    SELF.Liens28_Amount := IF(~suppress_condition, ri.LnJliens[28].Amount , '');
    SELF.Liens28_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[28].ReleaseDate, '');
    SELF.Liens28_DateLastSeen := IF(~suppress_condition, ri.LnJliens[28].DateLastSeen , '');
    SELF.Liens28_FilingNumber := IF(~suppress_condition, ri.LnJliens[28].FilingNumber , '');
    SELF.Liens28_FilingBook := IF(~suppress_condition, ri.LnJliens[28].FilingBook , '');
    SELF.Liens28_FilingPage := IF(~suppress_condition, ri.LnJliens[28].FilingPage , '');
    SELF.Liens28_Agency := IF(~suppress_condition, ri.LnJliens[28].Agency , '');
    SELF.Liens28_AgencyCounty := IF(~suppress_condition, ri.LnJliens[28].AgencyCounty , '');
    SELF.Liens28_AgencyState:= IF(~suppress_condition, ri.LnJliens[28].AgencyState, '');
    SELF.Liens28_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[28].ConsumerStatementId), '');
    SELF.Liens28_orig_rmsid := IF(~suppress_condition, ri.LnJliens[28].orig_rmsid, '');
    SELF.Liens29_Seq:= IF(~suppress_condition, ri.LnJliens[29].Seq, '');
    SELF.Liens29_DateFiled:= IF(~suppress_condition, ri.LnJliens[29].DateFiled, '');
    SELF.Liens29_LienTypeID := IF(~suppress_condition, ri.LnJliens[29].LienTypeID, '');
    SELF.Liens29_LienType := IF(~suppress_condition, ri.LnJliens[29].LienType , '');
    SELF.Liens29_Amount := IF(~suppress_condition, ri.LnJliens[29].Amount , '');
    SELF.Liens29_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[29].ReleaseDate, '');
    SELF.Liens29_DateLastSeen := IF(~suppress_condition, ri.LnJliens[29].DateLastSeen , '');
    SELF.Liens29_FilingNumber := IF(~suppress_condition, ri.LnJliens[29].FilingNumber , '');
    SELF.Liens29_FilingBook := IF(~suppress_condition, ri.LnJliens[29].FilingBook , '');
    SELF.Liens29_FilingPage := IF(~suppress_condition, ri.LnJliens[29].FilingPage , '');
    SELF.Liens29_Agency := IF(~suppress_condition, ri.LnJliens[29].Agency , '');
    SELF.Liens29_AgencyCounty := IF(~suppress_condition, ri.LnJliens[29].AgencyCounty , '');
    SELF.Liens29_AgencyState:= IF(~suppress_condition, ri.LnJliens[29].AgencyState, '');
    SELF.Liens29_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[29].ConsumerStatementId), '');
    SELF.Liens29_orig_rmsid := IF(~suppress_condition, ri.LnJliens[29].orig_rmsid, '');
    SELF.Liens30_Seq:= IF(~suppress_condition, ri.LnJliens[30].Seq , '');
    SELF.Liens30_DateFiled:= IF(~suppress_condition, ri.LnJliens[30].DateFiled , '');
    SELF.Liens30_LienTypeID := IF(~suppress_condition, ri.LnJliens[30].LienTypeID, '');
    SELF.Liens30_LienType := IF(~suppress_condition, ri.LnJliens[30].LienType, '');
    SELF.Liens30_Amount := IF(~suppress_condition, ri.LnJliens[30].Amount, '');
    SELF.Liens30_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[30].ReleaseDate , '');
    SELF.Liens30_DateLastSeen := IF(~suppress_condition, ri.LnJliens[30].DateLastSeen, '');
    SELF.Liens30_FilingNumber := IF(~suppress_condition, ri.LnJliens[30].FilingNumber, '');
    SELF.Liens30_FilingBook := IF(~suppress_condition, ri.LnJliens[30].FilingBook, '');
    SELF.Liens30_FilingPage := IF(~suppress_condition, ri.LnJliens[30].FilingPage, '');
    SELF.Liens30_Agency := IF(~suppress_condition, ri.LnJliens[30].Agency, '');
    SELF.Liens30_AgencyCounty := IF(~suppress_condition, ri.LnJliens[30].AgencyCounty, '');
    SELF.Liens30_AgencyState:= IF(~suppress_condition, ri.LnJliens[30].AgencyState , '');
    SELF.Liens30_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[30].ConsumerStatementId), '');
    SELF.Liens30_orig_rmsid := IF(~suppress_condition, ri.LnJliens[30].orig_rmsid, '');
    SELF.Liens31_Seq:= IF(~suppress_condition, ri.LnJliens[31].Seq, '');
    SELF.Liens31_DateFiled:= IF(~suppress_condition, ri.LnJliens[31].DateFiled, '');
    SELF.Liens31_LienTypeID := IF(~suppress_condition, ri.LnJliens[31].LienTypeID, '');
    SELF.Liens31_LienType := IF(~suppress_condition, ri.LnJliens[31].LienType, '');
    SELF.Liens31_Amount := IF(~suppress_condition, ri.LnJliens[31].Amount, '');
    SELF.Liens31_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[31].ReleaseDate, '');
    SELF.Liens31_DateLastSeen := IF(~suppress_condition, ri.LnJliens[31].DateLastSeen, '');
    SELF.Liens31_FilingNumber := IF(~suppress_condition, ri.LnJliens[31].FilingNumber, '');
    SELF.Liens31_FilingBook := IF(~suppress_condition, ri.LnJliens[31].FilingBook, '');
    SELF.Liens31_FilingPage := IF(~suppress_condition, ri.LnJliens[31].FilingPage, '');
    SELF.Liens31_Agency := IF(~suppress_condition, ri.LnJliens[31].Agency , '');
    SELF.Liens31_AgencyCounty := IF(~suppress_condition, ri.LnJliens[31].AgencyCounty, '');
    SELF.Liens31_AgencyState:= IF(~suppress_condition, ri.LnJliens[31].AgencyState, '');
    SELF.Liens31_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[31].ConsumerStatementId), '');
    SELF.Liens31_orig_rmsid := IF(~suppress_condition, ri.LnJliens[31].orig_rmsid, '');
    SELF.Liens32_Seq:= IF(~suppress_condition, ri.LnJliens[32].Seq, '');
    SELF.Liens32_DateFiled:= IF(~suppress_condition, ri.LnJliens[32].DateFiled, '');
    SELF.Liens32_LienTypeID := IF(~suppress_condition, ri.LnJliens[32].LienTypeID, '');
    SELF.Liens32_LienType := IF(~suppress_condition, ri.LnJliens[32].LienType, '');
    SELF.Liens32_Amount := IF(~suppress_condition, ri.LnJliens[32].Amount, '');
    SELF.Liens32_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[32].ReleaseDate, '');
    SELF.Liens32_DateLastSeen := IF(~suppress_condition, ri.LnJliens[32].DateLastSeen, '');
    SELF.Liens32_FilingNumber := IF(~suppress_condition, ri.LnJliens[32].FilingNumber, '');
    SELF.Liens32_FilingBook := IF(~suppress_condition, ri.LnJliens[32].FilingBook, '');
    SELF.Liens32_FilingPage := IF(~suppress_condition, ri.LnJliens[32].FilingPage, '');
    SELF.Liens32_Agency := IF(~suppress_condition, ri.LnJliens[32].Agency, ''); 
    SELF.Liens32_AgencyCounty := IF(~suppress_condition, ri.LnJliens[32].AgencyCounty, '');
    SELF.Liens32_AgencyState:= IF(~suppress_condition, ri.LnJliens[32].AgencyState, '');
    SELF.Liens32_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[32].ConsumerStatementId), '');
    SELF.Liens32_orig_rmsid := IF(~suppress_condition, ri.LnJliens[32].orig_rmsid, '');
    SELF.Liens33_Seq:= IF(~suppress_condition, ri.LnJliens[33].Seq, '');
    SELF.Liens33_DateFiled:= IF(~suppress_condition, ri.LnJliens[33].DateFiled, '');
    SELF.Liens33_LienTypeID := IF(~suppress_condition, ri.LnJliens[33].LienTypeID, '');
    SELF.Liens33_LienType := IF(~suppress_condition, ri.LnJliens[33].LienType, '');
    SELF.Liens33_Amount := IF(~suppress_condition, ri.LnJliens[33].Amount, '');
    SELF.Liens33_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[33].ReleaseDate, '');
    SELF.Liens33_DateLastSeen := IF(~suppress_condition, ri.LnJliens[33].DateLastSeen, '');
    SELF.Liens33_FilingNumber := IF(~suppress_condition, ri.LnJliens[33].FilingNumber, '');
    SELF.Liens33_FilingBook := IF(~suppress_condition, ri.LnJliens[33].FilingBook, '');
    SELF.Liens33_FilingPage := IF(~suppress_condition, ri.LnJliens[33].FilingPage, ''); 
    SELF.Liens33_Agency := IF(~suppress_condition, ri.LnJliens[33].Agency, ''); 
    SELF.Liens33_AgencyCounty := IF(~suppress_condition, ri.LnJliens[33].AgencyCounty, '');
    SELF.Liens33_AgencyState:= IF(~suppress_condition, ri.LnJliens[33].AgencyState, '');
    SELF.Liens33_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[33].ConsumerStatementId), '');
    SELF.Liens33_orig_rmsid := IF(~suppress_condition, ri.LnJliens[33].orig_rmsid, '');
    SELF.Liens34_Seq:= IF(~suppress_condition, ri.LnJliens[34].Seq, '');
    SELF.Liens34_DateFiled:= IF(~suppress_condition, ri.LnJliens[34].DateFiled, '');
    SELF.Liens34_LienTypeID := IF(~suppress_condition, ri.LnJliens[34].LienTypeID, '');
    SELF.Liens34_LienType := IF(~suppress_condition, ri.LnJliens[34].LienType, '');
    SELF.Liens34_Amount := IF(~suppress_condition, ri.LnJliens[34].Amount, '');
    SELF.Liens34_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[34].ReleaseDate, '');
    SELF.Liens34_DateLastSeen := IF(~suppress_condition, ri.LnJliens[34].DateLastSeen, '');
    SELF.Liens34_FilingNumber := IF(~suppress_condition, ri.LnJliens[34].FilingNumber, '');
    SELF.Liens34_FilingBook := IF(~suppress_condition, ri.LnJliens[34].FilingBook, '');
    SELF.Liens34_FilingPage := IF(~suppress_condition, ri.LnJliens[34].FilingPage, ''); 
    SELF.Liens34_Agency := IF(~suppress_condition, ri.LnJliens[34].Agency, ''); 
    SELF.Liens34_AgencyCounty := IF(~suppress_condition, ri.LnJliens[34].AgencyCounty, '');
    SELF.Liens34_AgencyState:= IF(~suppress_condition, ri.LnJliens[34].AgencyState, '');
    SELF.Liens34_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[34].ConsumerStatementId), '');
    SELF.Liens34_orig_rmsid := IF(~suppress_condition, ri.LnJliens[34].orig_rmsid, '');
    SELF.Liens35_Seq:= IF(~suppress_condition, ri.LnJliens[35].Seq, '');
    SELF.Liens35_DateFiled:= IF(~suppress_condition, ri.LnJliens[35].DateFiled, '');
    SELF.Liens35_LienTypeID := IF(~suppress_condition, ri.LnJliens[35].LienTypeID, '');
    SELF.Liens35_LienType := IF(~suppress_condition, ri.LnJliens[35].LienType , '');
    SELF.Liens35_Amount := IF(~suppress_condition, ri.LnJliens[35].Amount , '');
    SELF.Liens35_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[35].ReleaseDate, '');
    SELF.Liens35_DateLastSeen := IF(~suppress_condition, ri.LnJliens[35].DateLastSeen , '');
    SELF.Liens35_FilingNumber := IF(~suppress_condition, ri.LnJliens[35].FilingNumber , '');
    SELF.Liens35_FilingBook := IF(~suppress_condition, ri.LnJliens[35].FilingBook , '');
    SELF.Liens35_FilingPage := IF(~suppress_condition, ri.LnJliens[35].FilingPage , '');
    SELF.Liens35_Agency := IF(~suppress_condition, ri.LnJliens[35].Agency , '');
    SELF.Liens35_AgencyCounty := IF(~suppress_condition, ri.LnJliens[35].AgencyCounty , '');
    SELF.Liens35_AgencyState:= IF(~suppress_condition, ri.LnJliens[35].AgencyState, '');
    SELF.Liens35_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[35].ConsumerStatementId), '');
    SELF.Liens35_orig_rmsid := IF(~suppress_condition, ri.LnJliens[35].orig_rmsid, '');
    SELF.Liens36_Seq:= IF(~suppress_condition, ri.LnJliens[36].Seq, '');
    SELF.Liens36_DateFiled:= IF(~suppress_condition, ri.LnJliens[36].DateFiled, '');
    SELF.Liens36_LienTypeID := IF(~suppress_condition, ri.LnJliens[36].LienTypeID, '');
    SELF.Liens36_LienType := IF(~suppress_condition, ri.LnJliens[36].LienType , '');
    SELF.Liens36_Amount := IF(~suppress_condition, ri.LnJliens[36].Amount , '');
    SELF.Liens36_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[36].ReleaseDate, '');
    SELF.Liens36_DateLastSeen := IF(~suppress_condition, ri.LnJliens[36].DateLastSeen , '');
    SELF.Liens36_FilingNumber := IF(~suppress_condition, ri.LnJliens[36].FilingNumber , '');
    SELF.Liens36_FilingBook := IF(~suppress_condition, ri.LnJliens[36].FilingBook , '');
    SELF.Liens36_FilingPage := IF(~suppress_condition, ri.LnJliens[36].FilingPage , '');
    SELF.Liens36_Agency := IF(~suppress_condition, ri.LnJliens[36].Agency , '');
    SELF.Liens36_AgencyCounty := IF(~suppress_condition, ri.LnJliens[36].AgencyCounty , '');
    SELF.Liens36_AgencyState:= IF(~suppress_condition, ri.LnJliens[36].AgencyState, '');
    SELF.Liens36_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[36].ConsumerStatementId), '');
    SELF.Liens36_orig_rmsid := IF(~suppress_condition, ri.LnJliens[36].orig_rmsid, '');
    SELF.Liens37_Seq:= IF(~suppress_condition, ri.LnJliens[37].Seq, '');
    SELF.Liens37_DateFiled:= IF(~suppress_condition, ri.LnJliens[37].DateFiled, '');
    SELF.Liens37_LienTypeID := IF(~suppress_condition, ri.LnJliens[37].LienTypeID, '');
    SELF.Liens37_LienType := IF(~suppress_condition, ri.LnJliens[37].LienType , '');
    SELF.Liens37_Amount := IF(~suppress_condition, ri.LnJliens[37].Amount , '');
    SELF.Liens37_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[37].ReleaseDate, '');
    SELF.Liens37_DateLastSeen := IF(~suppress_condition, ri.LnJliens[37].DateLastSeen , '');
    SELF.Liens37_FilingNumber := IF(~suppress_condition, ri.LnJliens[37].FilingNumber , '');
    SELF.Liens37_FilingBook := IF(~suppress_condition, ri.LnJliens[37].FilingBook , '');
    SELF.Liens37_FilingPage := IF(~suppress_condition, ri.LnJliens[37].FilingPage , '');
    SELF.Liens37_Agency := IF(~suppress_condition, ri.LnJliens[37].Agency , '');
    SELF.Liens37_AgencyCounty := IF(~suppress_condition, ri.LnJliens[37].AgencyCounty , '');
    SELF.Liens37_AgencyState:= IF(~suppress_condition, ri.LnJliens[37].AgencyState, '');
    SELF.Liens37_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[37].ConsumerStatementId), '');
    SELF.Liens37_orig_rmsid := IF(~suppress_condition, ri.LnJliens[37].orig_rmsid, '');
    SELF.Liens38_Seq:= IF(~suppress_condition, ri.LnJliens[38].Seq, '');
    SELF.Liens38_DateFiled:= IF(~suppress_condition, ri.LnJliens[38].DateFiled, '');
    SELF.Liens38_LienTypeID := IF(~suppress_condition, ri.LnJliens[38].LienTypeID, '');
    SELF.Liens38_LienType := IF(~suppress_condition, ri.LnJliens[38].LienType , '');
    SELF.Liens38_Amount := IF(~suppress_condition, ri.LnJliens[38].Amount , '');
    SELF.Liens38_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[38].ReleaseDate, '');
    SELF.Liens38_DateLastSeen := IF(~suppress_condition, ri.LnJliens[38].DateLastSeen , '');
    SELF.Liens38_FilingNumber := IF(~suppress_condition, ri.LnJliens[38].FilingNumber , '');
    SELF.Liens38_FilingBook := IF(~suppress_condition, ri.LnJliens[38].FilingBook , '');
    SELF.Liens38_FilingPage := IF(~suppress_condition, ri.LnJliens[38].FilingPage , '');
    SELF.Liens38_Agency := IF(~suppress_condition, ri.LnJliens[38].Agency , '');
    SELF.Liens38_AgencyCounty := IF(~suppress_condition, ri.LnJliens[38].AgencyCounty , '');
    SELF.Liens38_AgencyState:= IF(~suppress_condition, ri.LnJliens[38].AgencyState, '');
    SELF.Liens38_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[38].ConsumerStatementId), '');
    SELF.Liens38_orig_rmsid := IF(~suppress_condition, ri.LnJliens[38].orig_rmsid, '');
    SELF.Liens39_Seq:= IF(~suppress_condition, ri.LnJliens[39].Seq, '');
    SELF.Liens39_DateFiled:= IF(~suppress_condition, ri.LnJliens[39].DateFiled, '');
    SELF.Liens39_LienTypeID := IF(~suppress_condition, ri.LnJliens[39].LienTypeID, '');
    SELF.Liens39_LienType := IF(~suppress_condition, ri.LnJliens[39].LienType , '');
    SELF.Liens39_Amount := IF(~suppress_condition, ri.LnJliens[39].Amount , '');
    SELF.Liens39_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[39].ReleaseDate, '');
    SELF.Liens39_DateLastSeen := IF(~suppress_condition, ri.LnJliens[39].DateLastSeen , '');
    SELF.Liens39_FilingNumber := IF(~suppress_condition, ri.LnJliens[39].FilingNumber , '');
    SELF.Liens39_FilingBook := IF(~suppress_condition, ri.LnJliens[39].FilingBook , '');
    SELF.Liens39_FilingPage := IF(~suppress_condition, ri.LnJliens[39].FilingPage , '');
    SELF.Liens39_Agency := IF(~suppress_condition, ri.LnJliens[39].Agency , '');
    SELF.Liens39_AgencyCounty := IF(~suppress_condition, ri.LnJliens[39].AgencyCounty , '');
    SELF.Liens39_AgencyState:= IF(~suppress_condition, ri.LnJliens[39].AgencyState, '');
    SELF.Liens39_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[39].ConsumerStatementId), '');
    SELF.Liens39_orig_rmsid := IF(~suppress_condition, ri.LnJliens[39].orig_rmsid, '');
    SELF.Liens40_Seq:= IF(~suppress_condition, ri.LnJliens[40].Seq , '');
    SELF.Liens40_DateFiled:= IF(~suppress_condition, ri.LnJliens[40].DateFiled , '');
    SELF.Liens40_LienTypeID := IF(~suppress_condition, ri.LnJliens[40].LienTypeID, '');
    SELF.Liens40_LienType := IF(~suppress_condition, ri.LnJliens[40].LienType, '');
    SELF.Liens40_Amount := IF(~suppress_condition, ri.LnJliens[40].Amount, '');
    SELF.Liens40_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[40].ReleaseDate , '');
    SELF.Liens40_DateLastSeen := IF(~suppress_condition, ri.LnJliens[40].DateLastSeen, '');
    SELF.Liens40_FilingNumber := IF(~suppress_condition, ri.LnJliens[40].FilingNumber, '');
    SELF.Liens40_FilingBook := IF(~suppress_condition, ri.LnJliens[40].FilingBook, '');
    SELF.Liens40_FilingPage := IF(~suppress_condition, ri.LnJliens[40].FilingPage, '');
    SELF.Liens40_Agency := IF(~suppress_condition, ri.LnJliens[40].Agency, '');
    SELF.Liens40_AgencyCounty := IF(~suppress_condition, ri.LnJliens[40].AgencyCounty, '');
    SELF.Liens40_AgencyState:= IF(~suppress_condition, ri.LnJliens[40].AgencyState , '');
    SELF.Liens40_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[40].ConsumerStatementId), '');
    SELF.Liens40_orig_rmsid := IF(~suppress_condition, ri.LnJliens[40].orig_rmsid, '');
    SELF.Liens41_Seq:= IF(~suppress_condition, ri.LnJliens[41].Seq , '');
    SELF.Liens41_DateFiled:= IF(~suppress_condition, ri.LnJliens[41].DateFiled , '');
    SELF.Liens41_LienTypeID := IF(~suppress_condition, ri.LnJliens[41].LienTypeID, '');
    SELF.Liens41_LienType := IF(~suppress_condition, ri.LnJliens[41].LienType, '');
    SELF.Liens41_Amount := IF(~suppress_condition, ri.LnJliens[41].Amount, '');
    SELF.Liens41_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[41].ReleaseDate , '');
    SELF.Liens41_DateLastSeen := IF(~suppress_condition, ri.LnJliens[41].DateLastSeen, '');
    SELF.Liens41_FilingNumber := IF(~suppress_condition, ri.LnJliens[41].FilingNumber, '');
    SELF.Liens41_FilingBook := IF(~suppress_condition, ri.LnJliens[41].FilingBook, '');
    SELF.Liens41_FilingPage := IF(~suppress_condition, ri.LnJliens[41].FilingPage, '');
    SELF.Liens41_Agency := IF(~suppress_condition, ri.LnJliens[41].Agency, '');
    SELF.Liens41_AgencyCounty := IF(~suppress_condition, ri.LnJliens[41].AgencyCounty, '');
    SELF.Liens41_AgencyState:= IF(~suppress_condition, ri.LnJliens[41].AgencyState , '');
    SELF.Liens41_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[41].ConsumerStatementId), '');
    SELF.Liens41_orig_rmsid := IF(~suppress_condition, ri.LnJliens[41].orig_rmsid, '');
    SELF.Liens42_Seq:= IF(~suppress_condition, ri.LnJliens[42].Seq , '');
    SELF.Liens42_DateFiled:= IF(~suppress_condition, ri.LnJliens[42].DateFiled , '');
    SELF.Liens42_LienTypeID := IF(~suppress_condition, ri.LnJliens[42].LienTypeID, '');
    SELF.Liens42_LienType := IF(~suppress_condition, ri.LnJliens[42].LienType, '');
    SELF.Liens42_Amount := IF(~suppress_condition, ri.LnJliens[42].Amount, '');
    SELF.Liens42_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[42].ReleaseDate , '');
    SELF.Liens42_DateLastSeen := IF(~suppress_condition, ri.LnJliens[42].DateLastSeen, '');
    SELF.Liens42_FilingNumber := IF(~suppress_condition, ri.LnJliens[42].FilingNumber, '');
    SELF.Liens42_FilingBook := IF(~suppress_condition, ri.LnJliens[42].FilingBook, '');
    SELF.Liens42_FilingPage := IF(~suppress_condition, ri.LnJliens[42].FilingPage, '');
    SELF.Liens42_Agency := IF(~suppress_condition, ri.LnJliens[42].Agency, '');
    SELF.Liens42_AgencyCounty := IF(~suppress_condition, ri.LnJliens[42].AgencyCounty, '');
    SELF.Liens42_AgencyState:= IF(~suppress_condition, ri.LnJliens[42].AgencyState , '');
    SELF.Liens42_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[42].ConsumerStatementId), '');
    SELF.Liens42_orig_rmsid := IF(~suppress_condition, ri.LnJliens[42].orig_rmsid, '');
    SELF.Liens43_Seq:= IF(~suppress_condition, ri.LnJliens[43].Seq , '');
    SELF.Liens43_DateFiled:= IF(~suppress_condition, ri.LnJliens[43].DateFiled , '');
    SELF.Liens43_LienTypeID := IF(~suppress_condition, ri.LnJliens[43].LienTypeID, '');
    SELF.Liens43_LienType := IF(~suppress_condition, ri.LnJliens[43].LienType, '');
    SELF.Liens43_Amount := IF(~suppress_condition, ri.LnJliens[43].Amount, '');
    SELF.Liens43_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[43].ReleaseDate , '');
    SELF.Liens43_DateLastSeen := IF(~suppress_condition, ri.LnJliens[43].DateLastSeen, '');
    SELF.Liens43_FilingNumber := IF(~suppress_condition, ri.LnJliens[43].FilingNumber, '');
    SELF.Liens43_FilingBook := IF(~suppress_condition, ri.LnJliens[43].FilingBook, '');
    SELF.Liens43_FilingPage := IF(~suppress_condition, ri.LnJliens[43].FilingPage, '');
    SELF.Liens43_Agency := IF(~suppress_condition, ri.LnJliens[43].Agency, '');
    SELF.Liens43_AgencyCounty := IF(~suppress_condition, ri.LnJliens[43].AgencyCounty, '');
    SELF.Liens43_AgencyState:= IF(~suppress_condition, ri.LnJliens[43].AgencyState , '');
    SELF.Liens43_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[43].ConsumerStatementId), '');
    SELF.Liens43_orig_rmsid := IF(~suppress_condition, ri.LnJliens[43].orig_rmsid, '');
    SELF.Liens44_Seq:= IF(~suppress_condition, ri.LnJliens[44].Seq , '');
    SELF.Liens44_DateFiled:= IF(~suppress_condition, ri.LnJliens[44].DateFiled , '');
    SELF.Liens44_LienTypeID := IF(~suppress_condition, ri.LnJliens[44].LienTypeID, '');
    SELF.Liens44_LienType := IF(~suppress_condition, ri.LnJliens[44].LienType, '');
    SELF.Liens44_Amount := IF(~suppress_condition, ri.LnJliens[44].Amount, '');
    SELF.Liens44_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[44].ReleaseDate , '');
    SELF.Liens44_DateLastSeen := IF(~suppress_condition, ri.LnJliens[44].DateLastSeen, '');
    SELF.Liens44_FilingNumber := IF(~suppress_condition, ri.LnJliens[44].FilingNumber, '');
    SELF.Liens44_FilingBook := IF(~suppress_condition, ri.LnJliens[44].FilingBook, '');
    SELF.Liens44_FilingPage := IF(~suppress_condition, ri.LnJliens[44].FilingPage, '');
    SELF.Liens44_Agency := IF(~suppress_condition, ri.LnJliens[44].Agency, '');
    SELF.Liens44_AgencyCounty := IF(~suppress_condition, ri.LnJliens[44].AgencyCounty, '');
    SELF.Liens44_AgencyState:= IF(~suppress_condition, ri.LnJliens[44].AgencyState , '');
    SELF.Liens44_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[44].ConsumerStatementId), '');
    SELF.Liens44_orig_rmsid := IF(~suppress_condition, ri.LnJliens[44].orig_rmsid, '');
    SELF.Liens45_Seq:= IF(~suppress_condition, ri.LnJliens[45].Seq , '');
    SELF.Liens45_DateFiled:= IF(~suppress_condition, ri.LnJliens[45].DateFiled , '');
    SELF.Liens45_LienTypeID := IF(~suppress_condition, ri.LnJliens[45].LienTypeID, '');
    SELF.Liens45_LienType := IF(~suppress_condition, ri.LnJliens[45].LienType, '');
    SELF.Liens45_Amount := IF(~suppress_condition, ri.LnJliens[45].Amount, '');
    SELF.Liens45_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[45].ReleaseDate , '');
    SELF.Liens45_DateLastSeen := IF(~suppress_condition, ri.LnJliens[45].DateLastSeen, '');
    SELF.Liens45_FilingNumber := IF(~suppress_condition, ri.LnJliens[45].FilingNumber, '');
    SELF.Liens45_FilingBook := IF(~suppress_condition, ri.LnJliens[45].FilingBook, '');
    SELF.Liens45_FilingPage := IF(~suppress_condition, ri.LnJliens[45].FilingPage, '');
    SELF.Liens45_Agency := IF(~suppress_condition, ri.LnJliens[45].Agency, '');
    SELF.Liens45_AgencyCounty := IF(~suppress_condition, ri.LnJliens[45].AgencyCounty, '');
    SELF.Liens45_AgencyState:= IF(~suppress_condition, ri.LnJliens[45].AgencyState , '');
    SELF.Liens45_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[45].ConsumerStatementId), '');
    SELF.Liens45_orig_rmsid := IF(~suppress_condition, ri.LnJliens[45].orig_rmsid, '');
    SELF.Liens46_Seq:= IF(~suppress_condition, ri.LnJliens[46].Seq , '');
    SELF.Liens46_DateFiled:= IF(~suppress_condition, ri.LnJliens[46].DateFiled , '');
    SELF.Liens46_LienTypeID := IF(~suppress_condition, ri.LnJliens[46].LienTypeID, '');
    SELF.Liens46_LienType := IF(~suppress_condition, ri.LnJliens[46].LienType, '');
    SELF.Liens46_Amount := IF(~suppress_condition, ri.LnJliens[46].Amount, '');
    SELF.Liens46_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[46].ReleaseDate , '');
    SELF.Liens46_DateLastSeen := IF(~suppress_condition, ri.LnJliens[46].DateLastSeen, '');
    SELF.Liens46_FilingNumber := IF(~suppress_condition, ri.LnJliens[46].FilingNumber, '');
    SELF.Liens46_FilingBook := IF(~suppress_condition, ri.LnJliens[46].FilingBook, '');
    SELF.Liens46_FilingPage := IF(~suppress_condition, ri.LnJliens[46].FilingPage, '');
    SELF.Liens46_Agency := IF(~suppress_condition, ri.LnJliens[46].Agency, '');
    SELF.Liens46_AgencyCounty := IF(~suppress_condition, ri.LnJliens[46].AgencyCounty, '');
    SELF.Liens46_AgencyState:= IF(~suppress_condition, ri.LnJliens[46].AgencyState , '');
    SELF.Liens46_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[46].ConsumerStatementId), '');
    SELF.Liens46_orig_rmsid := IF(~suppress_condition, ri.LnJliens[46].orig_rmsid, '');
    SELF.Liens47_Seq:= IF(~suppress_condition, ri.LnJliens[47].Seq , '');
    SELF.Liens47_DateFiled:= IF(~suppress_condition, ri.LnJliens[47].DateFiled , '');
    SELF.Liens47_LienTypeID := IF(~suppress_condition, ri.LnJliens[47].LienTypeID, '');
    SELF.Liens47_LienType := IF(~suppress_condition, ri.LnJliens[47].LienType, '');
    SELF.Liens47_Amount := IF(~suppress_condition, ri.LnJliens[47].Amount, '');
    SELF.Liens47_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[47].ReleaseDate , '');
    SELF.Liens47_DateLastSeen := IF(~suppress_condition, ri.LnJliens[47].DateLastSeen, '');
    SELF.Liens47_FilingNumber := IF(~suppress_condition, ri.LnJliens[47].FilingNumber, '');
    SELF.Liens47_FilingBook := IF(~suppress_condition, ri.LnJliens[47].FilingBook, '');
    SELF.Liens47_FilingPage := IF(~suppress_condition, ri.LnJliens[47].FilingPage, '');
    SELF.Liens47_Agency := IF(~suppress_condition, ri.LnJliens[47].Agency, '');
    SELF.Liens47_AgencyCounty := IF(~suppress_condition, ri.LnJliens[47].AgencyCounty, '');
    SELF.Liens47_AgencyState:= IF(~suppress_condition, ri.LnJliens[47].AgencyState , '');
    SELF.Liens47_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[47].ConsumerStatementId), '');
    SELF.Liens47_orig_rmsid := IF(~suppress_condition, ri.LnJliens[47].orig_rmsid, '');
    SELF.Liens48_Seq:= IF(~suppress_condition, ri.LnJliens[48].Seq , '');
    SELF.Liens48_DateFiled:= IF(~suppress_condition, ri.LnJliens[48].DateFiled , '');
    SELF.Liens48_LienTypeID := IF(~suppress_condition, ri.LnJliens[48].LienTypeID, '');
    SELF.Liens48_LienType := IF(~suppress_condition, ri.LnJliens[48].LienType, '');
    SELF.Liens48_Amount := IF(~suppress_condition, ri.LnJliens[48].Amount, '');
    SELF.Liens48_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[48].ReleaseDate , '');
    SELF.Liens48_DateLastSeen := IF(~suppress_condition, ri.LnJliens[48].DateLastSeen, '');
    SELF.Liens48_FilingNumber := IF(~suppress_condition, ri.LnJliens[48].FilingNumber, '');
    SELF.Liens48_FilingBook := IF(~suppress_condition, ri.LnJliens[48].FilingBook, '');
    SELF.Liens48_FilingPage := IF(~suppress_condition, ri.LnJliens[48].FilingPage, '');
    SELF.Liens48_Agency := IF(~suppress_condition, ri.LnJliens[48].Agency, '');
    SELF.Liens48_AgencyCounty := IF(~suppress_condition, ri.LnJliens[48].AgencyCounty, '');
    SELF.Liens48_AgencyState:= IF(~suppress_condition, ri.LnJliens[48].AgencyState , '');
    SELF.Liens48_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[48].ConsumerStatementId), '');
    SELF.Liens48_orig_rmsid := IF(~suppress_condition, ri.LnJliens[48].orig_rmsid, '');
    SELF.Liens49_Seq:= IF(~suppress_condition, ri.LnJliens[49].Seq , '');
    SELF.Liens49_DateFiled:= IF(~suppress_condition, ri.LnJliens[49].DateFiled , '');
    SELF.Liens49_LienTypeID := IF(~suppress_condition, ri.LnJliens[49].LienTypeID, '');
    SELF.Liens49_LienType := IF(~suppress_condition, ri.LnJliens[49].LienType, '');
    SELF.Liens49_Amount := IF(~suppress_condition, ri.LnJliens[49].Amount, '');
    SELF.Liens49_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[49].ReleaseDate , '');
    SELF.Liens49_DateLastSeen := IF(~suppress_condition, ri.LnJliens[49].DateLastSeen, '');
    SELF.Liens49_FilingNumber := IF(~suppress_condition, ri.LnJliens[49].FilingNumber, '');
    SELF.Liens49_FilingBook := IF(~suppress_condition, ri.LnJliens[49].FilingBook, '');
    SELF.Liens49_FilingPage := IF(~suppress_condition, ri.LnJliens[49].FilingPage, '');
    SELF.Liens49_Agency := IF(~suppress_condition, ri.LnJliens[49].Agency, '');
    SELF.Liens49_AgencyCounty := IF(~suppress_condition, ri.LnJliens[49].AgencyCounty, '');
    SELF.Liens49_AgencyState:= IF(~suppress_condition, ri.LnJliens[49].AgencyState , '');
    SELF.Liens49_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[49].ConsumerStatementId), '');
    SELF.Liens49_orig_rmsid := IF(~suppress_condition, ri.LnJliens[49].orig_rmsid, '');
    SELF.Liens50_Seq:= IF(~suppress_condition, ri.LnJliens[50].Seq , '');
    SELF.Liens50_DateFiled:= IF(~suppress_condition, ri.LnJliens[50].DateFiled , '');
    SELF.Liens50_LienTypeID := IF(~suppress_condition, ri.LnJliens[50].LienTypeID, '');
    SELF.Liens50_LienType := IF(~suppress_condition, ri.LnJliens[50].LienType, '');
    SELF.Liens50_Amount := IF(~suppress_condition, ri.LnJliens[50].Amount, '');
    SELF.Liens50_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[50].ReleaseDate , '');
    SELF.Liens50_DateLastSeen := IF(~suppress_condition, ri.LnJliens[50].DateLastSeen, '');
    SELF.Liens50_FilingNumber := IF(~suppress_condition, ri.LnJliens[50].FilingNumber, '');
    SELF.Liens50_FilingBook := IF(~suppress_condition, ri.LnJliens[50].FilingBook, '');
    SELF.Liens50_FilingPage := IF(~suppress_condition, ri.LnJliens[50].FilingPage, '');
    SELF.Liens50_Agency := IF(~suppress_condition, ri.LnJliens[50].Agency, '');
    SELF.Liens50_AgencyCounty := IF(~suppress_condition, ri.LnJliens[50].AgencyCounty, '');
    SELF.Liens50_AgencyState:= IF(~suppress_condition, ri.LnJliens[50].AgencyState , '');
    SELF.Liens50_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[50].ConsumerStatementId), '');
    SELF.Liens50_orig_rmsid := IF(~suppress_condition, ri.LnJliens[50].orig_rmsid, '');
    SELF.Liens51_Seq:= IF(~suppress_condition, ri.LnJliens[51].Seq, '');
    SELF.Liens51_DateFiled:= IF(~suppress_condition, ri.LnJliens[51].DateFiled, '');
    SELF.Liens51_LienTypeID := IF(~suppress_condition, ri.LnJliens[51].LienTypeID, '');
    SELF.Liens51_LienType := IF(~suppress_condition, ri.LnJliens[51].LienType, '');
    SELF.Liens51_Amount := IF(~suppress_condition, ri.LnJliens[51].Amount, '');
    SELF.Liens51_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[51].ReleaseDate, '');
    SELF.Liens51_DateLastSeen := IF(~suppress_condition, ri.LnJliens[51].DateLastSeen, '');
    SELF.Liens51_FilingNumber := IF(~suppress_condition, ri.LnJliens[51].FilingNumber, '');
    SELF.Liens51_FilingBook := IF(~suppress_condition, ri.LnJliens[51].FilingBook, '');
    SELF.Liens51_FilingPage := IF(~suppress_condition, ri.LnJliens[51].FilingPage, '');
    SELF.Liens51_Agency := IF(~suppress_condition, ri.LnJliens[51].Agency , '');
    SELF.Liens51_AgencyCounty := IF(~suppress_condition, ri.LnJliens[51].AgencyCounty, '');
    SELF.Liens51_AgencyState:= IF(~suppress_condition, ri.LnJliens[51].AgencyState, '');
    SELF.Liens51_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[51].ConsumerStatementId), '');
    SELF.Liens51_orig_rmsid := IF(~suppress_condition, ri.LnJliens[51].orig_rmsid, '');
    SELF.Liens52_Seq:= IF(~suppress_condition, ri.LnJliens[52].Seq, '');
    SELF.Liens52_DateFiled:= IF(~suppress_condition, ri.LnJliens[52].DateFiled, '');
    SELF.Liens52_LienTypeID := IF(~suppress_condition, ri.LnJliens[52].LienTypeID, '');
    SELF.Liens52_LienType := IF(~suppress_condition, ri.LnJliens[52].LienType, '');
    SELF.Liens52_Amount := IF(~suppress_condition, ri.LnJliens[52].Amount, '');
    SELF.Liens52_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[52].ReleaseDate, '');
    SELF.Liens52_DateLastSeen := IF(~suppress_condition, ri.LnJliens[52].DateLastSeen, '');
    SELF.Liens52_FilingNumber := IF(~suppress_condition, ri.LnJliens[52].FilingNumber, '');
    SELF.Liens52_FilingBook := IF(~suppress_condition, ri.LnJliens[52].FilingBook, '');
    SELF.Liens52_FilingPage := IF(~suppress_condition, ri.LnJliens[52].FilingPage, '');
    SELF.Liens52_Agency := IF(~suppress_condition, ri.LnJliens[52].Agency, ''); 
    SELF.Liens52_AgencyCounty := IF(~suppress_condition, ri.LnJliens[52].AgencyCounty, '');
    SELF.Liens52_AgencyState:= IF(~suppress_condition, ri.LnJliens[52].AgencyState, '');
    SELF.Liens52_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[52].ConsumerStatementId), '');
    SELF.Liens52_orig_rmsid := IF(~suppress_condition, ri.LnJliens[52].orig_rmsid, '');
    SELF.Liens53_Seq:= IF(~suppress_condition, ri.LnJliens[53].Seq, '');
    SELF.Liens53_DateFiled:= IF(~suppress_condition, ri.LnJliens[53].DateFiled, '');
    SELF.Liens53_LienTypeID := IF(~suppress_condition, ri.LnJliens[53].LienTypeID, '');
    SELF.Liens53_LienType := IF(~suppress_condition, ri.LnJliens[53].LienType, '');
    SELF.Liens53_Amount := IF(~suppress_condition, ri.LnJliens[53].Amount, '');
    SELF.Liens53_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[53].ReleaseDate, '');
    SELF.Liens53_DateLastSeen := IF(~suppress_condition, ri.LnJliens[53].DateLastSeen, '');
    SELF.Liens53_FilingNumber := IF(~suppress_condition, ri.LnJliens[53].FilingNumber, '');
    SELF.Liens53_FilingBook := IF(~suppress_condition, ri.LnJliens[53].FilingBook, '');
    SELF.Liens53_FilingPage := IF(~suppress_condition, ri.LnJliens[53].FilingPage, '');
    SELF.Liens53_Agency := IF(~suppress_condition, ri.LnJliens[53].Agency, ''); 
    SELF.Liens53_AgencyCounty := IF(~suppress_condition, ri.LnJliens[53].AgencyCounty, '');
    SELF.Liens53_AgencyState:= IF(~suppress_condition, ri.LnJliens[53].AgencyState, '');
    SELF.Liens53_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[53].ConsumerStatementId), '');
    SELF.Liens53_orig_rmsid := IF(~suppress_condition, ri.LnJliens[53].orig_rmsid, '');
    SELF.Liens54_Seq:= IF(~suppress_condition, ri.LnJliens[54].Seq, '');
    SELF.Liens54_DateFiled:= IF(~suppress_condition, ri.LnJliens[54].DateFiled, '');
    SELF.Liens54_LienTypeID := IF(~suppress_condition, ri.LnJliens[54].LienTypeID, '');
    SELF.Liens54_LienType := IF(~suppress_condition, ri.LnJliens[54].LienType, '');
    SELF.Liens54_Amount := IF(~suppress_condition, ri.LnJliens[54].Amount, '');
    SELF.Liens54_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[54].ReleaseDate, '');
    SELF.Liens54_DateLastSeen := IF(~suppress_condition, ri.LnJliens[54].DateLastSeen, '');
    SELF.Liens54_FilingNumber := IF(~suppress_condition, ri.LnJliens[54].FilingNumber, '');
    SELF.Liens54_FilingBook := IF(~suppress_condition, ri.LnJliens[54].FilingBook, '');
    SELF.Liens54_FilingPage := IF(~suppress_condition, ri.LnJliens[54].FilingPage, '');
    SELF.Liens54_Agency := IF(~suppress_condition, ri.LnJliens[54].Agency, ''); 
    SELF.Liens54_AgencyCounty := IF(~suppress_condition, ri.LnJliens[54].AgencyCounty, '');
    SELF.Liens54_AgencyState:= IF(~suppress_condition, ri.LnJliens[54].AgencyState, '');
    SELF.Liens54_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[54].ConsumerStatementId), '');
    SELF.Liens54_orig_rmsid := IF(~suppress_condition, ri.LnJliens[54].orig_rmsid, '');
    SELF.Liens55_Seq:= IF(~suppress_condition, ri.LnJliens[55].Seq, '');
    SELF.Liens55_DateFiled:= IF(~suppress_condition, ri.LnJliens[55].DateFiled, '');
    SELF.Liens55_LienTypeID := IF(~suppress_condition, ri.LnJliens[55].LienTypeID, '');
    SELF.Liens55_LienType := IF(~suppress_condition, ri.LnJliens[55].LienType , '');
    SELF.Liens55_Amount := IF(~suppress_condition, ri.LnJliens[55].Amount , '');
    SELF.Liens55_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[55].ReleaseDate, '');
    SELF.Liens55_DateLastSeen := IF(~suppress_condition, ri.LnJliens[55].DateLastSeen , '');
    SELF.Liens55_FilingNumber := IF(~suppress_condition, ri.LnJliens[55].FilingNumber , '');
    SELF.Liens55_FilingBook := IF(~suppress_condition, ri.LnJliens[55].FilingBook , '');
    SELF.Liens55_FilingPage := IF(~suppress_condition, ri.LnJliens[55].FilingPage , '');
    SELF.Liens55_Agency := IF(~suppress_condition, ri.LnJliens[55].Agency , '');
    SELF.Liens55_AgencyCounty := IF(~suppress_condition, ri.LnJliens[55].AgencyCounty , '');
    SELF.Liens55_AgencyState:= IF(~suppress_condition, ri.LnJliens[55].AgencyState, '');
    SELF.Liens55_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[55].ConsumerStatementId), '');
    SELF.Liens55_orig_rmsid := IF(~suppress_condition, ri.LnJliens[55].orig_rmsid, '');
    SELF.Liens56_Seq:= IF(~suppress_condition, ri.LnJliens[56].Seq, '');
    SELF.Liens56_DateFiled:= IF(~suppress_condition, ri.LnJliens[56].DateFiled, '');
    SELF.Liens56_LienTypeID := IF(~suppress_condition, ri.LnJliens[56].LienTypeID, '');
    SELF.Liens56_LienType := IF(~suppress_condition, ri.LnJliens[56].LienType , '');
    SELF.Liens56_Amount := IF(~suppress_condition, ri.LnJliens[56].Amount , '');
    SELF.Liens56_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[56].ReleaseDate, '');
    SELF.Liens56_DateLastSeen := IF(~suppress_condition, ri.LnJliens[56].DateLastSeen , '');
    SELF.Liens56_FilingNumber := IF(~suppress_condition, ri.LnJliens[56].FilingNumber , '');
    SELF.Liens56_FilingBook := IF(~suppress_condition, ri.LnJliens[56].FilingBook , '');
    SELF.Liens56_FilingPage := IF(~suppress_condition, ri.LnJliens[56].FilingPage , '');
    SELF.Liens56_Agency := IF(~suppress_condition, ri.LnJliens[56].Agency , '');
    SELF.Liens56_AgencyCounty := IF(~suppress_condition, ri.LnJliens[56].AgencyCounty , '');
    SELF.Liens56_AgencyState:= IF(~suppress_condition, ri.LnJliens[56].AgencyState, '');
    SELF.Liens56_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[56].ConsumerStatementId), '');
    SELF.Liens56_orig_rmsid := IF(~suppress_condition, ri.LnJliens[56].orig_rmsid, '');
    SELF.Liens57_Seq:= IF(~suppress_condition, ri.LnJliens[57].Seq, '');
    SELF.Liens57_DateFiled:= IF(~suppress_condition, ri.LnJliens[57].DateFiled, '');
    SELF.Liens57_LienTypeID := IF(~suppress_condition, ri.LnJliens[57].LienTypeID, '');
    SELF.Liens57_LienType := IF(~suppress_condition, ri.LnJliens[57].LienType , '');
    SELF.Liens57_Amount := IF(~suppress_condition, ri.LnJliens[57].Amount , '');
    SELF.Liens57_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[57].ReleaseDate, '');
    SELF.Liens57_DateLastSeen := IF(~suppress_condition, ri.LnJliens[57].DateLastSeen , '');
    SELF.Liens57_FilingNumber := IF(~suppress_condition, ri.LnJliens[57].FilingNumber , '');
    SELF.Liens57_FilingBook := IF(~suppress_condition, ri.LnJliens[57].FilingBook , '');
    SELF.Liens57_FilingPage := IF(~suppress_condition, ri.LnJliens[57].FilingPage , '');
    SELF.Liens57_Agency := IF(~suppress_condition, ri.LnJliens[57].Agency , '');
    SELF.Liens57_AgencyCounty := IF(~suppress_condition, ri.LnJliens[57].AgencyCounty , '');
    SELF.Liens57_AgencyState:= IF(~suppress_condition, ri.LnJliens[57].AgencyState, '');
    SELF.Liens57_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[57].ConsumerStatementId), '');
    SELF.Liens57_orig_rmsid := IF(~suppress_condition, ri.LnJliens[57].orig_rmsid, '');
    SELF.Liens58_Seq:= IF(~suppress_condition, ri.LnJliens[58].Seq, '');
    SELF.Liens58_DateFiled:= IF(~suppress_condition, ri.LnJliens[58].DateFiled, '');
    SELF.Liens58_LienTypeID := IF(~suppress_condition, ri.LnJliens[58].LienTypeID, '');
    SELF.Liens58_LienType := IF(~suppress_condition, ri.LnJliens[58].LienType , '');
    SELF.Liens58_Amount := IF(~suppress_condition, ri.LnJliens[58].Amount , '');
    SELF.Liens58_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[58].ReleaseDate, '');
    SELF.Liens58_DateLastSeen := IF(~suppress_condition, ri.LnJliens[58].DateLastSeen , '');
    SELF.Liens58_FilingNumber := IF(~suppress_condition, ri.LnJliens[58].FilingNumber , '');
    SELF.Liens58_FilingBook := IF(~suppress_condition, ri.LnJliens[58].FilingBook , '');
    SELF.Liens58_FilingPage := IF(~suppress_condition, ri.LnJliens[58].FilingPage , '');
    SELF.Liens58_Agency := IF(~suppress_condition, ri.LnJliens[58].Agency , '');
    SELF.Liens58_AgencyCounty := IF(~suppress_condition, ri.LnJliens[58].AgencyCounty , '');
    SELF.Liens58_AgencyState:= IF(~suppress_condition, ri.LnJliens[58].AgencyState, '');
    SELF.Liens58_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[58].ConsumerStatementId), '');
    SELF.Liens58_orig_rmsid := IF(~suppress_condition, ri.LnJliens[58].orig_rmsid, '');
    SELF.Liens59_Seq:= IF(~suppress_condition, ri.LnJliens[59].Seq, '');
    SELF.Liens59_DateFiled:= IF(~suppress_condition, ri.LnJliens[59].DateFiled, '');
    SELF.Liens59_LienTypeID := IF(~suppress_condition, ri.LnJliens[59].LienTypeID, '');
    SELF.Liens59_LienType := IF(~suppress_condition, ri.LnJliens[59].LienType , '');
    SELF.Liens59_Amount := IF(~suppress_condition, ri.LnJliens[59].Amount , '');
    SELF.Liens59_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[59].ReleaseDate, '');
    SELF.Liens59_DateLastSeen := IF(~suppress_condition, ri.LnJliens[59].DateLastSeen , '');
    SELF.Liens59_FilingNumber := IF(~suppress_condition, ri.LnJliens[59].FilingNumber , '');
    SELF.Liens59_FilingBook := IF(~suppress_condition, ri.LnJliens[59].FilingBook , '');
    SELF.Liens59_FilingPage := IF(~suppress_condition, ri.LnJliens[59].FilingPage , '');
    SELF.Liens59_Agency := IF(~suppress_condition, ri.LnJliens[59].Agency , '');
    SELF.Liens59_AgencyCounty := IF(~suppress_condition, ri.LnJliens[59].AgencyCounty , '');
    SELF.Liens59_AgencyState:= IF(~suppress_condition, ri.LnJliens[59].AgencyState, '');
    SELF.Liens59_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[59].ConsumerStatementId), '');
    SELF.Liens59_orig_rmsid := IF(~suppress_condition, ri.LnJliens[59].orig_rmsid, '');
    SELF.Liens60_Seq:= IF(~suppress_condition, ri.LnJliens[60].Seq , '');
    SELF.Liens60_DateFiled:= IF(~suppress_condition, ri.LnJliens[60].DateFiled , '');
    SELF.Liens60_LienTypeID := IF(~suppress_condition, ri.LnJliens[60].LienTypeID, '');
    SELF.Liens60_LienType := IF(~suppress_condition, ri.LnJliens[60].LienType, '');
    SELF.Liens60_Amount := IF(~suppress_condition, ri.LnJliens[60].Amount, '');
    SELF.Liens60_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[60].ReleaseDate , '');
    SELF.Liens60_DateLastSeen := IF(~suppress_condition, ri.LnJliens[60].DateLastSeen, '');
    SELF.Liens60_FilingNumber := IF(~suppress_condition, ri.LnJliens[60].FilingNumber, '');
    SELF.Liens60_FilingBook := IF(~suppress_condition, ri.LnJliens[60].FilingBook, '');
    SELF.Liens60_FilingPage := IF(~suppress_condition, ri.LnJliens[60].FilingPage, '');
    SELF.Liens60_Agency := IF(~suppress_condition, ri.LnJliens[60].Agency, '');
    SELF.Liens60_AgencyCounty := IF(~suppress_condition, ri.LnJliens[60].AgencyCounty, '');
    SELF.Liens60_AgencyState:= IF(~suppress_condition, ri.LnJliens[60].AgencyState , '');
    SELF.Liens60_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[60].ConsumerStatementId), '');
    SELF.Liens60_orig_rmsid := IF(~suppress_condition, ri.LnJliens[60].orig_rmsid, '');
    SELF.Liens61_Seq:= IF(~suppress_condition, ri.LnJliens[61].Seq, '');
    SELF.Liens61_DateFiled:= IF(~suppress_condition, ri.LnJliens[61].DateFiled, '');
    SELF.Liens61_LienTypeID := IF(~suppress_condition, ri.LnJliens[61].LienTypeID, '');
    SELF.Liens61_LienType := IF(~suppress_condition, ri.LnJliens[61].LienType, '');
    SELF.Liens61_Amount := IF(~suppress_condition, ri.LnJliens[61].Amount, '');
    SELF.Liens61_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[61].ReleaseDate, '');
    SELF.Liens61_DateLastSeen := IF(~suppress_condition, ri.LnJliens[61].DateLastSeen, '');
    SELF.Liens61_FilingNumber := IF(~suppress_condition, ri.LnJliens[61].FilingNumber, '');
    SELF.Liens61_FilingBook := IF(~suppress_condition, ri.LnJliens[61].FilingBook, '');
    SELF.Liens61_FilingPage := IF(~suppress_condition, ri.LnJliens[61].FilingPage, '');
    SELF.Liens61_Agency := IF(~suppress_condition, ri.LnJliens[61].Agency , '');
    SELF.Liens61_AgencyCounty := IF(~suppress_condition, ri.LnJliens[61].AgencyCounty, '');
    SELF.Liens61_AgencyState:= IF(~suppress_condition, ri.LnJliens[61].AgencyState, '');
    SELF.Liens61_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[61].ConsumerStatementId), '');
    SELF.Liens61_orig_rmsid := IF(~suppress_condition, ri.LnJliens[61].orig_rmsid, '');
    SELF.Liens62_Seq:= IF(~suppress_condition, ri.LnJliens[62].Seq, '');
    SELF.Liens62_DateFiled:= IF(~suppress_condition, ri.LnJliens[62].DateFiled, '');
    SELF.Liens62_LienTypeID := IF(~suppress_condition, ri.LnJliens[62].LienTypeID, '');
    SELF.Liens62_LienType := IF(~suppress_condition, ri.LnJliens[62].LienType, '');
    SELF.Liens62_Amount := IF(~suppress_condition, ri.LnJliens[62].Amount, '');
    SELF.Liens62_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[62].ReleaseDate, '');
    SELF.Liens62_DateLastSeen := IF(~suppress_condition, ri.LnJliens[62].DateLastSeen, '');
    SELF.Liens62_FilingNumber := IF(~suppress_condition, ri.LnJliens[62].FilingNumber, '');
    SELF.Liens62_FilingBook := IF(~suppress_condition, ri.LnJliens[62].FilingBook, '');
    SELF.Liens62_FilingPage := IF(~suppress_condition, ri.LnJliens[62].FilingPage, '');
    SELF.Liens62_Agency := IF(~suppress_condition, ri.LnJliens[62].Agency, ''); 
    SELF.Liens62_AgencyCounty := IF(~suppress_condition, ri.LnJliens[62].AgencyCounty, '');
    SELF.Liens62_AgencyState:= IF(~suppress_condition, ri.LnJliens[62].AgencyState, '');
    SELF.Liens62_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[62].ConsumerStatementId), '');
    SELF.Liens62_orig_rmsid := IF(~suppress_condition, ri.LnJliens[62].orig_rmsid, '');
    SELF.Liens63_Seq:= IF(~suppress_condition, ri.LnJliens[63].Seq, '');
    SELF.Liens63_DateFiled:= IF(~suppress_condition, ri.LnJliens[63].DateFiled, '');
    SELF.Liens63_LienTypeID := IF(~suppress_condition, ri.LnJliens[63].LienTypeID, '');
    SELF.Liens63_LienType := IF(~suppress_condition, ri.LnJliens[63].LienType, '');
    SELF.Liens63_Amount := IF(~suppress_condition, ri.LnJliens[63].Amount, '');
    SELF.Liens63_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[63].ReleaseDate, '');
    SELF.Liens63_DateLastSeen := IF(~suppress_condition, ri.LnJliens[63].DateLastSeen, '');
    SELF.Liens63_FilingNumber := IF(~suppress_condition, ri.LnJliens[63].FilingNumber, '');
    SELF.Liens63_FilingBook := IF(~suppress_condition, ri.LnJliens[63].FilingBook, '');
    SELF.Liens63_FilingPage := IF(~suppress_condition, ri.LnJliens[63].FilingPage, '');
    SELF.Liens63_Agency := IF(~suppress_condition, ri.LnJliens[63].Agency, ''); 
    SELF.Liens63_AgencyCounty := IF(~suppress_condition, ri.LnJliens[63].AgencyCounty, '');
    SELF.Liens63_AgencyState:= IF(~suppress_condition, ri.LnJliens[63].AgencyState, '');
    SELF.Liens63_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[63].ConsumerStatementId), '');
    SELF.Liens63_orig_rmsid := IF(~suppress_condition, ri.LnJliens[63].orig_rmsid, '');
    SELF.Liens64_Seq:= IF(~suppress_condition, ri.LnJliens[64].Seq, '');
    SELF.Liens64_DateFiled:= IF(~suppress_condition, ri.LnJliens[64].DateFiled, '');
    SELF.Liens64_LienTypeID := IF(~suppress_condition, ri.LnJliens[64].LienTypeID, '');
    SELF.Liens64_LienType := IF(~suppress_condition, ri.LnJliens[64].LienType, '');
    SELF.Liens64_Amount := IF(~suppress_condition, ri.LnJliens[64].Amount, '');
    SELF.Liens64_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[64].ReleaseDate, '');
    SELF.Liens64_DateLastSeen := IF(~suppress_condition, ri.LnJliens[64].DateLastSeen, '');
    SELF.Liens64_FilingNumber := IF(~suppress_condition, ri.LnJliens[64].FilingNumber, '');
    SELF.Liens64_FilingBook := IF(~suppress_condition, ri.LnJliens[64].FilingBook, '');
    SELF.Liens64_FilingPage := IF(~suppress_condition, ri.LnJliens[64].FilingPage, '');
    SELF.Liens64_Agency := IF(~suppress_condition, ri.LnJliens[64].Agency, ''); 
    SELF.Liens64_AgencyCounty := IF(~suppress_condition, ri.LnJliens[64].AgencyCounty, '');
    SELF.Liens64_AgencyState:= IF(~suppress_condition, ri.LnJliens[64].AgencyState, '');
    SELF.Liens64_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[64].ConsumerStatementId), '');
    SELF.Liens64_orig_rmsid := IF(~suppress_condition, ri.LnJliens[64].orig_rmsid, '');
    SELF.Liens65_Seq:= IF(~suppress_condition, ri.LnJliens[65].Seq, '');
    SELF.Liens65_DateFiled:= IF(~suppress_condition, ri.LnJliens[65].DateFiled, '');
    SELF.Liens65_LienTypeID := IF(~suppress_condition, ri.LnJliens[65].LienTypeID, '');
    SELF.Liens65_LienType := IF(~suppress_condition, ri.LnJliens[65].LienType , '');
    SELF.Liens65_Amount := IF(~suppress_condition, ri.LnJliens[65].Amount , '');
    SELF.Liens65_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[65].ReleaseDate, '');
    SELF.Liens65_DateLastSeen := IF(~suppress_condition, ri.LnJliens[65].DateLastSeen , '');
    SELF.Liens65_FilingNumber := IF(~suppress_condition, ri.LnJliens[65].FilingNumber , '');
    SELF.Liens65_FilingBook := IF(~suppress_condition, ri.LnJliens[65].FilingBook , '');
    SELF.Liens65_FilingPage := IF(~suppress_condition, ri.LnJliens[65].FilingPage , '');
    SELF.Liens65_Agency := IF(~suppress_condition, ri.LnJliens[65].Agency , '');
    SELF.Liens65_AgencyCounty := IF(~suppress_condition, ri.LnJliens[65].AgencyCounty , '');
    SELF.Liens65_AgencyState:= IF(~suppress_condition, ri.LnJliens[65].AgencyState, '');
    SELF.Liens65_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[65].ConsumerStatementId), '');
    SELF.Liens65_orig_rmsid := IF(~suppress_condition, ri.LnJliens[65].orig_rmsid, '');
    SELF.Liens66_Seq:= IF(~suppress_condition, ri.LnJliens[66].Seq, '');
    SELF.Liens66_DateFiled:= IF(~suppress_condition, ri.LnJliens[66].DateFiled, '');
    SELF.Liens66_LienTypeID := IF(~suppress_condition, ri.LnJliens[66].LienTypeID, '');
    SELF.Liens66_LienType := IF(~suppress_condition, ri.LnJliens[66].LienType , '');
    SELF.Liens66_Amount := IF(~suppress_condition, ri.LnJliens[66].Amount , '');
    SELF.Liens66_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[66].ReleaseDate, '');
    SELF.Liens66_DateLastSeen := IF(~suppress_condition, ri.LnJliens[66].DateLastSeen , '');
    SELF.Liens66_FilingNumber := IF(~suppress_condition, ri.LnJliens[66].FilingNumber , '');
    SELF.Liens66_FilingBook := IF(~suppress_condition, ri.LnJliens[66].FilingBook , '');
    SELF.Liens66_FilingPage := IF(~suppress_condition, ri.LnJliens[66].FilingPage , '');
    SELF.Liens66_Agency := IF(~suppress_condition, ri.LnJliens[66].Agency , '');
    SELF.Liens66_AgencyCounty := IF(~suppress_condition, ri.LnJliens[66].AgencyCounty , '');
    SELF.Liens66_AgencyState:= IF(~suppress_condition, ri.LnJliens[66].AgencyState, '');
    SELF.Liens66_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[66].ConsumerStatementId), '');
    SELF.Liens66_orig_rmsid := IF(~suppress_condition, ri.LnJliens[66].orig_rmsid, '');
    SELF.Liens67_Seq:= IF(~suppress_condition, ri.LnJliens[67].Seq, '');
    SELF.Liens67_DateFiled:= IF(~suppress_condition, ri.LnJliens[67].DateFiled, '');
    SELF.Liens67_LienTypeID := IF(~suppress_condition, ri.LnJliens[67].LienTypeID, '');
    SELF.Liens67_LienType := IF(~suppress_condition, ri.LnJliens[67].LienType , '');
    SELF.Liens67_Amount := IF(~suppress_condition, ri.LnJliens[67].Amount , '');
    SELF.Liens67_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[67].ReleaseDate, '');
    SELF.Liens67_DateLastSeen := IF(~suppress_condition, ri.LnJliens[67].DateLastSeen , '');
    SELF.Liens67_FilingNumber := IF(~suppress_condition, ri.LnJliens[67].FilingNumber , '');
    SELF.Liens67_FilingBook := IF(~suppress_condition, ri.LnJliens[67].FilingBook , '');
    SELF.Liens67_FilingPage := IF(~suppress_condition, ri.LnJliens[67].FilingPage , '');
    SELF.Liens67_Agency := IF(~suppress_condition, ri.LnJliens[67].Agency , '');
    SELF.Liens67_AgencyCounty := IF(~suppress_condition, ri.LnJliens[67].AgencyCounty , '');
    SELF.Liens67_AgencyState:= IF(~suppress_condition, ri.LnJliens[67].AgencyState, '');
    SELF.Liens67_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[67].ConsumerStatementId), '');
    SELF.Liens67_orig_rmsid := IF(~suppress_condition, ri.LnJliens[67].orig_rmsid, '');
    SELF.Liens68_Seq:= IF(~suppress_condition, ri.LnJliens[68].Seq, '');
    SELF.Liens68_DateFiled:= IF(~suppress_condition, ri.LnJliens[68].DateFiled, '');
    SELF.Liens68_LienTypeID := IF(~suppress_condition, ri.LnJliens[68].LienTypeID, '');
    SELF.Liens68_LienType := IF(~suppress_condition, ri.LnJliens[68].LienType , '');
    SELF.Liens68_Amount := IF(~suppress_condition, ri.LnJliens[68].Amount , '');
    SELF.Liens68_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[68].ReleaseDate, '');
    SELF.Liens68_DateLastSeen := IF(~suppress_condition, ri.LnJliens[68].DateLastSeen , '');
    SELF.Liens68_FilingNumber := IF(~suppress_condition, ri.LnJliens[68].FilingNumber , '');
    SELF.Liens68_FilingBook := IF(~suppress_condition, ri.LnJliens[68].FilingBook , '');
    SELF.Liens68_FilingPage := IF(~suppress_condition, ri.LnJliens[68].FilingPage , '');
    SELF.Liens68_Agency := IF(~suppress_condition, ri.LnJliens[68].Agency , '');
    SELF.Liens68_AgencyCounty := IF(~suppress_condition, ri.LnJliens[68].AgencyCounty , '');
    SELF.Liens68_AgencyState:= IF(~suppress_condition, ri.LnJliens[68].AgencyState, '');
    SELF.Liens68_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[68].ConsumerStatementId), '');
    SELF.Liens68_orig_rmsid := IF(~suppress_condition, ri.LnJliens[68].orig_rmsid, '');
    SELF.Liens69_Seq:= IF(~suppress_condition, ri.LnJliens[69].Seq, '');
    SELF.Liens69_DateFiled:= IF(~suppress_condition, ri.LnJliens[69].DateFiled, '');
    SELF.Liens69_LienTypeID := IF(~suppress_condition, ri.LnJliens[69].LienTypeID, '');
    SELF.Liens69_LienType := IF(~suppress_condition, ri.LnJliens[69].LienType , '');
    SELF.Liens69_Amount := IF(~suppress_condition, ri.LnJliens[69].Amount , '');
    SELF.Liens69_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[69].ReleaseDate, '');
    SELF.Liens69_DateLastSeen := IF(~suppress_condition, ri.LnJliens[69].DateLastSeen , '');
    SELF.Liens69_FilingNumber := IF(~suppress_condition, ri.LnJliens[69].FilingNumber , '');
    SELF.Liens69_FilingBook := IF(~suppress_condition, ri.LnJliens[69].FilingBook , '');
    SELF.Liens69_FilingPage := IF(~suppress_condition, ri.LnJliens[69].FilingPage , '');
    SELF.Liens69_Agency := IF(~suppress_condition, ri.LnJliens[69].Agency , '');
    SELF.Liens69_AgencyCounty := IF(~suppress_condition, ri.LnJliens[69].AgencyCounty , '');
    SELF.Liens69_AgencyState:= IF(~suppress_condition, ri.LnJliens[69].AgencyState, '');
    SELF.Liens69_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[69].ConsumerStatementId), '');
    SELF.Liens69_orig_rmsid := IF(~suppress_condition, ri.LnJliens[69].orig_rmsid, '');
    SELF.Liens70_Seq:= IF(~suppress_condition, ri.LnJliens[70].Seq , '');
    SELF.Liens70_DateFiled:= IF(~suppress_condition, ri.LnJliens[70].DateFiled , '');
    SELF.Liens70_LienTypeID := IF(~suppress_condition, ri.LnJliens[70].LienTypeID, '');
    SELF.Liens70_LienType := IF(~suppress_condition, ri.LnJliens[70].LienType, '');
    SELF.Liens70_Amount := IF(~suppress_condition, ri.LnJliens[70].Amount, '');
    SELF.Liens70_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[70].ReleaseDate , '');
    SELF.Liens70_DateLastSeen := IF(~suppress_condition, ri.LnJliens[70].DateLastSeen, '');
    SELF.Liens70_FilingNumber := IF(~suppress_condition, ri.LnJliens[70].FilingNumber, '');
    SELF.Liens70_FilingBook := IF(~suppress_condition, ri.LnJliens[70].FilingBook, '');
    SELF.Liens70_FilingPage := IF(~suppress_condition, ri.LnJliens[70].FilingPage, '');
    SELF.Liens70_Agency := IF(~suppress_condition, ri.LnJliens[70].Agency, '');
    SELF.Liens70_AgencyCounty := IF(~suppress_condition, ri.LnJliens[70].AgencyCounty, '');
    SELF.Liens70_AgencyState:= IF(~suppress_condition, ri.LnJliens[70].AgencyState , '');
    SELF.Liens70_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[70].ConsumerStatementId), '');
    SELF.Liens70_orig_rmsid := IF(~suppress_condition, ri.LnJliens[70].orig_rmsid, '');
    SELF.Liens71_Seq:= IF(~suppress_condition, ri.LnJliens[71].Seq, '');
    SELF.Liens71_DateFiled:= IF(~suppress_condition, ri.LnJliens[71].DateFiled, '');
    SELF.Liens71_LienTypeID := IF(~suppress_condition, ri.LnJliens[71].LienTypeID, '');
    SELF.Liens71_LienType := IF(~suppress_condition, ri.LnJliens[71].LienType, '');
    SELF.Liens71_Amount := IF(~suppress_condition, ri.LnJliens[71].Amount, '');
    SELF.Liens71_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[71].ReleaseDate, '');
    SELF.Liens71_DateLastSeen := IF(~suppress_condition, ri.LnJliens[71].DateLastSeen, '');
    SELF.Liens71_FilingNumber := IF(~suppress_condition, ri.LnJliens[71].FilingNumber, '');
    SELF.Liens71_FilingBook := IF(~suppress_condition, ri.LnJliens[71].FilingBook, '');
    SELF.Liens71_FilingPage := IF(~suppress_condition, ri.LnJliens[71].FilingPage, '');
    SELF.Liens71_Agency := IF(~suppress_condition, ri.LnJliens[71].Agency , '');
    SELF.Liens71_AgencyCounty := IF(~suppress_condition, ri.LnJliens[71].AgencyCounty, '');
    SELF.Liens71_AgencyState:= IF(~suppress_condition, ri.LnJliens[71].AgencyState, '');
    SELF.Liens71_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[71].ConsumerStatementId), '');
    SELF.Liens71_orig_rmsid := IF(~suppress_condition, ri.LnJliens[71].orig_rmsid, '');
    SELF.Liens72_Seq:= IF(~suppress_condition, ri.LnJliens[72].Seq, '');
    SELF.Liens72_DateFiled:= IF(~suppress_condition, ri.LnJliens[72].DateFiled, '');
    SELF.Liens72_LienTypeID := IF(~suppress_condition, ri.LnJliens[72].LienTypeID, '');
    SELF.Liens72_LienType := IF(~suppress_condition, ri.LnJliens[72].LienType, '');
    SELF.Liens72_Amount := IF(~suppress_condition, ri.LnJliens[72].Amount, '');
    SELF.Liens72_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[72].ReleaseDate, '');
    SELF.Liens72_DateLastSeen := IF(~suppress_condition, ri.LnJliens[72].DateLastSeen, '');
    SELF.Liens72_FilingNumber := IF(~suppress_condition, ri.LnJliens[72].FilingNumber, '');
    SELF.Liens72_FilingBook := IF(~suppress_condition, ri.LnJliens[72].FilingBook, '');
    SELF.Liens72_FilingPage := IF(~suppress_condition, ri.LnJliens[72].FilingPage, ''); 
    SELF.Liens72_Agency := IF(~suppress_condition, ri.LnJliens[72].Agency, ''); 
    SELF.Liens72_AgencyCounty := IF(~suppress_condition, ri.LnJliens[72].AgencyCounty, '');
    SELF.Liens72_AgencyState:= IF(~suppress_condition, ri.LnJliens[72].AgencyState, '');
    SELF.Liens72_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[72].ConsumerStatementId), '');
    SELF.Liens72_orig_rmsid := IF(~suppress_condition, ri.LnJliens[72].orig_rmsid, '');
    SELF.Liens73_Seq:= IF(~suppress_condition, ri.LnJliens[73].Seq, '');
    SELF.Liens73_DateFiled:= IF(~suppress_condition, ri.LnJliens[73].DateFiled, '');
    SELF.Liens73_LienTypeID := IF(~suppress_condition, ri.LnJliens[73].LienTypeID, '');
    SELF.Liens73_LienType := IF(~suppress_condition, ri.LnJliens[73].LienType, '');
    SELF.Liens73_Amount := IF(~suppress_condition, ri.LnJliens[73].Amount, '');
    SELF.Liens73_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[73].ReleaseDate, '');
    SELF.Liens73_DateLastSeen := IF(~suppress_condition, ri.LnJliens[73].DateLastSeen, '');
    SELF.Liens73_FilingNumber := IF(~suppress_condition, ri.LnJliens[73].FilingNumber, '');
    SELF.Liens73_FilingBook := IF(~suppress_condition, ri.LnJliens[73].FilingBook, '');
    SELF.Liens73_FilingPage := IF(~suppress_condition, ri.LnJliens[73].FilingPage, '');
    SELF.Liens73_Agency := IF(~suppress_condition, ri.LnJliens[73].Agency, ''); 
    SELF.Liens73_AgencyCounty := IF(~suppress_condition, ri.LnJliens[73].AgencyCounty, '');
    SELF.Liens73_AgencyState:= IF(~suppress_condition, ri.LnJliens[73].AgencyState, '');
    SELF.Liens73_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[73].ConsumerStatementId), '');
    SELF.Liens73_orig_rmsid := IF(~suppress_condition, ri.LnJliens[73].orig_rmsid, '');
    SELF.Liens74_Seq:= IF(~suppress_condition, ri.LnJliens[74].Seq, '');
    SELF.Liens74_DateFiled:= IF(~suppress_condition, ri.LnJliens[74].DateFiled, '');
    SELF.Liens74_LienTypeID := IF(~suppress_condition, ri.LnJliens[74].LienTypeID, '');
    SELF.Liens74_LienType := IF(~suppress_condition, ri.LnJliens[74].LienType, '');
    SELF.Liens74_Amount := IF(~suppress_condition, ri.LnJliens[74].Amount, '');
    SELF.Liens74_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[74].ReleaseDate, '');
    SELF.Liens74_DateLastSeen := IF(~suppress_condition, ri.LnJliens[74].DateLastSeen, '');
    SELF.Liens74_FilingNumber := IF(~suppress_condition, ri.LnJliens[74].FilingNumber, '');
    SELF.Liens74_FilingBook := IF(~suppress_condition, ri.LnJliens[74].FilingBook, '');
    SELF.Liens74_FilingPage := IF(~suppress_condition, ri.LnJliens[74].FilingPage, '');
    SELF.Liens74_Agency := IF(~suppress_condition, ri.LnJliens[74].Agency, ''); 
    SELF.Liens74_AgencyCounty := IF(~suppress_condition, ri.LnJliens[74].AgencyCounty, '');
    SELF.Liens74_AgencyState:= IF(~suppress_condition, ri.LnJliens[74].AgencyState, '');
    SELF.Liens74_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[74].ConsumerStatementId), '');
    SELF.Liens74_orig_rmsid := IF(~suppress_condition, ri.LnJliens[74].orig_rmsid, '');
    SELF.Liens75_Seq:= IF(~suppress_condition, ri.LnJliens[75].Seq, '');
    SELF.Liens75_DateFiled:= IF(~suppress_condition, ri.LnJliens[75].DateFiled, '');
    SELF.Liens75_LienTypeID := IF(~suppress_condition, ri.LnJliens[75].LienTypeID, '');
    SELF.Liens75_LienType := IF(~suppress_condition, ri.LnJliens[75].LienType , '');
    SELF.Liens75_Amount := IF(~suppress_condition, ri.LnJliens[75].Amount , '');
    SELF.Liens75_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[75].ReleaseDate, '');
    SELF.Liens75_DateLastSeen := IF(~suppress_condition, ri.LnJliens[75].DateLastSeen , '');
    SELF.Liens75_FilingNumber := IF(~suppress_condition, ri.LnJliens[75].FilingNumber , '');
    SELF.Liens75_FilingBook := IF(~suppress_condition, ri.LnJliens[75].FilingBook , '');
    SELF.Liens75_FilingPage := IF(~suppress_condition, ri.LnJliens[75].FilingPage , '');
    SELF.Liens75_Agency := IF(~suppress_condition, ri.LnJliens[75].Agency , '');
    SELF.Liens75_AgencyCounty := IF(~suppress_condition, ri.LnJliens[75].AgencyCounty , '');
    SELF.Liens75_AgencyState:= IF(~suppress_condition, ri.LnJliens[75].AgencyState, '');
    SELF.Liens75_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[75].ConsumerStatementId), '');
    SELF.Liens75_orig_rmsid := IF(~suppress_condition, ri.LnJliens[75].orig_rmsid, '');
    SELF.Liens76_Seq:= IF(~suppress_condition, ri.LnJliens[76].Seq, '');
    SELF.Liens76_DateFiled:= IF(~suppress_condition, ri.LnJliens[76].DateFiled, '');
    SELF.Liens76_LienTypeID := IF(~suppress_condition, ri.LnJliens[76].LienTypeID, '');
    SELF.Liens76_LienType := IF(~suppress_condition, ri.LnJliens[76].LienType , '');
    SELF.Liens76_Amount := IF(~suppress_condition, ri.LnJliens[76].Amount , '');
    SELF.Liens76_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[76].ReleaseDate, '');
    SELF.Liens76_DateLastSeen := IF(~suppress_condition, ri.LnJliens[76].DateLastSeen , '');
    SELF.Liens76_FilingNumber := IF(~suppress_condition, ri.LnJliens[76].FilingNumber , '');
    SELF.Liens76_FilingBook := IF(~suppress_condition, ri.LnJliens[76].FilingBook , '');
    SELF.Liens76_FilingPage := IF(~suppress_condition, ri.LnJliens[76].FilingPage , '');
    SELF.Liens76_Agency := IF(~suppress_condition, ri.LnJliens[76].Agency , '');
    SELF.Liens76_AgencyCounty := IF(~suppress_condition, ri.LnJliens[76].AgencyCounty , '');
    SELF.Liens76_AgencyState:= IF(~suppress_condition, ri.LnJliens[76].AgencyState, '');
    SELF.Liens76_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[76].ConsumerStatementId), '');
    SELF.Liens76_orig_rmsid := IF(~suppress_condition, ri.LnJliens[76].orig_rmsid, '');
    SELF.Liens77_Seq:= IF(~suppress_condition, ri.LnJliens[77].Seq, '');
    SELF.Liens77_DateFiled:= IF(~suppress_condition, ri.LnJliens[77].DateFiled, '');
    SELF.Liens77_LienTypeID := IF(~suppress_condition, ri.LnJliens[77].LienTypeID, '');
    SELF.Liens77_LienType := IF(~suppress_condition, ri.LnJliens[77].LienType , '');
    SELF.Liens77_Amount := IF(~suppress_condition, ri.LnJliens[77].Amount , '');
    SELF.Liens77_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[77].ReleaseDate, '');
    SELF.Liens77_DateLastSeen := IF(~suppress_condition, ri.LnJliens[77].DateLastSeen , '');
    SELF.Liens77_FilingNumber := IF(~suppress_condition, ri.LnJliens[77].FilingNumber , '');
    SELF.Liens77_FilingBook := IF(~suppress_condition, ri.LnJliens[77].FilingBook , '');
    SELF.Liens77_FilingPage := IF(~suppress_condition, ri.LnJliens[77].FilingPage , '');
    SELF.Liens77_Agency := IF(~suppress_condition, ri.LnJliens[77].Agency , '');
    SELF.Liens77_AgencyCounty := IF(~suppress_condition, ri.LnJliens[77].AgencyCounty , '');
    SELF.Liens77_AgencyState:= IF(~suppress_condition, ri.LnJliens[77].AgencyState, '');
    SELF.Liens77_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[77].ConsumerStatementId), '');
    SELF.Liens77_orig_rmsid := IF(~suppress_condition, ri.LnJliens[77].orig_rmsid, '');
    SELF.Liens78_Seq:= IF(~suppress_condition, ri.LnJliens[78].Seq, '');
    SELF.Liens78_DateFiled:= IF(~suppress_condition, ri.LnJliens[78].DateFiled, '');
    SELF.Liens78_LienTypeID := IF(~suppress_condition, ri.LnJliens[78].LienTypeID, '');
    SELF.Liens78_LienType := IF(~suppress_condition, ri.LnJliens[78].LienType , '');
    SELF.Liens78_Amount := IF(~suppress_condition, ri.LnJliens[78].Amount , '');
    SELF.Liens78_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[78].ReleaseDate, '');
    SELF.Liens78_DateLastSeen := IF(~suppress_condition, ri.LnJliens[78].DateLastSeen , '');
    SELF.Liens78_FilingNumber := IF(~suppress_condition, ri.LnJliens[78].FilingNumber , '');
    SELF.Liens78_FilingBook := IF(~suppress_condition, ri.LnJliens[78].FilingBook , '');
    SELF.Liens78_FilingPage := IF(~suppress_condition, ri.LnJliens[78].FilingPage , '');
    SELF.Liens78_Agency := IF(~suppress_condition, ri.LnJliens[78].Agency , '');
    SELF.Liens78_AgencyCounty := IF(~suppress_condition, ri.LnJliens[78].AgencyCounty , '');
    SELF.Liens78_AgencyState:= IF(~suppress_condition, ri.LnJliens[78].AgencyState, '');
    SELF.Liens78_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[78].ConsumerStatementId), '');
    SELF.Liens78_orig_rmsid := IF(~suppress_condition, ri.LnJliens[78].orig_rmsid, '');
    SELF.Liens79_Seq:= IF(~suppress_condition, ri.LnJliens[79].Seq, '');
    SELF.Liens79_DateFiled:= IF(~suppress_condition, ri.LnJliens[79].DateFiled, '');
    SELF.Liens79_LienTypeID := IF(~suppress_condition, ri.LnJliens[79].LienTypeID, '');
    SELF.Liens79_LienType := IF(~suppress_condition, ri.LnJliens[79].LienType , '');
    SELF.Liens79_Amount := IF(~suppress_condition, ri.LnJliens[79].Amount , '');
    SELF.Liens79_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[79].ReleaseDate, '');
    SELF.Liens79_DateLastSeen := IF(~suppress_condition, ri.LnJliens[79].DateLastSeen , '');
    SELF.Liens79_FilingNumber := IF(~suppress_condition, ri.LnJliens[79].FilingNumber , '');
    SELF.Liens79_FilingBook := IF(~suppress_condition, ri.LnJliens[79].FilingBook , '');
    SELF.Liens79_FilingPage := IF(~suppress_condition, ri.LnJliens[79].FilingPage , '');
    SELF.Liens79_Agency := IF(~suppress_condition, ri.LnJliens[79].Agency , '');
    SELF.Liens79_AgencyCounty := IF(~suppress_condition, ri.LnJliens[79].AgencyCounty , '');
    SELF.Liens79_AgencyState:= IF(~suppress_condition, ri.LnJliens[79].AgencyState, '');
    SELF.Liens79_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[79].ConsumerStatementId), '');
    SELF.Liens79_orig_rmsid := IF(~suppress_condition, ri.LnJliens[79].orig_rmsid, '');
    SELF.Liens80_Seq:= IF(~suppress_condition, ri.LnJliens[80].Seq , '');
    SELF.Liens80_DateFiled:= IF(~suppress_condition, ri.LnJliens[80].DateFiled , '');
    SELF.Liens80_LienTypeID := IF(~suppress_condition, ri.LnJliens[80].LienTypeID, '');
    SELF.Liens80_LienType := IF(~suppress_condition, ri.LnJliens[80].LienType, '');
    SELF.Liens80_Amount := IF(~suppress_condition, ri.LnJliens[80].Amount, '');
    SELF.Liens80_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[80].ReleaseDate , '');
    SELF.Liens80_DateLastSeen := IF(~suppress_condition, ri.LnJliens[80].DateLastSeen, '');
    SELF.Liens80_FilingNumber := IF(~suppress_condition, ri.LnJliens[80].FilingNumber, '');
    SELF.Liens80_FilingBook := IF(~suppress_condition, ri.LnJliens[80].FilingBook, '');
    SELF.Liens80_FilingPage := IF(~suppress_condition, ri.LnJliens[80].FilingPage, '');
    SELF.Liens80_Agency := IF(~suppress_condition, ri.LnJliens[80].Agency, '');
    SELF.Liens80_AgencyCounty := IF(~suppress_condition, ri.LnJliens[80].AgencyCounty, '');
    SELF.Liens80_AgencyState:= IF(~suppress_condition, ri.LnJliens[80].AgencyState , '');
    SELF.Liens80_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[80].ConsumerStatementId), '');
    SELF.Liens80_orig_rmsid := IF(~suppress_condition, ri.LnJliens[80].orig_rmsid, '');
    SELF.Liens81_Seq:= IF(~suppress_condition, ri.LnJliens[81].Seq, '');
    SELF.Liens81_DateFiled:= IF(~suppress_condition, ri.LnJliens[81].DateFiled, '');
    SELF.Liens81_LienTypeID := IF(~suppress_condition, ri.LnJliens[81].LienTypeID, '');
    SELF.Liens81_LienType := IF(~suppress_condition, ri.LnJliens[81].LienType, '');
    SELF.Liens81_Amount := IF(~suppress_condition, ri.LnJliens[81].Amount, '');
    SELF.Liens81_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[81].ReleaseDate, '');
    SELF.Liens81_DateLastSeen := IF(~suppress_condition, ri.LnJliens[81].DateLastSeen, '');
    SELF.Liens81_FilingNumber := IF(~suppress_condition, ri.LnJliens[81].FilingNumber, '');
    SELF.Liens81_FilingBook := IF(~suppress_condition, ri.LnJliens[81].FilingBook, '');
    SELF.Liens81_FilingPage := IF(~suppress_condition, ri.LnJliens[81].FilingPage, '');
    SELF.Liens81_Agency := IF(~suppress_condition, ri.LnJliens[81].Agency , '');
    SELF.Liens81_AgencyCounty := IF(~suppress_condition, ri.LnJliens[81].AgencyCounty, '');
    SELF.Liens81_AgencyState:= IF(~suppress_condition, ri.LnJliens[81].AgencyState, '');
    SELF.Liens81_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[81].ConsumerStatementId), '');
    SELF.Liens81_orig_rmsid := IF(~suppress_condition, ri.LnJliens[81].orig_rmsid, '');
    SELF.Liens82_Seq:= IF(~suppress_condition, ri.LnJliens[82].Seq, '');
    SELF.Liens82_DateFiled:= IF(~suppress_condition, ri.LnJliens[82].DateFiled, '');
    SELF.Liens82_LienTypeID := IF(~suppress_condition, ri.LnJliens[82].LienTypeID, '');
    SELF.Liens82_LienType := IF(~suppress_condition, ri.LnJliens[82].LienType, '');
    SELF.Liens82_Amount := IF(~suppress_condition, ri.LnJliens[82].Amount, '');
    SELF.Liens82_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[82].ReleaseDate, '');
    SELF.Liens82_DateLastSeen := IF(~suppress_condition, ri.LnJliens[82].DateLastSeen, '');
    SELF.Liens82_FilingNumber := IF(~suppress_condition, ri.LnJliens[82].FilingNumber, '');
    SELF.Liens82_FilingBook := IF(~suppress_condition, ri.LnJliens[82].FilingBook, '');
    SELF.Liens82_FilingPage := IF(~suppress_condition, ri.LnJliens[82].FilingPage, '');
    SELF.Liens82_Agency := IF(~suppress_condition, ri.LnJliens[82].Agency, ''); 
    SELF.Liens82_AgencyCounty := IF(~suppress_condition, ri.LnJliens[82].AgencyCounty, '');
    SELF.Liens82_AgencyState:= IF(~suppress_condition, ri.LnJliens[82].AgencyState, '');
    SELF.Liens82_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[82].ConsumerStatementId), '');
    SELF.Liens82_orig_rmsid := IF(~suppress_condition, ri.LnJliens[82].orig_rmsid, '');
    SELF.Liens83_Seq:= IF(~suppress_condition, ri.LnJliens[83].Seq, '');
    SELF.Liens83_DateFiled:= IF(~suppress_condition, ri.LnJliens[83].DateFiled, '');
    SELF.Liens83_LienTypeID := IF(~suppress_condition, ri.LnJliens[83].LienTypeID, '');
    SELF.Liens83_LienType := IF(~suppress_condition, ri.LnJliens[83].LienType, '');
    SELF.Liens83_Amount := IF(~suppress_condition, ri.LnJliens[83].Amount, '');
    SELF.Liens83_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[83].ReleaseDate, '');
    SELF.Liens83_DateLastSeen := IF(~suppress_condition, ri.LnJliens[83].DateLastSeen, '');
    SELF.Liens83_FilingNumber := IF(~suppress_condition, ri.LnJliens[83].FilingNumber, '');
    SELF.Liens83_FilingBook := IF(~suppress_condition, ri.LnJliens[83].FilingBook, '');
    SELF.Liens83_FilingPage := IF(~suppress_condition, ri.LnJliens[83].FilingPage, '');
    SELF.Liens83_Agency := IF(~suppress_condition, ri.LnJliens[83].Agency, ''); 
    SELF.Liens83_AgencyCounty := IF(~suppress_condition, ri.LnJliens[83].AgencyCounty, '');
    SELF.Liens83_AgencyState:= IF(~suppress_condition, ri.LnJliens[83].AgencyState, '');
    SELF.Liens83_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[83].ConsumerStatementId), '');
    SELF.Liens83_orig_rmsid := IF(~suppress_condition, ri.LnJliens[83].orig_rmsid, '');
    SELF.Liens84_Seq:= IF(~suppress_condition, ri.LnJliens[84].Seq, '');
    SELF.Liens84_DateFiled:= IF(~suppress_condition, ri.LnJliens[84].DateFiled, '');
    SELF.Liens84_LienTypeID := IF(~suppress_condition, ri.LnJliens[84].LienTypeID, '');
    SELF.Liens84_LienType := IF(~suppress_condition, ri.LnJliens[84].LienType, '');
    SELF.Liens84_Amount := IF(~suppress_condition, ri.LnJliens[84].Amount, '');
    SELF.Liens84_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[84].ReleaseDate, '');
    SELF.Liens84_DateLastSeen := IF(~suppress_condition, ri.LnJliens[84].DateLastSeen, '');
    SELF.Liens84_FilingNumber := IF(~suppress_condition, ri.LnJliens[84].FilingNumber, '');
    SELF.Liens84_FilingBook := IF(~suppress_condition, ri.LnJliens[84].FilingBook, '');
    SELF.Liens84_FilingPage := IF(~suppress_condition, ri.LnJliens[84].FilingPage, ''); 
    SELF.Liens84_Agency := IF(~suppress_condition, ri.LnJliens[84].Agency, ''); 
    SELF.Liens84_AgencyCounty := IF(~suppress_condition, ri.LnJliens[84].AgencyCounty, '');
    SELF.Liens84_AgencyState:= IF(~suppress_condition, ri.LnJliens[84].AgencyState, '');
    SELF.Liens84_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[84].ConsumerStatementId), '');
    SELF.Liens84_orig_rmsid := IF(~suppress_condition, ri.LnJliens[84].orig_rmsid, '');
    SELF.Liens85_Seq:= IF(~suppress_condition, ri.LnJliens[85].Seq, '');
    SELF.Liens85_DateFiled:= IF(~suppress_condition, ri.LnJliens[85].DateFiled, '');
    SELF.Liens85_LienTypeID := IF(~suppress_condition, ri.LnJliens[85].LienTypeID, '');
    SELF.Liens85_LienType := IF(~suppress_condition, ri.LnJliens[85].LienType , '');
    SELF.Liens85_Amount := IF(~suppress_condition, ri.LnJliens[85].Amount , '');
    SELF.Liens85_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[85].ReleaseDate, '');
    SELF.Liens85_DateLastSeen := IF(~suppress_condition, ri.LnJliens[85].DateLastSeen , '');
    SELF.Liens85_FilingNumber := IF(~suppress_condition, ri.LnJliens[85].FilingNumber , '');
    SELF.Liens85_FilingBook := IF(~suppress_condition, ri.LnJliens[85].FilingBook , '');
    SELF.Liens85_FilingPage := IF(~suppress_condition, ri.LnJliens[85].FilingPage , '');
    SELF.Liens85_Agency := IF(~suppress_condition, ri.LnJliens[85].Agency , '');
    SELF.Liens85_AgencyCounty := IF(~suppress_condition, ri.LnJliens[85].AgencyCounty , '');
    SELF.Liens85_AgencyState:= IF(~suppress_condition, ri.LnJliens[85].AgencyState, '');
    SELF.Liens85_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[85].ConsumerStatementId), '');
    SELF.Liens85_orig_rmsid := IF(~suppress_condition, ri.LnJliens[85].orig_rmsid, '');
    SELF.Liens86_Seq:= IF(~suppress_condition, ri.LnJliens[86].Seq, '');
    SELF.Liens86_DateFiled:= IF(~suppress_condition, ri.LnJliens[86].DateFiled, '');
    SELF.Liens86_LienTypeID := IF(~suppress_condition, ri.LnJliens[86].LienTypeID, '');
    SELF.Liens86_LienType := IF(~suppress_condition, ri.LnJliens[86].LienType , '');
    SELF.Liens86_Amount := IF(~suppress_condition, ri.LnJliens[86].Amount , '');
    SELF.Liens86_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[86].ReleaseDate, '');
    SELF.Liens86_DateLastSeen := IF(~suppress_condition, ri.LnJliens[86].DateLastSeen , '');
    SELF.Liens86_FilingNumber := IF(~suppress_condition, ri.LnJliens[86].FilingNumber , '');
    SELF.Liens86_FilingBook := IF(~suppress_condition, ri.LnJliens[86].FilingBook , '');
    SELF.Liens86_FilingPage := IF(~suppress_condition, ri.LnJliens[86].FilingPage , '');
    SELF.Liens86_Agency := IF(~suppress_condition, ri.LnJliens[86].Agency , '');
    SELF.Liens86_AgencyCounty := IF(~suppress_condition, ri.LnJliens[86].AgencyCounty , '');
    SELF.Liens86_AgencyState:= IF(~suppress_condition, ri.LnJliens[86].AgencyState, '');
    SELF.Liens86_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[86].ConsumerStatementId), '');
    SELF.Liens86_orig_rmsid := IF(~suppress_condition, ri.LnJliens[86].orig_rmsid, '');
    SELF.Liens87_Seq:= IF(~suppress_condition, ri.LnJliens[87].Seq, '');
    SELF.Liens87_DateFiled:= IF(~suppress_condition, ri.LnJliens[87].DateFiled, '');
    SELF.Liens87_LienTypeID := IF(~suppress_condition, ri.LnJliens[87].LienTypeID, '');
    SELF.Liens87_LienType := IF(~suppress_condition, ri.LnJliens[87].LienType , '');
    SELF.Liens87_Amount := IF(~suppress_condition, ri.LnJliens[87].Amount , '');
    SELF.Liens87_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[87].ReleaseDate, '');
    SELF.Liens87_DateLastSeen := IF(~suppress_condition, ri.LnJliens[87].DateLastSeen , '');
    SELF.Liens87_FilingNumber := IF(~suppress_condition, ri.LnJliens[87].FilingNumber , '');
    SELF.Liens87_FilingBook := IF(~suppress_condition, ri.LnJliens[87].FilingBook , '');
    SELF.Liens87_FilingPage := IF(~suppress_condition, ri.LnJliens[87].FilingPage , '');
    SELF.Liens87_Agency := IF(~suppress_condition, ri.LnJliens[87].Agency , '');
    SELF.Liens87_AgencyCounty := IF(~suppress_condition, ri.LnJliens[87].AgencyCounty , '');
    SELF.Liens87_AgencyState:= IF(~suppress_condition, ri.LnJliens[87].AgencyState, '');
    SELF.Liens87_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[87].ConsumerStatementId), '');
    SELF.Liens87_orig_rmsid := IF(~suppress_condition, ri.LnJliens[87].orig_rmsid, '');
    SELF.Liens88_Seq:= IF(~suppress_condition, ri.LnJliens[88].Seq, '');
    SELF.Liens88_DateFiled:= IF(~suppress_condition, ri.LnJliens[88].DateFiled, '');
    SELF.Liens88_LienTypeID := IF(~suppress_condition, ri.LnJliens[88].LienTypeID, '');
    SELF.Liens88_LienType := IF(~suppress_condition, ri.LnJliens[88].LienType , '');
    SELF.Liens88_Amount := IF(~suppress_condition, ri.LnJliens[88].Amount , '');
    SELF.Liens88_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[88].ReleaseDate, '');
    SELF.Liens88_DateLastSeen := IF(~suppress_condition, ri.LnJliens[88].DateLastSeen , '');
    SELF.Liens88_FilingNumber := IF(~suppress_condition, ri.LnJliens[88].FilingNumber , '');
    SELF.Liens88_FilingBook := IF(~suppress_condition, ri.LnJliens[88].FilingBook , '');
    SELF.Liens88_FilingPage := IF(~suppress_condition, ri.LnJliens[88].FilingPage , '');
    SELF.Liens88_Agency := IF(~suppress_condition, ri.LnJliens[88].Agency , '');
    SELF.Liens88_AgencyCounty := IF(~suppress_condition, ri.LnJliens[88].AgencyCounty , '');
    SELF.Liens88_AgencyState:= IF(~suppress_condition, ri.LnJliens[88].AgencyState, '');
    SELF.Liens88_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[88].ConsumerStatementId), '');
    SELF.Liens88_orig_rmsid := IF(~suppress_condition, ri.LnJliens[88].orig_rmsid, '');
    SELF.Liens89_Seq:= IF(~suppress_condition, ri.LnJliens[89].Seq, '');
    SELF.Liens89_DateFiled:= IF(~suppress_condition, ri.LnJliens[89].DateFiled, '');
    SELF.Liens89_LienTypeID := IF(~suppress_condition, ri.LnJliens[89].LienTypeID, '');
    SELF.Liens89_LienType := IF(~suppress_condition, ri.LnJliens[89].LienType , '');
    SELF.Liens89_Amount := IF(~suppress_condition, ri.LnJliens[89].Amount , '');
    SELF.Liens89_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[89].ReleaseDate, '');
    SELF.Liens89_DateLastSeen := IF(~suppress_condition, ri.LnJliens[89].DateLastSeen , '');
    SELF.Liens89_FilingNumber := IF(~suppress_condition, ri.LnJliens[89].FilingNumber , '');
    SELF.Liens89_FilingBook := IF(~suppress_condition, ri.LnJliens[89].FilingBook , '');
    SELF.Liens89_FilingPage := IF(~suppress_condition, ri.LnJliens[89].FilingPage , '');
    SELF.Liens89_Agency := IF(~suppress_condition, ri.LnJliens[89].Agency , '');
    SELF.Liens89_AgencyCounty := IF(~suppress_condition, ri.LnJliens[89].AgencyCounty , '');
    SELF.Liens89_AgencyState:= IF(~suppress_condition, ri.LnJliens[89].AgencyState, '');
    SELF.Liens89_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[89].ConsumerStatementId), '');
    SELF.Liens89_orig_rmsid := IF(~suppress_condition, ri.LnJliens[89].orig_rmsid, '');
    SELF.Liens90_Seq:= IF(~suppress_condition, ri.LnJliens[90].Seq , '');
    SELF.Liens90_DateFiled:= IF(~suppress_condition, ri.LnJliens[90].DateFiled , '');
    SELF.Liens90_LienTypeID := IF(~suppress_condition, ri.LnJliens[90].LienTypeID, '');
    SELF.Liens90_LienType := IF(~suppress_condition, ri.LnJliens[90].LienType, '');
    SELF.Liens90_Amount := IF(~suppress_condition, ri.LnJliens[90].Amount, '');
    SELF.Liens90_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[90].ReleaseDate , '');
    SELF.Liens90_DateLastSeen := IF(~suppress_condition, ri.LnJliens[90].DateLastSeen, '');
    SELF.Liens90_FilingNumber := IF(~suppress_condition, ri.LnJliens[90].FilingNumber, '');
    SELF.Liens90_FilingBook := IF(~suppress_condition, ri.LnJliens[90].FilingBook, '');
    SELF.Liens90_FilingPage := IF(~suppress_condition, ri.LnJliens[90].FilingPage, '');
    SELF.Liens90_Agency := IF(~suppress_condition, ri.LnJliens[90].Agency, '');
    SELF.Liens90_AgencyCounty := IF(~suppress_condition, ri.LnJliens[90].AgencyCounty, '');
    SELF.Liens90_AgencyState:= IF(~suppress_condition, ri.LnJliens[90].AgencyState , '');
    SELF.Liens90_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[90].ConsumerStatementId), '');
    SELF.Liens90_orig_rmsid := IF(~suppress_condition, ri.LnJliens[90].orig_rmsid, '');
    SELF.Liens91_Seq:= IF(~suppress_condition, ri.LnJliens[91].Seq, '');
    SELF.Liens91_DateFiled:= IF(~suppress_condition, ri.LnJliens[91].DateFiled, '');
    SELF.Liens91_LienTypeID := IF(~suppress_condition, ri.LnJliens[91].LienTypeID, '');
    SELF.Liens91_LienType := IF(~suppress_condition, ri.LnJliens[91].LienType, '');
    SELF.Liens91_Amount := IF(~suppress_condition, ri.LnJliens[91].Amount, '');
    SELF.Liens91_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[91].ReleaseDate, '');
    SELF.Liens91_DateLastSeen := IF(~suppress_condition, ri.LnJliens[91].DateLastSeen, '');
    SELF.Liens91_FilingNumber := IF(~suppress_condition, ri.LnJliens[91].FilingNumber, '');
    SELF.Liens91_FilingBook := IF(~suppress_condition, ri.LnJliens[91].FilingBook, '');
    SELF.Liens91_FilingPage := IF(~suppress_condition, ri.LnJliens[91].FilingPage, '');
    SELF.Liens91_Agency := IF(~suppress_condition, ri.LnJliens[91].Agency , '');
    SELF.Liens91_AgencyCounty := IF(~suppress_condition, ri.LnJliens[91].AgencyCounty, '');
    SELF.Liens91_AgencyState:= IF(~suppress_condition, ri.LnJliens[91].AgencyState, '');
    SELF.Liens91_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[91].ConsumerStatementId), '');
    SELF.Liens91_orig_rmsid := IF(~suppress_condition, ri.LnJliens[91].orig_rmsid, '');
    SELF.Liens92_Seq:= IF(~suppress_condition, ri.LnJliens[92].Seq, '');
    SELF.Liens92_DateFiled:= IF(~suppress_condition, ri.LnJliens[92].DateFiled, '');
    SELF.Liens92_LienTypeID := IF(~suppress_condition, ri.LnJliens[92].LienTypeID, '');
    SELF.Liens92_LienType := IF(~suppress_condition, ri.LnJliens[92].LienType, '');
    SELF.Liens92_Amount := IF(~suppress_condition, ri.LnJliens[92].Amount, '');
    SELF.Liens92_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[92].ReleaseDate, '');
    SELF.Liens92_DateLastSeen := IF(~suppress_condition, ri.LnJliens[92].DateLastSeen, '');
    SELF.Liens92_FilingNumber := IF(~suppress_condition, ri.LnJliens[92].FilingNumber, '');
    SELF.Liens92_FilingBook := IF(~suppress_condition, ri.LnJliens[92].FilingBook, '');
    SELF.Liens92_FilingPage := IF(~suppress_condition, ri.LnJliens[92].FilingPage, '');
    SELF.Liens92_Agency := IF(~suppress_condition, ri.LnJliens[92].Agency, ''); 
    SELF.Liens92_AgencyCounty := IF(~suppress_condition, ri.LnJliens[92].AgencyCounty, '');
    SELF.Liens92_AgencyState:= IF(~suppress_condition, ri.LnJliens[92].AgencyState, '');
    SELF.Liens92_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[92].ConsumerStatementId), '');
    SELF.Liens92_orig_rmsid := IF(~suppress_condition, ri.LnJliens[92].orig_rmsid, '');
    SELF.Liens93_Seq:= IF(~suppress_condition, ri.LnJliens[93].Seq, '');
    SELF.Liens93_DateFiled:= IF(~suppress_condition, ri.LnJliens[93].DateFiled, '');
    SELF.Liens93_LienTypeID := IF(~suppress_condition, ri.LnJliens[93].LienTypeID, '');
    SELF.Liens93_LienType := IF(~suppress_condition, ri.LnJliens[93].LienType, '');
    SELF.Liens93_Amount := IF(~suppress_condition, ri.LnJliens[93].Amount, '');
    SELF.Liens93_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[93].ReleaseDate, '');
    SELF.Liens93_DateLastSeen := IF(~suppress_condition, ri.LnJliens[93].DateLastSeen, '');
    SELF.Liens93_FilingNumber := IF(~suppress_condition, ri.LnJliens[93].FilingNumber, '');
    SELF.Liens93_FilingBook := IF(~suppress_condition, ri.LnJliens[93].FilingBook, '');
    SELF.Liens93_FilingPage := IF(~suppress_condition, ri.LnJliens[93].FilingPage, ''); 
    SELF.Liens93_Agency := IF(~suppress_condition, ri.LnJliens[93].Agency, ''); 
    SELF.Liens93_AgencyCounty := IF(~suppress_condition, ri.LnJliens[93].AgencyCounty, '');
    SELF.Liens93_AgencyState:= IF(~suppress_condition, ri.LnJliens[93].AgencyState, '');
    SELF.Liens93_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[93].ConsumerStatementId), '');
    SELF.Liens93_orig_rmsid := IF(~suppress_condition, ri.LnJliens[93].orig_rmsid, '');
    SELF.Liens94_Seq:= IF(~suppress_condition, ri.LnJliens[94].Seq, '');
    SELF.Liens94_DateFiled:= IF(~suppress_condition, ri.LnJliens[94].DateFiled, '');
    SELF.Liens94_LienTypeID := IF(~suppress_condition, ri.LnJliens[94].LienTypeID, '');
    SELF.Liens94_LienType := IF(~suppress_condition, ri.LnJliens[94].LienType, '');
    SELF.Liens94_Amount := IF(~suppress_condition, ri.LnJliens[94].Amount, '');
    SELF.Liens94_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[94].ReleaseDate, '');
    SELF.Liens94_DateLastSeen := IF(~suppress_condition, ri.LnJliens[94].DateLastSeen, '');
    SELF.Liens94_FilingNumber := IF(~suppress_condition, ri.LnJliens[94].FilingNumber, '');
    SELF.Liens94_FilingBook := IF(~suppress_condition, ri.LnJliens[94].FilingBook, '');
    SELF.Liens94_FilingPage := IF(~suppress_condition, ri.LnJliens[94].FilingPage, ''); 
    SELF.Liens94_Agency := IF(~suppress_condition, ri.LnJliens[94].Agency, ''); 
    SELF.Liens94_AgencyCounty := IF(~suppress_condition, ri.LnJliens[94].AgencyCounty, '');
    SELF.Liens94_AgencyState:= IF(~suppress_condition, ri.LnJliens[94].AgencyState, '');
    SELF.Liens94_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[94].ConsumerStatementId), '');
    SELF.Liens94_orig_rmsid := IF(~suppress_condition, ri.LnJliens[94].orig_rmsid, '');
    SELF.Liens95_Seq:= IF(~suppress_condition, ri.LnJliens[95].Seq, '');
    SELF.Liens95_DateFiled:= IF(~suppress_condition, ri.LnJliens[95].DateFiled, '');
    SELF.Liens95_LienTypeID := IF(~suppress_condition, ri.LnJliens[95].LienTypeID, '');
    SELF.Liens95_LienType := IF(~suppress_condition, ri.LnJliens[95].LienType , '');
    SELF.Liens95_Amount := IF(~suppress_condition, ri.LnJliens[95].Amount , '');
    SELF.Liens95_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[95].ReleaseDate, '');
    SELF.Liens95_DateLastSeen := IF(~suppress_condition, ri.LnJliens[95].DateLastSeen , '');
    SELF.Liens95_FilingNumber := IF(~suppress_condition, ri.LnJliens[95].FilingNumber , '');
    SELF.Liens95_FilingBook := IF(~suppress_condition, ri.LnJliens[95].FilingBook , '');
    SELF.Liens95_FilingPage := IF(~suppress_condition, ri.LnJliens[95].FilingPage , '');
    SELF.Liens95_Agency := IF(~suppress_condition, ri.LnJliens[95].Agency , '');
    SELF.Liens95_AgencyCounty := IF(~suppress_condition, ri.LnJliens[95].AgencyCounty , '');
    SELF.Liens95_AgencyState:= IF(~suppress_condition, ri.LnJliens[95].AgencyState, '');
    SELF.Liens95_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[95].ConsumerStatementId), '');
    SELF.Liens95_orig_rmsid := IF(~suppress_condition, ri.LnJliens[95].orig_rmsid, '');
    SELF.Liens96_Seq:= IF(~suppress_condition, ri.LnJliens[96].Seq, '');
    SELF.Liens96_DateFiled:= IF(~suppress_condition, ri.LnJliens[96].DateFiled, '');
    SELF.Liens96_LienTypeID := IF(~suppress_condition, ri.LnJliens[96].LienTypeID, '');
    SELF.Liens96_LienType := IF(~suppress_condition, ri.LnJliens[96].LienType , '');
    SELF.Liens96_Amount := IF(~suppress_condition, ri.LnJliens[96].Amount , '');
    SELF.Liens96_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[96].ReleaseDate, '');
    SELF.Liens96_DateLastSeen := IF(~suppress_condition, ri.LnJliens[96].DateLastSeen , '');
    SELF.Liens96_FilingNumber := IF(~suppress_condition, ri.LnJliens[96].FilingNumber , '');
    SELF.Liens96_FilingBook := IF(~suppress_condition, ri.LnJliens[96].FilingBook , '');
    SELF.Liens96_FilingPage := IF(~suppress_condition, ri.LnJliens[96].FilingPage , '');
    SELF.Liens96_Agency := IF(~suppress_condition, ri.LnJliens[96].Agency , '');
    SELF.Liens96_AgencyCounty := IF(~suppress_condition, ri.LnJliens[96].AgencyCounty , '');
    SELF.Liens96_AgencyState:= IF(~suppress_condition, ri.LnJliens[96].AgencyState, '');
    SELF.Liens96_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[96].ConsumerStatementId), '');
    SELF.Liens96_orig_rmsid := IF(~suppress_condition, ri.LnJliens[96].orig_rmsid, '');
    SELF.Liens97_Seq:= IF(~suppress_condition, ri.LnJliens[97].Seq, '');
    SELF.Liens97_DateFiled:= IF(~suppress_condition, ri.LnJliens[97].DateFiled, '');
    SELF.Liens97_LienTypeID := IF(~suppress_condition, ri.LnJliens[97].LienTypeID, '');
    SELF.Liens97_LienType := IF(~suppress_condition, ri.LnJliens[97].LienType , '');
    SELF.Liens97_Amount := IF(~suppress_condition, ri.LnJliens[97].Amount , '');
    SELF.Liens97_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[97].ReleaseDate, '');
    SELF.Liens97_DateLastSeen := IF(~suppress_condition, ri.LnJliens[97].DateLastSeen , '');
    SELF.Liens97_FilingNumber := IF(~suppress_condition, ri.LnJliens[97].FilingNumber , '');
    SELF.Liens97_FilingBook := IF(~suppress_condition, ri.LnJliens[97].FilingBook , '');
    SELF.Liens97_FilingPage := IF(~suppress_condition, ri.LnJliens[97].FilingPage , '');
    SELF.Liens97_Agency := IF(~suppress_condition, ri.LnJliens[97].Agency , '');
    SELF.Liens97_AgencyCounty := IF(~suppress_condition, ri.LnJliens[97].AgencyCounty , '');
    SELF.Liens97_AgencyState:= IF(~suppress_condition, ri.LnJliens[97].AgencyState, '');
    SELF.Liens97_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[97].ConsumerStatementId), '');
    SELF.Liens97_orig_rmsid := IF(~suppress_condition, ri.LnJliens[97].orig_rmsid, '');
    SELF.Liens98_Seq:= IF(~suppress_condition, ri.LnJliens[98].Seq, '');
    SELF.Liens98_DateFiled:= IF(~suppress_condition, ri.LnJliens[98].DateFiled, '');
    SELF.Liens98_LienTypeID := IF(~suppress_condition, ri.LnJliens[98].LienTypeID, '');
    SELF.Liens98_LienType := IF(~suppress_condition, ri.LnJliens[98].LienType , '');
    SELF.Liens98_Amount := IF(~suppress_condition, ri.LnJliens[98].Amount , '');
    SELF.Liens98_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[98].ReleaseDate, '');
    SELF.Liens98_DateLastSeen := IF(~suppress_condition, ri.LnJliens[98].DateLastSeen , '');
    SELF.Liens98_FilingNumber := IF(~suppress_condition, ri.LnJliens[98].FilingNumber , '');
    SELF.Liens98_FilingBook := IF(~suppress_condition, ri.LnJliens[98].FilingBook , '');
    SELF.Liens98_FilingPage := IF(~suppress_condition, ri.LnJliens[98].FilingPage , '');
    SELF.Liens98_Agency := IF(~suppress_condition, ri.LnJliens[98].Agency , '');
    SELF.Liens98_AgencyCounty := IF(~suppress_condition, ri.LnJliens[98].AgencyCounty , '');
    SELF.Liens98_AgencyState:= IF(~suppress_condition, ri.LnJliens[98].AgencyState, '');
    SELF.Liens98_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[98].ConsumerStatementId), '');
    SELF.Liens98_orig_rmsid := IF(~suppress_condition, ri.LnJliens[98].orig_rmsid, '');
    SELF.Liens99_Seq:= IF(~suppress_condition, ri.LnJliens[99].Seq, '');
    SELF.Liens99_DateFiled:= IF(~suppress_condition, ri.LnJliens[99].DateFiled, '');
    SELF.Liens99_LienTypeID := IF(~suppress_condition, ri.LnJliens[99].LienTypeID, '');
    SELF.Liens99_LienType := IF(~suppress_condition, ri.LnJliens[99].LienType , '');
    SELF.Liens99_Amount := IF(~suppress_condition, ri.LnJliens[99].Amount , '');
    SELF.Liens99_ReleaseDate:= IF(~suppress_condition, ri.LnJliens[99].ReleaseDate, '');
    SELF.Liens99_DateLastSeen := IF(~suppress_condition, ri.LnJliens[99].DateLastSeen , '');
    SELF.Liens99_FilingNumber := IF(~suppress_condition, ri.LnJliens[99].FilingNumber , '');
    SELF.Liens99_FilingBook := IF(~suppress_condition, ri.LnJliens[99].FilingBook , '');
    SELF.Liens99_FilingPage := IF(~suppress_condition, ri.LnJliens[99].FilingPage , '');
    SELF.Liens99_Agency := IF(~suppress_condition, ri.LnJliens[99].Agency , '');
    SELF.Liens99_AgencyCounty := IF(~suppress_condition, ri.LnJliens[99].AgencyCounty , '');
    SELF.Liens99_AgencyState:= IF(~suppress_condition, ri.LnJliens[99].AgencyState, '');
    SELF.Liens99_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJliens[99].ConsumerStatementId), '');
    SELF.Liens99_orig_rmsid := IF(~suppress_condition, ri.LnJliens[99].orig_rmsid, '');
    //Jgmts
    SELF.Jgmts1_Seq:= IF(~suppress_condition, ri.LnJJudgments[1].Seq, '');
    SELF.Jgmts1_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[1].DateFiled, '');
    SELF.Jgmts1_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[1].JudgmentTypeID, '');
    SELF.Jgmts1_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[1].JudgmentType, '');
    SELF.Jgmts1_Amount := IF(~suppress_condition, ri.LnJJudgments[1].Amount, '');
    SELF.Jgmts1_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[1].ReleaseDate, '');
    SELF.Jgmts1_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[1].FilingDescription, '');
    SELF.Jgmts1_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[1].DateLastSeen, '');
    SELF.Jgmts1_Defendant:= IF(~suppress_condition, ri.LnJJudgments[1].Defendant, '');
    SELF.Jgmts1_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[1].Plaintiff, '');
    SELF.Jgmts1_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[1].FilingNumber, '');
    SELF.Jgmts1_FilingBook := IF(~suppress_condition, ri.LnJJudgments[1].FilingBook, '');
    SELF.Jgmts1_FilingPage := IF(~suppress_condition, ri.LnJJudgments[1].FilingPage, '');
    SELF.Jgmts1_Eviction := IF(~suppress_condition, ri.LnJJudgments[1].Eviction, '');
    SELF.Jgmts1_Agency := IF(~suppress_condition, ri.LnJJudgments[1].Agency , '');
    SELF.Jgmts1_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[1].AgencyCounty, '');
    SELF.Jgmts1_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[1].AgencyState, '');
    SELF.Jgmts1_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[1].ConsumerStatementId), '');
    SELF.Jgmts1_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[1].orig_rmsid, '');
    SELF.Jgmts2_Seq:= IF(~suppress_condition, ri.LnJJudgments[2].Seq, '');
    SELF.Jgmts2_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[2].DateFiled, '');
    SELF.Jgmts2_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[2].JudgmentTypeID, '');
    SELF.Jgmts2_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[2].JudgmentType, '');
    SELF.Jgmts2_Amount := IF(~suppress_condition, ri.LnJJudgments[2].Amount, '');
    SELF.Jgmts2_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[2].ReleaseDate, '');
    SELF.Jgmts2_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[2].FilingDescription, '');
    SELF.Jgmts2_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[2].DateLastSeen, '');
    SELF.Jgmts2_Defendant:= IF(~suppress_condition, ri.LnJJudgments[2].Defendant, '');
    SELF.Jgmts2_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[2].Plaintiff, '');
    SELF.Jgmts2_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[2].FilingNumber, '');
    SELF.Jgmts2_FilingBook := IF(~suppress_condition, ri.LnJJudgments[2].FilingBook, '');
    SELF.Jgmts2_FilingPage := IF(~suppress_condition, ri.LnJJudgments[2].FilingPage, '');
    SELF.Jgmts2_Eviction := IF(~suppress_condition, ri.LnJJudgments[2].Eviction, ''); 
    SELF.Jgmts2_Agency := IF(~suppress_condition, ri.LnJJudgments[2].Agency, ''); 
    SELF.Jgmts2_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[2].AgencyCounty, '');
    SELF.Jgmts2_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[2].AgencyState, '');
    SELF.Jgmts2_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[2].ConsumerStatementId), '');
    SELF.Jgmts2_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[2].orig_rmsid, '');
    SELF.Jgmts3_Seq:= IF(~suppress_condition, ri.LnJJudgments[3].Seq, '');
    SELF.Jgmts3_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[3].DateFiled, '');
    SELF.Jgmts3_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[3].JudgmentTypeID, '');
    SELF.Jgmts3_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[3].JudgmentType, '');
    SELF.Jgmts3_Amount := IF(~suppress_condition, ri.LnJJudgments[3].Amount, '');
    SELF.Jgmts3_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[3].ReleaseDate, '');
    SELF.Jgmts3_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[3].FilingDescription, '');
    SELF.Jgmts3_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[3].DateLastSeen, '');
    SELF.Jgmts3_Defendant:= IF(~suppress_condition, ri.LnJJudgments[3].Defendant, ''); 
    SELF.Jgmts3_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[3].Plaintiff, '');
    SELF.Jgmts3_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[3].FilingNumber, '');
    SELF.Jgmts3_FilingBook := IF(~suppress_condition, ri.LnJJudgments[3].FilingBook, '');
    SELF.Jgmts3_FilingPage := IF(~suppress_condition, ri.LnJJudgments[3].FilingPage, '');
    SELF.Jgmts3_Eviction := IF(~suppress_condition, ri.LnJJudgments[3].Eviction, '');
    SELF.Jgmts3_Agency := IF(~suppress_condition, ri.LnJJudgments[3].Agency, ''); 
    SELF.Jgmts3_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[3].AgencyCounty, '');
    SELF.Jgmts3_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[3].AgencyState, '');
    SELF.Jgmts3_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[3].ConsumerStatementId), '');
    SELF.Jgmts3_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[3].orig_rmsid, '');
    SELF.Jgmts4_Seq:= IF(~suppress_condition, ri.LnJJudgments[4].Seq, '');
    SELF.Jgmts4_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[4].DateFiled, '');
    SELF.Jgmts4_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[4].JudgmentTypeID, '');
    SELF.Jgmts4_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[4].JudgmentType, '');
    SELF.Jgmts4_Amount := IF(~suppress_condition, ri.LnJJudgments[4].Amount, '');
    SELF.Jgmts4_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[4].releaseDate, '');
    SELF.Jgmts4_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[4].FilingDescription, '');
    SELF.Jgmts4_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[4].DateLastSeen, '');
    SELF.Jgmts4_Defendant:= IF(~suppress_condition, ri.LnJJudgments[4].Defendant, ''); 
    SELF.Jgmts4_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[4].Plaintiff, '');
    SELF.Jgmts4_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[4].FilingNumber, '');
    SELF.Jgmts4_FilingBook := IF(~suppress_condition, ri.LnJJudgments[4].FilingBook, '');
    SELF.Jgmts4_FilingPage := IF(~suppress_condition, ri.LnJJudgments[4].FilingPage, '');
    SELF.Jgmts4_Eviction := IF(~suppress_condition, ri.LnJJudgments[4].Eviction, '');
    SELF.Jgmts4_Agency := IF(~suppress_condition, ri.LnJJudgments[4].Agency, ''); 
    SELF.Jgmts4_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[4].AgencyCounty, '');
    SELF.Jgmts4_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[4].AgencyState, '');
    SELF.Jgmts4_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[4].ConsumerStatementId), '');
    SELF.Jgmts4_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[4].orig_rmsid, '');
    SELF.Jgmts5_Seq:= IF(~suppress_condition, ri.LnJJudgments[5].Seq, '');
    SELF.Jgmts5_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[5].DateFiled, '');
    SELF.Jgmts5_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[5].JudgmentTypeID, '');
    SELF.Jgmts5_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[5].JudgmentType , '');
    SELF.Jgmts5_Amount := IF(~suppress_condition, ri.LnJJudgments[5].Amount , '');
    SELF.Jgmts5_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[5].ReleaseDate, '');
    SELF.Jgmts5_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[5].FilingDescription, '');
    SELF.Jgmts5_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[5].DateLastSeen , '');
    SELF.Jgmts5_Defendant:= IF(~suppress_condition, ri.LnJJudgments[5].Defendant, ''); 
    SELF.Jgmts5_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[5].Plaintiff, '');
    SELF.Jgmts5_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[5].FilingNumber , '');
    SELF.Jgmts5_FilingBook := IF(~suppress_condition, ri.LnJJudgments[5].FilingBook , '');
    SELF.Jgmts5_FilingPage := IF(~suppress_condition, ri.LnJJudgments[5].FilingPage , '');
    SELF.Jgmts5_Eviction := IF(~suppress_condition, ri.LnJJudgments[5].Eviction, '');
    SELF.Jgmts5_Agency := IF(~suppress_condition, ri.LnJJudgments[5].Agency , '');
    SELF.Jgmts5_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[5].AgencyCounty , '');
    SELF.Jgmts5_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[5].AgencyState, '');
    SELF.Jgmts5_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[5].ConsumerStatementId), '');
    SELF.Jgmts5_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[5].orig_rmsid, '');
    SELF.Jgmts6_Seq:= IF(~suppress_condition, ri.LnJJudgments[6].Seq, '');
    SELF.Jgmts6_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[6].DateFiled, '');
    SELF.Jgmts6_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[6].JudgmentTypeID, '');
    SELF.Jgmts6_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[6].JudgmentType , '');
    SELF.Jgmts6_Amount := IF(~suppress_condition, ri.LnJJudgments[6].Amount , '');
    SELF.Jgmts6_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[6].ReleaseDate, '');
    SELF.Jgmts6_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[6].FilingDescription, '');
    SELF.Jgmts6_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[6].DateLastSeen , '');
    SELF.Jgmts6_Defendant:= IF(~suppress_condition, ri.LnJJudgments[6].Defendant, ''); 
    SELF.Jgmts6_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[6].Plaintiff, '');
    SELF.Jgmts6_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[6].FilingNumber , '');
    SELF.Jgmts6_FilingBook := IF(~suppress_condition, ri.LnJJudgments[6].FilingBook , '');
    SELF.Jgmts6_FilingPage := IF(~suppress_condition, ri.LnJJudgments[6].FilingPage , '');
    SELF.Jgmts6_Eviction := IF(~suppress_condition, ri.LnJJudgments[6].Eviction, '');
    SELF.Jgmts6_Agency := IF(~suppress_condition, ri.LnJJudgments[6].Agency , '');
    SELF.Jgmts6_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[6].AgencyCounty , '');
    SELF.Jgmts6_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[6].AgencyState, '');
    SELF.Jgmts6_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[6].ConsumerStatementId), '');
    SELF.Jgmts6_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[6].orig_rmsid, '');
    SELF.Jgmts7_Seq:= IF(~suppress_condition, ri.LnJJudgments[7].Seq, '');
    SELF.Jgmts7_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[7].DateFiled, '');
    SELF.Jgmts7_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[7].JudgmentTypeID, '');
    SELF.Jgmts7_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[7].JudgmentType , '');
    SELF.Jgmts7_Amount := IF(~suppress_condition, ri.LnJJudgments[7].Amount , '');
    SELF.Jgmts7_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[7].ReleaseDate, '');
    SELF.Jgmts7_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[7].FilingDescription, '');
    SELF.Jgmts7_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[7].DateLastSeen , '');
    SELF.Jgmts7_Defendant:= IF(~suppress_condition, ri.LnJJudgments[7].Defendant, ''); 
    SELF.Jgmts7_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[7].Plaintiff, '');
    SELF.Jgmts7_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[7].FilingNumber , '');
    SELF.Jgmts7_FilingBook := IF(~suppress_condition, ri.LnJJudgments[7].FilingBook , '');
    SELF.Jgmts7_FilingPage := IF(~suppress_condition, ri.LnJJudgments[7].FilingPage , '');
    SELF.Jgmts7_Eviction := IF(~suppress_condition, ri.LnJJudgments[7].Eviction, '');
    SELF.Jgmts7_Agency := IF(~suppress_condition, ri.LnJJudgments[7].Agency , '');
    SELF.Jgmts7_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[7].AgencyCounty , '');
    SELF.Jgmts7_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[7].AgencyState, '');
    SELF.Jgmts7_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[7].ConsumerStatementId), '');
    SELF.Jgmts7_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[7].orig_rmsid, '');
    SELF.Jgmts8_Seq:= IF(~suppress_condition, ri.LnJJudgments[8].Seq, '');
    SELF.Jgmts8_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[8].DateFiled, '');
    SELF.Jgmts8_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[8].JudgmentTypeID, '');
    SELF.Jgmts8_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[8].JudgmentType , '');
    SELF.Jgmts8_Amount := IF(~suppress_condition, ri.LnJJudgments[8].Amount , '');
    SELF.Jgmts8_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[8].ReleaseDate, '');
    SELF.Jgmts8_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[8].FilingDescription, '');
    SELF.Jgmts8_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[8].DateLastSeen , '');
    SELF.Jgmts8_Defendant:= IF(~suppress_condition, ri.LnJJudgments[8].Defendant, ''); 
    SELF.Jgmts8_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[8].Plaintiff, '');
    SELF.Jgmts8_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[8].FilingNumber , '');
    SELF.Jgmts8_FilingBook := IF(~suppress_condition, ri.LnJJudgments[8].FilingBook , '');
    SELF.Jgmts8_FilingPage := IF(~suppress_condition, ri.LnJJudgments[8].FilingPage , '');
    SELF.Jgmts8_Eviction := IF(~suppress_condition, ri.LnJJudgments[8].Eviction, '');
    SELF.Jgmts8_Agency := IF(~suppress_condition, ri.LnJJudgments[8].Agency , '');
    SELF.Jgmts8_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[8].AgencyCounty , '');
    SELF.Jgmts8_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[8].AgencyState, '');
    SELF.Jgmts8_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[8].ConsumerStatementId), '');
    SELF.Jgmts8_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[8].orig_rmsid, '');
    SELF.Jgmts9_Seq:= IF(~suppress_condition, ri.LnJJudgments[9].Seq, '');
    SELF.Jgmts9_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[9].DateFiled, '');
    SELF.Jgmts9_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[9].JudgmentTypeID, '');
    SELF.Jgmts9_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[9].JudgmentType , '');
    SELF.Jgmts9_Amount := IF(~suppress_condition, ri.LnJJudgments[9].Amount , '');
    SELF.Jgmts9_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[9].ReleaseDate, '');
    SELF.Jgmts9_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[9].FilingDescription, '');
    SELF.Jgmts9_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[9].DateLastSeen , '');
    SELF.Jgmts9_Defendant:= IF(~suppress_condition, ri.LnJJudgments[9].Defendant, ''); 
    SELF.Jgmts9_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[9].Plaintiff, '');
    SELF.Jgmts9_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[9].FilingNumber , '');
    SELF.Jgmts9_FilingBook := IF(~suppress_condition, ri.LnJJudgments[9].FilingBook , '');
    SELF.Jgmts9_FilingPage := IF(~suppress_condition, ri.LnJJudgments[9].FilingPage , '');
    SELF.Jgmts9_Eviction := IF(~suppress_condition, ri.LnJJudgments[9].Eviction, '');
    SELF.Jgmts9_Agency := IF(~suppress_condition, ri.LnJJudgments[9].Agency , '');
    SELF.Jgmts9_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[9].AgencyCounty , '');
    SELF.Jgmts9_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[9].AgencyState, '');
    SELF.Jgmts9_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[9].ConsumerStatementId), '');
    SELF.Jgmts9_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[9].orig_rmsid, '');
    SELF.Jgmts10_Seq:= IF(~suppress_condition, ri.LnJJudgments[10].Seq , '');
    SELF.Jgmts10_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[10].DateFiled , '');
    SELF.Jgmts10_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[10].JudgmentTypeID, '');
    SELF.Jgmts10_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[10].JudgmentType, '');
    SELF.Jgmts10_Amount := IF(~suppress_condition, ri.LnJJudgments[10].Amount, '');
    SELF.Jgmts10_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[10].ReleaseDate , '');
    SELF.Jgmts10_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[10].FilingDescription, '');
    SELF.Jgmts10_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[10].DateLastSeen, '');
    SELF.Jgmts10_Defendant:= IF(~suppress_condition, ri.LnJJudgments[10].Defendant, ''); 
    SELF.Jgmts10_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[10].Plaintiff, '');
    SELF.Jgmts10_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[10].FilingNumber, '');
    SELF.Jgmts10_FilingBook := IF(~suppress_condition, ri.LnJJudgments[10].FilingBook, '');
    SELF.Jgmts10_FilingPage := IF(~suppress_condition, ri.LnJJudgments[10].FilingPage, '');
    SELF.Jgmts10_Eviction := IF(~suppress_condition, ri.LnJJudgments[10].Eviction, '');
    SELF.Jgmts10_Agency := IF(~suppress_condition, ri.LnJJudgments[10].Agency, '');
    SELF.Jgmts10_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[10].AgencyCounty, '');
    SELF.Jgmts10_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[10].AgencyState , '');
    SELF.Jgmts10_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[10].ConsumerStatementId), '');
    SELF.Jgmts10_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[10].orig_rmsid, '');
    SELF.Jgmts11_Seq:= IF(~suppress_condition, ri.LnJJudgments[11].Seq, '');
    SELF.Jgmts11_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[11].DateFiled, '');
    SELF.Jgmts11_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[11].JudgmentTypeID, '');
    SELF.Jgmts11_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[11].JudgmentType, '');
    SELF.Jgmts11_Amount := IF(~suppress_condition, ri.LnJJudgments[11].Amount, '');
    SELF.Jgmts11_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[11].ReleaseDate , ''); 
    SELF.Jgmts11_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[11].FilingDescription, '');
    SELF.Jgmts11_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[11].DateLastSeen, '');
    SELF.Jgmts11_Defendant:= IF(~suppress_condition, ri.LnJJudgments[11].Defendant, '');
    SELF.Jgmts11_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[11].Plaintiff, '');
    SELF.Jgmts11_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[11].FilingNumber, '');
    SELF.Jgmts11_FilingBook := IF(~suppress_condition, ri.LnJJudgments[11].FilingBook, '');
    SELF.Jgmts11_FilingPage := IF(~suppress_condition, ri.LnJJudgments[11].FilingPage, '');
    SELF.Jgmts11_Eviction := IF(~suppress_condition, ri.LnJJudgments[11].Eviction, '');
    SELF.Jgmts11_Agency := IF(~suppress_condition, ri.LnJJudgments[11].Agency , '');
    SELF.Jgmts11_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[11].AgencyCounty, '');
    SELF.Jgmts11_AgencyState := IF(~suppress_condition, ri.LnJJudgments[11].AgencyState, '');
    SELF.Jgmts11_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[11].ConsumerStatementId), '');
    SELF.Jgmts11_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[11].orig_rmsid, '');
    SELF.Jgmts12_Seq:= IF(~suppress_condition, ri.LnJJudgments[12].Seq, '');
    SELF.Jgmts12_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[12].DateFiled, '');
    SELF.Jgmts12_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[12].JudgmentTypeID, '');
    SELF.Jgmts12_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[12].JudgmentType, '');
    SELF.Jgmts12_Amount := IF(~suppress_condition, ri.LnJJudgments[12].Amount, '');
    SELF.Jgmts12_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[12].ReleaseDate , '');
    SELF.Jgmts12_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[12].FilingDescription, '');
    SELF.Jgmts12_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[12].DateLastSeen, '');
    SELF.Jgmts12_Defendant:= IF(~suppress_condition, ri.LnJJudgments[12].Defendant, '');
    SELF.Jgmts12_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[12].Plaintiff, '');
    SELF.Jgmts12_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[12].FilingNumber, '');
    SELF.Jgmts12_FilingBook := IF(~suppress_condition, ri.LnJJudgments[12].FilingBook, '');
    SELF.Jgmts12_FilingPage := IF(~suppress_condition, ri.LnJJudgments[12].FilingPage, '');
    SELF.Jgmts12_Eviction := IF(~suppress_condition, ri.LnJJudgments[12].Eviction, ''); 
    SELF.Jgmts12_Agency := IF(~suppress_condition, ri.LnJJudgments[12].Agency, ''); 
    SELF.Jgmts12_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[12].AgencyCounty, '');
    SELF.Jgmts12_AgencyState := IF(~suppress_condition, ri.LnJJudgments[12].AgencyState, '');
    SELF.Jgmts12_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[12].ConsumerStatementId), '');
    SELF.Jgmts12_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[12].orig_rmsid, '');
    SELF.Jgmts13_Seq:= IF(~suppress_condition, ri.LnJJudgments[13].Seq, '');
    SELF.Jgmts13_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[13].DateFiled, '');
    SELF.Jgmts13_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[13].JudgmentTypeID, '');
    SELF.Jgmts13_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[13].JudgmentType, '');
    SELF.Jgmts13_Amount := IF(~suppress_condition, ri.LnJJudgments[13].Amount, '');
    SELF.Jgmts13_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[13].ReleaseDate , '');
    SELF.Jgmts13_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[13].FilingDescription, '');
    SELF.Jgmts13_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[13].DateLastSeen, '');
    SELF.Jgmts13_Defendant:= IF(~suppress_condition, ri.LnJJudgments[13].Defendant, '');
    SELF.Jgmts13_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[13].Plaintiff, '');
    SELF.Jgmts13_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[13].FilingNumber, '');
    SELF.Jgmts13_FilingBook := IF(~suppress_condition, ri.LnJJudgments[13].FilingBook, '');
    SELF.Jgmts13_FilingPage := IF(~suppress_condition, ri.LnJJudgments[13].FilingPage, '');
    SELF.Jgmts13_Eviction := IF(~suppress_condition, ri.LnJJudgments[13].Eviction, '');
    SELF.Jgmts13_Agency := IF(~suppress_condition, ri.LnJJudgments[13].Agency, ''); 
    SELF.Jgmts13_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[13].AgencyCounty, '');
    SELF.Jgmts13_AgencyState := IF(~suppress_condition, ri.LnJJudgments[13].AgencyState, '');
    SELF.Jgmts13_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[13].ConsumerStatementId), '');
    SELF.Jgmts13_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[13].orig_rmsid, '');
    SELF.Jgmts14_Seq:= IF(~suppress_condition, ri.LnJJudgments[14].Seq, '');
    SELF.Jgmts14_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[14].DateFiled, '');
    SELF.Jgmts14_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[14].JudgmentTypeID, '');
    SELF.Jgmts14_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[14].JudgmentType, '');
    SELF.Jgmts14_Amount := IF(~suppress_condition, ri.LnJJudgments[14].Amount, '');
    SELF.Jgmts14_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[14].ReleaseDate , ''); 
    SELF.Jgmts14_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[14].FilingDescription, '');
    SELF.Jgmts14_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[14].DateLastSeen, '');
    SELF.Jgmts14_Defendant:= IF(~suppress_condition, ri.LnJJudgments[14].Defendant, '');
    SELF.Jgmts14_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[14].Plaintiff, '');
    SELF.Jgmts14_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[14].FilingNumber, '');
    SELF.Jgmts14_FilingBook := IF(~suppress_condition, ri.LnJJudgments[14].FilingBook, '');
    SELF.Jgmts14_FilingPage := IF(~suppress_condition, ri.LnJJudgments[14].FilingPage, '');
    SELF.Jgmts14_Eviction := IF(~suppress_condition, ri.LnJJudgments[14].Eviction, '');
    SELF.Jgmts14_Agency := IF(~suppress_condition, ri.LnJJudgments[14].Agency, '');
    SELF.Jgmts14_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[14].AgencyCounty, '');
    SELF.Jgmts14_AgencyState := IF(~suppress_condition, ri.LnJJudgments[14].AgencyState, '');
    SELF.Jgmts14_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[14].ConsumerStatementId), '');
    SELF.Jgmts14_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[14].orig_rmsid, '');
    SELF.Jgmts15_Seq:= IF(~suppress_condition, ri.LnJJudgments[15].Seq, '');
    SELF.Jgmts15_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[15].DateFiled, '');
    SELF.Jgmts15_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[15].JudgmentTypeID, '');
    SELF.Jgmts15_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[15].JudgmentType , '');
    SELF.Jgmts15_Amount := IF(~suppress_condition, ri.LnJJudgments[15].Amount , '');
    SELF.Jgmts15_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[15].ReleaseDate , ''); 
    SELF.Jgmts15_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[15].FilingDescription, '');
    SELF.Jgmts15_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[15].DateLastSeen, '');
    SELF.Jgmts15_Defendant:= IF(~suppress_condition, ri.LnJJudgments[15].Defendant, '');
    SELF.Jgmts15_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[15].Plaintiff, '');
    SELF.Jgmts15_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[15].FilingNumber , '');
    SELF.Jgmts15_FilingBook := IF(~suppress_condition, ri.LnJJudgments[15].FilingBook , '');
    SELF.Jgmts15_FilingPage := IF(~suppress_condition, ri.LnJJudgments[15].FilingPage, '');
    SELF.Jgmts15_Eviction := IF(~suppress_condition, ri.LnJJudgments[15].Eviction, '');
    SELF.Jgmts15_Agency := IF(~suppress_condition, ri.LnJJudgments[15].Agency , '');
    SELF.Jgmts15_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[15].AgencyCounty , '');
    SELF.Jgmts15_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[15].AgencyState, '');
    SELF.Jgmts15_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[15].ConsumerStatementId), '');
    SELF.Jgmts15_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[15].orig_rmsid, '');
    SELF.Jgmts16_Seq:= IF(~suppress_condition, ri.LnJJudgments[16].Seq, '');
    SELF.Jgmts16_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[16].DateFiled, '');
    SELF.Jgmts16_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[16].JudgmentTypeID, '');
    SELF.Jgmts16_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[16].JudgmentType , '');
    SELF.Jgmts16_Amount := IF(~suppress_condition, ri.LnJJudgments[16].Amount , '');
    SELF.Jgmts16_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[16].ReleaseDate , ''); 
    SELF.Jgmts16_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[16].FilingDescription, '');
    SELF.Jgmts16_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[16].DateLastSeen, '');
    SELF.Jgmts16_Defendant:= IF(~suppress_condition, ri.LnJJudgments[16].Defendant, '');
    SELF.Jgmts16_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[16].Plaintiff, '');
    SELF.Jgmts16_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[16].FilingNumber , '');
    SELF.Jgmts16_FilingBook := IF(~suppress_condition, ri.LnJJudgments[16].FilingBook , '');
    SELF.Jgmts16_FilingPage := IF(~suppress_condition, ri.LnJJudgments[16].FilingPage, '');
    SELF.Jgmts16_Eviction := IF(~suppress_condition, ri.LnJJudgments[16].Eviction, '');
    SELF.Jgmts16_Agency := IF(~suppress_condition, ri.LnJJudgments[16].Agency , '');
    SELF.Jgmts16_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[16].AgencyCounty , '');
    SELF.Jgmts16_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[16].AgencyState, '');
    SELF.Jgmts16_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[16].ConsumerStatementId), '');
    SELF.Jgmts16_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[16].orig_rmsid, '');
    SELF.Jgmts17_Seq:= IF(~suppress_condition, ri.LnJJudgments[17].Seq, '');
    SELF.Jgmts17_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[17].DateFiled, '');
    SELF.Jgmts17_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[17].JudgmentTypeID, '');
    SELF.Jgmts17_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[17].JudgmentType , '');
    SELF.Jgmts17_Amount := IF(~suppress_condition, ri.LnJJudgments[17].Amount , '');
    SELF.Jgmts17_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[17].ReleaseDate , ''); 
    SELF.Jgmts17_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[17].FilingDescription, '');
    SELF.Jgmts17_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[17].DateLastSeen, '');
    SELF.Jgmts17_Defendant:= IF(~suppress_condition, ri.LnJJudgments[17].Defendant, '');
    SELF.Jgmts17_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[17].Plaintiff, '');
    SELF.Jgmts17_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[17].FilingNumber , '');
    SELF.Jgmts17_FilingBook := IF(~suppress_condition, ri.LnJJudgments[17].FilingBook , '');
    SELF.Jgmts17_FilingPage := IF(~suppress_condition, ri.LnJJudgments[17].FilingPage, '');
    SELF.Jgmts17_Eviction := IF(~suppress_condition, ri.LnJJudgments[17].Eviction, '');
    SELF.Jgmts17_Agency := IF(~suppress_condition, ri.LnJJudgments[17].Agency , '');
    SELF.Jgmts17_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[17].AgencyCounty , '');
    SELF.Jgmts17_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[17].AgencyState, '');
    SELF.Jgmts17_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[17].ConsumerStatementId), '');
    SELF.Jgmts17_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[17].orig_rmsid, '');
    SELF.Jgmts18_Seq:= IF(~suppress_condition, ri.LnJJudgments[18].Seq, '');
    SELF.Jgmts18_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[18].DateFiled, '');
    SELF.Jgmts18_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[18].JudgmentTypeID, '');
    SELF.Jgmts18_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[18].JudgmentType , '');
    SELF.Jgmts18_Amount := IF(~suppress_condition, ri.LnJJudgments[18].Amount , '');
    SELF.Jgmts18_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[18].ReleaseDate , '');
    SELF.Jgmts18_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[18].FilingDescription, '');
    SELF.Jgmts18_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[18].DateLastSeen, '');
    SELF.Jgmts18_Defendant:= IF(~suppress_condition, ri.LnJJudgments[18].Defendant, '');
    SELF.Jgmts18_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[18].Plaintiff, '');
    SELF.Jgmts18_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[18].FilingNumber , '');
    SELF.Jgmts18_FilingBook := IF(~suppress_condition, ri.LnJJudgments[18].FilingBook , '');
    SELF.Jgmts18_FilingPage := IF(~suppress_condition, ri.LnJJudgments[18].FilingPage, '');
    SELF.Jgmts18_Eviction := IF(~suppress_condition, ri.LnJJudgments[18].Eviction, '');
    SELF.Jgmts18_Agency := IF(~suppress_condition, ri.LnJJudgments[18].Agency , '');
    SELF.Jgmts18_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[18].AgencyCounty , '');
    SELF.Jgmts18_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[18].AgencyState, '');
    SELF.Jgmts18_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[18].ConsumerStatementId), '');
    SELF.Jgmts18_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[18].orig_rmsid, '');
    SELF.Jgmts19_Seq:= IF(~suppress_condition, ri.LnJJudgments[19].Seq, '');
    SELF.Jgmts19_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[19].DateFiled, '');
    SELF.Jgmts19_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[19].JudgmentTypeID, '');
    SELF.Jgmts19_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[19].JudgmentType , '');
    SELF.Jgmts19_Amount := IF(~suppress_condition, ri.LnJJudgments[19].Amount , '');
    SELF.Jgmts19_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[19].ReleaseDate , ''); 
    SELF.Jgmts19_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[19].FilingDescription, '');
    SELF.Jgmts19_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[19].DateLastSeen, '');
    SELF.Jgmts19_Defendant:= IF(~suppress_condition, ri.LnJJudgments[19].Defendant, '');
    SELF.Jgmts19_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[19].Plaintiff, '');
    SELF.Jgmts19_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[19].FilingNumber , '');
    SELF.Jgmts19_FilingBook := IF(~suppress_condition, ri.LnJJudgments[19].FilingBook , '');
    SELF.Jgmts19_FilingPage := IF(~suppress_condition, ri.LnJJudgments[19].FilingPage, '');
    SELF.Jgmts19_Eviction := IF(~suppress_condition, ri.LnJJudgments[19].Eviction, '');
    SELF.Jgmts19_Agency := IF(~suppress_condition, ri.LnJJudgments[19].Agency , '');
    SELF.Jgmts19_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[19].AgencyCounty , '');
    SELF.Jgmts19_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[19].AgencyState, '');
    SELF.Jgmts19_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[19].ConsumerStatementId), '');
    SELF.Jgmts19_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[19].orig_rmsid, '');
    SELF.Jgmts20_Seq:= IF(~suppress_condition, ri.LnJJudgments[20].Seq , '');
    SELF.Jgmts20_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[20].DateFiled , '');
    SELF.Jgmts20_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[20].JudgmentTypeID, '');
    SELF.Jgmts20_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[20].JudgmentType, '');
    SELF.Jgmts20_Amount := IF(~suppress_condition, ri.LnJJudgments[20].Amount, '');
    SELF.Jgmts20_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[20].ReleaseDate , ''); 
    SELF.Jgmts20_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[20].FilingDescription, '');
    SELF.Jgmts20_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[20].DateLastSeen, '');
    SELF.Jgmts20_Defendant:= IF(~suppress_condition, ri.LnJJudgments[20].Defendant, '');
    SELF.Jgmts20_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[20].Plaintiff, '');
    SELF.Jgmts20_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[20].FilingNumber, '');
    SELF.Jgmts20_FilingBook := IF(~suppress_condition, ri.LnJJudgments[20].FilingBook, '');
    SELF.Jgmts20_FilingPage := IF(~suppress_condition, ri.LnJJudgments[20].FilingPage, '');
    SELF.Jgmts20_Eviction := IF(~suppress_condition, ri.LnJJudgments[20].Eviction, '');
    SELF.Jgmts20_Agency := IF(~suppress_condition, ri.LnJJudgments[20].Agency, '');
    SELF.Jgmts20_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[20].AgencyCounty, '');
    SELF.Jgmts20_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[20].AgencyState , '');
    SELF.Jgmts20_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[20].ConsumerStatementId), '');
    SELF.Jgmts20_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[20].orig_rmsid, '');
    SELF.Jgmts21_Seq:= IF(~suppress_condition, ri.LnJJudgments[21].Seq , '');
    SELF.Jgmts21_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[21].DateFiled , '');
    SELF.Jgmts21_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[21].JudgmentTypeID, '');
    SELF.Jgmts21_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[21].JudgmentType, '');
    SELF.Jgmts21_Amount := IF(~suppress_condition, ri.LnJJudgments[21].Amount, '');
    SELF.Jgmts21_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[21].ReleaseDate , ''); 
    SELF.Jgmts21_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[21].FilingDescription, '');
    SELF.Jgmts21_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[21].DateLastSeen, '');
    SELF.Jgmts21_Defendant:= IF(~suppress_condition, ri.LnJJudgments[21].Defendant, '');
    SELF.Jgmts21_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[21].Plaintiff, '');
    SELF.Jgmts21_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[21].FilingNumber, '');
    SELF.Jgmts21_FilingBook := IF(~suppress_condition, ri.LnJJudgments[21].FilingBook, '');
    SELF.Jgmts21_FilingPage := IF(~suppress_condition, ri.LnJJudgments[21].FilingPage, '');
    SELF.Jgmts21_Eviction := IF(~suppress_condition, ri.LnJJudgments[21].Eviction, '');
    SELF.Jgmts21_Agency := IF(~suppress_condition, ri.LnJJudgments[21].Agency, '');
    SELF.Jgmts21_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[21].AgencyCounty, '');
    SELF.Jgmts21_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[21].AgencyState , '');
    SELF.Jgmts21_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[21].ConsumerStatementId), '');
    SELF.Jgmts21_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[21].orig_rmsid, '');
    SELF.Jgmts22_Seq:= IF(~suppress_condition, ri.LnJJudgments[22].Seq , '');
    SELF.Jgmts22_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[22].DateFiled , '');
    SELF.Jgmts22_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[22].JudgmentTypeID, '');
    SELF.Jgmts22_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[22].JudgmentType, '');
    SELF.Jgmts22_Amount := IF(~suppress_condition, ri.LnJJudgments[22].Amount, '');
    SELF.Jgmts22_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[22].ReleaseDate , '');
    SELF.Jgmts22_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[22].FilingDescription, '');
    SELF.Jgmts22_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[22].DateLastSeen, '');
    SELF.Jgmts22_Defendant:= IF(~suppress_condition, ri.LnJJudgments[22].Defendant, '');
    SELF.Jgmts22_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[22].Plaintiff, '');
    SELF.Jgmts22_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[22].FilingNumber, '');
    SELF.Jgmts22_FilingBook := IF(~suppress_condition, ri.LnJJudgments[22].FilingBook, '');
    SELF.Jgmts22_FilingPage := IF(~suppress_condition, ri.LnJJudgments[22].FilingPage, '');
    SELF.Jgmts22_Eviction := IF(~suppress_condition, ri.LnJJudgments[22].Eviction, '');
    SELF.Jgmts22_Agency := IF(~suppress_condition, ri.LnJJudgments[22].Agency, '');
    SELF.Jgmts22_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[22].AgencyCounty, '');
    SELF.Jgmts22_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[22].AgencyState , '');
    SELF.Jgmts22_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[22].ConsumerStatementId), '');
    SELF.Jgmts22_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[22].orig_rmsid, '');
    SELF.Jgmts23_Seq:= IF(~suppress_condition, ri.LnJJudgments[23].Seq , '');
    SELF.Jgmts23_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[23].DateFiled , '');
    SELF.Jgmts23_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[23].JudgmentTypeID, '');
    SELF.Jgmts23_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[23].JudgmentType, '');
    SELF.Jgmts23_Amount := IF(~suppress_condition, ri.LnJJudgments[23].Amount, '');
    SELF.Jgmts23_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[23].ReleaseDate , ''); 
    SELF.Jgmts23_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[23].FilingDescription, '');
    SELF.Jgmts23_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[23].DateLastSeen, '');
    SELF.Jgmts23_Defendant:= IF(~suppress_condition, ri.LnJJudgments[23].Defendant, '');
    SELF.Jgmts23_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[23].Plaintiff, '');
    SELF.Jgmts23_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[23].FilingNumber, '');
    SELF.Jgmts23_FilingBook := IF(~suppress_condition, ri.LnJJudgments[23].FilingBook, '');
    SELF.Jgmts23_FilingPage := IF(~suppress_condition, ri.LnJJudgments[23].FilingPage, '');
    SELF.Jgmts23_Eviction := IF(~suppress_condition, ri.LnJJudgments[23].Eviction, '');
    SELF.Jgmts23_Agency := IF(~suppress_condition, ri.LnJJudgments[23].Agency, '');
    SELF.Jgmts23_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[23].AgencyCounty, '');
    SELF.Jgmts23_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[23].AgencyState , '');
    SELF.Jgmts23_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[23].ConsumerStatementId), '');
    SELF.Jgmts23_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[23].orig_rmsid, '');
    SELF.Jgmts24_Seq:= IF(~suppress_condition, ri.LnJJudgments[24].Seq , '');
    SELF.Jgmts24_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[24].DateFiled , '');
    SELF.Jgmts24_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[24].JudgmentTypeID, '');
    SELF.Jgmts24_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[24].JudgmentType, '');
    SELF.Jgmts24_Amount := IF(~suppress_condition, ri.LnJJudgments[24].Amount, '');
    SELF.Jgmts24_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[24].ReleaseDate , ''); 
    SELF.Jgmts24_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[24].FilingDescription, '');
    SELF.Jgmts24_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[24].DateLastSeen, '');
    SELF.Jgmts24_Defendant:= IF(~suppress_condition, ri.LnJJudgments[24].Defendant, '');
    SELF.Jgmts24_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[24].Plaintiff, '');
    SELF.Jgmts24_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[24].FilingNumber, '');
    SELF.Jgmts24_FilingBook := IF(~suppress_condition, ri.LnJJudgments[24].FilingBook, '');
    SELF.Jgmts24_FilingPage := IF(~suppress_condition, ri.LnJJudgments[24].FilingPage, '');
    SELF.Jgmts24_Eviction := IF(~suppress_condition, ri.LnJJudgments[24].Eviction, '');
    SELF.Jgmts24_Agency := IF(~suppress_condition, ri.LnJJudgments[24].Agency, '');
    SELF.Jgmts24_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[24].AgencyCounty, '');
    SELF.Jgmts24_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[24].AgencyState , '');
    SELF.Jgmts24_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[24].ConsumerStatementId), '');
    SELF.Jgmts24_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[24].orig_rmsid, '');
    SELF.Jgmts25_Seq:= IF(~suppress_condition, ri.LnJJudgments[25].Seq , '');
    SELF.Jgmts25_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[25].DateFiled , '');
    SELF.Jgmts25_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[25].JudgmentTypeID, '');
    SELF.Jgmts25_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[25].JudgmentType, '');
    SELF.Jgmts25_Amount := IF(~suppress_condition, ri.LnJJudgments[25].Amount, '');
    SELF.Jgmts25_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[25].ReleaseDate , ''); 
    SELF.Jgmts25_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[25].FilingDescription, '');
    SELF.Jgmts25_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[25].DateLastSeen, '');
    SELF.Jgmts25_Defendant:= IF(~suppress_condition, ri.LnJJudgments[25].Defendant, '');
    SELF.Jgmts25_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[25].Plaintiff, '');
    SELF.Jgmts25_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[25].FilingNumber, '');
    SELF.Jgmts25_FilingBook := IF(~suppress_condition, ri.LnJJudgments[25].FilingBook, '');
    SELF.Jgmts25_FilingPage := IF(~suppress_condition, ri.LnJJudgments[25].FilingPage, '');
    SELF.Jgmts25_Eviction := IF(~suppress_condition, ri.LnJJudgments[25].Eviction, '');
    SELF.Jgmts25_Agency := IF(~suppress_condition, ri.LnJJudgments[25].Agency, '');
    SELF.Jgmts25_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[25].AgencyCounty, '');
    SELF.Jgmts25_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[25].AgencyState , '');
    SELF.Jgmts25_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[25].ConsumerStatementId), '');
    SELF.Jgmts25_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[25].orig_rmsid, '');
    SELF.Jgmts26_Seq:= IF(~suppress_condition, ri.LnJJudgments[26].Seq , '');
    SELF.Jgmts26_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[26].DateFiled , '');
    SELF.Jgmts26_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[26].JudgmentTypeID, '');
    SELF.Jgmts26_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[26].JudgmentType, '');
    SELF.Jgmts26_Amount := IF(~suppress_condition, ri.LnJJudgments[26].Amount, '');
    SELF.Jgmts26_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[26].ReleaseDate , '');
    SELF.Jgmts26_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[26].FilingDescription, '');
    SELF.Jgmts26_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[26].DateLastSeen, '');
    SELF.Jgmts26_Defendant:= IF(~suppress_condition, ri.LnJJudgments[26].Defendant, '');
    SELF.Jgmts26_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[26].Plaintiff, '');
    SELF.Jgmts26_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[26].FilingNumber, '');
    SELF.Jgmts26_FilingBook := IF(~suppress_condition, ri.LnJJudgments[26].FilingBook, '');
    SELF.Jgmts26_FilingPage := IF(~suppress_condition, ri.LnJJudgments[26].FilingPage, '');
    SELF.Jgmts26_Eviction := IF(~suppress_condition, ri.LnJJudgments[26].Eviction, '');
    SELF.Jgmts26_Agency := IF(~suppress_condition, ri.LnJJudgments[26].Agency, '');
    SELF.Jgmts26_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[26].AgencyCounty, '');
    SELF.Jgmts26_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[26].AgencyState , '');
    SELF.Jgmts26_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[26].ConsumerStatementId), '');
    SELF.Jgmts26_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[26].orig_rmsid, '');
    SELF.Jgmts27_Seq:= IF(~suppress_condition, ri.LnJJudgments[27].Seq , '');
    SELF.Jgmts27_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[27].DateFiled , '');
    SELF.Jgmts27_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[27].JudgmentTypeID, '');
    SELF.Jgmts27_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[27].JudgmentType, '');
    SELF.Jgmts27_Amount := IF(~suppress_condition, ri.LnJJudgments[27].Amount, '');
    SELF.Jgmts27_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[27].ReleaseDate , '');
    SELF.Jgmts27_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[27].FilingDescription, '');
    SELF.Jgmts27_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[27].DateLastSeen, '');
    SELF.Jgmts27_Defendant:= IF(~suppress_condition, ri.LnJJudgments[27].Defendant, '');
    SELF.Jgmts27_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[27].Plaintiff, '');
    SELF.Jgmts27_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[27].FilingNumber, '');
    SELF.Jgmts27_FilingBook := IF(~suppress_condition, ri.LnJJudgments[27].FilingBook, '');
    SELF.Jgmts27_FilingPage := IF(~suppress_condition, ri.LnJJudgments[27].FilingPage, '');
    SELF.Jgmts27_Eviction := IF(~suppress_condition, ri.LnJJudgments[27].Eviction, '');
    SELF.Jgmts27_Agency := IF(~suppress_condition, ri.LnJJudgments[27].Agency, '');
    SELF.Jgmts27_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[27].AgencyCounty, '');
    SELF.Jgmts27_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[27].AgencyState , '');
    SELF.Jgmts27_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[27].ConsumerStatementId), '');
    SELF.Jgmts27_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[27].orig_rmsid, '');
    SELF.Jgmts28_Seq:= IF(~suppress_condition, ri.LnJJudgments[28].Seq , '');
    SELF.Jgmts28_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[28].DateFiled , '');
    SELF.Jgmts28_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[28].JudgmentTypeID, '');
    SELF.Jgmts28_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[28].JudgmentType, '');
    SELF.Jgmts28_Amount := IF(~suppress_condition, ri.LnJJudgments[28].Amount, '');
    SELF.Jgmts28_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[28].ReleaseDate , ''); 
    SELF.Jgmts28_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[28].FilingDescription, '');
    SELF.Jgmts28_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[28].DateLastSeen, '');
    SELF.Jgmts28_Defendant:= IF(~suppress_condition, ri.LnJJudgments[28].Defendant, '');
    SELF.Jgmts28_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[28].Plaintiff, '');
    SELF.Jgmts28_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[28].FilingNumber, '');
    SELF.Jgmts28_FilingBook := IF(~suppress_condition, ri.LnJJudgments[28].FilingBook, '');
    SELF.Jgmts28_FilingPage := IF(~suppress_condition, ri.LnJJudgments[28].FilingPage, '');
    SELF.Jgmts28_Eviction := IF(~suppress_condition, ri.LnJJudgments[28].Eviction, '');
    SELF.Jgmts28_Agency := IF(~suppress_condition, ri.LnJJudgments[28].Agency, '');
    SELF.Jgmts28_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[28].AgencyCounty, '');
    SELF.Jgmts28_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[28].AgencyState , '');
    SELF.Jgmts28_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[28].ConsumerStatementId), '');
    SELF.Jgmts28_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[28].orig_rmsid, '');
    SELF.Jgmts29_Seq:= IF(~suppress_condition, ri.LnJJudgments[29].Seq , '');
    SELF.Jgmts29_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[29].DateFiled , '');
    SELF.Jgmts29_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[29].JudgmentTypeID, '');
    SELF.Jgmts29_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[29].JudgmentType, '');
    SELF.Jgmts29_Amount := IF(~suppress_condition, ri.LnJJudgments[29].Amount, '');
    SELF.Jgmts29_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[29].ReleaseDate , ''); 
    SELF.Jgmts29_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[29].FilingDescription, '');
    SELF.Jgmts29_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[29].DateLastSeen, '');
    SELF.Jgmts29_Defendant:= IF(~suppress_condition, ri.LnJJudgments[29].Defendant, '');
    SELF.Jgmts29_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[29].Plaintiff, '');
    SELF.Jgmts29_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[29].FilingNumber, '');
    SELF.Jgmts29_FilingBook := IF(~suppress_condition, ri.LnJJudgments[29].FilingBook, '');
    SELF.Jgmts29_FilingPage := IF(~suppress_condition, ri.LnJJudgments[29].FilingPage, '');
    SELF.Jgmts29_Eviction := IF(~suppress_condition, ri.LnJJudgments[29].Eviction, '');
    SELF.Jgmts29_Agency := IF(~suppress_condition, ri.LnJJudgments[29].Agency, '');
    SELF.Jgmts29_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[29].AgencyCounty, '');
    SELF.Jgmts29_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[29].AgencyState , '');
    SELF.Jgmts29_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[29].ConsumerStatementId), '');
    SELF.Jgmts29_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[29].orig_rmsid, '');
    SELF.Jgmts30_Seq:= IF(~suppress_condition, ri.LnJJudgments[30].Seq , '');
    SELF.Jgmts30_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[30].DateFiled , '');
    SELF.Jgmts30_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[30].JudgmentTypeID, '');
    SELF.Jgmts30_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[30].JudgmentType, '');
    SELF.Jgmts30_Amount := IF(~suppress_condition, ri.LnJJudgments[30].Amount, '');
    SELF.Jgmts30_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[30].ReleaseDate , ''); 
    SELF.Jgmts30_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[30].FilingDescription, '');
    SELF.Jgmts30_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[30].DateLastSeen, '');
    SELF.Jgmts30_Defendant:= IF(~suppress_condition, ri.LnJJudgments[30].Defendant, '');
    SELF.Jgmts30_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[30].Plaintiff, '');
    SELF.Jgmts30_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[30].FilingNumber, '');
    SELF.Jgmts30_FilingBook := IF(~suppress_condition, ri.LnJJudgments[30].FilingBook, '');
    SELF.Jgmts30_FilingPage := IF(~suppress_condition, ri.LnJJudgments[30].FilingPage, '');
    SELF.Jgmts30_Eviction := IF(~suppress_condition, ri.LnJJudgments[30].Eviction, '');
    SELF.Jgmts30_Agency := IF(~suppress_condition, ri.LnJJudgments[30].Agency, '');
    SELF.Jgmts30_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[30].AgencyCounty, '');
    SELF.Jgmts30_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[30].AgencyState , '');
    SELF.Jgmts30_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[30].ConsumerStatementId), '');
    SELF.Jgmts30_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[30].orig_rmsid, '');
    SELF.Jgmts31_Seq:= IF(~suppress_condition, ri.LnJJudgments[31].Seq , '');
    SELF.Jgmts31_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[31].DateFiled , '');
    SELF.Jgmts31_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[31].JudgmentTypeID, '');
    SELF.Jgmts31_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[31].JudgmentType, '');
    SELF.Jgmts31_Amount := IF(~suppress_condition, ri.LnJJudgments[31].Amount, '');
    SELF.Jgmts31_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[31].ReleaseDate , '');
    SELF.Jgmts31_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[31].FilingDescription, '');
    SELF.Jgmts31_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[31].DateLastSeen, '');
    SELF.Jgmts31_Defendant:= IF(~suppress_condition, ri.LnJJudgments[31].Defendant, '');
    SELF.Jgmts31_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[31].Plaintiff, '');
    SELF.Jgmts31_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[31].FilingNumber, '');
    SELF.Jgmts31_FilingBook := IF(~suppress_condition, ri.LnJJudgments[31].FilingBook, '');
    SELF.Jgmts31_FilingPage := IF(~suppress_condition, ri.LnJJudgments[31].FilingPage, '');
    SELF.Jgmts31_Eviction := IF(~suppress_condition, ri.LnJJudgments[31].Eviction, '');
    SELF.Jgmts31_Agency := IF(~suppress_condition, ri.LnJJudgments[31].Agency, '');
    SELF.Jgmts31_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[31].AgencyCounty, '');
    SELF.Jgmts31_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[31].AgencyState , '');
    SELF.Jgmts31_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[31].ConsumerStatementId), '');
    SELF.Jgmts31_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[31].orig_rmsid, '');
    SELF.Jgmts32_Seq:= IF(~suppress_condition, ri.LnJJudgments[32].Seq , '');
    SELF.Jgmts32_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[32].DateFiled , '');
    SELF.Jgmts32_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[32].JudgmentTypeID, '');
    SELF.Jgmts32_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[32].JudgmentType, '');
    SELF.Jgmts32_Amount := IF(~suppress_condition, ri.LnJJudgments[32].Amount, '');
    SELF.Jgmts32_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[32].ReleaseDate , '');
    SELF.Jgmts32_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[32].FilingDescription, '');
    SELF.Jgmts32_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[32].DateLastSeen, '');
    SELF.Jgmts32_Defendant:= IF(~suppress_condition, ri.LnJJudgments[32].Defendant, '');
    SELF.Jgmts32_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[32].Plaintiff, '');
    SELF.Jgmts32_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[32].FilingNumber, '');
    SELF.Jgmts32_FilingBook := IF(~suppress_condition, ri.LnJJudgments[32].FilingBook, '');
    SELF.Jgmts32_FilingPage := IF(~suppress_condition, ri.LnJJudgments[32].FilingPage, '');
    SELF.Jgmts32_Eviction := IF(~suppress_condition, ri.LnJJudgments[32].Eviction, '');
    SELF.Jgmts32_Agency := IF(~suppress_condition, ri.LnJJudgments[32].Agency, '');
    SELF.Jgmts32_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[32].AgencyCounty, '');
    SELF.Jgmts32_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[32].AgencyState , '');
    SELF.Jgmts32_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[32].ConsumerStatementId), '');
    SELF.Jgmts32_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[32].orig_rmsid, '');
    SELF.Jgmts33_Seq:= IF(~suppress_condition, ri.LnJJudgments[33].Seq , '');
    SELF.Jgmts33_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[33].DateFiled , '');
    SELF.Jgmts33_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[33].JudgmentTypeID, '');
    SELF.Jgmts33_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[33].JudgmentType, '');
    SELF.Jgmts33_Amount := IF(~suppress_condition, ri.LnJJudgments[33].Amount, '');
    SELF.Jgmts33_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[33].ReleaseDate , ''); 
    SELF.Jgmts33_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[33].FilingDescription, '');
    SELF.Jgmts33_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[33].DateLastSeen, '');
    SELF.Jgmts33_Defendant:= IF(~suppress_condition, ri.LnJJudgments[33].Defendant, '');
    SELF.Jgmts33_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[33].Plaintiff, '');
    SELF.Jgmts33_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[33].FilingNumber, '');
    SELF.Jgmts33_FilingBook := IF(~suppress_condition, ri.LnJJudgments[33].FilingBook, '');
    SELF.Jgmts33_FilingPage := IF(~suppress_condition, ri.LnJJudgments[33].FilingPage, '');
    SELF.Jgmts33_Eviction := IF(~suppress_condition, ri.LnJJudgments[33].Eviction, '');
    SELF.Jgmts33_Agency := IF(~suppress_condition, ri.LnJJudgments[33].Agency, '');
    SELF.Jgmts33_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[33].AgencyCounty, '');
    SELF.Jgmts33_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[33].AgencyState , '');
    SELF.Jgmts33_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[33].ConsumerStatementId), '');
    SELF.Jgmts33_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[33].orig_rmsid, '');
    SELF.Jgmts34_Seq:= IF(~suppress_condition, ri.LnJJudgments[34].Seq , '');
    SELF.Jgmts34_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[34].DateFiled , '');
    SELF.Jgmts34_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[34].JudgmentTypeID, '');
    SELF.Jgmts34_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[34].JudgmentType, '');
    SELF.Jgmts34_Amount := IF(~suppress_condition, ri.LnJJudgments[34].Amount, '');
    SELF.Jgmts34_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[34].ReleaseDate , ''); 
    SELF.Jgmts34_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[34].FilingDescription, '');
    SELF.Jgmts34_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[34].DateLastSeen, '');
    SELF.Jgmts34_Defendant:= IF(~suppress_condition, ri.LnJJudgments[34].Defendant, '');
    SELF.Jgmts34_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[34].Plaintiff, '');
    SELF.Jgmts34_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[34].FilingNumber, '');
    SELF.Jgmts34_FilingBook := IF(~suppress_condition, ri.LnJJudgments[34].FilingBook, '');
    SELF.Jgmts34_FilingPage := IF(~suppress_condition, ri.LnJJudgments[34].FilingPage, '');
    SELF.Jgmts34_Eviction := IF(~suppress_condition, ri.LnJJudgments[34].Eviction, '');
    SELF.Jgmts34_Agency := IF(~suppress_condition, ri.LnJJudgments[34].Agency, '');
    SELF.Jgmts34_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[34].AgencyCounty, '');
    SELF.Jgmts34_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[34].AgencyState , '');
    SELF.Jgmts34_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[34].ConsumerStatementId), '');
    SELF.Jgmts34_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[34].orig_rmsid, '');
    SELF.Jgmts35_Seq:= IF(~suppress_condition, ri.LnJJudgments[35].Seq , '');
    SELF.Jgmts35_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[35].DateFiled , '');
    SELF.Jgmts35_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[35].JudgmentTypeID, '');
    SELF.Jgmts35_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[35].JudgmentType, '');
    SELF.Jgmts35_Amount := IF(~suppress_condition, ri.LnJJudgments[35].Amount, '');
    SELF.Jgmts35_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[35].ReleaseDate , ''); 
    SELF.Jgmts35_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[35].FilingDescription, '');
    SELF.Jgmts35_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[35].DateLastSeen, '');
    SELF.Jgmts35_Defendant:= IF(~suppress_condition, ri.LnJJudgments[35].Defendant, '');
    SELF.Jgmts35_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[35].Plaintiff, '');
    SELF.Jgmts35_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[35].FilingNumber, '');
    SELF.Jgmts35_FilingBook := IF(~suppress_condition, ri.LnJJudgments[35].FilingBook, '');
    SELF.Jgmts35_FilingPage := IF(~suppress_condition, ri.LnJJudgments[35].FilingPage, '');
    SELF.Jgmts35_Eviction := IF(~suppress_condition, ri.LnJJudgments[35].Eviction, '');
    SELF.Jgmts35_Agency := IF(~suppress_condition, ri.LnJJudgments[35].Agency, '');
    SELF.Jgmts35_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[35].AgencyCounty, '');
    SELF.Jgmts35_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[35].AgencyState , '');
    SELF.Jgmts35_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[35].ConsumerStatementId), '');
    SELF.Jgmts35_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[35].orig_rmsid, '');
    SELF.Jgmts36_Seq:= IF(~suppress_condition, ri.LnJJudgments[36].Seq , '');
    SELF.Jgmts36_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[36].DateFiled , '');
    SELF.Jgmts36_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[36].JudgmentTypeID, '');
    SELF.Jgmts36_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[36].JudgmentType, '');
    SELF.Jgmts36_Amount := IF(~suppress_condition, ri.LnJJudgments[36].Amount, '');
    SELF.Jgmts36_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[36].ReleaseDate , '');
    SELF.Jgmts36_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[36].FilingDescription, '');
    SELF.Jgmts36_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[36].DateLastSeen, '');
    SELF.Jgmts36_Defendant:= IF(~suppress_condition, ri.LnJJudgments[36].Defendant, '');
    SELF.Jgmts36_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[36].Plaintiff, '');
    SELF.Jgmts36_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[36].FilingNumber, '');
    SELF.Jgmts36_FilingBook := IF(~suppress_condition, ri.LnJJudgments[36].FilingBook, '');
    SELF.Jgmts36_FilingPage := IF(~suppress_condition, ri.LnJJudgments[36].FilingPage, '');
    SELF.Jgmts36_Eviction := IF(~suppress_condition, ri.LnJJudgments[36].Eviction, '');
    SELF.Jgmts36_Agency := IF(~suppress_condition, ri.LnJJudgments[36].Agency, '');
    SELF.Jgmts36_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[36].AgencyCounty, '');
    SELF.Jgmts36_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[36].AgencyState , '');
    SELF.Jgmts36_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[36].ConsumerStatementId), '');
    SELF.Jgmts36_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[36].orig_rmsid, '');
    SELF.Jgmts37_Seq:= IF(~suppress_condition, ri.LnJJudgments[37].Seq , '');
    SELF.Jgmts37_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[37].DateFiled , '');
    SELF.Jgmts37_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[37].JudgmentTypeID, '');
    SELF.Jgmts37_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[37].JudgmentType, '');
    SELF.Jgmts37_Amount := IF(~suppress_condition, ri.LnJJudgments[37].Amount, '');
    SELF.Jgmts37_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[37].ReleaseDate , '');
    SELF.Jgmts37_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[37].FilingDescription, '');
    SELF.Jgmts37_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[37].DateLastSeen, '');
    SELF.Jgmts37_Defendant:= IF(~suppress_condition, ri.LnJJudgments[37].Defendant, '');
    SELF.Jgmts37_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[37].Plaintiff, '');
    SELF.Jgmts37_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[37].FilingNumber, '');
    SELF.Jgmts37_FilingBook := IF(~suppress_condition, ri.LnJJudgments[37].FilingBook, '');
    SELF.Jgmts37_FilingPage := IF(~suppress_condition, ri.LnJJudgments[37].FilingPage, '');
    SELF.Jgmts37_Eviction := IF(~suppress_condition, ri.LnJJudgments[37].Eviction, '');
    SELF.Jgmts37_Agency := IF(~suppress_condition, ri.LnJJudgments[37].Agency, '');
    SELF.Jgmts37_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[37].AgencyCounty, '');
    SELF.Jgmts37_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[37].AgencyState , '');
    SELF.Jgmts37_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[37].ConsumerStatementId), '');
    SELF.Jgmts37_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[37].orig_rmsid, '');
    SELF.Jgmts38_Seq:= IF(~suppress_condition, ri.LnJJudgments[38].Seq , '');
    SELF.Jgmts38_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[38].DateFiled , '');
    SELF.Jgmts38_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[38].JudgmentTypeID, '');
    SELF.Jgmts38_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[38].JudgmentType, '');
    SELF.Jgmts38_Amount := IF(~suppress_condition, ri.LnJJudgments[38].Amount, '');
    SELF.Jgmts38_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[38].ReleaseDate , '');
    SELF.Jgmts38_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[38].FilingDescription, '');
    SELF.Jgmts38_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[38].DateLastSeen, '');
    SELF.Jgmts38_Defendant:= IF(~suppress_condition, ri.LnJJudgments[38].Defendant, '');
    SELF.Jgmts38_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[38].Plaintiff, '');
    SELF.Jgmts38_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[38].FilingNumber, '');
    SELF.Jgmts38_FilingBook := IF(~suppress_condition, ri.LnJJudgments[38].FilingBook, '');
    SELF.Jgmts38_FilingPage := IF(~suppress_condition, ri.LnJJudgments[38].FilingPage, '');
    SELF.Jgmts38_Eviction := IF(~suppress_condition, ri.LnJJudgments[38].Eviction, '');
    SELF.Jgmts38_Agency := IF(~suppress_condition, ri.LnJJudgments[38].Agency, '');
    SELF.Jgmts38_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[38].AgencyCounty, '');
    SELF.Jgmts38_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[38].AgencyState , '');
    SELF.Jgmts38_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[38].ConsumerStatementId), '');
    SELF.Jgmts38_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[38].orig_rmsid, '');
    SELF.Jgmts39_Seq:= IF(~suppress_condition, ri.LnJJudgments[39].Seq , '');
    SELF.Jgmts39_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[39].DateFiled , '');
    SELF.Jgmts39_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[39].JudgmentTypeID, '');
    SELF.Jgmts39_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[39].JudgmentType, '');
    SELF.Jgmts39_Amount := IF(~suppress_condition, ri.LnJJudgments[39].Amount, '');
    SELF.Jgmts39_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[39].ReleaseDate , ''); 
    SELF.Jgmts39_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[39].FilingDescription, '');
    SELF.Jgmts39_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[39].DateLastSeen, '');
    SELF.Jgmts39_Defendant:= IF(~suppress_condition, ri.LnJJudgments[39].Defendant, '');
    SELF.Jgmts39_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[39].Plaintiff, '');
    SELF.Jgmts39_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[39].FilingNumber, '');
    SELF.Jgmts39_FilingBook := IF(~suppress_condition, ri.LnJJudgments[39].FilingBook, '');
    SELF.Jgmts39_FilingPage := IF(~suppress_condition, ri.LnJJudgments[39].FilingPage, '');
    SELF.Jgmts39_Eviction := IF(~suppress_condition, ri.LnJJudgments[39].Eviction, '');
    SELF.Jgmts39_Agency := IF(~suppress_condition, ri.LnJJudgments[39].Agency, '');
    SELF.Jgmts39_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[39].AgencyCounty, '');
    SELF.Jgmts39_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[39].AgencyState , '');
    SELF.Jgmts39_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[39].ConsumerStatementId), '');
    SELF.Jgmts39_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[39].orig_rmsid, '');
    SELF.Jgmts40_Seq:= IF(~suppress_condition, ri.LnJJudgments[40].Seq , '');
    SELF.Jgmts40_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[40].DateFiled , '');
    SELF.Jgmts40_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[40].JudgmentTypeID, '');
    SELF.Jgmts40_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[40].JudgmentType, '');
    SELF.Jgmts40_Amount := IF(~suppress_condition, ri.LnJJudgments[40].Amount, '');
    SELF.Jgmts40_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[40].ReleaseDate , '');
    SELF.Jgmts40_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[40].FilingDescription, '');
    SELF.Jgmts40_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[40].DateLastSeen, '');
    SELF.Jgmts40_Defendant:= IF(~suppress_condition, ri.LnJJudgments[40].Defendant, '');
    SELF.Jgmts40_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[40].Plaintiff, '');
    SELF.Jgmts40_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[40].FilingNumber, '');
    SELF.Jgmts40_FilingBook := IF(~suppress_condition, ri.LnJJudgments[40].FilingBook, '');
    SELF.Jgmts40_FilingPage := IF(~suppress_condition, ri.LnJJudgments[40].FilingPage, '');
    SELF.Jgmts40_Eviction := IF(~suppress_condition, ri.LnJJudgments[40].Eviction, '');
    SELF.Jgmts40_Agency := IF(~suppress_condition, ri.LnJJudgments[40].Agency, '');
    SELF.Jgmts40_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[40].AgencyCounty, '');
    SELF.Jgmts40_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[40].AgencyState , '');
    SELF.Jgmts40_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[40].ConsumerStatementId), '');
    SELF.Jgmts40_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[40].orig_rmsid, '');
    SELF.Jgmts41_Seq:= IF(~suppress_condition, ri.LnJJudgments[41].Seq , '');
    SELF.Jgmts41_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[41].DateFiled , '');
    SELF.Jgmts41_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[41].JudgmentTypeID, '');
    SELF.Jgmts41_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[41].JudgmentType, '');
    SELF.Jgmts41_Amount := IF(~suppress_condition, ri.LnJJudgments[41].Amount, '');
    SELF.Jgmts41_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[41].ReleaseDate , '');
    SELF.Jgmts41_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[41].FilingDescription, '');
    SELF.Jgmts41_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[41].DateLastSeen, '');
    SELF.Jgmts41_Defendant:= IF(~suppress_condition, ri.LnJJudgments[41].Defendant, '');
    SELF.Jgmts41_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[41].Plaintiff, '');
    SELF.Jgmts41_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[41].FilingNumber, '');
    SELF.Jgmts41_FilingBook := IF(~suppress_condition, ri.LnJJudgments[41].FilingBook, '');
    SELF.Jgmts41_FilingPage := IF(~suppress_condition, ri.LnJJudgments[41].FilingPage, '');
    SELF.Jgmts41_Eviction := IF(~suppress_condition, ri.LnJJudgments[41].Eviction, '');
    SELF.Jgmts41_Agency := IF(~suppress_condition, ri.LnJJudgments[41].Agency, '');
    SELF.Jgmts41_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[41].AgencyCounty, '');
    SELF.Jgmts41_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[41].AgencyState , '');
    SELF.Jgmts41_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[41].ConsumerStatementId), '');
    SELF.Jgmts41_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[41].orig_rmsid, '');
    SELF.Jgmts42_Seq:= IF(~suppress_condition, ri.LnJJudgments[42].Seq , '');
    SELF.Jgmts42_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[42].DateFiled , '');
    SELF.Jgmts42_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[42].JudgmentTypeID, '');
    SELF.Jgmts42_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[42].JudgmentType, '');
    SELF.Jgmts42_Amount := IF(~suppress_condition, ri.LnJJudgments[42].Amount, '');
    SELF.Jgmts42_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[42].ReleaseDate , '');
    SELF.Jgmts42_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[42].FilingDescription, '');
    SELF.Jgmts42_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[42].DateLastSeen, '');
    SELF.Jgmts42_Defendant:= IF(~suppress_condition, ri.LnJJudgments[42].Defendant, '');
    SELF.Jgmts42_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[42].Plaintiff, '');
    SELF.Jgmts42_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[42].FilingNumber, '');
    SELF.Jgmts42_FilingBook := IF(~suppress_condition, ri.LnJJudgments[42].FilingBook, '');
    SELF.Jgmts42_FilingPage := IF(~suppress_condition, ri.LnJJudgments[42].FilingPage, '');
    SELF.Jgmts42_Eviction := IF(~suppress_condition, ri.LnJJudgments[42].Eviction, '');
    SELF.Jgmts42_Agency := IF(~suppress_condition, ri.LnJJudgments[42].Agency, '');
    SELF.Jgmts42_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[42].AgencyCounty, '');
    SELF.Jgmts42_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[42].AgencyState , '');
    SELF.Jgmts42_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[42].ConsumerStatementId), '');
    SELF.Jgmts42_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[42].orig_rmsid, '');
    SELF.Jgmts43_Seq:= IF(~suppress_condition, ri.LnJJudgments[43].Seq , '');
    SELF.Jgmts43_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[43].DateFiled , '');
    SELF.Jgmts43_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[43].JudgmentTypeID, '');
    SELF.Jgmts43_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[43].JudgmentType, '');
    SELF.Jgmts43_Amount := IF(~suppress_condition, ri.LnJJudgments[43].Amount, '');
    SELF.Jgmts43_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[43].ReleaseDate , '');
    SELF.Jgmts43_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[43].FilingDescription, '');
    SELF.Jgmts43_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[43].DateLastSeen, '');
    SELF.Jgmts43_Defendant:= IF(~suppress_condition, ri.LnJJudgments[43].Defendant, '');
    SELF.Jgmts43_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[43].Plaintiff, '');
    SELF.Jgmts43_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[43].FilingNumber, '');
    SELF.Jgmts43_FilingBook := IF(~suppress_condition, ri.LnJJudgments[43].FilingBook, '');
    SELF.Jgmts43_FilingPage := IF(~suppress_condition, ri.LnJJudgments[43].FilingPage, '');
    SELF.Jgmts43_Eviction := IF(~suppress_condition, ri.LnJJudgments[43].Eviction, '');
    SELF.Jgmts43_Agency := IF(~suppress_condition, ri.LnJJudgments[43].Agency, '');
    SELF.Jgmts43_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[43].AgencyCounty, '');
    SELF.Jgmts43_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[43].AgencyState , '');
    SELF.Jgmts43_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[43].ConsumerStatementId), '');
    SELF.Jgmts43_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[43].orig_rmsid, '');
    SELF.Jgmts44_Seq:= IF(~suppress_condition, ri.LnJJudgments[44].Seq , '');
    SELF.Jgmts44_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[44].DateFiled , '');
    SELF.Jgmts44_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[44].JudgmentTypeID, '');
    SELF.Jgmts44_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[44].JudgmentType, '');
    SELF.Jgmts44_Amount := IF(~suppress_condition, ri.LnJJudgments[44].Amount, '');
    SELF.Jgmts44_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[44].ReleaseDate , '');
    SELF.Jgmts44_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[44].FilingDescription, '');
    SELF.Jgmts44_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[44].DateLastSeen, '');
    SELF.Jgmts44_Defendant:= IF(~suppress_condition, ri.LnJJudgments[44].Defendant, '');
    SELF.Jgmts44_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[44].Plaintiff, '');
    SELF.Jgmts44_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[44].FilingNumber, '');
    SELF.Jgmts44_FilingBook := IF(~suppress_condition, ri.LnJJudgments[44].FilingBook, '');
    SELF.Jgmts44_FilingPage := IF(~suppress_condition, ri.LnJJudgments[44].FilingPage, '');
    SELF.Jgmts44_Eviction := IF(~suppress_condition, ri.LnJJudgments[44].Eviction, '');
    SELF.Jgmts44_Agency := IF(~suppress_condition, ri.LnJJudgments[44].Agency, '');
    SELF.Jgmts44_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[44].AgencyCounty, '');
    SELF.Jgmts44_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[44].AgencyState , '');
    SELF.Jgmts44_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[44].ConsumerStatementId), '');
    SELF.Jgmts44_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[44].orig_rmsid, '');
    SELF.Jgmts45_Seq:= IF(~suppress_condition, ri.LnJJudgments[45].Seq , '');
    SELF.Jgmts45_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[45].DateFiled , '');
    SELF.Jgmts45_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[45].JudgmentTypeID, '');
    SELF.Jgmts45_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[45].JudgmentType, '');
    SELF.Jgmts45_Amount := IF(~suppress_condition, ri.LnJJudgments[45].Amount, '');
    SELF.Jgmts45_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[45].ReleaseDate , '');
    SELF.Jgmts45_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[45].FilingDescription, '');
    SELF.Jgmts45_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[45].DateLastSeen, '');
    SELF.Jgmts45_Defendant:= IF(~suppress_condition, ri.LnJJudgments[45].Defendant, '');
    SELF.Jgmts45_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[45].Plaintiff, '');
    SELF.Jgmts45_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[45].FilingNumber, '');
    SELF.Jgmts45_FilingBook := IF(~suppress_condition, ri.LnJJudgments[45].FilingBook, '');
    SELF.Jgmts45_FilingPage := IF(~suppress_condition, ri.LnJJudgments[45].FilingPage, '');
    SELF.Jgmts45_Eviction := IF(~suppress_condition, ri.LnJJudgments[45].Eviction, '');
    SELF.Jgmts45_Agency := IF(~suppress_condition, ri.LnJJudgments[45].Agency, '');
    SELF.Jgmts45_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[45].AgencyCounty, '');
    SELF.Jgmts45_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[45].AgencyState , '');
    SELF.Jgmts45_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[45].ConsumerStatementId), '');
    SELF.Jgmts45_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[45].orig_rmsid, '');
    SELF.Jgmts46_Seq:= IF(~suppress_condition, ri.LnJJudgments[46].Seq , '');
    SELF.Jgmts46_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[46].DateFiled , '');
    SELF.Jgmts46_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[46].JudgmentTypeID, '');
    SELF.Jgmts46_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[46].JudgmentType, '');
    SELF.Jgmts46_Amount := IF(~suppress_condition, ri.LnJJudgments[46].Amount, '');
    SELF.Jgmts46_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[46].ReleaseDate , '');
    SELF.Jgmts46_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[46].FilingDescription, '');
    SELF.Jgmts46_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[46].DateLastSeen, '');
    SELF.Jgmts46_Defendant:= IF(~suppress_condition, ri.LnJJudgments[46].Defendant, '');
    SELF.Jgmts46_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[46].Plaintiff, '');
    SELF.Jgmts46_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[46].FilingNumber, '');
    SELF.Jgmts46_FilingBook := IF(~suppress_condition, ri.LnJJudgments[46].FilingBook, '');
    SELF.Jgmts46_FilingPage := IF(~suppress_condition, ri.LnJJudgments[46].FilingPage, '');
    SELF.Jgmts46_Eviction := IF(~suppress_condition, ri.LnJJudgments[46].Eviction, '');
    SELF.Jgmts46_Agency := IF(~suppress_condition, ri.LnJJudgments[46].Agency, '');
    SELF.Jgmts46_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[46].AgencyCounty, '');
    SELF.Jgmts46_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[46].AgencyState , '');
    SELF.Jgmts46_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[46].ConsumerStatementId), '');
    SELF.Jgmts46_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[46].orig_rmsid, '');
    SELF.Jgmts47_Seq:= IF(~suppress_condition, ri.LnJJudgments[47].Seq , '');
    SELF.Jgmts47_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[47].DateFiled , '');
    SELF.Jgmts47_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[47].JudgmentTypeID, '');
    SELF.Jgmts47_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[47].JudgmentType, '');
    SELF.Jgmts47_Amount := IF(~suppress_condition, ri.LnJJudgments[47].Amount, '');
    SELF.Jgmts47_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[47].ReleaseDate , ''); 
    SELF.Jgmts47_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[47].FilingDescription, '');
    SELF.Jgmts47_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[47].DateLastSeen, '');
    SELF.Jgmts47_Defendant:= IF(~suppress_condition, ri.LnJJudgments[47].Defendant, '');
    SELF.Jgmts47_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[47].Plaintiff, '');
    SELF.Jgmts47_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[47].FilingNumber, '');
    SELF.Jgmts47_FilingBook := IF(~suppress_condition, ri.LnJJudgments[47].FilingBook, '');
    SELF.Jgmts47_FilingPage := IF(~suppress_condition, ri.LnJJudgments[47].FilingPage, '');
    SELF.Jgmts47_Eviction := IF(~suppress_condition, ri.LnJJudgments[47].Eviction, '');
    SELF.Jgmts47_Agency := IF(~suppress_condition, ri.LnJJudgments[47].Agency, '');
    SELF.Jgmts47_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[47].AgencyCounty, '');
    SELF.Jgmts47_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[47].AgencyState , '');
    SELF.Jgmts47_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[47].ConsumerStatementId), '');
    SELF.Jgmts47_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[47].orig_rmsid, '');
    SELF.Jgmts48_Seq:= IF(~suppress_condition, ri.LnJJudgments[48].Seq , '');
    SELF.Jgmts48_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[48].DateFiled , '');
    SELF.Jgmts48_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[48].JudgmentTypeID, '');
    SELF.Jgmts48_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[48].JudgmentType, '');
    SELF.Jgmts48_Amount := IF(~suppress_condition, ri.LnJJudgments[48].Amount, '');
    SELF.Jgmts48_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[48].ReleaseDate , '');
    SELF.Jgmts48_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[48].FilingDescription, '');
    SELF.Jgmts48_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[48].DateLastSeen, '');
    SELF.Jgmts48_Defendant:= IF(~suppress_condition, ri.LnJJudgments[48].Defendant, '');
    SELF.Jgmts48_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[48].Plaintiff, '');
    SELF.Jgmts48_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[48].FilingNumber, '');
    SELF.Jgmts48_FilingBook := IF(~suppress_condition, ri.LnJJudgments[48].FilingBook, '');
    SELF.Jgmts48_FilingPage := IF(~suppress_condition, ri.LnJJudgments[48].FilingPage, '');
    SELF.Jgmts48_Eviction := IF(~suppress_condition, ri.LnJJudgments[48].Eviction, '');
    SELF.Jgmts48_Agency := IF(~suppress_condition, ri.LnJJudgments[48].Agency, '');
    SELF.Jgmts48_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[48].AgencyCounty, '');
    SELF.Jgmts48_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[48].AgencyState , '');
    SELF.Jgmts48_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[48].ConsumerStatementId), '');
    SELF.Jgmts48_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[48].orig_rmsid, '');
    SELF.Jgmts49_Seq:= IF(~suppress_condition, ri.LnJJudgments[49].Seq , '');
    SELF.Jgmts49_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[49].DateFiled , '');
    SELF.Jgmts49_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[49].JudgmentTypeID, '');
    SELF.Jgmts49_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[49].JudgmentType, '');
    SELF.Jgmts49_Amount := IF(~suppress_condition, ri.LnJJudgments[49].Amount, '');
    SELF.Jgmts49_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[49].ReleaseDate , ''); 
    SELF.Jgmts49_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[49].FilingDescription, '');
    SELF.Jgmts49_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[49].DateLastSeen, '');
    SELF.Jgmts49_Defendant:= IF(~suppress_condition, ri.LnJJudgments[49].Defendant, '');
    SELF.Jgmts49_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[49].Plaintiff, '');
    SELF.Jgmts49_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[49].FilingNumber, '');
    SELF.Jgmts49_FilingBook := IF(~suppress_condition, ri.LnJJudgments[49].FilingBook, '');
    SELF.Jgmts49_FilingPage := IF(~suppress_condition, ri.LnJJudgments[49].FilingPage, '');
    SELF.Jgmts49_Eviction := IF(~suppress_condition, ri.LnJJudgments[49].Eviction, '');
    SELF.Jgmts49_Agency := IF(~suppress_condition, ri.LnJJudgments[49].Agency, '');
    SELF.Jgmts49_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[49].AgencyCounty, '');
    SELF.Jgmts49_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[49].AgencyState , '');
    SELF.Jgmts49_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[49].ConsumerStatementId), '');
    SELF.Jgmts49_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[49].orig_rmsid, '');
    SELF.Jgmts50_Seq:= IF(~suppress_condition, ri.LnJJudgments[50].Seq , '');
    SELF.Jgmts50_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[50].DateFiled , '');
    SELF.Jgmts50_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[50].JudgmentTypeID, '');
    SELF.Jgmts50_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[50].JudgmentType, '');
    SELF.Jgmts50_Amount := IF(~suppress_condition, ri.LnJJudgments[50].Amount, '');
    SELF.Jgmts50_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[50].ReleaseDate , ''); 
    SELF.Jgmts50_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[50].FilingDescription, '');
    SELF.Jgmts50_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[50].DateLastSeen, '');
    SELF.Jgmts50_Defendant:= IF(~suppress_condition, ri.LnJJudgments[50].Defendant, '');
    SELF.Jgmts50_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[50].Plaintiff, '');
    SELF.Jgmts50_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[50].FilingNumber, '');
    SELF.Jgmts50_FilingBook := IF(~suppress_condition, ri.LnJJudgments[50].FilingBook, '');
    SELF.Jgmts50_FilingPage := IF(~suppress_condition, ri.LnJJudgments[50].FilingPage, '');
    SELF.Jgmts50_Eviction := IF(~suppress_condition, ri.LnJJudgments[50].Eviction, '');
    SELF.Jgmts50_Agency := IF(~suppress_condition, ri.LnJJudgments[50].Agency, '');
    SELF.Jgmts50_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[50].AgencyCounty, '');
    SELF.Jgmts50_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[50].AgencyState , '');
    SELF.Jgmts50_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[50].ConsumerStatementId), '');
    SELF.Jgmts50_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[50].orig_rmsid, '');
    SELF.Jgmts51_Seq:= IF(~suppress_condition, ri.LnJJudgments[51].Seq , '');
    SELF.Jgmts51_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[51].DateFiled , '');
    SELF.Jgmts51_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[51].JudgmentTypeID, '');
    SELF.Jgmts51_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[51].JudgmentType, '');
    SELF.Jgmts51_Amount := IF(~suppress_condition, ri.LnJJudgments[51].Amount, '');
    SELF.Jgmts51_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[51].ReleaseDate , '');
    SELF.Jgmts51_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[51].FilingDescription, '');
    SELF.Jgmts51_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[51].DateLastSeen, '');
    SELF.Jgmts51_Defendant:= IF(~suppress_condition, ri.LnJJudgments[51].Defendant, '');
    SELF.Jgmts51_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[51].Plaintiff, '');
    SELF.Jgmts51_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[51].FilingNumber, '');
    SELF.Jgmts51_FilingBook := IF(~suppress_condition, ri.LnJJudgments[51].FilingBook, '');
    SELF.Jgmts51_FilingPage := IF(~suppress_condition, ri.LnJJudgments[51].FilingPage, '');
    SELF.Jgmts51_Eviction := IF(~suppress_condition, ri.LnJJudgments[51].Eviction, '');
    SELF.Jgmts51_Agency := IF(~suppress_condition, ri.LnJJudgments[51].Agency, '');
    SELF.Jgmts51_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[51].AgencyCounty, '');
    SELF.Jgmts51_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[51].AgencyState , '');
    SELF.Jgmts51_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[51].ConsumerStatementId), '');
    SELF.Jgmts51_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[51].orig_rmsid, '');
    SELF.Jgmts52_Seq:= IF(~suppress_condition, ri.LnJJudgments[52].Seq , '');
    SELF.Jgmts52_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[52].DateFiled , '');
    SELF.Jgmts52_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[52].JudgmentTypeID, '');
    SELF.Jgmts52_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[52].JudgmentType, '');
    SELF.Jgmts52_Amount := IF(~suppress_condition, ri.LnJJudgments[52].Amount, '');
    SELF.Jgmts52_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[52].ReleaseDate , ''); 
    SELF.Jgmts52_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[52].FilingDescription, '');
    SELF.Jgmts52_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[52].DateLastSeen, '');
    SELF.Jgmts52_Defendant:= IF(~suppress_condition, ri.LnJJudgments[52].Defendant, '');
    SELF.Jgmts52_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[52].Plaintiff, '');
    SELF.Jgmts52_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[52].FilingNumber, '');
    SELF.Jgmts52_FilingBook := IF(~suppress_condition, ri.LnJJudgments[52].FilingBook, '');
    SELF.Jgmts52_FilingPage := IF(~suppress_condition, ri.LnJJudgments[52].FilingPage, '');
    SELF.Jgmts52_Eviction := IF(~suppress_condition, ri.LnJJudgments[52].Eviction, '');
    SELF.Jgmts52_Agency := IF(~suppress_condition, ri.LnJJudgments[52].Agency, '');
    SELF.Jgmts52_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[52].AgencyCounty, '');
    SELF.Jgmts52_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[52].AgencyState , '');
    SELF.Jgmts52_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[52].ConsumerStatementId), '');
    SELF.Jgmts52_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[52].orig_rmsid, '');
    SELF.Jgmts53_Seq:= IF(~suppress_condition, ri.LnJJudgments[53].Seq , '');
    SELF.Jgmts53_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[53].DateFiled , '');
    SELF.Jgmts53_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[53].JudgmentTypeID, '');
    SELF.Jgmts53_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[53].JudgmentType, '');
    SELF.Jgmts53_Amount := IF(~suppress_condition, ri.LnJJudgments[53].Amount, '');
    SELF.Jgmts53_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[53].ReleaseDate , ''); 
    SELF.Jgmts53_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[53].FilingDescription, '');
    SELF.Jgmts53_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[53].DateLastSeen, '');
    SELF.Jgmts53_Defendant:= IF(~suppress_condition, ri.LnJJudgments[53].Defendant, '');
    SELF.Jgmts53_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[53].Plaintiff, '');
    SELF.Jgmts53_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[53].FilingNumber, '');
    SELF.Jgmts53_FilingBook := IF(~suppress_condition, ri.LnJJudgments[53].FilingBook, '');
    SELF.Jgmts53_FilingPage := IF(~suppress_condition, ri.LnJJudgments[53].FilingPage, '');
    SELF.Jgmts53_Eviction := IF(~suppress_condition, ri.LnJJudgments[53].Eviction, '');
    SELF.Jgmts53_Agency := IF(~suppress_condition, ri.LnJJudgments[53].Agency, '');
    SELF.Jgmts53_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[53].AgencyCounty, '');
    SELF.Jgmts53_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[53].AgencyState , '');
    SELF.Jgmts53_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[53].ConsumerStatementId), '');
    SELF.Jgmts53_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[53].orig_rmsid, '');
    SELF.Jgmts54_Seq:= IF(~suppress_condition, ri.LnJJudgments[54].Seq , '');
    SELF.Jgmts54_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[54].DateFiled , '');
    SELF.Jgmts54_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[54].JudgmentTypeID, '');
    SELF.Jgmts54_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[54].JudgmentType, '');
    SELF.Jgmts54_Amount := IF(~suppress_condition, ri.LnJJudgments[54].Amount, '');
    SELF.Jgmts54_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[54].ReleaseDate , ''); 
    SELF.Jgmts54_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[54].FilingDescription, '');
    SELF.Jgmts54_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[54].DateLastSeen, '');
    SELF.Jgmts54_Defendant:= IF(~suppress_condition, ri.LnJJudgments[54].Defendant, '');
    SELF.Jgmts54_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[54].Plaintiff, '');
    SELF.Jgmts54_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[54].FilingNumber, '');
    SELF.Jgmts54_FilingBook := IF(~suppress_condition, ri.LnJJudgments[54].FilingBook, '');
    SELF.Jgmts54_FilingPage := IF(~suppress_condition, ri.LnJJudgments[54].FilingPage, '');
    SELF.Jgmts54_Eviction := IF(~suppress_condition, ri.LnJJudgments[54].Eviction, '');
    SELF.Jgmts54_Agency := IF(~suppress_condition, ri.LnJJudgments[54].Agency, '');
    SELF.Jgmts54_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[54].AgencyCounty, '');
    SELF.Jgmts54_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[54].AgencyState , '');
    SELF.Jgmts54_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[54].ConsumerStatementId), '');
    SELF.Jgmts54_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[54].orig_rmsid, '');
    SELF.Jgmts55_Seq:= IF(~suppress_condition, ri.LnJJudgments[55].Seq , '');
    SELF.Jgmts55_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[55].DateFiled , '');
    SELF.Jgmts55_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[55].JudgmentTypeID, '');
    SELF.Jgmts55_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[55].JudgmentType, '');
    SELF.Jgmts55_Amount := IF(~suppress_condition, ri.LnJJudgments[55].Amount, '');
    SELF.Jgmts55_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[55].ReleaseDate , ''); 
    SELF.Jgmts55_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[55].FilingDescription, '');
    SELF.Jgmts55_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[55].DateLastSeen, '');
    SELF.Jgmts55_Defendant:= IF(~suppress_condition, ri.LnJJudgments[55].Defendant, '');
    SELF.Jgmts55_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[55].Plaintiff, '');
    SELF.Jgmts55_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[55].FilingNumber, '');
    SELF.Jgmts55_FilingBook := IF(~suppress_condition, ri.LnJJudgments[55].FilingBook, '');
    SELF.Jgmts55_FilingPage := IF(~suppress_condition, ri.LnJJudgments[55].FilingPage, '');
    SELF.Jgmts55_Eviction := IF(~suppress_condition, ri.LnJJudgments[55].Eviction, '');
    SELF.Jgmts55_Agency := IF(~suppress_condition, ri.LnJJudgments[55].Agency, '');
    SELF.Jgmts55_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[55].AgencyCounty, '');
    SELF.Jgmts55_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[55].AgencyState , '');
    SELF.Jgmts55_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[55].ConsumerStatementId), '');
    SELF.Jgmts55_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[55].orig_rmsid, '');
    SELF.Jgmts56_Seq:= IF(~suppress_condition, ri.LnJJudgments[56].Seq , '');
    SELF.Jgmts56_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[56].DateFiled , '');
    SELF.Jgmts56_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[56].JudgmentTypeID, '');
    SELF.Jgmts56_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[56].JudgmentType, '');
    SELF.Jgmts56_Amount := IF(~suppress_condition, ri.LnJJudgments[56].Amount, '');
    SELF.Jgmts56_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[56].ReleaseDate , ''); 
    SELF.Jgmts56_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[56].FilingDescription, '');
    SELF.Jgmts56_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[56].DateLastSeen, '');
    SELF.Jgmts56_Defendant:= IF(~suppress_condition, ri.LnJJudgments[56].Defendant, '');
    SELF.Jgmts56_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[56].Plaintiff, '');
    SELF.Jgmts56_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[56].FilingNumber, '');
    SELF.Jgmts56_FilingBook := IF(~suppress_condition, ri.LnJJudgments[56].FilingBook, '');
    SELF.Jgmts56_FilingPage := IF(~suppress_condition, ri.LnJJudgments[56].FilingPage, '');
    SELF.Jgmts56_Eviction := IF(~suppress_condition, ri.LnJJudgments[56].Eviction, '');
    SELF.Jgmts56_Agency := IF(~suppress_condition, ri.LnJJudgments[56].Agency, '');
    SELF.Jgmts56_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[56].AgencyCounty, '');
    SELF.Jgmts56_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[56].AgencyState , '');
    SELF.Jgmts56_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[56].ConsumerStatementId), '');
    SELF.Jgmts56_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[56].orig_rmsid, '');
    SELF.Jgmts57_Seq:= IF(~suppress_condition, ri.LnJJudgments[57].Seq , '');
    SELF.Jgmts57_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[57].DateFiled , '');
    SELF.Jgmts57_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[57].JudgmentTypeID, '');
    SELF.Jgmts57_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[57].JudgmentType, '');
    SELF.Jgmts57_Amount := IF(~suppress_condition, ri.LnJJudgments[57].Amount, '');
    SELF.Jgmts57_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[57].ReleaseDate , '');
    SELF.Jgmts57_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[57].FilingDescription, '');
    SELF.Jgmts57_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[57].DateLastSeen, '');
    SELF.Jgmts57_Defendant:= IF(~suppress_condition, ri.LnJJudgments[57].Defendant, '');
    SELF.Jgmts57_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[57].Plaintiff, '');
    SELF.Jgmts57_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[57].FilingNumber, '');
    SELF.Jgmts57_FilingBook := IF(~suppress_condition, ri.LnJJudgments[57].FilingBook, '');
    SELF.Jgmts57_FilingPage := IF(~suppress_condition, ri.LnJJudgments[57].FilingPage, '');
    SELF.Jgmts57_Eviction := IF(~suppress_condition, ri.LnJJudgments[57].Eviction, '');
    SELF.Jgmts57_Agency := IF(~suppress_condition, ri.LnJJudgments[57].Agency, '');
    SELF.Jgmts57_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[57].AgencyCounty, '');
    SELF.Jgmts57_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[57].AgencyState , '');
    SELF.Jgmts57_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[57].ConsumerStatementId), '');
    SELF.Jgmts57_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[57].orig_rmsid, '');
    SELF.Jgmts58_Seq:= IF(~suppress_condition, ri.LnJJudgments[58].Seq , '');
    SELF.Jgmts58_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[58].DateFiled , '');
    SELF.Jgmts58_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[58].JudgmentTypeID, '');
    SELF.Jgmts58_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[58].JudgmentType, '');
    SELF.Jgmts58_Amount := IF(~suppress_condition, ri.LnJJudgments[58].Amount, '');
    SELF.Jgmts58_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[58].ReleaseDate , '');
    SELF.Jgmts58_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[58].FilingDescription, '');
    SELF.Jgmts58_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[58].DateLastSeen, '');
    SELF.Jgmts58_Defendant:= IF(~suppress_condition, ri.LnJJudgments[58].Defendant, '');
    SELF.Jgmts58_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[58].Plaintiff, '');
    SELF.Jgmts58_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[58].FilingNumber, '');
    SELF.Jgmts58_FilingBook := IF(~suppress_condition, ri.LnJJudgments[58].FilingBook, '');
    SELF.Jgmts58_FilingPage := IF(~suppress_condition, ri.LnJJudgments[58].FilingPage, '');
    SELF.Jgmts58_Eviction := IF(~suppress_condition, ri.LnJJudgments[58].Eviction, '');
    SELF.Jgmts58_Agency := IF(~suppress_condition, ri.LnJJudgments[58].Agency, '');
    SELF.Jgmts58_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[58].AgencyCounty, '');
    SELF.Jgmts58_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[58].AgencyState , '');
    SELF.Jgmts58_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[58].ConsumerStatementId), '');
    SELF.Jgmts58_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[58].orig_rmsid, '');
    SELF.Jgmts59_Seq:= IF(~suppress_condition, ri.LnJJudgments[59].Seq , '');
    SELF.Jgmts59_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[59].DateFiled , '');
    SELF.Jgmts59_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[59].JudgmentTypeID, '');
    SELF.Jgmts59_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[59].JudgmentType, '');
    SELF.Jgmts59_Amount := IF(~suppress_condition, ri.LnJJudgments[59].Amount, '');
    SELF.Jgmts59_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[59].ReleaseDate , '');
    SELF.Jgmts59_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[59].FilingDescription, '');
    SELF.Jgmts59_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[59].DateLastSeen, '');
    SELF.Jgmts59_Defendant:= IF(~suppress_condition, ri.LnJJudgments[59].Defendant, '');
    SELF.Jgmts59_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[59].Plaintiff, '');
    SELF.Jgmts59_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[59].FilingNumber, '');
    SELF.Jgmts59_FilingBook := IF(~suppress_condition, ri.LnJJudgments[59].FilingBook, '');
    SELF.Jgmts59_FilingPage := IF(~suppress_condition, ri.LnJJudgments[59].FilingPage, '');
    SELF.Jgmts59_Eviction := IF(~suppress_condition, ri.LnJJudgments[59].Eviction, '');
    SELF.Jgmts59_Agency := IF(~suppress_condition, ri.LnJJudgments[59].Agency, '');
    SELF.Jgmts59_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[59].AgencyCounty, '');
    SELF.Jgmts59_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[59].AgencyState , '');
    SELF.Jgmts59_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[59].ConsumerStatementId), '');
    SELF.Jgmts59_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[59].orig_rmsid, '');
    SELF.Jgmts60_Seq:= IF(~suppress_condition, ri.LnJJudgments[60].Seq , '');
    SELF.Jgmts60_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[60].DateFiled , '');
    SELF.Jgmts60_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[60].JudgmentTypeID, '');
    SELF.Jgmts60_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[60].JudgmentType, '');
    SELF.Jgmts60_Amount := IF(~suppress_condition, ri.LnJJudgments[60].Amount, '');
    SELF.Jgmts60_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[60].ReleaseDate , '');
    SELF.Jgmts60_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[60].FilingDescription, '');
    SELF.Jgmts60_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[60].DateLastSeen, '');
    SELF.Jgmts60_Defendant:= IF(~suppress_condition, ri.LnJJudgments[60].Defendant, '');
    SELF.Jgmts60_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[60].Plaintiff, '');
    SELF.Jgmts60_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[60].FilingNumber, '');
    SELF.Jgmts60_FilingBook := IF(~suppress_condition, ri.LnJJudgments[60].FilingBook, '');
    SELF.Jgmts60_FilingPage := IF(~suppress_condition, ri.LnJJudgments[60].FilingPage, '');
    SELF.Jgmts60_Eviction := IF(~suppress_condition, ri.LnJJudgments[60].Eviction, '');
    SELF.Jgmts60_Agency := IF(~suppress_condition, ri.LnJJudgments[60].Agency, '');
    SELF.Jgmts60_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[60].AgencyCounty, '');
    SELF.Jgmts60_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[60].AgencyState , '');
    SELF.Jgmts60_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[60].ConsumerStatementId), '');
    SELF.Jgmts60_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[60].orig_rmsid, '');
    SELF.Jgmts61_Seq:= IF(~suppress_condition, ri.LnJJudgments[61].Seq , '');
    SELF.Jgmts61_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[61].DateFiled , '');
    SELF.Jgmts61_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[61].JudgmentTypeID, '');
    SELF.Jgmts61_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[61].JudgmentType, '');
    SELF.Jgmts61_Amount := IF(~suppress_condition, ri.LnJJudgments[61].Amount, '');
    SELF.Jgmts61_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[61].ReleaseDate , ''); 
    SELF.Jgmts61_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[61].FilingDescription, '');
    SELF.Jgmts61_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[61].DateLastSeen, '');
    SELF.Jgmts61_Defendant:= IF(~suppress_condition, ri.LnJJudgments[61].Defendant, '');
    SELF.Jgmts61_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[61].Plaintiff, '');
    SELF.Jgmts61_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[61].FilingNumber, '');
    SELF.Jgmts61_FilingBook := IF(~suppress_condition, ri.LnJJudgments[61].FilingBook, '');
    SELF.Jgmts61_FilingPage := IF(~suppress_condition, ri.LnJJudgments[61].FilingPage, '');
    SELF.Jgmts61_Eviction := IF(~suppress_condition, ri.LnJJudgments[61].Eviction, '');
    SELF.Jgmts61_Agency := IF(~suppress_condition, ri.LnJJudgments[61].Agency, '');
    SELF.Jgmts61_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[61].AgencyCounty, '');
    SELF.Jgmts61_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[61].AgencyState , '');
    SELF.Jgmts61_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[61].ConsumerStatementId), '');
    SELF.Jgmts61_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[61].orig_rmsid, '');
    SELF.Jgmts62_Seq:= IF(~suppress_condition, ri.LnJJudgments[62].Seq , '');
    SELF.Jgmts62_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[62].DateFiled , '');
    SELF.Jgmts62_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[62].JudgmentTypeID, '');
    SELF.Jgmts62_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[62].JudgmentType, '');
    SELF.Jgmts62_Amount := IF(~suppress_condition, ri.LnJJudgments[62].Amount, '');
    SELF.Jgmts62_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[62].ReleaseDate , ''); 
    SELF.Jgmts62_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[62].FilingDescription, '');
    SELF.Jgmts62_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[62].DateLastSeen, '');
    SELF.Jgmts62_Defendant:= IF(~suppress_condition, ri.LnJJudgments[62].Defendant, '');
    SELF.Jgmts62_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[62].Plaintiff, '');
    SELF.Jgmts62_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[62].FilingNumber, '');
    SELF.Jgmts62_FilingBook := IF(~suppress_condition, ri.LnJJudgments[62].FilingBook, '');
    SELF.Jgmts62_FilingPage := IF(~suppress_condition, ri.LnJJudgments[62].FilingPage, '');
    SELF.Jgmts62_Eviction := IF(~suppress_condition, ri.LnJJudgments[62].Eviction, '');
    SELF.Jgmts62_Agency := IF(~suppress_condition, ri.LnJJudgments[62].Agency, '');
    SELF.Jgmts62_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[62].AgencyCounty, '');
    SELF.Jgmts62_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[62].AgencyState , '');
    SELF.Jgmts62_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[62].ConsumerStatementId), '');
    SELF.Jgmts62_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[62].orig_rmsid, '');
    SELF.Jgmts63_Seq:= IF(~suppress_condition, ri.LnJJudgments[63].Seq , '');
    SELF.Jgmts63_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[63].DateFiled , '');
    SELF.Jgmts63_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[63].JudgmentTypeID, '');
    SELF.Jgmts63_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[63].JudgmentType, '');
    SELF.Jgmts63_Amount := IF(~suppress_condition, ri.LnJJudgments[63].Amount, '');
    SELF.Jgmts63_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[63].ReleaseDate , ''); 
    SELF.Jgmts63_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[63].FilingDescription, '');
    SELF.Jgmts63_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[63].DateLastSeen, '');
    SELF.Jgmts63_Defendant:= IF(~suppress_condition, ri.LnJJudgments[63].Defendant, '');
    SELF.Jgmts63_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[63].Plaintiff, '');
    SELF.Jgmts63_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[63].FilingNumber, '');
    SELF.Jgmts63_FilingBook := IF(~suppress_condition, ri.LnJJudgments[63].FilingBook, '');
    SELF.Jgmts63_FilingPage := IF(~suppress_condition, ri.LnJJudgments[63].FilingPage, '');
    SELF.Jgmts63_Eviction := IF(~suppress_condition, ri.LnJJudgments[63].Eviction, '');
    SELF.Jgmts63_Agency := IF(~suppress_condition, ri.LnJJudgments[63].Agency, '');
    SELF.Jgmts63_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[63].AgencyCounty, '');
    SELF.Jgmts63_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[63].AgencyState , '');
    SELF.Jgmts63_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[63].ConsumerStatementId), '');
    SELF.Jgmts63_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[63].orig_rmsid, '');
    SELF.Jgmts64_Seq:= IF(~suppress_condition, ri.LnJJudgments[64].Seq , '');
    SELF.Jgmts64_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[64].DateFiled , '');
    SELF.Jgmts64_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[64].JudgmentTypeID, '');
    SELF.Jgmts64_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[64].JudgmentType, '');
    SELF.Jgmts64_Amount := IF(~suppress_condition, ri.LnJJudgments[64].Amount, '');
    SELF.Jgmts64_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[64].ReleaseDate , '');
    SELF.Jgmts64_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[64].FilingDescription, '');
    SELF.Jgmts64_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[64].DateLastSeen, '');
    SELF.Jgmts64_Defendant:= IF(~suppress_condition, ri.LnJJudgments[64].Defendant, '');
    SELF.Jgmts64_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[64].Plaintiff, '');
    SELF.Jgmts64_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[64].FilingNumber, '');
    SELF.Jgmts64_FilingBook := IF(~suppress_condition, ri.LnJJudgments[64].FilingBook, '');
    SELF.Jgmts64_FilingPage := IF(~suppress_condition, ri.LnJJudgments[64].FilingPage, '');
    SELF.Jgmts64_Eviction := IF(~suppress_condition, ri.LnJJudgments[64].Eviction, '');
    SELF.Jgmts64_Agency := IF(~suppress_condition, ri.LnJJudgments[64].Agency, '');
    SELF.Jgmts64_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[64].AgencyCounty, '');
    SELF.Jgmts64_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[64].AgencyState , '');
    SELF.Jgmts64_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[64].ConsumerStatementId), '');
    SELF.Jgmts64_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[64].orig_rmsid, '');
    SELF.Jgmts65_Seq:= IF(~suppress_condition, ri.LnJJudgments[65].Seq , '');
    SELF.Jgmts65_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[65].DateFiled , '');
    SELF.Jgmts65_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[65].JudgmentTypeID, '');
    SELF.Jgmts65_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[65].JudgmentType, '');
    SELF.Jgmts65_Amount := IF(~suppress_condition, ri.LnJJudgments[65].Amount, '');
    SELF.Jgmts65_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[65].ReleaseDate , '');
    SELF.Jgmts65_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[65].FilingDescription, '');
    SELF.Jgmts65_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[65].DateLastSeen, '');
    SELF.Jgmts65_Defendant:= IF(~suppress_condition, ri.LnJJudgments[65].Defendant, '');
    SELF.Jgmts65_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[65].Plaintiff, '');
    SELF.Jgmts65_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[65].FilingNumber, '');
    SELF.Jgmts65_FilingBook := IF(~suppress_condition, ri.LnJJudgments[65].FilingBook, '');
    SELF.Jgmts65_FilingPage := IF(~suppress_condition, ri.LnJJudgments[65].FilingPage, '');
    SELF.Jgmts65_Eviction := IF(~suppress_condition, ri.LnJJudgments[65].Eviction, '');
    SELF.Jgmts65_Agency := IF(~suppress_condition, ri.LnJJudgments[65].Agency, '');
    SELF.Jgmts65_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[65].AgencyCounty, '');
    SELF.Jgmts65_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[65].AgencyState , '');
    SELF.Jgmts65_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[65].ConsumerStatementId), '');
    SELF.Jgmts65_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[65].orig_rmsid, '');
    SELF.Jgmts66_Seq:= IF(~suppress_condition, ri.LnJJudgments[66].Seq , '');
    SELF.Jgmts66_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[66].DateFiled , '');
    SELF.Jgmts66_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[66].JudgmentTypeID, '');
    SELF.Jgmts66_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[66].JudgmentType, '');
    SELF.Jgmts66_Amount := IF(~suppress_condition, ri.LnJJudgments[66].Amount, '');
    SELF.Jgmts66_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[66].ReleaseDate , '');
    SELF.Jgmts66_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[66].FilingDescription, '');
    SELF.Jgmts66_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[66].DateLastSeen, '');
    SELF.Jgmts66_Defendant:= IF(~suppress_condition, ri.LnJJudgments[66].Defendant, '');
    SELF.Jgmts66_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[66].Plaintiff, '');
    SELF.Jgmts66_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[66].FilingNumber, '');
    SELF.Jgmts66_FilingBook := IF(~suppress_condition, ri.LnJJudgments[66].FilingBook, '');
    SELF.Jgmts66_FilingPage := IF(~suppress_condition, ri.LnJJudgments[66].FilingPage, '');
    SELF.Jgmts66_Eviction := IF(~suppress_condition, ri.LnJJudgments[66].Eviction, '');
    SELF.Jgmts66_Agency := IF(~suppress_condition, ri.LnJJudgments[66].Agency, '');
    SELF.Jgmts66_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[66].AgencyCounty, '');
    SELF.Jgmts66_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[66].AgencyState , '');
    SELF.Jgmts66_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[66].ConsumerStatementId), '');
    SELF.Jgmts66_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[66].orig_rmsid, '');
    SELF.Jgmts67_Seq:= IF(~suppress_condition, ri.LnJJudgments[67].Seq , '');
    SELF.Jgmts67_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[67].DateFiled , '');
    SELF.Jgmts67_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[67].JudgmentTypeID, '');
    SELF.Jgmts67_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[67].JudgmentType, '');
    SELF.Jgmts67_Amount := IF(~suppress_condition, ri.LnJJudgments[67].Amount, '');
    SELF.Jgmts67_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[67].ReleaseDate , '');
    SELF.Jgmts67_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[67].FilingDescription, '');
    SELF.Jgmts67_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[67].DateLastSeen, '');
    SELF.Jgmts67_Defendant:= IF(~suppress_condition, ri.LnJJudgments[67].Defendant, '');
    SELF.Jgmts67_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[67].Plaintiff, '');
    SELF.Jgmts67_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[67].FilingNumber, '');
    SELF.Jgmts67_FilingBook := IF(~suppress_condition, ri.LnJJudgments[67].FilingBook, '');
    SELF.Jgmts67_FilingPage := IF(~suppress_condition, ri.LnJJudgments[67].FilingPage, '');
    SELF.Jgmts67_Eviction := IF(~suppress_condition, ri.LnJJudgments[67].Eviction, '');
    SELF.Jgmts67_Agency := IF(~suppress_condition, ri.LnJJudgments[67].Agency, '');
    SELF.Jgmts67_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[67].AgencyCounty, '');
    SELF.Jgmts67_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[67].AgencyState , '');
    SELF.Jgmts67_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[67].ConsumerStatementId), '');
    SELF.Jgmts67_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[67].orig_rmsid, '');
    SELF.Jgmts68_Seq:= IF(~suppress_condition, ri.LnJJudgments[68].Seq , '');
    SELF.Jgmts68_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[68].DateFiled , '');
    SELF.Jgmts68_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[68].JudgmentTypeID, '');
    SELF.Jgmts68_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[68].JudgmentType, '');
    SELF.Jgmts68_Amount := IF(~suppress_condition, ri.LnJJudgments[68].Amount, '');
    SELF.Jgmts68_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[68].ReleaseDate , ''); 
    SELF.Jgmts68_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[68].FilingDescription, '');
    SELF.Jgmts68_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[68].DateLastSeen, '');
    SELF.Jgmts68_Defendant:= IF(~suppress_condition, ri.LnJJudgments[68].Defendant, '');
    SELF.Jgmts68_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[68].Plaintiff, '');
    SELF.Jgmts68_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[68].FilingNumber, '');
    SELF.Jgmts68_FilingBook := IF(~suppress_condition, ri.LnJJudgments[68].FilingBook, '');
    SELF.Jgmts68_FilingPage := IF(~suppress_condition, ri.LnJJudgments[68].FilingPage, '');
    SELF.Jgmts68_Eviction := IF(~suppress_condition, ri.LnJJudgments[68].Eviction, '');
    SELF.Jgmts68_Agency := IF(~suppress_condition, ri.LnJJudgments[68].Agency, '');
    SELF.Jgmts68_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[68].AgencyCounty, '');
    SELF.Jgmts68_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[68].AgencyState , '');
    SELF.Jgmts68_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[68].ConsumerStatementId), '');
    SELF.Jgmts68_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[68].orig_rmsid, '');
    SELF.Jgmts69_Seq:= IF(~suppress_condition, ri.LnJJudgments[69].Seq , '');
    SELF.Jgmts69_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[69].DateFiled , '');
    SELF.Jgmts69_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[69].JudgmentTypeID, '');
    SELF.Jgmts69_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[69].JudgmentType, '');
    SELF.Jgmts69_Amount := IF(~suppress_condition, ri.LnJJudgments[69].Amount, '');
    SELF.Jgmts69_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[69].ReleaseDate , ''); 
    SELF.Jgmts69_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[69].FilingDescription, '');
    SELF.Jgmts69_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[69].DateLastSeen, '');
    SELF.Jgmts69_Defendant:= IF(~suppress_condition, ri.LnJJudgments[69].Defendant, '');
    SELF.Jgmts69_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[69].Plaintiff, '');
    SELF.Jgmts69_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[69].FilingNumber, '');
    SELF.Jgmts69_FilingBook := IF(~suppress_condition, ri.LnJJudgments[69].FilingBook, '');
    SELF.Jgmts69_FilingPage := IF(~suppress_condition, ri.LnJJudgments[69].FilingPage, '');
    SELF.Jgmts69_Eviction := IF(~suppress_condition, ri.LnJJudgments[69].Eviction, '');
    SELF.Jgmts69_Agency := IF(~suppress_condition, ri.LnJJudgments[69].Agency, '');
    SELF.Jgmts69_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[69].AgencyCounty, '');
    SELF.Jgmts69_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[69].AgencyState , '');
    SELF.Jgmts69_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[69].ConsumerStatementId), '');
    SELF.Jgmts69_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[69].orig_rmsid, '');
    SELF.Jgmts70_Seq := IF(~suppress_condition, ri.LnJJudgments[70].Seq, '');
    SELF.Jgmts70_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[70].DateFiled , '');
    SELF.Jgmts70_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[70].JudgmentTypeID, '');
    SELF.Jgmts70_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[70].JudgmentType, '');
    SELF.Jgmts70_Amount := IF(~suppress_condition, ri.LnJJudgments[70].Amount, '');
    SELF.Jgmts70_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[70].ReleaseDate , '');
    SELF.Jgmts70_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[70].FilingDescription, '');
    SELF.Jgmts70_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[70].DateLastSeen, '');
    SELF.Jgmts70_Defendant:= IF(~suppress_condition, ri.LnJJudgments[70].Defendant, '');
    SELF.Jgmts70_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[70].Plaintiff, '');
    SELF.Jgmts70_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[70].FilingNumber, '');
    SELF.Jgmts70_FilingBook := IF(~suppress_condition, ri.LnJJudgments[70].FilingBook, '');
    SELF.Jgmts70_FilingPage := IF(~suppress_condition, ri.LnJJudgments[70].FilingPage, '');
    SELF.Jgmts70_Eviction := IF(~suppress_condition, ri.LnJJudgments[70].Eviction, '');
    SELF.Jgmts70_Agency := IF(~suppress_condition, ri.LnJJudgments[70].Agency, '');
    SELF.Jgmts70_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[70].AgencyCounty, '');
    SELF.Jgmts70_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[70].AgencyState , '');
    SELF.Jgmts70_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[70].ConsumerStatementId), '');
    SELF.Jgmts70_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[70].orig_rmsid, '');
    SELF.Jgmts71_Seq:= IF(~suppress_condition, ri.LnJJudgments[71].Seq , '');
    SELF.Jgmts71_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[71].DateFiled , '');
    SELF.Jgmts71_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[71].JudgmentTypeID, '');
    SELF.Jgmts71_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[71].JudgmentType, '');
    SELF.Jgmts71_Amount := IF(~suppress_condition, ri.LnJJudgments[71].Amount, '');
    SELF.Jgmts71_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[71].ReleaseDate , '');
    SELF.Jgmts71_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[71].FilingDescription, '');
    SELF.Jgmts71_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[71].DateLastSeen, '');
    SELF.Jgmts71_Defendant:= IF(~suppress_condition, ri.LnJJudgments[71].Defendant, '');
    SELF.Jgmts71_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[71].Plaintiff, '');
    SELF.Jgmts71_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[71].FilingNumber, '');
    SELF.Jgmts71_FilingBook := IF(~suppress_condition, ri.LnJJudgments[71].FilingBook, '');
    SELF.Jgmts71_FilingPage := IF(~suppress_condition, ri.LnJJudgments[71].FilingPage, '');
    SELF.Jgmts71_Eviction := IF(~suppress_condition, ri.LnJJudgments[71].Eviction, '');
    SELF.Jgmts71_Agency := IF(~suppress_condition, ri.LnJJudgments[71].Agency, '');
    SELF.Jgmts71_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[71].AgencyCounty, '');
    SELF.Jgmts71_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[71].AgencyState , '');
    SELF.Jgmts71_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[71].ConsumerStatementId), '');
    SELF.Jgmts71_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[71].orig_rmsid, '');
    SELF.Jgmts72_Seq:= IF(~suppress_condition, ri.LnJJudgments[72].Seq , '');
    SELF.Jgmts72_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[72].DateFiled , '');
    SELF.Jgmts72_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[72].JudgmentTypeID, '');
    SELF.Jgmts72_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[72].JudgmentType, '');
    SELF.Jgmts72_Amount := IF(~suppress_condition, ri.LnJJudgments[72].Amount, '');
    SELF.Jgmts72_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[72].ReleaseDate , ''); 
    SELF.Jgmts72_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[72].FilingDescription, '');
    SELF.Jgmts72_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[72].DateLastSeen, '');
    SELF.Jgmts72_Defendant:= IF(~suppress_condition, ri.LnJJudgments[72].Defendant, '');
    SELF.Jgmts72_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[72].Plaintiff, '');
    SELF.Jgmts72_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[72].FilingNumber, '');
    SELF.Jgmts72_FilingBook := IF(~suppress_condition, ri.LnJJudgments[72].FilingBook, '');
    SELF.Jgmts72_FilingPage := IF(~suppress_condition, ri.LnJJudgments[72].FilingPage, '');
    SELF.Jgmts72_Eviction := IF(~suppress_condition, ri.LnJJudgments[72].Eviction, '');
    SELF.Jgmts72_Agency := IF(~suppress_condition, ri.LnJJudgments[72].Agency, '');
    SELF.Jgmts72_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[72].AgencyCounty, '');
    SELF.Jgmts72_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[72].AgencyState , '');
    SELF.Jgmts72_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[72].ConsumerStatementId), '');
    SELF.Jgmts72_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[72].orig_rmsid, '');
    SELF.Jgmts73_Seq:= IF(~suppress_condition, ri.LnJJudgments[73].Seq , '');
    SELF.Jgmts73_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[73].DateFiled , '');
    SELF.Jgmts73_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[73].JudgmentTypeID, '');
    SELF.Jgmts73_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[73].JudgmentType, '');
    SELF.Jgmts73_Amount := IF(~suppress_condition, ri.LnJJudgments[73].Amount, '');
    SELF.Jgmts73_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[73].ReleaseDate , ''); 
    SELF.Jgmts73_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[73].FilingDescription, '');
    SELF.Jgmts73_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[73].DateLastSeen, '');
    SELF.Jgmts73_Defendant:= IF(~suppress_condition, ri.LnJJudgments[73].Defendant, '');
    SELF.Jgmts73_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[73].Plaintiff, '');
    SELF.Jgmts73_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[73].FilingNumber, '');
    SELF.Jgmts73_FilingBook := IF(~suppress_condition, ri.LnJJudgments[73].FilingBook, '');
    SELF.Jgmts73_FilingPage := IF(~suppress_condition, ri.LnJJudgments[73].FilingPage, '');
    SELF.Jgmts73_Eviction := IF(~suppress_condition, ri.LnJJudgments[73].Eviction, '');
    SELF.Jgmts73_Agency := IF(~suppress_condition, ri.LnJJudgments[73].Agency, '');
    SELF.Jgmts73_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[73].AgencyCounty, '');
    SELF.Jgmts73_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[73].AgencyState , '');
    SELF.Jgmts73_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[73].ConsumerStatementId), '');
    SELF.Jgmts73_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[73].orig_rmsid, '');
    SELF.Jgmts74_Seq:= IF(~suppress_condition, ri.LnJJudgments[74].Seq , '');
    SELF.Jgmts74_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[74].DateFiled , '');
    SELF.Jgmts74_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[74].JudgmentTypeID, '');
    SELF.Jgmts74_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[74].JudgmentType, '');
    SELF.Jgmts74_Amount := IF(~suppress_condition, ri.LnJJudgments[74].Amount, '');
    SELF.Jgmts74_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[74].ReleaseDate , ''); 
    SELF.Jgmts74_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[74].FilingDescription, '');
    SELF.Jgmts74_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[74].DateLastSeen, '');
    SELF.Jgmts74_Defendant:= IF(~suppress_condition, ri.LnJJudgments[74].Defendant, '');
    SELF.Jgmts74_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[74].Plaintiff, '');
    SELF.Jgmts74_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[74].FilingNumber, '');
    SELF.Jgmts74_FilingBook := IF(~suppress_condition, ri.LnJJudgments[74].FilingBook, '');
    SELF.Jgmts74_FilingPage := IF(~suppress_condition, ri.LnJJudgments[74].FilingPage, '');
    SELF.Jgmts74_Eviction := IF(~suppress_condition, ri.LnJJudgments[74].Eviction, '');
    SELF.Jgmts74_Agency := IF(~suppress_condition, ri.LnJJudgments[74].Agency, '');
    SELF.Jgmts74_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[74].AgencyCounty, '');
    SELF.Jgmts74_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[74].AgencyState , '');
    SELF.Jgmts74_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[74].ConsumerStatementId), '');
    SELF.Jgmts74_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[74].orig_rmsid, '');
    SELF.Jgmts75_Seq:= IF(~suppress_condition, ri.LnJJudgments[75].Seq , '');
    SELF.Jgmts75_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[75].DateFiled , '');
    SELF.Jgmts75_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[75].JudgmentTypeID, '');
    SELF.Jgmts75_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[75].JudgmentType, '');
    SELF.Jgmts75_Amount := IF(~suppress_condition, ri.LnJJudgments[75].Amount, '');
    SELF.Jgmts75_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[75].ReleaseDate , '');
    SELF.Jgmts75_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[75].FilingDescription, '');
    SELF.Jgmts75_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[75].DateLastSeen, '');
    SELF.Jgmts75_Defendant:= IF(~suppress_condition, ri.LnJJudgments[75].Defendant, '');
    SELF.Jgmts75_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[75].Plaintiff, '');
    SELF.Jgmts75_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[75].FilingNumber, '');
    SELF.Jgmts75_FilingBook := IF(~suppress_condition, ri.LnJJudgments[75].FilingBook, '');
    SELF.Jgmts75_FilingPage := IF(~suppress_condition, ri.LnJJudgments[75].FilingPage, '');
    SELF.Jgmts75_Eviction := IF(~suppress_condition, ri.LnJJudgments[75].Eviction, '');
    SELF.Jgmts75_Agency := IF(~suppress_condition, ri.LnJJudgments[75].Agency, '');
    SELF.Jgmts75_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[75].AgencyCounty, '');
    SELF.Jgmts75_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[75].AgencyState , '');
    SELF.Jgmts75_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[75].ConsumerStatementId), '');
    SELF.Jgmts75_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[75].orig_rmsid, '');
    SELF.Jgmts76_Seq:= IF(~suppress_condition, ri.LnJJudgments[76].Seq , '');
    SELF.Jgmts76_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[76].DateFiled , '');
    SELF.Jgmts76_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[76].JudgmentTypeID, '');
    SELF.Jgmts76_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[76].JudgmentType, '');
    SELF.Jgmts76_Amount := IF(~suppress_condition, ri.LnJJudgments[76].Amount, '');
    SELF.Jgmts76_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[76].ReleaseDate , '');
    SELF.Jgmts76_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[76].FilingDescription, '');
    SELF.Jgmts76_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[76].DateLastSeen, '');
    SELF.Jgmts76_Defendant:= IF(~suppress_condition, ri.LnJJudgments[76].Defendant, '');
    SELF.Jgmts76_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[76].Plaintiff, '');
    SELF.Jgmts76_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[76].FilingNumber, '');
    SELF.Jgmts76_FilingBook := IF(~suppress_condition, ri.LnJJudgments[76].FilingBook, '');
    SELF.Jgmts76_FilingPage := IF(~suppress_condition, ri.LnJJudgments[76].FilingPage, '');
    SELF.Jgmts76_Eviction := IF(~suppress_condition, ri.LnJJudgments[76].Eviction, '');
    SELF.Jgmts76_Agency := IF(~suppress_condition, ri.LnJJudgments[76].Agency, '');
    SELF.Jgmts76_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[76].AgencyCounty, '');
    SELF.Jgmts76_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[76].AgencyState , '');
    SELF.Jgmts76_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[76].ConsumerStatementId), '');
    SELF.Jgmts76_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[76].orig_rmsid, '');
    SELF.Jgmts77_Seq:= IF(~suppress_condition, ri.LnJJudgments[77].Seq , '');
    SELF.Jgmts77_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[77].DateFiled , '');
    SELF.Jgmts77_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[77].JudgmentTypeID, '');
    SELF.Jgmts77_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[77].JudgmentType, '');
    SELF.Jgmts77_Amount := IF(~suppress_condition, ri.LnJJudgments[77].Amount, '');
    SELF.Jgmts77_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[77].ReleaseDate , '');
    SELF.Jgmts77_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[77].FilingDescription, '');
    SELF.Jgmts77_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[77].DateLastSeen, '');
    SELF.Jgmts77_Defendant:= IF(~suppress_condition, ri.LnJJudgments[77].Defendant, '');
    SELF.Jgmts77_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[77].Plaintiff, '');
    SELF.Jgmts77_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[77].FilingNumber, '');
    SELF.Jgmts77_FilingBook := IF(~suppress_condition, ri.LnJJudgments[77].FilingBook, '');
    SELF.Jgmts77_FilingPage := IF(~suppress_condition, ri.LnJJudgments[77].FilingPage, '');
    SELF.Jgmts77_Eviction := IF(~suppress_condition, ri.LnJJudgments[77].Eviction, '');
    SELF.Jgmts77_Agency := IF(~suppress_condition, ri.LnJJudgments[77].Agency, '');
    SELF.Jgmts77_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[77].AgencyCounty, '');
    SELF.Jgmts77_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[77].AgencyState , '');
    SELF.Jgmts77_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[77].ConsumerStatementId), '');
    SELF.Jgmts77_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[77].orig_rmsid, '');
    SELF.Jgmts78_Seq:= IF(~suppress_condition, ri.LnJJudgments[78].Seq , '');
    SELF.Jgmts78_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[78].DateFiled , '');
    SELF.Jgmts78_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[78].JudgmentTypeID, '');
    SELF.Jgmts78_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[78].JudgmentType, '');
    SELF.Jgmts78_Amount := IF(~suppress_condition, ri.LnJJudgments[78].Amount, '');
    SELF.Jgmts78_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[78].ReleaseDate , '');
    SELF.Jgmts78_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[78].FilingDescription, '');
    SELF.Jgmts78_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[78].DateLastSeen, '');
    SELF.Jgmts78_Defendant:= IF(~suppress_condition, ri.LnJJudgments[78].Defendant, '');
    SELF.Jgmts78_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[78].Plaintiff, '');
    SELF.Jgmts78_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[78].FilingNumber, '');
    SELF.Jgmts78_FilingBook := IF(~suppress_condition, ri.LnJJudgments[78].FilingBook, '');
    SELF.Jgmts78_FilingPage := IF(~suppress_condition, ri.LnJJudgments[78].FilingPage, '');
    SELF.Jgmts78_Eviction := IF(~suppress_condition, ri.LnJJudgments[78].Eviction, '');
    SELF.Jgmts78_Agency := IF(~suppress_condition, ri.LnJJudgments[78].Agency, '');
    SELF.Jgmts78_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[78].AgencyCounty, '');
    SELF.Jgmts78_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[78].AgencyState , '');
    SELF.Jgmts78_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[78].ConsumerStatementId), '');
    SELF.Jgmts78_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[78].orig_rmsid, '');
    SELF.Jgmts79_Seq:= IF(~suppress_condition, ri.LnJJudgments[79].Seq , '');
    SELF.Jgmts79_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[79].DateFiled , '');
    SELF.Jgmts79_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[79].JudgmentTypeID, '');
    SELF.Jgmts79_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[79].JudgmentType, '');
    SELF.Jgmts79_Amount := IF(~suppress_condition, ri.LnJJudgments[79].Amount, '');
    SELF.Jgmts79_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[79].ReleaseDate , '');
    SELF.Jgmts79_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[79].FilingDescription, '');
    SELF.Jgmts79_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[79].DateLastSeen, '');
    SELF.Jgmts79_Defendant:= IF(~suppress_condition, ri.LnJJudgments[79].Defendant, '');
    SELF.Jgmts79_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[79].Plaintiff, '');
    SELF.Jgmts79_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[79].FilingNumber, '');
    SELF.Jgmts79_FilingBook := IF(~suppress_condition, ri.LnJJudgments[79].FilingBook, '');
    SELF.Jgmts79_FilingPage := IF(~suppress_condition, ri.LnJJudgments[79].FilingPage, '');
    SELF.Jgmts79_Eviction := IF(~suppress_condition, ri.LnJJudgments[79].Eviction, '');
    SELF.Jgmts79_Agency := IF(~suppress_condition, ri.LnJJudgments[79].Agency, '');
    SELF.Jgmts79_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[79].AgencyCounty, '');
    SELF.Jgmts79_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[79].AgencyState , '');
    SELF.Jgmts79_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[79].ConsumerStatementId), '');
    SELF.Jgmts79_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[79].orig_rmsid, '');
    SELF.Jgmts80_Seq:= IF(~suppress_condition, ri.LnJJudgments[80].Seq , '');
    SELF.Jgmts80_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[80].DateFiled , '');
    SELF.Jgmts80_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[80].JudgmentTypeID, '');
    SELF.Jgmts80_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[80].JudgmentType, '');
    SELF.Jgmts80_Amount := IF(~suppress_condition, ri.LnJJudgments[80].Amount, '');
    SELF.Jgmts80_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[80].ReleaseDate , '');
    SELF.Jgmts80_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[80].FilingDescription, '');
    SELF.Jgmts80_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[80].DateLastSeen, '');
    SELF.Jgmts80_Defendant:= IF(~suppress_condition, ri.LnJJudgments[80].Defendant, '');
    SELF.Jgmts80_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[80].Plaintiff, '');
    SELF.Jgmts80_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[80].FilingNumber, '');
    SELF.Jgmts80_FilingBook := IF(~suppress_condition, ri.LnJJudgments[80].FilingBook, '');
    SELF.Jgmts80_FilingPage := IF(~suppress_condition, ri.LnJJudgments[80].FilingPage, '');
    SELF.Jgmts80_Eviction := IF(~suppress_condition, ri.LnJJudgments[80].Eviction, '');
    SELF.Jgmts80_Agency := IF(~suppress_condition, ri.LnJJudgments[80].Agency, '');
    SELF.Jgmts80_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[80].AgencyCounty, '');
    SELF.Jgmts80_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[80].AgencyState , '');
    SELF.Jgmts80_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[80].ConsumerStatementId), '');
    SELF.Jgmts80_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[80].orig_rmsid, '');
    SELF.Jgmts81_Seq:= IF(~suppress_condition, ri.LnJJudgments[81].Seq , '');
    SELF.Jgmts81_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[81].DateFiled , '');
    SELF.Jgmts81_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[81].JudgmentTypeID, '');
    SELF.Jgmts81_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[81].JudgmentType, '');
    SELF.Jgmts81_Amount := IF(~suppress_condition, ri.LnJJudgments[81].Amount, '');
    SELF.Jgmts81_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[81].ReleaseDate , '');
    SELF.Jgmts81_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[81].FilingDescription, '');
    SELF.Jgmts81_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[81].DateLastSeen, '');
    SELF.Jgmts81_Defendant:= IF(~suppress_condition, ri.LnJJudgments[81].Defendant, '');
    SELF.Jgmts81_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[81].Plaintiff, '');
    SELF.Jgmts81_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[81].FilingNumber, '');
    SELF.Jgmts81_FilingBook := IF(~suppress_condition, ri.LnJJudgments[81].FilingBook, '');
    SELF.Jgmts81_FilingPage := IF(~suppress_condition, ri.LnJJudgments[81].FilingPage, '');
    SELF.Jgmts81_Eviction := IF(~suppress_condition, ri.LnJJudgments[81].Eviction, '');
    SELF.Jgmts81_Agency := IF(~suppress_condition, ri.LnJJudgments[81].Agency, '');
    SELF.Jgmts81_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[81].AgencyCounty, '');
    SELF.Jgmts81_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[81].AgencyState , '');
    SELF.Jgmts81_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[81].ConsumerStatementId), '');
    SELF.Jgmts81_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[81].orig_rmsid, '');
    SELF.Jgmts82_Seq:= IF(~suppress_condition, ri.LnJJudgments[82].Seq , '');
    SELF.Jgmts82_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[82].DateFiled , '');
    SELF.Jgmts82_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[82].JudgmentTypeID, '');
    SELF.Jgmts82_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[82].JudgmentType, '');
    SELF.Jgmts82_Amount := IF(~suppress_condition, ri.LnJJudgments[82].Amount, '');
    SELF.Jgmts82_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[82].ReleaseDate , '');
    SELF.Jgmts82_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[82].FilingDescription, '');
    SELF.Jgmts82_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[82].DateLastSeen, '');
    SELF.Jgmts82_Defendant:= IF(~suppress_condition, ri.LnJJudgments[82].Defendant, '');
    SELF.Jgmts82_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[82].Plaintiff, '');
    SELF.Jgmts82_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[82].FilingNumber, '');
    SELF.Jgmts82_FilingBook := IF(~suppress_condition, ri.LnJJudgments[82].FilingBook, '');
    SELF.Jgmts82_FilingPage := IF(~suppress_condition, ri.LnJJudgments[82].FilingPage, '');
    SELF.Jgmts82_Eviction := IF(~suppress_condition, ri.LnJJudgments[82].Eviction, '');
    SELF.Jgmts82_Agency := IF(~suppress_condition, ri.LnJJudgments[82].Agency, '');
    SELF.Jgmts82_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[82].AgencyCounty, '');
    SELF.Jgmts82_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[82].AgencyState , '');
    SELF.Jgmts82_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[82].ConsumerStatementId), '');
    SELF.Jgmts82_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[82].orig_rmsid, '');
    SELF.Jgmts83_Seq:= IF(~suppress_condition, ri.LnJJudgments[83].Seq , '');
    SELF.Jgmts83_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[83].DateFiled , '');
    SELF.Jgmts83_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[83].JudgmentTypeID, '');
    SELF.Jgmts83_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[83].JudgmentType, '');
    SELF.Jgmts83_Amount := IF(~suppress_condition, ri.LnJJudgments[83].Amount, '');
    SELF.Jgmts83_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[83].ReleaseDate , '');
    SELF.Jgmts83_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[83].FilingDescription, '');
    SELF.Jgmts83_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[83].DateLastSeen, '');
    SELF.Jgmts83_Defendant:= IF(~suppress_condition, ri.LnJJudgments[83].Defendant, '');
    SELF.Jgmts83_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[83].Plaintiff, '');
    SELF.Jgmts83_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[83].FilingNumber, '');
    SELF.Jgmts83_FilingBook := IF(~suppress_condition, ri.LnJJudgments[83].FilingBook, '');
    SELF.Jgmts83_FilingPage := IF(~suppress_condition, ri.LnJJudgments[83].FilingPage, '');
    SELF.Jgmts83_Eviction := IF(~suppress_condition, ri.LnJJudgments[83].Eviction, '');
    SELF.Jgmts83_Agency := IF(~suppress_condition, ri.LnJJudgments[83].Agency, '');
    SELF.Jgmts83_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[83].AgencyCounty, '');
    SELF.Jgmts83_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[83].AgencyState , '');
    SELF.Jgmts83_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[83].ConsumerStatementId), '');
    SELF.Jgmts83_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[83].orig_rmsid, '');
    SELF.Jgmts84_Seq:= IF(~suppress_condition, ri.LnJJudgments[84].Seq , '');
    SELF.Jgmts84_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[84].DateFiled , '');
    SELF.Jgmts84_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[84].JudgmentTypeID, '');
    SELF.Jgmts84_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[84].JudgmentType, '');
    SELF.Jgmts84_Amount := IF(~suppress_condition, ri.LnJJudgments[84].Amount, '');
    SELF.Jgmts84_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[84].ReleaseDate , '');
    SELF.Jgmts84_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[84].FilingDescription, '');
    SELF.Jgmts84_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[84].DateLastSeen, '');
    SELF.Jgmts84_Defendant:= IF(~suppress_condition, ri.LnJJudgments[84].Defendant, '');
    SELF.Jgmts84_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[84].Plaintiff, '');
    SELF.Jgmts84_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[84].FilingNumber, '');
    SELF.Jgmts84_FilingBook := IF(~suppress_condition, ri.LnJJudgments[84].FilingBook, '');
    SELF.Jgmts84_FilingPage := IF(~suppress_condition, ri.LnJJudgments[84].FilingPage, '');
    SELF.Jgmts84_Eviction := IF(~suppress_condition, ri.LnJJudgments[84].Eviction, '');
    SELF.Jgmts84_Agency := IF(~suppress_condition, ri.LnJJudgments[84].Agency, '');
    SELF.Jgmts84_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[84].AgencyCounty, '');
    SELF.Jgmts84_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[84].AgencyState , '');
    SELF.Jgmts84_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[84].ConsumerStatementId), '');
    SELF.Jgmts84_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[84].orig_rmsid, '');
    SELF.Jgmts85_Seq:= IF(~suppress_condition, ri.LnJJudgments[85].Seq , '');
    SELF.Jgmts85_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[85].DateFiled , '');
    SELF.Jgmts85_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[85].JudgmentTypeID, '');
    SELF.Jgmts85_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[85].JudgmentType, '');
    SELF.Jgmts85_Amount := IF(~suppress_condition, ri.LnJJudgments[85].Amount, '');
    SELF.Jgmts85_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[85].ReleaseDate , '');
    SELF.Jgmts85_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[85].FilingDescription, '');
    SELF.Jgmts85_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[85].DateLastSeen, '');
    SELF.Jgmts85_Defendant:= IF(~suppress_condition, ri.LnJJudgments[85].Defendant, '');
    SELF.Jgmts85_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[85].Plaintiff, '');
    SELF.Jgmts85_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[85].FilingNumber, '');
    SELF.Jgmts85_FilingBook := IF(~suppress_condition, ri.LnJJudgments[85].FilingBook, '');
    SELF.Jgmts85_FilingPage := IF(~suppress_condition, ri.LnJJudgments[85].FilingPage, '');
    SELF.Jgmts85_Eviction := IF(~suppress_condition, ri.LnJJudgments[85].Eviction, '');
    SELF.Jgmts85_Agency := IF(~suppress_condition, ri.LnJJudgments[85].Agency, '');
    SELF.Jgmts85_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[85].AgencyCounty, '');
    SELF.Jgmts85_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[85].AgencyState , '');
    SELF.Jgmts85_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[85].ConsumerStatementId), '');
    SELF.Jgmts85_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[85].orig_rmsid, '');
    SELF.Jgmts86_Seq:= IF(~suppress_condition, ri.LnJJudgments[86].Seq , '');
    SELF.Jgmts86_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[86].DateFiled , '');
    SELF.Jgmts86_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[86].JudgmentTypeID, '');
    SELF.Jgmts86_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[86].JudgmentType, '');
    SELF.Jgmts86_Amount := IF(~suppress_condition, ri.LnJJudgments[86].Amount, '');
    SELF.Jgmts86_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[86].ReleaseDate , '');
    SELF.Jgmts86_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[86].FilingDescription, '');
    SELF.Jgmts86_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[86].DateLastSeen, '');
    SELF.Jgmts86_Defendant:= IF(~suppress_condition, ri.LnJJudgments[86].Defendant, '');
    SELF.Jgmts86_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[86].Plaintiff, '');
    SELF.Jgmts86_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[86].FilingNumber, '');
    SELF.Jgmts86_FilingBook := IF(~suppress_condition, ri.LnJJudgments[86].FilingBook, '');
    SELF.Jgmts86_FilingPage := IF(~suppress_condition, ri.LnJJudgments[86].FilingPage, '');
    SELF.Jgmts86_Eviction := IF(~suppress_condition, ri.LnJJudgments[86].Eviction, '');
    SELF.Jgmts86_Agency := IF(~suppress_condition, ri.LnJJudgments[86].Agency, '');
    SELF.Jgmts86_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[86].AgencyCounty, '');
    SELF.Jgmts86_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[86].AgencyState , '');
    SELF.Jgmts86_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[86].ConsumerStatementId), '');
    SELF.Jgmts86_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[86].orig_rmsid, '');
    SELF.Jgmts87_Seq:= IF(~suppress_condition, ri.LnJJudgments[87].Seq , '');
    SELF.Jgmts87_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[87].DateFiled , '');
    SELF.Jgmts87_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[87].JudgmentTypeID, '');
    SELF.Jgmts87_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[87].JudgmentType, '');
    SELF.Jgmts87_Amount := IF(~suppress_condition, ri.LnJJudgments[87].Amount, '');
    SELF.Jgmts87_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[87].ReleaseDate , ''); 
    SELF.Jgmts87_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[87].FilingDescription, '');
    SELF.Jgmts87_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[87].DateLastSeen, '');
    SELF.Jgmts87_Defendant:= IF(~suppress_condition, ri.LnJJudgments[87].Defendant, '');
    SELF.Jgmts87_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[87].Plaintiff, '');
    SELF.Jgmts87_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[87].FilingNumber, '');
    SELF.Jgmts87_FilingBook := IF(~suppress_condition, ri.LnJJudgments[87].FilingBook, '');
    SELF.Jgmts87_FilingPage := IF(~suppress_condition, ri.LnJJudgments[87].FilingPage, '');
    SELF.Jgmts87_Eviction := IF(~suppress_condition, ri.LnJJudgments[87].Eviction, '');
    SELF.Jgmts87_Agency := IF(~suppress_condition, ri.LnJJudgments[87].Agency, '');
    SELF.Jgmts87_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[87].AgencyCounty, '');
    SELF.Jgmts87_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[87].AgencyState , '');
    SELF.Jgmts87_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[87].ConsumerStatementId), '');
    SELF.Jgmts87_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[87].orig_rmsid, '');
    SELF.Jgmts88_Seq:= IF(~suppress_condition, ri.LnJJudgments[88].Seq , '');
    SELF.Jgmts88_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[88].DateFiled , '');
    SELF.Jgmts88_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[88].JudgmentTypeID, '');
    SELF.Jgmts88_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[88].JudgmentType, '');
    SELF.Jgmts88_Amount := IF(~suppress_condition, ri.LnJJudgments[88].Amount, '');
    SELF.Jgmts88_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[88].ReleaseDate , '');
    SELF.Jgmts88_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[88].FilingDescription, '');
    SELF.Jgmts88_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[88].DateLastSeen, '');
    SELF.Jgmts88_Defendant:= IF(~suppress_condition, ri.LnJJudgments[88].Defendant, '');
    SELF.Jgmts88_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[88].Plaintiff, '');
    SELF.Jgmts88_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[88].FilingNumber, '');
    SELF.Jgmts88_FilingBook := IF(~suppress_condition, ri.LnJJudgments[88].FilingBook, '');
    SELF.Jgmts88_FilingPage := IF(~suppress_condition, ri.LnJJudgments[88].FilingPage, '');
    SELF.Jgmts88_Eviction := IF(~suppress_condition, ri.LnJJudgments[88].Eviction, '');
    SELF.Jgmts88_Agency := IF(~suppress_condition, ri.LnJJudgments[88].Agency, '');
    SELF.Jgmts88_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[88].AgencyCounty, '');
    SELF.Jgmts88_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[88].AgencyState , '');
    SELF.Jgmts88_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[88].ConsumerStatementId), '');
    SELF.Jgmts88_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[88].orig_rmsid, '');
    SELF.Jgmts89_Seq:= IF(~suppress_condition, ri.LnJJudgments[89].Seq , '');
    SELF.Jgmts89_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[89].DateFiled , '');
    SELF.Jgmts89_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[89].JudgmentTypeID, '');
    SELF.Jgmts89_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[89].JudgmentType, '');
    SELF.Jgmts89_Amount := IF(~suppress_condition, ri.LnJJudgments[89].Amount, '');
    SELF.Jgmts89_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[89].ReleaseDate , '');
    SELF.Jgmts89_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[89].FilingDescription, '');
    SELF.Jgmts89_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[89].DateLastSeen, '');
    SELF.Jgmts89_Defendant:= IF(~suppress_condition, ri.LnJJudgments[89].Defendant, '');
    SELF.Jgmts89_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[89].Plaintiff, '');
    SELF.Jgmts89_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[89].FilingNumber, '');
    SELF.Jgmts89_FilingBook := IF(~suppress_condition, ri.LnJJudgments[89].FilingBook, '');
    SELF.Jgmts89_FilingPage := IF(~suppress_condition, ri.LnJJudgments[89].FilingPage, '');
    SELF.Jgmts89_Eviction := IF(~suppress_condition, ri.LnJJudgments[89].Eviction, '');
    SELF.Jgmts89_Agency := IF(~suppress_condition, ri.LnJJudgments[89].Agency, '');
    SELF.Jgmts89_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[89].AgencyCounty, '');
    SELF.Jgmts89_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[89].AgencyState , '');
    SELF.Jgmts89_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[89].ConsumerStatementId), '');
    SELF.Jgmts89_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[89].orig_rmsid, '');
    SELF.Jgmts90_Seq:= IF(~suppress_condition, ri.LnJJudgments[90].Seq , '');
    SELF.Jgmts90_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[90].DateFiled , '');
    SELF.Jgmts90_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[90].JudgmentTypeID, '');
    SELF.Jgmts90_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[90].JudgmentType, '');
    SELF.Jgmts90_Amount := IF(~suppress_condition, ri.LnJJudgments[90].Amount, '');
    SELF.Jgmts90_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[90].ReleaseDate , ''); 
    SELF.Jgmts90_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[90].FilingDescription, '');
    SELF.Jgmts90_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[90].DateLastSeen, '');
    SELF.Jgmts90_Defendant:= IF(~suppress_condition, ri.LnJJudgments[90].Defendant, '');
    SELF.Jgmts90_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[90].Plaintiff, '');
    SELF.Jgmts90_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[90].FilingNumber, '');
    SELF.Jgmts90_FilingBook := IF(~suppress_condition, ri.LnJJudgments[90].FilingBook, '');
    SELF.Jgmts90_FilingPage := IF(~suppress_condition, ri.LnJJudgments[90].FilingPage, '');
    SELF.Jgmts90_Eviction := IF(~suppress_condition, ri.LnJJudgments[90].Eviction, '');
    SELF.Jgmts90_Agency := IF(~suppress_condition, ri.LnJJudgments[90].Agency, '');
    SELF.Jgmts90_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[90].AgencyCounty, '');
    SELF.Jgmts90_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[90].AgencyState , '');
    SELF.Jgmts90_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[90].ConsumerStatementId), '');
    SELF.Jgmts90_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[90].orig_rmsid, '');
    SELF.Jgmts91_Seq:= IF(~suppress_condition, ri.LnJJudgments[91].Seq , '');
    SELF.Jgmts91_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[91].DateFiled , '');
    SELF.Jgmts91_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[91].JudgmentTypeID, '');
    SELF.Jgmts91_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[91].JudgmentType, '');
    SELF.Jgmts91_Amount := IF(~suppress_condition, ri.LnJJudgments[91].Amount, '');
    SELF.Jgmts91_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[91].ReleaseDate , '');
    SELF.Jgmts91_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[91].FilingDescription, '');
    SELF.Jgmts91_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[91].DateLastSeen, '');
    SELF.Jgmts91_Defendant:= IF(~suppress_condition, ri.LnJJudgments[91].Defendant, '');
    SELF.Jgmts91_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[91].Plaintiff, '');
    SELF.Jgmts91_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[91].FilingNumber, '');
    SELF.Jgmts91_FilingBook := IF(~suppress_condition, ri.LnJJudgments[91].FilingBook, '');
    SELF.Jgmts91_FilingPage := IF(~suppress_condition, ri.LnJJudgments[91].FilingPage, '');
    SELF.Jgmts91_Eviction := IF(~suppress_condition, ri.LnJJudgments[91].Eviction, '');
    SELF.Jgmts91_Agency := IF(~suppress_condition, ri.LnJJudgments[91].Agency, '');
    SELF.Jgmts91_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[91].AgencyCounty, '');
    SELF.Jgmts91_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[91].AgencyState , '');
    SELF.Jgmts91_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[91].ConsumerStatementId), '');
    SELF.Jgmts91_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[91].orig_rmsid, '');
    SELF.Jgmts92_Seq:= IF(~suppress_condition, ri.LnJJudgments[92].Seq , '');
    SELF.Jgmts92_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[92].DateFiled , '');
    SELF.Jgmts92_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[92].JudgmentTypeID, '');
    SELF.Jgmts92_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[92].JudgmentType, '');
    SELF.Jgmts92_Amount := IF(~suppress_condition, ri.LnJJudgments[92].Amount, '');
    SELF.Jgmts92_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[92].ReleaseDate , '');
    SELF.Jgmts92_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[92].FilingDescription, '');
    SELF.Jgmts92_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[92].DateLastSeen, '');
    SELF.Jgmts92_Defendant:= IF(~suppress_condition, ri.LnJJudgments[92].Defendant, '');
    SELF.Jgmts92_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[92].Plaintiff, '');
    SELF.Jgmts92_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[92].FilingNumber, '');
    SELF.Jgmts92_FilingBook := IF(~suppress_condition, ri.LnJJudgments[92].FilingBook, '');
    SELF.Jgmts92_FilingPage := IF(~suppress_condition, ri.LnJJudgments[92].FilingPage, '');
    SELF.Jgmts92_Eviction := IF(~suppress_condition, ri.LnJJudgments[92].Eviction, '');
    SELF.Jgmts92_Agency := IF(~suppress_condition, ri.LnJJudgments[92].Agency, '');
    SELF.Jgmts92_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[92].AgencyCounty, '');
    SELF.Jgmts92_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[92].AgencyState , '');
    SELF.Jgmts92_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[92].ConsumerStatementId), '');
    SELF.Jgmts92_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[92].orig_rmsid, '');
    SELF.Jgmts93_Seq:= IF(~suppress_condition, ri.LnJJudgments[93].Seq , '');
    SELF.Jgmts93_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[93].DateFiled , '');
    SELF.Jgmts93_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[93].JudgmentTypeID, '');
    SELF.Jgmts93_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[93].JudgmentType, '');
    SELF.Jgmts93_Amount := IF(~suppress_condition, ri.LnJJudgments[93].Amount, '');
    SELF.Jgmts93_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[93].ReleaseDate , '');
    SELF.Jgmts93_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[93].FilingDescription, '');
    SELF.Jgmts93_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[93].DateLastSeen, '');
    SELF.Jgmts93_Defendant:= IF(~suppress_condition, ri.LnJJudgments[93].Defendant, '');
    SELF.Jgmts93_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[93].Plaintiff, '');
    SELF.Jgmts93_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[93].FilingNumber, '');
    SELF.Jgmts93_FilingBook := IF(~suppress_condition, ri.LnJJudgments[93].FilingBook, '');
    SELF.Jgmts93_FilingPage := IF(~suppress_condition, ri.LnJJudgments[93].FilingPage, '');
    SELF.Jgmts93_Eviction := IF(~suppress_condition, ri.LnJJudgments[93].Eviction, '');
    SELF.Jgmts93_Agency := IF(~suppress_condition, ri.LnJJudgments[93].Agency, '');
    SELF.Jgmts93_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[93].AgencyCounty, '');
    SELF.Jgmts93_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[93].AgencyState , '');
    SELF.Jgmts93_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[93].ConsumerStatementId), '');
    SELF.Jgmts93_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[93].orig_rmsid, '');
    SELF.Jgmts94_Seq:= IF(~suppress_condition, ri.LnJJudgments[94].Seq , '');
    SELF.Jgmts94_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[94].DateFiled , '');
    SELF.Jgmts94_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[94].JudgmentTypeID, '');
    SELF.Jgmts94_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[94].JudgmentType, '');
    SELF.Jgmts94_Amount := IF(~suppress_condition, ri.LnJJudgments[94].Amount, '');
    SELF.Jgmts94_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[94].ReleaseDate , '');
    SELF.Jgmts94_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[94].FilingDescription, '');
    SELF.Jgmts94_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[94].DateLastSeen, '');
    SELF.Jgmts94_Defendant:= IF(~suppress_condition, ri.LnJJudgments[94].Defendant, '');
    SELF.Jgmts94_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[94].Plaintiff, '');
    SELF.Jgmts94_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[94].FilingNumber, '');
    SELF.Jgmts94_FilingBook := IF(~suppress_condition, ri.LnJJudgments[94].FilingBook, '');
    SELF.Jgmts94_FilingPage := IF(~suppress_condition, ri.LnJJudgments[94].FilingPage, '');
    SELF.Jgmts94_Eviction := IF(~suppress_condition, ri.LnJJudgments[94].Eviction, '');
    SELF.Jgmts94_Agency := IF(~suppress_condition, ri.LnJJudgments[94].Agency, '');
    SELF.Jgmts94_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[94].AgencyCounty, '');
    SELF.Jgmts94_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[94].AgencyState , '');
    SELF.Jgmts94_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[94].ConsumerStatementId), '');
    SELF.Jgmts94_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[94].orig_rmsid, '');
    SELF.Jgmts95_Seq:= IF(~suppress_condition, ri.LnJJudgments[95].Seq , '');
    SELF.Jgmts95_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[95].DateFiled , '');
    SELF.Jgmts95_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[95].JudgmentTypeID, '');
    SELF.Jgmts95_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[95].JudgmentType, '');
    SELF.Jgmts95_Amount := IF(~suppress_condition, ri.LnJJudgments[95].Amount, '');
    SELF.Jgmts95_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[95].ReleaseDate , ''); 
    SELF.Jgmts95_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[95].FilingDescription, '');
    SELF.Jgmts95_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[95].DateLastSeen, '');
    SELF.Jgmts95_Defendant:= IF(~suppress_condition, ri.LnJJudgments[95].Defendant, '');
    SELF.Jgmts95_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[95].Plaintiff, '');
    SELF.Jgmts95_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[95].FilingNumber, '');
    SELF.Jgmts95_FilingBook := IF(~suppress_condition, ri.LnJJudgments[95].FilingBook, '');
    SELF.Jgmts95_FilingPage := IF(~suppress_condition, ri.LnJJudgments[95].FilingPage, '');
    SELF.Jgmts95_Eviction := IF(~suppress_condition, ri.LnJJudgments[95].Eviction, '');
    SELF.Jgmts95_Agency := IF(~suppress_condition, ri.LnJJudgments[95].Agency, '');
    SELF.Jgmts95_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[95].AgencyCounty, '');
    SELF.Jgmts95_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[95].AgencyState , '');
    SELF.Jgmts95_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[95].ConsumerStatementId), '');
    SELF.Jgmts95_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[95].orig_rmsid, '');
    SELF.Jgmts96_Seq:= IF(~suppress_condition, ri.LnJJudgments[96].Seq , '');
    SELF.Jgmts96_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[96].DateFiled , '');
    SELF.Jgmts96_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[96].JudgmentTypeID, '');
    SELF.Jgmts96_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[96].JudgmentType, '');
    SELF.Jgmts96_Amount := IF(~suppress_condition, ri.LnJJudgments[96].Amount, '');
    SELF.Jgmts96_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[96].ReleaseDate , ''); 
    SELF.Jgmts96_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[96].FilingDescription, '');
    SELF.Jgmts96_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[96].DateLastSeen, '');
    SELF.Jgmts96_Defendant:= IF(~suppress_condition, ri.LnJJudgments[96].Defendant, '');
    SELF.Jgmts96_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[96].Plaintiff, '');
    SELF.Jgmts96_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[96].FilingNumber, '');
    SELF.Jgmts96_FilingBook := IF(~suppress_condition, ri.LnJJudgments[96].FilingBook, '');
    SELF.Jgmts96_FilingPage := IF(~suppress_condition, ri.LnJJudgments[96].FilingPage, '');
    SELF.Jgmts96_Eviction := IF(~suppress_condition, ri.LnJJudgments[96].Eviction, '');
    SELF.Jgmts96_Agency := IF(~suppress_condition, ri.LnJJudgments[96].Agency, '');
    SELF.Jgmts96_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[96].AgencyCounty, '');
    SELF.Jgmts96_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[96].AgencyState , '');
    SELF.Jgmts96_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[96].ConsumerStatementId), '');
    SELF.Jgmts96_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[96].orig_rmsid, '');
    SELF.Jgmts97_Seq:= IF(~suppress_condition, ri.LnJJudgments[97].Seq , '');
    SELF.Jgmts97_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[97].DateFiled , '');
    SELF.Jgmts97_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[97].JudgmentTypeID, '');
    SELF.Jgmts97_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[97].JudgmentType, '');
    SELF.Jgmts97_Amount := IF(~suppress_condition, ri.LnJJudgments[97].Amount, '');
    SELF.Jgmts97_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[97].ReleaseDate , ''); 
    SELF.Jgmts97_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[97].FilingDescription, '');
    SELF.Jgmts97_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[97].DateLastSeen, '');
    SELF.Jgmts97_Defendant:= IF(~suppress_condition, ri.LnJJudgments[97].Defendant, '');
    SELF.Jgmts97_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[97].Plaintiff, '');
    SELF.Jgmts97_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[97].FilingNumber, '');
    SELF.Jgmts97_FilingBook := IF(~suppress_condition, ri.LnJJudgments[97].FilingBook, '');
    SELF.Jgmts97_FilingPage := IF(~suppress_condition, ri.LnJJudgments[97].FilingPage, '');
    SELF.Jgmts97_Eviction := IF(~suppress_condition, ri.LnJJudgments[97].Eviction, '');
    SELF.Jgmts97_Agency := IF(~suppress_condition, ri.LnJJudgments[97].Agency, '');
    SELF.Jgmts97_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[97].AgencyCounty, '');
    SELF.Jgmts97_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[97].AgencyState , '');
    SELF.Jgmts97_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[97].ConsumerStatementId), '');
    SELF.Jgmts97_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[97].orig_rmsid, '');
    SELF.Jgmts98_Seq:= IF(~suppress_condition, ri.LnJJudgments[98].Seq , '');
    SELF.Jgmts98_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[98].DateFiled , '');
    SELF.Jgmts98_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[98].JudgmentTypeID, '');
    SELF.Jgmts98_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[98].JudgmentType, '');
    SELF.Jgmts98_Amount := IF(~suppress_condition, ri.LnJJudgments[98].Amount, '');
    SELF.Jgmts98_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[98].ReleaseDate , ''); 
    SELF.Jgmts98_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[98].FilingDescription, '');
    SELF.Jgmts98_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[98].DateLastSeen, '');
    SELF.Jgmts98_Defendant:= IF(~suppress_condition, ri.LnJJudgments[98].Defendant, '');
    SELF.Jgmts98_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[98].Plaintiff, '');
    SELF.Jgmts98_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[98].FilingNumber, '');
    SELF.Jgmts98_FilingBook := IF(~suppress_condition, ri.LnJJudgments[98].FilingBook, '');
    SELF.Jgmts98_FilingPage := IF(~suppress_condition, ri.LnJJudgments[98].FilingPage, '');
    SELF.Jgmts98_Eviction := IF(~suppress_condition, ri.LnJJudgments[98].Eviction, '');
    SELF.Jgmts98_Agency := IF(~suppress_condition, ri.LnJJudgments[98].Agency, '');
    SELF.Jgmts98_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[98].AgencyCounty, '');
    SELF.Jgmts98_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[98].AgencyState , '');
    SELF.Jgmts98_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[98].ConsumerStatementId), '');
    SELF.Jgmts98_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[98].orig_rmsid, '');
    SELF.Jgmts99_Seq:= IF(~suppress_condition, ri.LnJJudgments[99].Seq , '');
    SELF.Jgmts99_DateFiled:= IF(~suppress_condition, ri.LnJJudgments[99].DateFiled , '');
    SELF.Jgmts99_JudgmentTypeID := IF(~suppress_condition, ri.LnJJudgments[99].JudgmentTypeID, '');
    SELF.Jgmts99_JudgmentType := IF(~suppress_condition, ri.LnJJudgments[99].JudgmentType, '');
    SELF.Jgmts99_Amount := IF(~suppress_condition, ri.LnJJudgments[99].Amount, '');
    SELF.Jgmts99_ReleaseDate:= IF(~suppress_condition, ri.LnJJudgments[99].ReleaseDate , '');
    SELF.Jgmts99_FilingDescription:= IF(~suppress_condition, ri.LnJJudgments[99].FilingDescription, '');
    SELF.Jgmts99_DateLastSeen := IF(~suppress_condition, ri.LnJJudgments[99].DateLastSeen, '');
    SELF.Jgmts99_Defendant:= IF(~suppress_condition, ri.LnJJudgments[99].Defendant, '');
    SELF.Jgmts99_Plaintiff:= IF(~suppress_condition, ri.LnJJudgments[99].Plaintiff, '');
    SELF.Jgmts99_FilingNumber := IF(~suppress_condition, ri.LnJJudgments[99].FilingNumber, '');
    SELF.Jgmts99_FilingBook := IF(~suppress_condition, ri.LnJJudgments[99].FilingBook, '');
    SELF.Jgmts99_FilingPage := IF(~suppress_condition, ri.LnJJudgments[99].FilingPage, '');
    SELF.Jgmts99_Eviction := IF(~suppress_condition, ri.LnJJudgments[99].Eviction, '');
    SELF.Jgmts99_Agency := IF(~suppress_condition, ri.LnJJudgments[99].Agency, '');
    SELF.Jgmts99_AgencyCounty := IF(~suppress_condition, ri.LnJJudgments[99].AgencyCounty, '');
    SELF.Jgmts99_AgencyState:= IF(~suppress_condition, ri.LnJJudgments[99].AgencyState , '');
    SELF.Jgmts99_ConsumerStatementId:= IF(~suppress_condition, SetCSID(ri.LnJJudgments[99].ConsumerStatementId), '');
    SELF.Jgmts99_orig_rmsid := IF(~suppress_condition, ri.LnJJudgments[99].orig_rmsid, '');
    SELF.Liens1_AgencyID:= IF(~suppress_condition, ri.LnJliens[1].AgencyID, '');
    SELF.Liens2_AgencyID:= IF(~suppress_condition, ri.LnJliens[2].AgencyID, '');
    SELF.Liens3_AgencyID:= IF(~suppress_condition, ri.LnJliens[3].AgencyID, '');
    SELF.Liens4_AgencyID:= IF(~suppress_condition, ri.LnJliens[4].AgencyID, '');
    SELF.Liens5_AgencyID:= IF(~suppress_condition, ri.LnJliens[5].AgencyID, '');
    SELF.Liens6_AgencyID:= IF(~suppress_condition, ri.LnJliens[6].AgencyID, '');
    SELF.Liens7_AgencyID:= IF(~suppress_condition, ri.LnJliens[7].AgencyID, '');
    SELF.Liens8_AgencyID:= IF(~suppress_condition, ri.LnJliens[8].AgencyID, '');
    SELF.Liens9_AgencyID:= IF(~suppress_condition, ri.LnJliens[9].AgencyID, '');
    SELF.Liens10_AgencyID := IF(~suppress_condition, ri.LnJliens[10].AgencyID, '');
    SELF.Liens11_AgencyID := IF(~suppress_condition, ri.LnJliens[11].AgencyID, '');
    SELF.Liens12_AgencyID := IF(~suppress_condition, ri.LnJliens[12].AgencyID, '');
    SELF.Liens13_AgencyID := IF(~suppress_condition, ri.LnJliens[13].AgencyID, '');
    SELF.Liens14_AgencyID := IF(~suppress_condition, ri.LnJliens[14].AgencyID, '');
    SELF.Liens15_AgencyID := IF(~suppress_condition, ri.LnJliens[15].AgencyID, '');
    SELF.Liens16_AgencyID := IF(~suppress_condition, ri.LnJliens[16].AgencyID, '');
    SELF.Liens17_AgencyID := IF(~suppress_condition, ri.LnJliens[17].AgencyID, '');
    SELF.Liens18_AgencyID := IF(~suppress_condition, ri.LnJliens[18].AgencyID, '');
    SELF.Liens19_AgencyID := IF(~suppress_condition, ri.LnJliens[19].AgencyID, '');
    SELF.Liens20_AgencyID := IF(~suppress_condition, ri.LnJliens[20].AgencyID, '');
    SELF.Liens21_AgencyID := IF(~suppress_condition, ri.LnJliens[21].AgencyID, '');
    SELF.Liens22_AgencyID := IF(~suppress_condition, ri.LnJliens[22].AgencyID, '');
    SELF.Liens23_AgencyID := IF(~suppress_condition, ri.LnJliens[23].AgencyID, '');
    SELF.Liens24_AgencyID := IF(~suppress_condition, ri.LnJliens[24].AgencyID, '');
    SELF.Liens25_AgencyID := IF(~suppress_condition, ri.LnJliens[25].AgencyID, '');
    SELF.Liens26_AgencyID := IF(~suppress_condition, ri.LnJliens[26].AgencyID, '');
    SELF.Liens27_AgencyID := IF(~suppress_condition, ri.LnJliens[27].AgencyID, '');
    SELF.Liens28_AgencyID := IF(~suppress_condition, ri.LnJliens[28].AgencyID, '');
    SELF.Liens29_AgencyID := IF(~suppress_condition, ri.LnJliens[29].AgencyID, '');
    SELF.Liens30_AgencyID := IF(~suppress_condition, ri.LnJliens[30].AgencyID, '');
    SELF.Liens31_AgencyID := IF(~suppress_condition, ri.LnJliens[31].AgencyID, '');
    SELF.Liens32_AgencyID := IF(~suppress_condition, ri.LnJliens[32].AgencyID, '');
    SELF.Liens33_AgencyID := IF(~suppress_condition, ri.LnJliens[33].AgencyID, '');
    SELF.Liens34_AgencyID := IF(~suppress_condition, ri.LnJliens[34].AgencyID, '');
    SELF.Liens35_AgencyID := IF(~suppress_condition, ri.LnJliens[35].AgencyID, '');
    SELF.Liens36_AgencyID := IF(~suppress_condition, ri.LnJliens[36].AgencyID, '');
    SELF.Liens37_AgencyID := IF(~suppress_condition, ri.LnJliens[37].AgencyID, '');
    SELF.Liens38_AgencyID := IF(~suppress_condition, ri.LnJliens[38].AgencyID, '');
    SELF.Liens39_AgencyID := IF(~suppress_condition, ri.LnJliens[39].AgencyID, '');
    SELF.Liens40_AgencyID := IF(~suppress_condition, ri.LnJliens[40].AgencyID, '');
    SELF.Liens41_AgencyID := IF(~suppress_condition, ri.LnJliens[41].AgencyID, '');
    SELF.Liens42_AgencyID := IF(~suppress_condition, ri.LnJliens[42].AgencyID, '');
    SELF.Liens43_AgencyID := IF(~suppress_condition, ri.LnJliens[43].AgencyID, '');
    SELF.Liens44_AgencyID := IF(~suppress_condition, ri.LnJliens[44].AgencyID, '');
    SELF.Liens45_AgencyID := IF(~suppress_condition, ri.LnJliens[45].AgencyID, '');
    SELF.Liens46_AgencyID := IF(~suppress_condition, ri.LnJliens[46].AgencyID, '');
    SELF.Liens47_AgencyID := IF(~suppress_condition, ri.LnJliens[47].AgencyID, '');
    SELF.Liens48_AgencyID := IF(~suppress_condition, ri.LnJliens[48].AgencyID, '');
    SELF.Liens49_AgencyID := IF(~suppress_condition, ri.LnJliens[49].AgencyID, '');
    SELF.Liens50_AgencyID := IF(~suppress_condition, ri.LnJliens[50].AgencyID, '');
    SELF.Liens51_AgencyID := IF(~suppress_condition, ri.LnJliens[51].AgencyID, '');
    SELF.Liens52_AgencyID := IF(~suppress_condition, ri.LnJliens[52].AgencyID, '');
    SELF.Liens53_AgencyID := IF(~suppress_condition, ri.LnJliens[53].AgencyID, '');
    SELF.Liens54_AgencyID := IF(~suppress_condition, ri.LnJliens[54].AgencyID, '');
    SELF.Liens55_AgencyID := IF(~suppress_condition, ri.LnJliens[55].AgencyID, '');
    SELF.Liens56_AgencyID := IF(~suppress_condition, ri.LnJliens[56].AgencyID, '');
    SELF.Liens57_AgencyID := IF(~suppress_condition, ri.LnJliens[57].AgencyID, '');
    SELF.Liens58_AgencyID := IF(~suppress_condition, ri.LnJliens[58].AgencyID, '');
    SELF.Liens59_AgencyID := IF(~suppress_condition, ri.LnJliens[59].AgencyID, '');
    SELF.Liens60_AgencyID := IF(~suppress_condition, ri.LnJliens[60].AgencyID, '');
    SELF.Liens61_AgencyID := IF(~suppress_condition, ri.LnJliens[61].AgencyID, '');
    SELF.Liens62_AgencyID := IF(~suppress_condition, ri.LnJliens[62].AgencyID, '');
    SELF.Liens63_AgencyID := IF(~suppress_condition, ri.LnJliens[63].AgencyID, '');
    SELF.Liens64_AgencyID := IF(~suppress_condition, ri.LnJliens[64].AgencyID, '');
    SELF.Liens65_AgencyID := IF(~suppress_condition, ri.LnJliens[65].AgencyID, '');
    SELF.Liens66_AgencyID := IF(~suppress_condition, ri.LnJliens[66].AgencyID, '');
    SELF.Liens67_AgencyID := IF(~suppress_condition, ri.LnJliens[67].AgencyID, '');
    SELF.Liens68_AgencyID := IF(~suppress_condition, ri.LnJliens[68].AgencyID, '');
    SELF.Liens69_AgencyID := IF(~suppress_condition, ri.LnJliens[69].AgencyID, '');
    SELF.Liens70_AgencyID := IF(~suppress_condition, ri.LnJliens[70].AgencyID, '');
    SELF.Liens71_AgencyID := IF(~suppress_condition, ri.LnJliens[71].AgencyID, '');
    SELF.Liens72_AgencyID := IF(~suppress_condition, ri.LnJliens[72].AgencyID, '');
    SELF.Liens73_AgencyID := IF(~suppress_condition, ri.LnJliens[73].AgencyID, '');
    SELF.Liens74_AgencyID := IF(~suppress_condition, ri.LnJliens[74].AgencyID, '');
    SELF.Liens75_AgencyID := IF(~suppress_condition, ri.LnJliens[75].AgencyID, '');
    SELF.Liens76_AgencyID := IF(~suppress_condition, ri.LnJliens[76].AgencyID, '');
    SELF.Liens77_AgencyID := IF(~suppress_condition, ri.LnJliens[77].AgencyID, '');
    SELF.Liens78_AgencyID := IF(~suppress_condition, ri.LnJliens[78].AgencyID, '');
    SELF.Liens79_AgencyID := IF(~suppress_condition, ri.LnJliens[79].AgencyID, '');
    SELF.Liens80_AgencyID := IF(~suppress_condition, ri.LnJliens[80].AgencyID, '');
    SELF.Liens81_AgencyID := IF(~suppress_condition, ri.LnJliens[81].AgencyID, '');
    SELF.Liens82_AgencyID := IF(~suppress_condition, ri.LnJliens[82].AgencyID, '');
    SELF.Liens83_AgencyID := IF(~suppress_condition, ri.LnJliens[83].AgencyID, '');
    SELF.Liens84_AgencyID := IF(~suppress_condition, ri.LnJliens[84].AgencyID, '');
    SELF.Liens85_AgencyID := IF(~suppress_condition, ri.LnJliens[85].AgencyID, '');
    SELF.Liens86_AgencyID := IF(~suppress_condition, ri.LnJliens[86].AgencyID, '');
    SELF.Liens87_AgencyID := IF(~suppress_condition, ri.LnJliens[87].AgencyID, '');
    SELF.Liens88_AgencyID := IF(~suppress_condition, ri.LnJliens[88].AgencyID, '');
    SELF.Liens89_AgencyID := IF(~suppress_condition, ri.LnJliens[89].AgencyID, '');
    SELF.Liens90_AgencyID := IF(~suppress_condition, ri.LnJliens[90].AgencyID, '');
    SELF.Liens91_AgencyID := IF(~suppress_condition, ri.LnJliens[91].AgencyID, '');
    SELF.Liens92_AgencyID := IF(~suppress_condition, ri.LnJliens[92].AgencyID, '');
    SELF.Liens93_AgencyID := IF(~suppress_condition, ri.LnJliens[93].AgencyID, '');
    SELF.Liens94_AgencyID := IF(~suppress_condition, ri.LnJliens[94].AgencyID, '');
    SELF.Liens95_AgencyID := IF(~suppress_condition, ri.LnJliens[95].AgencyID, '');
    SELF.Liens96_AgencyID := IF(~suppress_condition, ri.LnJliens[96].AgencyID, '');
    SELF.Liens97_AgencyID := IF(~suppress_condition, ri.LnJliens[97].AgencyID, '');
    SELF.Liens98_AgencyID := IF(~suppress_condition, ri.LnJliens[98].AgencyID, '');
    SELF.Liens99_AgencyID := IF(~suppress_condition, ri.LnJliens[99].AgencyID, '');
    SELF.Jgmts1_AgencyID:= IF(~suppress_condition, ri.LnJJudgments[1].AgencyID, '');
    SELF.Jgmts2_AgencyID:= IF(~suppress_condition, ri.LnJJudgments[2].AgencyID, '');
    SELF.Jgmts3_AgencyID:= IF(~suppress_condition, ri.LnJJudgments[3].AgencyID, '');
    SELF.Jgmts4_AgencyID:= IF(~suppress_condition, ri.LnJJudgments[4].AgencyID, '');
    SELF.Jgmts5_AgencyID:= IF(~suppress_condition, ri.LnJJudgments[5].AgencyID, '');
    SELF.Jgmts6_AgencyID:= IF(~suppress_condition, ri.LnJJudgments[6].AgencyID, '');
    SELF.Jgmts7_AgencyID:= IF(~suppress_condition, ri.LnJJudgments[7].AgencyID, '');
    SELF.Jgmts8_AgencyID:= IF(~suppress_condition, ri.LnJJudgments[8].AgencyID, '');
    SELF.Jgmts9_AgencyID:= IF(~suppress_condition, ri.LnJJudgments[9].AgencyID, '');
    SELF.Jgmts10_AgencyID := IF(~suppress_condition, ri.LnJJudgments[10].AgencyID, '');
    SELF.Jgmts11_AgencyID := IF(~suppress_condition, ri.LnJJudgments[11].AgencyID, '');
    SELF.Jgmts12_AgencyID := IF(~suppress_condition, ri.LnJJudgments[12].AgencyID, '');
    SELF.Jgmts13_AgencyID := IF(~suppress_condition, ri.LnJJudgments[13].AgencyID, '');
    SELF.Jgmts14_AgencyID := IF(~suppress_condition, ri.LnJJudgments[14].AgencyID, '');
    SELF.Jgmts15_AgencyID := IF(~suppress_condition, ri.LnJJudgments[15].AgencyID, '');
    SELF.Jgmts16_AgencyID := IF(~suppress_condition, ri.LnJJudgments[16].AgencyID, '');
    SELF.Jgmts17_AgencyID := IF(~suppress_condition, ri.LnJJudgments[17].AgencyID, '');
    SELF.Jgmts18_AgencyID := IF(~suppress_condition, ri.LnJJudgments[18].AgencyID, '');
    SELF.Jgmts19_AgencyID := IF(~suppress_condition, ri.LnJJudgments[19].AgencyID, '');
    SELF.Jgmts20_AgencyID := IF(~suppress_condition, ri.LnJJudgments[20].AgencyID, '');
    SELF.Jgmts21_AgencyID := IF(~suppress_condition, ri.LnJJudgments[21].AgencyID, '');
    SELF.Jgmts22_AgencyID := IF(~suppress_condition, ri.LnJJudgments[22].AgencyID, '');
    SELF.Jgmts23_AgencyID := IF(~suppress_condition, ri.LnJJudgments[23].AgencyID, '');
    SELF.Jgmts24_AgencyID := IF(~suppress_condition, ri.LnJJudgments[24].AgencyID, '');
    SELF.Jgmts25_AgencyID := IF(~suppress_condition, ri.LnJJudgments[25].AgencyID, '');
    SELF.Jgmts26_AgencyID := IF(~suppress_condition, ri.LnJJudgments[26].AgencyID, '');
    SELF.Jgmts27_AgencyID := IF(~suppress_condition, ri.LnJJudgments[27].AgencyID, '');
    SELF.Jgmts28_AgencyID := IF(~suppress_condition, ri.LnJJudgments[28].AgencyID, '');
    SELF.Jgmts29_AgencyID := IF(~suppress_condition, ri.LnJJudgments[29].AgencyID, '');
    SELF.Jgmts30_AgencyID := IF(~suppress_condition, ri.LnJJudgments[30].AgencyID, '');
    SELF.Jgmts31_AgencyID := IF(~suppress_condition, ri.LnJJudgments[31].AgencyID, '');
    SELF.Jgmts32_AgencyID := IF(~suppress_condition, ri.LnJJudgments[32].AgencyID, '');
    SELF.Jgmts33_AgencyID := IF(~suppress_condition, ri.LnJJudgments[33].AgencyID, '');
    SELF.Jgmts34_AgencyID := IF(~suppress_condition, ri.LnJJudgments[34].AgencyID, '');
    SELF.Jgmts35_AgencyID := IF(~suppress_condition, ri.LnJJudgments[35].AgencyID, '');
    SELF.Jgmts36_AgencyID := IF(~suppress_condition, ri.LnJJudgments[36].AgencyID, '');
    SELF.Jgmts37_AgencyID := IF(~suppress_condition, ri.LnJJudgments[37].AgencyID, '');
    SELF.Jgmts38_AgencyID := IF(~suppress_condition, ri.LnJJudgments[38].AgencyID, '');
    SELF.Jgmts39_AgencyID := IF(~suppress_condition, ri.LnJJudgments[39].AgencyID, '');
    SELF.Jgmts40_AgencyID := IF(~suppress_condition, ri.LnJJudgments[40].AgencyID, '');
    SELF.Jgmts41_AgencyID := IF(~suppress_condition, ri.LnJJudgments[41].AgencyID, '');
    SELF.Jgmts42_AgencyID := IF(~suppress_condition, ri.LnJJudgments[42].AgencyID, '');
    SELF.Jgmts43_AgencyID := IF(~suppress_condition, ri.LnJJudgments[43].AgencyID, '');
    SELF.Jgmts44_AgencyID := IF(~suppress_condition, ri.LnJJudgments[44].AgencyID, '');
    SELF.Jgmts45_AgencyID := IF(~suppress_condition, ri.LnJJudgments[45].AgencyID, '');
    SELF.Jgmts46_AgencyID := IF(~suppress_condition, ri.LnJJudgments[46].AgencyID, '');
    SELF.Jgmts47_AgencyID := IF(~suppress_condition, ri.LnJJudgments[47].AgencyID, '');
    SELF.Jgmts48_AgencyID := IF(~suppress_condition, ri.LnJJudgments[48].AgencyID, '');
    SELF.Jgmts49_AgencyID := IF(~suppress_condition, ri.LnJJudgments[49].AgencyID, '');
    SELF.Jgmts50_AgencyID := IF(~suppress_condition, ri.LnJJudgments[50].AgencyID, '');
    SELF.Jgmts51_AgencyID := IF(~suppress_condition, ri.LnJJudgments[51].AgencyID, '');
    SELF.Jgmts52_AgencyID := IF(~suppress_condition, ri.LnJJudgments[52].AgencyID, '');
    SELF.Jgmts53_AgencyID := IF(~suppress_condition, ri.LnJJudgments[53].AgencyID, '');
    SELF.Jgmts54_AgencyID := IF(~suppress_condition, ri.LnJJudgments[54].AgencyID, '');
    SELF.Jgmts55_AgencyID := IF(~suppress_condition, ri.LnJJudgments[55].AgencyID, '');
    SELF.Jgmts56_AgencyID := IF(~suppress_condition, ri.LnJJudgments[56].AgencyID, '');
    SELF.Jgmts57_AgencyID := IF(~suppress_condition, ri.LnJJudgments[57].AgencyID, '');
    SELF.Jgmts58_AgencyID := IF(~suppress_condition, ri.LnJJudgments[58].AgencyID, '');
    SELF.Jgmts59_AgencyID := IF(~suppress_condition, ri.LnJJudgments[59].AgencyID, '');
    SELF.Jgmts60_AgencyID := IF(~suppress_condition, ri.LnJJudgments[60].AgencyID, '');
    SELF.Jgmts61_AgencyID := IF(~suppress_condition, ri.LnJJudgments[61].AgencyID, '');
    SELF.Jgmts62_AgencyID := IF(~suppress_condition, ri.LnJJudgments[62].AgencyID, '');
    SELF.Jgmts63_AgencyID := IF(~suppress_condition, ri.LnJJudgments[63].AgencyID, '');
    SELF.Jgmts64_AgencyID := IF(~suppress_condition, ri.LnJJudgments[64].AgencyID, '');
    SELF.Jgmts65_AgencyID := IF(~suppress_condition, ri.LnJJudgments[65].AgencyID, '');
    SELF.Jgmts66_AgencyID := IF(~suppress_condition, ri.LnJJudgments[66].AgencyID, '');
    SELF.Jgmts67_AgencyID := IF(~suppress_condition, ri.LnJJudgments[67].AgencyID, '');
    SELF.Jgmts68_AgencyID := IF(~suppress_condition, ri.LnJJudgments[68].AgencyID, '');
    SELF.Jgmts69_AgencyID := IF(~suppress_condition, ri.LnJJudgments[69].AgencyID, '');
    SELF.Jgmts70_AgencyID := IF(~suppress_condition, ri.LnJJudgments[70].AgencyID, '');
    SELF.Jgmts71_AgencyID := IF(~suppress_condition, ri.LnJJudgments[71].AgencyID, '');
    SELF.Jgmts72_AgencyID := IF(~suppress_condition, ri.LnJJudgments[72].AgencyID, '');
    SELF.Jgmts73_AgencyID := IF(~suppress_condition, ri.LnJJudgments[73].AgencyID, '');
    SELF.Jgmts74_AgencyID := IF(~suppress_condition, ri.LnJJudgments[74].AgencyID, '');
    SELF.Jgmts75_AgencyID := IF(~suppress_condition, ri.LnJJudgments[75].AgencyID, '');
    SELF.Jgmts76_AgencyID := IF(~suppress_condition, ri.LnJJudgments[76].AgencyID, '');
    SELF.Jgmts77_AgencyID := IF(~suppress_condition, ri.LnJJudgments[77].AgencyID, '');
    SELF.Jgmts78_AgencyID := IF(~suppress_condition, ri.LnJJudgments[78].AgencyID, '');
    SELF.Jgmts79_AgencyID := IF(~suppress_condition, ri.LnJJudgments[79].AgencyID, '');
    SELF.Jgmts80_AgencyID := IF(~suppress_condition, ri.LnJJudgments[80].AgencyID, '');
    SELF.Jgmts81_AgencyID := IF(~suppress_condition, ri.LnJJudgments[81].AgencyID, '');
    SELF.Jgmts82_AgencyID := IF(~suppress_condition, ri.LnJJudgments[82].AgencyID, '');
    SELF.Jgmts83_AgencyID := IF(~suppress_condition, ri.LnJJudgments[83].AgencyID, '');
    SELF.Jgmts84_AgencyID := IF(~suppress_condition, ri.LnJJudgments[84].AgencyID, '');
    SELF.Jgmts85_AgencyID := IF(~suppress_condition, ri.LnJJudgments[85].AgencyID, '');
    SELF.Jgmts86_AgencyID := IF(~suppress_condition, ri.LnJJudgments[86].AgencyID, '');
    SELF.Jgmts87_AgencyID := IF(~suppress_condition, ri.LnJJudgments[87].AgencyID, '');
    SELF.Jgmts88_AgencyID := IF(~suppress_condition, ri.LnJJudgments[88].AgencyID, '');
    SELF.Jgmts89_AgencyID := IF(~suppress_condition, ri.LnJJudgments[89].AgencyID, '');
    SELF.Jgmts90_AgencyID := IF(~suppress_condition, ri.LnJJudgments[90].AgencyID, '');
    SELF.Jgmts91_AgencyID := IF(~suppress_condition, ri.LnJJudgments[91].AgencyID, '');
    SELF.Jgmts92_AgencyID := IF(~suppress_condition, ri.LnJJudgments[92].AgencyID, '');
    SELF.Jgmts93_AgencyID := IF(~suppress_condition, ri.LnJJudgments[93].AgencyID, '');
    SELF.Jgmts94_AgencyID := IF(~suppress_condition, ri.LnJJudgments[94].AgencyID, '');
    SELF.Jgmts95_AgencyID := IF(~suppress_condition, ri.LnJJudgments[95].AgencyID, '');
    SELF.Jgmts96_AgencyID := IF(~suppress_condition, ri.LnJJudgments[96].AgencyID, '');
    SELF.Jgmts97_AgencyID := IF(~suppress_condition, ri.LnJJudgments[97].AgencyID, '');
    SELF.Jgmts98_AgencyID := IF(~suppress_condition, ri.LnJJudgments[98].AgencyID, '');
    SELF.Jgmts99_AgencyID := IF(~suppress_condition, ri.LnJJudgments[99].AgencyID, '');
    SELF.Full := IF(~suppress_condition, ri.report.summary.name.full, '');
    SELF.First := IF(~suppress_condition, ri.report.summary.name.first, '');
    SELF.Middle := IF(~suppress_condition, ri.report.summary.name.middle, '');
    SELF.Last := IF(~suppress_condition, ri.report.summary.name.last, '');
    SELF.Suffix := IF(~suppress_condition, ri.report.summary.name.suffix, '');
    SELF.Prefix := IF(~suppress_condition, ri.report.summary.name.prefix, '');
    SELF.StreetNumber := IF(~suppress_condition, ri.report.summary.address.streetnumber, '');
    SELF.StreetPreDirection := IF(~suppress_condition, ri.report.summary.address.StreetPreDirection, '');
    SELF.StreetName := IF(~suppress_condition, ri.report.summary.address.StreetName, '');
    SELF.StreetSuffix := IF(~suppress_condition, ri.report.summary.address.StreetSuffix, '');
    SELF.StreetPostDirection := IF(~suppress_condition, ri.report.summary.address.StreetPostDirection, '');
    SELF.UnitDesignation := IF(~suppress_condition, ri.report.summary.address.UnitDesignation, '');
    SELF.UnitNumber := IF(~suppress_condition, ri.report.summary.address.UnitNumber, '');
    SELF.StreetAddress1 := IF(~suppress_condition, ri.report.summary.address.StreetAddress1, '');
    SELF.StreetAddress2 := IF(~suppress_condition, ri.report.summary.address.StreetAddress2, '');
    SELF.City := IF(~suppress_condition, ri.report.summary.address.City, '');
    SELF.State := IF(~suppress_condition, ri.report.summary.address.State, '');
    SELF.Zip5 := IF(~suppress_condition, ri.report.summary.address.Zip5, '');
    SELF.Zip4 := IF(~suppress_condition, ri.report.summary.address.Zip4, '');
    SELF.County := IF(~suppress_condition, ri.report.summary.address.County, '');
    SELF.PostalCode := IF(~suppress_condition, ri.report.summary.address.PostalCode, '');
    SELF.StateCityZip := IF(~suppress_condition, ri.report.summary.address.StateCityZip, '');
    SELF.SSN := IF(~suppress_condition, ri.report.summary.SSN, '');
    SELF.Phone := IF(~suppress_condition, ri.report.summary.Phone, '');
    SELF.Year := IF(~suppress_condition, ri.report.summary.DOB.Year, '');
    SELF.Month := IF(~suppress_condition, ri.report.summary.DOB.Month, '');
    SELF.Day := IF(~suppress_condition, ri.report.summary.DOB.Day, '');
    SELF.UniqueId := IF(~suppress_condition, ri.report.summary.UniqueId, '');
    SELF.AddressStability := IF(~suppress_condition, ri.report.summary.AddressStability, '');
    SELF.InquiriesRestricted := IF(~suppress_condition, ri.report.summary.InquiriesRestricted, '');
    SELF.SSNMismatch := IF(~suppress_condition, ri.report.summary.SSNMismatch, '');
    SELF.DOBMismatch := IF(~suppress_condition, ri.report.summary.DOBMismatch, '');
    SELF.AddressMismatch := IF(~suppress_condition, ri.report.summary.AddressMismatch, '');
    SELF.PhoneMismatch := IF(~suppress_condition, ri.report.summary.PhoneMismatch, '');
    SELF.UniqueIDMismatch := IF(~suppress_condition, ri.report.summary.UniqueIDMismatch, '');
    SELF.LnJEvictionTotalCount := IF(~suppress_condition, ri.LnJEvictionTotalCount, '');
    SELF.LnJEvictionTotalCount12Month := IF(~suppress_condition, ri.LnJEvictionTotalCount12Month, '');
    SELF.LnjEvictionTimeNewest := IF(~suppress_condition, ri.LnjEvictionTimeNewest, '');
    SELF.LnJJudgmentSmallClaimsCount := IF(~suppress_condition, ri.LnJJudgmentSmallClaimsCount, '');
    SELF.LnjJudgmentCourtCount := IF(~suppress_condition, ri.LnjJudgmentCourtCount, '');
    SELF.LnjJudgmentForeclosureCount := IF(~suppress_condition, ri.LnjJudgmentForeclosureCount, '');
    SELF.LnjLienJudgmentSeverityIndex := IF(~suppress_condition, ri.LnjLienJudgmentSeverityIndex, '');
    SELF.LnjLienJudgmentCount := IF(~suppress_condition, ri.LnjLienJudgmentCount, '');
    SELF.LnjLienJudgmentCount12Month := IF(~suppress_condition, ri.LnjLienJudgmentCount12Month, '');
    SELF.LnJLienTaxCount := IF(~suppress_condition, ri.LnJLienTaxCount, '');
    SELF.LnjLienJudgmentOtherCount := IF(~suppress_condition, ri.LnjLienJudgmentOtherCount, '');
    SELF.LnjLienJudgmentTimeNewest := IF(~suppress_condition, ri.LnjLienJudgmentTimeNewest, '');
    SELF.LnjLienJudgmentDollarTotal := IF(~suppress_condition, ri.LnjLienJudgmentDollarTotal, '');
    SELF.LnjLienCount := IF(~suppress_condition, ri.LnjLienCount, '');
    SELF.LnjLienTimeNewest := IF(~suppress_condition, ri.LnjLienTimeNewest, '');
    SELF.LnjLienDollarTotal := IF(~suppress_condition, ri.LnjLienDollarTotal, '');
    SELF.LnjLienTaxTimeNewest := IF(~suppress_condition, ri.LnjLienTaxTimeNewest, '');
    SELF.LnjLienTaxDollarTotal := IF(~suppress_condition, ri.LnjLienTaxDollarTotal, '');
    SELF.LnjLienTaxStateCount := IF(~suppress_condition, ri.LnjLienTaxStateCount, '');
    SELF.LnjLienTaxStateTimeNewest := IF(~suppress_condition, ri.LnjLienTaxStateTimeNewest, '');
    SELF.LnjLienTaxStateDollarTotal := IF(~suppress_condition, ri.LnjLienTaxStateDollarTotal, '');
    SELF.LnjLienTaxFederalCount := IF(~suppress_condition, ri.LnjLienTaxFederalCount, '');
    SELF.LnjLienTaxFederalTimeNewest := IF(~suppress_condition, ri.LnjLienTaxFederalTimeNewest, '');
    SELF.LnjLienTaxFederalDollarTotal := IF(~suppress_condition, ri.LnjLienTaxFederalDollarTotal, '');
    SELF.LnjJudgmentCount := IF(~suppress_condition, ri.LnjJudgmentCount, '');
    SELF.LnjJudgmentTimeNewest := IF(~suppress_condition, ri.LnjJudgmentTimeNewest, '');
    SELF.LnjJudgmentDollarTotal := IF(~suppress_condition, ri.LnjJudgmentDollarTotal, '');
    SELF := ri;
    SELF := []; 
END;

EXPORT RiskView.Layouts.layout_riskview5_batch_response AttributesOnlyBatch(RiskView.Layouts.layout_riskview5_batch_response le) := TRANSFORM
        SELF.AcctNo := le.AcctNo;
        SELF.LexID := le.LexID;
        SELF.Auto_Index := le.Auto_Index;
        SELF.Auto_Score_Name := le.Auto_Score_Name;
        SELF.Auto_score := le.Auto_score;
        SELF.Auto_reason1 := le.Auto_reason1;
        SELF.Auto_reason2 := le.Auto_reason2;
        SELF.Auto_reason3 := le.Auto_reason3;
        SELF.Auto_reason4 := le.Auto_reason4;
        SELF.Auto_reason5 := le.Auto_reason5;
        SELF.Bankcard_Index := le.Bankcard_Index;
        SELF.BankCard_Score_Name := le.BankCard_Score_Name;
        SELF.Bankcard_score := le.Bankcard_score;
        SELF.Bankcard_reason1 := le.Bankcard_reason1;
        SELF.Bankcard_reason2 := le.Bankcard_reason2;
        SELF.Bankcard_reason3 := le.Bankcard_reason3;
        SELF.Bankcard_reason4 := le.Bankcard_reason4;
        SELF.Bankcard_reason5 := le.Bankcard_reason5;
        SELF.Short_term_lending_Index := le.Short_term_lending_Index;
        SELF.Short_term_lending_Score_Name := le.Short_term_lending_Score_Name;
        SELF.Short_term_lending_score := le.Short_term_lending_score;
        SELF.Short_term_lending_reason1 := le.Short_term_lending_reason1;
        SELF.Short_term_lending_reason2 := le.Short_term_lending_reason2;
        SELF.Short_term_lending_reason3 := le.Short_term_lending_reason3;
        SELF.Short_term_lending_reason4 := le.Short_term_lending_reason4;
        SELF.Short_term_lending_reason5 := le.Short_term_lending_reason5;
        SELF.Telecommunications_Index := le.Telecommunications_Index;
        SELF.Telecommunications_Score_Name := le.Telecommunications_Score_Name;
        SELF.Telecommunications_score := le.Telecommunications_score;
        SELF.Telecommunications_reason1 := le.Telecommunications_reason1;
        SELF.Telecommunications_reason2 := le.Telecommunications_reason2;
        SELF.Telecommunications_reason3 := le.Telecommunications_reason3;
        SELF.Telecommunications_reason4 := le.Telecommunications_reason4;
        SELF.Telecommunications_reason5 := le.Telecommunications_reason5;
        SELF.Crossindustry_Index := le.Crossindustry_Index;
        SELF.Crossindustry_Score_Name := le.Crossindustry_Score_Name;
        SELF.Crossindustry_score := le.Crossindustry_score;
        SELF.Crossindustry_reason1 := le.Crossindustry_reason1;
        SELF.Crossindustry_reason2 := le.Crossindustry_reason2;
        SELF.Crossindustry_reason3 := le.Crossindustry_reason3;
        SELF.Crossindustry_reason4 := le.Crossindustry_reason4;
        SELF.Crossindustry_reason5 := le.Crossindustry_reason5;
        SELF.Custom_Index := le.Custom_Index;
        SELF.Custom_Score_Name := le.Custom_Score_Name;
        SELF.Custom_score := le.Custom_score;
        SELF.Custom_reason1 := le.Custom_reason1;
        SELF.Custom_reason2 := le.Custom_reason2;
        SELF.Custom_reason3 := le.Custom_reason3;
        SELF.Custom_reason4 := le.Custom_reason4;
        SELF.Custom_reason5 := le.Custom_reason5;
        SELF.Custom2_Index := le.Custom2_Index;
        SELF.Custom2_Score_Name := le.Custom2_Score_Name;
        SELF.Custom2_score := le.Custom2_score;
        SELF.Custom2_reason1 := le.Custom2_reason1;
        SELF.Custom2_reason2 := le.Custom2_reason2;
        SELF.Custom2_reason3 := le.Custom2_reason3;
        SELF.Custom2_reason4 := le.Custom2_reason4;
        SELF.Custom2_reason5 := le.Custom2_reason5;
        SELF.Custom3_Index := le.Custom3_Index;
        SELF.Custom3_Score_Name := le.Custom3_Score_Name;
        SELF.Custom3_score := le.Custom3_score;
        SELF.Custom3_reason1 := le.Custom3_reason1;
        SELF.Custom3_reason2 := le.Custom3_reason2;
        SELF.Custom3_reason3 := le.Custom3_reason3;
        SELF.Custom3_reason4 := le.Custom3_reason4;
        SELF.Custom3_reason5 := le.Custom3_reason5;
        SELF.Custom4_Index := le.Custom4_Index;
        SELF.Custom4_Score_Name := le.Custom4_Score_Name;
        SELF.Custom4_score := le.Custom4_score;
        SELF.Custom4_reason1 := le.Custom4_reason1;
        SELF.Custom4_reason2 := le.Custom4_reason2;
        SELF.Custom4_reason3 := le.Custom4_reason3;
        SELF.Custom4_reason4 := le.Custom4_reason4;
        SELF.Custom4_reason5 := le.Custom4_reason5;
        SELF.Custom5_Index := le.Custom5_Index;
        SELF.Custom5_Score_Name := le.Custom5_Score_Name;
        SELF.Custom5_score := le.Custom5_score;
        SELF.Custom5_reason1 := le.Custom5_reason1;
        SELF.Custom5_reason2 := le.Custom5_reason2;
        SELF.Custom5_reason3 := le.Custom5_reason3;
        SELF.Custom5_reason4 := le.Custom5_reason4;
        SELF.Custom5_reason5 := le.Custom5_reason5;
        SELF.Attribute_Index := le.Attribute_Index;
        SELF.InputProvidedFirstName := le.InputProvidedFirstName;
        SELF.InputProvidedLastName := le.InputProvidedLastName;
        SELF.InputProvidedStreetAddress := le.InputProvidedStreetAddress;
        SELF.InputProvidedCity := le.InputProvidedCity;
        SELF.InputProvidedState := le.InputProvidedState;
        SELF.InputProvidedZipCode := le.InputProvidedZipCode;
        SELF.InputProvidedSSN := le.InputProvidedSSN;
        SELF.InputProvidedDateofBirth := le.InputProvidedDateofBirth;
        SELF.InputProvidedPhone := le.InputProvidedPhone;
        SELF.InputProvidedLexID := le.InputProvidedLexID;
        SELF.SubjectRecordTimeOldest := le.SubjectRecordTimeOldest;
        SELF.SubjectRecordTimeNewest := le.SubjectRecordTimeNewest;
        SELF.SubjectNewestRecord12Month := le.SubjectNewestRecord12Month;
        SELF.SubjectActivityIndex03Month := le.SubjectActivityIndex03Month;
        SELF.SubjectActivityIndex06Month := le.SubjectActivityIndex06Month;
        SELF.SubjectActivityIndex12Month := le.SubjectActivityIndex12Month;
        SELF.SubjectAge := le.SubjectAge;
        SELF.SubjectDeceased := le.SubjectDeceased;
        SELF.SubjectSSNCount := le.SubjectSSNCount;
        SELF.SubjectStabilityIndex := le.SubjectStabilityIndex;
        SELF.SubjectStabilityPrimaryFactor := le.SubjectStabilityPrimaryFactor;
        SELF.SubjectAbilityIndex := le.SubjectAbilityIndex;
        SELF.SubjectAbilityPrimaryFactor := le.SubjectAbilityPrimaryFactor;
        SELF.SubjectWillingnessIndex := le.SubjectWillingnessIndex;
        SELF.SubjectWillingnessPrimaryFactor := le.SubjectWillingnessPrimaryFactor;
        SELF.ConfirmationSubjectFound := le.ConfirmationSubjectFound;
        SELF.ConfirmationInputName := le.ConfirmationInputName;
        SELF.ConfirmationInputDOB := le.ConfirmationInputDOB;
        SELF.ConfirmationInputSSN := le.ConfirmationInputSSN;
        SELF.ConfirmationInputAddress := le.ConfirmationInputAddress;
        SELF.SourceNonDerogProfileIndex := le.SourceNonDerogProfileIndex;
        SELF.SourceNonDerogCount := le.SourceNonDerogCount;
        SELF.SourceNonDerogCount03Month := le.SourceNonDerogCount03Month;
        SELF.SourceNonDerogCount06Month := le.SourceNonDerogCount06Month;
        SELF.SourceNonDerogCount12Month := le.SourceNonDerogCount12Month;
        SELF.SourceCredHeaderTimeOldest := le.SourceCredHeaderTimeOldest;
        SELF.SourceCredHeaderTimeNewest := le.SourceCredHeaderTimeNewest;
        SELF.SourceVoterRegistration := le.SourceVoterRegistration;
        SELF.EducationAttendance := le.EducationAttendance;
        SELF.EducationEvidence := le.EducationEvidence;
        SELF.EducationProgramAttended := le.EducationProgramAttended;
        SELF.EducationInstitutionPrivate := le.EducationInstitutionPrivate;
        SELF.EducationInstitutionRating := le.EducationInstitutionRating;
        SELF.ProfLicCount := le.ProfLicCount;
        SELF.ProfLicTypeCategory := le.ProfLicTypeCategory;
        SELF.BusinessAssociation := le.BusinessAssociation;
        SELF.BusinessAssociationIndex := le.BusinessAssociationIndex;
        SELF.BusinessAssociationTimeOldest := le.BusinessAssociationTimeOldest;
        SELF.BusinessTitleLeadership := le.BusinessTitleLeadership;
        SELF.AssetIndex := le.AssetIndex;
        SELF.AssetIndexPrimaryFactor := le.AssetIndexPrimaryFactor;
        SELF.AssetOwnership := le.AssetOwnership;
        SELF.AssetProp := le.AssetProp;
        SELF.AssetPropIndex := le.AssetPropIndex;
        SELF.AssetPropEverCount := le.AssetPropEverCount;
        SELF.AssetPropCurrentCount := le.AssetPropCurrentCount;
        SELF.AssetPropCurrentTaxTotal := le.AssetPropCurrentTaxTotal;
        SELF.AssetPropPurchaseCount12Month := le.AssetPropPurchaseCount12Month;
        SELF.AssetPropPurchaseTimeOldest := le.AssetPropPurchaseTimeOldest;
        SELF.AssetPropPurchaseTimeNewest := le.AssetPropPurchaseTimeNewest;
        SELF.AssetPropNewestMortgageType := le.AssetPropNewestMortgageType;
        SELF.AssetPropEverSoldCount := le.AssetPropEverSoldCount;
        SELF.AssetPropSoldCount12Month := le.AssetPropSoldCount12Month;
        SELF.AssetPropSaleTimeOldest := le.AssetPropSaleTimeOldest;
        SELF.AssetPropSaleTimeNewest := le.AssetPropSaleTimeNewest;
        SELF.AssetPropNewestSalePrice := le.AssetPropNewestSalePrice;
        SELF.AssetPropSalePurchaseRatio := le.AssetPropSalePurchaseRatio;
        SELF.AssetPersonal := le.AssetPersonal;
        SELF.AssetPersonalCount := le.AssetPersonalCount;
        SELF.PurchaseActivityIndex := le.PurchaseActivityIndex;
        SELF.PurchaseActivityCount := le.PurchaseActivityCount;
        SELF.PurchaseActivityDollarTotal := le.PurchaseActivityDollarTotal;
        SELF.DerogSeverityIndex := le.DerogSeverityIndex;
        SELF.DerogCount := le.DerogCount;
        SELF.DerogCount12Month := le.DerogCount12Month;
        SELF.DerogTimeNewest := le.DerogTimeNewest;
        SELF.CriminalFelonyCount := le.CriminalFelonyCount;
        SELF.CriminalFelonyCount12Month := le.CriminalFelonyCount12Month;
        SELF.CriminalFelonyTimeNewest := le.CriminalFelonyTimeNewest;
        SELF.CriminalNonFelonyCount := le.CriminalNonFelonyCount;
        SELF.CriminalNonFelonyCount12Month := le.CriminalNonFelonyCount12Month;
        SELF.CriminalNonFelonyTimeNewest := le.CriminalNonFelonyTimeNewest;
        SELF.EvictionCount := le.EvictionCount;
        SELF.EvictionCount12Month := le.EvictionCount12Month;
        SELF.EvictionTimeNewest := le.EvictionTimeNewest;
        SELF.LienJudgmentSeverityIndex := le.LienJudgmentSeverityIndex;
        SELF.LienJudgmentCount := le.LienJudgmentCount;
        SELF.LienJudgmentCount12Month := le.LienJudgmentCount12Month;
        SELF.LienJudgmentSmallClaimsCount := le.LienJudgmentSmallClaimsCount;
        SELF.LienJudgmentCourtCount := le.LienJudgmentCourtCount;
        SELF.LienJudgmentTaxCount := le.LienJudgmentTaxCount;
        SELF.LienJudgmentForeclosureCount := le.LienJudgmentForeclosureCount;
        SELF.LienJudgmentOtherCount := le.LienJudgmentOtherCount;
        SELF.LienJudgmentTimeNewest := le.LienJudgmentTimeNewest;
        SELF.LienJudgmentDollarTotal := le.LienJudgmentDollarTotal;
        SELF.BankruptcyCount := le.BankruptcyCount;
        SELF.BankruptcyCount24Month := le.BankruptcyCount24Month;
        SELF.BankruptcyTimeNewest := le.BankruptcyTimeNewest;
        SELF.BankruptcyChapter := le.BankruptcyChapter;
        SELF.BankruptcyStatus := le.BankruptcyStatus;
        SELF.BankruptcyDismissed24Month := le.BankruptcyDismissed24Month;
        SELF.ShortTermLoanRequest := le.ShortTermLoanRequest;
        SELF.ShortTermLoanRequest12Month := le.ShortTermLoanRequest12Month;
        SELF.ShortTermLoanRequest24Month := le.ShortTermLoanRequest24Month;
        SELF.InquiryAuto12Month := le.InquiryAuto12Month;
        SELF.InquiryBanking12Month := le.InquiryBanking12Month;
        SELF.InquiryTelcom12Month := le.InquiryTelcom12Month;
        SELF.InquiryNonShortTerm12Month := le.InquiryNonShortTerm12Month;
        SELF.InquiryShortTerm12Month := le.InquiryShortTerm12Month;
        SELF.InquiryCollections12Month := le.InquiryCollections12Month;
        SELF.SSNSubjectCount := le.SSNSubjectCount;
        SELF.SSNDeceased := le.SSNDeceased;
        SELF.SSNDateLowIssued := le.SSNDateLowIssued;
        SELF.SSNProblems := le.SSNProblems;
        SELF.AddrOnFileCount := le.AddrOnFileCount;
        SELF.AddrOnFileCorrectional := le.AddrOnFileCorrectional;
        SELF.AddrOnFileCollege := le.AddrOnFileCollege;
        SELF.AddrOnFileHighRisk := le.AddrOnFileHighRisk;
        SELF.AddrInputTimeOldest := le.AddrInputTimeOldest;
        SELF.AddrInputTimeNewest := le.AddrInputTimeNewest;
        SELF.AddrInputLengthOfRes := le.AddrInputLengthOfRes;
        SELF.AddrInputSubjectCount := le.AddrInputSubjectCount;
        SELF.AddrInputMatchIndex := le.AddrInputMatchIndex;
        SELF.AddrInputSubjectOwned := le.AddrInputSubjectOwned;
        SELF.AddrInputDeedMailing := le.AddrInputDeedMailing;
        SELF.AddrInputOwnershipIndex := le.AddrInputOwnershipIndex;
        SELF.AddrInputPhoneService := le.AddrInputPhoneService;
        SELF.AddrInputPhoneCount := le.AddrInputPhoneCount;
        SELF.AddrInputDwellType := le.AddrInputDwellType;
        SELF.AddrInputDwellTypeIndex := le.AddrInputDwellTypeIndex;
        SELF.AddrInputDelivery := le.AddrInputDelivery;
        SELF.AddrInputTimeLastSale := le.AddrInputTimeLastSale;
        SELF.AddrInputLastSalePrice := le.AddrInputLastSalePrice;
        SELF.AddrInputTaxValue := le.AddrInputTaxValue;
        SELF.AddrInputTaxYr := le.AddrInputTaxYr;
        SELF.AddrInputTaxMarketValue := le.AddrInputTaxMarketValue;
        SELF.AddrInputAVMValue := le.AddrInputAVMValue;
        SELF.AddrInputAVMValue12Month := le.AddrInputAVMValue12Month;
        SELF.AddrInputAVMRatio12MonthPrior := le.AddrInputAVMRatio12MonthPrior;
        SELF.AddrInputAVMValue60Month := le.AddrInputAVMValue60Month;
        SELF.AddrInputAVMRatio60MonthPrior := le.AddrInputAVMRatio60MonthPrior;
        SELF.AddrInputCountyRatio := le.AddrInputCountyRatio;
        SELF.AddrInputTractRatio := le.AddrInputTractRatio;
        SELF.AddrInputBlockRatio := le.AddrInputBlockRatio;
        SELF.AddrInputProblems := le.AddrInputProblems;
        SELF.AddrCurrentTimeOldest := le.AddrCurrentTimeOldest;
        SELF.AddrCurrentTimeNewest := le.AddrCurrentTimeNewest;
        SELF.AddrCurrentLengthOfRes := le.AddrCurrentLengthOfRes;
        SELF.AddrCurrentSubjectOwned := le.AddrCurrentSubjectOwned;
        SELF.AddrCurrentDeedMailing := le.AddrCurrentDeedMailing;
        SELF.AddrCurrentOwnershipIndex := le.AddrCurrentOwnershipIndex;
        SELF.AddrCurrentPhoneService := le.AddrCurrentPhoneService;
        SELF.AddrCurrentDwellType := le.AddrCurrentDwellType;
        SELF.AddrCurrentDwellTypeIndex := le.AddrCurrentDwellTypeIndex;
        SELF.AddrCurrentTimeLastSale := le.AddrCurrentTimeLastSale;
        SELF.AddrCurrentLastSalesPrice := le.AddrCurrentLastSalesPrice;
        SELF.AddrCurrentTaxValue := le.AddrCurrentTaxValue;
        SELF.AddrCurrentTaxYr := le.AddrCurrentTaxYr;
        SELF.AddrCurrentTaxMarketValue := le.AddrCurrentTaxMarketValue;
        SELF.AddrCurrentAVMValue := le.AddrCurrentAVMValue;
        SELF.AddrCurrentAVMValue12Month := le.AddrCurrentAVMValue12Month;
        SELF.AddrCurrentAVMRatio12MonthPrior := le.AddrCurrentAVMRatio12MonthPrior;
        SELF.AddrCurrentAVMValue60Month := le.AddrCurrentAVMValue60Month;
        SELF.AddrCurrentAVMRatio60MonthPrior := le.AddrCurrentAVMRatio60MonthPrior;
        SELF.AddrCurrentCountyRatio := le.AddrCurrentCountyRatio;
        SELF.AddrCurrentTractRatio := le.AddrCurrentTractRatio;
        SELF.AddrCurrentBlockRatio := le.AddrCurrentBlockRatio;
        SELF.AddrCurrentCorrectional := le.AddrCurrentCorrectional;
        SELF.AddrPreviousTimeOldest := le.AddrPreviousTimeOldest;
        SELF.AddrPreviousTimeNewest := le.AddrPreviousTimeNewest;
        SELF.AddrPreviousLengthOfRes := le.AddrPreviousLengthOfRes;
        SELF.AddrPreviousSubjectOwned := le.AddrPreviousSubjectOwned;
        SELF.AddrPreviousOwnershipIndex := le.AddrPreviousOwnershipIndex;
        SELF.AddrPreviousDwellType := le.AddrPreviousDwellType;
        SELF.AddrPreviousDwellTypeIndex := le.AddrPreviousDwellTypeIndex;
        SELF.AddrPreviousCorrectional := le.AddrPreviousCorrectional;
        SELF.AddrStabilityIndex := le.AddrStabilityIndex;
        SELF.AddrChangeCount03Month := le.AddrChangeCount03Month;
        SELF.AddrChangeCount06Month := le.AddrChangeCount06Month;
        SELF.AddrChangeCount12Month := le.AddrChangeCount12Month;
        SELF.AddrChangeCount24Month := le.AddrChangeCount24Month;
        SELF.AddrChangeCount60Month := le.AddrChangeCount60Month;
        SELF.AddrLastMoveTaxRatioDiff := le.AddrLastMoveTaxRatioDiff;
        SELF.AddrLastMoveEconTrajectory := le.AddrLastMoveEconTrajectory;
        SELF.AddrLastMoveEconTrajectoryIndex := le.AddrLastMoveEconTrajectoryIndex;
        SELF.PhoneInputProblems := le.PhoneInputProblems;
        SELF.PhoneInputSubjectCount := le.PhoneInputSubjectCount;
        SELF.PhoneInputMobile := le.PhoneInputMobile;
        SELF.AlertRegulatoryCondition := le.AlertRegulatoryCondition;
        SELF.rv3ConfirmationSubjectFound := le.rv3ConfirmationSubjectFound;
        SELF.rv3AddrChangeCount60Month := le.rv3AddrChangeCount60Month;
        SELF.rv3AddrChangeCount12Month := le.rv3AddrChangeCount12Month;
        SELF.rv3AddrInputTimeOldest := le.rv3AddrInputTimeOldest;
        SELF.rv3SourceNonDerogCount := le.rv3SourceNonDerogCount;
        SELF.rv3AssetPropCurrentCount := le.rv3AssetPropCurrentCount;
        SELF.rv3SSNDeceased := le.rv3SSNDeceased;
        SELF.rv3AssetIndex := le.rv3AssetIndex;
        SELF.CheckProfileIndex := le.CheckProfileIndex;
        SELF.CheckTimeOldest := le.CheckTimeOldest;
        SELF.CheckTimeNewest := le.CheckTimeNewest;
        SELF.CheckNegTimeOldest := le.CheckNegTimeOldest;
        SELF.CheckNegRiskDecTimeNewest := le.CheckNegRiskDecTimeNewest;
        SELF.CheckNegPaidTimeNewest := le.CheckNegPaidTimeNewest;
        SELF.CheckCountTotal := le.CheckCountTotal;
        SELF.CheckAmountTotal := le.CheckAmountTotal;
        SELF.CheckAmountTotalSinceNegPaid := le.CheckAmountTotalSinceNegPaid;
        SELF.CheckAmountTotal03Month := le.CheckAmountTotal03Month;
        SELF.Alert1 := le.Alert1;
        SELF.Alert2 := le.Alert2;
        SELF.Alert3 := le.Alert3;
        SELF.Alert4 := le.Alert4;
        SELF.Alert5 := le.Alert5;
        SELF.Alert6 := le.Alert6;
        SELF.Alert7 := le.Alert7;
        SELF.Alert8 := le.Alert8;
        SELF.Alert9 := le.Alert9;
        SELF.Alert10 := le.Alert10;
        SELF.ConsumerStatementText := le.ConsumerStatementText;
        SELF.LnJEvictionTotalCount := le.LnJEvictionTotalCount;
        SELF.LnJEvictionTotalCount12Month := le.LnJEvictionTotalCount12Month;
        SELF.LnjEvictionTimeNewest := le.LnjEvictionTimeNewest;
        SELF.LnJJudgmentSmallClaimsCount := le.LnJJudgmentSmallClaimsCount;
        SELF.LnjJudgmentCourtCount := le.LnjJudgmentCourtCount;
        SELF.LnjJudgmentForeclosureCount := le.LnjJudgmentForeclosureCount;
        SELF.LnjLienJudgmentSeverityIndex := le.LnjLienJudgmentSeverityIndex;
        SELF.LnjLienJudgmentCount := le.LnjLienJudgmentCount;
        SELF.LnjLienJudgmentCount12Month := le.LnjLienJudgmentCount12Month;
        SELF.LnJLienTaxCount := le.LnJLienTaxCount;
        SELF.LnjLienJudgmentOtherCount := le.LnjLienJudgmentOtherCount;
        SELF.LnjLienJudgmentTimeNewest := le.LnjLienJudgmentTimeNewest;
        SELF.LnjLienJudgmentDollarTotal := le.LnjLienJudgmentDollarTotal;
        SELF.LnjLienCount := le.LnjLienCount;
        SELF.LnjLienTimeNewest := le.LnjLienTimeNewest;
        SELF.LnjLienDollarTotal := le.LnjLienDollarTotal;
        SELF.LnjLienTaxTimeNewest := le.LnjLienTaxTimeNewest;
        SELF.LnjLienTaxDollarTotal := le.LnjLienTaxDollarTotal;
        SELF.LnjLienTaxStateCount := le.LnjLienTaxStateCount;
        SELF.LnjLienTaxStateTimeNewest := le.LnjLienTaxStateTimeNewest;
        SELF.LnjLienTaxStateDollarTotal := le.LnjLienTaxStateDollarTotal;
        SELF.LnjLienTaxFederalCount := le.LnjLienTaxFederalCount;
        SELF.LnjLienTaxFederalTimeNewest := le.LnjLienTaxFederalTimeNewest;
        SELF.LnjLienTaxFederalDollarTotal := le.LnjLienTaxFederalDollarTotal;
        SELF.LnjJudgmentCount := le.LnjJudgmentCount;
        SELF.LnjJudgmentTimeNewest := le.LnjJudgmentTimeNewest;
        SELF.LnjJudgmentDollarTotal := le.LnjJudgmentDollarTotal;
        SELF := [];
END;

//IDA model transforms
EXPORT Models.RVG2005_0_1.z_layouts_Input xfm_RVG2005_RVAttrs_and_IDAattrs(riskview.layouts.attributes_internal_layout_noscore le, Risk_Indicators.layouts.layout_IDA_out rt) := TRANSFORM
      Self.TransactionID := (String)le.seq;
      //RV attributes
      self.INPUTPROVIDEDFIRSTNAME                   := le.inputprovidedfirstname;
      self.INPUTPROVIDEDLASTNAME                    := le.inputprovidedlastname;
      self.INPUTPROVIDEDSTREETADDRESS               := le.inputprovidedstreetaddress;
      self.INPUTPROVIDEDCITY                        := le.inputprovidedcity;
      self.INPUTPROVIDEDSTATE                       := le.inputprovidedstate;
      self.INPUTPROVIDEDZIPCODE                     := le.inputprovidedzipcode;
      self.INPUTPROVIDEDSSN                         := le.inputprovidedssn;
      self.INPUTPROVIDEDDATEOFBIRTH                 := le.inputprovideddateofbirth;
      self.INPUTPROVIDEDPHONE                       := le.inputprovidedphone;
      self.INPUTPROVIDEDLEXID                       := le.inputprovidedlexid;
      self.SUBJECTRECORDTIMEOLDEST                  := le.subjectrecordtimeoldest;
      self.SUBJECTRECORDTIMENEWEST                  := le.subjectrecordtimenewest;
      self.SUBJECTNEWESTRECORD12MONTH               := le.subjectnewestrecord12month;
      self.SUBJECTACTIVITYINDEX03MONTH              := le.subjectactivityindex03month;
      self.SUBJECTACTIVITYINDEX06MONTH              := le.subjectactivityindex06month;
      self.SUBJECTACTIVITYINDEX12MONTH              := le.subjectactivityindex12month;
      self.SUBJECTAGE                               := le.subjectage;
      self.SUBJECTDECEASED                          := le.subjectdeceased;
      self.SUBJECTSSNCOUNT                          := le.subjectssncount;
      self.SUBJECTSTABILITYINDEX                    := le.subjectstabilityindex;
      self.SUBJECTSTABILITYPRIMARYFACTOR            := le.subjectstabilityprimaryfactor;
      self.SUBJECTABILITYINDEX                      := le.subjectabilityindex;
      self.SUBJECTABILITYPRIMARYFACTOR              := le.subjectabilityprimaryfactor;
      self.SUBJECTWILLINGNESSINDEX                  := le.subjectwillingnessindex;
      self.SUBJECTWILLINGNESSPRIMARYFACTOR          := le.subjectwillingnessprimaryfactor;
      self.CONFIRMATIONSUBJECTFOUND                 := le.confirmationsubjectfound;
      self.CONFIRMATIONINPUTNAME                    := le.confirmationinputname;
      self.CONFIRMATIONINPUTDOB                     := le.confirmationinputdob;
      self.CONFIRMATIONINPUTSSN                     := le.confirmationinputssn;
      self.CONFIRMATIONINPUTADDRESS                 := le.confirmationinputaddress;
      self.SOURCENONDEROGPROFILEINDEX               := le.sourcenonderogprofileindex;
      self.SOURCENONDEROGCOUNT                      := le.sourcenonderogcount;
      self.SOURCENONDEROGCOUNT03MONTH               := le.sourcenonderogcount03month;
      self.SOURCENONDEROGCOUNT06MONTH               := le.sourcenonderogcount06month;
      self.SOURCENONDEROGCOUNT12MONTH               := le.sourcenonderogcount12month;
      self.SOURCECREDHEADERTIMEOLDEST               := le.sourcecredheadertimeoldest;
      self.SOURCECREDHEADERTIMENEWEST               := le.sourcecredheadertimenewest;
      self.SOURCEVOTERREGISTRATION                  := le.sourcevoterregistration;
      self.EDUCATIONATTENDANCE                      := le.educationattendance;
      self.EDUCATIONEVIDENCE                        := le.educationevidence;
      self.EDUCATIONPROGRAMATTENDED                 := le.educationprogramattended;
      self.EDUCATIONINSTITUTIONPRIVATE              := le.educationinstitutionprivate;
      self.EDUCATIONINSTITUTIONRATING               := le.educationinstitutionrating;
      self.PROFLICCOUNT                             := le.profliccount;
      self.PROFLICTYPECATEGORY                      := le.proflictypecategory;
      self.BUSINESSASSOCIATION                      := le.businessassociation;
      self.BUSINESSASSOCIATIONINDEX                 := le.businessassociationindex;
      self.BUSINESSASSOCIATIONTIMEOLDEST            := le.businessassociationtimeoldest;
      self.BUSINESSTITLELEADERSHIP                  := le.businesstitleleadership;
      self.ASSETINDEX                               := le.assetindex;
      self.ASSETINDEXPRIMARYFACTOR                  := le.assetindexprimaryfactor;
      self.ASSETOWNERSHIP                           := le.assetownership;
      self.ASSETPROP                                := le.assetprop;
      self.ASSETPROPINDEX                           := le.assetpropindex;
      self.ASSETPROPEVERCOUNT                       := le.assetpropevercount;
      self.ASSETPROPCURRENTCOUNT                    := le.assetpropcurrentcount;
      self.ASSETPROPCURRENTTAXTOTAL                 := le.assetpropcurrenttaxtotal;
      self.ASSETPROPPURCHASECOUNT12MONTH            := le.assetproppurchasecount12month;
      self.ASSETPROPPURCHASETIMEOLDEST              := le.assetproppurchasetimeoldest;
      self.ASSETPROPPURCHASETIMENEWEST              := le.assetproppurchasetimenewest;
      self.ASSETPROPNEWESTMORTGAGETYPE              := le.assetpropnewestmortgagetype;
      self.ASSETPROPEVERSOLDCOUNT                   := le.assetpropeversoldcount;
      self.ASSETPROPSOLDCOUNT12MONTH                := le.assetpropsoldcount12month;
      self.ASSETPROPSALETIMEOLDEST                  := le.assetpropsaletimeoldest;
      self.ASSETPROPSALETIMENEWEST                  := le.assetpropsaletimenewest;
      self.ASSETPROPNEWESTSALEPRICE                 := le.assetpropnewestsaleprice;
      self.ASSETPROPSALEPURCHASERATIO               := le.assetpropsalepurchaseratio;
      self.ASSETPERSONAL                            := le.assetpersonal;
      self.ASSETPERSONALCOUNT                       := le.assetpersonalcount;
      self.PURCHASEACTIVITYINDEX                    := le.purchaseactivityindex;
      self.PURCHASEACTIVITYCOUNT                    := le.purchaseactivitycount;
      self.PURCHASEACTIVITYDOLLARTOTAL              := le.purchaseactivitydollartotal;
      self.DEROGSEVERITYINDEX                       := le.derogseverityindex;
      self.DEROGCOUNT                               := le.derogcount;
      self.DEROGCOUNT12MONTH                        := le.derogcount12month;
      self.DEROGTIMENEWEST                          := le.derogtimenewest;
      self.CRIMINALFELONYCOUNT                      := le.criminalfelonycount;
      self.CRIMINALFELONYCOUNT12MONTH               := le.criminalfelonycount12month;
      self.CRIMINALFELONYTIMENEWEST                 := le.criminalfelonytimenewest;
      self.CRIMINALNONFELONYCOUNT                   := le.criminalnonfelonycount;
      self.CRIMINALNONFELONYCOUNT12MONTH            := le.criminalnonfelonycount12month;
      self.CRIMINALNONFELONYTIMENEWEST              := le.criminalnonfelonytimenewest;
      self.EVICTIONCOUNT                            := le.evictioncount;
      self.EVICTIONCOUNT12MONTH                     := le.evictioncount12month;
      self.EVICTIONTIMENEWEST                       := le.evictiontimenewest;
      self.LIENJUDGMENTSEVERITYINDEX                := le.lienjudgmentseverityindex;
      self.LIENJUDGMENTCOUNT                        := le.lienjudgmentcount;
      self.LIENJUDGMENTCOUNT12MONTH                 := le.lienjudgmentcount12month;
      self.LIENJUDGMENTSMALLCLAIMSCOUNT             := le.lienjudgmentsmallclaimscount;
      self.LIENJUDGMENTCOURTCOUNT                   := le.lienjudgmentcourtcount;
      self.LIENJUDGMENTTAXCOUNT                     := le.lienjudgmenttaxcount;
      self.LIENJUDGMENTFORECLOSURECOUNT             := le.lienjudgmentforeclosurecount;
      self.LIENJUDGMENTOTHERCOUNT                   := le.lienjudgmentothercount;
      self.LIENJUDGMENTTIMENEWEST                   := le.lienjudgmenttimenewest;
      self.LIENJUDGMENTDOLLARTOTAL                  := le.lienjudgmentdollartotal;
      self.BANKRUPTCYCOUNT                          := le.bankruptcycount;
      self.BANKRUPTCYCOUNT24MONTH                   := le.bankruptcycount24month;
      self.BANKRUPTCYTIMENEWEST                     := le.bankruptcytimenewest;
      self.BANKRUPTCYCHAPTER                        := le.bankruptcychapter;
      self.BANKRUPTCYSTATUS                         := le.bankruptcystatus;
      self.BANKRUPTCYDISMISSED24MONTH               := le.bankruptcydismissed24month;
      self.SHORTTERMLOANREQUEST                     := le.shorttermloanrequest;
      self.SHORTTERMLOANREQUEST12MONTH              := le.shorttermloanrequest12month;
      self.SHORTTERMLOANREQUEST24MONTH              := le.shorttermloanrequest24month;
      self.INQUIRYAUTO12MONTH                       := le.inquiryauto12month;
      self.INQUIRYBANKING12MONTH                    := le.inquirybanking12month;
      self.INQUIRYTELCOM12MONTH                     := le.inquirytelcom12month;
      self.INQUIRYNONSHORTTERM12MONTH               := le.inquirynonshortterm12month;
      self.INQUIRYSHORTTERM12MONTH                  := le.inquiryshortterm12month;
      self.INQUIRYCOLLECTIONS12MONTH                := le.inquirycollections12month;
      self.SSNSUBJECTCOUNT                          := le.ssnsubjectcount;
      self.SSNDECEASED                              := le.ssndeceased;
      self.SSNDATELOWISSUED                         := le.ssndatelowissued;
      self.SSNPROBLEMS                              := le.ssnproblems;
      self.ADDRONFILECOUNT                          := le.addronfilecount;
      self.ADDRONFILECORRECTIONAL                   := le.addronfilecorrectional;
      self.ADDRONFILECOLLEGE                        := le.addronfilecollege;
      self.ADDRONFILEHIGHRISK                       := le.addronfilehighrisk;
      self.ADDRINPUTTIMEOLDEST                      := le.addrinputtimeoldest;
      self.ADDRINPUTTIMENEWEST                      := le.addrinputtimenewest;
      self.ADDRINPUTLENGTHOFRES                     := le.addrinputlengthofres;
      self.ADDRINPUTSUBJECTCOUNT                    := le.addrinputsubjectcount;
      self.ADDRINPUTMATCHINDEX                      := le.addrinputmatchindex;
      self.ADDRINPUTSUBJECTOWNED                    := le.addrinputsubjectowned;
      self.ADDRINPUTDEEDMAILING                     := le.addrinputdeedmailing;
      self.ADDRINPUTOWNERSHIPINDEX                  := le.addrinputownershipindex;
      self.ADDRINPUTPHONESERVICE                    := le.addrinputphoneservice;
      self.ADDRINPUTPHONECOUNT                      := le.addrinputphonecount;
      self.ADDRINPUTDWELLTYPE                       := le.addrinputdwelltype;
      self.ADDRINPUTDWELLTYPEINDEX                  := le.addrinputdwelltypeindex;
      self.ADDRINPUTDELIVERY                        := le.addrinputdelivery;
      self.ADDRINPUTTIMELASTSALE                    := le.addrinputtimelastsale;
      self.ADDRINPUTLASTSALEPRICE                   := le.addrinputlastsaleprice;
      self.ADDRINPUTTAXVALUE                        := le.addrinputtaxvalue;
      self.ADDRINPUTTAXYR                           := le.addrinputtaxyr;
      self.ADDRINPUTTAXMARKETVALUE                  := le.addrinputtaxmarketvalue;
      self.ADDRINPUTAVMVALUE                        := le.addrinputavmvalue;
      self.ADDRINPUTAVMVALUE12MONTH                 := le.addrinputavmvalue12month;
      self.ADDRINPUTAVMRATIO12MONTHPRIOR            := le.addrinputavmratio12monthprior;
      self.ADDRINPUTAVMVALUE60MONTH                 := le.addrinputavmvalue60month;
      self.ADDRINPUTAVMRATIO60MONTHPRIOR            := le.addrinputavmratio60monthprior;
      self.ADDRINPUTCOUNTYRATIO                     := le.addrinputcountyratio;
      self.ADDRINPUTTRACTRATIO                      := le.addrinputtractratio;
      self.ADDRINPUTBLOCKRATIO                      := le.addrinputblockratio;
      self.ADDRINPUTPROBLEMS                        := le.addrinputproblems;
      self.ADDRCURRENTTIMEOLDEST                    := le.addrcurrenttimeoldest;
      self.ADDRCURRENTTIMENEWEST                    := le.addrcurrenttimenewest;
      self.ADDRCURRENTLENGTHOFRES                   := le.addrcurrentlengthofres;
      self.ADDRCURRENTSUBJECTOWNED                  := le.addrcurrentsubjectowned;
      self.ADDRCURRENTDEEDMAILING                   := le.addrcurrentdeedmailing;
      self.ADDRCURRENTOWNERSHIPINDEX                := le.addrcurrentownershipindex;
      self.ADDRCURRENTPHONESERVICE                  := le.addrcurrentphoneservice;
      self.ADDRCURRENTDWELLTYPE                     := le.addrcurrentdwelltype;
      self.ADDRCURRENTDWELLTYPEINDEX                := le.addrcurrentdwelltypeindex;
      self.ADDRCURRENTTIMELASTSALE                  := le.addrcurrenttimelastsale;
      self.ADDRCURRENTLASTSALESPRICE                := le.addrcurrentlastsalesprice;
      self.ADDRCURRENTTAXVALUE                      := le.addrcurrenttaxvalue;
      self.ADDRCURRENTTAXYR                         := le.addrcurrenttaxyr;
      self.ADDRCURRENTTAXMARKETVALUE                := le.addrcurrenttaxmarketvalue;
      self.ADDRCURRENTAVMVALUE                      := le.addrcurrentavmvalue;
      self.ADDRCURRENTAVMVALUE12MONTH               := le.addrcurrentavmvalue12month;
      self.ADDRCURRENTAVMRATIO12MONTHPRIOR          := le.addrcurrentavmratio12monthprior;
      self.ADDRCURRENTAVMVALUE60MONTH               := le.addrcurrentavmvalue60month;
      self.ADDRCURRENTAVMRATIO60MONTHPRIOR          := le.addrcurrentavmratio60monthprior;
      self.ADDRCURRENTCOUNTYRATIO                   := le.addrcurrentcountyratio;
      self.ADDRCURRENTTRACTRATIO                    := le.addrcurrenttractratio;
      self.ADDRCURRENTBLOCKRATIO                    := le.addrcurrentblockratio;
      self.ADDRCURRENTCORRECTIONAL                  := le.addrcurrentcorrectional;
      self.ADDRPREVIOUSTIMEOLDEST                   := le.addrprevioustimeoldest;
      self.ADDRPREVIOUSTIMENEWEST                   := le.addrprevioustimenewest;
      self.ADDRPREVIOUSLENGTHOFRES                  := le.addrpreviouslengthofres;
      self.ADDRPREVIOUSSUBJECTOWNED                 := le.addrprevioussubjectowned;
      self.ADDRPREVIOUSOWNERSHIPINDEX               := le.addrpreviousownershipindex;
      self.ADDRPREVIOUSDWELLTYPE                    := le.addrpreviousdwelltype;
      self.ADDRPREVIOUSDWELLTYPEINDEX               := le.addrpreviousdwelltypeindex;
      self.ADDRPREVIOUSCORRECTIONAL                 := le.addrpreviouscorrectional;
      self.ADDRSTABILITYINDEX                       := le.addrstabilityindex;
      self.ADDRCHANGECOUNT03MONTH                   := le.addrchangecount03month;
      self.ADDRCHANGECOUNT06MONTH                   := le.addrchangecount06month;
      self.ADDRCHANGECOUNT12MONTH                   := le.addrchangecount12month;
      self.ADDRCHANGECOUNT24MONTH                   := le.addrchangecount24month;
      self.ADDRCHANGECOUNT60MONTH                   := le.addrchangecount60month;
      self.ADDRLASTMOVETAXRATIODIFF                 := le.addrlastmovetaxratiodiff;
      self.ADDRLASTMOVEECONTRAJECTORY               := le.addrlastmoveecontrajectory;
      self.ADDRLASTMOVEECONTRAJECTORYINDEX          := le.addrlastmoveecontrajectoryindex;
      self.PHONEINPUTPROBLEMS                       := le.phoneinputproblems;
      self.PHONEINPUTSUBJECTCOUNT                   := le.phoneinputsubjectcount;
      self.PHONEINPUTMOBILE                         := le.phoneinputmobile;
      self.ALERTREGULATORYCONDITION                 := le.alertregulatorycondition;
      
      //IDA attributes
      self.CADCSAP_IBK_S1_D90_NUM                   := rt.Indicators(name = 'CADCSAP_IBK_S1_D90_NUM')[1].value;
      self.CADCSAP_IBK_S1_D90_UNAME                 := rt.Indicators(name = 'CADCSAP_IBK_S1_D90_UNAME')[1].value;
      self.CADCSAP_IBK_S1_D90_UADD                  := rt.Indicators(name = 'CADCSAP_IBK_S1_D90_UADD')[1].value;
      self.CADCSAP_IBK_S1_D90_UHP                   := rt.Indicators(name = 'CADCSAP_IBK_S1_D90_UHP')[1].value;
      self.CADCSAP_IBK_S1_D90_UDOB                  := rt.Indicators(name = 'CADCSAP_IBK_S1_D90_UDOB')[1].value;
      self.CADCSAP_IBK_S1_D90_UEMAIL                := rt.Indicators(name = 'CADCSAP_IBK_S1_D90_UEMAIL')[1].value;
      self.CADCSAP_IBK_S1_D90_DAYSMR                := rt.Indicators(name = 'CADCSAP_IBK_S1_D90_DAYSMR')[1].value;
      self.CADCSAP_IBK_S1_D90_DAYSLR                := rt.Indicators(name = 'CADCSAP_IBK_S1_D90_DAYSLR')[1].value;
      self.CADCSAP_IBK_S1_D120_NUM                  := rt.Indicators(name = 'CADCSAP_IBK_S1_D120_NUM')[1].value;
      self.CADCSAP_IBK_S1_D120_UNAME                := rt.Indicators(name = 'CADCSAP_IBK_S1_D120_UNAME')[1].value;
      self.CADCSAP_IBK_S1_D120_UADD                 := rt.Indicators(name = 'CADCSAP_IBK_S1_D120_UADD')[1].value;
      self.CADCSAP_IBK_S1_D120_UHP                  := rt.Indicators(name = 'CADCSAP_IBK_S1_D120_UHP')[1].value;
      self.CADCSAP_IBK_S1_D120_UDOB                 := rt.Indicators(name = 'CADCSAP_IBK_S1_D120_UDOB')[1].value;
      self.CADCSAP_IBK_S1_D120_UEMAIL               := rt.Indicators(name = 'CADCSAP_IBK_S1_D120_UEMAIL')[1].value;
      self.CADCSAP_IBK_S1_D120_DAYSMR               := rt.Indicators(name = 'CADCSAP_IBK_S1_D120_DAYSMR')[1].value;
      self.CADCSAP_IBK_S1_D120_DAYSLR               := rt.Indicators(name = 'CADCSAP_IBK_S1_D120_DAYSLR')[1].value;
      self.CADCSAP_IBK_S1_D365_NUM                  := rt.Indicators(name = 'CADCSAP_IBK_S1_D365_NUM')[1].value;
      self.CADCSAP_IBK_S1_D365_UNAME                := rt.Indicators(name = 'CADCSAP_IBK_S1_D365_UNAME')[1].value;
      self.CADCSAP_IBK_S1_D365_UADD                 := rt.Indicators(name = 'CADCSAP_IBK_S1_D365_UADD')[1].value;
      self.CADCSAP_IBK_S1_D365_UHP                  := rt.Indicators(name = 'CADCSAP_IBK_S1_D365_UHP')[1].value;
      self.CADCSAP_IBK_S1_D365_UDOB                 := rt.Indicators(name = 'CADCSAP_IBK_S1_D365_UDOB')[1].value;
      self.CADCSAP_IBK_S1_D365_UEMAIL               := rt.Indicators(name = 'CADCSAP_IBK_S1_D365_UEMAIL')[1].value;
      self.CADCSAP_IBK_S1_D365_DAYSMR               := rt.Indicators(name = 'CADCSAP_IBK_S1_D365_DAYSMR')[1].value;
      self.CADCSAP_IBK_S1_D365_DAYSLR               := rt.Indicators(name = 'CADCSAP_IBK_S1_D365_DAYSLR')[1].value;
      self.CADCSAP_IBK_S1_D1095_NUM                 := rt.Indicators(name = 'CADCSAP_IBK_S1_D1095_NUM')[1].value;
      self.CADCSAP_IBK_S1_D1095_UNAME               := rt.Indicators(name = 'CADCSAP_IBK_S1_D1095_UNAME')[1].value;
      self.CADCSAP_IBK_S1_D1095_UADD                := rt.Indicators(name = 'CADCSAP_IBK_S1_D1095_UADD')[1].value;
      self.CADCSAP_IBK_S1_D1095_UHP                 := rt.Indicators(name = 'CADCSAP_IBK_S1_D1095_UHP')[1].value;
      self.CADCSAP_IBK_S1_D1095_UDOB                := rt.Indicators(name = 'CADCSAP_IBK_S1_D1095_UDOB')[1].value;
      self.CADCSAP_IBK_S1_D1095_UEMAIL              := rt.Indicators(name = 'CADCSAP_IBK_S1_D1095_UEMAIL')[1].value;
      self.CADCSAP_IBK_S1_D1095_DAYSMR              := rt.Indicators(name = 'CADCSAP_IBK_S1_D1095_DAYSMR')[1].value;
      self.CADCSAP_IBK_S1_D1095_DAYSLR              := rt.Indicators(name = 'CADCSAP_IBK_S1_D1095_DAYSLR')[1].value;
      self.CADCSAP_IBK_A1_D90_NUM                   := rt.Indicators(name = 'CADCSAP_IBK_A1_D90_NUM')[1].value;
      self.CADCSAP_IBK_A1_D90_UNAME                 := rt.Indicators(name = 'CADCSAP_IBK_A1_D90_UNAME')[1].value;
      self.CADCSAP_IBK_A1_D90_UHP                   := rt.Indicators(name = 'CADCSAP_IBK_A1_D90_UHP')[1].value;
      self.CADCSAP_IBK_A1_D90_UDOB                  := rt.Indicators(name = 'CADCSAP_IBK_A1_D90_UDOB')[1].value;
      self.CADCSAP_IBK_A1_D90_UEMAIL                := rt.Indicators(name = 'CADCSAP_IBK_A1_D90_UEMAIL')[1].value;
      self.CADCSAP_IBK_A1_D90_DAYSMR                := rt.Indicators(name = 'CADCSAP_IBK_A1_D90_DAYSMR')[1].value;
      self.CADCSAP_IBK_A1_D90_DAYSLR                := rt.Indicators(name = 'CADCSAP_IBK_A1_D90_DAYSLR')[1].value;
      self.CADCSAP_IBK_A1_D120_NUM                  := rt.Indicators(name = 'CADCSAP_IBK_A1_D120_NUM')[1].value;
      self.CADCSAP_IBK_A1_D120_UNAME                := rt.Indicators(name = 'CADCSAP_IBK_A1_D120_UNAME')[1].value;
      self.CADCSAP_IBK_A1_D120_UHP                  := rt.Indicators(name = 'CADCSAP_IBK_A1_D120_UHP')[1].value;
      self.CADCSAP_IBK_A1_D120_UDOB                 := rt.Indicators(name = 'CADCSAP_IBK_A1_D120_UDOB')[1].value;
      self.CADCSAP_IBK_A1_D120_UEMAIL               := rt.Indicators(name = 'CADCSAP_IBK_A1_D120_UEMAIL')[1].value;
      self.CADCSAP_IBK_A1_D120_DAYSMR               := rt.Indicators(name = 'CADCSAP_IBK_A1_D120_DAYSMR')[1].value;
      self.CADCSAP_IBK_A1_D120_DAYSLR               := rt.Indicators(name = 'CADCSAP_IBK_A1_D120_DAYSLR')[1].value;
      self.CADCSAP_IBK_A1_D365_NUM                  := rt.Indicators(name = 'CADCSAP_IBK_A1_D365_NUM')[1].value;
      self.CADCSAP_IBK_A1_D365_UNAME                := rt.Indicators(name = 'CADCSAP_IBK_A1_D365_UNAME')[1].value;
      self.CADCSAP_IBK_A1_D365_UHP                  := rt.Indicators(name = 'CADCSAP_IBK_A1_D365_UHP')[1].value;
      self.CADCSAP_IBK_A1_D365_UDOB                 := rt.Indicators(name = 'CADCSAP_IBK_A1_D365_UDOB')[1].value;
      self.CADCSAP_IBK_A1_D365_UEMAIL               := rt.Indicators(name = 'CADCSAP_IBK_A1_D365_UEMAIL')[1].value;
      self.CADCSAP_IBK_A1_D365_DAYSMR               := rt.Indicators(name = 'CADCSAP_IBK_A1_D365_DAYSMR')[1].value;
      self.CADCSAP_IBK_A1_D365_DAYSLR               := rt.Indicators(name = 'CADCSAP_IBK_A1_D365_DAYSLR')[1].value;
      self.CADCSAP_IBK_A1_D1095_NUM                 := rt.Indicators(name = 'CADCSAP_IBK_A1_D1095_NUM')[1].value;
      self.CADCSAP_IBK_A1_D1095_UNAME               := rt.Indicators(name = 'CADCSAP_IBK_A1_D1095_UNAME')[1].value;
      self.CADCSAP_IBK_A1_D1095_UHP                 := rt.Indicators(name = 'CADCSAP_IBK_A1_D1095_UHP')[1].value;
      self.CADCSAP_IBK_A1_D1095_UDOB                := rt.Indicators(name = 'CADCSAP_IBK_A1_D1095_UDOB')[1].value;
      self.CADCSAP_IBK_A1_D1095_UEMAIL              := rt.Indicators(name = 'CADCSAP_IBK_A1_D1095_UEMAIL')[1].value;
      self.CADCSAP_IBK_A1_D1095_DAYSMR              := rt.Indicators(name = 'CADCSAP_IBK_A1_D1095_DAYSMR')[1].value;
      self.CADCSAP_IBK_A1_D1095_DAYSLR              := rt.Indicators(name = 'CADCSAP_IBK_A1_D1095_DAYSLR')[1].value;
      self.CADCSAP_IBK_P1_D90_NUM                   := rt.Indicators(name = 'CADCSAP_IBK_P1_D90_NUM')[1].value;
      self.CADCSAP_IBK_P1_D90_UNAME                 := rt.Indicators(name = 'CADCSAP_IBK_P1_D90_UNAME')[1].value;
      self.CADCSAP_IBK_P1_D90_UADD                  := rt.Indicators(name = 'CADCSAP_IBK_P1_D90_UADD')[1].value;
      self.CADCSAP_IBK_P1_D90_UDOB                  := rt.Indicators(name = 'CADCSAP_IBK_P1_D90_UDOB')[1].value;
      self.CADCSAP_IBK_P1_D90_UEMAIL                := rt.Indicators(name = 'CADCSAP_IBK_P1_D90_UEMAIL')[1].value;
      self.CADCSAP_IBK_P1_D90_DAYSMR                := rt.Indicators(name = 'CADCSAP_IBK_P1_D90_DAYSMR')[1].value;
      self.CADCSAP_IBK_P1_D90_DAYSLR                := rt.Indicators(name = 'CADCSAP_IBK_P1_D90_DAYSLR')[1].value;
      self.CADCSAP_IBK_P1_D120_NUM                  := rt.Indicators(name = 'CADCSAP_IBK_P1_D120_NUM')[1].value;
      self.CADCSAP_IBK_P1_D120_UNAME                := rt.Indicators(name = 'CADCSAP_IBK_P1_D120_UNAME')[1].value;
      self.CADCSAP_IBK_P1_D120_UADD                 := rt.Indicators(name = 'CADCSAP_IBK_P1_D120_UADD')[1].value;
      self.CADCSAP_IBK_P1_D120_UDOB                 := rt.Indicators(name = 'CADCSAP_IBK_P1_D120_UDOB')[1].value;
      self.CADCSAP_IBK_P1_D120_UEMAIL               := rt.Indicators(name = 'CADCSAP_IBK_P1_D120_UEMAIL')[1].value;
      self.CADCSAP_IBK_P1_D120_DAYSMR               := rt.Indicators(name = 'CADCSAP_IBK_P1_D120_DAYSMR')[1].value;
      self.CADCSAP_IBK_P1_D120_DAYSLR               := rt.Indicators(name = 'CADCSAP_IBK_P1_D120_DAYSLR')[1].value;
      self.CADCSAP_IBK_P1_D365_NUM                  := rt.Indicators(name = 'CADCSAP_IBK_P1_D365_NUM')[1].value;
      self.CADCSAP_IBK_P1_D365_UNAME                := rt.Indicators(name = 'CADCSAP_IBK_P1_D365_UNAME')[1].value;
      self.CADCSAP_IBK_P1_D365_UADD                 := rt.Indicators(name = 'CADCSAP_IBK_P1_D365_UADD')[1].value;
      self.CADCSAP_IBK_P1_D365_UDOB                 := rt.Indicators(name = 'CADCSAP_IBK_P1_D365_UDOB')[1].value;
      self.CADCSAP_IBK_P1_D365_UEMAIL               := rt.Indicators(name = 'CADCSAP_IBK_P1_D365_UEMAIL')[1].value;
      self.CADCSAP_IBK_P1_D365_DAYSMR               := rt.Indicators(name = 'CADCSAP_IBK_P1_D365_DAYSMR')[1].value;
      self.CADCSAP_IBK_P1_D365_DAYSLR               := rt.Indicators(name = 'CADCSAP_IBK_P1_D365_DAYSLR')[1].value;
      self.CADCSAP_IBK_P1_D1095_NUM                 := rt.Indicators(name = 'CADCSAP_IBK_P1_D1095_NUM')[1].value;
      self.CADCSAP_IBK_P1_D1095_UNAME               := rt.Indicators(name = 'CADCSAP_IBK_P1_D1095_UNAME')[1].value;
      self.CADCSAP_IBK_P1_D1095_UADD                := rt.Indicators(name = 'CADCSAP_IBK_P1_D1095_UADD')[1].value;
      self.CADCSAP_IBK_P1_D1095_UDOB                := rt.Indicators(name = 'CADCSAP_IBK_P1_D1095_UDOB')[1].value;
      self.CADCSAP_IBK_P1_D1095_UEMAIL              := rt.Indicators(name = 'CADCSAP_IBK_P1_D1095_UEMAIL')[1].value;
      self.CADCSAP_IBK_P1_D1095_DAYSMR              := rt.Indicators(name = 'CADCSAP_IBK_P1_D1095_DAYSMR')[1].value;
      self.CADCSAP_IBK_P1_D1095_DAYSLR              := rt.Indicators(name = 'CADCSAP_IBK_P1_D1095_DAYSLR')[1].value;
      self.CADCSAP_IBK_PX_D90_NUM                   := rt.Indicators(name = 'CADCSAP_IBK_PX_D90_NUM')[1].value;
      self.CADCSAP_IBK_PX_D90_UNAME                 := rt.Indicators(name = 'CADCSAP_IBK_PX_D90_UNAME')[1].value;
      self.CADCSAP_IBK_PX_D90_UADD                  := rt.Indicators(name = 'CADCSAP_IBK_PX_D90_UADD')[1].value;
      self.CADCSAP_IBK_PX_D90_UHP                   := rt.Indicators(name = 'CADCSAP_IBK_PX_D90_UHP')[1].value;
      self.CADCSAP_IBK_PX_D90_UDOB                  := rt.Indicators(name = 'CADCSAP_IBK_PX_D90_UDOB')[1].value;
      self.CADCSAP_IBK_PX_D90_UEMAIL                := rt.Indicators(name = 'CADCSAP_IBK_PX_D90_UEMAIL')[1].value;
      self.CADCSAP_IBK_PX_D90_DAYSMR                := rt.Indicators(name = 'CADCSAP_IBK_PX_D90_DAYSMR')[1].value;
      self.CADCSAP_IBK_PX_D90_DAYSLR                := rt.Indicators(name = 'CADCSAP_IBK_PX_D90_DAYSLR')[1].value;
      self.CADCSAP_IBK_PX_D120_NUM                  := rt.Indicators(name = 'CADCSAP_IBK_PX_D120_NUM')[1].value;
      self.CADCSAP_IBK_PX_D120_UNAME                := rt.Indicators(name = 'CADCSAP_IBK_PX_D120_UNAME')[1].value;
      self.CADCSAP_IBK_PX_D120_UADD                 := rt.Indicators(name = 'CADCSAP_IBK_PX_D120_UADD')[1].value;
      self.CADCSAP_IBK_PX_D120_UHP                  := rt.Indicators(name = 'CADCSAP_IBK_PX_D120_UHP')[1].value;
      self.CADCSAP_IBK_PX_D120_UDOB                 := rt.Indicators(name = 'CADCSAP_IBK_PX_D120_UDOB')[1].value;
      self.CADCSAP_IBK_PX_D120_UEMAIL               := rt.Indicators(name = 'CADCSAP_IBK_PX_D120_UEMAIL')[1].value;
      self.CADCSAP_IBK_PX_D120_DAYSMR               := rt.Indicators(name = 'CADCSAP_IBK_PX_D120_DAYSMR')[1].value;
      self.CADCSAP_IBK_PX_D120_DAYSLR               := rt.Indicators(name = 'CADCSAP_IBK_PX_D120_DAYSLR')[1].value;
      self.CADCSAP_IBK_PX_D365_NUM                  := rt.Indicators(name = 'CADCSAP_IBK_PX_D365_NUM')[1].value;
      self.CADCSAP_IBK_PX_D365_UNAME                := rt.Indicators(name = 'CADCSAP_IBK_PX_D365_UNAME')[1].value;
      self.CADCSAP_IBK_PX_D365_UADD                 := rt.Indicators(name = 'CADCSAP_IBK_PX_D365_UADD')[1].value;
      self.CADCSAP_IBK_PX_D365_UHP                  := rt.Indicators(name = 'CADCSAP_IBK_PX_D365_UHP')[1].value;
      self.CADCSAP_IBK_PX_D365_UDOB                 := rt.Indicators(name = 'CADCSAP_IBK_PX_D365_UDOB')[1].value;
      self.CADCSAP_IBK_PX_D365_UEMAIL               := rt.Indicators(name = 'CADCSAP_IBK_PX_D365_UEMAIL')[1].value;
      self.CADCSAP_IBK_PX_D365_DAYSMR               := rt.Indicators(name = 'CADCSAP_IBK_PX_D365_DAYSMR')[1].value;
      self.CADCSAP_IBK_PX_D365_DAYSLR               := rt.Indicators(name = 'CADCSAP_IBK_PX_D365_DAYSLR')[1].value;
      self.CADCSAP_IBK_PX_D1095_NUM                 := rt.Indicators(name = 'CADCSAP_IBK_PX_D1095_NUM')[1].value;
      self.CADCSAP_IBK_PX_D1095_UNAME               := rt.Indicators(name = 'CADCSAP_IBK_PX_D1095_UNAME')[1].value;
      self.CADCSAP_IBK_PX_D1095_UADD                := rt.Indicators(name = 'CADCSAP_IBK_PX_D1095_UADD')[1].value;
      self.CADCSAP_IBK_PX_D1095_UHP                 := rt.Indicators(name = 'CADCSAP_IBK_PX_D1095_UHP')[1].value;
      self.CADCSAP_IBK_PX_D1095_UDOB                := rt.Indicators(name = 'CADCSAP_IBK_PX_D1095_UDOB')[1].value;
      self.CADCSAP_IBK_PX_D1095_UEMAIL              := rt.Indicators(name = 'CADCSAP_IBK_PX_D1095_UEMAIL')[1].value;
      self.CADCSAP_IBK_PX_D1095_DAYSMR              := rt.Indicators(name = 'CADCSAP_IBK_PX_D1095_DAYSMR')[1].value;
      self.CADCSAP_IBK_PX_D1095_DAYSLR              := rt.Indicators(name = 'CADCSAP_IBK_PX_D1095_DAYSLR')[1].value;
      self.CADCSAP_IPD_S1_D90_NUM                   := rt.Indicators(name = 'CADCSAP_IPD_S1_D90_NUM')[1].value;
      self.CADCSAP_IPD_S1_D90_UNAME                 := rt.Indicators(name = 'CADCSAP_IPD_S1_D90_UNAME')[1].value;
      self.CADCSAP_IPD_S1_D90_UADD                  := rt.Indicators(name = 'CADCSAP_IPD_S1_D90_UADD')[1].value;
      self.CADCSAP_IPD_S1_D90_UHP                   := rt.Indicators(name = 'CADCSAP_IPD_S1_D90_UHP')[1].value;
      self.CADCSAP_IPD_S1_D90_UDOB                  := rt.Indicators(name = 'CADCSAP_IPD_S1_D90_UDOB')[1].value;
      self.CADCSAP_IPD_S1_D90_UEMAIL                := rt.Indicators(name = 'CADCSAP_IPD_S1_D90_UEMAIL')[1].value;
      self.CADCSAP_IPD_S1_D90_DAYSMR                := rt.Indicators(name = 'CADCSAP_IPD_S1_D90_DAYSMR')[1].value;
      self.CADCSAP_IPD_S1_D90_DAYSLR                := rt.Indicators(name = 'CADCSAP_IPD_S1_D90_DAYSLR')[1].value;
      self.CADCSAP_IPD_S1_D120_NUM                  := rt.Indicators(name = 'CADCSAP_IPD_S1_D120_NUM')[1].value;
      self.CADCSAP_IPD_S1_D120_UNAME                := rt.Indicators(name = 'CADCSAP_IPD_S1_D120_UNAME')[1].value;
      self.CADCSAP_IPD_S1_D120_UADD                 := rt.Indicators(name = 'CADCSAP_IPD_S1_D120_UADD')[1].value;
      self.CADCSAP_IPD_S1_D120_UHP                  := rt.Indicators(name = 'CADCSAP_IPD_S1_D120_UHP')[1].value;
      self.CADCSAP_IPD_S1_D120_UDOB                 := rt.Indicators(name = 'CADCSAP_IPD_S1_D120_UDOB')[1].value;
      self.CADCSAP_IPD_S1_D120_UEMAIL               := rt.Indicators(name = 'CADCSAP_IPD_S1_D120_UEMAIL')[1].value;
      self.CADCSAP_IPD_S1_D120_DAYSMR               := rt.Indicators(name = 'CADCSAP_IPD_S1_D120_DAYSMR')[1].value;
      self.CADCSAP_IPD_S1_D120_DAYSLR               := rt.Indicators(name = 'CADCSAP_IPD_S1_D120_DAYSLR')[1].value;
      self.CADCSAP_IPD_S1_D365_NUM                  := rt.Indicators(name = 'CADCSAP_IPD_S1_D365_NUM')[1].value;
      self.CADCSAP_IPD_S1_D365_UNAME                := rt.Indicators(name = 'CADCSAP_IPD_S1_D365_UNAME')[1].value;
      self.CADCSAP_IPD_S1_D365_UADD                 := rt.Indicators(name = 'CADCSAP_IPD_S1_D365_UADD')[1].value;
      self.CADCSAP_IPD_S1_D365_UHP                  := rt.Indicators(name = 'CADCSAP_IPD_S1_D365_UHP')[1].value;
      self.CADCSAP_IPD_S1_D365_UDOB                 := rt.Indicators(name = 'CADCSAP_IPD_S1_D365_UDOB')[1].value;
      self.CADCSAP_IPD_S1_D365_UEMAIL               := rt.Indicators(name = 'CADCSAP_IPD_S1_D365_UEMAIL')[1].value;
      self.CADCSAP_IPD_S1_D365_DAYSMR               := rt.Indicators(name = 'CADCSAP_IPD_S1_D365_DAYSMR')[1].value;
      self.CADCSAP_IPD_S1_D365_DAYSLR               := rt.Indicators(name = 'CADCSAP_IPD_S1_D365_DAYSLR')[1].value;
      self.CADCSAP_IPD_S1_D1095_NUM                 := rt.Indicators(name = 'CADCSAP_IPD_S1_D1095_NUM')[1].value;
      self.CADCSAP_IPD_S1_D1095_UNAME               := rt.Indicators(name = 'CADCSAP_IPD_S1_D1095_UNAME')[1].value;
      self.CADCSAP_IPD_S1_D1095_UADD                := rt.Indicators(name = 'CADCSAP_IPD_S1_D1095_UADD')[1].value;
      self.CADCSAP_IPD_S1_D1095_UHP                 := rt.Indicators(name = 'CADCSAP_IPD_S1_D1095_UHP')[1].value;
      self.CADCSAP_IPD_S1_D1095_UDOB                := rt.Indicators(name = 'CADCSAP_IPD_S1_D1095_UDOB')[1].value;
      self.CADCSAP_IPD_S1_D1095_UEMAIL              := rt.Indicators(name = 'CADCSAP_IPD_S1_D1095_UEMAIL')[1].value;
      self.CADCSAP_IPD_S1_D1095_DAYSMR              := rt.Indicators(name = 'CADCSAP_IPD_S1_D1095_DAYSMR')[1].value;
      self.CADCSAP_IPD_S1_D1095_DAYSLR              := rt.Indicators(name = 'CADCSAP_IPD_S1_D1095_DAYSLR')[1].value;
      self.CADCSAP_IPD_A1_D90_NUM                   := rt.Indicators(name = 'CADCSAP_IPD_A1_D90_NUM')[1].value;
      self.CADCSAP_IPD_A1_D90_UNAME                 := rt.Indicators(name = 'CADCSAP_IPD_A1_D90_UNAME')[1].value;
      self.CADCSAP_IPD_A1_D90_UHP                   := rt.Indicators(name = 'CADCSAP_IPD_A1_D90_UHP')[1].value;
      self.CADCSAP_IPD_A1_D90_UDOB                  := rt.Indicators(name = 'CADCSAP_IPD_A1_D90_UDOB')[1].value;
      self.CADCSAP_IPD_A1_D90_UEMAIL                := rt.Indicators(name = 'CADCSAP_IPD_A1_D90_UEMAIL')[1].value;
      self.CADCSAP_IPD_A1_D90_DAYSMR                := rt.Indicators(name = 'CADCSAP_IPD_A1_D90_DAYSMR')[1].value;
      self.CADCSAP_IPD_A1_D90_DAYSLR                := rt.Indicators(name = 'CADCSAP_IPD_A1_D90_DAYSLR')[1].value;
      self.CADCSAP_IPD_A1_D120_NUM                  := rt.Indicators(name = 'CADCSAP_IPD_A1_D120_NUM')[1].value;
      self.CADCSAP_IPD_A1_D120_UNAME                := rt.Indicators(name = 'CADCSAP_IPD_A1_D120_UNAME')[1].value;
      self.CADCSAP_IPD_A1_D120_UHP                  := rt.Indicators(name = 'CADCSAP_IPD_A1_D120_UHP')[1].value;
      self.CADCSAP_IPD_A1_D120_UDOB                 := rt.Indicators(name = 'CADCSAP_IPD_A1_D120_UDOB')[1].value;
      self.CADCSAP_IPD_A1_D120_UEMAIL               := rt.Indicators(name = 'CADCSAP_IPD_A1_D120_UEMAIL')[1].value;
      self.CADCSAP_IPD_A1_D120_DAYSMR               := rt.Indicators(name = 'CADCSAP_IPD_A1_D120_DAYSMR')[1].value;
      self.CADCSAP_IPD_A1_D120_DAYSLR               := rt.Indicators(name = 'CADCSAP_IPD_A1_D120_DAYSLR')[1].value;
      self.CADCSAP_IPD_A1_D365_NUM                  := rt.Indicators(name = 'CADCSAP_IPD_A1_D365_NUM')[1].value;
      self.CADCSAP_IPD_A1_D365_UNAME                := rt.Indicators(name = 'CADCSAP_IPD_A1_D365_UNAME')[1].value;
      self.CADCSAP_IPD_A1_D365_UHP                  := rt.Indicators(name = 'CADCSAP_IPD_A1_D365_UHP')[1].value;
      self.CADCSAP_IPD_A1_D365_UDOB                 := rt.Indicators(name = 'CADCSAP_IPD_A1_D365_UDOB')[1].value;
      self.CADCSAP_IPD_A1_D365_UEMAIL               := rt.Indicators(name = 'CADCSAP_IPD_A1_D365_UEMAIL')[1].value;
      self.CADCSAP_IPD_A1_D365_DAYSMR               := rt.Indicators(name = 'CADCSAP_IPD_A1_D365_DAYSMR')[1].value;
      self.CADCSAP_IPD_A1_D365_DAYSLR               := rt.Indicators(name = 'CADCSAP_IPD_A1_D365_DAYSLR')[1].value;
      self.CADCSAP_IPD_A1_D1095_NUM                 := rt.Indicators(name = 'CADCSAP_IPD_A1_D1095_NUM')[1].value;
      self.CADCSAP_IPD_A1_D1095_UNAME               := rt.Indicators(name = 'CADCSAP_IPD_A1_D1095_UNAME')[1].value;
      self.CADCSAP_IPD_A1_D1095_UHP                 := rt.Indicators(name = 'CADCSAP_IPD_A1_D1095_UHP')[1].value;
      self.CADCSAP_IPD_A1_D1095_UDOB                := rt.Indicators(name = 'CADCSAP_IPD_A1_D1095_UDOB')[1].value;
      self.CADCSAP_IPD_A1_D1095_UEMAIL              := rt.Indicators(name = 'CADCSAP_IPD_A1_D1095_UEMAIL')[1].value;
      self.CADCSAP_IPD_A1_D1095_DAYSMR              := rt.Indicators(name = 'CADCSAP_IPD_A1_D1095_DAYSMR')[1].value;
      self.CADCSAP_IPD_A1_D1095_DAYSLR              := rt.Indicators(name = 'CADCSAP_IPD_A1_D1095_DAYSLR')[1].value;
      self.CADCSAP_IPD_P1_D90_NUM                   := rt.Indicators(name = 'CADCSAP_IPD_P1_D90_NUM')[1].value;
      self.CADCSAP_IPD_P1_D90_UNAME                 := rt.Indicators(name = 'CADCSAP_IPD_P1_D90_UNAME')[1].value;
      self.CADCSAP_IPD_P1_D90_UADD                  := rt.Indicators(name = 'CADCSAP_IPD_P1_D90_UADD')[1].value;
      self.CADCSAP_IPD_P1_D90_UDOB                  := rt.Indicators(name = 'CADCSAP_IPD_P1_D90_UDOB')[1].value;
      self.CADCSAP_IPD_P1_D90_UEMAIL                := rt.Indicators(name = 'CADCSAP_IPD_P1_D90_UEMAIL')[1].value;
      self.CADCSAP_IPD_P1_D90_DAYSMR                := rt.Indicators(name = 'CADCSAP_IPD_P1_D90_DAYSMR')[1].value;
      self.CADCSAP_IPD_P1_D90_DAYSLR                := rt.Indicators(name = 'CADCSAP_IPD_P1_D90_DAYSLR')[1].value;
      self.CADCSAP_IPD_P1_D120_NUM                  := rt.Indicators(name = 'CADCSAP_IPD_P1_D120_NUM')[1].value;
      self.CADCSAP_IPD_P1_D120_UNAME                := rt.Indicators(name = 'CADCSAP_IPD_P1_D120_UNAME')[1].value;
      self.CADCSAP_IPD_P1_D120_UADD                 := rt.Indicators(name = 'CADCSAP_IPD_P1_D120_UADD')[1].value;
      self.CADCSAP_IPD_P1_D120_UDOB                 := rt.Indicators(name = 'CADCSAP_IPD_P1_D120_UDOB')[1].value;
      self.CADCSAP_IPD_P1_D120_UEMAIL               := rt.Indicators(name = 'CADCSAP_IPD_P1_D120_UEMAIL')[1].value;
      self.CADCSAP_IPD_P1_D120_DAYSMR               := rt.Indicators(name = 'CADCSAP_IPD_P1_D120_DAYSMR')[1].value;
      self.CADCSAP_IPD_P1_D120_DAYSLR               := rt.Indicators(name = 'CADCSAP_IPD_P1_D120_DAYSLR')[1].value;
      self.CADCSAP_IPD_P1_D365_NUM                  := rt.Indicators(name = 'CADCSAP_IPD_P1_D365_NUM')[1].value;
      self.CADCSAP_IPD_P1_D365_UNAME                := rt.Indicators(name = 'CADCSAP_IPD_P1_D365_UNAME')[1].value;
      self.CADCSAP_IPD_P1_D365_UADD                 := rt.Indicators(name = 'CADCSAP_IPD_P1_D365_UADD')[1].value;
      self.CADCSAP_IPD_P1_D365_UDOB                 := rt.Indicators(name = 'CADCSAP_IPD_P1_D365_UDOB')[1].value;
      self.CADCSAP_IPD_P1_D365_UEMAIL               := rt.Indicators(name = 'CADCSAP_IPD_P1_D365_UEMAIL')[1].value;
      self.CADCSAP_IPD_P1_D365_DAYSMR               := rt.Indicators(name = 'CADCSAP_IPD_P1_D365_DAYSMR')[1].value;
      self.CADCSAP_IPD_P1_D365_DAYSLR               := rt.Indicators(name = 'CADCSAP_IPD_P1_D365_DAYSLR')[1].value;
      self.CADCSAP_IPD_P1_D1095_NUM                 := rt.Indicators(name = 'CADCSAP_IPD_P1_D1095_NUM')[1].value;
      self.CADCSAP_IPD_P1_D1095_UNAME               := rt.Indicators(name = 'CADCSAP_IPD_P1_D1095_UNAME')[1].value;
      self.CADCSAP_IPD_P1_D1095_UADD                := rt.Indicators(name = 'CADCSAP_IPD_P1_D1095_UADD')[1].value;
      self.CADCSAP_IPD_P1_D1095_UDOB                := rt.Indicators(name = 'CADCSAP_IPD_P1_D1095_UDOB')[1].value;
      self.CADCSAP_IPD_P1_D1095_UEMAIL              := rt.Indicators(name = 'CADCSAP_IPD_P1_D1095_UEMAIL')[1].value;
      self.CADCSAP_IPD_P1_D1095_DAYSMR              := rt.Indicators(name = 'CADCSAP_IPD_P1_D1095_DAYSMR')[1].value;
      self.CADCSAP_IPD_P1_D1095_DAYSLR              := rt.Indicators(name = 'CADCSAP_IPD_P1_D1095_DAYSLR')[1].value;
      self.CADCSAP_IPD_PX_D90_NUM                   := rt.Indicators(name = 'CADCSAP_IPD_PX_D90_NUM')[1].value;
      self.CADCSAP_IPD_PX_D90_UNAME                 := rt.Indicators(name = 'CADCSAP_IPD_PX_D90_UNAME')[1].value;
      self.CADCSAP_IPD_PX_D90_UADD                  := rt.Indicators(name = 'CADCSAP_IPD_PX_D90_UADD')[1].value;
      self.CADCSAP_IPD_PX_D90_UHP                   := rt.Indicators(name = 'CADCSAP_IPD_PX_D90_UHP')[1].value;
      self.CADCSAP_IPD_PX_D90_UDOB                  := rt.Indicators(name = 'CADCSAP_IPD_PX_D90_UDOB')[1].value;
      self.CADCSAP_IPD_PX_D90_UEMAIL                := rt.Indicators(name = 'CADCSAP_IPD_PX_D90_UEMAIL')[1].value;
      self.CADCSAP_IPD_PX_D90_DAYSMR                := rt.Indicators(name = 'CADCSAP_IPD_PX_D90_DAYSMR')[1].value;
      self.CADCSAP_IPD_PX_D90_DAYSLR                := rt.Indicators(name = 'CADCSAP_IPD_PX_D90_DAYSLR')[1].value;
      self.CADCSAP_IPD_PX_D120_NUM                  := rt.Indicators(name = 'CADCSAP_IPD_PX_D120_NUM')[1].value;
      self.CADCSAP_IPD_PX_D120_UNAME                := rt.Indicators(name = 'CADCSAP_IPD_PX_D120_UNAME')[1].value;
      self.CADCSAP_IPD_PX_D120_UADD                 := rt.Indicators(name = 'CADCSAP_IPD_PX_D120_UADD')[1].value;
      self.CADCSAP_IPD_PX_D120_UHP                  := rt.Indicators(name = 'CADCSAP_IPD_PX_D120_UHP')[1].value;
      self.CADCSAP_IPD_PX_D120_UDOB                 := rt.Indicators(name = 'CADCSAP_IPD_PX_D120_UDOB')[1].value;
      self.CADCSAP_IPD_PX_D120_UEMAIL               := rt.Indicators(name = 'CADCSAP_IPD_PX_D120_UEMAIL')[1].value;
      self.CADCSAP_IPD_PX_D120_DAYSMR               := rt.Indicators(name = 'CADCSAP_IPD_PX_D120_DAYSMR')[1].value;
      self.CADCSAP_IPD_PX_D120_DAYSLR               := rt.Indicators(name = 'CADCSAP_IPD_PX_D120_DAYSLR')[1].value;
      self.CADCSAP_IPD_PX_D365_NUM                  := rt.Indicators(name = 'CADCSAP_IPD_PX_D365_NUM')[1].value;
      self.CADCSAP_IPD_PX_D365_UNAME                := rt.Indicators(name = 'CADCSAP_IPD_PX_D365_UNAME')[1].value;
      self.CADCSAP_IPD_PX_D365_UADD                 := rt.Indicators(name = 'CADCSAP_IPD_PX_D365_UADD')[1].value;
      self.CADCSAP_IPD_PX_D365_UHP                  := rt.Indicators(name = 'CADCSAP_IPD_PX_D365_UHP')[1].value;
      self.CADCSAP_IPD_PX_D365_UDOB                 := rt.Indicators(name = 'CADCSAP_IPD_PX_D365_UDOB')[1].value;
      self.CADCSAP_IPD_PX_D365_UEMAIL               := rt.Indicators(name = 'CADCSAP_IPD_PX_D365_UEMAIL')[1].value;
      self.CADCSAP_IPD_PX_D365_DAYSMR               := rt.Indicators(name = 'CADCSAP_IPD_PX_D365_DAYSMR')[1].value;
      self.CADCSAP_IPD_PX_D365_DAYSLR               := rt.Indicators(name = 'CADCSAP_IPD_PX_D365_DAYSLR')[1].value;
      self.CADCSAP_IPD_PX_D1095_NUM                 := rt.Indicators(name = 'CADCSAP_IPD_PX_D1095_NUM')[1].value;
      self.CADCSAP_IPD_PX_D1095_UNAME               := rt.Indicators(name = 'CADCSAP_IPD_PX_D1095_UNAME')[1].value;
      self.CADCSAP_IPD_PX_D1095_UADD                := rt.Indicators(name = 'CADCSAP_IPD_PX_D1095_UADD')[1].value;
      self.CADCSAP_IPD_PX_D1095_UHP                 := rt.Indicators(name = 'CADCSAP_IPD_PX_D1095_UHP')[1].value;
      self.CADCSAP_IPD_PX_D1095_UDOB                := rt.Indicators(name = 'CADCSAP_IPD_PX_D1095_UDOB')[1].value;
      self.CADCSAP_IPD_PX_D1095_UEMAIL              := rt.Indicators(name = 'CADCSAP_IPD_PX_D1095_UEMAIL')[1].value;
      self.CADCSAP_IPD_PX_D1095_DAYSMR              := rt.Indicators(name = 'CADCSAP_IPD_PX_D1095_DAYSMR')[1].value;
      self.CADCSAP_IPD_PX_D1095_DAYSLR              := rt.Indicators(name = 'CADCSAP_IPD_PX_D1095_DAYSLR')[1].value;
      self.CADCSAP_IX_S1_D90_NUM                    := rt.Indicators(name = 'CADCSAP_IX_S1_D90_NUM')[1].value;
      self.CADCSAP_IX_S1_D90_UNAME                  := rt.Indicators(name = 'CADCSAP_IX_S1_D90_UNAME')[1].value;
      self.CADCSAP_IX_S1_D90_UADD                   := rt.Indicators(name = 'CADCSAP_IX_S1_D90_UADD')[1].value;
      self.CADCSAP_IX_S1_D90_UHP                    := rt.Indicators(name = 'CADCSAP_IX_S1_D90_UHP')[1].value;
      self.CADCSAP_IX_S1_D90_UDOB                   := rt.Indicators(name = 'CADCSAP_IX_S1_D90_UDOB')[1].value;
      self.CADCSAP_IX_S1_D90_UEMAIL                 := rt.Indicators(name = 'CADCSAP_IX_S1_D90_UEMAIL')[1].value;
      self.CADCSAP_IX_S1_D90_DAYSMR                 := rt.Indicators(name = 'CADCSAP_IX_S1_D90_DAYSMR')[1].value;
      self.CADCSAP_IX_S1_D90_DAYSLR                 := rt.Indicators(name = 'CADCSAP_IX_S1_D90_DAYSLR')[1].value;
      self.CADCSAP_IX_S1_D120_NUM                   := rt.Indicators(name = 'CADCSAP_IX_S1_D120_NUM')[1].value;
      self.CADCSAP_IX_S1_D120_UNAME                 := rt.Indicators(name = 'CADCSAP_IX_S1_D120_UNAME')[1].value;
      self.CADCSAP_IX_S1_D120_UADD                  := rt.Indicators(name = 'CADCSAP_IX_S1_D120_UADD')[1].value;
      self.CADCSAP_IX_S1_D120_UHP                   := rt.Indicators(name = 'CADCSAP_IX_S1_D120_UHP')[1].value;
      self.CADCSAP_IX_S1_D120_UDOB                  := rt.Indicators(name = 'CADCSAP_IX_S1_D120_UDOB')[1].value;
      self.CADCSAP_IX_S1_D120_UEMAIL                := rt.Indicators(name = 'CADCSAP_IX_S1_D120_UEMAIL')[1].value;
      self.CADCSAP_IX_S1_D120_DAYSMR                := rt.Indicators(name = 'CADCSAP_IX_S1_D120_DAYSMR')[1].value;
      self.CADCSAP_IX_S1_D120_DAYSLR                := rt.Indicators(name = 'CADCSAP_IX_S1_D120_DAYSLR')[1].value;
      self.CADCSAP_IX_S1_D365_NUM                   := rt.Indicators(name = 'CADCSAP_IX_S1_D365_NUM')[1].value;
      self.CADCSAP_IX_S1_D365_UNAME                 := rt.Indicators(name = 'CADCSAP_IX_S1_D365_UNAME')[1].value;
      self.CADCSAP_IX_S1_D365_UADD                  := rt.Indicators(name = 'CADCSAP_IX_S1_D365_UADD')[1].value;
      self.CADCSAP_IX_S1_D365_UHP                   := rt.Indicators(name = 'CADCSAP_IX_S1_D365_UHP')[1].value;
      self.CADCSAP_IX_S1_D365_UDOB                  := rt.Indicators(name = 'CADCSAP_IX_S1_D365_UDOB')[1].value;
      self.CADCSAP_IX_S1_D365_UEMAIL                := rt.Indicators(name = 'CADCSAP_IX_S1_D365_UEMAIL')[1].value;
      self.CADCSAP_IX_S1_D365_DAYSMR                := rt.Indicators(name = 'CADCSAP_IX_S1_D365_DAYSMR')[1].value;
      self.CADCSAP_IX_S1_D365_DAYSLR                := rt.Indicators(name = 'CADCSAP_IX_S1_D365_DAYSLR')[1].value;
      self.CADCSAP_IX_S1_D1095_NUM                  := rt.Indicators(name = 'CADCSAP_IX_S1_D1095_NUM')[1].value;
      self.CADCSAP_IX_S1_D1095_UNAME                := rt.Indicators(name = 'CADCSAP_IX_S1_D1095_UNAME')[1].value;
      self.CADCSAP_IX_S1_D1095_UADD                 := rt.Indicators(name = 'CADCSAP_IX_S1_D1095_UADD')[1].value;
      self.CADCSAP_IX_S1_D1095_UHP                  := rt.Indicators(name = 'CADCSAP_IX_S1_D1095_UHP')[1].value;
      self.CADCSAP_IX_S1_D1095_UDOB                 := rt.Indicators(name = 'CADCSAP_IX_S1_D1095_UDOB')[1].value;
      self.CADCSAP_IX_S1_D1095_UEMAIL               := rt.Indicators(name = 'CADCSAP_IX_S1_D1095_UEMAIL')[1].value;
      self.CADCSAP_IX_S1_D1095_DAYSMR               := rt.Indicators(name = 'CADCSAP_IX_S1_D1095_DAYSMR')[1].value;
      self.CADCSAP_IX_S1_D1095_DAYSLR               := rt.Indicators(name = 'CADCSAP_IX_S1_D1095_DAYSLR')[1].value;
      self.CADCSAP_IX_A1_D90_NUM                    := rt.Indicators(name = 'CADCSAP_IX_A1_D90_NUM')[1].value;
      self.CADCSAP_IX_A1_D90_UNAME                  := rt.Indicators(name = 'CADCSAP_IX_A1_D90_UNAME')[1].value;
      self.CADCSAP_IX_A1_D90_UHP                    := rt.Indicators(name = 'CADCSAP_IX_A1_D90_UHP')[1].value;
      self.CADCSAP_IX_A1_D90_UDOB                   := rt.Indicators(name = 'CADCSAP_IX_A1_D90_UDOB')[1].value;
      self.CADCSAP_IX_A1_D90_UEMAIL                 := rt.Indicators(name = 'CADCSAP_IX_A1_D90_UEMAIL')[1].value;
      self.CADCSAP_IX_A1_D90_DAYSMR                 := rt.Indicators(name = 'CADCSAP_IX_A1_D90_DAYSMR')[1].value;
      self.CADCSAP_IX_A1_D90_DAYSLR                 := rt.Indicators(name = 'CADCSAP_IX_A1_D90_DAYSLR')[1].value;
      self.CADCSAP_IX_A1_D120_NUM                   := rt.Indicators(name = 'CADCSAP_IX_A1_D120_NUM')[1].value;
      self.CADCSAP_IX_A1_D120_UNAME                 := rt.Indicators(name = 'CADCSAP_IX_A1_D120_UNAME')[1].value;
      self.CADCSAP_IX_A1_D120_UHP                   := rt.Indicators(name = 'CADCSAP_IX_A1_D120_UHP')[1].value;
      self.CADCSAP_IX_A1_D120_UDOB                  := rt.Indicators(name = 'CADCSAP_IX_A1_D120_UDOB')[1].value;
      self.CADCSAP_IX_A1_D120_UEMAIL                := rt.Indicators(name = 'CADCSAP_IX_A1_D120_UEMAIL')[1].value;
      self.CADCSAP_IX_A1_D120_DAYSMR                := rt.Indicators(name = 'CADCSAP_IX_A1_D120_DAYSMR')[1].value;
      self.CADCSAP_IX_A1_D120_DAYSLR                := rt.Indicators(name = 'CADCSAP_IX_A1_D120_DAYSLR')[1].value;
      self.CADCSAP_IX_A1_D365_NUM                   := rt.Indicators(name = 'CADCSAP_IX_A1_D365_NUM')[1].value;
      self.CADCSAP_IX_A1_D365_UNAME                 := rt.Indicators(name = 'CADCSAP_IX_A1_D365_UNAME')[1].value;
      self.CADCSAP_IX_A1_D365_UHP                   := rt.Indicators(name = 'CADCSAP_IX_A1_D365_UHP')[1].value;
      self.CADCSAP_IX_A1_D365_UDOB                  := rt.Indicators(name = 'CADCSAP_IX_A1_D365_UDOB')[1].value;
      self.CADCSAP_IX_A1_D365_UEMAIL                := rt.Indicators(name = 'CADCSAP_IX_A1_D365_UEMAIL')[1].value;
      self.CADCSAP_IX_A1_D365_DAYSMR                := rt.Indicators(name = 'CADCSAP_IX_A1_D365_DAYSMR')[1].value;
      self.CADCSAP_IX_A1_D365_DAYSLR                := rt.Indicators(name = 'CADCSAP_IX_A1_D365_DAYSLR')[1].value;
      self.CADCSAP_IX_A1_D1095_NUM                  := rt.Indicators(name = 'CADCSAP_IX_A1_D1095_NUM')[1].value;
      self.CADCSAP_IX_A1_D1095_UNAME                := rt.Indicators(name = 'CADCSAP_IX_A1_D1095_UNAME')[1].value;
      self.CADCSAP_IX_A1_D1095_UHP                  := rt.Indicators(name = 'CADCSAP_IX_A1_D1095_UHP')[1].value;
      self.CADCSAP_IX_A1_D1095_UDOB                 := rt.Indicators(name = 'CADCSAP_IX_A1_D1095_UDOB')[1].value;
      self.CADCSAP_IX_A1_D1095_UEMAIL               := rt.Indicators(name = 'CADCSAP_IX_A1_D1095_UEMAIL')[1].value;
      self.CADCSAP_IX_A1_D1095_DAYSMR               := rt.Indicators(name = 'CADCSAP_IX_A1_D1095_DAYSMR')[1].value;
      self.CADCSAP_IX_A1_D1095_DAYSLR               := rt.Indicators(name = 'CADCSAP_IX_A1_D1095_DAYSLR')[1].value;
      self.CADCSAP_IX_P1_D90_NUM                    := rt.Indicators(name = 'CADCSAP_IX_P1_D90_NUM')[1].value;
      self.CADCSAP_IX_P1_D90_UNAME                  := rt.Indicators(name = 'CADCSAP_IX_P1_D90_UNAME')[1].value;
      self.CADCSAP_IX_P1_D90_UADD                   := rt.Indicators(name = 'CADCSAP_IX_P1_D90_UADD')[1].value;
      self.CADCSAP_IX_P1_D90_UDOB                   := rt.Indicators(name = 'CADCSAP_IX_P1_D90_UDOB')[1].value;
      self.CADCSAP_IX_P1_D90_UEMAIL                 := rt.Indicators(name = 'CADCSAP_IX_P1_D90_UEMAIL')[1].value;
      self.CADCSAP_IX_P1_D90_DAYSMR                 := rt.Indicators(name = 'CADCSAP_IX_P1_D90_DAYSMR')[1].value;
      self.CADCSAP_IX_P1_D90_DAYSLR                 := rt.Indicators(name = 'CADCSAP_IX_P1_D90_DAYSLR')[1].value;
      self.CADCSAP_IX_P1_D120_NUM                   := rt.Indicators(name = 'CADCSAP_IX_P1_D120_NUM')[1].value;
      self.CADCSAP_IX_P1_D120_UNAME                 := rt.Indicators(name = 'CADCSAP_IX_P1_D120_UNAME')[1].value;
      self.CADCSAP_IX_P1_D120_UADD                  := rt.Indicators(name = 'CADCSAP_IX_P1_D120_UADD')[1].value;
      self.CADCSAP_IX_P1_D120_UDOB                  := rt.Indicators(name = 'CADCSAP_IX_P1_D120_UDOB')[1].value;
      self.CADCSAP_IX_P1_D120_UEMAIL                := rt.Indicators(name = 'CADCSAP_IX_P1_D120_UEMAIL')[1].value;
      self.CADCSAP_IX_P1_D120_DAYSMR                := rt.Indicators(name = 'CADCSAP_IX_P1_D120_DAYSMR')[1].value;
      self.CADCSAP_IX_P1_D120_DAYSLR                := rt.Indicators(name = 'CADCSAP_IX_P1_D120_DAYSLR')[1].value;
      self.CADCSAP_IX_P1_D365_NUM                   := rt.Indicators(name = 'CADCSAP_IX_P1_D365_NUM')[1].value;
      self.CADCSAP_IX_P1_D365_UNAME                 := rt.Indicators(name = 'CADCSAP_IX_P1_D365_UNAME')[1].value;
      self.CADCSAP_IX_P1_D365_UADD                  := rt.Indicators(name = 'CADCSAP_IX_P1_D365_UADD')[1].value;
      self.CADCSAP_IX_P1_D365_UDOB                  := rt.Indicators(name = 'CADCSAP_IX_P1_D365_UDOB')[1].value;
      self.CADCSAP_IX_P1_D365_UEMAIL                := rt.Indicators(name = 'CADCSAP_IX_P1_D365_UEMAIL')[1].value;
      self.CADCSAP_IX_P1_D365_DAYSMR                := rt.Indicators(name = 'CADCSAP_IX_P1_D365_DAYSMR')[1].value;
      self.CADCSAP_IX_P1_D365_DAYSLR                := rt.Indicators(name = 'CADCSAP_IX_P1_D365_DAYSLR')[1].value;
      self.CADCSAP_IX_P1_D1095_NUM                  := rt.Indicators(name = 'CADCSAP_IX_P1_D1095_NUM')[1].value;
      self.CADCSAP_IX_P1_D1095_UNAME                := rt.Indicators(name = 'CADCSAP_IX_P1_D1095_UNAME')[1].value;
      self.CADCSAP_IX_P1_D1095_UADD                 := rt.Indicators(name = 'CADCSAP_IX_P1_D1095_UADD')[1].value;
      self.CADCSAP_IX_P1_D1095_UDOB                 := rt.Indicators(name = 'CADCSAP_IX_P1_D1095_UDOB')[1].value;
      self.CADCSAP_IX_P1_D1095_UEMAIL               := rt.Indicators(name = 'CADCSAP_IX_P1_D1095_UEMAIL')[1].value;
      self.CADCSAP_IX_P1_D1095_DAYSMR               := rt.Indicators(name = 'CADCSAP_IX_P1_D1095_DAYSMR')[1].value;
      self.CADCSAP_IX_P1_D1095_DAYSLR               := rt.Indicators(name = 'CADCSAP_IX_P1_D1095_DAYSLR')[1].value;
      self.CADCSAP_IX_PX_D90_NUM                    := rt.Indicators(name = 'CADCSAP_IX_PX_D90_NUM')[1].value;
      self.CADCSAP_IX_PX_D90_UNAME                  := rt.Indicators(name = 'CADCSAP_IX_PX_D90_UNAME')[1].value;
      self.CADCSAP_IX_PX_D90_UADD                   := rt.Indicators(name = 'CADCSAP_IX_PX_D90_UADD')[1].value;
      self.CADCSAP_IX_PX_D90_UHP                    := rt.Indicators(name = 'CADCSAP_IX_PX_D90_UHP')[1].value;
      self.CADCSAP_IX_PX_D90_UDOB                   := rt.Indicators(name = 'CADCSAP_IX_PX_D90_UDOB')[1].value;
      self.CADCSAP_IX_PX_D90_UEMAIL                 := rt.Indicators(name = 'CADCSAP_IX_PX_D90_UEMAIL')[1].value;
      self.CADCSAP_IX_PX_D90_DAYSMR                 := rt.Indicators(name = 'CADCSAP_IX_PX_D90_DAYSMR')[1].value;
      self.CADCSAP_IX_PX_D90_DAYSLR                 := rt.Indicators(name = 'CADCSAP_IX_PX_D90_DAYSLR')[1].value;
      self.CADCSAP_IX_PX_D120_NUM                   := rt.Indicators(name = 'CADCSAP_IX_PX_D120_NUM')[1].value;
      self.CADCSAP_IX_PX_D120_UNAME                 := rt.Indicators(name = 'CADCSAP_IX_PX_D120_UNAME')[1].value;
      self.CADCSAP_IX_PX_D120_UADD                  := rt.Indicators(name = 'CADCSAP_IX_PX_D120_UADD')[1].value;
      self.CADCSAP_IX_PX_D120_UHP                   := rt.Indicators(name = 'CADCSAP_IX_PX_D120_UHP')[1].value;
      self.CADCSAP_IX_PX_D120_UDOB                  := rt.Indicators(name = 'CADCSAP_IX_PX_D120_UDOB')[1].value;
      self.CADCSAP_IX_PX_D120_UEMAIL                := rt.Indicators(name = 'CADCSAP_IX_PX_D120_UEMAIL')[1].value;
      self.CADCSAP_IX_PX_D120_DAYSMR                := rt.Indicators(name = 'CADCSAP_IX_PX_D120_DAYSMR')[1].value;
      self.CADCSAP_IX_PX_D120_DAYSLR                := rt.Indicators(name = 'CADCSAP_IX_PX_D120_DAYSLR')[1].value;
      self.CADCSAP_IX_PX_D365_NUM                   := rt.Indicators(name = 'CADCSAP_IX_PX_D365_NUM')[1].value;
      self.CADCSAP_IX_PX_D365_UNAME                 := rt.Indicators(name = 'CADCSAP_IX_PX_D365_UNAME')[1].value;
      self.CADCSAP_IX_PX_D365_UADD                  := rt.Indicators(name = 'CADCSAP_IX_PX_D365_UADD')[1].value;
      self.CADCSAP_IX_PX_D365_UHP                   := rt.Indicators(name = 'CADCSAP_IX_PX_D365_UHP')[1].value;
      self.CADCSAP_IX_PX_D365_UDOB                  := rt.Indicators(name = 'CADCSAP_IX_PX_D365_UDOB')[1].value;
      self.CADCSAP_IX_PX_D365_UEMAIL                := rt.Indicators(name = 'CADCSAP_IX_PX_D365_UEMAIL')[1].value;
      self.CADCSAP_IX_PX_D365_DAYSMR                := rt.Indicators(name = 'CADCSAP_IX_PX_D365_DAYSMR')[1].value;
      self.CADCSAP_IX_PX_D365_DAYSLR                := rt.Indicators(name = 'CADCSAP_IX_PX_D365_DAYSLR')[1].value;
      self.CADCSAP_IX_PX_D1095_NUM                  := rt.Indicators(name = 'CADCSAP_IX_PX_D1095_NUM')[1].value;
      self.CADCSAP_IX_PX_D1095_UNAME                := rt.Indicators(name = 'CADCSAP_IX_PX_D1095_UNAME')[1].value;
      self.CADCSAP_IX_PX_D1095_UADD                 := rt.Indicators(name = 'CADCSAP_IX_PX_D1095_UADD')[1].value;
      self.CADCSAP_IX_PX_D1095_UHP                  := rt.Indicators(name = 'CADCSAP_IX_PX_D1095_UHP')[1].value;
      self.CADCSAP_IX_PX_D1095_UDOB                 := rt.Indicators(name = 'CADCSAP_IX_PX_D1095_UDOB')[1].value;
      self.CADCSAP_IX_PX_D1095_UEMAIL               := rt.Indicators(name = 'CADCSAP_IX_PX_D1095_UEMAIL')[1].value;
      self.CADCSAP_IX_PX_D1095_DAYSMR               := rt.Indicators(name = 'CADCSAP_IX_PX_D1095_DAYSMR')[1].value;
      self.CADCSAP_IX_PX_D1095_DAYSLR               := rt.Indicators(name = 'CADCSAP_IX_PX_D1095_DAYSLR')[1].value;
      
      self := [];
    END;

//RVA2008_1 model transform
EXPORT Models.RVA2008_1_0.z_layouts_Input xfm_RVA2008_RVAttrs(riskview.layouts.attributes_internal_layout_noscore le) := TRANSFORM
      Self.TransactionID := (String)le.seq;
      //RV attributes
      self.SUBJECTDECEASED                          := le.subjectdeceased;
      self.CONFIRMATIONSUBJECTFOUND                 := le.confirmationsubjectfound;
      self.CONFIRMATIONINPUTADDRESS                 := le.confirmationinputaddress;
      self.SOURCECREDHEADERTIMEOLDEST               := le.sourcecredheadertimeoldest;
      self.ASSETPROPEVERCOUNT                       := le.assetpropevercount;
      self.DEROGTIMENEWEST                          := le.derogtimenewest;
      self.CRIMINALFELONYCOUNT                      := le.criminalfelonycount;
      self.EVICTIONCOUNT                            := le.evictioncount;
      self.LIENJUDGMENTTAXCOUNT                     := le.lienjudgmenttaxcount;
      self.INQUIRYAUTO12MONTH                       := le.inquiryauto12month;
      self.INQUIRYBANKING12MONTH                    := le.inquirybanking12month;
      self.INQUIRYSHORTTERM12MONTH                  := le.inquiryshortterm12month;
      self.SSNSUBJECTCOUNT                          := le.ssnsubjectcount;
      self.SSNDECEASED                              := le.ssndeceased;
      self.ADDRINPUTMATCHINDEX                      := le.addrinputmatchindex;
      self.ADDRINPUTSUBJECTOWNED                    := le.addrinputsubjectowned;
      self.ADDRPREVIOUSTIMEOLDEST                   := le.addrprevioustimeoldest;
      self.ADDRCHANGECOUNT03MONTH                   := le.addrchangecount03month;
      
      self := [];
    END;
		
//RVT2004_1 model transform
EXPORT Models.RVT2004_1_0.z_layouts_Input xfm_RVT2004_1_RVAttrs(riskview.layouts.attributes_internal_layout_noscore le) := TRANSFORM
			self.TransactionID := (String)le.seq;
			// RV Attributes
	    self.SUBJECTRECORDTIMEOLDEST                  := le.subjectrecordtimeoldest;
      self.SUBJECTDECEASED                          := le.subjectdeceased;
      self.CONFIRMATIONSUBJECTFOUND                 := le.confirmationsubjectfound;
      self.SOURCENONDEROGCOUNT                      := le.sourcenonderogcount;
      self.SOURCENONDEROGCOUNT06MONTH               := le.sourcenonderogcount06month;
      self.SSNDECEASED                              := le.ssndeceased;
      self.ASSETPROPEVERCOUNT                       := le.assetpropevercount;
      self.EVICTIONCOUNT                            := le.evictioncount;
      self.LIENJUDGMENTCOUNT                        := le.lienjudgmentcount;
      self.BANKRUPTCYSTATUS                         := le.bankruptcystatus;
      self.SHORTTERMLOANREQUEST                     := le.shorttermloanrequest;
      self.INQUIRYAUTO12MONTH                       := le.inquiryauto12month;
      self.INQUIRYBANKING12MONTH                    := le.inquirybanking12month;
      self.INQUIRYSHORTTERM12MONTH                  := le.inquiryshortterm12month;
      self.INQUIRYCOLLECTIONS12MONTH                := le.inquirycollections12month;
      self.ADDRONFILECOUNT                          := le.addronfilecount;
      self.ADDRCURRENTOWNERSHIPINDEX                := le.addrcurrentownershipindex;
      self.ADDRPREVIOUSTIMEOLDEST                   := le.addrprevioustimeoldest;
      self.ADDRCHANGECOUNT60MONTH                   := le.addrchangecount60month;
      self.ALERTREGULATORYCONDITION                 := le.alertregulatorycondition;
      
      self := [];
    END;    

// rv5 attribute transform
EXPORT iesp.share.t_NameValuePair intoVersion5(riskview.layouts.layout_riskview5_search_results le, INTEGER c) := TRANSFORM
  SELF.name := MAP(
              c=1	=> 'InputProvidedFirstName',
              c=2	=> 'InputProvidedLastName',
              c=3	=> 'InputProvidedStreetAddress',
              c=4	=> 'InputProvidedCity',
              c=5	=> 'InputProvidedState',
              c=6	=> 'InputProvidedZipCode',
              c=7	=> 'InputProvidedSSN',
              c=8	=> 'InputProvidedDateofBirth',
              c=9	=> 'InputProvidedPhone',
              c=10	=> 'InputProvidedLexID',
              c=11	=> 'SubjectRecordTimeOldest',
              c=12	=> 'SubjectRecordTimeNewest',
              c=13	=> 'SubjectNewestRecord12Month',
              c=14	=> 'SubjectActivityIndex03Month',
              c=15	=> 'SubjectActivityIndex06Month',
              c=16	=> 'SubjectActivityIndex12Month',
              c=17	=> 'SubjectAge',
              c=18	=> 'SubjectDeceased',
              c=19	=> 'SubjectSSNCount',
              c=20	=> 'SubjectStabilityIndex',
              c=21	=> 'SubjectStabilityPrimaryFactor',
              c=22	=> 'SubjectAbilityIndex',
              c=23	=> 'SubjectAbilityPrimaryFactor',
              c=24	=> 'SubjectWillingnessIndex',
              c=25	=> 'SubjectWillingnessPrimaryFactor',
              c=26	=> 'ConfirmationSubjectFound',
              c=27	=> 'ConfirmationInputName',
              c=28	=> 'ConfirmationInputDOB',
              c=29	=> 'ConfirmationInputSSN',
              c=30	=> 'ConfirmationInputAddress',
              c=31	=> 'SourceNonDerogProfileIndex',
              c=32	=> 'SourceNonDerogCount',
              c=33	=> 'SourceNonDerogCount03Month',
              c=34	=> 'SourceNonDerogCount06Month',
              c=35	=> 'SourceNonDerogCount12Month',
              c=36	=> 'SourceCredHeaderTimeOldest',
              c=37	=> 'SourceCredHeaderTimeNewest',
              // c=38	=> 'SourceDirectory',   -- removing from layout for change control request #2
              // c=39	=> 'SourceDirectoryCount',   -- removing from layout for change control request #2
              c=40	=> 'SourceVoterRegistration',
              // c=41	=> 'EstimatedAnnualIncome',   -- removing from layout for change control request #2
              c=42	=> 'EducationAttendance',
              c=43	=> 'EducationEvidence',
              c=44	=> 'EducationProgramAttended',
              c=45	=> 'EducationInstitutionPrivate',
              c=46	=> 'EducationInstitutionRating',
              c=47	=> 'ProfLicCount',
              c=48	=> 'ProfLicTypeCategory',
              c=49	=> 'BusinessAssociation',
              c=50	=> 'BusinessAssociationIndex',
              c=51	=> 'BusinessAssociationTimeOldest',
              c=52	=> 'BusinessTitleLeadership',
              c=53	=> 'AssetIndex',
              c=54	=> 'AssetIndexPrimaryFactor',
              c=55	=> 'AssetOwnership',
              c=56	=> 'AssetProp',
              c=57	=> 'AssetPropIndex',
              c=58	=> 'AssetPropEverCount',
              c=59	=> 'AssetPropCurrentCount',
              c=60	=> 'AssetPropCurrentTaxTotal',
              c=61	=> 'AssetPropPurchaseCount12Month',
              c=62	=> 'AssetPropPurchaseTimeOldest',
              c=63	=> 'AssetPropPurchaseTimeNewest',
              c=64	=> 'AssetPropNewestMortgageType',
              c=65	=> 'AssetPropEverSoldCount',
              c=66	=> 'AssetPropSoldCount12Month',
              c=67	=> 'AssetPropSaleTimeOldest',
              c=68	=> 'AssetPropSaleTimeNewest',
              c=69	=> 'AssetPropNewestSalePrice',
              c=70	=> 'AssetPropSalePurchaseRatio',
              c=71	=> 'AssetPersonal',
              c=72	=> 'AssetPersonalCount',
              c=73	=> 'PurchaseActivityIndex',
              c=74	=> 'PurchaseActivityCount',
              c=75	=> 'PurchaseActivityDollarTotal',
              c=76	=> 'DerogSeverityIndex',
              c=77	=> 'DerogCount',
              c=78	=> 'DerogCount12Month',
              c=79	=> 'DerogTimeNewest',
              c=80	=> 'CriminalFelonyCount',
              c=81	=> 'CriminalFelonyCount12Month',
              c=82	=> 'CriminalFelonyTimeNewest',
              c=83	=> 'CriminalNonFelonyCount',
              c=84	=> 'CriminalNonFelonyCount12Month',
              c=85	=> 'CriminalNonFelonyTimeNewest',
              c=86	=> 'EvictionCount',
              c=87	=> 'EvictionCount12Month',
              c=88	=> 'EvictionTimeNewest',
              c=89	=> 'LienJudgmentSeverityIndex',
              c=90	=> 'LienJudgmentCount',
              c=91	=> 'LienJudgmentCount12Month',
              c=92	=> 'LienJudgmentSmallClaimsCount',
              c=93	=> 'LienJudgmentCourtCount',
              c=94	=> 'LienJudgmentTaxCount',
              c=95	=> 'LienJudgmentForeclosureCount',
              c=96	=> 'LienJudgmentOtherCount',
              c=97	=> 'LienJudgmentTimeNewest',
              c=98	=> 'LienJudgmentDollarTotal',
              c=99	=> 'BankruptcyCount',
              c=100	=> 'BankruptcyCount24Month',
              c=101	=> 'BankruptcyTimeNewest',
              c=102	=> 'BankruptcyChapter',
              c=103	=> 'BankruptcyStatus',
              c=104	=> 'BankruptcyDismissed24Month',
              c=105	=> 'ShortTermLoanRequest',
              c=106	=> 'ShortTermLoanRequest12Month',
              c=107	=> 'ShortTermLoanRequest24Month',
              c=108	=> 'InquiryAuto12Month',
              c=109	=> 'InquiryBanking12Month',
              c=110	=> 'InquiryTelcom12Month',
              c=111	=> 'InquiryNonShortTerm12Month',
              c=112	=> 'InquiryShortTerm12Month',
              c=113	=> 'InquiryCollections12Month',
              c=114	=> 'SSNSubjectCount',
              c=115	=> 'SSNDeceased',
              c=116	=> 'SSNDateLowIssued',
              c=117	=> 'SSNProblems',
              c=118	=> 'AddrOnFileCount',
              c=119	=> 'AddrOnFileCorrectional',
              c=120	=> 'AddrOnFileCollege',
              c=121	=> 'AddrOnFileHighRisk',
              c=122	=> 'AddrInputTimeOldest',
              c=123	=> 'AddrInputTimeNewest',
              c=124	=> 'AddrInputLengthOfRes',
              c=125	=> 'AddrInputSubjectCount',
              c=126	=> 'AddrInputMatchIndex',
              c=127	=> 'AddrInputSubjectOwned',
              c=128	=> 'AddrInputDeedMailing',
              c=129	=> 'AddrInputOwnershipIndex',
              c=130	=> 'AddrInputPhoneService',
              c=131	=> 'AddrInputPhoneCount',
              c=132	=> 'AddrInputDwellType',
              c=133	=> 'AddrInputDwellTypeIndex',
              c=134	=> 'AddrInputDelivery',
              c=135	=> 'AddrInputTimeLastSale',
              c=136	=> 'AddrInputLastSalePrice',
              c=137	=> 'AddrInputTaxValue',
              c=138	=> 'AddrInputTaxYr',
              c=139	=> 'AddrInputTaxMarketValue',
              c=140	=> 'AddrInputAVMValue',
              c=141	=> 'AddrInputAVMValue12Month',
              c=142	=> 'AddrInputAVMRatio12MonthPrior',
              c=143	=> 'AddrInputAVMValue60Month',
              c=144	=> 'AddrInputAVMRatio60MonthPrior',
              c=145	=> 'AddrInputCountyRatio',
              c=146	=> 'AddrInputTractRatio',
              c=147	=> 'AddrInputBlockRatio',
              c=148	=> 'AddrInputProblems',
              c=149	=> 'AddrCurrentTimeOldest',
              c=150	=> 'AddrCurrentTimeNewest',
              c=151	=> 'AddrCurrentLengthOfRes',
              c=152	=> 'AddrCurrentSubjectOwned',
              c=153	=> 'AddrCurrentDeedMailing',
              c=154	=> 'AddrCurrentOwnershipIndex',
              c=155	=> 'AddrCurrentPhoneService',
              c=156	=> 'AddrCurrentDwellType',
              c=157	=> 'AddrCurrentDwellTypeIndex',
              c=158	=> 'AddrCurrentTimeLastSale',
              c=159	=> 'AddrCurrentLastSalesPrice',
              c=160	=> 'AddrCurrentTaxValue',
              c=161	=> 'AddrCurrentTaxYr',
              c=162	=> 'AddrCurrentTaxMarketValue',
              c=163	=> 'AddrCurrentAVMValue',
              c=164	=> 'AddrCurrentAVMValue12Month',
              c=165	=> 'AddrCurrentAVMRatio12MonthPrior',
              c=166	=> 'AddrCurrentAVMValue60Month',
              c=167	=> 'AddrCurrentAVMRatio60MonthPrior',
              c=168	=> 'AddrCurrentCountyRatio',
              c=169	=> 'AddrCurrentTractRatio',
              c=170	=> 'AddrCurrentBlockRatio',
              c=171	=> 'AddrCurrentCorrectional',
              c=172	=> 'AddrPreviousTimeOldest',
              c=173	=> 'AddrPreviousTimeNewest',
              c=174	=> 'AddrPreviousLengthOfRes',
              c=175	=> 'AddrPreviousSubjectOwned',
              c=176	=> 'AddrPreviousOwnershipIndex',
              c=177	=> 'AddrPreviousDwellType',
              c=178	=> 'AddrPreviousDwellTypeIndex',
              c=179	=> 'AddrPreviousCorrectional',
              c=180	=> 'AddrStabilityIndex',
              c=181	=> 'AddrChangeCount03Month',
              c=182	=> 'AddrChangeCount06Month',
              c=183	=> 'AddrChangeCount12Month',
              c=184	=> 'AddrChangeCount24Month',
              c=185	=> 'AddrChangeCount60Month',
              c=186	=> 'AddrLastMoveTaxRatioDiff',
              c=187	=> 'AddrLastMoveEconTrajectory',
              c=188	=> 'AddrLastMoveEconTrajectoryIndex',
              c=189	=> 'PhoneInputProblems',
              c=190	=> 'PhoneInputSubjectCount',
              c=191	=> 'PhoneInputMobile',
              c=192	=> 'AlertRegulatoryCondition',
              c=193	=> 'CheckProfileIndex',
              c=194	=> 'CheckTimeOldest',
              c=195	=> 'CheckTimeNewest',
              c=196	=> 'CheckNegTimeOldest',
              c=197 => 'CheckNegTimeNewest',
              c=198	=> 'CheckNegRiskDecTimeNewest',
              c=199	=> 'CheckNegPaidTimeNewest',
              c=200	=> 'CheckCountTotal',
              c=201	=> 'CheckAmountTotal',
              c=202	=> 'CheckAmountTotalSinceNegPaid',
              c=203	=> 'CheckAmountTotal03Month',
                       ''
              );

  SELF.value := MAP(
              c=1	=>  le.InputProvidedFirstName	,
              c=2	=>  le.InputProvidedLastName	,
              c=3	=>  le.InputProvidedStreetAddress	,
              c=4	=>  le.InputProvidedCity	,
              c=5	=>  le.InputProvidedState	,
              c=6	=>  le.InputProvidedZipCode	,
              c=7	=>  le.InputProvidedSSN	,
              c=8	=>  le.InputProvidedDateofBirth	,
              c=9	=>  le.InputProvidedPhone	,
              c=10	=>  le.InputProvidedLexID	,
              c=11	=>  le.SubjectRecordTimeOldest	,
              c=12	=>  le.SubjectRecordTimeNewest	,
              c=13	=>  le.SubjectNewestRecord12Month	,
              c=14	=>  le.SubjectActivityIndex03Month	,
              c=15	=>  le.SubjectActivityIndex06Month	,
              c=16	=>  le.SubjectActivityIndex12Month	,
              c=17	=>  le.SubjectAge	,
              c=18	=>  le.SubjectDeceased	,
              c=19	=>  le.SubjectSSNCount	,
              c=20	=>  le.SubjectStabilityIndex	,
              c=21	=>  le.SubjectStabilityPrimaryFactor	,
              c=22	=>  le.SubjectAbilityIndex	,
              c=23	=>  le.SubjectAbilityPrimaryFactor	,
              c=24	=>  le.SubjectWillingnessIndex	,
              c=25	=>  le.SubjectWillingnessPrimaryFactor	,
              c=26	=>  le.ConfirmationSubjectFound	,
              c=27	=>  le.ConfirmationInputName	,
              c=28	=>  le.ConfirmationInputDOB	,
              c=29	=>  le.ConfirmationInputSSN	,
              c=30	=>  le.ConfirmationInputAddress	,
              c=31	=>  le.SourceNonDerogProfileIndex	,
              c=32	=>  le.SourceNonDerogCount	,
              c=33	=>  le.SourceNonDerogCount03Month	,
              c=34	=>  le.SourceNonDerogCount06Month	,
              c=35	=>  le.SourceNonDerogCount12Month	,
              c=36	=>  le.SourceCredHeaderTimeOldest	,
              c=37	=>  le.SourceCredHeaderTimeNewest	,
              // c=38	=>  le.SourceDirectory	,
              // c=39	=>  le.SourceDirectoryCount	,
              c=40	=>  le.SourceVoterRegistration	,
              // c=41	=>  le.EstimatedAnnualIncome	,
              c=42	=>  le.EducationAttendance	,
              c=43	=>  le.EducationEvidence	,
              c=44	=>  le.EducationProgramAttended	,
              c=45	=>  le.EducationInstitutionPrivate	,
              c=46	=>  le.EducationInstitutionRating	,
              c=47	=>  le.ProfLicCount	,
              c=48	=>  le.ProfLicTypeCategory	,
              c=49	=>  le.BusinessAssociation	,
              c=50	=>  le.BusinessAssociationIndex	,
              c=51	=>  le.BusinessAssociationTimeOldest	,
              c=52	=>  le.BusinessTitleLeadership	,
              c=53	=>  le.AssetIndex	,
              c=54	=>  le.AssetIndexPrimaryFactor	,
              c=55	=>  le.AssetOwnership	,
              c=56	=>  le.AssetProp	,
              c=57	=>  le.AssetPropIndex	,
              c=58	=>  le.AssetPropEverCount	,
              c=59	=>  le.AssetPropCurrentCount	,
              c=60	=>  le.AssetPropCurrentTaxTotal	,
              c=61	=>  le.AssetPropPurchaseCount12Month	,
              c=62	=>  le.AssetPropPurchaseTimeOldest	,
              c=63	=>  le.AssetPropPurchaseTimeNewest	,
              c=64	=>  le.AssetPropNewestMortgageType	,
              c=65	=>  le.AssetPropEverSoldCount	,
              c=66	=>  le.AssetPropSoldCount12Month	,
              c=67	=>  le.AssetPropSaleTimeOldest	,
              c=68	=>  le.AssetPropSaleTimeNewest	,
              c=69	=>  le.AssetPropNewestSalePrice	,
              c=70	=>  le.AssetPropSalePurchaseRatio	,
              c=71	=>  le.AssetPersonal	,
              c=72	=>  le.AssetPersonalCount	,
              c=73	=>  le.PurchaseActivityIndex	,
              c=74	=>  le.PurchaseActivityCount	,
              c=75	=>  le.PurchaseActivityDollarTotal	,
              c=76	=>  le.DerogSeverityIndex	,
              c=77	=>  le.DerogCount	,
              c=78	=>  le.DerogCount12Month	,
              c=79	=>  le.DerogTimeNewest	,
              c=80	=>  le.CriminalFelonyCount	,
              c=81	=>  le.CriminalFelonyCount12Month	,
              c=82	=>  le.CriminalFelonyTimeNewest	,
              c=83	=>  le.CriminalNonFelonyCount	,
              c=84	=>  le.CriminalNonFelonyCount12Month	,
              c=85	=>  le.CriminalNonFelonyTimeNewest	,
              c=86	=>  le.EvictionCount	,
              c=87	=>  le.EvictionCount12Month	,
              c=88	=>  le.EvictionTimeNewest	,
              c=89	=>  le.LienJudgmentSeverityIndex	,
              c=90	=>  le.LienJudgmentCount	,
              c=91	=>  le.LienJudgmentCount12Month	,
              c=92	=>  le.LienJudgmentSmallClaimsCount	,
              c=93	=>  le.LienJudgmentCourtCount	,
              c=94	=>  le.LienJudgmentTaxCount	,
              c=95	=>  le.LienJudgmentForeclosureCount	,
              c=96	=>  le.LienJudgmentOtherCount	,
              c=97	=>  le.LienJudgmentTimeNewest	,
              c=98	=>  le.LienJudgmentDollarTotal	,
              c=99	=>  le.BankruptcyCount 	,
              c=100	=>  le.BankruptcyCount24Month	,
              c=101	=>  le.BankruptcyTimeNewest	,
              c=102	=>  le.BankruptcyChapter	,
              c=103	=>  le.BankruptcyStatus	,
              c=104	=>  le.BankruptcyDismissed24Month	,
              c=105	=>  le.ShortTermLoanRequest	,
              c=106	=>  le.ShortTermLoanRequest12Month	,
              c=107	=>  le.ShortTermLoanRequest24Month	,
              c=108	=>  le.InquiryAuto12Month	,
              c=109	=>  le.InquiryBanking12Month	,
              c=110	=>  le.InquiryTelcom12Month	,
              c=111	=>  le.InquiryNonShortTerm12Month	,
              c=112	=>  le.InquiryShortTerm12Month	,
              c=113	=>  le.InquiryCollections12Month	,
              c=114	=>  le.SSNSubjectCount	,
              c=115	=>  le.SSNDeceased	,
              c=116	=>  le.SSNDateLowIssued	,
              c=117	=>  le.SSNProblems	,
              c=118	=>  le.AddrOnFileCount	,
              c=119	=>  le.AddrOnFileCorrectional	,
              c=120	=>  le.AddrOnFileCollege	,
              c=121	=>  le.AddrOnFileHighRisk	,
              c=122	=>  le.AddrInputTimeOldest	,
              c=123	=>  le.AddrInputTimeNewest	,
              c=124	=>  le.AddrInputLengthOfRes	,
              c=125	=>  le.AddrInputSubjectCount	,
              c=126	=>  le.AddrInputMatchIndex	,
              c=127	=>  le.AddrInputSubjectOwned	,
              c=128	=>  le.AddrInputDeedMailing	,
              c=129	=>  le.AddrInputOwnershipIndex	,
              c=130	=>  le.AddrInputPhoneService	,
              c=131	=>  le.AddrInputPhoneCount	,
              c=132	=>  le.AddrInputDwellType	,
              c=133	=>  le.AddrInputDwellTypeIndex	,
              c=134	=>  le.AddrInputDelivery	,
              c=135	=>  le.AddrInputTimeLastSale	,
              c=136	=>  le.AddrInputLastSalePrice	,
              c=137	=>  le.AddrInputTaxValue	,
              c=138	=>  le.AddrInputTaxYr	,
              c=139	=>  le.AddrInputTaxMarketValue	,
              c=140	=>  le.AddrInputAVMValue	,
              c=141	=>  le.AddrInputAVMValue12Month	,
              c=142	=>  le.AddrInputAVMRatio12MonthPrior	,
              c=143	=>  le.AddrInputAVMValue60Month	,
              c=144	=>  le.AddrInputAVMRatio60MonthPrior	,
              c=145	=>  le.AddrInputCountyRatio	,
              c=146	=>  le.AddrInputTractRatio	,
              c=147	=>  le.AddrInputBlockRatio	,
              c=148	=>  le.AddrInputProblems	,
              c=149	=>  le.AddrCurrentTimeOldest	,
              c=150	=>  le.AddrCurrentTimeNewest	,
              c=151	=>  le.AddrCurrentLengthOfRes 	,
              c=152	=>  le.AddrCurrentSubjectOwned 	,
              c=153	=>  le.AddrCurrentDeedMailing	,
              c=154	=>  le.AddrCurrentOwnershipIndex	,
              c=155	=>  le.AddrCurrentPhoneService	,
              c=156	=>  le.AddrCurrentDwellType 	,
              c=157	=>  le.AddrCurrentDwellTypeIndex	,
              c=158	=>  le.AddrCurrentTimeLastSale	,
              c=159	=>  le.AddrCurrentLastSalesPrice	,
              c=160	=>  le.AddrCurrentTaxValue	,
              c=161	=>  le.AddrCurrentTaxYr	,
              c=162	=>  le.AddrCurrentTaxMarketValue	,
              c=163	=>  le.AddrCurrentAVMValue	,
              c=164	=>  le.AddrCurrentAVMValue12Month	,
              c=165	=>  le.AddrCurrentAVMRatio12MonthPrior	,
              c=166	=>  le.AddrCurrentAVMValue60Month	,
              c=167	=>  le.AddrCurrentAVMRatio60MonthPrior	,
              c=168	=>  le.AddrCurrentCountyRatio	,
              c=169	=>  le.AddrCurrentTractRatio	,
              c=170	=>  le.AddrCurrentBlockRatio	,
              c=171	=>  le.AddrCurrentCorrectional	,
              c=172	=>  le.AddrPreviousTimeOldest	,
              c=173	=>  le.AddrPreviousTimeNewest	,
              c=174	=>  le.AddrPreviousLengthOfRes 	,
              c=175	=>  le.AddrPreviousSubjectOwned 	,
              c=176	=>  le.AddrPreviousOwnershipIndex	,
              c=177	=>  le.AddrPreviousDwellType 	,
              c=178	=>  le.AddrPreviousDwellTypeIndex	,
              c=179	=>  le.AddrPreviousCorrectional	,
              c=180	=>  le.AddrStabilityIndex	,
              c=181	=>  le.AddrChangeCount03Month	,
              c=182	=>  le.AddrChangeCount06Month	,
              c=183	=>  le.AddrChangeCount12Month	,
              c=184	=>  le.AddrChangeCount24Month	,
              c=185	=>  le.AddrChangeCount60Month	,
              c=186	=>  le.AddrLastMoveTaxRatioDiff	,
              c=187	=>  le.AddrLastMoveEconTrajectory	,
              c=188	=>  le.AddrLastMoveEconTrajectoryIndex	,
              c=189	=>  le.PhoneInputProblems	,
              c=190	=>  le.PhoneInputSubjectCount	,
              c=191	=>  le.PhoneInputMobile 	,
              c=192	=>  le.AlertRegulatoryCondition	,
              c=193	=>  le.CheckProfileIndex,
              c=194	=>  le.CheckTimeOldest,
              c=195	=>  le.CheckTimeNewest,
              c=196	=>  le.CheckNegTimeOldest,
              c=197	=>  le.CheckNegTimeNewest,
              c=198	=>  le.CheckNegRiskDecTimeNewest,
              c=199	=>  le.CheckNegPaidTimeNewest,
              c=200	=>  le.CheckCountTotal,
              c=201	=>  le.CheckAmountTotal,
              c=202	=>  le.CheckAmountTotalSinceNegPaid,
              c=203	=>  le.CheckAmountTotal03Month,
                        ''
              );
END;


EXPORT iesp.riskview2.t_RiskView2ModelHRI intoModel(riskview.layouts.layout_riskview5_search_results le, integer c) := TRANSFORM

    Is_next_gen := MAP(
			c=1	 => le.Auto_Score_Name in RiskView.Constants.next_gen_models,
			c=2	 => le.BankCard_Score_Name in RiskView.Constants.next_gen_models,
			c=3	 => le.Short_term_lending_Score_Name in RiskView.Constants.next_gen_models,
			c=4	 => le.Telecommunications_Score_Name in RiskView.Constants.next_gen_models,
			c=5	 => le.Crossindustry_Score_Name in RiskView.Constants.next_gen_models,
			c=6	 => le.Custom_Score_Name in RiskView.Constants.next_gen_models,
			c=7	 => le.Custom2_Score_Name in RiskView.Constants.next_gen_models,
			c=8	 => le.Custom3_Score_Name in RiskView.Constants.next_gen_models,
			c=9	 => le.Custom4_Score_Name in RiskView.Constants.next_gen_models,
			c=10 => le.Custom5_Score_Name in RiskView.Constants.next_gen_models,
			        FALSE
		);
    
		score_name := MAP(
			c=1	=> le.Auto_Score_Name,
			c=2	=> le.BankCard_Score_Name,
			c=3	=> le.Short_term_lending_Score_Name,
			c=4	=> le.Telecommunications_Score_Name,
			c=5	=> le.Crossindustry_Score_Name,
			c=6	=> le.Custom_Score_Name,
			c=7	=> le.Custom2_Score_Name,
			c=8	=> le.Custom3_Score_Name,
			c=9	=> le.Custom4_Score_Name,
			c=10	=> le.Custom5_Score_Name,
			''
		);
		
		score_type := MAP(
			c=1 => le.Auto_Type,
			c=2 => le.BankCard_Type,
			c=3 => le.Short_term_lending_Type,
			c=4 => le.Telecommunications_Type,
			c=5 => le.Crossindustry_Type,
			c=6 => le.Custom_Type,
			c=7 => le.Custom2_Type,
			c=8 => le.Custom3_Type,
			c=9 => le.Custom4_Type,
			c=10 => le.Custom5_Type,			
			''
		);

		score_value := MAP(
			c=1	=> le.auto_score,
			c=2	=> le.Bankcard_score,
			c=3	=> le.Short_term_lending_score,
			c=4	=> le.Telecommunications_score,
			c=5	=> le.Crossindustry_score,
			c=6	=> le.Custom_score,
			c=7 => le.Custom2_score,
			c=8 => le.Custom3_score,
			c=9 => le.Custom4_score,
			c=10 => le.Custom5_score,
			''
		);
		
		reason1 := MAP(
			c=1	=> le.auto_reason1,
			c=2	=> le.Bankcard_reason1,
			c=3	=> le.Short_term_lending_reason1,
			c=4	=> le.Telecommunications_reason1,
			c=5	=> le.Crossindustry_reason1,
			c=6	=> le.Custom_reason1,
			c=7	=> le.Custom2_reason1,
			c=8	=> le.Custom3_reason1,
			c=9	=> le.Custom4_reason1,
			c=10	=> le.Custom5_reason1,
			''
		);
		
		reason2 := MAP(
			c=1	=> le.auto_reason2,
			c=2	=> le.Bankcard_reason2,
			c=3	=> le.Short_term_lending_reason2,
			c=4	=> le.Telecommunications_reason2,
			c=5	=> le.Crossindustry_reason2,
			c=6	=> le.Custom_reason2,
			c=7	=> le.Custom2_reason2,
			c=8	=> le.Custom3_reason2,
			c=9	=> le.Custom4_reason2,
			c=10	=> le.Custom5_reason2,
			''
		);
		
		reason3 := MAP(
			c=1	=> le.auto_reason3,
			c=2	=> le.Bankcard_reason3,
			c=3	=> le.Short_term_lending_reason3,
			c=4	=> le.Telecommunications_reason3,
			c=5	=> le.Crossindustry_reason3,
			c=6	=> le.Custom_reason3,
			c=7	=> le.Custom2_reason3,
			c=8	=> le.Custom3_reason3,
			c=9	=> le.Custom4_reason3,
			c=10	=> le.Custom5_reason3,
			''
		);
		
		reason4 := MAP(
			c=1	=> le.auto_reason4,
			c=2	=> le.Bankcard_reason4,
			c=3	=> le.Short_term_lending_reason4,
			c=4	=> le.Telecommunications_reason4,
			c=5	=> le.Crossindustry_reason4,
			c=6	=> le.Custom_reason4,
			c=7	=> le.Custom2_reason4,
			c=8	=> le.Custom3_reason4,
			c=9	=> le.Custom4_reason4,
			c=10	=> le.Custom5_reason4,
			''
		);
		
		reason5 := MAP(
			c=1	=> le.auto_reason5,
			c=2	=> le.Bankcard_reason5,
			c=3	=> le.Short_term_lending_reason5,
			c=4	=> le.Telecommunications_reason5,
			c=5	=> le.Crossindustry_reason5,
			c=6	=> le.Custom_reason5,
			c=7	=> le.Custom2_reason5,
			c=8	=> le.Custom3_reason5,
			c=9	=> le.Custom4_reason5,
			c=10	=> le.Custom5_reason5,
			''
		);
		
		ds_reasons := DATASET([
			{1, reason1, Risk_Indicators.getHRIDesc(reason1, Is_next_gen)},
			{2, reason2, Risk_Indicators.getHRIDesc(reason2, Is_next_gen)},
			{3, reason3, Risk_Indicators.getHRIDesc(reason3, Is_next_gen)},
			{4, reason4, Risk_Indicators.getHRIDesc(reason4, Is_next_gen)},
			{5, reason5, Risk_Indicators.getHRIDesc(reason5, Is_next_gen)}
			], iesp.riskview2.t_RiskView2RiskIndicator)(ReasonCode NOT IN ['','00']); // Only keep the valid reason codes
		
		self.name := score_name;
    
    //non-standard custom models, scores must be cast as INTEGER vs UNSIGNED
    NonStandardModels := ['ShortTermLendingRVR1903_1'];
		
		SELF.Scores := DATASET([transform(iesp.riskview2.t_RiskView2ScoreHRI,
			// self.value := (unsigned)score_value;
			self.value := if(score_name IN NonStandardModels, (integer)score_value, (unsigned)score_value);
			self._type := score_type;
			self.ScoreReasons := ds_reasons;
			)]);
	END;


EXPORT iesp.riskview2.t_RiskView2Alert norm_alerts(riskview.layouts.layout_riskview5_search_results le, INTEGER c) := TRANSFORM
		
		SELF.code := MAP(
			c=1	=> le.alert1,
			c=2	=> le.alert2,
			c=3	=> le.alert3,
			c=4	=> le.alert4,
			c=5	=> le.alert5,
			c=6	=> le.alert6,
			c=7	=> le.alert7,
			c=8	=> le.alert8,
			c=9	=> le.alert9,
			c=10	=> le.alert10,
			''
		);

		SELF.description := MAP(
			c=1	=>  if(le.alert1<>'', risk_indicators.getHRIDesc(le.alert1), ''),
			c=2	=>  if(le.alert2<>'', risk_indicators.getHRIDesc(le.alert2), ''),
			c=3	=>  if(le.alert3<>'', risk_indicators.getHRIDesc(le.alert3), ''),
			c=4	=>  if(le.alert4<>'', risk_indicators.getHRIDesc(le.alert4), ''),
			c=5	=>  if(le.alert5<>'', risk_indicators.getHRIDesc(le.alert5), ''),
			c=6	=>  if(le.alert6<>'', risk_indicators.getHRIDesc(le.alert6), ''),
			c=7	=>  if(le.alert7<>'', risk_indicators.getHRIDesc(le.alert7), ''),
			c=8	=>  if(le.alert8<>'', risk_indicators.getHRIDesc(le.alert8), ''),
			c=9	=>  if(le.alert9<>'', risk_indicators.getHRIDesc(le.alert9), ''),
			c=10	=>  if(le.alert10<>'', risk_indicators.getHRIDesc(le.alert10), ''),
			''
		);
	END;
  
EXPORT iesp.share.t_NameValuePair norm_LnJ(riskview.layouts.layout_riskview5_search_results le, INTEGER c) := TRANSFORM
		
		SELF.name := MAP(
		 c=1 => 'LnJEvictionTotalCount'        ,
		 c=2 => 'LnJEvictionTotalCount12Month',
		 c=3 => 'LnJEvictionTimeNewest'        ,
		 c=4 => 'LnJJudgmentSmallClaimsCount'  ,
		 c=5 => 'LnJJudgmentCourtCount'        ,
		 c=6 => 'LnJJudgmentForeclosureCount'  ,
		 c=7 => 'LnJLienJudgmentSeverityIndex' ,
		 c=8 => 'LnJLienJudgmentCount'         ,
		 c=9 => 'LnJLienJudgmentCount12Month'  ,
		 c=10=> 'LnJLienTaxCount'              ,
		 c=11 => 'LnJLienJudgmentOtherCount'    ,
		 c=12 => 'LnjLienJudgmentTimeNewest'    ,
		 c=13 => 'LnJLienJudgmentDollarTotal'   ,
		 c=14 => 'LnJLienCount'                 ,
		 c=15 => 'LnJLienTimeNewest'           ,
		 c=16 => 'LnJLienDollarTotal'           ,
		 c=17 => 'LnJLienTaxTimeNewest'         ,
		 c=18 => 'LnJLienTaxDollarTotal'        ,
		 c=19 => 'LnJLienTaxStateCount'         ,
		 c=20 => 'LnJLienTaxStateTimeNewest'    ,
		 c=21 => 'LnJLienTaxStateDollarTotal'   ,
		 c=22 => 'LnJLienTaxFederalCount'       ,
		 c=23 => 'LnJLienTaxFederalTimeNewest'  ,
		 c=24 => 'LnJLienTaxFederalDollarTotal' ,
		 c=25 => 'LnJJudgmentCount'             ,
		 c=26 => 'LnJJudgmentTimeNewest'        ,
		 c=27 => 'LnJJudgmentDollarTotal' ,
		 ''	);

		SELF.value := MAP(
			c=1 => le.LnJEvictionTotalCount        ,
			c=2 => le.LnJEvictionTotalCount12Month,
			c=3 => le.LnJEvictionTimeNewest        ,
			c=4 => le.LnJJudgmentSmallClaimsCount  ,
			c=5 => le.LnJJudgmentCourtCount        ,
			c=6 => le.LnJJudgmentForeclosureCount  ,																
			c=7 => le.LnJLienJudgmentSeverityIndex ,
			c=8 => le.LnJLienJudgmentCount         ,
			c=9 => le.LnJLienJudgmentCount12Month  ,
			c=10 => le.LnJLienTaxCount              ,
			c=11 => le.LnJLienJudgmentOtherCount    ,
			c=12 => le.LnjLienJudgmentTimeNewest    ,
			c=13 => le.LnJLienJudgmentDollarTotal   ,

			c=14 => le.LnJLienCount                 ,
			c=15 => le.LnJLienTimeNewest           ,
			c=16 => le.LnJLienDollarTotal           ,
			c=17 => le.LnJLienTaxTimeNewest         ,
			c=18 => le.LnJLienTaxDollarTotal       ,
			c=19 => le.LnJLienTaxStateCount         ,
			c=20 => le.LnJLienTaxStateTimeNewest    ,
			c=21 => le.LnJLienTaxStateDollarTotal   ,
			c=22 => le.LnJLienTaxFederalCount      ,
			c=23 => le.LnJLienTaxFederalTimeNewest  ,
			c=24 => le.LnJLienTaxFederalDollarTotal ,
			c=25 => le.LnJJudgmentCount             ,
			c=26 => le.LnJJudgmentTimeNewest        ,
			c=27 => le.LnJJudgmentDollarTotal,
			''
		);
	END;

EXPORT iesp.share.t_NameValuePair intoFISattrs(riskview.layouts.layout_riskview5_search_results le, INTEGER c) := TRANSFORM
		
  SELF.name := MAP(
    c=1 => 'RV3SSNDeceased',
    c=2 => 'RV3ConfirmationSubjectFound',
    c=3 => 'RV3SourceNonDerogCount',
    c=4 => 'RV3AddrChangeCount12Month',
    c=5 => 'RV3AddrChangeCount60Month',
    c=6 => 'RV3AddrInputTimeOldest',
    c=7 => 'RV3AssetPropCurrentCount',
    c=8 => 'RV3AssetIndex',
		       '' );

  SELF.value := MAP(
    c=1 => le.rv3SSNDeceased,
    c=2 => le.rv3ConfirmationSubjectFound,
    c=3 => le.rv3SourceNonDerogCount,
    c=4 => le.rv3AddrChangeCount12Month,
    c=5 => le.rv3AddrChangeCount60Month,
    c=6 => le.rv3AddrInputTimeOldest,
    c=7 => le.rv3AssetPropCurrentCount,																
    c=8 => le.rv3AssetIndex,
           '' );
	END;

END;