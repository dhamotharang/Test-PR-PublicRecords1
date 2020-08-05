﻿IMPORT risk_indicators, RiskView, iesp;

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

EXPORT RiskView.Layouts.layout_riskview5_batch_response FormatBatch(RiskView.Layouts.layout_riskview_input le, 
		riskview.layouts.layout_riskview5_search_results ri //, 
		//integer l, integer j
		) := transform
		self.acctno := le.acctno;
    
 // don't log the lexid if the person got a noscore
    self.inquiry_lexid := if(riskview.constants.noScoreAlert in [ri.Alert1,ri.Alert2,ri.Alert3,ri.Alert4,ri.Alert5,ri.Alert6,ri.Alert7,ri.Alert8,ri.Alert9,ri.Alert10], '', ri.LexID);
    
		self.Liens1_Seq          := ri.LnJliens[1].Seq;
		self.Liens1_DateFiled    := ri.LnJliens[1].DateFiled;
  self.Liens1_LienTypeID   := ri.LnJliens[1].LienTypeID;
		self.Liens1_LienType     := ri.LnJliens[1].LienType;
		self.Liens1_Amount       := ri.LnJliens[1].Amount;
		self.Liens1_ReleaseDate  := ri.LnJliens[1].ReleaseDate;
		self.Liens1_DateLastSeen := ri.LnJliens[1].DateLastSeen;
		self.Liens1_FilingNumber := ri.LnJliens[1].FilingNumber;
		self.Liens1_FilingBook   := ri.LnJliens[1].FilingBook;
		self.Liens1_FilingPage   := ri.LnJliens[1].FilingPage;
		self.Liens1_Agency       := ri.LnJliens[1].Agency;
		self.Liens1_AgencyCounty := ri.LnJliens[1].AgencyCounty;
		self.Liens1_AgencyState	:= ri.LnJliens[1].AgencyState;
		self.Liens1_ConsumerStatementId	:= SetCSID(ri.LnJliens[1].ConsumerStatementId);
    self.Liens1_orig_rmsid       := ri.LnJliens[1].orig_rmsid;
		self.Liens2_Seq          := ri.LnJliens[2].Seq;
		self.Liens2_DateFiled    := ri.LnJliens[2].DateFiled;
  self.Liens2_LienTypeID   := ri.LnJliens[2].LienTypeID;
		self.Liens2_LienType     := ri.LnJliens[2].LienType;
		self.Liens2_Amount       := ri.LnJliens[2].Amount;
		self.Liens2_ReleaseDate  := ri.LnJliens[2].ReleaseDate;
		self.Liens2_DateLastSeen := ri.LnJliens[2].DateLastSeen;
		self.Liens2_FilingNumber := ri.LnJliens[2].FilingNumber;
		self.Liens2_FilingBook   := ri.LnJliens[2].FilingBook;
		self.Liens2_FilingPage   := ri.LnJliens[2].FilingPage;
		self.Liens2_Agency       := ri.LnJliens[2].Agency; 
		self.Liens2_AgencyCounty := ri.LnJliens[2].AgencyCounty;
		self.Liens2_AgencyState	:= ri.LnJliens[2].AgencyState;
		self.Liens2_ConsumerStatementId	:= SetCSID(ri.LnJliens[2].ConsumerStatementId);
    self.Liens2_orig_rmsid       := ri.LnJliens[2].orig_rmsid;
		self.Liens3_Seq          := ri.LnJliens[3].Seq;
		self.Liens3_DateFiled    := ri.LnJliens[3].DateFiled;
  self.Liens3_LienTypeID   := ri.LnJliens[3].LienTypeID;
		self.Liens3_LienType     := ri.LnJliens[3].LienType;
		self.Liens3_Amount       := ri.LnJliens[3].Amount;
		self.Liens3_ReleaseDate  := ri.LnJliens[3].ReleaseDate;
		self.Liens3_DateLastSeen := ri.LnJliens[3].DateLastSeen;
		self.Liens3_FilingNumber := ri.LnJliens[3].FilingNumber;
		self.Liens3_FilingBook   := ri.LnJliens[3].FilingBook;
		self.Liens3_FilingPage   := ri.LnJliens[3].FilingPage; 
		self.Liens3_Agency       := ri.LnJliens[3].Agency; 
		self.Liens3_AgencyCounty := ri.LnJliens[3].AgencyCounty;
		self.Liens3_AgencyState	:= ri.LnJliens[3].AgencyState;
		self.Liens3_ConsumerStatementId	:= SetCSID(ri.LnJliens[3].ConsumerStatementId);
    self.Liens3_orig_rmsid       := ri.LnJliens[3].orig_rmsid;
		self.Liens4_Seq          := ri.LnJliens[4].Seq;
		self.Liens4_DateFiled    := ri.LnJliens[4].DateFiled;
  self.Liens4_LienTypeID   := ri.LnJliens[4].LienTypeID;
		self.Liens4_LienType     := ri.LnJliens[4].LienType;
		self.Liens4_Amount       := ri.LnJliens[4].Amount;
		self.Liens4_ReleaseDate  := ri.LnJliens[4].ReleaseDate;
		self.Liens4_DateLastSeen := ri.LnJliens[4].DateLastSeen;
		self.Liens4_FilingNumber := ri.LnJliens[4].FilingNumber;
		self.Liens4_FilingBook   := ri.LnJliens[4].FilingBook;
		self.Liens4_FilingPage   := ri.LnJliens[4].FilingPage;
		self.Liens4_Agency       := ri.LnJliens[4].Agency; 
		self.Liens4_AgencyCounty := ri.LnJliens[4].AgencyCounty;
		self.Liens4_AgencyState	:= ri.LnJliens[4].AgencyState;
		self.Liens4_ConsumerStatementId	:= SetCSID(ri.LnJliens[4].ConsumerStatementId);
		self.Liens4_orig_rmsid       := ri.LnJliens[4].orig_rmsid;
		self.Liens5_Seq          := ri.LnJliens[5].Seq              ;
		self.Liens5_DateFiled    := ri.LnJliens[5].DateFiled        ;
  self.Liens5_LienTypeID   := ri.LnJliens[5].LienTypeID;
		self.Liens5_LienType     := ri.LnJliens[5].LienType         ;
		self.Liens5_Amount       := ri.LnJliens[5].Amount           ;
		self.Liens5_ReleaseDate  := ri.LnJliens[5].ReleaseDate      ;
		self.Liens5_DateLastSeen := ri.LnJliens[5].DateLastSeen     ;
		self.Liens5_FilingNumber := ri.LnJliens[5].FilingNumber     ;
		self.Liens5_FilingBook   := ri.LnJliens[5].FilingBook       ;
		self.Liens5_FilingPage   := ri.LnJliens[5].FilingPage       ;
		self.Liens5_Agency       := ri.LnJliens[5].Agency           ;
		self.Liens5_AgencyCounty := ri.LnJliens[5].AgencyCounty     ;
		self.Liens5_AgencyState  := ri.LnJliens[5].AgencyState      ;
		self.Liens5_ConsumerStatementId	:= SetCSID(ri.LnJliens[5].ConsumerStatementId);
    self.Liens5_orig_rmsid       := ri.LnJliens[5].orig_rmsid;
		self.Liens6_Seq          := ri.LnJliens[6].Seq              ;
		self.Liens6_DateFiled    := ri.LnJliens[6].DateFiled        ;
  self.Liens6_LienTypeID   := ri.LnJliens[6].LienTypeID;
		self.Liens6_LienType     := ri.LnJliens[6].LienType         ;
		self.Liens6_Amount       := ri.LnJliens[6].Amount           ;
		self.Liens6_ReleaseDate  := ri.LnJliens[6].ReleaseDate      ;
		self.Liens6_DateLastSeen := ri.LnJliens[6].DateLastSeen     ;
		self.Liens6_FilingNumber := ri.LnJliens[6].FilingNumber     ;
		self.Liens6_FilingBook   := ri.LnJliens[6].FilingBook       ;
		self.Liens6_FilingPage   := ri.LnJliens[6].FilingPage       ;
		self.Liens6_Agency       := ri.LnJliens[6].Agency           ;
		self.Liens6_AgencyCounty := ri.LnJliens[6].AgencyCounty     ;
		self.Liens6_AgencyState  := ri.LnJliens[6].AgencyState      ;
		self.Liens6_ConsumerStatementId	:= SetCSID(ri.LnJliens[6].ConsumerStatementId);
    self.Liens6_orig_rmsid       := ri.LnJliens[6].orig_rmsid;
		self.Liens7_Seq          := ri.LnJliens[7].Seq              ;
		self.Liens7_DateFiled    := ri.LnJliens[7].DateFiled        ;
  self.Liens7_LienTypeID   := ri.LnJliens[7].LienTypeID;
		self.Liens7_LienType     := ri.LnJliens[7].LienType         ;
		self.Liens7_Amount       := ri.LnJliens[7].Amount           ;
		self.Liens7_ReleaseDate  := ri.LnJliens[7].ReleaseDate      ;
		self.Liens7_DateLastSeen := ri.LnJliens[7].DateLastSeen     ;
		self.Liens7_FilingNumber := ri.LnJliens[7].FilingNumber     ;
		self.Liens7_FilingBook   := ri.LnJliens[7].FilingBook       ;
		self.Liens7_FilingPage   := ri.LnJliens[7].FilingPage       ;
		self.Liens7_Agency       := ri.LnJliens[7].Agency           ;
		self.Liens7_AgencyCounty := ri.LnJliens[7].AgencyCounty     ;
		self.Liens7_AgencyState  := ri.LnJliens[7].AgencyState      ;
		self.Liens7_ConsumerStatementId	:= SetCSID(ri.LnJliens[7].ConsumerStatementId);
    self.Liens7_orig_rmsid       := ri.LnJliens[7].orig_rmsid;
		self.Liens8_Seq          := ri.LnJliens[8].Seq              ;
		self.Liens8_DateFiled    := ri.LnJliens[8].DateFiled        ;
  self.Liens8_LienTypeID   := ri.LnJliens[8].LienTypeID;
		self.Liens8_LienType     := ri.LnJliens[8].LienType         ;
		self.Liens8_Amount       := ri.LnJliens[8].Amount           ;
		self.Liens8_ReleaseDate  := ri.LnJliens[8].ReleaseDate      ;
		self.Liens8_DateLastSeen := ri.LnJliens[8].DateLastSeen     ;
		self.Liens8_FilingNumber := ri.LnJliens[8].FilingNumber     ;
		self.Liens8_FilingBook   := ri.LnJliens[8].FilingBook       ;
		self.Liens8_FilingPage   := ri.LnJliens[8].FilingPage       ;
		self.Liens8_Agency       := ri.LnJliens[8].Agency           ;
		self.Liens8_AgencyCounty := ri.LnJliens[8].AgencyCounty     ;
		self.Liens8_AgencyState  := ri.LnJliens[8].AgencyState      ;
		self.Liens8_ConsumerStatementId	:= SetCSID(ri.LnJliens[8].ConsumerStatementId);
    self.Liens8_orig_rmsid       := ri.LnJliens[8].orig_rmsid;
		self.Liens9_Seq          := ri.LnJliens[9].Seq              ;
		self.Liens9_DateFiled    := ri.LnJliens[9].DateFiled        ;
  self.Liens9_LienTypeID   := ri.LnJliens[9].LienTypeID;
		self.Liens9_LienType     := ri.LnJliens[9].LienType         ;
		self.Liens9_Amount       := ri.LnJliens[9].Amount           ;
		self.Liens9_ReleaseDate  := ri.LnJliens[9].ReleaseDate      ;
		self.Liens9_DateLastSeen := ri.LnJliens[9].DateLastSeen     ;
		self.Liens9_FilingNumber := ri.LnJliens[9].FilingNumber     ;
		self.Liens9_FilingBook   := ri.LnJliens[9].FilingBook       ;
		self.Liens9_FilingPage   := ri.LnJliens[9].FilingPage       ;
		self.Liens9_Agency       := ri.LnJliens[9].Agency           ;
		self.Liens9_AgencyCounty := ri.LnJliens[9].AgencyCounty     ;
		self.Liens9_AgencyState  := ri.LnJliens[9].AgencyState      ;
		self.Liens9_ConsumerStatementId	:= SetCSID(ri.LnJliens[9].ConsumerStatementId);
    self.Liens9_orig_rmsid       := ri.LnJliens[9].orig_rmsid;
		self.Liens10_Seq          := ri.LnJliens[10].Seq             ;
		self.Liens10_DateFiled    := ri.LnJliens[10].DateFiled       ;
  self.Liens10_LienTypeID   := ri.LnJliens[10].LienTypeID;
		self.Liens10_LienType     := ri.LnJliens[10].LienType        ;
		self.Liens10_Amount       := ri.LnJliens[10].Amount          ;
		self.Liens10_ReleaseDate  := ri.LnJliens[10].ReleaseDate     ;
		self.Liens10_DateLastSeen := ri.LnJliens[10].DateLastSeen    ;
		self.Liens10_FilingNumber := ri.LnJliens[10].FilingNumber    ;
		self.Liens10_FilingBook   := ri.LnJliens[10].FilingBook      ;
		self.Liens10_FilingPage   := ri.LnJliens[10].FilingPage      ;
		self.Liens10_Agency       := ri.LnJliens[10].Agency          ;
		self.Liens10_AgencyCounty := ri.LnJliens[10].AgencyCounty    ;
		self.Liens10_AgencyState  := ri.LnJliens[10].AgencyState     ;
		self.Liens10_ConsumerStatementId	:= SetCSID(ri.LnJliens[10].ConsumerStatementId);
    self.Liens10_orig_rmsid       := ri.LnJliens[10].orig_rmsid;
		self.Liens11_Seq          := ri.LnJliens[11].Seq;
		self.Liens11_DateFiled    := ri.LnJliens[11].DateFiled;
  self.Liens11_LienTypeID   := ri.LnJliens[11].LienTypeID;
		self.Liens11_LienType     := ri.LnJliens[11].LienType;
		self.Liens11_Amount       := ri.LnJliens[11].Amount;
		self.Liens11_ReleaseDate  := ri.LnJliens[11].ReleaseDate;
		self.Liens11_DateLastSeen := ri.LnJliens[11].DateLastSeen;
		self.Liens11_FilingNumber := ri.LnJliens[11].FilingNumber;
		self.Liens11_FilingBook   := ri.LnJliens[11].FilingBook;
		self.Liens11_FilingPage   := ri.LnJliens[11].FilingPage;
		self.Liens11_Agency       := ri.LnJliens[11].Agency ;
		self.Liens11_AgencyCounty := ri.LnJliens[11].AgencyCounty;
		self.Liens11_AgencyState	:= ri.LnJliens[11].AgencyState;
		self.Liens11_ConsumerStatementId	:= SetCSID(ri.LnJliens[11].ConsumerStatementId);
    self.Liens11_orig_rmsid       := ri.LnJliens[11].orig_rmsid;
		self.Liens12_Seq          := ri.LnJliens[12].Seq;
		self.Liens12_DateFiled    := ri.LnJliens[12].DateFiled;
  self.Liens12_LienTypeID   := ri.LnJliens[12].LienTypeID;
		self.Liens12_LienType     := ri.LnJliens[12].LienType;
		self.Liens12_Amount       := ri.LnJliens[12].Amount;
		self.Liens12_ReleaseDate  := ri.LnJliens[12].ReleaseDate;
		self.Liens12_DateLastSeen := ri.LnJliens[12].DateLastSeen;
		self.Liens12_FilingNumber := ri.LnJliens[12].FilingNumber;
		self.Liens12_FilingBook   := ri.LnJliens[12].FilingBook;
		self.Liens12_FilingPage   := ri.LnJliens[12].FilingPage;
		self.Liens12_Agency       := ri.LnJliens[12].Agency; 
		self.Liens12_AgencyCounty := ri.LnJliens[12].AgencyCounty;
		self.Liens12_AgencyState	:= ri.LnJliens[12].AgencyState;
		self.Liens12_ConsumerStatementId	:= SetCSID(ri.LnJliens[12].ConsumerStatementId);
    self.Liens12_orig_rmsid       := ri.LnJliens[12].orig_rmsid;
		self.Liens13_Seq          := ri.LnJliens[13].Seq;
		self.Liens13_DateFiled    := ri.LnJliens[13].DateFiled;
  self.Liens13_LienTypeID   := ri.LnJliens[13].LienTypeID;
		self.Liens13_LienType     := ri.LnJliens[13].LienType;
		self.Liens13_Amount       := ri.LnJliens[13].Amount;
		self.Liens13_ReleaseDate  := ri.LnJliens[13].ReleaseDate;
		self.Liens13_DateLastSeen := ri.LnJliens[13].DateLastSeen;
		self.Liens13_FilingNumber := ri.LnJliens[13].FilingNumber;
		self.Liens13_FilingBook   := ri.LnJliens[13].FilingBook;
		self.Liens13_FilingPage   := ri.LnJliens[13].FilingPage;
		self.Liens13_Agency       := ri.LnJliens[13].Agency; 
		self.Liens13_AgencyCounty := ri.LnJliens[13].AgencyCounty;
		self.Liens13_AgencyState	:= ri.LnJliens[13].AgencyState;
		self.Liens13_ConsumerStatementId	:= SetCSID(ri.LnJliens[13].ConsumerStatementId);
    self.Liens13_orig_rmsid       := ri.LnJliens[13].orig_rmsid;
		self.Liens14_Seq          := ri.LnJliens[14].Seq;
		self.Liens14_DateFiled    := ri.LnJliens[14].DateFiled;
  self.Liens14_LienTypeID   := ri.LnJliens[14].LienTypeID;
		self.Liens14_LienType     := ri.LnJliens[14].LienType;
		self.Liens14_Amount       := ri.LnJliens[14].Amount;
		self.Liens14_ReleaseDate  := ri.LnJliens[14].ReleaseDate;
		self.Liens14_DateLastSeen := ri.LnJliens[14].DateLastSeen;
		self.Liens14_FilingNumber := ri.LnJliens[14].FilingNumber;
		self.Liens14_FilingBook   := ri.LnJliens[14].FilingBook;
		self.Liens14_FilingPage   := ri.LnJliens[14].FilingPage;
		self.Liens14_Agency       := ri.LnJliens[14].Agency; 
		self.Liens14_AgencyCounty := ri.LnJliens[14].AgencyCounty;
		self.Liens14_AgencyState	:= ri.LnJliens[14].AgencyState;
		self.Liens14_ConsumerStatementId	:= SetCSID(ri.LnJliens[14].ConsumerStatementId);
		self.Liens14_orig_rmsid       := ri.LnJliens[14].orig_rmsid;
		self.Liens15_Seq          := ri.LnJliens[15].Seq              ;
		self.Liens15_DateFiled    := ri.LnJliens[15].DateFiled        ;
  self.Liens15_LienTypeID   := ri.LnJliens[15].LienTypeID;
		self.Liens15_LienType     := ri.LnJliens[15].LienType         ;
		self.Liens15_Amount       := ri.LnJliens[15].Amount           ;
		self.Liens15_ReleaseDate  := ri.LnJliens[15].ReleaseDate      ;
		self.Liens15_DateLastSeen := ri.LnJliens[15].DateLastSeen     ;
		self.Liens15_FilingNumber := ri.LnJliens[15].FilingNumber     ;
		self.Liens15_FilingBook   := ri.LnJliens[15].FilingBook       ;
		self.Liens15_FilingPage   := ri.LnJliens[15].FilingPage       ;
		self.Liens15_Agency       := ri.LnJliens[15].Agency           ;
		self.Liens15_AgencyCounty := ri.LnJliens[15].AgencyCounty     ;
		self.Liens15_AgencyState  := ri.LnJliens[15].AgencyState      ;
		self.Liens15_ConsumerStatementId	:= SetCSID(ri.LnJliens[15].ConsumerStatementId);
    self.Liens15_orig_rmsid       := ri.LnJliens[15].orig_rmsid;
		self.Liens16_Seq          := ri.LnJliens[16].Seq              ;
		self.Liens16_DateFiled    := ri.LnJliens[16].DateFiled        ;
  self.Liens16_LienTypeID   := ri.LnJliens[16].LienTypeID;
		self.Liens16_LienType     := ri.LnJliens[16].LienType         ;
		self.Liens16_Amount       := ri.LnJliens[16].Amount           ;
		self.Liens16_ReleaseDate  := ri.LnJliens[16].ReleaseDate      ;
		self.Liens16_DateLastSeen := ri.LnJliens[16].DateLastSeen     ;
		self.Liens16_FilingNumber := ri.LnJliens[16].FilingNumber     ;
		self.Liens16_FilingBook   := ri.LnJliens[16].FilingBook       ;
		self.Liens16_FilingPage   := ri.LnJliens[16].FilingPage       ;
		self.Liens16_Agency       := ri.LnJliens[16].Agency           ;
		self.Liens16_AgencyCounty := ri.LnJliens[16].AgencyCounty     ;
		self.Liens16_AgencyState  := ri.LnJliens[16].AgencyState      ;
		self.Liens16_ConsumerStatementId	:= SetCSID(ri.LnJliens[16].ConsumerStatementId);
    self.Liens16_orig_rmsid       := ri.LnJliens[16].orig_rmsid;
		self.Liens17_Seq          := ri.LnJliens[17].Seq              ;
		self.Liens17_DateFiled    := ri.LnJliens[17].DateFiled        ;
  self.Liens17_LienTypeID   := ri.LnJliens[17].LienTypeID;
		self.Liens17_LienType     := ri.LnJliens[17].LienType         ;
		self.Liens17_Amount       := ri.LnJliens[17].Amount           ;
		self.Liens17_ReleaseDate  := ri.LnJliens[17].ReleaseDate      ;
		self.Liens17_DateLastSeen := ri.LnJliens[17].DateLastSeen     ;
		self.Liens17_FilingNumber := ri.LnJliens[17].FilingNumber     ;
		self.Liens17_FilingBook   := ri.LnJliens[17].FilingBook       ;
		self.Liens17_FilingPage   := ri.LnJliens[17].FilingPage       ;
		self.Liens17_Agency       := ri.LnJliens[17].Agency           ;
		self.Liens17_AgencyCounty := ri.LnJliens[17].AgencyCounty     ;
		self.Liens17_AgencyState  := ri.LnJliens[17].AgencyState      ;
		self.Liens17_ConsumerStatementId	:= SetCSID(ri.LnJliens[17].ConsumerStatementId);
    self.Liens17_orig_rmsid       := ri.LnJliens[17].orig_rmsid;
		self.Liens18_Seq          := ri.LnJliens[18].Seq              ;
		self.Liens18_DateFiled    := ri.LnJliens[18].DateFiled        ;
  self.Liens18_LienTypeID   := ri.LnJliens[18].LienTypeID;
		self.Liens18_LienType     := ri.LnJliens[18].LienType         ;
		self.Liens18_Amount       := ri.LnJliens[18].Amount           ;
		self.Liens18_ReleaseDate  := ri.LnJliens[18].ReleaseDate      ;
		self.Liens18_DateLastSeen := ri.LnJliens[18].DateLastSeen     ;
		self.Liens18_FilingNumber := ri.LnJliens[18].FilingNumber     ;
		self.Liens18_FilingBook   := ri.LnJliens[18].FilingBook       ;
		self.Liens18_FilingPage   := ri.LnJliens[18].FilingPage       ;
		self.Liens18_Agency       := ri.LnJliens[18].Agency           ;
		self.Liens18_AgencyCounty := ri.LnJliens[18].AgencyCounty     ;
		self.Liens18_AgencyState  := ri.LnJliens[18].AgencyState      ;
		self.Liens18_ConsumerStatementId	:= SetCSID(ri.LnJliens[18].ConsumerStatementId);
    self.Liens18_orig_rmsid       := ri.LnJliens[18].orig_rmsid;
		self.Liens19_Seq          := ri.LnJliens[19].Seq              ;
		self.Liens19_DateFiled    := ri.LnJliens[19].DateFiled        ;
  self.Liens19_LienTypeID   := ri.LnJliens[19].LienTypeID;
		self.Liens19_LienType     := ri.LnJliens[19].LienType         ;
		self.Liens19_Amount       := ri.LnJliens[19].Amount           ;
		self.Liens19_ReleaseDate  := ri.LnJliens[19].ReleaseDate      ;
		self.Liens19_DateLastSeen := ri.LnJliens[19].DateLastSeen     ;
		self.Liens19_FilingNumber := ri.LnJliens[19].FilingNumber     ;
		self.Liens19_FilingBook   := ri.LnJliens[19].FilingBook       ;
		self.Liens19_FilingPage   := ri.LnJliens[19].FilingPage       ;
		self.Liens19_Agency       := ri.LnJliens[19].Agency           ;
		self.Liens19_AgencyCounty := ri.LnJliens[19].AgencyCounty     ;
		self.Liens19_AgencyState  := ri.LnJliens[19].AgencyState      ;
		self.Liens19_ConsumerStatementId	:= SetCSID(ri.LnJliens[19].ConsumerStatementId);
    self.Liens19_orig_rmsid       := ri.LnJliens[19].orig_rmsid;
		self.Liens20_Seq          := ri.LnJliens[20].Seq             ;
		self.Liens20_DateFiled    := ri.LnJliens[20].DateFiled       ;
  self.Liens20_LienTypeID   := ri.LnJliens[20].LienTypeID;
		self.Liens20_LienType     := ri.LnJliens[20].LienType        ;
		self.Liens20_Amount       := ri.LnJliens[20].Amount          ;
		self.Liens20_ReleaseDate  := ri.LnJliens[20].ReleaseDate     ;
		self.Liens20_DateLastSeen := ri.LnJliens[20].DateLastSeen    ;
		self.Liens20_FilingNumber := ri.LnJliens[20].FilingNumber    ;
		self.Liens20_FilingBook   := ri.LnJliens[20].FilingBook      ;
		self.Liens20_FilingPage   := ri.LnJliens[20].FilingPage      ;
		self.Liens20_Agency       := ri.LnJliens[20].Agency          ;
		self.Liens20_AgencyCounty := ri.LnJliens[20].AgencyCounty    ;
		self.Liens20_AgencyState  := ri.LnJliens[20].AgencyState     ;
		self.Liens20_ConsumerStatementId	:= SetCSID(ri.LnJliens[20].ConsumerStatementId);
    self.Liens20_orig_rmsid       := ri.LnJliens[20].orig_rmsid;
				self.Liens21_Seq          := ri.LnJliens[21].Seq;
		self.Liens21_DateFiled    := ri.LnJliens[21].DateFiled;
  self.Liens21_LienTypeID   := ri.LnJliens[21].LienTypeID;
		self.Liens21_LienType     := ri.LnJliens[21].LienType;
		self.Liens21_Amount       := ri.LnJliens[21].Amount;
		self.Liens21_ReleaseDate  := ri.LnJliens[21].ReleaseDate;
		self.Liens21_DateLastSeen := ri.LnJliens[21].DateLastSeen;
		self.Liens21_FilingNumber := ri.LnJliens[21].FilingNumber;
		self.Liens21_FilingBook   := ri.LnJliens[21].FilingBook;
		self.Liens21_FilingPage   := ri.LnJliens[21].FilingPage;
		self.Liens21_Agency       := ri.LnJliens[21].Agency ;
		self.Liens21_AgencyCounty := ri.LnJliens[21].AgencyCounty;
		self.Liens21_AgencyState	:= ri.LnJliens[21].AgencyState;
		self.Liens21_ConsumerStatementId	:= SetCSID(ri.LnJliens[21].ConsumerStatementId);
    self.Liens21_orig_rmsid       := ri.LnJliens[21].orig_rmsid;
		self.Liens22_Seq          := ri.LnJliens[22].Seq;
		self.Liens22_DateFiled    := ri.LnJliens[22].DateFiled;
  self.Liens22_LienTypeID   := ri.LnJliens[22].LienTypeID;
		self.Liens22_LienType     := ri.LnJliens[22].LienType;
		self.Liens22_Amount       := ri.LnJliens[22].Amount;
		self.Liens22_ReleaseDate  := ri.LnJliens[22].ReleaseDate;
		self.Liens22_DateLastSeen := ri.LnJliens[22].DateLastSeen;
		self.Liens22_FilingNumber := ri.LnJliens[22].FilingNumber;
		self.Liens22_FilingBook   := ri.LnJliens[22].FilingBook;
		self.Liens22_FilingPage   := ri.LnJliens[22].FilingPage;
		self.Liens22_Agency       := ri.LnJliens[22].Agency; 
		self.Liens22_AgencyCounty := ri.LnJliens[22].AgencyCounty;
		self.Liens22_AgencyState	:= ri.LnJliens[22].AgencyState;
		self.Liens22_ConsumerStatementId	:= SetCSID(ri.LnJliens[22].ConsumerStatementId);
    self.Liens22_orig_rmsid       := ri.LnJliens[22].orig_rmsid;
		self.Liens23_Seq          := ri.LnJliens[23].Seq;
		self.Liens23_DateFiled    := ri.LnJliens[23].DateFiled;
  self.Liens23_LienTypeID   := ri.LnJliens[23].LienTypeID;
		self.Liens23_LienType     := ri.LnJliens[23].LienType;
		self.Liens23_Amount       := ri.LnJliens[23].Amount;
		self.Liens23_ReleaseDate  := ri.LnJliens[23].ReleaseDate;
		self.Liens23_DateLastSeen := ri.LnJliens[23].DateLastSeen;
		self.Liens23_FilingNumber := ri.LnJliens[23].FilingNumber;
		self.Liens23_FilingBook   := ri.LnJliens[23].FilingBook;
		self.Liens23_FilingPage   := ri.LnJliens[23].FilingPage; 
		self.Liens23_Agency       := ri.LnJliens[23].Agency; 
		self.Liens23_AgencyCounty := ri.LnJliens[23].AgencyCounty;
		self.Liens23_AgencyState	:= ri.LnJliens[23].AgencyState;
		self.Liens23_ConsumerStatementId	:= SetCSID(ri.LnJliens[23].ConsumerStatementId);
    self.Liens23_orig_rmsid       := ri.LnJliens[23].orig_rmsid;
		self.Liens24_Seq          := ri.LnJliens[24].Seq;
		self.Liens24_DateFiled    := ri.LnJliens[24].DateFiled;
  self.Liens24_LienTypeID   := ri.LnJliens[24].LienTypeID;
		self.Liens24_LienType     := ri.LnJliens[24].LienType;
		self.Liens24_Amount       := ri.LnJliens[24].Amount;
		self.Liens24_ReleaseDate  := ri.LnJliens[24].ReleaseDate;
		self.Liens24_DateLastSeen := ri.LnJliens[24].DateLastSeen;
		self.Liens24_FilingNumber := ri.LnJliens[24].FilingNumber;
		self.Liens24_FilingBook   := ri.LnJliens[24].FilingBook;
		self.Liens24_FilingPage   := ri.LnJliens[24].FilingPage;
		self.Liens24_Agency       := ri.LnJliens[24].Agency; 
		self.Liens24_AgencyCounty := ri.LnJliens[24].AgencyCounty;
		self.Liens24_AgencyState	:= ri.LnJliens[24].AgencyState;
		self.Liens24_ConsumerStatementId	:= SetCSID(ri.LnJliens[24].ConsumerStatementId);
		self.Liens24_orig_rmsid       := ri.LnJliens[24].orig_rmsid;
		self.Liens25_Seq          := ri.LnJliens[25].Seq              ;
		self.Liens25_DateFiled    := ri.LnJliens[25].DateFiled        ;
  self.Liens25_LienTypeID   := ri.LnJliens[25].LienTypeID;
		self.Liens25_LienType     := ri.LnJliens[25].LienType         ;
		self.Liens25_Amount       := ri.LnJliens[25].Amount           ;
		self.Liens25_ReleaseDate  := ri.LnJliens[25].ReleaseDate      ;
		self.Liens25_DateLastSeen := ri.LnJliens[25].DateLastSeen     ;
		self.Liens25_FilingNumber := ri.LnJliens[25].FilingNumber     ;
		self.Liens25_FilingBook   := ri.LnJliens[25].FilingBook       ;
		self.Liens25_FilingPage   := ri.LnJliens[25].FilingPage       ;
		self.Liens25_Agency       := ri.LnJliens[25].Agency           ;
		self.Liens25_AgencyCounty := ri.LnJliens[25].AgencyCounty     ;
		self.Liens25_AgencyState  := ri.LnJliens[25].AgencyState      ;
		self.Liens25_ConsumerStatementId	:= SetCSID(ri.LnJliens[25].ConsumerStatementId);
    self.Liens25_orig_rmsid       := ri.LnJliens[25].orig_rmsid;
		self.Liens26_Seq          := ri.LnJliens[26].Seq              ;
		self.Liens26_DateFiled    := ri.LnJliens[26].DateFiled        ;
  self.Liens26_LienTypeID   := ri.LnJliens[26].LienTypeID;
		self.Liens26_LienType     := ri.LnJliens[26].LienType         ;
		self.Liens26_Amount       := ri.LnJliens[26].Amount           ;
		self.Liens26_ReleaseDate  := ri.LnJliens[26].ReleaseDate      ;
		self.Liens26_DateLastSeen := ri.LnJliens[26].DateLastSeen     ;
		self.Liens26_FilingNumber := ri.LnJliens[26].FilingNumber     ;
		self.Liens26_FilingBook   := ri.LnJliens[26].FilingBook       ;
		self.Liens26_FilingPage   := ri.LnJliens[26].FilingPage       ;
		self.Liens26_Agency       := ri.LnJliens[26].Agency           ;
		self.Liens26_AgencyCounty := ri.LnJliens[26].AgencyCounty     ;
		self.Liens26_AgencyState  := ri.LnJliens[26].AgencyState      ;
		self.Liens26_ConsumerStatementId	:= SetCSID(ri.LnJliens[26].ConsumerStatementId);
    self.Liens26_orig_rmsid       := ri.LnJliens[26].orig_rmsid;
		self.Liens27_Seq          := ri.LnJliens[27].Seq              ;
		self.Liens27_DateFiled    := ri.LnJliens[27].DateFiled        ;
  self.Liens27_LienTypeID   := ri.LnJliens[27].LienTypeID;
		self.Liens27_LienType     := ri.LnJliens[27].LienType         ;
		self.Liens27_Amount       := ri.LnJliens[27].Amount           ;
		self.Liens27_ReleaseDate  := ri.LnJliens[27].ReleaseDate      ;
		self.Liens27_DateLastSeen := ri.LnJliens[27].DateLastSeen     ;
		self.Liens27_FilingNumber := ri.LnJliens[27].FilingNumber     ;
		self.Liens27_FilingBook   := ri.LnJliens[27].FilingBook       ;
		self.Liens27_FilingPage   := ri.LnJliens[27].FilingPage       ;
		self.Liens27_Agency       := ri.LnJliens[27].Agency           ;
		self.Liens27_AgencyCounty := ri.LnJliens[27].AgencyCounty     ;
		self.Liens27_AgencyState  := ri.LnJliens[27].AgencyState      ;
		self.Liens27_ConsumerStatementId	:= SetCSID(ri.LnJliens[27].ConsumerStatementId);
    self.Liens27_orig_rmsid       := ri.LnJliens[27].orig_rmsid;
		self.Liens28_Seq          := ri.LnJliens[28].Seq              ;
		self.Liens28_DateFiled    := ri.LnJliens[28].DateFiled        ;
  self.Liens28_LienTypeID   := ri.LnJliens[28].LienTypeID;
		self.Liens28_LienType     := ri.LnJliens[28].LienType         ;
		self.Liens28_Amount       := ri.LnJliens[28].Amount           ;
		self.Liens28_ReleaseDate  := ri.LnJliens[28].ReleaseDate      ;
		self.Liens28_DateLastSeen := ri.LnJliens[28].DateLastSeen     ;
		self.Liens28_FilingNumber := ri.LnJliens[28].FilingNumber     ;
		self.Liens28_FilingBook   := ri.LnJliens[28].FilingBook       ;
		self.Liens28_FilingPage   := ri.LnJliens[28].FilingPage       ;
		self.Liens28_Agency       := ri.LnJliens[28].Agency           ;
		self.Liens28_AgencyCounty := ri.LnJliens[28].AgencyCounty     ;
		self.Liens28_AgencyState  := ri.LnJliens[28].AgencyState      ;
		self.Liens28_ConsumerStatementId	:= SetCSID(ri.LnJliens[28].ConsumerStatementId);
    self.Liens28_orig_rmsid       := ri.LnJliens[28].orig_rmsid;
		self.Liens29_Seq          := ri.LnJliens[29].Seq              ;
		self.Liens29_DateFiled    := ri.LnJliens[29].DateFiled        ;
  self.Liens29_LienTypeID   := ri.LnJliens[29].LienTypeID;
		self.Liens29_LienType     := ri.LnJliens[29].LienType         ;
		self.Liens29_Amount       := ri.LnJliens[29].Amount           ;
		self.Liens29_ReleaseDate  := ri.LnJliens[29].ReleaseDate      ;
		self.Liens29_DateLastSeen := ri.LnJliens[29].DateLastSeen     ;
		self.Liens29_FilingNumber := ri.LnJliens[29].FilingNumber     ;
		self.Liens29_FilingBook   := ri.LnJliens[29].FilingBook       ;
		self.Liens29_FilingPage   := ri.LnJliens[29].FilingPage       ;
		self.Liens29_Agency       := ri.LnJliens[29].Agency           ;
		self.Liens29_AgencyCounty := ri.LnJliens[29].AgencyCounty     ;
		self.Liens29_AgencyState  := ri.LnJliens[29].AgencyState      ;
		self.Liens29_ConsumerStatementId	:= SetCSID(ri.LnJliens[29].ConsumerStatementId);
    self.Liens29_orig_rmsid       := ri.LnJliens[29].orig_rmsid;
		self.Liens30_Seq          := ri.LnJliens[30].Seq             ;
		self.Liens30_DateFiled    := ri.LnJliens[30].DateFiled       ;
  self.Liens30_LienTypeID   := ri.LnJliens[30].LienTypeID;
		self.Liens30_LienType     := ri.LnJliens[30].LienType        ;
		self.Liens30_Amount       := ri.LnJliens[30].Amount          ;
		self.Liens30_ReleaseDate  := ri.LnJliens[30].ReleaseDate     ;
		self.Liens30_DateLastSeen := ri.LnJliens[30].DateLastSeen    ;
		self.Liens30_FilingNumber := ri.LnJliens[30].FilingNumber    ;
		self.Liens30_FilingBook   := ri.LnJliens[30].FilingBook      ;
		self.Liens30_FilingPage   := ri.LnJliens[30].FilingPage      ;
		self.Liens30_Agency       := ri.LnJliens[30].Agency          ;
		self.Liens30_AgencyCounty := ri.LnJliens[30].AgencyCounty    ;
		self.Liens30_AgencyState  := ri.LnJliens[30].AgencyState     ;
		self.Liens30_ConsumerStatementId	:= SetCSID(ri.LnJliens[30].ConsumerStatementId);
    self.Liens30_orig_rmsid       := ri.LnJliens[30].orig_rmsid;
				self.Liens31_Seq          := ri.LnJliens[31].Seq;
		self.Liens31_DateFiled    := ri.LnJliens[31].DateFiled;
  self.Liens31_LienTypeID   := ri.LnJliens[31].LienTypeID;
		self.Liens31_LienType     := ri.LnJliens[31].LienType;
		self.Liens31_Amount       := ri.LnJliens[31].Amount;
		self.Liens31_ReleaseDate  := ri.LnJliens[31].ReleaseDate;
		self.Liens31_DateLastSeen := ri.LnJliens[31].DateLastSeen;
		self.Liens31_FilingNumber := ri.LnJliens[31].FilingNumber;
		self.Liens31_FilingBook   := ri.LnJliens[31].FilingBook;
		self.Liens31_FilingPage   := ri.LnJliens[31].FilingPage;
		self.Liens31_Agency       := ri.LnJliens[31].Agency ;
		self.Liens31_AgencyCounty := ri.LnJliens[31].AgencyCounty;
		self.Liens31_AgencyState	:= ri.LnJliens[31].AgencyState;
		self.Liens31_ConsumerStatementId	:= SetCSID(ri.LnJliens[31].ConsumerStatementId);
    self.Liens31_orig_rmsid       := ri.LnJliens[31].orig_rmsid;
		self.Liens32_Seq          := ri.LnJliens[32].Seq;
		self.Liens32_DateFiled    := ri.LnJliens[32].DateFiled;
  self.Liens32_LienTypeID   := ri.LnJliens[32].LienTypeID;
		self.Liens32_LienType     := ri.LnJliens[32].LienType;
		self.Liens32_Amount       := ri.LnJliens[32].Amount;
		self.Liens32_ReleaseDate  := ri.LnJliens[32].ReleaseDate;
		self.Liens32_DateLastSeen := ri.LnJliens[32].DateLastSeen;
		self.Liens32_FilingNumber := ri.LnJliens[32].FilingNumber;
		self.Liens32_FilingBook   := ri.LnJliens[32].FilingBook;
		self.Liens32_FilingPage   := ri.LnJliens[32].FilingPage;
		self.Liens32_Agency       := ri.LnJliens[32].Agency; 
		self.Liens32_AgencyCounty := ri.LnJliens[32].AgencyCounty;
		self.Liens32_AgencyState	:= ri.LnJliens[32].AgencyState;
		self.Liens32_ConsumerStatementId	:= SetCSID(ri.LnJliens[32].ConsumerStatementId);
    self.Liens32_orig_rmsid       := ri.LnJliens[32].orig_rmsid;
		self.Liens33_Seq          := ri.LnJliens[33].Seq;
		self.Liens33_DateFiled    := ri.LnJliens[33].DateFiled;
  self.Liens33_LienTypeID   := ri.LnJliens[33].LienTypeID;
		self.Liens33_LienType     := ri.LnJliens[33].LienType;
		self.Liens33_Amount       := ri.LnJliens[33].Amount;
		self.Liens33_ReleaseDate  := ri.LnJliens[33].ReleaseDate;
		self.Liens33_DateLastSeen := ri.LnJliens[33].DateLastSeen;
		self.Liens33_FilingNumber := ri.LnJliens[33].FilingNumber;
		self.Liens33_FilingBook   := ri.LnJliens[33].FilingBook;
		self.Liens33_FilingPage   := ri.LnJliens[33].FilingPage; 
		self.Liens33_Agency       := ri.LnJliens[33].Agency; 
		self.Liens33_AgencyCounty := ri.LnJliens[33].AgencyCounty;
		self.Liens33_AgencyState	:= ri.LnJliens[33].AgencyState;
		self.Liens33_ConsumerStatementId	:= SetCSID(ri.LnJliens[33].ConsumerStatementId);
    self.Liens33_orig_rmsid       := ri.LnJliens[33].orig_rmsid;
		self.Liens34_Seq          := ri.LnJliens[34].Seq;
		self.Liens34_DateFiled    := ri.LnJliens[34].DateFiled;
  self.Liens34_LienTypeID   := ri.LnJliens[34].LienTypeID;
		self.Liens34_LienType     := ri.LnJliens[34].LienType;
		self.Liens34_Amount       := ri.LnJliens[34].Amount;
		self.Liens34_ReleaseDate  := ri.LnJliens[34].ReleaseDate;
		self.Liens34_DateLastSeen := ri.LnJliens[34].DateLastSeen;
		self.Liens34_FilingNumber := ri.LnJliens[34].FilingNumber;
		self.Liens34_FilingBook   := ri.LnJliens[34].FilingBook;
		self.Liens34_FilingPage   := ri.LnJliens[34].FilingPage; 
		self.Liens34_Agency       := ri.LnJliens[34].Agency; 
		self.Liens34_AgencyCounty := ri.LnJliens[34].AgencyCounty;
		self.Liens34_AgencyState	:= ri.LnJliens[34].AgencyState;
		self.Liens34_ConsumerStatementId	:= SetCSID(ri.LnJliens[34].ConsumerStatementId);
		self.Liens34_orig_rmsid       := ri.LnJliens[34].orig_rmsid;
		self.Liens35_Seq          := ri.LnJliens[35].Seq              ;
		self.Liens35_DateFiled    := ri.LnJliens[35].DateFiled        ;
  self.Liens35_LienTypeID   := ri.LnJliens[35].LienTypeID;
		self.Liens35_LienType     := ri.LnJliens[35].LienType         ;
		self.Liens35_Amount       := ri.LnJliens[35].Amount           ;
		self.Liens35_ReleaseDate  := ri.LnJliens[35].ReleaseDate      ;
		self.Liens35_DateLastSeen := ri.LnJliens[35].DateLastSeen     ;
		self.Liens35_FilingNumber := ri.LnJliens[35].FilingNumber     ;
		self.Liens35_FilingBook   := ri.LnJliens[35].FilingBook       ;
		self.Liens35_FilingPage   := ri.LnJliens[35].FilingPage       ;
		self.Liens35_Agency       := ri.LnJliens[35].Agency           ;
		self.Liens35_AgencyCounty := ri.LnJliens[35].AgencyCounty     ;
		self.Liens35_AgencyState  := ri.LnJliens[35].AgencyState      ;
		self.Liens35_ConsumerStatementId	:= SetCSID(ri.LnJliens[35].ConsumerStatementId);
    self.Liens35_orig_rmsid       := ri.LnJliens[35].orig_rmsid;
		self.Liens36_Seq          := ri.LnJliens[36].Seq              ;
		self.Liens36_DateFiled    := ri.LnJliens[36].DateFiled        ;
  self.Liens36_LienTypeID   := ri.LnJliens[36].LienTypeID;
		self.Liens36_LienType     := ri.LnJliens[36].LienType         ;
		self.Liens36_Amount       := ri.LnJliens[36].Amount           ;
		self.Liens36_ReleaseDate  := ri.LnJliens[36].ReleaseDate      ;
		self.Liens36_DateLastSeen := ri.LnJliens[36].DateLastSeen     ;
		self.Liens36_FilingNumber := ri.LnJliens[36].FilingNumber     ;
		self.Liens36_FilingBook   := ri.LnJliens[36].FilingBook       ;
		self.Liens36_FilingPage   := ri.LnJliens[36].FilingPage       ;
		self.Liens36_Agency       := ri.LnJliens[36].Agency           ;
		self.Liens36_AgencyCounty := ri.LnJliens[36].AgencyCounty     ;
		self.Liens36_AgencyState  := ri.LnJliens[36].AgencyState      ;
		self.Liens36_ConsumerStatementId	:= SetCSID(ri.LnJliens[36].ConsumerStatementId);
    self.Liens36_orig_rmsid       := ri.LnJliens[36].orig_rmsid;
		self.Liens37_Seq          := ri.LnJliens[37].Seq              ;
		self.Liens37_DateFiled    := ri.LnJliens[37].DateFiled        ;
  self.Liens37_LienTypeID   := ri.LnJliens[37].LienTypeID;
		self.Liens37_LienType     := ri.LnJliens[37].LienType         ;
		self.Liens37_Amount       := ri.LnJliens[37].Amount           ;
		self.Liens37_ReleaseDate  := ri.LnJliens[37].ReleaseDate      ;
		self.Liens37_DateLastSeen := ri.LnJliens[37].DateLastSeen     ;
		self.Liens37_FilingNumber := ri.LnJliens[37].FilingNumber     ;
		self.Liens37_FilingBook   := ri.LnJliens[37].FilingBook       ;
		self.Liens37_FilingPage   := ri.LnJliens[37].FilingPage       ;
		self.Liens37_Agency       := ri.LnJliens[37].Agency           ;
		self.Liens37_AgencyCounty := ri.LnJliens[37].AgencyCounty     ;
		self.Liens37_AgencyState  := ri.LnJliens[37].AgencyState      ;
		self.Liens37_ConsumerStatementId	:= SetCSID(ri.LnJliens[37].ConsumerStatementId);
    self.Liens37_orig_rmsid       := ri.LnJliens[37].orig_rmsid;
		self.Liens38_Seq          := ri.LnJliens[38].Seq              ;
		self.Liens38_DateFiled    := ri.LnJliens[38].DateFiled        ;
  self.Liens38_LienTypeID   := ri.LnJliens[38].LienTypeID;
		self.Liens38_LienType     := ri.LnJliens[38].LienType         ;
		self.Liens38_Amount       := ri.LnJliens[38].Amount           ;
		self.Liens38_ReleaseDate  := ri.LnJliens[38].ReleaseDate      ;
		self.Liens38_DateLastSeen := ri.LnJliens[38].DateLastSeen     ;
		self.Liens38_FilingNumber := ri.LnJliens[38].FilingNumber     ;
		self.Liens38_FilingBook   := ri.LnJliens[38].FilingBook       ;
		self.Liens38_FilingPage   := ri.LnJliens[38].FilingPage       ;
		self.Liens38_Agency       := ri.LnJliens[38].Agency           ;
		self.Liens38_AgencyCounty := ri.LnJliens[38].AgencyCounty     ;
		self.Liens38_AgencyState  := ri.LnJliens[38].AgencyState      ;
		self.Liens38_ConsumerStatementId	:= SetCSID(ri.LnJliens[38].ConsumerStatementId);
    self.Liens38_orig_rmsid       := ri.LnJliens[38].orig_rmsid;
		self.Liens39_Seq          := ri.LnJliens[39].Seq              ;
		self.Liens39_DateFiled    := ri.LnJliens[39].DateFiled        ;
  self.Liens39_LienTypeID   := ri.LnJliens[39].LienTypeID;
		self.Liens39_LienType     := ri.LnJliens[39].LienType         ;
		self.Liens39_Amount       := ri.LnJliens[39].Amount           ;
		self.Liens39_ReleaseDate  := ri.LnJliens[39].ReleaseDate      ;
		self.Liens39_DateLastSeen := ri.LnJliens[39].DateLastSeen     ;
		self.Liens39_FilingNumber := ri.LnJliens[39].FilingNumber     ;
		self.Liens39_FilingBook   := ri.LnJliens[39].FilingBook       ;
		self.Liens39_FilingPage   := ri.LnJliens[39].FilingPage       ;
		self.Liens39_Agency       := ri.LnJliens[39].Agency           ;
		self.Liens39_AgencyCounty := ri.LnJliens[39].AgencyCounty     ;
		self.Liens39_AgencyState  := ri.LnJliens[39].AgencyState      ;
		self.Liens39_ConsumerStatementId	:= SetCSID(ri.LnJliens[39].ConsumerStatementId);
    self.Liens39_orig_rmsid       := ri.LnJliens[39].orig_rmsid;
		self.Liens40_Seq          := ri.LnJliens[40].Seq             ;
		self.Liens40_DateFiled    := ri.LnJliens[40].DateFiled       ;
  self.Liens40_LienTypeID   := ri.LnJliens[40].LienTypeID;
		self.Liens40_LienType     := ri.LnJliens[40].LienType        ;
		self.Liens40_Amount       := ri.LnJliens[40].Amount          ;
		self.Liens40_ReleaseDate  := ri.LnJliens[40].ReleaseDate     ;
		self.Liens40_DateLastSeen := ri.LnJliens[40].DateLastSeen    ;
		self.Liens40_FilingNumber := ri.LnJliens[40].FilingNumber    ;
		self.Liens40_FilingBook   := ri.LnJliens[40].FilingBook      ;
		self.Liens40_FilingPage   := ri.LnJliens[40].FilingPage      ;
		self.Liens40_Agency       := ri.LnJliens[40].Agency          ;
		self.Liens40_AgencyCounty := ri.LnJliens[40].AgencyCounty    ;
		self.Liens40_AgencyState  := ri.LnJliens[40].AgencyState     ;
		self.Liens40_ConsumerStatementId	:= SetCSID(ri.LnJliens[40].ConsumerStatementId);
    self.Liens40_orig_rmsid       := ri.LnJliens[40].orig_rmsid;
		self.Liens41_Seq          := ri.LnJliens[41].Seq             ;
		self.Liens41_DateFiled    := ri.LnJliens[41].DateFiled       ;
  self.Liens41_LienTypeID   := ri.LnJliens[41].LienTypeID;
		self.Liens41_LienType     := ri.LnJliens[41].LienType        ;
		self.Liens41_Amount       := ri.LnJliens[41].Amount          ;
		self.Liens41_ReleaseDate  := ri.LnJliens[41].ReleaseDate     ;
		self.Liens41_DateLastSeen := ri.LnJliens[41].DateLastSeen    ;
		self.Liens41_FilingNumber := ri.LnJliens[41].FilingNumber    ;
		self.Liens41_FilingBook   := ri.LnJliens[41].FilingBook      ;
		self.Liens41_FilingPage   := ri.LnJliens[41].FilingPage      ;
		self.Liens41_Agency       := ri.LnJliens[41].Agency          ;
		self.Liens41_AgencyCounty := ri.LnJliens[41].AgencyCounty    ;
		self.Liens41_AgencyState  := ri.LnJliens[41].AgencyState     ;
		self.Liens41_ConsumerStatementId	:= SetCSID(ri.LnJliens[41].ConsumerStatementId);
    self.Liens41_orig_rmsid       := ri.LnJliens[41].orig_rmsid;
		self.Liens42_Seq          := ri.LnJliens[42].Seq             ;
		self.Liens42_DateFiled    := ri.LnJliens[42].DateFiled       ;
  self.Liens42_LienTypeID   := ri.LnJliens[42].LienTypeID;
		self.Liens42_LienType     := ri.LnJliens[42].LienType        ;
		self.Liens42_Amount       := ri.LnJliens[42].Amount          ;
		self.Liens42_ReleaseDate  := ri.LnJliens[42].ReleaseDate     ;
		self.Liens42_DateLastSeen := ri.LnJliens[42].DateLastSeen    ;
		self.Liens42_FilingNumber := ri.LnJliens[42].FilingNumber    ;
		self.Liens42_FilingBook   := ri.LnJliens[42].FilingBook      ;
		self.Liens42_FilingPage   := ri.LnJliens[42].FilingPage      ;
		self.Liens42_Agency       := ri.LnJliens[42].Agency          ;
		self.Liens42_AgencyCounty := ri.LnJliens[42].AgencyCounty    ;
		self.Liens42_AgencyState  := ri.LnJliens[42].AgencyState     ;
		self.Liens42_ConsumerStatementId	:= SetCSID(ri.LnJliens[42].ConsumerStatementId);
		self.Liens42_orig_rmsid       := ri.LnJliens[42].orig_rmsid;
		self.Liens43_Seq          := ri.LnJliens[43].Seq             ;
		self.Liens43_DateFiled    := ri.LnJliens[43].DateFiled       ;
  self.Liens43_LienTypeID   := ri.LnJliens[43].LienTypeID;
		self.Liens43_LienType     := ri.LnJliens[43].LienType        ;
		self.Liens43_Amount       := ri.LnJliens[43].Amount          ;
		self.Liens43_ReleaseDate  := ri.LnJliens[43].ReleaseDate     ;
		self.Liens43_DateLastSeen := ri.LnJliens[43].DateLastSeen    ;
		self.Liens43_FilingNumber := ri.LnJliens[43].FilingNumber    ;
		self.Liens43_FilingBook   := ri.LnJliens[43].FilingBook      ;
		self.Liens43_FilingPage   := ri.LnJliens[43].FilingPage      ;
		self.Liens43_Agency       := ri.LnJliens[43].Agency          ;
		self.Liens43_AgencyCounty := ri.LnJliens[43].AgencyCounty    ;
		self.Liens43_AgencyState  := ri.LnJliens[43].AgencyState     ;
		self.Liens43_ConsumerStatementId	:= SetCSID(ri.LnJliens[43].ConsumerStatementId);
		self.Liens43_orig_rmsid       := ri.LnJliens[43].orig_rmsid;
		self.Liens44_Seq          := ri.LnJliens[44].Seq             ;
		self.Liens44_DateFiled    := ri.LnJliens[44].DateFiled       ;
  self.Liens44_LienTypeID   := ri.LnJliens[44].LienTypeID;
		self.Liens44_LienType     := ri.LnJliens[44].LienType        ;
		self.Liens44_Amount       := ri.LnJliens[44].Amount          ;
		self.Liens44_ReleaseDate  := ri.LnJliens[44].ReleaseDate     ;
		self.Liens44_DateLastSeen := ri.LnJliens[44].DateLastSeen    ;
		self.Liens44_FilingNumber := ri.LnJliens[44].FilingNumber    ;
		self.Liens44_FilingBook   := ri.LnJliens[44].FilingBook      ;
		self.Liens44_FilingPage   := ri.LnJliens[44].FilingPage      ;
		self.Liens44_Agency       := ri.LnJliens[44].Agency          ;
		self.Liens44_AgencyCounty := ri.LnJliens[44].AgencyCounty    ;
		self.Liens44_AgencyState  := ri.LnJliens[44].AgencyState     ;
		self.Liens44_ConsumerStatementId	:= SetCSID(ri.LnJliens[44].ConsumerStatementId);
		self.Liens44_orig_rmsid       := ri.LnJliens[44].orig_rmsid;
		self.Liens45_Seq          := ri.LnJliens[45].Seq             ;
		self.Liens45_DateFiled    := ri.LnJliens[45].DateFiled       ;
  self.Liens45_LienTypeID   := ri.LnJliens[45].LienTypeID;
		self.Liens45_LienType     := ri.LnJliens[45].LienType        ;
		self.Liens45_Amount       := ri.LnJliens[45].Amount          ;
		self.Liens45_ReleaseDate  := ri.LnJliens[45].ReleaseDate     ;
		self.Liens45_DateLastSeen := ri.LnJliens[45].DateLastSeen    ;
		self.Liens45_FilingNumber := ri.LnJliens[45].FilingNumber    ;
		self.Liens45_FilingBook   := ri.LnJliens[45].FilingBook      ;
		self.Liens45_FilingPage   := ri.LnJliens[45].FilingPage      ;
		self.Liens45_Agency       := ri.LnJliens[45].Agency          ;
		self.Liens45_AgencyCounty := ri.LnJliens[45].AgencyCounty    ;
		self.Liens45_AgencyState  := ri.LnJliens[45].AgencyState     ;
		self.Liens45_ConsumerStatementId	:= SetCSID(ri.LnJliens[45].ConsumerStatementId);
		self.Liens45_orig_rmsid       := ri.LnJliens[45].orig_rmsid;
		self.Liens46_Seq          := ri.LnJliens[46].Seq             ;
		self.Liens46_DateFiled    := ri.LnJliens[46].DateFiled       ;
  self.Liens46_LienTypeID   := ri.LnJliens[46].LienTypeID;
		self.Liens46_LienType     := ri.LnJliens[46].LienType        ;
		self.Liens46_Amount       := ri.LnJliens[46].Amount          ;
		self.Liens46_ReleaseDate  := ri.LnJliens[46].ReleaseDate     ;
		self.Liens46_DateLastSeen := ri.LnJliens[46].DateLastSeen    ;
		self.Liens46_FilingNumber := ri.LnJliens[46].FilingNumber    ;
		self.Liens46_FilingBook   := ri.LnJliens[46].FilingBook      ;
		self.Liens46_FilingPage   := ri.LnJliens[46].FilingPage      ;
		self.Liens46_Agency       := ri.LnJliens[46].Agency          ;
		self.Liens46_AgencyCounty := ri.LnJliens[46].AgencyCounty    ;
		self.Liens46_AgencyState  := ri.LnJliens[46].AgencyState     ;
		self.Liens46_ConsumerStatementId	:= SetCSID(ri.LnJliens[46].ConsumerStatementId);
    self.Liens46_orig_rmsid       := ri.LnJliens[46].orig_rmsid;		
		self.Liens47_Seq          := ri.LnJliens[47].Seq             ;
		self.Liens47_DateFiled    := ri.LnJliens[47].DateFiled       ;
  self.Liens47_LienTypeID   := ri.LnJliens[47].LienTypeID;
		self.Liens47_LienType     := ri.LnJliens[47].LienType        ;
		self.Liens47_Amount       := ri.LnJliens[47].Amount          ;
		self.Liens47_ReleaseDate  := ri.LnJliens[47].ReleaseDate     ;
		self.Liens47_DateLastSeen := ri.LnJliens[47].DateLastSeen    ;
		self.Liens47_FilingNumber := ri.LnJliens[47].FilingNumber    ;
		self.Liens47_FilingBook   := ri.LnJliens[47].FilingBook      ;
		self.Liens47_FilingPage   := ri.LnJliens[47].FilingPage      ;
		self.Liens47_Agency       := ri.LnJliens[47].Agency          ;
		self.Liens47_AgencyCounty := ri.LnJliens[47].AgencyCounty    ;
		self.Liens47_AgencyState  := ri.LnJliens[47].AgencyState     ;
		self.Liens47_ConsumerStatementId	:= SetCSID(ri.LnJliens[47].ConsumerStatementId);
		self.Liens47_orig_rmsid       := ri.LnJliens[47].orig_rmsid;
		self.Liens48_Seq          := ri.LnJliens[48].Seq             ;
		self.Liens48_DateFiled    := ri.LnJliens[48].DateFiled       ;
  self.Liens48_LienTypeID   := ri.LnJliens[48].LienTypeID;
		self.Liens48_LienType     := ri.LnJliens[48].LienType        ;
		self.Liens48_Amount       := ri.LnJliens[48].Amount          ;
		self.Liens48_ReleaseDate  := ri.LnJliens[48].ReleaseDate     ;
		self.Liens48_DateLastSeen := ri.LnJliens[48].DateLastSeen    ;
		self.Liens48_FilingNumber := ri.LnJliens[48].FilingNumber    ;
		self.Liens48_FilingBook   := ri.LnJliens[48].FilingBook      ;
		self.Liens48_FilingPage   := ri.LnJliens[48].FilingPage      ;
		self.Liens48_Agency       := ri.LnJliens[48].Agency          ;
		self.Liens48_AgencyCounty := ri.LnJliens[48].AgencyCounty    ;
		self.Liens48_AgencyState  := ri.LnJliens[48].AgencyState     ;
		self.Liens48_ConsumerStatementId	:= SetCSID(ri.LnJliens[48].ConsumerStatementId);
		self.Liens48_orig_rmsid       := ri.LnJliens[48].orig_rmsid;
		self.Liens49_Seq          := ri.LnJliens[49].Seq             ;
		self.Liens49_DateFiled    := ri.LnJliens[49].DateFiled       ;
  self.Liens49_LienTypeID   := ri.LnJliens[49].LienTypeID;
		self.Liens49_LienType     := ri.LnJliens[49].LienType        ;
		self.Liens49_Amount       := ri.LnJliens[49].Amount          ;
		self.Liens49_ReleaseDate  := ri.LnJliens[49].ReleaseDate     ;
		self.Liens49_DateLastSeen := ri.LnJliens[49].DateLastSeen    ;
		self.Liens49_FilingNumber := ri.LnJliens[49].FilingNumber    ;
		self.Liens49_FilingBook   := ri.LnJliens[49].FilingBook      ;
		self.Liens49_FilingPage   := ri.LnJliens[49].FilingPage      ;
		self.Liens49_Agency       := ri.LnJliens[49].Agency          ;
		self.Liens49_AgencyCounty := ri.LnJliens[49].AgencyCounty    ;
		self.Liens49_AgencyState  := ri.LnJliens[49].AgencyState     ;
		self.Liens49_ConsumerStatementId	:= SetCSID(ri.LnJliens[49].ConsumerStatementId);
		self.Liens49_orig_rmsid       := ri.LnJliens[49].orig_rmsid;
		self.Liens50_Seq      := ri.LnJliens[50].Seq         ;
		self.Liens50_DateFiled    := ri.LnJliens[50].DateFiled       ;
  self.Liens50_LienTypeID   := ri.LnJliens[50].LienTypeID;
		self.Liens50_LienType     := ri.LnJliens[50].LienType        ;
		self.Liens50_Amount       := ri.LnJliens[50].Amount          ;
		self.Liens50_ReleaseDate  := ri.LnJliens[50].ReleaseDate     ;
		self.Liens50_DateLastSeen := ri.LnJliens[50].DateLastSeen    ;
		self.Liens50_FilingNumber := ri.LnJliens[50].FilingNumber    ;
		self.Liens50_FilingBook   := ri.LnJliens[50].FilingBook      ;
		self.Liens50_FilingPage   := ri.LnJliens[50].FilingPage      ;
		self.Liens50_Agency       := ri.LnJliens[50].Agency          ;
		self.Liens50_AgencyCounty := ri.LnJliens[50].AgencyCounty    ;
		self.Liens50_AgencyState  := ri.LnJliens[50].AgencyState     ;	
		self.Liens50_ConsumerStatementId	:= SetCSID(ri.LnJliens[50].ConsumerStatementId);
    self.Liens50_orig_rmsid       := ri.LnJliens[50].orig_rmsid;
		self.Liens51_Seq          := ri.LnJliens[51].Seq;
		self.Liens51_DateFiled    := ri.LnJliens[51].DateFiled;
  self.Liens51_LienTypeID   := ri.LnJliens[51].LienTypeID;
		self.Liens51_LienType     := ri.LnJliens[51].LienType;
		self.Liens51_Amount       := ri.LnJliens[51].Amount;
		self.Liens51_ReleaseDate  := ri.LnJliens[51].ReleaseDate;
		self.Liens51_DateLastSeen := ri.LnJliens[51].DateLastSeen;
		self.Liens51_FilingNumber := ri.LnJliens[51].FilingNumber;
		self.Liens51_FilingBook   := ri.LnJliens[51].FilingBook;
		self.Liens51_FilingPage   := ri.LnJliens[51].FilingPage;
		self.Liens51_Agency       := ri.LnJliens[51].Agency ;
		self.Liens51_AgencyCounty := ri.LnJliens[51].AgencyCounty;
		self.Liens51_AgencyState  := ri.LnJliens[51].AgencyState;
		self.Liens51_ConsumerStatementId	:= SetCSID(ri.LnJliens[51].ConsumerStatementId);
    self.Liens51_orig_rmsid       := ri.LnJliens[51].orig_rmsid;
		self.Liens52_Seq          := ri.LnJliens[52].Seq;
		self.Liens52_DateFiled    := ri.LnJliens[52].DateFiled;
  self.Liens52_LienTypeID   := ri.LnJliens[52].LienTypeID;
		self.Liens52_LienType     := ri.LnJliens[52].LienType;
		self.Liens52_Amount       := ri.LnJliens[52].Amount;
		self.Liens52_ReleaseDate  := ri.LnJliens[52].ReleaseDate;
		self.Liens52_DateLastSeen := ri.LnJliens[52].DateLastSeen;
		self.Liens52_FilingNumber := ri.LnJliens[52].FilingNumber;
		self.Liens52_FilingBook   := ri.LnJliens[52].FilingBook;
		self.Liens52_FilingPage   := ri.LnJliens[52].FilingPage;
		self.Liens52_Agency       := ri.LnJliens[52].Agency; 
		self.Liens52_AgencyCounty := ri.LnJliens[52].AgencyCounty;
		self.Liens52_AgencyState  := ri.LnJliens[52].AgencyState;
		self.Liens52_ConsumerStatementId	:= SetCSID(ri.LnJliens[52].ConsumerStatementId);
    self.Liens52_orig_rmsid       := ri.LnJliens[52].orig_rmsid;
		self.Liens53_Seq          := ri.LnJliens[53].Seq;
		self.Liens53_DateFiled    := ri.LnJliens[53].DateFiled;
  self.Liens53_LienTypeID   := ri.LnJliens[53].LienTypeID;
		self.Liens53_LienType     := ri.LnJliens[53].LienType;
		self.Liens53_Amount       := ri.LnJliens[53].Amount;
		self.Liens53_ReleaseDate  := ri.LnJliens[53].ReleaseDate;
		self.Liens53_DateLastSeen := ri.LnJliens[53].DateLastSeen;
		self.Liens53_FilingNumber := ri.LnJliens[53].FilingNumber;
		self.Liens53_FilingBook   := ri.LnJliens[53].FilingBook;
		self.Liens53_FilingPage   := ri.LnJliens[53].FilingPage;
		self.Liens53_Agency       := ri.LnJliens[53].Agency; 
		self.Liens53_AgencyCounty := ri.LnJliens[53].AgencyCounty;
		self.Liens53_AgencyState  := ri.LnJliens[53].AgencyState;
		self.Liens53_ConsumerStatementId	:= SetCSID(ri.LnJliens[53].ConsumerStatementId);
    self.Liens53_orig_rmsid       := ri.LnJliens[53].orig_rmsid;
		self.Liens54_Seq          := ri.LnJliens[54].Seq;
		self.Liens54_DateFiled    := ri.LnJliens[54].DateFiled;
  self.Liens54_LienTypeID   := ri.LnJliens[54].LienTypeID;
		self.Liens54_LienType     := ri.LnJliens[54].LienType;
		self.Liens54_Amount       := ri.LnJliens[54].Amount;
		self.Liens54_ReleaseDate  := ri.LnJliens[54].ReleaseDate;
		self.Liens54_DateLastSeen := ri.LnJliens[54].DateLastSeen;
		self.Liens54_FilingNumber := ri.LnJliens[54].FilingNumber;
		self.Liens54_FilingBook   := ri.LnJliens[54].FilingBook;
		self.Liens54_FilingPage   := ri.LnJliens[54].FilingPage;
		self.Liens54_Agency       := ri.LnJliens[54].Agency; 
		self.Liens54_AgencyCounty := ri.LnJliens[54].AgencyCounty;
		self.Liens54_AgencyState  := ri.LnJliens[54].AgencyState;
		self.Liens54_ConsumerStatementId	:= SetCSID(ri.LnJliens[54].ConsumerStatementId);
		self.Liens54_orig_rmsid       := ri.LnJliens[54].orig_rmsid;
		self.Liens55_Seq          := ri.LnJliens[55].Seq              ;
		self.Liens55_DateFiled    := ri.LnJliens[55].DateFiled        ;
  self.Liens55_LienTypeID   := ri.LnJliens[55].LienTypeID;
		self.Liens55_LienType     := ri.LnJliens[55].LienType         ;
		self.Liens55_Amount       := ri.LnJliens[55].Amount           ;
		self.Liens55_ReleaseDate  := ri.LnJliens[55].ReleaseDate      ;
		self.Liens55_DateLastSeen := ri.LnJliens[55].DateLastSeen     ;
		self.Liens55_FilingNumber := ri.LnJliens[55].FilingNumber     ;
		self.Liens55_FilingBook   := ri.LnJliens[55].FilingBook       ;
		self.Liens55_FilingPage   := ri.LnJliens[55].FilingPage       ;
		self.Liens55_Agency       := ri.LnJliens[55].Agency           ;
		self.Liens55_AgencyCounty := ri.LnJliens[55].AgencyCounty     ;
		self.Liens55_AgencyState  := ri.LnJliens[55].AgencyState      ;
		self.Liens55_ConsumerStatementId	:= SetCSID(ri.LnJliens[55].ConsumerStatementId);
    self.Liens55_orig_rmsid       := ri.LnJliens[55].orig_rmsid;
		self.Liens56_Seq          := ri.LnJliens[56].Seq              ;
		self.Liens56_DateFiled    := ri.LnJliens[56].DateFiled        ;
  self.Liens56_LienTypeID   := ri.LnJliens[56].LienTypeID;
		self.Liens56_LienType     := ri.LnJliens[56].LienType         ;
		self.Liens56_Amount       := ri.LnJliens[56].Amount           ;
		self.Liens56_ReleaseDate  := ri.LnJliens[56].ReleaseDate      ;
		self.Liens56_DateLastSeen := ri.LnJliens[56].DateLastSeen     ;
		self.Liens56_FilingNumber := ri.LnJliens[56].FilingNumber     ;
		self.Liens56_FilingBook   := ri.LnJliens[56].FilingBook       ;
		self.Liens56_FilingPage   := ri.LnJliens[56].FilingPage       ;
		self.Liens56_Agency       := ri.LnJliens[56].Agency           ;
		self.Liens56_AgencyCounty := ri.LnJliens[56].AgencyCounty     ;
		self.Liens56_AgencyState  := ri.LnJliens[56].AgencyState      ;
		self.Liens56_ConsumerStatementId	:= SetCSID(ri.LnJliens[56].ConsumerStatementId);
    self.Liens56_orig_rmsid       := ri.LnJliens[56].orig_rmsid;
		self.Liens57_Seq          := ri.LnJliens[57].Seq              ;
		self.Liens57_DateFiled    := ri.LnJliens[57].DateFiled        ;
  self.Liens57_LienTypeID   := ri.LnJliens[57].LienTypeID;
		self.Liens57_LienType     := ri.LnJliens[57].LienType         ;
		self.Liens57_Amount       := ri.LnJliens[57].Amount           ;
		self.Liens57_ReleaseDate  := ri.LnJliens[57].ReleaseDate      ;
		self.Liens57_DateLastSeen := ri.LnJliens[57].DateLastSeen     ;
		self.Liens57_FilingNumber := ri.LnJliens[57].FilingNumber     ;
		self.Liens57_FilingBook   := ri.LnJliens[57].FilingBook       ;
		self.Liens57_FilingPage   := ri.LnJliens[57].FilingPage       ;
		self.Liens57_Agency       := ri.LnJliens[57].Agency           ;
		self.Liens57_AgencyCounty := ri.LnJliens[57].AgencyCounty     ;
		self.Liens57_AgencyState  := ri.LnJliens[57].AgencyState      ;
		self.Liens57_ConsumerStatementId	:= SetCSID(ri.LnJliens[57].ConsumerStatementId);
    self.Liens57_orig_rmsid       := ri.LnJliens[57].orig_rmsid;
		self.Liens58_Seq          := ri.LnJliens[58].Seq              ;
		self.Liens58_DateFiled    := ri.LnJliens[58].DateFiled        ;
  self.Liens58_LienTypeID   := ri.LnJliens[58].LienTypeID;
		self.Liens58_LienType     := ri.LnJliens[58].LienType         ;
		self.Liens58_Amount       := ri.LnJliens[58].Amount           ;
		self.Liens58_ReleaseDate  := ri.LnJliens[58].ReleaseDate      ;
		self.Liens58_DateLastSeen := ri.LnJliens[58].DateLastSeen     ;
		self.Liens58_FilingNumber := ri.LnJliens[58].FilingNumber     ;
		self.Liens58_FilingBook   := ri.LnJliens[58].FilingBook       ;
		self.Liens58_FilingPage   := ri.LnJliens[58].FilingPage       ;
		self.Liens58_Agency       := ri.LnJliens[58].Agency           ;
		self.Liens58_AgencyCounty := ri.LnJliens[58].AgencyCounty     ;
		self.Liens58_AgencyState  := ri.LnJliens[58].AgencyState      ;
		self.Liens58_ConsumerStatementId	:= SetCSID(ri.LnJliens[58].ConsumerStatementId);
    self.Liens58_orig_rmsid       := ri.LnJliens[58].orig_rmsid;
		self.Liens59_Seq          := ri.LnJliens[59].Seq              ;
		self.Liens59_DateFiled    := ri.LnJliens[59].DateFiled        ;
  self.Liens59_LienTypeID   := ri.LnJliens[59].LienTypeID;
		self.Liens59_LienType     := ri.LnJliens[59].LienType         ;
		self.Liens59_Amount       := ri.LnJliens[59].Amount           ;
		self.Liens59_ReleaseDate  := ri.LnJliens[59].ReleaseDate      ;
		self.Liens59_DateLastSeen := ri.LnJliens[59].DateLastSeen     ;
		self.Liens59_FilingNumber := ri.LnJliens[59].FilingNumber     ;
		self.Liens59_FilingBook   := ri.LnJliens[59].FilingBook       ;
		self.Liens59_FilingPage   := ri.LnJliens[59].FilingPage       ;
		self.Liens59_Agency       := ri.LnJliens[59].Agency           ;
		self.Liens59_AgencyCounty := ri.LnJliens[59].AgencyCounty     ;
		self.Liens59_AgencyState  := ri.LnJliens[59].AgencyState      ;
		self.Liens59_ConsumerStatementId	:= SetCSID(ri.LnJliens[59].ConsumerStatementId);
    self.Liens59_orig_rmsid       := ri.LnJliens[59].orig_rmsid;
		self.Liens60_Seq          := ri.LnJliens[60].Seq             ;
		self.Liens60_DateFiled    := ri.LnJliens[60].DateFiled       ;
  self.Liens60_LienTypeID   := ri.LnJliens[60].LienTypeID;
		self.Liens60_LienType     := ri.LnJliens[60].LienType        ;
		self.Liens60_Amount       := ri.LnJliens[60].Amount          ;
		self.Liens60_ReleaseDate  := ri.LnJliens[60].ReleaseDate     ;
		self.Liens60_DateLastSeen := ri.LnJliens[60].DateLastSeen    ;
		self.Liens60_FilingNumber := ri.LnJliens[60].FilingNumber    ;
		self.Liens60_FilingBook   := ri.LnJliens[60].FilingBook      ;
		self.Liens60_FilingPage   := ri.LnJliens[60].FilingPage      ;
		self.Liens60_Agency       := ri.LnJliens[60].Agency          ;
		self.Liens60_AgencyCounty := ri.LnJliens[60].AgencyCounty    ;
		self.Liens60_AgencyState  := ri.LnJliens[60].AgencyState     ;
		self.Liens60_ConsumerStatementId	:= SetCSID(ri.LnJliens[60].ConsumerStatementId);
    self.Liens60_orig_rmsid       := ri.LnJliens[60].orig_rmsid;
			self.Liens61_Seq          := ri.LnJliens[61].Seq;
		self.Liens61_DateFiled    := ri.LnJliens[61].DateFiled;
  self.Liens61_LienTypeID   := ri.LnJliens[61].LienTypeID;
		self.Liens61_LienType     := ri.LnJliens[61].LienType;
		self.Liens61_Amount       := ri.LnJliens[61].Amount;
		self.Liens61_ReleaseDate  := ri.LnJliens[61].ReleaseDate;
		self.Liens61_DateLastSeen := ri.LnJliens[61].DateLastSeen;
		self.Liens61_FilingNumber := ri.LnJliens[61].FilingNumber;
		self.Liens61_FilingBook   := ri.LnJliens[61].FilingBook;
		self.Liens61_FilingPage   := ri.LnJliens[61].FilingPage;
		self.Liens61_Agency       := ri.LnJliens[61].Agency ;
		self.Liens61_AgencyCounty := ri.LnJliens[61].AgencyCounty;
		self.Liens61_AgencyState  := ri.LnJliens[61].AgencyState;
		self.Liens61_ConsumerStatementId	:= SetCSID(ri.LnJliens[61].ConsumerStatementId);
    self.Liens61_orig_rmsid       := ri.LnJliens[61].orig_rmsid;
		self.Liens62_Seq          := ri.LnJliens[62].Seq;
		self.Liens62_DateFiled    := ri.LnJliens[62].DateFiled;
  self.Liens62_LienTypeID   := ri.LnJliens[62].LienTypeID;
		self.Liens62_LienType     := ri.LnJliens[62].LienType;
		self.Liens62_Amount       := ri.LnJliens[62].Amount;
		self.Liens62_ReleaseDate  := ri.LnJliens[62].ReleaseDate;
		self.Liens62_DateLastSeen := ri.LnJliens[62].DateLastSeen;
		self.Liens62_FilingNumber := ri.LnJliens[62].FilingNumber;
		self.Liens62_FilingBook   := ri.LnJliens[62].FilingBook;
		self.Liens62_FilingPage   := ri.LnJliens[62].FilingPage;
		self.Liens62_Agency       := ri.LnJliens[62].Agency; 
		self.Liens62_AgencyCounty := ri.LnJliens[62].AgencyCounty;
		self.Liens62_AgencyState  := ri.LnJliens[62].AgencyState;
		self.Liens62_ConsumerStatementId	:= SetCSID(ri.LnJliens[62].ConsumerStatementId);
    self.Liens62_orig_rmsid       := ri.LnJliens[62].orig_rmsid;
		self.Liens63_Seq          := ri.LnJliens[63].Seq;
		self.Liens63_DateFiled    := ri.LnJliens[63].DateFiled;
  self.Liens63_LienTypeID   := ri.LnJliens[63].LienTypeID;
		self.Liens63_LienType     := ri.LnJliens[63].LienType;
		self.Liens63_Amount       := ri.LnJliens[63].Amount;
		self.Liens63_ReleaseDate  := ri.LnJliens[63].ReleaseDate;
		self.Liens63_DateLastSeen := ri.LnJliens[63].DateLastSeen;
		self.Liens63_FilingNumber := ri.LnJliens[63].FilingNumber;
		self.Liens63_FilingBook   := ri.LnJliens[63].FilingBook;
		self.Liens63_FilingPage   := ri.LnJliens[63].FilingPage;
		self.Liens63_Agency       := ri.LnJliens[63].Agency; 
		self.Liens63_AgencyCounty := ri.LnJliens[63].AgencyCounty;
		self.Liens63_AgencyState  := ri.LnJliens[63].AgencyState;
		self.Liens63_ConsumerStatementId	:= SetCSID(ri.LnJliens[63].ConsumerStatementId);
    self.Liens63_orig_rmsid       := ri.LnJliens[63].orig_rmsid;
		self.Liens64_Seq          := ri.LnJliens[64].Seq;
		self.Liens64_DateFiled    := ri.LnJliens[64].DateFiled;
  self.Liens64_LienTypeID   := ri.LnJliens[64].LienTypeID;
		self.Liens64_LienType     := ri.LnJliens[64].LienType;
		self.Liens64_Amount       := ri.LnJliens[64].Amount;
		self.Liens64_ReleaseDate  := ri.LnJliens[64].ReleaseDate;
		self.Liens64_DateLastSeen := ri.LnJliens[64].DateLastSeen;
		self.Liens64_FilingNumber := ri.LnJliens[64].FilingNumber;
		self.Liens64_FilingBook   := ri.LnJliens[64].FilingBook;
		self.Liens64_FilingPage   := ri.LnJliens[64].FilingPage;
		self.Liens64_Agency       := ri.LnJliens[64].Agency; 
		self.Liens64_AgencyCounty := ri.LnJliens[64].AgencyCounty;
		self.Liens64_AgencyState  := ri.LnJliens[64].AgencyState;
		self.Liens64_ConsumerStatementId	:= SetCSID(ri.LnJliens[64].ConsumerStatementId);
		self.Liens64_orig_rmsid       := ri.LnJliens[64].orig_rmsid;
		self.Liens65_Seq          := ri.LnJliens[65].Seq              ;
		self.Liens65_DateFiled    := ri.LnJliens[65].DateFiled        ;
  self.Liens65_LienTypeID   := ri.LnJliens[65].LienTypeID;
		self.Liens65_LienType     := ri.LnJliens[65].LienType         ;
		self.Liens65_Amount       := ri.LnJliens[65].Amount           ;
		self.Liens65_ReleaseDate  := ri.LnJliens[65].ReleaseDate      ;
		self.Liens65_DateLastSeen := ri.LnJliens[65].DateLastSeen     ;
		self.Liens65_FilingNumber := ri.LnJliens[65].FilingNumber     ;
		self.Liens65_FilingBook   := ri.LnJliens[65].FilingBook       ;
		self.Liens65_FilingPage   := ri.LnJliens[65].FilingPage       ;
		self.Liens65_Agency       := ri.LnJliens[65].Agency           ;
		self.Liens65_AgencyCounty := ri.LnJliens[65].AgencyCounty     ;
		self.Liens65_AgencyState  := ri.LnJliens[65].AgencyState      ;
		self.Liens65_ConsumerStatementId	:= SetCSID(ri.LnJliens[65].ConsumerStatementId);
    self.Liens65_orig_rmsid       := ri.LnJliens[65].orig_rmsid;
		self.Liens66_Seq          := ri.LnJliens[66].Seq              ;
		self.Liens66_DateFiled    := ri.LnJliens[66].DateFiled        ;
  self.Liens66_LienTypeID   := ri.LnJliens[66].LienTypeID;
		self.Liens66_LienType     := ri.LnJliens[66].LienType         ;
		self.Liens66_Amount       := ri.LnJliens[66].Amount           ;
		self.Liens66_ReleaseDate  := ri.LnJliens[66].ReleaseDate      ;
		self.Liens66_DateLastSeen := ri.LnJliens[66].DateLastSeen     ;
		self.Liens66_FilingNumber := ri.LnJliens[66].FilingNumber     ;
		self.Liens66_FilingBook   := ri.LnJliens[66].FilingBook       ;
		self.Liens66_FilingPage   := ri.LnJliens[66].FilingPage       ;
		self.Liens66_Agency       := ri.LnJliens[66].Agency           ;
		self.Liens66_AgencyCounty := ri.LnJliens[66].AgencyCounty     ;
		self.Liens66_AgencyState  := ri.LnJliens[66].AgencyState      ;
		self.Liens66_ConsumerStatementId	:= SetCSID(ri.LnJliens[66].ConsumerStatementId);
    self.Liens66_orig_rmsid       := ri.LnJliens[66].orig_rmsid;
		self.Liens67_Seq          := ri.LnJliens[67].Seq              ;
		self.Liens67_DateFiled    := ri.LnJliens[67].DateFiled        ;
  self.Liens67_LienTypeID   := ri.LnJliens[67].LienTypeID;
		self.Liens67_LienType     := ri.LnJliens[67].LienType         ;
		self.Liens67_Amount       := ri.LnJliens[67].Amount           ;
		self.Liens67_ReleaseDate  := ri.LnJliens[67].ReleaseDate      ;
		self.Liens67_DateLastSeen := ri.LnJliens[67].DateLastSeen     ;
		self.Liens67_FilingNumber := ri.LnJliens[67].FilingNumber     ;
		self.Liens67_FilingBook   := ri.LnJliens[67].FilingBook       ;
		self.Liens67_FilingPage   := ri.LnJliens[67].FilingPage       ;
		self.Liens67_Agency       := ri.LnJliens[67].Agency           ;
		self.Liens67_AgencyCounty := ri.LnJliens[67].AgencyCounty     ;
		self.Liens67_AgencyState  := ri.LnJliens[67].AgencyState      ;
		self.Liens67_ConsumerStatementId	:= SetCSID(ri.LnJliens[67].ConsumerStatementId);
    self.Liens67_orig_rmsid       := ri.LnJliens[67].orig_rmsid;
		self.Liens68_Seq          := ri.LnJliens[68].Seq              ;
		self.Liens68_DateFiled    := ri.LnJliens[68].DateFiled        ;
  self.Liens68_LienTypeID   := ri.LnJliens[68].LienTypeID;
		self.Liens68_LienType     := ri.LnJliens[68].LienType         ;
		self.Liens68_Amount       := ri.LnJliens[68].Amount           ;
		self.Liens68_ReleaseDate  := ri.LnJliens[68].ReleaseDate      ;
		self.Liens68_DateLastSeen := ri.LnJliens[68].DateLastSeen     ;
		self.Liens68_FilingNumber := ri.LnJliens[68].FilingNumber     ;
		self.Liens68_FilingBook   := ri.LnJliens[68].FilingBook       ;
		self.Liens68_FilingPage   := ri.LnJliens[68].FilingPage       ;
		self.Liens68_Agency       := ri.LnJliens[68].Agency           ;
		self.Liens68_AgencyCounty := ri.LnJliens[68].AgencyCounty     ;
		self.Liens68_AgencyState  := ri.LnJliens[68].AgencyState      ;
		self.Liens68_ConsumerStatementId	:= SetCSID(ri.LnJliens[68].ConsumerStatementId);
    self.Liens68_orig_rmsid       := ri.LnJliens[68].orig_rmsid;
		self.Liens69_Seq          := ri.LnJliens[69].Seq              ;
		self.Liens69_DateFiled    := ri.LnJliens[69].DateFiled        ;
  self.Liens69_LienTypeID   := ri.LnJliens[69].LienTypeID;
		self.Liens69_LienType     := ri.LnJliens[69].LienType         ;
		self.Liens69_Amount       := ri.LnJliens[69].Amount           ;
		self.Liens69_ReleaseDate  := ri.LnJliens[69].ReleaseDate      ;
		self.Liens69_DateLastSeen := ri.LnJliens[69].DateLastSeen     ;
		self.Liens69_FilingNumber := ri.LnJliens[69].FilingNumber     ;
		self.Liens69_FilingBook   := ri.LnJliens[69].FilingBook       ;
		self.Liens69_FilingPage   := ri.LnJliens[69].FilingPage       ;
		self.Liens69_Agency       := ri.LnJliens[69].Agency           ;
		self.Liens69_AgencyCounty := ri.LnJliens[69].AgencyCounty     ;
		self.Liens69_AgencyState  := ri.LnJliens[69].AgencyState      ;
		self.Liens69_ConsumerStatementId	:= SetCSID(ri.LnJliens[69].ConsumerStatementId);
    self.Liens69_orig_rmsid       := ri.LnJliens[69].orig_rmsid;
		self.Liens70_Seq          := ri.LnJliens[70].Seq             ;
		self.Liens70_DateFiled    := ri.LnJliens[70].DateFiled       ;
  self.Liens70_LienTypeID   := ri.LnJliens[70].LienTypeID;
		self.Liens70_LienType     := ri.LnJliens[70].LienType        ;
		self.Liens70_Amount       := ri.LnJliens[70].Amount          ;
		self.Liens70_ReleaseDate  := ri.LnJliens[70].ReleaseDate     ;
		self.Liens70_DateLastSeen := ri.LnJliens[70].DateLastSeen    ;
		self.Liens70_FilingNumber := ri.LnJliens[70].FilingNumber    ;
		self.Liens70_FilingBook   := ri.LnJliens[70].FilingBook      ;
		self.Liens70_FilingPage   := ri.LnJliens[70].FilingPage      ;
		self.Liens70_Agency       := ri.LnJliens[70].Agency          ;
		self.Liens70_AgencyCounty := ri.LnJliens[70].AgencyCounty    ;
		self.Liens70_AgencyState  := ri.LnJliens[70].AgencyState     ;
		self.Liens70_ConsumerStatementId	:= SetCSID(ri.LnJliens[70].ConsumerStatementId);
    self.Liens70_orig_rmsid       := ri.LnJliens[70].orig_rmsid;
				self.Liens71_Seq          := ri.LnJliens[71].Seq;
		self.Liens71_DateFiled    := ri.LnJliens[71].DateFiled;
  self.Liens71_LienTypeID   := ri.LnJliens[71].LienTypeID;
		self.Liens71_LienType     := ri.LnJliens[71].LienType;
		self.Liens71_Amount       := ri.LnJliens[71].Amount;
		self.Liens71_ReleaseDate  := ri.LnJliens[71].ReleaseDate;
		self.Liens71_DateLastSeen := ri.LnJliens[71].DateLastSeen;
		self.Liens71_FilingNumber := ri.LnJliens[71].FilingNumber;
		self.Liens71_FilingBook   := ri.LnJliens[71].FilingBook;
		self.Liens71_FilingPage   := ri.LnJliens[71].FilingPage;
		self.Liens71_Agency       := ri.LnJliens[71].Agency ;
		self.Liens71_AgencyCounty := ri.LnJliens[71].AgencyCounty;
		self.Liens71_AgencyState  := ri.LnJliens[71].AgencyState;
		self.Liens71_ConsumerStatementId	:= SetCSID(ri.LnJliens[71].ConsumerStatementId);
    self.Liens71_orig_rmsid       := ri.LnJliens[71].orig_rmsid;
		self.Liens72_Seq          := ri.LnJliens[72].Seq;
		self.Liens72_DateFiled    := ri.LnJliens[72].DateFiled;
  self.Liens72_LienTypeID   := ri.LnJliens[72].LienTypeID;
		self.Liens72_LienType     := ri.LnJliens[72].LienType;
		self.Liens72_Amount       := ri.LnJliens[72].Amount;
		self.Liens72_ReleaseDate  := ri.LnJliens[72].ReleaseDate;
		self.Liens72_DateLastSeen := ri.LnJliens[72].DateLastSeen;
		self.Liens72_FilingNumber := ri.LnJliens[72].FilingNumber;
		self.Liens72_FilingBook   := ri.LnJliens[72].FilingBook;
		self.Liens72_FilingPage   := ri.LnJliens[72].FilingPage; 
		self.Liens72_Agency       := ri.LnJliens[72].Agency; 
		self.Liens72_AgencyCounty := ri.LnJliens[72].AgencyCounty;
		self.Liens72_AgencyState  := ri.LnJliens[72].AgencyState;
		self.Liens72_ConsumerStatementId	:= SetCSID(ri.LnJliens[72].ConsumerStatementId);
    self.Liens72_orig_rmsid       := ri.LnJliens[72].orig_rmsid;
		self.Liens73_Seq          := ri.LnJliens[73].Seq;
		self.Liens73_DateFiled    := ri.LnJliens[73].DateFiled;
  self.Liens73_LienTypeID   := ri.LnJliens[73].LienTypeID;
		self.Liens73_LienType     := ri.LnJliens[73].LienType;
		self.Liens73_Amount       := ri.LnJliens[73].Amount;
		self.Liens73_ReleaseDate  := ri.LnJliens[73].ReleaseDate;
		self.Liens73_DateLastSeen := ri.LnJliens[73].DateLastSeen;
		self.Liens73_FilingNumber := ri.LnJliens[73].FilingNumber;
		self.Liens73_FilingBook   := ri.LnJliens[73].FilingBook;
		self.Liens73_FilingPage   := ri.LnJliens[73].FilingPage;
		self.Liens73_Agency       := ri.LnJliens[73].Agency; 
		self.Liens73_AgencyCounty := ri.LnJliens[73].AgencyCounty;
		self.Liens73_AgencyState  := ri.LnJliens[73].AgencyState;
		self.Liens73_ConsumerStatementId	:= SetCSID(ri.LnJliens[73].ConsumerStatementId);
    self.Liens73_orig_rmsid       := ri.LnJliens[73].orig_rmsid;
		self.Liens74_Seq          := ri.LnJliens[74].Seq;
		self.Liens74_DateFiled    := ri.LnJliens[74].DateFiled;
  self.Liens74_LienTypeID   := ri.LnJliens[74].LienTypeID;
		self.Liens74_LienType     := ri.LnJliens[74].LienType;
		self.Liens74_Amount       := ri.LnJliens[74].Amount;
		self.Liens74_ReleaseDate  := ri.LnJliens[74].ReleaseDate;
		self.Liens74_DateLastSeen := ri.LnJliens[74].DateLastSeen;
		self.Liens74_FilingNumber := ri.LnJliens[74].FilingNumber;
		self.Liens74_FilingBook   := ri.LnJliens[74].FilingBook;
		self.Liens74_FilingPage   := ri.LnJliens[74].FilingPage;
		self.Liens74_Agency       := ri.LnJliens[74].Agency; 
		self.Liens74_AgencyCounty := ri.LnJliens[74].AgencyCounty;
		self.Liens74_AgencyState  := ri.LnJliens[74].AgencyState;
		self.Liens74_ConsumerStatementId	:= SetCSID(ri.LnJliens[74].ConsumerStatementId);
		self.Liens74_orig_rmsid       := ri.LnJliens[74].orig_rmsid;
		self.Liens75_Seq          := ri.LnJliens[75].Seq              ;
		self.Liens75_DateFiled    := ri.LnJliens[75].DateFiled        ;
  self.Liens75_LienTypeID   := ri.LnJliens[75].LienTypeID;
		self.Liens75_LienType     := ri.LnJliens[75].LienType         ;
		self.Liens75_Amount       := ri.LnJliens[75].Amount           ;
		self.Liens75_ReleaseDate  := ri.LnJliens[75].ReleaseDate      ;
		self.Liens75_DateLastSeen := ri.LnJliens[75].DateLastSeen     ;
		self.Liens75_FilingNumber := ri.LnJliens[75].FilingNumber     ;
		self.Liens75_FilingBook   := ri.LnJliens[75].FilingBook       ;
		self.Liens75_FilingPage   := ri.LnJliens[75].FilingPage       ;
		self.Liens75_Agency       := ri.LnJliens[75].Agency           ;
		self.Liens75_AgencyCounty := ri.LnJliens[75].AgencyCounty     ;
		self.Liens75_AgencyState  := ri.LnJliens[75].AgencyState      ;
		self.Liens75_ConsumerStatementId	:= SetCSID(ri.LnJliens[75].ConsumerStatementId);
    self.Liens75_orig_rmsid       := ri.LnJliens[75].orig_rmsid;
		self.Liens76_Seq          := ri.LnJliens[76].Seq              ;
		self.Liens76_DateFiled    := ri.LnJliens[76].DateFiled        ;
  self.Liens76_LienTypeID   := ri.LnJliens[76].LienTypeID;
		self.Liens76_LienType     := ri.LnJliens[76].LienType         ;
		self.Liens76_Amount       := ri.LnJliens[76].Amount           ;
		self.Liens76_ReleaseDate  := ri.LnJliens[76].ReleaseDate      ;
		self.Liens76_DateLastSeen := ri.LnJliens[76].DateLastSeen     ;
		self.Liens76_FilingNumber := ri.LnJliens[76].FilingNumber     ;
		self.Liens76_FilingBook   := ri.LnJliens[76].FilingBook       ;
		self.Liens76_FilingPage   := ri.LnJliens[76].FilingPage       ;
		self.Liens76_Agency       := ri.LnJliens[76].Agency           ;
		self.Liens76_AgencyCounty := ri.LnJliens[76].AgencyCounty     ;
		self.Liens76_AgencyState  := ri.LnJliens[76].AgencyState      ;
		self.Liens76_ConsumerStatementId	:= SetCSID(ri.LnJliens[76].ConsumerStatementId);
    self.Liens76_orig_rmsid       := ri.LnJliens[76].orig_rmsid;
		self.Liens77_Seq          := ri.LnJliens[77].Seq              ;
		self.Liens77_DateFiled    := ri.LnJliens[77].DateFiled        ;
  self.Liens77_LienTypeID   := ri.LnJliens[77].LienTypeID;
		self.Liens77_LienType     := ri.LnJliens[77].LienType         ;
		self.Liens77_Amount       := ri.LnJliens[77].Amount           ;
		self.Liens77_ReleaseDate  := ri.LnJliens[77].ReleaseDate      ;
		self.Liens77_DateLastSeen := ri.LnJliens[77].DateLastSeen     ;
		self.Liens77_FilingNumber := ri.LnJliens[77].FilingNumber     ;
		self.Liens77_FilingBook   := ri.LnJliens[77].FilingBook       ;
		self.Liens77_FilingPage   := ri.LnJliens[77].FilingPage       ;
		self.Liens77_Agency       := ri.LnJliens[77].Agency           ;
		self.Liens77_AgencyCounty := ri.LnJliens[77].AgencyCounty     ;
		self.Liens77_AgencyState  := ri.LnJliens[77].AgencyState      ;
		self.Liens77_ConsumerStatementId	:= SetCSID(ri.LnJliens[77].ConsumerStatementId);
    self.Liens77_orig_rmsid       := ri.LnJliens[77].orig_rmsid;
		self.Liens78_Seq          := ri.LnJliens[78].Seq              ;
		self.Liens78_DateFiled    := ri.LnJliens[78].DateFiled        ;
  self.Liens78_LienTypeID   := ri.LnJliens[78].LienTypeID;
		self.Liens78_LienType     := ri.LnJliens[78].LienType         ;
		self.Liens78_Amount       := ri.LnJliens[78].Amount           ;
		self.Liens78_ReleaseDate  := ri.LnJliens[78].ReleaseDate      ;
		self.Liens78_DateLastSeen := ri.LnJliens[78].DateLastSeen     ;
		self.Liens78_FilingNumber := ri.LnJliens[78].FilingNumber     ;
		self.Liens78_FilingBook   := ri.LnJliens[78].FilingBook       ;
		self.Liens78_FilingPage   := ri.LnJliens[78].FilingPage       ;
		self.Liens78_Agency       := ri.LnJliens[78].Agency           ;
		self.Liens78_AgencyCounty := ri.LnJliens[78].AgencyCounty     ;
		self.Liens78_AgencyState  := ri.LnJliens[78].AgencyState      ;
		self.Liens78_ConsumerStatementId	:= SetCSID(ri.LnJliens[78].ConsumerStatementId);
    self.Liens78_orig_rmsid       := ri.LnJliens[78].orig_rmsid;
		self.Liens79_Seq          := ri.LnJliens[79].Seq              ;
		self.Liens79_DateFiled    := ri.LnJliens[79].DateFiled        ;
  self.Liens79_LienTypeID   := ri.LnJliens[79].LienTypeID;
		self.Liens79_LienType     := ri.LnJliens[79].LienType         ;
		self.Liens79_Amount       := ri.LnJliens[79].Amount           ;
		self.Liens79_ReleaseDate  := ri.LnJliens[79].ReleaseDate      ;
		self.Liens79_DateLastSeen := ri.LnJliens[79].DateLastSeen     ;
		self.Liens79_FilingNumber := ri.LnJliens[79].FilingNumber     ;
		self.Liens79_FilingBook   := ri.LnJliens[79].FilingBook       ;
		self.Liens79_FilingPage   := ri.LnJliens[79].FilingPage       ;
		self.Liens79_Agency       := ri.LnJliens[79].Agency           ;
		self.Liens79_AgencyCounty := ri.LnJliens[79].AgencyCounty     ;
		self.Liens79_AgencyState  := ri.LnJliens[79].AgencyState      ;
		self.Liens79_ConsumerStatementId	:= SetCSID(ri.LnJliens[79].ConsumerStatementId);
    self.Liens79_orig_rmsid       := ri.LnJliens[79].orig_rmsid;
		self.Liens80_Seq          := ri.LnJliens[80].Seq             ;
		self.Liens80_DateFiled    := ri.LnJliens[80].DateFiled       ;
  self.Liens80_LienTypeID   := ri.LnJliens[80].LienTypeID;
		self.Liens80_LienType     := ri.LnJliens[80].LienType        ;
		self.Liens80_Amount       := ri.LnJliens[80].Amount          ;
		self.Liens80_ReleaseDate  := ri.LnJliens[80].ReleaseDate     ;
		self.Liens80_DateLastSeen := ri.LnJliens[80].DateLastSeen    ;
		self.Liens80_FilingNumber := ri.LnJliens[80].FilingNumber    ;
		self.Liens80_FilingBook   := ri.LnJliens[80].FilingBook      ;
		self.Liens80_FilingPage   := ri.LnJliens[80].FilingPage      ;
		self.Liens80_Agency       := ri.LnJliens[80].Agency          ;
		self.Liens80_AgencyCounty := ri.LnJliens[80].AgencyCounty    ;
		self.Liens80_AgencyState  := ri.LnJliens[80].AgencyState     ;
		self.Liens80_ConsumerStatementId	:= SetCSID(ri.LnJliens[80].ConsumerStatementId);
    self.Liens80_orig_rmsid       := ri.LnJliens[80].orig_rmsid;
				self.Liens81_Seq          := ri.LnJliens[81].Seq;
		self.Liens81_DateFiled    := ri.LnJliens[81].DateFiled;
  self.Liens81_LienTypeID   := ri.LnJliens[81].LienTypeID;
		self.Liens81_LienType     := ri.LnJliens[81].LienType;
		self.Liens81_Amount       := ri.LnJliens[81].Amount;
		self.Liens81_ReleaseDate  := ri.LnJliens[81].ReleaseDate;
		self.Liens81_DateLastSeen := ri.LnJliens[81].DateLastSeen;
		self.Liens81_FilingNumber := ri.LnJliens[81].FilingNumber;
		self.Liens81_FilingBook   := ri.LnJliens[81].FilingBook;
		self.Liens81_FilingPage   := ri.LnJliens[81].FilingPage;
		self.Liens81_Agency       := ri.LnJliens[81].Agency ;
		self.Liens81_AgencyCounty := ri.LnJliens[81].AgencyCounty;
		self.Liens81_AgencyState  := ri.LnJliens[81].AgencyState;
		self.Liens81_ConsumerStatementId	:= SetCSID(ri.LnJliens[81].ConsumerStatementId);
    self.Liens81_orig_rmsid       := ri.LnJliens[81].orig_rmsid;
		self.Liens82_Seq          := ri.LnJliens[82].Seq;
		self.Liens82_DateFiled    := ri.LnJliens[82].DateFiled;
  self.Liens82_LienTypeID   := ri.LnJliens[82].LienTypeID;
		self.Liens82_LienType     := ri.LnJliens[82].LienType;
		self.Liens82_Amount       := ri.LnJliens[82].Amount;
		self.Liens82_ReleaseDate  := ri.LnJliens[82].ReleaseDate;
		self.Liens82_DateLastSeen := ri.LnJliens[82].DateLastSeen;
		self.Liens82_FilingNumber := ri.LnJliens[82].FilingNumber;
		self.Liens82_FilingBook   := ri.LnJliens[82].FilingBook;
		self.Liens82_FilingPage   := ri.LnJliens[82].FilingPage;
		self.Liens82_Agency       := ri.LnJliens[82].Agency; 
		self.Liens82_AgencyCounty := ri.LnJliens[82].AgencyCounty;
		self.Liens82_AgencyState  := ri.LnJliens[82].AgencyState;
		self.Liens82_ConsumerStatementId	:= SetCSID(ri.LnJliens[82].ConsumerStatementId);
    self.Liens82_orig_rmsid       := ri.LnJliens[82].orig_rmsid;
		self.Liens83_Seq          := ri.LnJliens[83].Seq;
		self.Liens83_DateFiled    := ri.LnJliens[83].DateFiled;
  self.Liens83_LienTypeID   := ri.LnJliens[83].LienTypeID;
		self.Liens83_LienType     := ri.LnJliens[83].LienType;
		self.Liens83_Amount       := ri.LnJliens[83].Amount;
		self.Liens83_ReleaseDate  := ri.LnJliens[83].ReleaseDate;
		self.Liens83_DateLastSeen := ri.LnJliens[83].DateLastSeen;
		self.Liens83_FilingNumber := ri.LnJliens[83].FilingNumber;
		self.Liens83_FilingBook   := ri.LnJliens[83].FilingBook;
		self.Liens83_FilingPage   := ri.LnJliens[83].FilingPage;
		self.Liens83_Agency       := ri.LnJliens[83].Agency; 
		self.Liens83_AgencyCounty := ri.LnJliens[83].AgencyCounty;
		self.Liens83_AgencyState  := ri.LnJliens[83].AgencyState;
		self.Liens83_ConsumerStatementId	:= SetCSID(ri.LnJliens[83].ConsumerStatementId);
    self.Liens83_orig_rmsid       := ri.LnJliens[83].orig_rmsid;
		self.Liens84_Seq          := ri.LnJliens[84].Seq;
		self.Liens84_DateFiled    := ri.LnJliens[84].DateFiled;
  self.Liens84_LienTypeID   := ri.LnJliens[84].LienTypeID;
		self.Liens84_LienType     := ri.LnJliens[84].LienType;
		self.Liens84_Amount       := ri.LnJliens[84].Amount;
		self.Liens84_ReleaseDate  := ri.LnJliens[84].ReleaseDate;
		self.Liens84_DateLastSeen := ri.LnJliens[84].DateLastSeen;
		self.Liens84_FilingNumber := ri.LnJliens[84].FilingNumber;
		self.Liens84_FilingBook   := ri.LnJliens[84].FilingBook;
		self.Liens84_FilingPage   := ri.LnJliens[84].FilingPage; 
		self.Liens84_Agency       := ri.LnJliens[84].Agency; 
		self.Liens84_AgencyCounty := ri.LnJliens[84].AgencyCounty;
		self.Liens84_AgencyState  := ri.LnJliens[84].AgencyState;
		self.Liens84_ConsumerStatementId	:= SetCSID(ri.LnJliens[84].ConsumerStatementId);
		self.Liens84_orig_rmsid       := ri.LnJliens[84].orig_rmsid;
		self.Liens85_Seq          := ri.LnJliens[85].Seq              ;
		self.Liens85_DateFiled    := ri.LnJliens[85].DateFiled        ;
  self.Liens85_LienTypeID   := ri.LnJliens[85].LienTypeID;
		self.Liens85_LienType     := ri.LnJliens[85].LienType         ;
		self.Liens85_Amount       := ri.LnJliens[85].Amount           ;
		self.Liens85_ReleaseDate  := ri.LnJliens[85].ReleaseDate      ;
		self.Liens85_DateLastSeen := ri.LnJliens[85].DateLastSeen     ;
		self.Liens85_FilingNumber := ri.LnJliens[85].FilingNumber     ;
		self.Liens85_FilingBook   := ri.LnJliens[85].FilingBook       ;
		self.Liens85_FilingPage   := ri.LnJliens[85].FilingPage       ;
		self.Liens85_Agency       := ri.LnJliens[85].Agency           ;
		self.Liens85_AgencyCounty := ri.LnJliens[85].AgencyCounty     ;
		self.Liens85_AgencyState  := ri.LnJliens[85].AgencyState      ;
		self.Liens85_ConsumerStatementId	:= SetCSID(ri.LnJliens[85].ConsumerStatementId);
    self.Liens85_orig_rmsid       := ri.LnJliens[85].orig_rmsid;
		self.Liens86_Seq          := ri.LnJliens[86].Seq              ;
		self.Liens86_DateFiled    := ri.LnJliens[86].DateFiled        ;
  self.Liens86_LienTypeID   := ri.LnJliens[86].LienTypeID;
		self.Liens86_LienType     := ri.LnJliens[86].LienType         ;
		self.Liens86_Amount       := ri.LnJliens[86].Amount           ;
		self.Liens86_ReleaseDate  := ri.LnJliens[86].ReleaseDate      ;
		self.Liens86_DateLastSeen := ri.LnJliens[86].DateLastSeen     ;
		self.Liens86_FilingNumber := ri.LnJliens[86].FilingNumber     ;
		self.Liens86_FilingBook   := ri.LnJliens[86].FilingBook       ;
		self.Liens86_FilingPage   := ri.LnJliens[86].FilingPage       ;
		self.Liens86_Agency       := ri.LnJliens[86].Agency           ;
		self.Liens86_AgencyCounty := ri.LnJliens[86].AgencyCounty     ;
		self.Liens86_AgencyState  := ri.LnJliens[86].AgencyState      ;
		self.Liens86_ConsumerStatementId	:= SetCSID(ri.LnJliens[86].ConsumerStatementId);
    self.Liens86_orig_rmsid       := ri.LnJliens[86].orig_rmsid;
		self.Liens87_Seq          := ri.LnJliens[87].Seq              ;
		self.Liens87_DateFiled    := ri.LnJliens[87].DateFiled        ;
  self.Liens87_LienTypeID   := ri.LnJliens[87].LienTypeID;
		self.Liens87_LienType     := ri.LnJliens[87].LienType         ;
		self.Liens87_Amount       := ri.LnJliens[87].Amount           ;
		self.Liens87_ReleaseDate  := ri.LnJliens[87].ReleaseDate      ;
		self.Liens87_DateLastSeen := ri.LnJliens[87].DateLastSeen     ;
		self.Liens87_FilingNumber := ri.LnJliens[87].FilingNumber     ;
		self.Liens87_FilingBook   := ri.LnJliens[87].FilingBook       ;
		self.Liens87_FilingPage   := ri.LnJliens[87].FilingPage       ;
		self.Liens87_Agency       := ri.LnJliens[87].Agency           ;
		self.Liens87_AgencyCounty := ri.LnJliens[87].AgencyCounty     ;
		self.Liens87_AgencyState  := ri.LnJliens[87].AgencyState      ;
		self.Liens87_ConsumerStatementId	:= SetCSID(ri.LnJliens[87].ConsumerStatementId);
    self.Liens87_orig_rmsid       := ri.LnJliens[87].orig_rmsid;
		self.Liens88_Seq          := ri.LnJliens[88].Seq              ;
		self.Liens88_DateFiled    := ri.LnJliens[88].DateFiled        ;
  self.Liens88_LienTypeID   := ri.LnJliens[88].LienTypeID;
		self.Liens88_LienType     := ri.LnJliens[88].LienType         ;
		self.Liens88_Amount       := ri.LnJliens[88].Amount           ;
		self.Liens88_ReleaseDate  := ri.LnJliens[88].ReleaseDate      ;
		self.Liens88_DateLastSeen := ri.LnJliens[88].DateLastSeen     ;
		self.Liens88_FilingNumber := ri.LnJliens[88].FilingNumber     ;
		self.Liens88_FilingBook   := ri.LnJliens[88].FilingBook       ;
		self.Liens88_FilingPage   := ri.LnJliens[88].FilingPage       ;
		self.Liens88_Agency       := ri.LnJliens[88].Agency           ;
		self.Liens88_AgencyCounty := ri.LnJliens[88].AgencyCounty     ;
		self.Liens88_AgencyState  := ri.LnJliens[88].AgencyState      ;
		self.Liens88_ConsumerStatementId	:= SetCSID(ri.LnJliens[88].ConsumerStatementId);
    self.Liens88_orig_rmsid       := ri.LnJliens[88].orig_rmsid;
		self.Liens89_Seq          := ri.LnJliens[89].Seq              ;
		self.Liens89_DateFiled    := ri.LnJliens[89].DateFiled        ;
  self.Liens89_LienTypeID   := ri.LnJliens[89].LienTypeID;
		self.Liens89_LienType     := ri.LnJliens[89].LienType         ;
		self.Liens89_Amount       := ri.LnJliens[89].Amount           ;
		self.Liens89_ReleaseDate  := ri.LnJliens[89].ReleaseDate      ;
		self.Liens89_DateLastSeen := ri.LnJliens[89].DateLastSeen     ;
		self.Liens89_FilingNumber := ri.LnJliens[89].FilingNumber     ;
		self.Liens89_FilingBook   := ri.LnJliens[89].FilingBook       ;
		self.Liens89_FilingPage   := ri.LnJliens[89].FilingPage       ;
		self.Liens89_Agency       := ri.LnJliens[89].Agency           ;
		self.Liens89_AgencyCounty := ri.LnJliens[89].AgencyCounty     ;
		self.Liens89_AgencyState  := ri.LnJliens[89].AgencyState      ;
		self.Liens89_ConsumerStatementId	:= SetCSID(ri.LnJliens[89].ConsumerStatementId);
    self.Liens89_orig_rmsid       := ri.LnJliens[89].orig_rmsid;
		self.Liens90_Seq          := ri.LnJliens[90].Seq             ;
		self.Liens90_DateFiled    := ri.LnJliens[90].DateFiled       ;
  self.Liens90_LienTypeID   := ri.LnJliens[90].LienTypeID;
		self.Liens90_LienType     := ri.LnJliens[90].LienType        ;
		self.Liens90_Amount       := ri.LnJliens[90].Amount          ;
		self.Liens90_ReleaseDate  := ri.LnJliens[90].ReleaseDate     ;
		self.Liens90_DateLastSeen := ri.LnJliens[90].DateLastSeen    ;
		self.Liens90_FilingNumber := ri.LnJliens[90].FilingNumber    ;
		self.Liens90_FilingBook   := ri.LnJliens[90].FilingBook      ;
		self.Liens90_FilingPage   := ri.LnJliens[90].FilingPage      ;
		self.Liens90_Agency       := ri.LnJliens[90].Agency          ;
		self.Liens90_AgencyCounty := ri.LnJliens[90].AgencyCounty    ;
		self.Liens90_AgencyState  := ri.LnJliens[90].AgencyState     ;
		self.Liens90_ConsumerStatementId	:= SetCSID(ri.LnJliens[90].ConsumerStatementId);
    self.Liens90_orig_rmsid       := ri.LnJliens[90].orig_rmsid;
				self.Liens91_Seq          := ri.LnJliens[91].Seq;
		self.Liens91_DateFiled    := ri.LnJliens[91].DateFiled;
  self.Liens91_LienTypeID   := ri.LnJliens[91].LienTypeID;
		self.Liens91_LienType     := ri.LnJliens[91].LienType;
		self.Liens91_Amount       := ri.LnJliens[91].Amount;
		self.Liens91_ReleaseDate  := ri.LnJliens[91].ReleaseDate;
		self.Liens91_DateLastSeen := ri.LnJliens[91].DateLastSeen;
		self.Liens91_FilingNumber := ri.LnJliens[91].FilingNumber;
		self.Liens91_FilingBook   := ri.LnJliens[91].FilingBook;
		self.Liens91_FilingPage   := ri.LnJliens[91].FilingPage;
		self.Liens91_Agency       := ri.LnJliens[91].Agency ;
		self.Liens91_AgencyCounty := ri.LnJliens[91].AgencyCounty;
		self.Liens91_AgencyState  := ri.LnJliens[91].AgencyState;
		self.Liens91_ConsumerStatementId	:= SetCSID(ri.LnJliens[91].ConsumerStatementId);
    self.Liens91_orig_rmsid       := ri.LnJliens[91].orig_rmsid;
		self.Liens92_Seq          := ri.LnJliens[92].Seq;
		self.Liens92_DateFiled    := ri.LnJliens[92].DateFiled;
  self.Liens92_LienTypeID   := ri.LnJliens[92].LienTypeID;
		self.Liens92_LienType     := ri.LnJliens[92].LienType;
		self.Liens92_Amount       := ri.LnJliens[92].Amount;
		self.Liens92_ReleaseDate  := ri.LnJliens[92].ReleaseDate;
		self.Liens92_DateLastSeen := ri.LnJliens[92].DateLastSeen;
		self.Liens92_FilingNumber := ri.LnJliens[92].FilingNumber;
		self.Liens92_FilingBook   := ri.LnJliens[92].FilingBook;
		self.Liens92_FilingPage   := ri.LnJliens[92].FilingPage;
		self.Liens92_Agency       := ri.LnJliens[92].Agency; 
		self.Liens92_AgencyCounty := ri.LnJliens[92].AgencyCounty;
		self.Liens92_AgencyState  := ri.LnJliens[92].AgencyState;
		self.Liens92_ConsumerStatementId	:= SetCSID(ri.LnJliens[92].ConsumerStatementId);
    self.Liens92_orig_rmsid       := ri.LnJliens[92].orig_rmsid;
		self.Liens93_Seq          := ri.LnJliens[93].Seq;
		self.Liens93_DateFiled    := ri.LnJliens[93].DateFiled;
  self.Liens93_LienTypeID   := ri.LnJliens[93].LienTypeID;
		self.Liens93_LienType     := ri.LnJliens[93].LienType;
		self.Liens93_Amount       := ri.LnJliens[93].Amount;
		self.Liens93_ReleaseDate  := ri.LnJliens[93].ReleaseDate;
		self.Liens93_DateLastSeen := ri.LnJliens[93].DateLastSeen;
		self.Liens93_FilingNumber := ri.LnJliens[93].FilingNumber;
		self.Liens93_FilingBook   := ri.LnJliens[93].FilingBook;
		self.Liens93_FilingPage   := ri.LnJliens[93].FilingPage; 
		self.Liens93_Agency       := ri.LnJliens[93].Agency; 
		self.Liens93_AgencyCounty := ri.LnJliens[93].AgencyCounty;
		self.Liens93_AgencyState  := ri.LnJliens[93].AgencyState;
		self.Liens93_ConsumerStatementId	:= SetCSID(ri.LnJliens[93].ConsumerStatementId);
    self.Liens93_orig_rmsid       := ri.LnJliens[93].orig_rmsid;
		self.Liens94_Seq          := ri.LnJliens[94].Seq;
		self.Liens94_DateFiled    := ri.LnJliens[94].DateFiled;
  self.Liens94_LienTypeID   := ri.LnJliens[94].LienTypeID;
		self.Liens94_LienType     := ri.LnJliens[94].LienType;
		self.Liens94_Amount       := ri.LnJliens[94].Amount;
		self.Liens94_ReleaseDate  := ri.LnJliens[94].ReleaseDate;
		self.Liens94_DateLastSeen := ri.LnJliens[94].DateLastSeen;
		self.Liens94_FilingNumber := ri.LnJliens[94].FilingNumber;
		self.Liens94_FilingBook   := ri.LnJliens[94].FilingBook;
		self.Liens94_FilingPage   := ri.LnJliens[94].FilingPage; 
		self.Liens94_Agency       := ri.LnJliens[94].Agency; 
		self.Liens94_AgencyCounty := ri.LnJliens[94].AgencyCounty;
		self.Liens94_AgencyState  := ri.LnJliens[94].AgencyState;
		self.Liens94_ConsumerStatementId	:= SetCSID(ri.LnJliens[94].ConsumerStatementId);
		self.Liens94_orig_rmsid       := ri.LnJliens[94].orig_rmsid;
		self.Liens95_Seq          := ri.LnJliens[95].Seq              ;
		self.Liens95_DateFiled    := ri.LnJliens[95].DateFiled        ;
  self.Liens95_LienTypeID   := ri.LnJliens[95].LienTypeID;
		self.Liens95_LienType     := ri.LnJliens[95].LienType         ;
		self.Liens95_Amount       := ri.LnJliens[95].Amount           ;
		self.Liens95_ReleaseDate  := ri.LnJliens[95].ReleaseDate      ;
		self.Liens95_DateLastSeen := ri.LnJliens[95].DateLastSeen     ;
		self.Liens95_FilingNumber := ri.LnJliens[95].FilingNumber     ;
		self.Liens95_FilingBook   := ri.LnJliens[95].FilingBook       ;
		self.Liens95_FilingPage   := ri.LnJliens[95].FilingPage       ;
		self.Liens95_Agency       := ri.LnJliens[95].Agency           ;
		self.Liens95_AgencyCounty := ri.LnJliens[95].AgencyCounty     ;
		self.Liens95_AgencyState  := ri.LnJliens[95].AgencyState      ;
		self.Liens95_ConsumerStatementId	:= SetCSID(ri.LnJliens[95].ConsumerStatementId);
    self.Liens95_orig_rmsid       := ri.LnJliens[95].orig_rmsid;
		self.Liens96_Seq          := ri.LnJliens[96].Seq              ;
		self.Liens96_DateFiled    := ri.LnJliens[96].DateFiled        ;
  self.Liens96_LienTypeID   := ri.LnJliens[96].LienTypeID;
		self.Liens96_LienType     := ri.LnJliens[96].LienType         ;
		self.Liens96_Amount       := ri.LnJliens[96].Amount           ;
		self.Liens96_ReleaseDate  := ri.LnJliens[96].ReleaseDate      ;
		self.Liens96_DateLastSeen := ri.LnJliens[96].DateLastSeen     ;
		self.Liens96_FilingNumber := ri.LnJliens[96].FilingNumber     ;
		self.Liens96_FilingBook   := ri.LnJliens[96].FilingBook       ;
		self.Liens96_FilingPage   := ri.LnJliens[96].FilingPage       ;
		self.Liens96_Agency       := ri.LnJliens[96].Agency           ;
		self.Liens96_AgencyCounty := ri.LnJliens[96].AgencyCounty     ;
		self.Liens96_AgencyState  := ri.LnJliens[96].AgencyState      ;
		self.Liens96_ConsumerStatementId	:= SetCSID(ri.LnJliens[96].ConsumerStatementId);
    self.Liens96_orig_rmsid       := ri.LnJliens[96].orig_rmsid;
		self.Liens97_Seq          := ri.LnJliens[97].Seq              ;
		self.Liens97_DateFiled    := ri.LnJliens[97].DateFiled        ;
  self.Liens97_LienTypeID   := ri.LnJliens[97].LienTypeID;
		self.Liens97_LienType     := ri.LnJliens[97].LienType         ;
		self.Liens97_Amount       := ri.LnJliens[97].Amount           ;
		self.Liens97_ReleaseDate  := ri.LnJliens[97].ReleaseDate      ;
		self.Liens97_DateLastSeen := ri.LnJliens[97].DateLastSeen     ;
		self.Liens97_FilingNumber := ri.LnJliens[97].FilingNumber     ;
		self.Liens97_FilingBook   := ri.LnJliens[97].FilingBook       ;
		self.Liens97_FilingPage   := ri.LnJliens[97].FilingPage       ;
		self.Liens97_Agency       := ri.LnJliens[97].Agency           ;
		self.Liens97_AgencyCounty := ri.LnJliens[97].AgencyCounty     ;
		self.Liens97_AgencyState  := ri.LnJliens[97].AgencyState      ;
		self.Liens97_ConsumerStatementId	:= SetCSID(ri.LnJliens[97].ConsumerStatementId);
    self.Liens97_orig_rmsid       := ri.LnJliens[97].orig_rmsid;
		self.Liens98_Seq          := ri.LnJliens[98].Seq              ;
		self.Liens98_DateFiled    := ri.LnJliens[98].DateFiled        ;
  self.Liens98_LienTypeID   := ri.LnJliens[98].LienTypeID;
		self.Liens98_LienType     := ri.LnJliens[98].LienType         ;
		self.Liens98_Amount       := ri.LnJliens[98].Amount           ;
		self.Liens98_ReleaseDate  := ri.LnJliens[98].ReleaseDate      ;
		self.Liens98_DateLastSeen := ri.LnJliens[98].DateLastSeen     ;
		self.Liens98_FilingNumber := ri.LnJliens[98].FilingNumber     ;
		self.Liens98_FilingBook   := ri.LnJliens[98].FilingBook       ;
		self.Liens98_FilingPage   := ri.LnJliens[98].FilingPage       ;
		self.Liens98_Agency       := ri.LnJliens[98].Agency           ;
		self.Liens98_AgencyCounty := ri.LnJliens[98].AgencyCounty     ;
		self.Liens98_AgencyState  := ri.LnJliens[98].AgencyState      ;
		self.Liens98_ConsumerStatementId	:= SetCSID(ri.LnJliens[98].ConsumerStatementId);
    self.Liens98_orig_rmsid       := ri.LnJliens[98].orig_rmsid;
		self.Liens99_Seq          := ri.LnJliens[99].Seq              ;
		self.Liens99_DateFiled    := ri.LnJliens[99].DateFiled        ;
  self.Liens99_LienTypeID   := ri.LnJliens[99].LienTypeID;
		self.Liens99_LienType     := ri.LnJliens[99].LienType         ;
		self.Liens99_Amount       := ri.LnJliens[99].Amount           ;
		self.Liens99_ReleaseDate  := ri.LnJliens[99].ReleaseDate      ;
		self.Liens99_DateLastSeen := ri.LnJliens[99].DateLastSeen     ;
		self.Liens99_FilingNumber := ri.LnJliens[99].FilingNumber     ;
		self.Liens99_FilingBook   := ri.LnJliens[99].FilingBook       ;
		self.Liens99_FilingPage   := ri.LnJliens[99].FilingPage       ;
		self.Liens99_Agency       := ri.LnJliens[99].Agency           ;
		self.Liens99_AgencyCounty := ri.LnJliens[99].AgencyCounty     ;
		self.Liens99_AgencyState  := ri.LnJliens[99].AgencyState      ;
		self.Liens99_ConsumerStatementId	:= SetCSID(ri.LnJliens[99].ConsumerStatementId);
    self.Liens99_orig_rmsid       := ri.LnJliens[99].orig_rmsid;
//Jgmts
		self.Jgmts1_Seq          := ri.LnJJudgments[1].Seq;
		self.Jgmts1_DateFiled    := ri.LnJJudgments[1].DateFiled;
  self.Jgmts1_JudgmentTypeID := ri.LnJJudgments[1].JudgmentTypeID;
		self.Jgmts1_JudgmentType     := ri.LnJJudgments[1].JudgmentType;
		self.Jgmts1_Amount       := ri.LnJJudgments[1].Amount;
		self.Jgmts1_ReleaseDate  := ri.LnJJudgments[1].ReleaseDate;
		self.Jgmts1_FilingDescription  := ri.LnJJudgments[1].FilingDescription;
		self.Jgmts1_DateLastSeen := ri.LnJJudgments[1].DateLastSeen;
		self.Jgmts1_Defendant    := ri.LnJJudgments[1].Defendant;
		self.Jgmts1_Plaintiff    := ri.LnJJudgments[1].Plaintiff;
		self.Jgmts1_FilingNumber := ri.LnJJudgments[1].FilingNumber;
		self.Jgmts1_FilingBook   := ri.LnJJudgments[1].FilingBook;
		self.Jgmts1_FilingPage   := ri.LnJJudgments[1].FilingPage;
		self.Jgmts1_Eviction     := ri.LnJJudgments[1].Eviction;
		self.Jgmts1_Agency       := ri.LnJJudgments[1].Agency ;
		self.Jgmts1_AgencyCounty := ri.LnJJudgments[1].AgencyCounty;
		self.Jgmts1_AgencyState	:= ri.LnJJudgments[1].AgencyState;
		self.Jgmts1_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[1].ConsumerStatementId);
    self.Jgmts1_orig_rmsid       := ri.LnJJudgments[1].orig_rmsid;
		self.Jgmts2_Seq          := ri.LnJJudgments[2].Seq;
		self.Jgmts2_DateFiled    := ri.LnJJudgments[2].DateFiled;
  self.Jgmts2_JudgmentTypeID := ri.LnJJudgments[2].JudgmentTypeID;
		self.Jgmts2_JudgmentType     := ri.LnJJudgments[2].JudgmentType;
		self.Jgmts2_Amount       := ri.LnJJudgments[2].Amount;
		self.Jgmts2_ReleaseDate  := ri.LnJJudgments[2].ReleaseDate;
		self.Jgmts2_FilingDescription  := ri.LnJJudgments[2].FilingDescription;
		self.Jgmts2_DateLastSeen := ri.LnJJudgments[2].DateLastSeen;
		self.Jgmts2_Defendant    := ri.LnJJudgments[2].Defendant;
		self.Jgmts2_Plaintiff    := ri.LnJJudgments[2].Plaintiff;
		self.Jgmts2_FilingNumber := ri.LnJJudgments[2].FilingNumber;
		self.Jgmts2_FilingBook   := ri.LnJJudgments[2].FilingBook;
		self.Jgmts2_FilingPage   := ri.LnJJudgments[2].FilingPage;
		self.Jgmts2_Eviction     := ri.LnJJudgments[2].Eviction; 
		self.Jgmts2_Agency       := ri.LnJJudgments[2].Agency; 
		self.Jgmts2_AgencyCounty := ri.LnJJudgments[2].AgencyCounty;
		self.Jgmts2_AgencyState	:= ri.LnJJudgments[2].AgencyState;
		self.Jgmts2_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[2].ConsumerStatementId);
    self.Jgmts2_orig_rmsid       := ri.LnJJudgments[2].orig_rmsid;
		self.Jgmts3_Seq          := ri.LnJJudgments[3].Seq;
		self.Jgmts3_DateFiled    := ri.LnJJudgments[3].DateFiled;
  self.Jgmts3_JudgmentTypeID := ri.LnJJudgments[3].JudgmentTypeID;
		self.Jgmts3_JudgmentType     := ri.LnJJudgments[3].JudgmentType;
		self.Jgmts3_Amount       := ri.LnJJudgments[3].Amount;
		self.Jgmts3_ReleaseDate  := ri.LnJJudgments[3].ReleaseDate;
		self.Jgmts3_FilingDescription  := ri.LnJJudgments[3].FilingDescription;
		self.Jgmts3_DateLastSeen := ri.LnJJudgments[3].DateLastSeen;
		self.Jgmts3_Defendant    := ri.LnJJudgments[3].Defendant; 
		self.Jgmts3_Plaintiff    := ri.LnJJudgments[3].Plaintiff;
		self.Jgmts3_FilingNumber := ri.LnJJudgments[3].FilingNumber;
		self.Jgmts3_FilingBook   := ri.LnJJudgments[3].FilingBook;
		self.Jgmts3_FilingPage   := ri.LnJJudgments[3].FilingPage;
		self.Jgmts3_Eviction     := ri.LnJJudgments[3].Eviction;
		self.Jgmts3_Agency       := ri.LnJJudgments[3].Agency; 
		self.Jgmts3_AgencyCounty := ri.LnJJudgments[3].AgencyCounty;
		self.Jgmts3_AgencyState	:= ri.LnJJudgments[3].AgencyState;
		self.Jgmts3_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[3].ConsumerStatementId);
    self.Jgmts3_orig_rmsid       := ri.LnJJudgments[3].orig_rmsid;
		self.Jgmts4_Seq          := ri.LnJJudgments[4].Seq;
		self.Jgmts4_DateFiled    := ri.LnJJudgments[4].DateFiled;
  self.Jgmts4_JudgmentTypeID := ri.LnJJudgments[4].JudgmentTypeID;
		self.Jgmts4_JudgmentType     := ri.LnJJudgments[4].JudgmentType;
		self.Jgmts4_Amount       := ri.LnJJudgments[4].Amount;
		self.Jgmts4_ReleaseDate  := ri.LnJJudgments[4].releaseDate;
		self.Jgmts4_FilingDescription  := ri.LnJJudgments[4].FilingDescription;
		self.Jgmts4_DateLastSeen := ri.LnJJudgments[4].DateLastSeen;
		self.Jgmts4_Defendant    := ri.LnJJudgments[4].Defendant; 
		self.Jgmts4_Plaintiff    := ri.LnJJudgments[4].Plaintiff;
		self.Jgmts4_FilingNumber := ri.LnJJudgments[4].FilingNumber;
		self.Jgmts4_FilingBook   := ri.LnJJudgments[4].FilingBook;
		self.Jgmts4_FilingPage   := ri.LnJJudgments[4].FilingPage;
		self.Jgmts4_Eviction     := ri.LnJJudgments[4].Eviction;
		self.Jgmts4_Agency       := ri.LnJJudgments[4].Agency; 
		self.Jgmts4_AgencyCounty := ri.LnJJudgments[4].AgencyCounty;
		self.Jgmts4_AgencyState	:= ri.LnJJudgments[4].AgencyState;
		self.Jgmts4_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[4].ConsumerStatementId);
		self.Jgmts4_orig_rmsid       := ri.LnJJudgments[4].orig_rmsid;
		self.Jgmts5_Seq          := ri.LnJJudgments[5].Seq              ;
		self.Jgmts5_DateFiled    := ri.LnJJudgments[5].DateFiled        ;
  self.Jgmts5_JudgmentTypeID := ri.LnJJudgments[5].JudgmentTypeID;
		self.Jgmts5_JudgmentType     := ri.LnJJudgments[5].JudgmentType         ;
		self.Jgmts5_Amount       := ri.LnJJudgments[5].Amount           ;
		self.Jgmts5_ReleaseDate  := ri.LnJJudgments[5].ReleaseDate      ;
		self.Jgmts5_FilingDescription  := ri.LnJJudgments[5].FilingDescription;
		self.Jgmts5_DateLastSeen := ri.LnJJudgments[5].DateLastSeen     ;
		self.Jgmts5_Defendant    := ri.LnJJudgments[5].Defendant; 
		self.Jgmts5_Plaintiff    := ri.LnJJudgments[5].Plaintiff;
		self.Jgmts5_FilingNumber := ri.LnJJudgments[5].FilingNumber     ;
		self.Jgmts5_FilingBook   := ri.LnJJudgments[5].FilingBook       ;
		self.Jgmts5_FilingPage   := ri.LnJJudgments[5].FilingPage       ;
		self.Jgmts5_Eviction     := ri.LnJJudgments[5].Eviction;
		self.Jgmts5_Agency       := ri.LnJJudgments[5].Agency           ;
		self.Jgmts5_AgencyCounty := ri.LnJJudgments[5].AgencyCounty     ;
		self.Jgmts5_AgencyState  := ri.LnJJudgments[5].AgencyState      ;
		self.Jgmts5_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[5].ConsumerStatementId);
    self.Jgmts5_orig_rmsid       := ri.LnJJudgments[5].orig_rmsid;
		self.Jgmts6_Seq          := ri.LnJJudgments[6].Seq              ;
		self.Jgmts6_DateFiled    := ri.LnJJudgments[6].DateFiled        ;
  self.Jgmts6_JudgmentTypeID := ri.LnJJudgments[6].JudgmentTypeID;
		self.Jgmts6_JudgmentType     := ri.LnJJudgments[6].JudgmentType         ;
		self.Jgmts6_Amount       := ri.LnJJudgments[6].Amount           ;
		self.Jgmts6_ReleaseDate  := ri.LnJJudgments[6].ReleaseDate      ;
		self.Jgmts6_FilingDescription  := ri.LnJJudgments[6].FilingDescription;
		self.Jgmts6_DateLastSeen := ri.LnJJudgments[6].DateLastSeen     ;
		self.Jgmts6_Defendant    := ri.LnJJudgments[6].Defendant; 
		self.Jgmts6_Plaintiff    := ri.LnJJudgments[6].Plaintiff;
		self.Jgmts6_FilingNumber := ri.LnJJudgments[6].FilingNumber     ;
		self.Jgmts6_FilingBook   := ri.LnJJudgments[6].FilingBook       ;
		self.Jgmts6_FilingPage   := ri.LnJJudgments[6].FilingPage       ;
		self.Jgmts6_Eviction     := ri.LnJJudgments[6].Eviction;
		self.Jgmts6_Agency       := ri.LnJJudgments[6].Agency           ;
		self.Jgmts6_AgencyCounty := ri.LnJJudgments[6].AgencyCounty     ;
		self.Jgmts6_AgencyState  := ri.LnJJudgments[6].AgencyState      ;
		self.Jgmts6_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[6].ConsumerStatementId);
    self.Jgmts6_orig_rmsid       := ri.LnJJudgments[6].orig_rmsid;
		self.Jgmts7_Seq          := ri.LnJJudgments[7].Seq              ;
		self.Jgmts7_DateFiled    := ri.LnJJudgments[7].DateFiled        ;
  self.Jgmts7_JudgmentTypeID := ri.LnJJudgments[7].JudgmentTypeID;
		self.Jgmts7_JudgmentType     := ri.LnJJudgments[7].JudgmentType         ;
		self.Jgmts7_Amount       := ri.LnJJudgments[7].Amount           ;
		self.Jgmts7_ReleaseDate  := ri.LnJJudgments[7].ReleaseDate      ;
		self.Jgmts7_FilingDescription  := ri.LnJJudgments[7].FilingDescription;
		self.Jgmts7_DateLastSeen := ri.LnJJudgments[7].DateLastSeen     ;
		self.Jgmts7_Defendant    := ri.LnJJudgments[7].Defendant; 
		self.Jgmts7_Plaintiff    := ri.LnJJudgments[7].Plaintiff;
		self.Jgmts7_FilingNumber := ri.LnJJudgments[7].FilingNumber     ;
		self.Jgmts7_FilingBook   := ri.LnJJudgments[7].FilingBook       ;
		self.Jgmts7_FilingPage   := ri.LnJJudgments[7].FilingPage       ;
		self.Jgmts7_Eviction     := ri.LnJJudgments[7].Eviction;
		self.Jgmts7_Agency       := ri.LnJJudgments[7].Agency           ;
		self.Jgmts7_AgencyCounty := ri.LnJJudgments[7].AgencyCounty     ;
		self.Jgmts7_AgencyState  := ri.LnJJudgments[7].AgencyState      ;
		self.Jgmts7_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[7].ConsumerStatementId);
    self.Jgmts7_orig_rmsid       := ri.LnJJudgments[7].orig_rmsid;
		self.Jgmts8_Seq          := ri.LnJJudgments[8].Seq              ;
		self.Jgmts8_DateFiled    := ri.LnJJudgments[8].DateFiled        ;
  self.Jgmts8_JudgmentTypeID := ri.LnJJudgments[8].JudgmentTypeID;
		self.Jgmts8_JudgmentType     := ri.LnJJudgments[8].JudgmentType         ;
		self.Jgmts8_Amount       := ri.LnJJudgments[8].Amount           ;
		self.Jgmts8_ReleaseDate  := ri.LnJJudgments[8].ReleaseDate      ;
		self.Jgmts8_FilingDescription  := ri.LnJJudgments[8].FilingDescription;
		self.Jgmts8_DateLastSeen := ri.LnJJudgments[8].DateLastSeen     ;
		self.Jgmts8_Defendant    := ri.LnJJudgments[8].Defendant; 
		self.Jgmts8_Plaintiff    := ri.LnJJudgments[8].Plaintiff;
		self.Jgmts8_FilingNumber := ri.LnJJudgments[8].FilingNumber     ;
		self.Jgmts8_FilingBook   := ri.LnJJudgments[8].FilingBook       ;
		self.Jgmts8_FilingPage   := ri.LnJJudgments[8].FilingPage       ;
		self.Jgmts8_Eviction     := ri.LnJJudgments[8].Eviction;
		self.Jgmts8_Agency       := ri.LnJJudgments[8].Agency           ;
		self.Jgmts8_AgencyCounty := ri.LnJJudgments[8].AgencyCounty     ;
		self.Jgmts8_AgencyState  := ri.LnJJudgments[8].AgencyState      ;
		self.Jgmts8_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[8].ConsumerStatementId);
    self.Jgmts8_orig_rmsid       := ri.LnJJudgments[8].orig_rmsid;
		self.Jgmts9_Seq          := ri.LnJJudgments[9].Seq              ;
		self.Jgmts9_DateFiled    := ri.LnJJudgments[9].DateFiled        ;
  self.Jgmts9_JudgmentTypeID := ri.LnJJudgments[9].JudgmentTypeID;
		self.Jgmts9_JudgmentType     := ri.LnJJudgments[9].JudgmentType         ;
		self.Jgmts9_Amount       := ri.LnJJudgments[9].Amount           ;
		self.Jgmts9_ReleaseDate  := ri.LnJJudgments[9].ReleaseDate      ;
		self.Jgmts9_FilingDescription  := ri.LnJJudgments[9].FilingDescription;
		self.Jgmts9_DateLastSeen := ri.LnJJudgments[9].DateLastSeen     ;
		self.Jgmts9_Defendant    := ri.LnJJudgments[9].Defendant; 
		self.Jgmts9_Plaintiff    := ri.LnJJudgments[9].Plaintiff;
		self.Jgmts9_FilingNumber := ri.LnJJudgments[9].FilingNumber     ;
		self.Jgmts9_FilingBook   := ri.LnJJudgments[9].FilingBook       ;
		self.Jgmts9_FilingPage   := ri.LnJJudgments[9].FilingPage       ;
		self.Jgmts9_Eviction     := ri.LnJJudgments[9].Eviction;
		self.Jgmts9_Agency       := ri.LnJJudgments[9].Agency           ;
		self.Jgmts9_AgencyCounty := ri.LnJJudgments[9].AgencyCounty     ;
		self.Jgmts9_AgencyState  := ri.LnJJudgments[9].AgencyState      ;
		self.Jgmts9_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[9].ConsumerStatementId);
    self.Jgmts9_orig_rmsid       := ri.LnJJudgments[9].orig_rmsid;
		self.Jgmts10_Seq          := ri.LnJJudgments[10].Seq             ;
		self.Jgmts10_DateFiled    := ri.LnJJudgments[10].DateFiled       ;
  self.Jgmts10_JudgmentTypeID := ri.LnJJudgments[10].JudgmentTypeID;
		self.Jgmts10_JudgmentType     := ri.LnJJudgments[10].JudgmentType        ;
		self.Jgmts10_Amount       := ri.LnJJudgments[10].Amount          ;
		self.Jgmts10_ReleaseDate  := ri.LnJJudgments[10].ReleaseDate     ;
		self.Jgmts10_FilingDescription  := ri.LnJJudgments[10].FilingDescription;
		self.Jgmts10_DateLastSeen := ri.LnJJudgments[10].DateLastSeen    ;
		self.Jgmts10_Defendant    := ri.LnJJudgments[10].Defendant; 
		self.Jgmts10_Plaintiff    := ri.LnJJudgments[10].Plaintiff;
		self.Jgmts10_FilingNumber := ri.LnJJudgments[10].FilingNumber    ;
		self.Jgmts10_FilingBook   := ri.LnJJudgments[10].FilingBook      ;
		self.Jgmts10_FilingPage   := ri.LnJJudgments[10].FilingPage      ;
		self.Jgmts10_Eviction     := ri.LnJJudgments[10].Eviction;
		self.Jgmts10_Agency       := ri.LnJJudgments[10].Agency          ;
		self.Jgmts10_AgencyCounty := ri.LnJJudgments[10].AgencyCounty    ;
		self.Jgmts10_AgencyState  := ri.LnJJudgments[10].AgencyState     ;
		self.Jgmts10_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[10].ConsumerStatementId);
    self.Jgmts10_orig_rmsid       := ri.LnJJudgments[10].orig_rmsid;
		self.Jgmts11_Seq          := ri.LnJJudgments[11].Seq;
		self.Jgmts11_DateFiled    := ri.LnJJudgments[11].DateFiled;
  self.Jgmts11_JudgmentTypeID := ri.LnJJudgments[11].JudgmentTypeID;
		self.Jgmts11_JudgmentType     := ri.LnJJudgments[11].JudgmentType;
		self.Jgmts11_Amount       := ri.LnJJudgments[11].Amount;
		self.Jgmts11_ReleaseDate  := ri.LnJJudgments[11].ReleaseDate ; 
		self.Jgmts11_FilingDescription  := ri.LnJJudgments[11].FilingDescription;
		self.Jgmts11_DateLastSeen := ri.LnJJudgments[11].DateLastSeen;
		self.Jgmts11_Defendant    := ri.LnJJudgments[11].Defendant;
		self.Jgmts11_Plaintiff    := ri.LnJJudgments[11].Plaintiff;
		self.Jgmts11_FilingNumber := ri.LnJJudgments[11].FilingNumber;
		self.Jgmts11_FilingBook   := ri.LnJJudgments[11].FilingBook;
		self.Jgmts11_FilingPage   := ri.LnJJudgments[11].FilingPage;
		self.Jgmts11_Eviction     := ri.LnJJudgments[11].Eviction;
		self.Jgmts11_Agency       := ri.LnJJudgments[11].Agency ;
		self.Jgmts11_AgencyCounty := ri.LnJJudgments[11].AgencyCounty;
		self.Jgmts11_AgencyState	 := ri.LnJJudgments[11].AgencyState;
		self.Jgmts11_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[11].ConsumerStatementId);
    self.Jgmts11_orig_rmsid       := ri.LnJJudgments[11].orig_rmsid;
		self.Jgmts12_Seq          := ri.LnJJudgments[12].Seq;
		self.Jgmts12_DateFiled    := ri.LnJJudgments[12].DateFiled;
  self.Jgmts12_JudgmentTypeID := ri.LnJJudgments[12].JudgmentTypeID;
		self.Jgmts12_JudgmentType     := ri.LnJJudgments[12].JudgmentType;
		self.Jgmts12_Amount       := ri.LnJJudgments[12].Amount;
		self.Jgmts12_ReleaseDate  := ri.LnJJudgments[12].ReleaseDate ;  
		self.Jgmts12_FilingDescription  := ri.LnJJudgments[12].FilingDescription;
		self.Jgmts12_DateLastSeen := ri.LnJJudgments[12].DateLastSeen;
		self.Jgmts12_Defendant    := ri.LnJJudgments[12].Defendant;
		self.Jgmts12_Plaintiff    := ri.LnJJudgments[12].Plaintiff;
		self.Jgmts12_FilingNumber := ri.LnJJudgments[12].FilingNumber;
		self.Jgmts12_FilingBook   := ri.LnJJudgments[12].FilingBook;
		self.Jgmts12_FilingPage   := ri.LnJJudgments[12].FilingPage;
		self.Jgmts12_Eviction     := ri.LnJJudgments[12].Eviction; 
		self.Jgmts12_Agency       := ri.LnJJudgments[12].Agency; 
		self.Jgmts12_AgencyCounty := ri.LnJJudgments[12].AgencyCounty;
		self.Jgmts12_AgencyState	 := ri.LnJJudgments[12].AgencyState;
		self.Jgmts12_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[12].ConsumerStatementId);
    self.Jgmts12_orig_rmsid       := ri.LnJJudgments[12].orig_rmsid;
		self.Jgmts13_Seq          := ri.LnJJudgments[13].Seq;
		self.Jgmts13_DateFiled    := ri.LnJJudgments[13].DateFiled;
  self.Jgmts13_JudgmentTypeID := ri.LnJJudgments[13].JudgmentTypeID;
		self.Jgmts13_JudgmentType     := ri.LnJJudgments[13].JudgmentType;
		self.Jgmts13_Amount       := ri.LnJJudgments[13].Amount;
		self.Jgmts13_ReleaseDate  := ri.LnJJudgments[13].ReleaseDate ;
		self.Jgmts13_FilingDescription  := ri.LnJJudgments[13].FilingDescription;
		self.Jgmts13_DateLastSeen := ri.LnJJudgments[13].DateLastSeen;
		self.Jgmts13_Defendant    := ri.LnJJudgments[13].Defendant;
		self.Jgmts13_Plaintiff    := ri.LnJJudgments[13].Plaintiff;
		self.Jgmts13_FilingNumber := ri.LnJJudgments[13].FilingNumber;
		self.Jgmts13_FilingBook   := ri.LnJJudgments[13].FilingBook;
		self.Jgmts13_FilingPage   := ri.LnJJudgments[13].FilingPage;
		self.Jgmts13_Eviction     := ri.LnJJudgments[13].Eviction;
		self.Jgmts13_Agency       := ri.LnJJudgments[13].Agency; 
		self.Jgmts13_AgencyCounty := ri.LnJJudgments[13].AgencyCounty;
		self.Jgmts13_AgencyState	 := ri.LnJJudgments[13].AgencyState;
		self.Jgmts13_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[13].ConsumerStatementId);
    self.Jgmts13_orig_rmsid       := ri.LnJJudgments[13].orig_rmsid;
		self.Jgmts14_Seq          := ri.LnJJudgments[14].Seq;
		self.Jgmts14_DateFiled    := ri.LnJJudgments[14].DateFiled;
  self.Jgmts14_JudgmentTypeID := ri.LnJJudgments[14].JudgmentTypeID;
		self.Jgmts14_JudgmentType     := ri.LnJJudgments[14].JudgmentType;
		self.Jgmts14_Amount       := ri.LnJJudgments[14].Amount;
		self.Jgmts14_ReleaseDate  := ri.LnJJudgments[14].ReleaseDate ; 
		self.Jgmts14_FilingDescription  := ri.LnJJudgments[14].FilingDescription;
		self.Jgmts14_DateLastSeen := ri.LnJJudgments[14].DateLastSeen;
		self.Jgmts14_Defendant    := ri.LnJJudgments[14].Defendant;
		self.Jgmts14_Plaintiff    := ri.LnJJudgments[14].Plaintiff;
		self.Jgmts14_FilingNumber := ri.LnJJudgments[14].FilingNumber;
		self.Jgmts14_FilingBook   := ri.LnJJudgments[14].FilingBook;
		self.Jgmts14_FilingPage   := ri.LnJJudgments[14].FilingPage;
		self.Jgmts14_Eviction     := ri.LnJJudgments[14].Eviction;
		self.Jgmts14_Agency       := ri.LnJJudgments[14].Agency;  
		self.Jgmts14_AgencyCounty := ri.LnJJudgments[14].AgencyCounty;
		self.Jgmts14_AgencyState	 := ri.LnJJudgments[14].AgencyState;	
		self.Jgmts14_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[14].ConsumerStatementId);
    self.Jgmts14_orig_rmsid       := ri.LnJJudgments[14].orig_rmsid;
		self.Jgmts15_Seq          := ri.LnJJudgments[15].Seq              ;
		self.Jgmts15_DateFiled    := ri.LnJJudgments[15].DateFiled        ;
  self.Jgmts15_JudgmentTypeID := ri.LnJJudgments[15].JudgmentTypeID;
		self.Jgmts15_JudgmentType     := ri.LnJJudgments[15].JudgmentType         ;
		self.Jgmts15_Amount       := ri.LnJJudgments[15].Amount           ;
		self.Jgmts15_ReleaseDate  := ri.LnJJudgments[15].ReleaseDate ; 
		self.Jgmts15_FilingDescription  := ri.LnJJudgments[15].FilingDescription;
		self.Jgmts15_DateLastSeen := ri.LnJJudgments[15].DateLastSeen;
		self.Jgmts15_Defendant    := ri.LnJJudgments[15].Defendant;
		self.Jgmts15_Plaintiff    := ri.LnJJudgments[15].Plaintiff;
		self.Jgmts15_FilingNumber := ri.LnJJudgments[15].FilingNumber     ;
		self.Jgmts15_FilingBook   := ri.LnJJudgments[15].FilingBook       ;
		self.Jgmts15_FilingPage   := ri.LnJJudgments[15].FilingPage;
		self.Jgmts15_Eviction     := ri.LnJJudgments[15].Eviction;
		self.Jgmts15_Agency       := ri.LnJJudgments[15].Agency           ;
		self.Jgmts15_AgencyCounty := ri.LnJJudgments[15].AgencyCounty     ;
		self.Jgmts15_AgencyState  := ri.LnJJudgments[15].AgencyState      ;
		self.Jgmts15_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[15].ConsumerStatementId);
    self.Jgmts15_orig_rmsid       := ri.LnJJudgments[15].orig_rmsid;
		self.Jgmts16_Seq          := ri.LnJJudgments[16].Seq              ;
		self.Jgmts16_DateFiled    := ri.LnJJudgments[16].DateFiled        ;
  self.Jgmts16_JudgmentTypeID := ri.LnJJudgments[16].JudgmentTypeID;
		self.Jgmts16_JudgmentType     := ri.LnJJudgments[16].JudgmentType         ;
		self.Jgmts16_Amount       := ri.LnJJudgments[16].Amount           ;
		self.Jgmts16_ReleaseDate  := ri.LnJJudgments[16].ReleaseDate ; 
		self.Jgmts16_FilingDescription  := ri.LnJJudgments[16].FilingDescription;
		self.Jgmts16_DateLastSeen := ri.LnJJudgments[16].DateLastSeen;
		self.Jgmts16_Defendant    := ri.LnJJudgments[16].Defendant;
		self.Jgmts16_Plaintiff    := ri.LnJJudgments[16].Plaintiff;
		self.Jgmts16_FilingNumber := ri.LnJJudgments[16].FilingNumber     ;
		self.Jgmts16_FilingBook   := ri.LnJJudgments[16].FilingBook       ;
		self.Jgmts16_FilingPage   := ri.LnJJudgments[16].FilingPage;
		self.Jgmts16_Eviction     := ri.LnJJudgments[16].Eviction;
    self.Jgmts16_Agency       := ri.LnJJudgments[16].Agency           ;
		self.Jgmts16_AgencyCounty := ri.LnJJudgments[16].AgencyCounty     ;
		self.Jgmts16_AgencyState  := ri.LnJJudgments[16].AgencyState      ;
		self.Jgmts16_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[16].ConsumerStatementId);
    self.Jgmts16_orig_rmsid       := ri.LnJJudgments[16].orig_rmsid;
		self.Jgmts17_Seq          := ri.LnJJudgments[17].Seq              ;
		self.Jgmts17_DateFiled    := ri.LnJJudgments[17].DateFiled        ;
  self.Jgmts17_JudgmentTypeID := ri.LnJJudgments[17].JudgmentTypeID;
		self.Jgmts17_JudgmentType     := ri.LnJJudgments[17].JudgmentType         ;
		self.Jgmts17_Amount       := ri.LnJJudgments[17].Amount           ;
		self.Jgmts17_ReleaseDate  := ri.LnJJudgments[17].ReleaseDate ; 
		self.Jgmts17_FilingDescription  := ri.LnJJudgments[17].FilingDescription;
		self.Jgmts17_DateLastSeen := ri.LnJJudgments[17].DateLastSeen;
		self.Jgmts17_Defendant    := ri.LnJJudgments[17].Defendant;
		self.Jgmts17_Plaintiff    := ri.LnJJudgments[17].Plaintiff;
		self.Jgmts17_FilingNumber := ri.LnJJudgments[17].FilingNumber     ;
		self.Jgmts17_FilingBook   := ri.LnJJudgments[17].FilingBook       ;
		self.Jgmts17_FilingPage   := ri.LnJJudgments[17].FilingPage;
		self.Jgmts17_Eviction     := ri.LnJJudgments[17].Eviction;
		self.Jgmts17_Agency       := ri.LnJJudgments[17].Agency           ;
		self.Jgmts17_AgencyCounty := ri.LnJJudgments[17].AgencyCounty     ;
		self.Jgmts17_AgencyState  := ri.LnJJudgments[17].AgencyState      ;
		self.Jgmts17_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[17].ConsumerStatementId);
    self.Jgmts17_orig_rmsid       := ri.LnJJudgments[17].orig_rmsid;
		self.Jgmts18_Seq          := ri.LnJJudgments[18].Seq              ;
		self.Jgmts18_DateFiled    := ri.LnJJudgments[18].DateFiled        ;
  self.Jgmts18_JudgmentTypeID := ri.LnJJudgments[18].JudgmentTypeID;
		self.Jgmts18_JudgmentType     := ri.LnJJudgments[18].JudgmentType         ;
		self.Jgmts18_Amount       := ri.LnJJudgments[18].Amount           ;
		self.Jgmts18_ReleaseDate  := ri.LnJJudgments[18].ReleaseDate ;
		self.Jgmts18_FilingDescription  := ri.LnJJudgments[18].FilingDescription;
		self.Jgmts18_DateLastSeen := ri.LnJJudgments[18].DateLastSeen;
		self.Jgmts18_Defendant    := ri.LnJJudgments[18].Defendant;
		self.Jgmts18_Plaintiff    := ri.LnJJudgments[18].Plaintiff;
		self.Jgmts18_FilingNumber := ri.LnJJudgments[18].FilingNumber     ;
		self.Jgmts18_FilingBook   := ri.LnJJudgments[18].FilingBook       ;
		self.Jgmts18_FilingPage   := ri.LnJJudgments[18].FilingPage;
		self.Jgmts18_Eviction     := ri.LnJJudgments[18].Eviction;
		self.Jgmts18_Agency       := ri.LnJJudgments[18].Agency           ;
		self.Jgmts18_AgencyCounty := ri.LnJJudgments[18].AgencyCounty     ;
		self.Jgmts18_AgencyState  := ri.LnJJudgments[18].AgencyState      ;
		self.Jgmts18_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[18].ConsumerStatementId);
    self.Jgmts18_orig_rmsid       := ri.LnJJudgments[18].orig_rmsid;
		self.Jgmts19_Seq          := ri.LnJJudgments[19].Seq              ;
		self.Jgmts19_DateFiled    := ri.LnJJudgments[19].DateFiled        ;
  self.Jgmts19_JudgmentTypeID := ri.LnJJudgments[19].JudgmentTypeID;
		self.Jgmts19_JudgmentType     := ri.LnJJudgments[19].JudgmentType         ;
		self.Jgmts19_Amount       := ri.LnJJudgments[19].Amount           ;
		self.Jgmts19_ReleaseDate  := ri.LnJJudgments[19].ReleaseDate ; 
		self.Jgmts19_FilingDescription  := ri.LnJJudgments[19].FilingDescription;
		self.Jgmts19_DateLastSeen := ri.LnJJudgments[19].DateLastSeen;
		self.Jgmts19_Defendant    := ri.LnJJudgments[19].Defendant;
		self.Jgmts19_Plaintiff    := ri.LnJJudgments[19].Plaintiff;
		self.Jgmts19_FilingNumber := ri.LnJJudgments[19].FilingNumber     ;
		self.Jgmts19_FilingBook   := ri.LnJJudgments[19].FilingBook       ;
		self.Jgmts19_FilingPage   := ri.LnJJudgments[19].FilingPage;
		self.Jgmts19_Eviction     := ri.LnJJudgments[19].Eviction;
		self.Jgmts19_Agency       := ri.LnJJudgments[19].Agency           ;
		self.Jgmts19_AgencyCounty := ri.LnJJudgments[19].AgencyCounty     ;
		self.Jgmts19_AgencyState  := ri.LnJJudgments[19].AgencyState      ;
		self.Jgmts19_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[19].ConsumerStatementId);
    self.Jgmts19_orig_rmsid       := ri.LnJJudgments[19].orig_rmsid;
		self.Jgmts20_Seq          := ri.LnJJudgments[20].Seq             ;
		self.Jgmts20_DateFiled    := ri.LnJJudgments[20].DateFiled       ;
  self.Jgmts20_JudgmentTypeID := ri.LnJJudgments[20].JudgmentTypeID;
		self.Jgmts20_JudgmentType     := ri.LnJJudgments[20].JudgmentType        ;
		self.Jgmts20_Amount       := ri.LnJJudgments[20].Amount          ;
		self.Jgmts20_ReleaseDate  := ri.LnJJudgments[20].ReleaseDate ; 
		self.Jgmts20_FilingDescription  := ri.LnJJudgments[20].FilingDescription;
		self.Jgmts20_DateLastSeen := ri.LnJJudgments[20].DateLastSeen;
		self.Jgmts20_Defendant    := ri.LnJJudgments[20].Defendant;
		self.Jgmts20_Plaintiff    := ri.LnJJudgments[20].Plaintiff;
		self.Jgmts20_FilingNumber := ri.LnJJudgments[20].FilingNumber    ;
		self.Jgmts20_FilingBook   := ri.LnJJudgments[20].FilingBook      ;
		self.Jgmts20_FilingPage   := ri.LnJJudgments[20].FilingPage;
		self.Jgmts20_Eviction     := ri.LnJJudgments[20].Eviction;
		self.Jgmts20_Agency       := ri.LnJJudgments[20].Agency          ;
		self.Jgmts20_AgencyCounty := ri.LnJJudgments[20].AgencyCounty    ;
		self.Jgmts20_AgencyState  := ri.LnJJudgments[20].AgencyState     ;
		self.Jgmts20_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[20].ConsumerStatementId);
    self.Jgmts20_orig_rmsid       := ri.LnJJudgments[20].orig_rmsid;
		self.Jgmts21_Seq          := ri.LnJJudgments[21].Seq             ;
		self.Jgmts21_DateFiled    := ri.LnJJudgments[21].DateFiled       ;
  self.Jgmts21_JudgmentTypeID := ri.LnJJudgments[21].JudgmentTypeID;
		self.Jgmts21_JudgmentType     := ri.LnJJudgments[21].JudgmentType        ;
		self.Jgmts21_Amount       := ri.LnJJudgments[21].Amount          ;
		self.Jgmts21_ReleaseDate  := ri.LnJJudgments[21].ReleaseDate ; 
		self.Jgmts21_FilingDescription  := ri.LnJJudgments[21].FilingDescription;
		self.Jgmts21_DateLastSeen := ri.LnJJudgments[21].DateLastSeen;
		self.Jgmts21_Defendant    := ri.LnJJudgments[21].Defendant;
		self.Jgmts21_Plaintiff    := ri.LnJJudgments[21].Plaintiff;
		self.Jgmts21_FilingNumber := ri.LnJJudgments[21].FilingNumber    ;
		self.Jgmts21_FilingBook   := ri.LnJJudgments[21].FilingBook      ;
		self.Jgmts21_FilingPage   := ri.LnJJudgments[21].FilingPage;
		self.Jgmts21_Eviction     := ri.LnJJudgments[21].Eviction;
		self.Jgmts21_Agency       := ri.LnJJudgments[21].Agency          ;
		self.Jgmts21_AgencyCounty := ri.LnJJudgments[21].AgencyCounty    ;
		self.Jgmts21_AgencyState  := ri.LnJJudgments[21].AgencyState     ;
		self.Jgmts21_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[21].ConsumerStatementId);
    self.Jgmts21_orig_rmsid       := ri.LnJJudgments[21].orig_rmsid;
		self.Jgmts22_Seq          := ri.LnJJudgments[22].Seq             ;
		self.Jgmts22_DateFiled    := ri.LnJJudgments[22].DateFiled       ;
  self.Jgmts22_JudgmentTypeID := ri.LnJJudgments[22].JudgmentTypeID;
		self.Jgmts22_JudgmentType     := ri.LnJJudgments[22].JudgmentType        ;
		self.Jgmts22_Amount       := ri.LnJJudgments[22].Amount          ;
		self.Jgmts22_ReleaseDate  := ri.LnJJudgments[22].ReleaseDate ;
		self.Jgmts22_FilingDescription  := ri.LnJJudgments[22].FilingDescription;
		self.Jgmts22_DateLastSeen := ri.LnJJudgments[22].DateLastSeen;
		self.Jgmts22_Defendant    := ri.LnJJudgments[22].Defendant;
		self.Jgmts22_Plaintiff    := ri.LnJJudgments[22].Plaintiff;
		self.Jgmts22_FilingNumber := ri.LnJJudgments[22].FilingNumber    ;
		self.Jgmts22_FilingBook   := ri.LnJJudgments[22].FilingBook      ;
		self.Jgmts22_FilingPage   := ri.LnJJudgments[22].FilingPage;
		self.Jgmts22_Eviction     := ri.LnJJudgments[22].Eviction;
		self.Jgmts22_Agency       := ri.LnJJudgments[22].Agency          ;
		self.Jgmts22_AgencyCounty := ri.LnJJudgments[22].AgencyCounty    ;
		self.Jgmts22_AgencyState  := ri.LnJJudgments[22].AgencyState     ;
		self.Jgmts22_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[22].ConsumerStatementId);
    self.Jgmts22_orig_rmsid       := ri.LnJJudgments[22].orig_rmsid;
		self.Jgmts23_Seq          := ri.LnJJudgments[23].Seq             ;
		self.Jgmts23_DateFiled    := ri.LnJJudgments[23].DateFiled       ;
  self.Jgmts23_JudgmentTypeID := ri.LnJJudgments[23].JudgmentTypeID;
		self.Jgmts23_JudgmentType     := ri.LnJJudgments[23].JudgmentType        ;
		self.Jgmts23_Amount       := ri.LnJJudgments[23].Amount          ;
		self.Jgmts23_ReleaseDate  := ri.LnJJudgments[23].ReleaseDate ; 
		self.Jgmts23_FilingDescription  := ri.LnJJudgments[23].FilingDescription;
		self.Jgmts23_DateLastSeen := ri.LnJJudgments[23].DateLastSeen;
		self.Jgmts23_Defendant    := ri.LnJJudgments[23].Defendant;
		self.Jgmts23_Plaintiff    := ri.LnJJudgments[23].Plaintiff;
		self.Jgmts23_FilingNumber := ri.LnJJudgments[23].FilingNumber    ;
		self.Jgmts23_FilingBook   := ri.LnJJudgments[23].FilingBook      ;
		self.Jgmts23_FilingPage   := ri.LnJJudgments[23].FilingPage;
		self.Jgmts23_Eviction     := ri.LnJJudgments[23].Eviction;
		self.Jgmts23_Agency       := ri.LnJJudgments[23].Agency          ;
		self.Jgmts23_AgencyCounty := ri.LnJJudgments[23].AgencyCounty    ;
		self.Jgmts23_AgencyState  := ri.LnJJudgments[23].AgencyState     ;
		self.Jgmts23_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[23].ConsumerStatementId);
    self.Jgmts23_orig_rmsid       := ri.LnJJudgments[23].orig_rmsid;
		self.Jgmts24_Seq          := ri.LnJJudgments[24].Seq             ;
		self.Jgmts24_DateFiled    := ri.LnJJudgments[24].DateFiled       ;
  self.Jgmts24_JudgmentTypeID := ri.LnJJudgments[24].JudgmentTypeID;
		self.Jgmts24_JudgmentType     := ri.LnJJudgments[24].JudgmentType        ;
		self.Jgmts24_Amount       := ri.LnJJudgments[24].Amount          ;
		self.Jgmts24_ReleaseDate  := ri.LnJJudgments[24].ReleaseDate ; 
		self.Jgmts24_FilingDescription  := ri.LnJJudgments[24].FilingDescription;
		self.Jgmts24_DateLastSeen := ri.LnJJudgments[24].DateLastSeen;
		self.Jgmts24_Defendant    := ri.LnJJudgments[24].Defendant;
		self.Jgmts24_Plaintiff    := ri.LnJJudgments[24].Plaintiff;
		self.Jgmts24_FilingNumber := ri.LnJJudgments[24].FilingNumber    ;
		self.Jgmts24_FilingBook   := ri.LnJJudgments[24].FilingBook      ;
		self.Jgmts24_FilingPage   := ri.LnJJudgments[24].FilingPage;
		self.Jgmts24_Eviction     := ri.LnJJudgments[24].Eviction;
		self.Jgmts24_Agency       := ri.LnJJudgments[24].Agency          ;
		self.Jgmts24_AgencyCounty := ri.LnJJudgments[24].AgencyCounty    ;
		self.Jgmts24_AgencyState  := ri.LnJJudgments[24].AgencyState     ;
		self.Jgmts24_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[24].ConsumerStatementId);
    self.Jgmts24_orig_rmsid       := ri.LnJJudgments[24].orig_rmsid;
		self.Jgmts25_Seq          := ri.LnJJudgments[25].Seq             ;
		self.Jgmts25_DateFiled    := ri.LnJJudgments[25].DateFiled       ;
  self.Jgmts25_JudgmentTypeID := ri.LnJJudgments[25].JudgmentTypeID;
		self.Jgmts25_JudgmentType     := ri.LnJJudgments[25].JudgmentType        ;
		self.Jgmts25_Amount       := ri.LnJJudgments[25].Amount          ;
		self.Jgmts25_ReleaseDate  := ri.LnJJudgments[25].ReleaseDate ; 
		self.Jgmts25_FilingDescription  := ri.LnJJudgments[25].FilingDescription;
		self.Jgmts25_DateLastSeen := ri.LnJJudgments[25].DateLastSeen;
		self.Jgmts25_Defendant    := ri.LnJJudgments[25].Defendant;
		self.Jgmts25_Plaintiff    := ri.LnJJudgments[25].Plaintiff;
		self.Jgmts25_FilingNumber := ri.LnJJudgments[25].FilingNumber    ;
		self.Jgmts25_FilingBook   := ri.LnJJudgments[25].FilingBook      ;
		self.Jgmts25_FilingPage   := ri.LnJJudgments[25].FilingPage;
		self.Jgmts25_Eviction     := ri.LnJJudgments[25].Eviction;
		self.Jgmts25_Agency       := ri.LnJJudgments[25].Agency          ;
		self.Jgmts25_AgencyCounty := ri.LnJJudgments[25].AgencyCounty    ;
		self.Jgmts25_AgencyState  := ri.LnJJudgments[25].AgencyState     ;
		self.Jgmts25_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[25].ConsumerStatementId);
    self.Jgmts25_orig_rmsid       := ri.LnJJudgments[25].orig_rmsid;
		self.Jgmts26_Seq          := ri.LnJJudgments[26].Seq             ;
		self.Jgmts26_DateFiled    := ri.LnJJudgments[26].DateFiled       ;
  self.Jgmts26_JudgmentTypeID := ri.LnJJudgments[26].JudgmentTypeID;
		self.Jgmts26_JudgmentType     := ri.LnJJudgments[26].JudgmentType        ;
		self.Jgmts26_Amount       := ri.LnJJudgments[26].Amount          ;
		self.Jgmts26_ReleaseDate  := ri.LnJJudgments[26].ReleaseDate ;
		self.Jgmts26_FilingDescription  := ri.LnJJudgments[26].FilingDescription;
		self.Jgmts26_DateLastSeen := ri.LnJJudgments[26].DateLastSeen;
		self.Jgmts26_Defendant    := ri.LnJJudgments[26].Defendant;
		self.Jgmts26_Plaintiff    := ri.LnJJudgments[26].Plaintiff;
		self.Jgmts26_FilingNumber := ri.LnJJudgments[26].FilingNumber    ;
		self.Jgmts26_FilingBook   := ri.LnJJudgments[26].FilingBook      ;
		self.Jgmts26_FilingPage   := ri.LnJJudgments[26].FilingPage;
		self.Jgmts26_Eviction     := ri.LnJJudgments[26].Eviction;
		self.Jgmts26_Agency       := ri.LnJJudgments[26].Agency          ;
		self.Jgmts26_AgencyCounty := ri.LnJJudgments[26].AgencyCounty    ;
		self.Jgmts26_AgencyState  := ri.LnJJudgments[26].AgencyState     ;
		self.Jgmts26_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[26].ConsumerStatementId);
		self.Jgmts26_orig_rmsid       := ri.LnJJudgments[26].orig_rmsid;
		self.Jgmts27_Seq          := ri.LnJJudgments[27].Seq             ;
		self.Jgmts27_DateFiled    := ri.LnJJudgments[27].DateFiled       ;
  self.Jgmts27_JudgmentTypeID := ri.LnJJudgments[27].JudgmentTypeID;
		self.Jgmts27_JudgmentType     := ri.LnJJudgments[27].JudgmentType        ;
		self.Jgmts27_Amount       := ri.LnJJudgments[27].Amount          ;
		self.Jgmts27_ReleaseDate  := ri.LnJJudgments[27].ReleaseDate ;
		self.Jgmts27_FilingDescription  := ri.LnJJudgments[27].FilingDescription;
		self.Jgmts27_DateLastSeen := ri.LnJJudgments[27].DateLastSeen;
		self.Jgmts27_Defendant    := ri.LnJJudgments[27].Defendant;
		self.Jgmts27_Plaintiff    := ri.LnJJudgments[27].Plaintiff;
		self.Jgmts27_FilingNumber := ri.LnJJudgments[27].FilingNumber    ;
		self.Jgmts27_FilingBook   := ri.LnJJudgments[27].FilingBook      ;
		self.Jgmts27_FilingPage   := ri.LnJJudgments[27].FilingPage;
		self.Jgmts27_Eviction     := ri.LnJJudgments[27].Eviction;
		self.Jgmts27_Agency       := ri.LnJJudgments[27].Agency          ;
		self.Jgmts27_AgencyCounty := ri.LnJJudgments[27].AgencyCounty    ;
		self.Jgmts27_AgencyState  := ri.LnJJudgments[27].AgencyState     ;
		self.Jgmts27_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[27].ConsumerStatementId);
    self.Jgmts27_orig_rmsid       := ri.LnJJudgments[27].orig_rmsid;
		self.Jgmts28_Seq          := ri.LnJJudgments[28].Seq             ;
		self.Jgmts28_DateFiled    := ri.LnJJudgments[28].DateFiled       ;
  self.Jgmts28_JudgmentTypeID := ri.LnJJudgments[28].JudgmentTypeID;
		self.Jgmts28_JudgmentType     := ri.LnJJudgments[28].JudgmentType        ;
		self.Jgmts28_Amount       := ri.LnJJudgments[28].Amount          ;
		self.Jgmts28_ReleaseDate  := ri.LnJJudgments[28].ReleaseDate ; 
		self.Jgmts28_FilingDescription  := ri.LnJJudgments[28].FilingDescription;
		self.Jgmts28_DateLastSeen := ri.LnJJudgments[28].DateLastSeen;
		self.Jgmts28_Defendant    := ri.LnJJudgments[28].Defendant;
		self.Jgmts28_Plaintiff    := ri.LnJJudgments[28].Plaintiff;
		self.Jgmts28_FilingNumber := ri.LnJJudgments[28].FilingNumber    ;
		self.Jgmts28_FilingBook   := ri.LnJJudgments[28].FilingBook      ;
		self.Jgmts28_FilingPage   := ri.LnJJudgments[28].FilingPage;
		self.Jgmts28_Eviction     := ri.LnJJudgments[28].Eviction;
		self.Jgmts28_Agency       := ri.LnJJudgments[28].Agency          ;
		self.Jgmts28_AgencyCounty := ri.LnJJudgments[28].AgencyCounty    ;
		self.Jgmts28_AgencyState  := ri.LnJJudgments[28].AgencyState     ;
		self.Jgmts28_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[28].ConsumerStatementId);
    self.Jgmts28_orig_rmsid       := ri.LnJJudgments[28].orig_rmsid;
		self.Jgmts29_Seq          := ri.LnJJudgments[29].Seq             ;
		self.Jgmts29_DateFiled    := ri.LnJJudgments[29].DateFiled       ;
  self.Jgmts29_JudgmentTypeID := ri.LnJJudgments[29].JudgmentTypeID;
		self.Jgmts29_JudgmentType     := ri.LnJJudgments[29].JudgmentType        ;
		self.Jgmts29_Amount       := ri.LnJJudgments[29].Amount          ;
		self.Jgmts29_ReleaseDate  := ri.LnJJudgments[29].ReleaseDate ; 
		self.Jgmts29_FilingDescription  := ri.LnJJudgments[29].FilingDescription;
		self.Jgmts29_DateLastSeen := ri.LnJJudgments[29].DateLastSeen;
		self.Jgmts29_Defendant    := ri.LnJJudgments[29].Defendant;
		self.Jgmts29_Plaintiff    := ri.LnJJudgments[29].Plaintiff;
		self.Jgmts29_FilingNumber := ri.LnJJudgments[29].FilingNumber    ;
		self.Jgmts29_FilingBook   := ri.LnJJudgments[29].FilingBook      ;
		self.Jgmts29_FilingPage   := ri.LnJJudgments[29].FilingPage;
		self.Jgmts29_Eviction     := ri.LnJJudgments[29].Eviction;
		self.Jgmts29_Agency       := ri.LnJJudgments[29].Agency          ;
		self.Jgmts29_AgencyCounty := ri.LnJJudgments[29].AgencyCounty    ;
		self.Jgmts29_AgencyState  := ri.LnJJudgments[29].AgencyState     ;
		self.Jgmts29_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[29].ConsumerStatementId);
    self.Jgmts29_orig_rmsid       := ri.LnJJudgments[29].orig_rmsid;
		self.Jgmts30_Seq          := ri.LnJJudgments[30].Seq             ;
		self.Jgmts30_DateFiled    := ri.LnJJudgments[30].DateFiled       ;
  self.Jgmts30_JudgmentTypeID := ri.LnJJudgments[30].JudgmentTypeID;
		self.Jgmts30_JudgmentType     := ri.LnJJudgments[30].JudgmentType        ;
		self.Jgmts30_Amount       := ri.LnJJudgments[30].Amount          ;
		self.Jgmts30_ReleaseDate  := ri.LnJJudgments[30].ReleaseDate ; 
		self.Jgmts30_FilingDescription  := ri.LnJJudgments[30].FilingDescription;
		self.Jgmts30_DateLastSeen := ri.LnJJudgments[30].DateLastSeen;
		self.Jgmts30_Defendant    := ri.LnJJudgments[30].Defendant;
		self.Jgmts30_Plaintiff    := ri.LnJJudgments[30].Plaintiff;
		self.Jgmts30_FilingNumber := ri.LnJJudgments[30].FilingNumber    ;
		self.Jgmts30_FilingBook   := ri.LnJJudgments[30].FilingBook      ;
		self.Jgmts30_FilingPage   := ri.LnJJudgments[30].FilingPage;
		self.Jgmts30_Eviction     := ri.LnJJudgments[30].Eviction;
		self.Jgmts30_Agency       := ri.LnJJudgments[30].Agency          ;
		self.Jgmts30_AgencyCounty := ri.LnJJudgments[30].AgencyCounty    ;
		self.Jgmts30_AgencyState  := ri.LnJJudgments[30].AgencyState     ;
		self.Jgmts30_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[30].ConsumerStatementId);
    self.Jgmts30_orig_rmsid       := ri.LnJJudgments[30].orig_rmsid;
		self.Jgmts31_Seq          := ri.LnJJudgments[31].Seq             ;
		self.Jgmts31_DateFiled    := ri.LnJJudgments[31].DateFiled       ;
  self.Jgmts31_JudgmentTypeID := ri.LnJJudgments[31].JudgmentTypeID;
		self.Jgmts31_JudgmentType     := ri.LnJJudgments[31].JudgmentType        ;
		self.Jgmts31_Amount       := ri.LnJJudgments[31].Amount          ;
		self.Jgmts31_ReleaseDate  := ri.LnJJudgments[31].ReleaseDate ;
		self.Jgmts31_FilingDescription  := ri.LnJJudgments[31].FilingDescription;
		self.Jgmts31_DateLastSeen := ri.LnJJudgments[31].DateLastSeen;
		self.Jgmts31_Defendant    := ri.LnJJudgments[31].Defendant;
		self.Jgmts31_Plaintiff    := ri.LnJJudgments[31].Plaintiff;
		self.Jgmts31_FilingNumber := ri.LnJJudgments[31].FilingNumber    ;
		self.Jgmts31_FilingBook   := ri.LnJJudgments[31].FilingBook      ;
		self.Jgmts31_FilingPage   := ri.LnJJudgments[31].FilingPage;
		self.Jgmts31_Eviction     := ri.LnJJudgments[31].Eviction;
		self.Jgmts31_Agency       := ri.LnJJudgments[31].Agency          ;
		self.Jgmts31_AgencyCounty := ri.LnJJudgments[31].AgencyCounty    ;
		self.Jgmts31_AgencyState  := ri.LnJJudgments[31].AgencyState     ;
		self.Jgmts31_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[31].ConsumerStatementId);
    self.Jgmts31_orig_rmsid       := ri.LnJJudgments[31].orig_rmsid;
		self.Jgmts32_Seq          := ri.LnJJudgments[32].Seq             ;
		self.Jgmts32_DateFiled    := ri.LnJJudgments[32].DateFiled       ;
  self.Jgmts32_JudgmentTypeID := ri.LnJJudgments[32].JudgmentTypeID;
		self.Jgmts32_JudgmentType     := ri.LnJJudgments[32].JudgmentType        ;
		self.Jgmts32_Amount       := ri.LnJJudgments[32].Amount          ;
		self.Jgmts32_ReleaseDate  := ri.LnJJudgments[32].ReleaseDate ;
		self.Jgmts32_FilingDescription  := ri.LnJJudgments[32].FilingDescription;
		self.Jgmts32_DateLastSeen := ri.LnJJudgments[32].DateLastSeen;
		self.Jgmts32_Defendant    := ri.LnJJudgments[32].Defendant;
		self.Jgmts32_Plaintiff    := ri.LnJJudgments[32].Plaintiff;
		self.Jgmts32_FilingNumber := ri.LnJJudgments[32].FilingNumber    ;
		self.Jgmts32_FilingBook   := ri.LnJJudgments[32].FilingBook      ;
		self.Jgmts32_FilingPage   := ri.LnJJudgments[32].FilingPage;
		self.Jgmts32_Eviction     := ri.LnJJudgments[32].Eviction;
		self.Jgmts32_Agency       := ri.LnJJudgments[32].Agency          ;
		self.Jgmts32_AgencyCounty := ri.LnJJudgments[32].AgencyCounty    ;
		self.Jgmts32_AgencyState  := ri.LnJJudgments[32].AgencyState     ;
		self.Jgmts32_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[32].ConsumerStatementId);
    self.Jgmts32_orig_rmsid       := ri.LnJJudgments[32].orig_rmsid;
		self.Jgmts33_Seq          := ri.LnJJudgments[33].Seq             ;
		self.Jgmts33_DateFiled    := ri.LnJJudgments[33].DateFiled       ;
  self.Jgmts33_JudgmentTypeID := ri.LnJJudgments[33].JudgmentTypeID;
		self.Jgmts33_JudgmentType     := ri.LnJJudgments[33].JudgmentType        ;
		self.Jgmts33_Amount       := ri.LnJJudgments[33].Amount          ;
		self.Jgmts33_ReleaseDate  := ri.LnJJudgments[33].ReleaseDate ; 
		self.Jgmts33_FilingDescription  := ri.LnJJudgments[33].FilingDescription;
		self.Jgmts33_DateLastSeen := ri.LnJJudgments[33].DateLastSeen;
		self.Jgmts33_Defendant    := ri.LnJJudgments[33].Defendant;
		self.Jgmts33_Plaintiff    := ri.LnJJudgments[33].Plaintiff;
		self.Jgmts33_FilingNumber := ri.LnJJudgments[33].FilingNumber    ;
		self.Jgmts33_FilingBook   := ri.LnJJudgments[33].FilingBook      ;
		self.Jgmts33_FilingPage   := ri.LnJJudgments[33].FilingPage;
		self.Jgmts33_Eviction     := ri.LnJJudgments[33].Eviction;
		self.Jgmts33_Agency       := ri.LnJJudgments[33].Agency          ;
		self.Jgmts33_AgencyCounty := ri.LnJJudgments[33].AgencyCounty    ;
		self.Jgmts33_AgencyState  := ri.LnJJudgments[33].AgencyState     ;
		self.Jgmts33_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[33].ConsumerStatementId);
    self.Jgmts33_orig_rmsid       := ri.LnJJudgments[33].orig_rmsid;
		self.Jgmts34_Seq          := ri.LnJJudgments[34].Seq             ;
		self.Jgmts34_DateFiled    := ri.LnJJudgments[34].DateFiled       ;
  self.Jgmts34_JudgmentTypeID := ri.LnJJudgments[34].JudgmentTypeID;
		self.Jgmts34_JudgmentType     := ri.LnJJudgments[34].JudgmentType        ;
		self.Jgmts34_Amount       := ri.LnJJudgments[34].Amount          ;
		self.Jgmts34_ReleaseDate  := ri.LnJJudgments[34].ReleaseDate ; 
		self.Jgmts34_FilingDescription  := ri.LnJJudgments[34].FilingDescription;
		self.Jgmts34_DateLastSeen := ri.LnJJudgments[34].DateLastSeen;
		self.Jgmts34_Defendant    := ri.LnJJudgments[34].Defendant;
		self.Jgmts34_Plaintiff    := ri.LnJJudgments[34].Plaintiff;
		self.Jgmts34_FilingNumber := ri.LnJJudgments[34].FilingNumber    ;
		self.Jgmts34_FilingBook   := ri.LnJJudgments[34].FilingBook      ;
		self.Jgmts34_FilingPage   := ri.LnJJudgments[34].FilingPage;
		self.Jgmts34_Eviction     := ri.LnJJudgments[34].Eviction;
		self.Jgmts34_Agency       := ri.LnJJudgments[34].Agency          ;
		self.Jgmts34_AgencyCounty := ri.LnJJudgments[34].AgencyCounty    ;
		self.Jgmts34_AgencyState  := ri.LnJJudgments[34].AgencyState     ;
		self.Jgmts34_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[34].ConsumerStatementId);
    self.Jgmts34_orig_rmsid       := ri.LnJJudgments[34].orig_rmsid;
		self.Jgmts35_Seq          := ri.LnJJudgments[35].Seq             ;
		self.Jgmts35_DateFiled    := ri.LnJJudgments[35].DateFiled       ;
  self.Jgmts35_JudgmentTypeID := ri.LnJJudgments[35].JudgmentTypeID;
		self.Jgmts35_JudgmentType     := ri.LnJJudgments[35].JudgmentType        ;
		self.Jgmts35_Amount       := ri.LnJJudgments[35].Amount          ;
		self.Jgmts35_ReleaseDate  := ri.LnJJudgments[35].ReleaseDate ; 
		self.Jgmts35_FilingDescription  := ri.LnJJudgments[35].FilingDescription;
		self.Jgmts35_DateLastSeen := ri.LnJJudgments[35].DateLastSeen;
		self.Jgmts35_Defendant    := ri.LnJJudgments[35].Defendant;
		self.Jgmts35_Plaintiff    := ri.LnJJudgments[35].Plaintiff;
		self.Jgmts35_FilingNumber := ri.LnJJudgments[35].FilingNumber    ;
		self.Jgmts35_FilingBook   := ri.LnJJudgments[35].FilingBook      ;
		self.Jgmts35_FilingPage   := ri.LnJJudgments[35].FilingPage;
		self.Jgmts35_Eviction     := ri.LnJJudgments[35].Eviction;
		self.Jgmts35_Agency       := ri.LnJJudgments[35].Agency          ;
		self.Jgmts35_AgencyCounty := ri.LnJJudgments[35].AgencyCounty    ;
		self.Jgmts35_AgencyState  := ri.LnJJudgments[35].AgencyState     ;
		self.Jgmts35_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[35].ConsumerStatementId);
    self.Jgmts35_orig_rmsid       := ri.LnJJudgments[35].orig_rmsid;
		self.Jgmts36_Seq          := ri.LnJJudgments[36].Seq             ;
		self.Jgmts36_DateFiled    := ri.LnJJudgments[36].DateFiled       ;
  self.Jgmts36_JudgmentTypeID := ri.LnJJudgments[36].JudgmentTypeID;
		self.Jgmts36_JudgmentType     := ri.LnJJudgments[36].JudgmentType        ;
		self.Jgmts36_Amount       := ri.LnJJudgments[36].Amount          ;
		self.Jgmts36_ReleaseDate  := ri.LnJJudgments[36].ReleaseDate ;
		self.Jgmts36_FilingDescription  := ri.LnJJudgments[36].FilingDescription;
		self.Jgmts36_DateLastSeen := ri.LnJJudgments[36].DateLastSeen;
		self.Jgmts36_Defendant    := ri.LnJJudgments[36].Defendant;
		self.Jgmts36_Plaintiff    := ri.LnJJudgments[36].Plaintiff;
		self.Jgmts36_FilingNumber := ri.LnJJudgments[36].FilingNumber    ;
		self.Jgmts36_FilingBook   := ri.LnJJudgments[36].FilingBook      ;
		self.Jgmts36_FilingPage   := ri.LnJJudgments[36].FilingPage;
		self.Jgmts36_Eviction     := ri.LnJJudgments[36].Eviction;
		self.Jgmts36_Agency       := ri.LnJJudgments[36].Agency          ;
		self.Jgmts36_AgencyCounty := ri.LnJJudgments[36].AgencyCounty    ;
		self.Jgmts36_AgencyState  := ri.LnJJudgments[36].AgencyState     ;
		self.Jgmts36_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[36].ConsumerStatementId);
    self.Jgmts36_orig_rmsid       := ri.LnJJudgments[36].orig_rmsid;
		self.Jgmts37_Seq          := ri.LnJJudgments[37].Seq             ;
		self.Jgmts37_DateFiled    := ri.LnJJudgments[37].DateFiled       ;
  self.Jgmts37_JudgmentTypeID := ri.LnJJudgments[37].JudgmentTypeID;
		self.Jgmts37_JudgmentType     := ri.LnJJudgments[37].JudgmentType        ;
		self.Jgmts37_Amount       := ri.LnJJudgments[37].Amount          ;
		self.Jgmts37_ReleaseDate  := ri.LnJJudgments[37].ReleaseDate ;
		self.Jgmts37_FilingDescription  := ri.LnJJudgments[37].FilingDescription;
		self.Jgmts37_DateLastSeen := ri.LnJJudgments[37].DateLastSeen;
		self.Jgmts37_Defendant    := ri.LnJJudgments[37].Defendant;
		self.Jgmts37_Plaintiff    := ri.LnJJudgments[37].Plaintiff;
		self.Jgmts37_FilingNumber := ri.LnJJudgments[37].FilingNumber    ;
		self.Jgmts37_FilingBook   := ri.LnJJudgments[37].FilingBook      ;
		self.Jgmts37_FilingPage   := ri.LnJJudgments[37].FilingPage;
		self.Jgmts37_Eviction     := ri.LnJJudgments[37].Eviction;
		self.Jgmts37_Agency       := ri.LnJJudgments[37].Agency          ;
		self.Jgmts37_AgencyCounty := ri.LnJJudgments[37].AgencyCounty    ;
		self.Jgmts37_AgencyState  := ri.LnJJudgments[37].AgencyState     ;
		self.Jgmts37_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[37].ConsumerStatementId);
    self.Jgmts37_orig_rmsid       := ri.LnJJudgments[37].orig_rmsid;
		self.Jgmts38_Seq          := ri.LnJJudgments[38].Seq             ;
		self.Jgmts38_DateFiled    := ri.LnJJudgments[38].DateFiled       ;
  self.Jgmts38_JudgmentTypeID := ri.LnJJudgments[38].JudgmentTypeID;
		self.Jgmts38_JudgmentType     := ri.LnJJudgments[38].JudgmentType        ;
		self.Jgmts38_Amount       := ri.LnJJudgments[38].Amount          ;
		self.Jgmts38_ReleaseDate  := ri.LnJJudgments[38].ReleaseDate ;
		self.Jgmts38_FilingDescription  := ri.LnJJudgments[38].FilingDescription;
		self.Jgmts38_DateLastSeen := ri.LnJJudgments[38].DateLastSeen;
		self.Jgmts38_Defendant    := ri.LnJJudgments[38].Defendant;
		self.Jgmts38_Plaintiff    := ri.LnJJudgments[38].Plaintiff;
		self.Jgmts38_FilingNumber := ri.LnJJudgments[38].FilingNumber    ;
		self.Jgmts38_FilingBook   := ri.LnJJudgments[38].FilingBook      ;
		self.Jgmts38_FilingPage   := ri.LnJJudgments[38].FilingPage;
		self.Jgmts38_Eviction     := ri.LnJJudgments[38].Eviction;
		self.Jgmts38_Agency       := ri.LnJJudgments[38].Agency          ;
		self.Jgmts38_AgencyCounty := ri.LnJJudgments[38].AgencyCounty    ;
		self.Jgmts38_AgencyState  := ri.LnJJudgments[38].AgencyState     ;
		self.Jgmts38_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[38].ConsumerStatementId);
    self.Jgmts38_orig_rmsid       := ri.LnJJudgments[38].orig_rmsid;
		self.Jgmts39_Seq          := ri.LnJJudgments[39].Seq             ;
		self.Jgmts39_DateFiled    := ri.LnJJudgments[39].DateFiled       ;
  self.Jgmts39_JudgmentTypeID := ri.LnJJudgments[39].JudgmentTypeID;
		self.Jgmts39_JudgmentType     := ri.LnJJudgments[39].JudgmentType        ;
		self.Jgmts39_Amount       := ri.LnJJudgments[39].Amount          ;
		self.Jgmts39_ReleaseDate  := ri.LnJJudgments[39].ReleaseDate ; 
		self.Jgmts39_FilingDescription  := ri.LnJJudgments[39].FilingDescription;
		self.Jgmts39_DateLastSeen := ri.LnJJudgments[39].DateLastSeen;
		self.Jgmts39_Defendant    := ri.LnJJudgments[39].Defendant;
		self.Jgmts39_Plaintiff    := ri.LnJJudgments[39].Plaintiff;
		self.Jgmts39_FilingNumber := ri.LnJJudgments[39].FilingNumber    ;
		self.Jgmts39_FilingBook   := ri.LnJJudgments[39].FilingBook      ;
		self.Jgmts39_FilingPage   := ri.LnJJudgments[39].FilingPage;
		self.Jgmts39_Eviction     := ri.LnJJudgments[39].Eviction;
		self.Jgmts39_Agency       := ri.LnJJudgments[39].Agency          ;
		self.Jgmts39_AgencyCounty := ri.LnJJudgments[39].AgencyCounty    ;
		self.Jgmts39_AgencyState  := ri.LnJJudgments[39].AgencyState     ;
		self.Jgmts39_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[39].ConsumerStatementId);
    self.Jgmts39_orig_rmsid       := ri.LnJJudgments[39].orig_rmsid;
		self.Jgmts40_Seq          := ri.LnJJudgments[40].Seq             ;
		self.Jgmts40_DateFiled    := ri.LnJJudgments[40].DateFiled       ;
  self.Jgmts40_JudgmentTypeID := ri.LnJJudgments[40].JudgmentTypeID;
		self.Jgmts40_JudgmentType     := ri.LnJJudgments[40].JudgmentType        ;
		self.Jgmts40_Amount       := ri.LnJJudgments[40].Amount          ;
		self.Jgmts40_ReleaseDate  := ri.LnJJudgments[40].ReleaseDate ;
		self.Jgmts40_FilingDescription  := ri.LnJJudgments[40].FilingDescription;
		self.Jgmts40_DateLastSeen := ri.LnJJudgments[40].DateLastSeen;
		self.Jgmts40_Defendant    := ri.LnJJudgments[40].Defendant;
		self.Jgmts40_Plaintiff    := ri.LnJJudgments[40].Plaintiff;
		self.Jgmts40_FilingNumber := ri.LnJJudgments[40].FilingNumber    ;
		self.Jgmts40_FilingBook   := ri.LnJJudgments[40].FilingBook      ;
		self.Jgmts40_FilingPage   := ri.LnJJudgments[40].FilingPage;
		self.Jgmts40_Eviction     := ri.LnJJudgments[40].Eviction;
		self.Jgmts40_Agency       := ri.LnJJudgments[40].Agency          ;
		self.Jgmts40_AgencyCounty := ri.LnJJudgments[40].AgencyCounty    ;
		self.Jgmts40_AgencyState  := ri.LnJJudgments[40].AgencyState     ;
		self.Jgmts40_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[40].ConsumerStatementId);
    self.Jgmts40_orig_rmsid       := ri.LnJJudgments[40].orig_rmsid;
		self.Jgmts41_Seq          := ri.LnJJudgments[41].Seq             ;
		self.Jgmts41_DateFiled    := ri.LnJJudgments[41].DateFiled       ;
  self.Jgmts41_JudgmentTypeID := ri.LnJJudgments[41].JudgmentTypeID;
		self.Jgmts41_JudgmentType     := ri.LnJJudgments[41].JudgmentType        ;
		self.Jgmts41_Amount       := ri.LnJJudgments[41].Amount          ;
		self.Jgmts41_ReleaseDate  := ri.LnJJudgments[41].ReleaseDate ;
		self.Jgmts41_FilingDescription  := ri.LnJJudgments[41].FilingDescription;
		self.Jgmts41_DateLastSeen := ri.LnJJudgments[41].DateLastSeen;
		self.Jgmts41_Defendant    := ri.LnJJudgments[41].Defendant;
		self.Jgmts41_Plaintiff    := ri.LnJJudgments[41].Plaintiff;
		self.Jgmts41_FilingNumber := ri.LnJJudgments[41].FilingNumber    ;
		self.Jgmts41_FilingBook   := ri.LnJJudgments[41].FilingBook      ;
		self.Jgmts41_FilingPage   := ri.LnJJudgments[41].FilingPage;
		self.Jgmts41_Eviction     := ri.LnJJudgments[41].Eviction;
		self.Jgmts41_Agency       := ri.LnJJudgments[41].Agency          ;
		self.Jgmts41_AgencyCounty := ri.LnJJudgments[41].AgencyCounty    ;
		self.Jgmts41_AgencyState  := ri.LnJJudgments[41].AgencyState     ;
		self.Jgmts41_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[41].ConsumerStatementId);
    self.Jgmts41_orig_rmsid       := ri.LnJJudgments[41].orig_rmsid;
		self.Jgmts42_Seq          := ri.LnJJudgments[42].Seq             ;
		self.Jgmts42_DateFiled    := ri.LnJJudgments[42].DateFiled       ;
  self.Jgmts42_JudgmentTypeID := ri.LnJJudgments[42].JudgmentTypeID;
		self.Jgmts42_JudgmentType     := ri.LnJJudgments[42].JudgmentType        ;
		self.Jgmts42_Amount       := ri.LnJJudgments[42].Amount          ;
		self.Jgmts42_ReleaseDate  := ri.LnJJudgments[42].ReleaseDate ;
		self.Jgmts42_FilingDescription  := ri.LnJJudgments[42].FilingDescription;
		self.Jgmts42_DateLastSeen := ri.LnJJudgments[42].DateLastSeen;
		self.Jgmts42_Defendant    := ri.LnJJudgments[42].Defendant;
		self.Jgmts42_Plaintiff    := ri.LnJJudgments[42].Plaintiff;
		self.Jgmts42_FilingNumber := ri.LnJJudgments[42].FilingNumber    ;
		self.Jgmts42_FilingBook   := ri.LnJJudgments[42].FilingBook      ;
		self.Jgmts42_FilingPage   := ri.LnJJudgments[42].FilingPage;
		self.Jgmts42_Eviction     := ri.LnJJudgments[42].Eviction;
		self.Jgmts42_Agency       := ri.LnJJudgments[42].Agency          ;
		self.Jgmts42_AgencyCounty := ri.LnJJudgments[42].AgencyCounty    ;
		self.Jgmts42_AgencyState  := ri.LnJJudgments[42].AgencyState     ;
		self.Jgmts42_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[42].ConsumerStatementId);
    self.Jgmts42_orig_rmsid       := ri.LnJJudgments[42].orig_rmsid;
		self.Jgmts43_Seq          := ri.LnJJudgments[43].Seq             ;
		self.Jgmts43_DateFiled    := ri.LnJJudgments[43].DateFiled       ;
  self.Jgmts43_JudgmentTypeID := ri.LnJJudgments[43].JudgmentTypeID;
		self.Jgmts43_JudgmentType     := ri.LnJJudgments[43].JudgmentType        ;
		self.Jgmts43_Amount       := ri.LnJJudgments[43].Amount          ;
		self.Jgmts43_ReleaseDate  := ri.LnJJudgments[43].ReleaseDate ;
		self.Jgmts43_FilingDescription  := ri.LnJJudgments[43].FilingDescription;
		self.Jgmts43_DateLastSeen := ri.LnJJudgments[43].DateLastSeen;
		self.Jgmts43_Defendant    := ri.LnJJudgments[43].Defendant;
		self.Jgmts43_Plaintiff    := ri.LnJJudgments[43].Plaintiff;
		self.Jgmts43_FilingNumber := ri.LnJJudgments[43].FilingNumber    ;
		self.Jgmts43_FilingBook   := ri.LnJJudgments[43].FilingBook      ;
		self.Jgmts43_FilingPage   := ri.LnJJudgments[43].FilingPage;
		self.Jgmts43_Eviction     := ri.LnJJudgments[43].Eviction;
		self.Jgmts43_Agency       := ri.LnJJudgments[43].Agency          ;
		self.Jgmts43_AgencyCounty := ri.LnJJudgments[43].AgencyCounty    ;
		self.Jgmts43_AgencyState  := ri.LnJJudgments[43].AgencyState     ;
		self.Jgmts43_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[43].ConsumerStatementId);
    self.Jgmts43_orig_rmsid       := ri.LnJJudgments[43].orig_rmsid;
		self.Jgmts44_Seq          := ri.LnJJudgments[44].Seq             ;
		self.Jgmts44_DateFiled    := ri.LnJJudgments[44].DateFiled       ;
  self.Jgmts44_JudgmentTypeID := ri.LnJJudgments[44].JudgmentTypeID;
		self.Jgmts44_JudgmentType     := ri.LnJJudgments[44].JudgmentType        ;
		self.Jgmts44_Amount       := ri.LnJJudgments[44].Amount          ;
		self.Jgmts44_ReleaseDate  := ri.LnJJudgments[44].ReleaseDate ;
		self.Jgmts44_FilingDescription  := ri.LnJJudgments[44].FilingDescription;
		self.Jgmts44_DateLastSeen := ri.LnJJudgments[44].DateLastSeen;
		self.Jgmts44_Defendant    := ri.LnJJudgments[44].Defendant;
		self.Jgmts44_Plaintiff    := ri.LnJJudgments[44].Plaintiff;
		self.Jgmts44_FilingNumber := ri.LnJJudgments[44].FilingNumber    ;
		self.Jgmts44_FilingBook   := ri.LnJJudgments[44].FilingBook      ;
		self.Jgmts44_FilingPage   := ri.LnJJudgments[44].FilingPage;
		self.Jgmts44_Eviction     := ri.LnJJudgments[44].Eviction;
		self.Jgmts44_Agency       := ri.LnJJudgments[44].Agency          ;
		self.Jgmts44_AgencyCounty := ri.LnJJudgments[44].AgencyCounty    ;
		self.Jgmts44_AgencyState  := ri.LnJJudgments[44].AgencyState     ;
		self.Jgmts44_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[44].ConsumerStatementId);
    self.Jgmts44_orig_rmsid       := ri.LnJJudgments[44].orig_rmsid;
		self.Jgmts45_Seq          := ri.LnJJudgments[45].Seq             ;
		self.Jgmts45_DateFiled    := ri.LnJJudgments[45].DateFiled       ;
  self.Jgmts45_JudgmentTypeID := ri.LnJJudgments[45].JudgmentTypeID;
		self.Jgmts45_JudgmentType     := ri.LnJJudgments[45].JudgmentType        ;
		self.Jgmts45_Amount       := ri.LnJJudgments[45].Amount          ;
		self.Jgmts45_ReleaseDate  := ri.LnJJudgments[45].ReleaseDate ;
		self.Jgmts45_FilingDescription  := ri.LnJJudgments[45].FilingDescription;
		self.Jgmts45_DateLastSeen := ri.LnJJudgments[45].DateLastSeen;
		self.Jgmts45_Defendant    := ri.LnJJudgments[45].Defendant;
		self.Jgmts45_Plaintiff    := ri.LnJJudgments[45].Plaintiff;
		self.Jgmts45_FilingNumber := ri.LnJJudgments[45].FilingNumber    ;
		self.Jgmts45_FilingBook   := ri.LnJJudgments[45].FilingBook      ;
		self.Jgmts45_FilingPage   := ri.LnJJudgments[45].FilingPage;
		self.Jgmts45_Eviction     := ri.LnJJudgments[45].Eviction;
		self.Jgmts45_Agency       := ri.LnJJudgments[45].Agency          ;
		self.Jgmts45_AgencyCounty := ri.LnJJudgments[45].AgencyCounty    ;
		self.Jgmts45_AgencyState  := ri.LnJJudgments[45].AgencyState     ;
		self.Jgmts45_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[45].ConsumerStatementId);
    self.Jgmts45_orig_rmsid       := ri.LnJJudgments[45].orig_rmsid;
		self.Jgmts46_Seq          := ri.LnJJudgments[46].Seq             ;
		self.Jgmts46_DateFiled    := ri.LnJJudgments[46].DateFiled       ;
  self.Jgmts46_JudgmentTypeID := ri.LnJJudgments[46].JudgmentTypeID;
		self.Jgmts46_JudgmentType     := ri.LnJJudgments[46].JudgmentType        ;
		self.Jgmts46_Amount       := ri.LnJJudgments[46].Amount          ;
		self.Jgmts46_ReleaseDate  := ri.LnJJudgments[46].ReleaseDate ;
		self.Jgmts46_FilingDescription  := ri.LnJJudgments[46].FilingDescription;
		self.Jgmts46_DateLastSeen := ri.LnJJudgments[46].DateLastSeen;
		self.Jgmts46_Defendant    := ri.LnJJudgments[46].Defendant;
		self.Jgmts46_Plaintiff    := ri.LnJJudgments[46].Plaintiff;
		self.Jgmts46_FilingNumber := ri.LnJJudgments[46].FilingNumber    ;
		self.Jgmts46_FilingBook   := ri.LnJJudgments[46].FilingBook      ;
		self.Jgmts46_FilingPage   := ri.LnJJudgments[46].FilingPage;
		self.Jgmts46_Eviction     := ri.LnJJudgments[46].Eviction;
		self.Jgmts46_Agency       := ri.LnJJudgments[46].Agency          ;
		self.Jgmts46_AgencyCounty := ri.LnJJudgments[46].AgencyCounty    ;
		self.Jgmts46_AgencyState  := ri.LnJJudgments[46].AgencyState     ;
		self.Jgmts46_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[46].ConsumerStatementId);
    self.Jgmts46_orig_rmsid       := ri.LnJJudgments[46].orig_rmsid;
		self.Jgmts47_Seq          := ri.LnJJudgments[47].Seq             ;
		self.Jgmts47_DateFiled    := ri.LnJJudgments[47].DateFiled       ;
  self.Jgmts47_JudgmentTypeID := ri.LnJJudgments[47].JudgmentTypeID;
		self.Jgmts47_JudgmentType     := ri.LnJJudgments[47].JudgmentType        ;
		self.Jgmts47_Amount       := ri.LnJJudgments[47].Amount          ;
		self.Jgmts47_ReleaseDate  := ri.LnJJudgments[47].ReleaseDate ; 
		self.Jgmts47_FilingDescription  := ri.LnJJudgments[47].FilingDescription;
		self.Jgmts47_DateLastSeen := ri.LnJJudgments[47].DateLastSeen;
		self.Jgmts47_Defendant    := ri.LnJJudgments[47].Defendant;
		self.Jgmts47_Plaintiff    := ri.LnJJudgments[47].Plaintiff;
		self.Jgmts47_FilingNumber := ri.LnJJudgments[47].FilingNumber    ;
		self.Jgmts47_FilingBook   := ri.LnJJudgments[47].FilingBook      ;
		self.Jgmts47_FilingPage   := ri.LnJJudgments[47].FilingPage;
		self.Jgmts47_Eviction     := ri.LnJJudgments[47].Eviction;
		self.Jgmts47_Agency       := ri.LnJJudgments[47].Agency          ;
		self.Jgmts47_AgencyCounty := ri.LnJJudgments[47].AgencyCounty    ;
		self.Jgmts47_AgencyState  := ri.LnJJudgments[47].AgencyState     ;
		self.Jgmts47_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[47].ConsumerStatementId);
    self.Jgmts47_orig_rmsid       := ri.LnJJudgments[47].orig_rmsid;
		self.Jgmts48_Seq          := ri.LnJJudgments[48].Seq             ;
		self.Jgmts48_DateFiled    := ri.LnJJudgments[48].DateFiled       ;
  self.Jgmts48_JudgmentTypeID := ri.LnJJudgments[48].JudgmentTypeID;
		self.Jgmts48_JudgmentType     := ri.LnJJudgments[48].JudgmentType        ;
		self.Jgmts48_Amount       := ri.LnJJudgments[48].Amount          ;
		self.Jgmts48_ReleaseDate  := ri.LnJJudgments[48].ReleaseDate ;
		self.Jgmts48_FilingDescription  := ri.LnJJudgments[48].FilingDescription;
		self.Jgmts48_DateLastSeen := ri.LnJJudgments[48].DateLastSeen;
		self.Jgmts48_Defendant    := ri.LnJJudgments[48].Defendant;
		self.Jgmts48_Plaintiff    := ri.LnJJudgments[48].Plaintiff;
		self.Jgmts48_FilingNumber := ri.LnJJudgments[48].FilingNumber    ;
		self.Jgmts48_FilingBook   := ri.LnJJudgments[48].FilingBook      ;
		self.Jgmts48_FilingPage   := ri.LnJJudgments[48].FilingPage;
		self.Jgmts48_Eviction     := ri.LnJJudgments[48].Eviction;
		self.Jgmts48_Agency       := ri.LnJJudgments[48].Agency          ;
		self.Jgmts48_AgencyCounty := ri.LnJJudgments[48].AgencyCounty    ;
		self.Jgmts48_AgencyState  := ri.LnJJudgments[48].AgencyState     ;
		self.Jgmts48_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[48].ConsumerStatementId);
    self.Jgmts48_orig_rmsid       := ri.LnJJudgments[48].orig_rmsid;
		self.Jgmts49_Seq          := ri.LnJJudgments[49].Seq             ;
		self.Jgmts49_DateFiled    := ri.LnJJudgments[49].DateFiled       ;
  self.Jgmts49_JudgmentTypeID := ri.LnJJudgments[49].JudgmentTypeID;
		self.Jgmts49_JudgmentType     := ri.LnJJudgments[49].JudgmentType        ;
		self.Jgmts49_Amount       := ri.LnJJudgments[49].Amount          ;
		self.Jgmts49_ReleaseDate  := ri.LnJJudgments[49].ReleaseDate ; 
		self.Jgmts49_FilingDescription  := ri.LnJJudgments[49].FilingDescription;
		self.Jgmts49_DateLastSeen := ri.LnJJudgments[49].DateLastSeen;
		self.Jgmts49_Defendant    := ri.LnJJudgments[49].Defendant;
		self.Jgmts49_Plaintiff    := ri.LnJJudgments[49].Plaintiff;
		self.Jgmts49_FilingNumber := ri.LnJJudgments[49].FilingNumber    ;
		self.Jgmts49_FilingBook   := ri.LnJJudgments[49].FilingBook      ;
		self.Jgmts49_FilingPage   := ri.LnJJudgments[49].FilingPage;
		self.Jgmts49_Eviction     := ri.LnJJudgments[49].Eviction;
		self.Jgmts49_Agency       := ri.LnJJudgments[49].Agency          ;
		self.Jgmts49_AgencyCounty := ri.LnJJudgments[49].AgencyCounty    ;
		self.Jgmts49_AgencyState  := ri.LnJJudgments[49].AgencyState     ;
		self.Jgmts49_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[49].ConsumerStatementId);
    self.Jgmts49_orig_rmsid       := ri.LnJJudgments[49].orig_rmsid;
		self.Jgmts50_Seq      := ri.LnJJudgments[50].Seq         ;
		self.Jgmts50_DateFiled    := ri.LnJJudgments[50].DateFiled       ;
  self.Jgmts50_JudgmentTypeID := ri.LnJJudgments[50].JudgmentTypeID;
		self.Jgmts50_JudgmentType     := ri.LnJJudgments[50].JudgmentType        ;
		self.Jgmts50_Amount       := ri.LnJJudgments[50].Amount          ;
		self.Jgmts50_ReleaseDate  := ri.LnJJudgments[50].ReleaseDate ; 
		self.Jgmts50_FilingDescription  := ri.LnJJudgments[50].FilingDescription;
		self.Jgmts50_DateLastSeen := ri.LnJJudgments[50].DateLastSeen;
		self.Jgmts50_Defendant    := ri.LnJJudgments[50].Defendant;
		self.Jgmts50_Plaintiff    := ri.LnJJudgments[50].Plaintiff;
		self.Jgmts50_FilingNumber := ri.LnJJudgments[50].FilingNumber    ;
		self.Jgmts50_FilingBook   := ri.LnJJudgments[50].FilingBook      ;
		self.Jgmts50_FilingPage   := ri.LnJJudgments[50].FilingPage;
		self.Jgmts50_Eviction     := ri.LnJJudgments[50].Eviction;
		self.Jgmts50_Agency       := ri.LnJJudgments[50].Agency          ;
		self.Jgmts50_AgencyCounty := ri.LnJJudgments[50].AgencyCounty    ;
		self.Jgmts50_AgencyState  := ri.LnJJudgments[50].AgencyState     ;
		self.Jgmts50_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[50].ConsumerStatementId);
    self.Jgmts50_orig_rmsid       := ri.LnJJudgments[50].orig_rmsid;
		self.Jgmts51_Seq          := ri.LnJJudgments[51].Seq             ;
		self.Jgmts51_DateFiled    := ri.LnJJudgments[51].DateFiled       ;
  self.Jgmts51_JudgmentTypeID := ri.LnJJudgments[51].JudgmentTypeID;
		self.Jgmts51_JudgmentType     := ri.LnJJudgments[51].JudgmentType        ;
		self.Jgmts51_Amount       := ri.LnJJudgments[51].Amount          ;
		self.Jgmts51_ReleaseDate  := ri.LnJJudgments[51].ReleaseDate ;
		self.Jgmts51_FilingDescription  := ri.LnJJudgments[51].FilingDescription;
		self.Jgmts51_DateLastSeen := ri.LnJJudgments[51].DateLastSeen;
		self.Jgmts51_Defendant    := ri.LnJJudgments[51].Defendant;
		self.Jgmts51_Plaintiff    := ri.LnJJudgments[51].Plaintiff;
		self.Jgmts51_FilingNumber := ri.LnJJudgments[51].FilingNumber    ;
		self.Jgmts51_FilingBook   := ri.LnJJudgments[51].FilingBook      ;
		self.Jgmts51_FilingPage   := ri.LnJJudgments[51].FilingPage;
		self.Jgmts51_Eviction     := ri.LnJJudgments[51].Eviction;
		self.Jgmts51_Agency       := ri.LnJJudgments[51].Agency          ;
		self.Jgmts51_AgencyCounty := ri.LnJJudgments[51].AgencyCounty    ;
		self.Jgmts51_AgencyState  := ri.LnJJudgments[51].AgencyState     ;
		self.Jgmts51_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[51].ConsumerStatementId);
    self.Jgmts51_orig_rmsid       := ri.LnJJudgments[51].orig_rmsid;
		self.Jgmts52_Seq          := ri.LnJJudgments[52].Seq             ;
		self.Jgmts52_DateFiled    := ri.LnJJudgments[52].DateFiled       ;
  self.Jgmts52_JudgmentTypeID := ri.LnJJudgments[52].JudgmentTypeID;
		self.Jgmts52_JudgmentType     := ri.LnJJudgments[52].JudgmentType        ;
		self.Jgmts52_Amount       := ri.LnJJudgments[52].Amount          ;
		self.Jgmts52_ReleaseDate  := ri.LnJJudgments[52].ReleaseDate ; 
		self.Jgmts52_FilingDescription  := ri.LnJJudgments[52].FilingDescription;
		self.Jgmts52_DateLastSeen := ri.LnJJudgments[52].DateLastSeen;
		self.Jgmts52_Defendant    := ri.LnJJudgments[52].Defendant;
		self.Jgmts52_Plaintiff    := ri.LnJJudgments[52].Plaintiff;
		self.Jgmts52_FilingNumber := ri.LnJJudgments[52].FilingNumber    ;
		self.Jgmts52_FilingBook   := ri.LnJJudgments[52].FilingBook      ;
		self.Jgmts52_FilingPage   := ri.LnJJudgments[52].FilingPage;
		self.Jgmts52_Eviction     := ri.LnJJudgments[52].Eviction;
		self.Jgmts52_Agency       := ri.LnJJudgments[52].Agency          ;
		self.Jgmts52_AgencyCounty := ri.LnJJudgments[52].AgencyCounty    ;
		self.Jgmts52_AgencyState  := ri.LnJJudgments[52].AgencyState     ;
		self.Jgmts52_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[52].ConsumerStatementId);
    self.Jgmts52_orig_rmsid       := ri.LnJJudgments[52].orig_rmsid;
		self.Jgmts53_Seq          := ri.LnJJudgments[53].Seq             ;
		self.Jgmts53_DateFiled    := ri.LnJJudgments[53].DateFiled       ;
  self.Jgmts53_JudgmentTypeID := ri.LnJJudgments[53].JudgmentTypeID;
		self.Jgmts53_JudgmentType     := ri.LnJJudgments[53].JudgmentType        ;
		self.Jgmts53_Amount       := ri.LnJJudgments[53].Amount          ;
		self.Jgmts53_ReleaseDate  := ri.LnJJudgments[53].ReleaseDate ; 
		self.Jgmts53_FilingDescription  := ri.LnJJudgments[53].FilingDescription;
		self.Jgmts53_DateLastSeen := ri.LnJJudgments[53].DateLastSeen;
		self.Jgmts53_Defendant    := ri.LnJJudgments[53].Defendant;
		self.Jgmts53_Plaintiff    := ri.LnJJudgments[53].Plaintiff;
		self.Jgmts53_FilingNumber := ri.LnJJudgments[53].FilingNumber    ;
		self.Jgmts53_FilingBook   := ri.LnJJudgments[53].FilingBook      ;
		self.Jgmts53_FilingPage   := ri.LnJJudgments[53].FilingPage;
		self.Jgmts53_Eviction     := ri.LnJJudgments[53].Eviction;
		self.Jgmts53_Agency       := ri.LnJJudgments[53].Agency          ;
		self.Jgmts53_AgencyCounty := ri.LnJJudgments[53].AgencyCounty    ;
		self.Jgmts53_AgencyState  := ri.LnJJudgments[53].AgencyState     ;
		self.Jgmts53_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[53].ConsumerStatementId);
    self.Jgmts53_orig_rmsid       := ri.LnJJudgments[53].orig_rmsid;
		self.Jgmts54_Seq          := ri.LnJJudgments[54].Seq             ;
		self.Jgmts54_DateFiled    := ri.LnJJudgments[54].DateFiled       ;
  self.Jgmts54_JudgmentTypeID := ri.LnJJudgments[54].JudgmentTypeID;
		self.Jgmts54_JudgmentType     := ri.LnJJudgments[54].JudgmentType        ;
		self.Jgmts54_Amount       := ri.LnJJudgments[54].Amount          ;
		self.Jgmts54_ReleaseDate  := ri.LnJJudgments[54].ReleaseDate ; 
		self.Jgmts54_FilingDescription  := ri.LnJJudgments[54].FilingDescription;
		self.Jgmts54_DateLastSeen := ri.LnJJudgments[54].DateLastSeen;
		self.Jgmts54_Defendant    := ri.LnJJudgments[54].Defendant;
		self.Jgmts54_Plaintiff    := ri.LnJJudgments[54].Plaintiff;
		self.Jgmts54_FilingNumber := ri.LnJJudgments[54].FilingNumber    ;
		self.Jgmts54_FilingBook   := ri.LnJJudgments[54].FilingBook      ;
		self.Jgmts54_FilingPage   := ri.LnJJudgments[54].FilingPage;
		self.Jgmts54_Eviction     := ri.LnJJudgments[54].Eviction;
		self.Jgmts54_Agency       := ri.LnJJudgments[54].Agency          ;
		self.Jgmts54_AgencyCounty := ri.LnJJudgments[54].AgencyCounty    ;
		self.Jgmts54_AgencyState  := ri.LnJJudgments[54].AgencyState     ;
		self.Jgmts54_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[54].ConsumerStatementId);
    self.Jgmts54_orig_rmsid       := ri.LnJJudgments[54].orig_rmsid;
		self.Jgmts55_Seq          := ri.LnJJudgments[55].Seq             ;
		self.Jgmts55_DateFiled    := ri.LnJJudgments[55].DateFiled       ;
  self.Jgmts55_JudgmentTypeID := ri.LnJJudgments[55].JudgmentTypeID;
		self.Jgmts55_JudgmentType     := ri.LnJJudgments[55].JudgmentType        ;
		self.Jgmts55_Amount       := ri.LnJJudgments[55].Amount          ;
		self.Jgmts55_ReleaseDate  := ri.LnJJudgments[55].ReleaseDate ; 
		self.Jgmts55_FilingDescription  := ri.LnJJudgments[55].FilingDescription;
		self.Jgmts55_DateLastSeen := ri.LnJJudgments[55].DateLastSeen;
		self.Jgmts55_Defendant    := ri.LnJJudgments[55].Defendant;
		self.Jgmts55_Plaintiff    := ri.LnJJudgments[55].Plaintiff;
		self.Jgmts55_FilingNumber := ri.LnJJudgments[55].FilingNumber    ;
		self.Jgmts55_FilingBook   := ri.LnJJudgments[55].FilingBook      ;
		self.Jgmts55_FilingPage   := ri.LnJJudgments[55].FilingPage;
		self.Jgmts55_Eviction     := ri.LnJJudgments[55].Eviction;
		self.Jgmts55_Agency       := ri.LnJJudgments[55].Agency          ;
		self.Jgmts55_AgencyCounty := ri.LnJJudgments[55].AgencyCounty    ;
		self.Jgmts55_AgencyState  := ri.LnJJudgments[55].AgencyState     ;
		self.Jgmts55_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[55].ConsumerStatementId);
    self.Jgmts55_orig_rmsid       := ri.LnJJudgments[55].orig_rmsid;
		self.Jgmts56_Seq          := ri.LnJJudgments[56].Seq             ;
		self.Jgmts56_DateFiled    := ri.LnJJudgments[56].DateFiled       ;
  self.Jgmts56_JudgmentTypeID := ri.LnJJudgments[56].JudgmentTypeID;
		self.Jgmts56_JudgmentType     := ri.LnJJudgments[56].JudgmentType        ;
		self.Jgmts56_Amount       := ri.LnJJudgments[56].Amount          ;
		self.Jgmts56_ReleaseDate  := ri.LnJJudgments[56].ReleaseDate ; 
		self.Jgmts56_FilingDescription  := ri.LnJJudgments[56].FilingDescription;
		self.Jgmts56_DateLastSeen := ri.LnJJudgments[56].DateLastSeen;
		self.Jgmts56_Defendant    := ri.LnJJudgments[56].Defendant;
		self.Jgmts56_Plaintiff    := ri.LnJJudgments[56].Plaintiff;
		self.Jgmts56_FilingNumber := ri.LnJJudgments[56].FilingNumber    ;
		self.Jgmts56_FilingBook   := ri.LnJJudgments[56].FilingBook      ;
		self.Jgmts56_FilingPage   := ri.LnJJudgments[56].FilingPage;
		self.Jgmts56_Eviction     := ri.LnJJudgments[56].Eviction;
		self.Jgmts56_Agency       := ri.LnJJudgments[56].Agency          ;
		self.Jgmts56_AgencyCounty := ri.LnJJudgments[56].AgencyCounty    ;
		self.Jgmts56_AgencyState  := ri.LnJJudgments[56].AgencyState     ;
		self.Jgmts56_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[56].ConsumerStatementId);
    self.Jgmts56_orig_rmsid       := ri.LnJJudgments[56].orig_rmsid;
		self.Jgmts57_Seq          := ri.LnJJudgments[57].Seq             ;
		self.Jgmts57_DateFiled    := ri.LnJJudgments[57].DateFiled       ;
  self.Jgmts57_JudgmentTypeID := ri.LnJJudgments[57].JudgmentTypeID;
		self.Jgmts57_JudgmentType     := ri.LnJJudgments[57].JudgmentType        ;
		self.Jgmts57_Amount       := ri.LnJJudgments[57].Amount          ;
		self.Jgmts57_ReleaseDate  := ri.LnJJudgments[57].ReleaseDate ;
		self.Jgmts57_FilingDescription  := ri.LnJJudgments[57].FilingDescription;
		self.Jgmts57_DateLastSeen := ri.LnJJudgments[57].DateLastSeen;
		self.Jgmts57_Defendant    := ri.LnJJudgments[57].Defendant;
		self.Jgmts57_Plaintiff    := ri.LnJJudgments[57].Plaintiff;
		self.Jgmts57_FilingNumber := ri.LnJJudgments[57].FilingNumber    ;
		self.Jgmts57_FilingBook   := ri.LnJJudgments[57].FilingBook      ;
		self.Jgmts57_FilingPage   := ri.LnJJudgments[57].FilingPage;
		self.Jgmts57_Eviction     := ri.LnJJudgments[57].Eviction;
		self.Jgmts57_Agency       := ri.LnJJudgments[57].Agency          ;
		self.Jgmts57_AgencyCounty := ri.LnJJudgments[57].AgencyCounty    ;
		self.Jgmts57_AgencyState  := ri.LnJJudgments[57].AgencyState     ;
		self.Jgmts57_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[57].ConsumerStatementId);
    self.Jgmts57_orig_rmsid       := ri.LnJJudgments[57].orig_rmsid;
		self.Jgmts58_Seq          := ri.LnJJudgments[58].Seq             ;
		self.Jgmts58_DateFiled    := ri.LnJJudgments[58].DateFiled       ;
  self.Jgmts58_JudgmentTypeID := ri.LnJJudgments[58].JudgmentTypeID;
		self.Jgmts58_JudgmentType     := ri.LnJJudgments[58].JudgmentType        ;
		self.Jgmts58_Amount       := ri.LnJJudgments[58].Amount          ;
		self.Jgmts58_ReleaseDate  := ri.LnJJudgments[58].ReleaseDate ;
		self.Jgmts58_FilingDescription  := ri.LnJJudgments[58].FilingDescription;
		self.Jgmts58_DateLastSeen := ri.LnJJudgments[58].DateLastSeen;
		self.Jgmts58_Defendant    := ri.LnJJudgments[58].Defendant;
		self.Jgmts58_Plaintiff    := ri.LnJJudgments[58].Plaintiff;
		self.Jgmts58_FilingNumber := ri.LnJJudgments[58].FilingNumber    ;
		self.Jgmts58_FilingBook   := ri.LnJJudgments[58].FilingBook      ;
		self.Jgmts58_FilingPage   := ri.LnJJudgments[58].FilingPage;
		self.Jgmts58_Eviction     := ri.LnJJudgments[58].Eviction;
		self.Jgmts58_Agency       := ri.LnJJudgments[58].Agency          ;
		self.Jgmts58_AgencyCounty := ri.LnJJudgments[58].AgencyCounty    ;
		self.Jgmts58_AgencyState  := ri.LnJJudgments[58].AgencyState     ;
		self.Jgmts58_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[58].ConsumerStatementId);
    self.Jgmts58_orig_rmsid       := ri.LnJJudgments[58].orig_rmsid;
		self.Jgmts59_Seq          := ri.LnJJudgments[59].Seq             ;
		self.Jgmts59_DateFiled    := ri.LnJJudgments[59].DateFiled       ;
  self.Jgmts59_JudgmentTypeID := ri.LnJJudgments[59].JudgmentTypeID;
		self.Jgmts59_JudgmentType     := ri.LnJJudgments[59].JudgmentType        ;
		self.Jgmts59_Amount       := ri.LnJJudgments[59].Amount          ;
		self.Jgmts59_ReleaseDate  := ri.LnJJudgments[59].ReleaseDate ;
		self.Jgmts59_FilingDescription  := ri.LnJJudgments[59].FilingDescription;
		self.Jgmts59_DateLastSeen := ri.LnJJudgments[59].DateLastSeen;
		self.Jgmts59_Defendant    := ri.LnJJudgments[59].Defendant;
		self.Jgmts59_Plaintiff    := ri.LnJJudgments[59].Plaintiff;
		self.Jgmts59_FilingNumber := ri.LnJJudgments[59].FilingNumber    ;
		self.Jgmts59_FilingBook   := ri.LnJJudgments[59].FilingBook      ;
		self.Jgmts59_FilingPage   := ri.LnJJudgments[59].FilingPage;
		self.Jgmts59_Eviction     := ri.LnJJudgments[59].Eviction;
		self.Jgmts59_Agency       := ri.LnJJudgments[59].Agency          ;
		self.Jgmts59_AgencyCounty := ri.LnJJudgments[59].AgencyCounty    ;
		self.Jgmts59_AgencyState  := ri.LnJJudgments[59].AgencyState     ;
		self.Jgmts59_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[59].ConsumerStatementId);
    self.Jgmts59_orig_rmsid       := ri.LnJJudgments[59].orig_rmsid;
		self.Jgmts60_Seq          := ri.LnJJudgments[60].Seq             ;
		self.Jgmts60_DateFiled    := ri.LnJJudgments[60].DateFiled       ;
  self.Jgmts60_JudgmentTypeID := ri.LnJJudgments[60].JudgmentTypeID;
		self.Jgmts60_JudgmentType     := ri.LnJJudgments[60].JudgmentType        ;
		self.Jgmts60_Amount       := ri.LnJJudgments[60].Amount          ;
		self.Jgmts60_ReleaseDate  := ri.LnJJudgments[60].ReleaseDate ;
		self.Jgmts60_FilingDescription  := ri.LnJJudgments[60].FilingDescription;
		self.Jgmts60_DateLastSeen := ri.LnJJudgments[60].DateLastSeen;
		self.Jgmts60_Defendant    := ri.LnJJudgments[60].Defendant;
		self.Jgmts60_Plaintiff    := ri.LnJJudgments[60].Plaintiff;
		self.Jgmts60_FilingNumber := ri.LnJJudgments[60].FilingNumber    ;
		self.Jgmts60_FilingBook   := ri.LnJJudgments[60].FilingBook      ;
		self.Jgmts60_FilingPage   := ri.LnJJudgments[60].FilingPage;
		self.Jgmts60_Eviction     := ri.LnJJudgments[60].Eviction;
		self.Jgmts60_Agency       := ri.LnJJudgments[60].Agency          ;
		self.Jgmts60_AgencyCounty := ri.LnJJudgments[60].AgencyCounty    ;
		self.Jgmts60_AgencyState  := ri.LnJJudgments[60].AgencyState     ;
		self.Jgmts60_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[60].ConsumerStatementId);
    self.Jgmts60_orig_rmsid       := ri.LnJJudgments[60].orig_rmsid;
		self.Jgmts61_Seq          := ri.LnJJudgments[61].Seq             ;
		self.Jgmts61_DateFiled    := ri.LnJJudgments[61].DateFiled       ;
  self.Jgmts61_JudgmentTypeID := ri.LnJJudgments[61].JudgmentTypeID;
		self.Jgmts61_JudgmentType     := ri.LnJJudgments[61].JudgmentType        ;
		self.Jgmts61_Amount       := ri.LnJJudgments[61].Amount          ;
		self.Jgmts61_ReleaseDate  := ri.LnJJudgments[61].ReleaseDate ; 
		self.Jgmts61_FilingDescription  := ri.LnJJudgments[61].FilingDescription;
		self.Jgmts61_DateLastSeen := ri.LnJJudgments[61].DateLastSeen;
		self.Jgmts61_Defendant    := ri.LnJJudgments[61].Defendant;
		self.Jgmts61_Plaintiff    := ri.LnJJudgments[61].Plaintiff;
		self.Jgmts61_FilingNumber := ri.LnJJudgments[61].FilingNumber    ;
		self.Jgmts61_FilingBook   := ri.LnJJudgments[61].FilingBook      ;
		self.Jgmts61_FilingPage   := ri.LnJJudgments[61].FilingPage;
		self.Jgmts61_Eviction     := ri.LnJJudgments[61].Eviction;
		self.Jgmts61_Agency       := ri.LnJJudgments[61].Agency          ;
		self.Jgmts61_AgencyCounty := ri.LnJJudgments[61].AgencyCounty    ;
		self.Jgmts61_AgencyState  := ri.LnJJudgments[61].AgencyState     ;
		self.Jgmts61_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[61].ConsumerStatementId);
    self.Jgmts61_orig_rmsid       := ri.LnJJudgments[61].orig_rmsid;
		self.Jgmts62_Seq          := ri.LnJJudgments[62].Seq             ;
		self.Jgmts62_DateFiled    := ri.LnJJudgments[62].DateFiled       ;
  self.Jgmts62_JudgmentTypeID := ri.LnJJudgments[62].JudgmentTypeID;
		self.Jgmts62_JudgmentType     := ri.LnJJudgments[62].JudgmentType        ;
		self.Jgmts62_Amount       := ri.LnJJudgments[62].Amount          ;
		self.Jgmts62_ReleaseDate  := ri.LnJJudgments[62].ReleaseDate ; 
		self.Jgmts62_FilingDescription  := ri.LnJJudgments[62].FilingDescription;
		self.Jgmts62_DateLastSeen := ri.LnJJudgments[62].DateLastSeen;
		self.Jgmts62_Defendant    := ri.LnJJudgments[62].Defendant;
		self.Jgmts62_Plaintiff    := ri.LnJJudgments[62].Plaintiff;
		self.Jgmts62_FilingNumber := ri.LnJJudgments[62].FilingNumber    ;
		self.Jgmts62_FilingBook   := ri.LnJJudgments[62].FilingBook      ;
		self.Jgmts62_FilingPage   := ri.LnJJudgments[62].FilingPage;
		self.Jgmts62_Eviction     := ri.LnJJudgments[62].Eviction;
		self.Jgmts62_Agency       := ri.LnJJudgments[62].Agency          ;
		self.Jgmts62_AgencyCounty := ri.LnJJudgments[62].AgencyCounty    ;
		self.Jgmts62_AgencyState  := ri.LnJJudgments[62].AgencyState     ;
		self.Jgmts62_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[62].ConsumerStatementId);
    self.Jgmts62_orig_rmsid       := ri.LnJJudgments[62].orig_rmsid;
		self.Jgmts63_Seq          := ri.LnJJudgments[63].Seq             ;
		self.Jgmts63_DateFiled    := ri.LnJJudgments[63].DateFiled       ;
  self.Jgmts63_JudgmentTypeID := ri.LnJJudgments[63].JudgmentTypeID;
		self.Jgmts63_JudgmentType     := ri.LnJJudgments[63].JudgmentType        ;
		self.Jgmts63_Amount       := ri.LnJJudgments[63].Amount          ;
		self.Jgmts63_ReleaseDate  := ri.LnJJudgments[63].ReleaseDate ; 
		self.Jgmts63_FilingDescription  := ri.LnJJudgments[63].FilingDescription;
		self.Jgmts63_DateLastSeen := ri.LnJJudgments[63].DateLastSeen;
		self.Jgmts63_Defendant    := ri.LnJJudgments[63].Defendant;
		self.Jgmts63_Plaintiff    := ri.LnJJudgments[63].Plaintiff;
		self.Jgmts63_FilingNumber := ri.LnJJudgments[63].FilingNumber    ;
		self.Jgmts63_FilingBook   := ri.LnJJudgments[63].FilingBook      ;
		self.Jgmts63_FilingPage   := ri.LnJJudgments[63].FilingPage;
		self.Jgmts63_Eviction     := ri.LnJJudgments[63].Eviction;
		self.Jgmts63_Agency       := ri.LnJJudgments[63].Agency          ;
		self.Jgmts63_AgencyCounty := ri.LnJJudgments[63].AgencyCounty    ;
		self.Jgmts63_AgencyState  := ri.LnJJudgments[63].AgencyState     ;
		self.Jgmts63_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[63].ConsumerStatementId);
    self.Jgmts63_orig_rmsid       := ri.LnJJudgments[63].orig_rmsid;
		self.Jgmts64_Seq          := ri.LnJJudgments[64].Seq             ;
		self.Jgmts64_DateFiled    := ri.LnJJudgments[64].DateFiled       ;
  self.Jgmts64_JudgmentTypeID := ri.LnJJudgments[64].JudgmentTypeID;
		self.Jgmts64_JudgmentType     := ri.LnJJudgments[64].JudgmentType        ;
		self.Jgmts64_Amount       := ri.LnJJudgments[64].Amount          ;
		self.Jgmts64_ReleaseDate  := ri.LnJJudgments[64].ReleaseDate ;  
		self.Jgmts64_FilingDescription  := ri.LnJJudgments[64].FilingDescription;
		self.Jgmts64_DateLastSeen := ri.LnJJudgments[64].DateLastSeen;
		self.Jgmts64_Defendant    := ri.LnJJudgments[64].Defendant;
		self.Jgmts64_Plaintiff    := ri.LnJJudgments[64].Plaintiff;
		self.Jgmts64_FilingNumber := ri.LnJJudgments[64].FilingNumber    ;
		self.Jgmts64_FilingBook   := ri.LnJJudgments[64].FilingBook      ;
		self.Jgmts64_FilingPage   := ri.LnJJudgments[64].FilingPage;
		self.Jgmts64_Eviction     := ri.LnJJudgments[64].Eviction;
		self.Jgmts64_Agency       := ri.LnJJudgments[64].Agency          ;
		self.Jgmts64_AgencyCounty := ri.LnJJudgments[64].AgencyCounty    ;
		self.Jgmts64_AgencyState  := ri.LnJJudgments[64].AgencyState     ;
		self.Jgmts64_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[64].ConsumerStatementId);
    self.Jgmts64_orig_rmsid       := ri.LnJJudgments[64].orig_rmsid;
		self.Jgmts65_Seq          := ri.LnJJudgments[65].Seq             ;
		self.Jgmts65_DateFiled    := ri.LnJJudgments[65].DateFiled       ;
  self.Jgmts65_JudgmentTypeID := ri.LnJJudgments[65].JudgmentTypeID;
		self.Jgmts65_JudgmentType     := ri.LnJJudgments[65].JudgmentType        ;
		self.Jgmts65_Amount       := ri.LnJJudgments[65].Amount          ;
		self.Jgmts65_ReleaseDate  := ri.LnJJudgments[65].ReleaseDate ;
		self.Jgmts65_FilingDescription  := ri.LnJJudgments[65].FilingDescription;
		self.Jgmts65_DateLastSeen := ri.LnJJudgments[65].DateLastSeen;
		self.Jgmts65_Defendant    := ri.LnJJudgments[65].Defendant;
		self.Jgmts65_Plaintiff    := ri.LnJJudgments[65].Plaintiff;
		self.Jgmts65_FilingNumber := ri.LnJJudgments[65].FilingNumber    ;
		self.Jgmts65_FilingBook   := ri.LnJJudgments[65].FilingBook      ;
		self.Jgmts65_FilingPage   := ri.LnJJudgments[65].FilingPage;
		self.Jgmts65_Eviction     := ri.LnJJudgments[65].Eviction;
		self.Jgmts65_Agency       := ri.LnJJudgments[65].Agency          ;
		self.Jgmts65_AgencyCounty := ri.LnJJudgments[65].AgencyCounty    ;
		self.Jgmts65_AgencyState  := ri.LnJJudgments[65].AgencyState     ;
		self.Jgmts65_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[65].ConsumerStatementId);
    self.Jgmts65_orig_rmsid       := ri.LnJJudgments[65].orig_rmsid;
		self.Jgmts66_Seq          := ri.LnJJudgments[66].Seq             ;
		self.Jgmts66_DateFiled    := ri.LnJJudgments[66].DateFiled       ;
  self.Jgmts66_JudgmentTypeID := ri.LnJJudgments[66].JudgmentTypeID;
		self.Jgmts66_JudgmentType     := ri.LnJJudgments[66].JudgmentType        ;
		self.Jgmts66_Amount       := ri.LnJJudgments[66].Amount          ;
		self.Jgmts66_ReleaseDate  := ri.LnJJudgments[66].ReleaseDate ;
		self.Jgmts66_FilingDescription  := ri.LnJJudgments[66].FilingDescription;
		self.Jgmts66_DateLastSeen := ri.LnJJudgments[66].DateLastSeen;
		self.Jgmts66_Defendant    := ri.LnJJudgments[66].Defendant;
		self.Jgmts66_Plaintiff    := ri.LnJJudgments[66].Plaintiff;
		self.Jgmts66_FilingNumber := ri.LnJJudgments[66].FilingNumber    ;
		self.Jgmts66_FilingBook   := ri.LnJJudgments[66].FilingBook      ;
		self.Jgmts66_FilingPage   := ri.LnJJudgments[66].FilingPage;
		self.Jgmts66_Eviction     := ri.LnJJudgments[66].Eviction;
		self.Jgmts66_Agency       := ri.LnJJudgments[66].Agency          ;
		self.Jgmts66_AgencyCounty := ri.LnJJudgments[66].AgencyCounty    ;
		self.Jgmts66_AgencyState  := ri.LnJJudgments[66].AgencyState     ;
		self.Jgmts66_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[66].ConsumerStatementId);
    self.Jgmts66_orig_rmsid       := ri.LnJJudgments[66].orig_rmsid;
		self.Jgmts67_Seq          := ri.LnJJudgments[67].Seq             ;
		self.Jgmts67_DateFiled    := ri.LnJJudgments[67].DateFiled       ;
  self.Jgmts67_JudgmentTypeID := ri.LnJJudgments[67].JudgmentTypeID;
		self.Jgmts67_JudgmentType     := ri.LnJJudgments[67].JudgmentType        ;
		self.Jgmts67_Amount       := ri.LnJJudgments[67].Amount          ;
		self.Jgmts67_ReleaseDate  := ri.LnJJudgments[67].ReleaseDate ;
		self.Jgmts67_FilingDescription  := ri.LnJJudgments[67].FilingDescription;
		self.Jgmts67_DateLastSeen := ri.LnJJudgments[67].DateLastSeen;
		self.Jgmts67_Defendant    := ri.LnJJudgments[67].Defendant;
		self.Jgmts67_Plaintiff    := ri.LnJJudgments[67].Plaintiff;
		self.Jgmts67_FilingNumber := ri.LnJJudgments[67].FilingNumber    ;
		self.Jgmts67_FilingBook   := ri.LnJJudgments[67].FilingBook      ;
		self.Jgmts67_FilingPage   := ri.LnJJudgments[67].FilingPage;
		self.Jgmts67_Eviction     := ri.LnJJudgments[67].Eviction;
		self.Jgmts67_Agency       := ri.LnJJudgments[67].Agency          ;
		self.Jgmts67_AgencyCounty := ri.LnJJudgments[67].AgencyCounty    ;
		self.Jgmts67_AgencyState  := ri.LnJJudgments[67].AgencyState     ;
		self.Jgmts67_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[67].ConsumerStatementId);
    self.Jgmts67_orig_rmsid       := ri.LnJJudgments[67].orig_rmsid;
		self.Jgmts68_Seq          := ri.LnJJudgments[68].Seq             ;
		self.Jgmts68_DateFiled    := ri.LnJJudgments[68].DateFiled       ;
  self.Jgmts68_JudgmentTypeID := ri.LnJJudgments[68].JudgmentTypeID;
		self.Jgmts68_JudgmentType     := ri.LnJJudgments[68].JudgmentType        ;
		self.Jgmts68_Amount       := ri.LnJJudgments[68].Amount          ;
		self.Jgmts68_ReleaseDate  := ri.LnJJudgments[68].ReleaseDate ; 
		self.Jgmts68_FilingDescription  := ri.LnJJudgments[68].FilingDescription;
		self.Jgmts68_DateLastSeen := ri.LnJJudgments[68].DateLastSeen;
		self.Jgmts68_Defendant    := ri.LnJJudgments[68].Defendant;
		self.Jgmts68_Plaintiff    := ri.LnJJudgments[68].Plaintiff;
		self.Jgmts68_FilingNumber := ri.LnJJudgments[68].FilingNumber    ;
		self.Jgmts68_FilingBook   := ri.LnJJudgments[68].FilingBook      ;
		self.Jgmts68_FilingPage   := ri.LnJJudgments[68].FilingPage;
		self.Jgmts68_Eviction     := ri.LnJJudgments[68].Eviction;
		self.Jgmts68_Agency       := ri.LnJJudgments[68].Agency          ;
		self.Jgmts68_AgencyCounty := ri.LnJJudgments[68].AgencyCounty    ;
		self.Jgmts68_AgencyState  := ri.LnJJudgments[68].AgencyState     ;
		self.Jgmts68_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[68].ConsumerStatementId);
    self.Jgmts68_orig_rmsid       := ri.LnJJudgments[68].orig_rmsid;
		self.Jgmts69_Seq          := ri.LnJJudgments[69].Seq             ;
		self.Jgmts69_DateFiled    := ri.LnJJudgments[69].DateFiled       ;
  self.Jgmts69_JudgmentTypeID := ri.LnJJudgments[69].JudgmentTypeID;
		self.Jgmts69_JudgmentType     := ri.LnJJudgments[69].JudgmentType        ;
		self.Jgmts69_Amount       := ri.LnJJudgments[69].Amount          ;
		self.Jgmts69_ReleaseDate  := ri.LnJJudgments[69].ReleaseDate ; 
		self.Jgmts69_FilingDescription  := ri.LnJJudgments[69].FilingDescription;
		self.Jgmts69_DateLastSeen := ri.LnJJudgments[69].DateLastSeen;
		self.Jgmts69_Defendant    := ri.LnJJudgments[69].Defendant;
		self.Jgmts69_Plaintiff    := ri.LnJJudgments[69].Plaintiff;
		self.Jgmts69_FilingNumber := ri.LnJJudgments[69].FilingNumber    ;
		self.Jgmts69_FilingBook   := ri.LnJJudgments[69].FilingBook      ;
		self.Jgmts69_FilingPage   := ri.LnJJudgments[69].FilingPage;
		self.Jgmts69_Eviction     := ri.LnJJudgments[69].Eviction;
		self.Jgmts69_Agency       := ri.LnJJudgments[69].Agency          ;
		self.Jgmts69_AgencyCounty := ri.LnJJudgments[69].AgencyCounty    ;
		self.Jgmts69_AgencyState  := ri.LnJJudgments[69].AgencyState     ;
		self.Jgmts69_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[69].ConsumerStatementId);
    self.Jgmts69_orig_rmsid       := ri.LnJJudgments[69].orig_rmsid;
		self.Jgmts70_Seq         := ri.LnJJudgments[70].Seq            ;
		self.Jgmts70_DateFiled    := ri.LnJJudgments[70].DateFiled       ;
  self.Jgmts70_JudgmentTypeID := ri.LnJJudgments[70].JudgmentTypeID;
		self.Jgmts70_JudgmentType     := ri.LnJJudgments[70].JudgmentType        ;
		self.Jgmts70_Amount       := ri.LnJJudgments[70].Amount          ;
		self.Jgmts70_ReleaseDate  := ri.LnJJudgments[70].ReleaseDate ;
		self.Jgmts70_FilingDescription  := ri.LnJJudgments[70].FilingDescription;
		self.Jgmts70_DateLastSeen := ri.LnJJudgments[70].DateLastSeen;
		self.Jgmts70_Defendant    := ri.LnJJudgments[70].Defendant;
		self.Jgmts70_Plaintiff    := ri.LnJJudgments[70].Plaintiff;
		self.Jgmts70_FilingNumber := ri.LnJJudgments[70].FilingNumber    ;
		self.Jgmts70_FilingBook   := ri.LnJJudgments[70].FilingBook      ;
		self.Jgmts70_FilingPage   := ri.LnJJudgments[70].FilingPage;
		self.Jgmts70_Eviction     := ri.LnJJudgments[70].Eviction;
		self.Jgmts70_Agency       := ri.LnJJudgments[70].Agency          ;
		self.Jgmts70_AgencyCounty := ri.LnJJudgments[70].AgencyCounty    ;
		self.Jgmts70_AgencyState  := ri.LnJJudgments[70].AgencyState     ;
		self.Jgmts70_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[70].ConsumerStatementId);
    self.Jgmts70_orig_rmsid       := ri.LnJJudgments[70].orig_rmsid;
		self.Jgmts71_Seq          := ri.LnJJudgments[71].Seq             ;
		self.Jgmts71_DateFiled    := ri.LnJJudgments[71].DateFiled       ;
  self.Jgmts71_JudgmentTypeID := ri.LnJJudgments[71].JudgmentTypeID;
		self.Jgmts71_JudgmentType     := ri.LnJJudgments[71].JudgmentType        ;
		self.Jgmts71_Amount       := ri.LnJJudgments[71].Amount          ;
		self.Jgmts71_ReleaseDate  := ri.LnJJudgments[71].ReleaseDate ;
		self.Jgmts71_FilingDescription  := ri.LnJJudgments[71].FilingDescription;
		self.Jgmts71_DateLastSeen := ri.LnJJudgments[71].DateLastSeen;
		self.Jgmts71_Defendant    := ri.LnJJudgments[71].Defendant;
		self.Jgmts71_Plaintiff    := ri.LnJJudgments[71].Plaintiff;
		self.Jgmts71_FilingNumber := ri.LnJJudgments[71].FilingNumber    ;
		self.Jgmts71_FilingBook   := ri.LnJJudgments[71].FilingBook      ;
		self.Jgmts71_FilingPage   := ri.LnJJudgments[71].FilingPage;
		self.Jgmts71_Eviction     := ri.LnJJudgments[71].Eviction;
		self.Jgmts71_Agency       := ri.LnJJudgments[71].Agency          ;
		self.Jgmts71_AgencyCounty := ri.LnJJudgments[71].AgencyCounty    ;
		self.Jgmts71_AgencyState  := ri.LnJJudgments[71].AgencyState     ;
		self.Jgmts71_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[71].ConsumerStatementId);
    self.Jgmts71_orig_rmsid       := ri.LnJJudgments[71].orig_rmsid;
		self.Jgmts72_Seq          := ri.LnJJudgments[72].Seq             ;
		self.Jgmts72_DateFiled    := ri.LnJJudgments[72].DateFiled       ;
  self.Jgmts72_JudgmentTypeID := ri.LnJJudgments[72].JudgmentTypeID;
		self.Jgmts72_JudgmentType     := ri.LnJJudgments[72].JudgmentType        ;
		self.Jgmts72_Amount       := ri.LnJJudgments[72].Amount          ;
		self.Jgmts72_ReleaseDate  := ri.LnJJudgments[72].ReleaseDate ; 
		self.Jgmts72_FilingDescription  := ri.LnJJudgments[72].FilingDescription;
		self.Jgmts72_DateLastSeen := ri.LnJJudgments[72].DateLastSeen;
		self.Jgmts72_Defendant    := ri.LnJJudgments[72].Defendant;
		self.Jgmts72_Plaintiff    := ri.LnJJudgments[72].Plaintiff;
		self.Jgmts72_FilingNumber := ri.LnJJudgments[72].FilingNumber    ;
		self.Jgmts72_FilingBook   := ri.LnJJudgments[72].FilingBook      ;
		self.Jgmts72_FilingPage   := ri.LnJJudgments[72].FilingPage;
		self.Jgmts72_Eviction     := ri.LnJJudgments[72].Eviction;
		self.Jgmts72_Agency       := ri.LnJJudgments[72].Agency          ;
		self.Jgmts72_AgencyCounty := ri.LnJJudgments[72].AgencyCounty    ;
		self.Jgmts72_AgencyState  := ri.LnJJudgments[72].AgencyState     ;
		self.Jgmts72_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[72].ConsumerStatementId);
    self.Jgmts72_orig_rmsid       := ri.LnJJudgments[72].orig_rmsid;
		self.Jgmts73_Seq          := ri.LnJJudgments[73].Seq             ;
		self.Jgmts73_DateFiled    := ri.LnJJudgments[73].DateFiled       ;
  self.Jgmts73_JudgmentTypeID := ri.LnJJudgments[73].JudgmentTypeID;
		self.Jgmts73_JudgmentType     := ri.LnJJudgments[73].JudgmentType        ;
		self.Jgmts73_Amount       := ri.LnJJudgments[73].Amount          ;
		self.Jgmts73_ReleaseDate  := ri.LnJJudgments[73].ReleaseDate ; 
		self.Jgmts73_FilingDescription  := ri.LnJJudgments[73].FilingDescription;
		self.Jgmts73_DateLastSeen := ri.LnJJudgments[73].DateLastSeen;
		self.Jgmts73_Defendant    := ri.LnJJudgments[73].Defendant;
		self.Jgmts73_Plaintiff    := ri.LnJJudgments[73].Plaintiff;
		self.Jgmts73_FilingNumber := ri.LnJJudgments[73].FilingNumber    ;
		self.Jgmts73_FilingBook   := ri.LnJJudgments[73].FilingBook      ;
		self.Jgmts73_FilingPage   := ri.LnJJudgments[73].FilingPage;
		self.Jgmts73_Eviction     := ri.LnJJudgments[73].Eviction;
		self.Jgmts73_Agency       := ri.LnJJudgments[73].Agency          ;
		self.Jgmts73_AgencyCounty := ri.LnJJudgments[73].AgencyCounty    ;
		self.Jgmts73_AgencyState  := ri.LnJJudgments[73].AgencyState     ;
		self.Jgmts73_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[73].ConsumerStatementId);
    self.Jgmts73_orig_rmsid       := ri.LnJJudgments[73].orig_rmsid;
		self.Jgmts74_Seq          := ri.LnJJudgments[74].Seq             ;
		self.Jgmts74_DateFiled    := ri.LnJJudgments[74].DateFiled       ;
  self.Jgmts74_JudgmentTypeID := ri.LnJJudgments[74].JudgmentTypeID;
		self.Jgmts74_JudgmentType     := ri.LnJJudgments[74].JudgmentType        ;
		self.Jgmts74_Amount       := ri.LnJJudgments[74].Amount          ;
		self.Jgmts74_ReleaseDate  := ri.LnJJudgments[74].ReleaseDate ; 
		self.Jgmts74_FilingDescription  := ri.LnJJudgments[74].FilingDescription;
		self.Jgmts74_DateLastSeen := ri.LnJJudgments[74].DateLastSeen;
		self.Jgmts74_Defendant    := ri.LnJJudgments[74].Defendant;
		self.Jgmts74_Plaintiff    := ri.LnJJudgments[74].Plaintiff;
		self.Jgmts74_FilingNumber := ri.LnJJudgments[74].FilingNumber    ;
		self.Jgmts74_FilingBook   := ri.LnJJudgments[74].FilingBook      ;
		self.Jgmts74_FilingPage   := ri.LnJJudgments[74].FilingPage;
		self.Jgmts74_Eviction     := ri.LnJJudgments[74].Eviction;
		self.Jgmts74_Agency       := ri.LnJJudgments[74].Agency          ;
		self.Jgmts74_AgencyCounty := ri.LnJJudgments[74].AgencyCounty    ;
		self.Jgmts74_AgencyState  := ri.LnJJudgments[74].AgencyState     ;
		self.Jgmts74_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[74].ConsumerStatementId);
    self.Jgmts74_orig_rmsid       := ri.LnJJudgments[74].orig_rmsid;
		self.Jgmts75_Seq          := ri.LnJJudgments[75].Seq             ;
		self.Jgmts75_DateFiled    := ri.LnJJudgments[75].DateFiled       ;
  self.Jgmts75_JudgmentTypeID := ri.LnJJudgments[75].JudgmentTypeID;
		self.Jgmts75_JudgmentType     := ri.LnJJudgments[75].JudgmentType        ;
		self.Jgmts75_Amount       := ri.LnJJudgments[75].Amount          ;
		self.Jgmts75_ReleaseDate  := ri.LnJJudgments[75].ReleaseDate ;
		self.Jgmts75_FilingDescription  := ri.LnJJudgments[75].FilingDescription;
		self.Jgmts75_DateLastSeen := ri.LnJJudgments[75].DateLastSeen;
		self.Jgmts75_Defendant    := ri.LnJJudgments[75].Defendant;
		self.Jgmts75_Plaintiff    := ri.LnJJudgments[75].Plaintiff;
		self.Jgmts75_FilingNumber := ri.LnJJudgments[75].FilingNumber    ;
		self.Jgmts75_FilingBook   := ri.LnJJudgments[75].FilingBook      ;
		self.Jgmts75_FilingPage   := ri.LnJJudgments[75].FilingPage;
		self.Jgmts75_Eviction     := ri.LnJJudgments[75].Eviction;
		self.Jgmts75_Agency       := ri.LnJJudgments[75].Agency          ;
		self.Jgmts75_AgencyCounty := ri.LnJJudgments[75].AgencyCounty    ;
		self.Jgmts75_AgencyState  := ri.LnJJudgments[75].AgencyState     ;
		self.Jgmts75_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[75].ConsumerStatementId);
    self.Jgmts75_orig_rmsid       := ri.LnJJudgments[75].orig_rmsid;
		self.Jgmts76_Seq          := ri.LnJJudgments[76].Seq             ;
		self.Jgmts76_DateFiled    := ri.LnJJudgments[76].DateFiled       ;
  self.Jgmts76_JudgmentTypeID := ri.LnJJudgments[76].JudgmentTypeID;
		self.Jgmts76_JudgmentType     := ri.LnJJudgments[76].JudgmentType        ;
		self.Jgmts76_Amount       := ri.LnJJudgments[76].Amount          ;
		self.Jgmts76_ReleaseDate  := ri.LnJJudgments[76].ReleaseDate ;
		self.Jgmts76_FilingDescription  := ri.LnJJudgments[76].FilingDescription;
		self.Jgmts76_DateLastSeen := ri.LnJJudgments[76].DateLastSeen;
		self.Jgmts76_Defendant    := ri.LnJJudgments[76].Defendant;
		self.Jgmts76_Plaintiff    := ri.LnJJudgments[76].Plaintiff;
		self.Jgmts76_FilingNumber := ri.LnJJudgments[76].FilingNumber    ;
		self.Jgmts76_FilingBook   := ri.LnJJudgments[76].FilingBook      ;
		self.Jgmts76_FilingPage   := ri.LnJJudgments[76].FilingPage;
		self.Jgmts76_Eviction     := ri.LnJJudgments[76].Eviction;
		self.Jgmts76_Agency       := ri.LnJJudgments[76].Agency          ;
		self.Jgmts76_AgencyCounty := ri.LnJJudgments[76].AgencyCounty    ;
		self.Jgmts76_AgencyState  := ri.LnJJudgments[76].AgencyState     ;
		self.Jgmts76_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[76].ConsumerStatementId);
    self.Jgmts76_orig_rmsid       := ri.LnJJudgments[76].orig_rmsid;
		self.Jgmts77_Seq          := ri.LnJJudgments[77].Seq             ;
		self.Jgmts77_DateFiled    := ri.LnJJudgments[77].DateFiled       ;
  self.Jgmts77_JudgmentTypeID := ri.LnJJudgments[77].JudgmentTypeID;
		self.Jgmts77_JudgmentType     := ri.LnJJudgments[77].JudgmentType        ;
		self.Jgmts77_Amount       := ri.LnJJudgments[77].Amount          ;
		self.Jgmts77_ReleaseDate  := ri.LnJJudgments[77].ReleaseDate ;
		self.Jgmts77_FilingDescription  := ri.LnJJudgments[77].FilingDescription;
		self.Jgmts77_DateLastSeen := ri.LnJJudgments[77].DateLastSeen;
		self.Jgmts77_Defendant    := ri.LnJJudgments[77].Defendant;
		self.Jgmts77_Plaintiff    := ri.LnJJudgments[77].Plaintiff;
		self.Jgmts77_FilingNumber := ri.LnJJudgments[77].FilingNumber    ;
		self.Jgmts77_FilingBook   := ri.LnJJudgments[77].FilingBook      ;
		self.Jgmts77_FilingPage   := ri.LnJJudgments[77].FilingPage;
		self.Jgmts77_Eviction     := ri.LnJJudgments[77].Eviction;
		self.Jgmts77_Agency       := ri.LnJJudgments[77].Agency          ;
		self.Jgmts77_AgencyCounty := ri.LnJJudgments[77].AgencyCounty    ;
		self.Jgmts77_AgencyState  := ri.LnJJudgments[77].AgencyState     ;
		self.Jgmts77_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[77].ConsumerStatementId);
    self.Jgmts77_orig_rmsid       := ri.LnJJudgments[77].orig_rmsid;
		self.Jgmts78_Seq          := ri.LnJJudgments[78].Seq             ;
		self.Jgmts78_DateFiled    := ri.LnJJudgments[78].DateFiled       ;
  self.Jgmts78_JudgmentTypeID := ri.LnJJudgments[78].JudgmentTypeID;
		self.Jgmts78_JudgmentType     := ri.LnJJudgments[78].JudgmentType        ;
		self.Jgmts78_Amount       := ri.LnJJudgments[78].Amount          ;
		self.Jgmts78_ReleaseDate  := ri.LnJJudgments[78].ReleaseDate ;
		self.Jgmts78_FilingDescription  := ri.LnJJudgments[78].FilingDescription;
		self.Jgmts78_DateLastSeen := ri.LnJJudgments[78].DateLastSeen;
		self.Jgmts78_Defendant    := ri.LnJJudgments[78].Defendant;
		self.Jgmts78_Plaintiff    := ri.LnJJudgments[78].Plaintiff;
		self.Jgmts78_FilingNumber := ri.LnJJudgments[78].FilingNumber    ;
		self.Jgmts78_FilingBook   := ri.LnJJudgments[78].FilingBook      ;
		self.Jgmts78_FilingPage   := ri.LnJJudgments[78].FilingPage;
		self.Jgmts78_Eviction     := ri.LnJJudgments[78].Eviction;
		self.Jgmts78_Agency       := ri.LnJJudgments[78].Agency          ;
		self.Jgmts78_AgencyCounty := ri.LnJJudgments[78].AgencyCounty    ;
		self.Jgmts78_AgencyState  := ri.LnJJudgments[78].AgencyState     ;
		self.Jgmts78_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[78].ConsumerStatementId);
    self.Jgmts78_orig_rmsid       := ri.LnJJudgments[78].orig_rmsid;
		self.Jgmts79_Seq          := ri.LnJJudgments[79].Seq             ;
		self.Jgmts79_DateFiled    := ri.LnJJudgments[79].DateFiled       ;
  self.Jgmts79_JudgmentTypeID := ri.LnJJudgments[79].JudgmentTypeID;
		self.Jgmts79_JudgmentType     := ri.LnJJudgments[79].JudgmentType        ;
		self.Jgmts79_Amount       := ri.LnJJudgments[79].Amount          ;
		self.Jgmts79_ReleaseDate  := ri.LnJJudgments[79].ReleaseDate ;
		self.Jgmts79_FilingDescription  := ri.LnJJudgments[79].FilingDescription;
		self.Jgmts79_DateLastSeen := ri.LnJJudgments[79].DateLastSeen;
		self.Jgmts79_Defendant    := ri.LnJJudgments[79].Defendant;
		self.Jgmts79_Plaintiff    := ri.LnJJudgments[79].Plaintiff;
		self.Jgmts79_FilingNumber := ri.LnJJudgments[79].FilingNumber    ;
		self.Jgmts79_FilingBook   := ri.LnJJudgments[79].FilingBook      ;
		self.Jgmts79_FilingPage   := ri.LnJJudgments[79].FilingPage;
		self.Jgmts79_Eviction     := ri.LnJJudgments[79].Eviction;
		self.Jgmts79_Agency       := ri.LnJJudgments[79].Agency          ;
		self.Jgmts79_AgencyCounty := ri.LnJJudgments[79].AgencyCounty    ;
		self.Jgmts79_AgencyState  := ri.LnJJudgments[79].AgencyState     ;
		self.Jgmts79_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[79].ConsumerStatementId);
    self.Jgmts79_orig_rmsid       := ri.LnJJudgments[79].orig_rmsid;
		self.Jgmts80_Seq          := ri.LnJJudgments[80].Seq             ;
		self.Jgmts80_DateFiled    := ri.LnJJudgments[80].DateFiled       ;
  self.Jgmts80_JudgmentTypeID := ri.LnJJudgments[80].JudgmentTypeID;
		self.Jgmts80_JudgmentType     := ri.LnJJudgments[80].JudgmentType        ;
		self.Jgmts80_Amount       := ri.LnJJudgments[80].Amount          ;
		self.Jgmts80_ReleaseDate  := ri.LnJJudgments[80].ReleaseDate ;
		self.Jgmts80_FilingDescription  := ri.LnJJudgments[80].FilingDescription;
		self.Jgmts80_DateLastSeen := ri.LnJJudgments[80].DateLastSeen;
		self.Jgmts80_Defendant    := ri.LnJJudgments[80].Defendant;
		self.Jgmts80_Plaintiff    := ri.LnJJudgments[80].Plaintiff;
		self.Jgmts80_FilingNumber := ri.LnJJudgments[80].FilingNumber    ;
		self.Jgmts80_FilingBook   := ri.LnJJudgments[80].FilingBook      ;
		self.Jgmts80_FilingPage   := ri.LnJJudgments[80].FilingPage;
		self.Jgmts80_Eviction     := ri.LnJJudgments[80].Eviction;
		self.Jgmts80_Agency       := ri.LnJJudgments[80].Agency          ;
		self.Jgmts80_AgencyCounty := ri.LnJJudgments[80].AgencyCounty    ;
		self.Jgmts80_AgencyState  := ri.LnJJudgments[80].AgencyState     ;
		self.Jgmts80_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[80].ConsumerStatementId);
    self.Jgmts80_orig_rmsid       := ri.LnJJudgments[80].orig_rmsid;
		self.Jgmts81_Seq          := ri.LnJJudgments[81].Seq             ;
		self.Jgmts81_DateFiled    := ri.LnJJudgments[81].DateFiled       ;
  self.Jgmts81_JudgmentTypeID := ri.LnJJudgments[81].JudgmentTypeID;
		self.Jgmts81_JudgmentType     := ri.LnJJudgments[81].JudgmentType        ;
		self.Jgmts81_Amount       := ri.LnJJudgments[81].Amount          ;
		self.Jgmts81_ReleaseDate  := ri.LnJJudgments[81].ReleaseDate ;
		self.Jgmts81_FilingDescription  := ri.LnJJudgments[81].FilingDescription;
		self.Jgmts81_DateLastSeen := ri.LnJJudgments[81].DateLastSeen;
		self.Jgmts81_Defendant    := ri.LnJJudgments[81].Defendant;
		self.Jgmts81_Plaintiff    := ri.LnJJudgments[81].Plaintiff;
		self.Jgmts81_FilingNumber := ri.LnJJudgments[81].FilingNumber    ;
		self.Jgmts81_FilingBook   := ri.LnJJudgments[81].FilingBook      ;
		self.Jgmts81_FilingPage   := ri.LnJJudgments[81].FilingPage;
		self.Jgmts81_Eviction     := ri.LnJJudgments[81].Eviction;
		self.Jgmts81_Agency       := ri.LnJJudgments[81].Agency          ;
		self.Jgmts81_AgencyCounty := ri.LnJJudgments[81].AgencyCounty    ;
		self.Jgmts81_AgencyState  := ri.LnJJudgments[81].AgencyState     ;
		self.Jgmts81_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[81].ConsumerStatementId);
    self.Jgmts81_orig_rmsid       := ri.LnJJudgments[81].orig_rmsid;
		self.Jgmts82_Seq          := ri.LnJJudgments[82].Seq             ;
		self.Jgmts82_DateFiled    := ri.LnJJudgments[82].DateFiled       ;
  self.Jgmts82_JudgmentTypeID := ri.LnJJudgments[82].JudgmentTypeID;
		self.Jgmts82_JudgmentType     := ri.LnJJudgments[82].JudgmentType        ;
		self.Jgmts82_Amount       := ri.LnJJudgments[82].Amount          ;
		self.Jgmts82_ReleaseDate  := ri.LnJJudgments[82].ReleaseDate ;
		self.Jgmts82_FilingDescription  := ri.LnJJudgments[82].FilingDescription;
		self.Jgmts82_DateLastSeen := ri.LnJJudgments[82].DateLastSeen;
		self.Jgmts82_Defendant    := ri.LnJJudgments[82].Defendant;
		self.Jgmts82_Plaintiff    := ri.LnJJudgments[82].Plaintiff;
		self.Jgmts82_FilingNumber := ri.LnJJudgments[82].FilingNumber    ;
		self.Jgmts82_FilingBook   := ri.LnJJudgments[82].FilingBook      ;
		self.Jgmts82_FilingPage   := ri.LnJJudgments[82].FilingPage;
		self.Jgmts82_Eviction     := ri.LnJJudgments[82].Eviction;
		self.Jgmts82_Agency       := ri.LnJJudgments[82].Agency          ;
		self.Jgmts82_AgencyCounty := ri.LnJJudgments[82].AgencyCounty    ;
		self.Jgmts82_AgencyState  := ri.LnJJudgments[82].AgencyState     ;
		self.Jgmts82_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[82].ConsumerStatementId);
    self.Jgmts82_orig_rmsid       := ri.LnJJudgments[82].orig_rmsid;
		self.Jgmts83_Seq          := ri.LnJJudgments[83].Seq             ;
		self.Jgmts83_DateFiled    := ri.LnJJudgments[83].DateFiled       ;
  self.Jgmts83_JudgmentTypeID := ri.LnJJudgments[83].JudgmentTypeID;
		self.Jgmts83_JudgmentType     := ri.LnJJudgments[83].JudgmentType        ;
		self.Jgmts83_Amount       := ri.LnJJudgments[83].Amount          ;
		self.Jgmts83_ReleaseDate  := ri.LnJJudgments[83].ReleaseDate ;
		self.Jgmts83_FilingDescription  := ri.LnJJudgments[83].FilingDescription;
		self.Jgmts83_DateLastSeen := ri.LnJJudgments[83].DateLastSeen;
		self.Jgmts83_Defendant    := ri.LnJJudgments[83].Defendant;
		self.Jgmts83_Plaintiff    := ri.LnJJudgments[83].Plaintiff;
		self.Jgmts83_FilingNumber := ri.LnJJudgments[83].FilingNumber    ;
		self.Jgmts83_FilingBook   := ri.LnJJudgments[83].FilingBook      ;
		self.Jgmts83_FilingPage   := ri.LnJJudgments[83].FilingPage;
		self.Jgmts83_Eviction     := ri.LnJJudgments[83].Eviction;
		self.Jgmts83_Agency       := ri.LnJJudgments[83].Agency          ;
		self.Jgmts83_AgencyCounty := ri.LnJJudgments[83].AgencyCounty    ;
		self.Jgmts83_AgencyState  := ri.LnJJudgments[83].AgencyState     ;
		self.Jgmts83_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[83].ConsumerStatementId);
    self.Jgmts83_orig_rmsid       := ri.LnJJudgments[83].orig_rmsid;
		self.Jgmts84_Seq          := ri.LnJJudgments[84].Seq             ;
		self.Jgmts84_DateFiled    := ri.LnJJudgments[84].DateFiled       ;
  self.Jgmts84_JudgmentTypeID := ri.LnJJudgments[84].JudgmentTypeID;
		self.Jgmts84_JudgmentType     := ri.LnJJudgments[84].JudgmentType        ;
		self.Jgmts84_Amount       := ri.LnJJudgments[84].Amount          ;
		self.Jgmts84_ReleaseDate  := ri.LnJJudgments[84].ReleaseDate ;
		self.Jgmts84_FilingDescription  := ri.LnJJudgments[84].FilingDescription;
		self.Jgmts84_DateLastSeen := ri.LnJJudgments[84].DateLastSeen;
		self.Jgmts84_Defendant    := ri.LnJJudgments[84].Defendant;
		self.Jgmts84_Plaintiff    := ri.LnJJudgments[84].Plaintiff;
		self.Jgmts84_FilingNumber := ri.LnJJudgments[84].FilingNumber    ;
		self.Jgmts84_FilingBook   := ri.LnJJudgments[84].FilingBook      ;
		self.Jgmts84_FilingPage   := ri.LnJJudgments[84].FilingPage;
		self.Jgmts84_Eviction     := ri.LnJJudgments[84].Eviction;
		self.Jgmts84_Agency       := ri.LnJJudgments[84].Agency          ;
		self.Jgmts84_AgencyCounty := ri.LnJJudgments[84].AgencyCounty    ;
		self.Jgmts84_AgencyState  := ri.LnJJudgments[84].AgencyState     ;
		self.Jgmts84_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[84].ConsumerStatementId);
    self.Jgmts84_orig_rmsid       := ri.LnJJudgments[84].orig_rmsid;
		self.Jgmts85_Seq          := ri.LnJJudgments[85].Seq             ;
		self.Jgmts85_DateFiled    := ri.LnJJudgments[85].DateFiled       ;
  self.Jgmts85_JudgmentTypeID := ri.LnJJudgments[85].JudgmentTypeID;
		self.Jgmts85_JudgmentType     := ri.LnJJudgments[85].JudgmentType        ;
		self.Jgmts85_Amount       := ri.LnJJudgments[85].Amount          ;
		self.Jgmts85_ReleaseDate  := ri.LnJJudgments[85].ReleaseDate ;
		self.Jgmts85_FilingDescription  := ri.LnJJudgments[85].FilingDescription;
		self.Jgmts85_DateLastSeen := ri.LnJJudgments[85].DateLastSeen;
		self.Jgmts85_Defendant    := ri.LnJJudgments[85].Defendant;
		self.Jgmts85_Plaintiff    := ri.LnJJudgments[85].Plaintiff;
		self.Jgmts85_FilingNumber := ri.LnJJudgments[85].FilingNumber    ;
		self.Jgmts85_FilingBook   := ri.LnJJudgments[85].FilingBook      ;
		self.Jgmts85_FilingPage   := ri.LnJJudgments[85].FilingPage;
		self.Jgmts85_Eviction     := ri.LnJJudgments[85].Eviction;
		self.Jgmts85_Agency       := ri.LnJJudgments[85].Agency          ;
		self.Jgmts85_AgencyCounty := ri.LnJJudgments[85].AgencyCounty    ;
		self.Jgmts85_AgencyState  := ri.LnJJudgments[85].AgencyState     ;
		self.Jgmts85_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[85].ConsumerStatementId);
    self.Jgmts85_orig_rmsid       := ri.LnJJudgments[85].orig_rmsid;
		self.Jgmts86_Seq          := ri.LnJJudgments[86].Seq             ;
		self.Jgmts86_DateFiled    := ri.LnJJudgments[86].DateFiled       ;
  self.Jgmts86_JudgmentTypeID := ri.LnJJudgments[86].JudgmentTypeID;
		self.Jgmts86_JudgmentType     := ri.LnJJudgments[86].JudgmentType        ;
		self.Jgmts86_Amount       := ri.LnJJudgments[86].Amount          ;
		self.Jgmts86_ReleaseDate  := ri.LnJJudgments[86].ReleaseDate ;
		self.Jgmts86_FilingDescription  := ri.LnJJudgments[86].FilingDescription;
		self.Jgmts86_DateLastSeen := ri.LnJJudgments[86].DateLastSeen;
		self.Jgmts86_Defendant    := ri.LnJJudgments[86].Defendant;
		self.Jgmts86_Plaintiff    := ri.LnJJudgments[86].Plaintiff;
		self.Jgmts86_FilingNumber := ri.LnJJudgments[86].FilingNumber    ;
		self.Jgmts86_FilingBook   := ri.LnJJudgments[86].FilingBook      ;
		self.Jgmts86_FilingPage   := ri.LnJJudgments[86].FilingPage;
		self.Jgmts86_Eviction     := ri.LnJJudgments[86].Eviction;
		self.Jgmts86_Agency       := ri.LnJJudgments[86].Agency          ;
		self.Jgmts86_AgencyCounty := ri.LnJJudgments[86].AgencyCounty    ;
		self.Jgmts86_AgencyState  := ri.LnJJudgments[86].AgencyState     ;
		self.Jgmts86_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[86].ConsumerStatementId);
    self.Jgmts86_orig_rmsid       := ri.LnJJudgments[86].orig_rmsid;
		self.Jgmts87_Seq          := ri.LnJJudgments[87].Seq             ;
		self.Jgmts87_DateFiled    := ri.LnJJudgments[87].DateFiled       ;
  self.Jgmts87_JudgmentTypeID := ri.LnJJudgments[87].JudgmentTypeID;
		self.Jgmts87_JudgmentType     := ri.LnJJudgments[87].JudgmentType        ;
		self.Jgmts87_Amount       := ri.LnJJudgments[87].Amount          ;
		self.Jgmts87_ReleaseDate  := ri.LnJJudgments[87].ReleaseDate ; 
		self.Jgmts87_FilingDescription  := ri.LnJJudgments[87].FilingDescription;
		self.Jgmts87_DateLastSeen := ri.LnJJudgments[87].DateLastSeen;
		self.Jgmts87_Defendant    := ri.LnJJudgments[87].Defendant;
		self.Jgmts87_Plaintiff    := ri.LnJJudgments[87].Plaintiff;
		self.Jgmts87_FilingNumber := ri.LnJJudgments[87].FilingNumber    ;
		self.Jgmts87_FilingBook   := ri.LnJJudgments[87].FilingBook      ;
		self.Jgmts87_FilingPage   := ri.LnJJudgments[87].FilingPage;
		self.Jgmts87_Eviction     := ri.LnJJudgments[87].Eviction;
		self.Jgmts87_Agency       := ri.LnJJudgments[87].Agency          ;
		self.Jgmts87_AgencyCounty := ri.LnJJudgments[87].AgencyCounty    ;
		self.Jgmts87_AgencyState  := ri.LnJJudgments[87].AgencyState     ;
		self.Jgmts87_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[87].ConsumerStatementId);
    self.Jgmts87_orig_rmsid       := ri.LnJJudgments[87].orig_rmsid;
		self.Jgmts88_Seq          := ri.LnJJudgments[88].Seq             ;
		self.Jgmts88_DateFiled    := ri.LnJJudgments[88].DateFiled       ;
  self.Jgmts88_JudgmentTypeID := ri.LnJJudgments[88].JudgmentTypeID;
		self.Jgmts88_JudgmentType     := ri.LnJJudgments[88].JudgmentType        ;
		self.Jgmts88_Amount       := ri.LnJJudgments[88].Amount          ;
		self.Jgmts88_ReleaseDate  := ri.LnJJudgments[88].ReleaseDate ;
		self.Jgmts88_FilingDescription  := ri.LnJJudgments[88].FilingDescription;
		self.Jgmts88_DateLastSeen := ri.LnJJudgments[88].DateLastSeen;
		self.Jgmts88_Defendant    := ri.LnJJudgments[88].Defendant;
		self.Jgmts88_Plaintiff    := ri.LnJJudgments[88].Plaintiff;
		self.Jgmts88_FilingNumber := ri.LnJJudgments[88].FilingNumber    ;
		self.Jgmts88_FilingBook   := ri.LnJJudgments[88].FilingBook      ;
		self.Jgmts88_FilingPage   := ri.LnJJudgments[88].FilingPage;
		self.Jgmts88_Eviction     := ri.LnJJudgments[88].Eviction;
		self.Jgmts88_Agency       := ri.LnJJudgments[88].Agency          ;
		self.Jgmts88_AgencyCounty := ri.LnJJudgments[88].AgencyCounty    ;
		self.Jgmts88_AgencyState  := ri.LnJJudgments[88].AgencyState     ;
		self.Jgmts88_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[88].ConsumerStatementId);
    self.Jgmts88_orig_rmsid       := ri.LnJJudgments[88].orig_rmsid;
		self.Jgmts89_Seq          := ri.LnJJudgments[89].Seq             ;
		self.Jgmts89_DateFiled    := ri.LnJJudgments[89].DateFiled       ;
  self.Jgmts89_JudgmentTypeID := ri.LnJJudgments[89].JudgmentTypeID;
		self.Jgmts89_JudgmentType     := ri.LnJJudgments[89].JudgmentType        ;
		self.Jgmts89_Amount       := ri.LnJJudgments[89].Amount          ;
		self.Jgmts89_ReleaseDate  := ri.LnJJudgments[89].ReleaseDate ;
		self.Jgmts89_FilingDescription  := ri.LnJJudgments[89].FilingDescription;
		self.Jgmts89_DateLastSeen := ri.LnJJudgments[89].DateLastSeen;
		self.Jgmts89_Defendant    := ri.LnJJudgments[89].Defendant;
		self.Jgmts89_Plaintiff    := ri.LnJJudgments[89].Plaintiff;
		self.Jgmts89_FilingNumber := ri.LnJJudgments[89].FilingNumber    ;
		self.Jgmts89_FilingBook   := ri.LnJJudgments[89].FilingBook      ;
		self.Jgmts89_FilingPage   := ri.LnJJudgments[89].FilingPage;
		self.Jgmts89_Eviction     := ri.LnJJudgments[89].Eviction;
		self.Jgmts89_Agency       := ri.LnJJudgments[89].Agency          ;
		self.Jgmts89_AgencyCounty := ri.LnJJudgments[89].AgencyCounty    ;
		self.Jgmts89_AgencyState  := ri.LnJJudgments[89].AgencyState     ;
		self.Jgmts89_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[89].ConsumerStatementId);
    self.Jgmts89_orig_rmsid       := ri.LnJJudgments[89].orig_rmsid;
		self.Jgmts90_Seq          := ri.LnJJudgments[90].Seq             ;
		self.Jgmts90_DateFiled    := ri.LnJJudgments[90].DateFiled       ;
  self.Jgmts90_JudgmentTypeID := ri.LnJJudgments[90].JudgmentTypeID;
		self.Jgmts90_JudgmentType     := ri.LnJJudgments[90].JudgmentType        ;
		self.Jgmts90_Amount       := ri.LnJJudgments[90].Amount          ;
		self.Jgmts90_ReleaseDate  := ri.LnJJudgments[90].ReleaseDate ; 
		self.Jgmts90_FilingDescription  := ri.LnJJudgments[90].FilingDescription;
		self.Jgmts90_DateLastSeen := ri.LnJJudgments[90].DateLastSeen;
		self.Jgmts90_Defendant    := ri.LnJJudgments[90].Defendant;
		self.Jgmts90_Plaintiff    := ri.LnJJudgments[90].Plaintiff;
		self.Jgmts90_FilingNumber := ri.LnJJudgments[90].FilingNumber    ;
		self.Jgmts90_FilingBook   := ri.LnJJudgments[90].FilingBook      ;
		self.Jgmts90_FilingPage   := ri.LnJJudgments[90].FilingPage;
		self.Jgmts90_Eviction     := ri.LnJJudgments[90].Eviction;
		self.Jgmts90_Agency       := ri.LnJJudgments[90].Agency          ;
		self.Jgmts90_AgencyCounty := ri.LnJJudgments[90].AgencyCounty    ;
		self.Jgmts90_AgencyState  := ri.LnJJudgments[90].AgencyState     ;
		self.Jgmts90_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[90].ConsumerStatementId);
    self.Jgmts90_orig_rmsid       := ri.LnJJudgments[90].orig_rmsid;
		self.Jgmts91_Seq          := ri.LnJJudgments[91].Seq             ;
		self.Jgmts91_DateFiled    := ri.LnJJudgments[91].DateFiled       ;
  self.Jgmts91_JudgmentTypeID := ri.LnJJudgments[91].JudgmentTypeID;
		self.Jgmts91_JudgmentType     := ri.LnJJudgments[91].JudgmentType        ;
		self.Jgmts91_Amount       := ri.LnJJudgments[91].Amount          ;
		self.Jgmts91_ReleaseDate  := ri.LnJJudgments[91].ReleaseDate ;
		self.Jgmts91_FilingDescription  := ri.LnJJudgments[91].FilingDescription;
		self.Jgmts91_DateLastSeen := ri.LnJJudgments[91].DateLastSeen;
		self.Jgmts91_Defendant    := ri.LnJJudgments[91].Defendant;
		self.Jgmts91_Plaintiff    := ri.LnJJudgments[91].Plaintiff;
		self.Jgmts91_FilingNumber := ri.LnJJudgments[91].FilingNumber    ;
		self.Jgmts91_FilingBook   := ri.LnJJudgments[91].FilingBook      ;
		self.Jgmts91_FilingPage   := ri.LnJJudgments[91].FilingPage;
		self.Jgmts91_Eviction     := ri.LnJJudgments[91].Eviction;
		self.Jgmts91_Agency       := ri.LnJJudgments[91].Agency          ;
		self.Jgmts91_AgencyCounty := ri.LnJJudgments[91].AgencyCounty    ;
		self.Jgmts91_AgencyState  := ri.LnJJudgments[91].AgencyState     ;
		self.Jgmts91_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[91].ConsumerStatementId);
    self.Jgmts91_orig_rmsid       := ri.LnJJudgments[91].orig_rmsid;
		self.Jgmts92_Seq          := ri.LnJJudgments[92].Seq             ;
		self.Jgmts92_DateFiled    := ri.LnJJudgments[92].DateFiled       ;
  self.Jgmts92_JudgmentTypeID := ri.LnJJudgments[92].JudgmentTypeID;
		self.Jgmts92_JudgmentType     := ri.LnJJudgments[92].JudgmentType        ;
		self.Jgmts92_Amount       := ri.LnJJudgments[92].Amount          ;
		self.Jgmts92_ReleaseDate  := ri.LnJJudgments[92].ReleaseDate ;
		self.Jgmts92_FilingDescription  := ri.LnJJudgments[92].FilingDescription;
		self.Jgmts92_DateLastSeen := ri.LnJJudgments[92].DateLastSeen;
		self.Jgmts92_Defendant    := ri.LnJJudgments[92].Defendant;
		self.Jgmts92_Plaintiff    := ri.LnJJudgments[92].Plaintiff;
		self.Jgmts92_FilingNumber := ri.LnJJudgments[92].FilingNumber    ;
		self.Jgmts92_FilingBook   := ri.LnJJudgments[92].FilingBook      ;
		self.Jgmts92_FilingPage   := ri.LnJJudgments[92].FilingPage;
		self.Jgmts92_Eviction     := ri.LnJJudgments[92].Eviction;
		self.Jgmts92_Agency       := ri.LnJJudgments[92].Agency          ;
		self.Jgmts92_AgencyCounty := ri.LnJJudgments[92].AgencyCounty    ;
		self.Jgmts92_AgencyState  := ri.LnJJudgments[92].AgencyState     ;
		self.Jgmts92_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[92].ConsumerStatementId);
    self.Jgmts92_orig_rmsid       := ri.LnJJudgments[92].orig_rmsid;
		self.Jgmts93_Seq          := ri.LnJJudgments[93].Seq             ;
		self.Jgmts93_DateFiled    := ri.LnJJudgments[93].DateFiled       ;
  self.Jgmts93_JudgmentTypeID := ri.LnJJudgments[93].JudgmentTypeID;
		self.Jgmts93_JudgmentType     := ri.LnJJudgments[93].JudgmentType        ;
		self.Jgmts93_Amount       := ri.LnJJudgments[93].Amount          ;
		self.Jgmts93_ReleaseDate  := ri.LnJJudgments[93].ReleaseDate ;
		self.Jgmts93_FilingDescription  := ri.LnJJudgments[93].FilingDescription;
		self.Jgmts93_DateLastSeen := ri.LnJJudgments[93].DateLastSeen;
		self.Jgmts93_Defendant    := ri.LnJJudgments[93].Defendant;
		self.Jgmts93_Plaintiff    := ri.LnJJudgments[93].Plaintiff;
		self.Jgmts93_FilingNumber := ri.LnJJudgments[93].FilingNumber    ;
		self.Jgmts93_FilingBook   := ri.LnJJudgments[93].FilingBook      ;
		self.Jgmts93_FilingPage   := ri.LnJJudgments[93].FilingPage;
		self.Jgmts93_Eviction     := ri.LnJJudgments[93].Eviction;
		self.Jgmts93_Agency       := ri.LnJJudgments[93].Agency          ;
		self.Jgmts93_AgencyCounty := ri.LnJJudgments[93].AgencyCounty    ;
		self.Jgmts93_AgencyState  := ri.LnJJudgments[93].AgencyState     ;
		self.Jgmts93_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[93].ConsumerStatementId);
    self.Jgmts93_orig_rmsid       := ri.LnJJudgments[93].orig_rmsid;
		self.Jgmts94_Seq          := ri.LnJJudgments[94].Seq             ;
		self.Jgmts94_DateFiled    := ri.LnJJudgments[94].DateFiled       ;
  self.Jgmts94_JudgmentTypeID := ri.LnJJudgments[94].JudgmentTypeID;
		self.Jgmts94_JudgmentType     := ri.LnJJudgments[94].JudgmentType        ;
		self.Jgmts94_Amount       := ri.LnJJudgments[94].Amount          ;
		self.Jgmts94_ReleaseDate  := ri.LnJJudgments[94].ReleaseDate ;
		self.Jgmts94_FilingDescription  := ri.LnJJudgments[94].FilingDescription;
		self.Jgmts94_DateLastSeen := ri.LnJJudgments[94].DateLastSeen;
		self.Jgmts94_Defendant    := ri.LnJJudgments[94].Defendant;
		self.Jgmts94_Plaintiff    := ri.LnJJudgments[94].Plaintiff;
		self.Jgmts94_FilingNumber := ri.LnJJudgments[94].FilingNumber    ;
		self.Jgmts94_FilingBook   := ri.LnJJudgments[94].FilingBook      ;
		self.Jgmts94_FilingPage   := ri.LnJJudgments[94].FilingPage;
		self.Jgmts94_Eviction     := ri.LnJJudgments[94].Eviction;
		self.Jgmts94_Agency       := ri.LnJJudgments[94].Agency          ;
		self.Jgmts94_AgencyCounty := ri.LnJJudgments[94].AgencyCounty    ;
		self.Jgmts94_AgencyState  := ri.LnJJudgments[94].AgencyState     ;
		self.Jgmts94_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[94].ConsumerStatementId);
    self.Jgmts94_orig_rmsid       := ri.LnJJudgments[94].orig_rmsid;
		self.Jgmts95_Seq          := ri.LnJJudgments[95].Seq             ;
		self.Jgmts95_DateFiled    := ri.LnJJudgments[95].DateFiled       ;
  self.Jgmts95_JudgmentTypeID := ri.LnJJudgments[95].JudgmentTypeID;
		self.Jgmts95_JudgmentType     := ri.LnJJudgments[95].JudgmentType        ;
		self.Jgmts95_Amount       := ri.LnJJudgments[95].Amount          ;
		self.Jgmts95_ReleaseDate  := ri.LnJJudgments[95].ReleaseDate ;         
		self.Jgmts95_FilingDescription  := ri.LnJJudgments[95].FilingDescription;
		self.Jgmts95_DateLastSeen := ri.LnJJudgments[95].DateLastSeen;
		self.Jgmts95_Defendant    := ri.LnJJudgments[95].Defendant;
		self.Jgmts95_Plaintiff    := ri.LnJJudgments[95].Plaintiff;
		self.Jgmts95_FilingNumber := ri.LnJJudgments[95].FilingNumber    ;
		self.Jgmts95_FilingBook   := ri.LnJJudgments[95].FilingBook      ;
		self.Jgmts95_FilingPage   := ri.LnJJudgments[95].FilingPage;
		self.Jgmts95_Eviction     := ri.LnJJudgments[95].Eviction;
		self.Jgmts95_Agency       := ri.LnJJudgments[95].Agency          ;
		self.Jgmts95_AgencyCounty := ri.LnJJudgments[95].AgencyCounty    ;
		self.Jgmts95_AgencyState  := ri.LnJJudgments[95].AgencyState     ;
		self.Jgmts95_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[95].ConsumerStatementId);
    self.Jgmts95_orig_rmsid       := ri.LnJJudgments[95].orig_rmsid;
		self.Jgmts96_Seq          := ri.LnJJudgments[96].Seq             ;
		self.Jgmts96_DateFiled    := ri.LnJJudgments[96].DateFiled       ;
  self.Jgmts96_JudgmentTypeID := ri.LnJJudgments[96].JudgmentTypeID;
		self.Jgmts96_JudgmentType     := ri.LnJJudgments[96].JudgmentType        ;
		self.Jgmts96_Amount       := ri.LnJJudgments[96].Amount          ;
		self.Jgmts96_ReleaseDate  := ri.LnJJudgments[96].ReleaseDate ;         
		self.Jgmts96_FilingDescription  := ri.LnJJudgments[96].FilingDescription;
		self.Jgmts96_DateLastSeen := ri.LnJJudgments[96].DateLastSeen;
		self.Jgmts96_Defendant    := ri.LnJJudgments[96].Defendant;
		self.Jgmts96_Plaintiff    := ri.LnJJudgments[96].Plaintiff;
		self.Jgmts96_FilingNumber := ri.LnJJudgments[96].FilingNumber    ;
		self.Jgmts96_FilingBook   := ri.LnJJudgments[96].FilingBook      ;
		self.Jgmts96_FilingPage   := ri.LnJJudgments[96].FilingPage;
		self.Jgmts96_Eviction     := ri.LnJJudgments[96].Eviction;
		self.Jgmts96_Agency       := ri.LnJJudgments[96].Agency          ;
		self.Jgmts96_AgencyCounty := ri.LnJJudgments[96].AgencyCounty    ;
		self.Jgmts96_AgencyState  := ri.LnJJudgments[96].AgencyState     ;
		self.Jgmts96_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[96].ConsumerStatementId);
    self.Jgmts96_orig_rmsid       := ri.LnJJudgments[96].orig_rmsid;
		self.Jgmts97_Seq          := ri.LnJJudgments[97].Seq             ;
		self.Jgmts97_DateFiled    := ri.LnJJudgments[97].DateFiled       ;
  self.Jgmts97_JudgmentTypeID := ri.LnJJudgments[97].JudgmentTypeID;
		self.Jgmts97_JudgmentType     := ri.LnJJudgments[97].JudgmentType        ;
		self.Jgmts97_Amount       := ri.LnJJudgments[97].Amount          ;
		self.Jgmts97_ReleaseDate  := ri.LnJJudgments[97].ReleaseDate ;         
		self.Jgmts97_FilingDescription  := ri.LnJJudgments[97].FilingDescription;
		self.Jgmts97_DateLastSeen := ri.LnJJudgments[97].DateLastSeen;
		self.Jgmts97_Defendant    := ri.LnJJudgments[97].Defendant;
		self.Jgmts97_Plaintiff    := ri.LnJJudgments[97].Plaintiff;
		self.Jgmts97_FilingNumber := ri.LnJJudgments[97].FilingNumber    ;
		self.Jgmts97_FilingBook   := ri.LnJJudgments[97].FilingBook      ;
		self.Jgmts97_FilingPage   := ri.LnJJudgments[97].FilingPage;
		self.Jgmts97_Eviction     := ri.LnJJudgments[97].Eviction;
		self.Jgmts97_Agency       := ri.LnJJudgments[97].Agency          ;
		self.Jgmts97_AgencyCounty := ri.LnJJudgments[97].AgencyCounty    ;
		self.Jgmts97_AgencyState  := ri.LnJJudgments[97].AgencyState     ;
		self.Jgmts97_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[97].ConsumerStatementId);
    self.Jgmts97_orig_rmsid       := ri.LnJJudgments[97].orig_rmsid;
		self.Jgmts98_Seq          := ri.LnJJudgments[98].Seq             ;
		self.Jgmts98_DateFiled    := ri.LnJJudgments[98].DateFiled       ;
  self.Jgmts98_JudgmentTypeID := ri.LnJJudgments[98].JudgmentTypeID;
		self.Jgmts98_JudgmentType     := ri.LnJJudgments[98].JudgmentType        ;
		self.Jgmts98_Amount       := ri.LnJJudgments[98].Amount          ;
		self.Jgmts98_ReleaseDate  := ri.LnJJudgments[98].ReleaseDate ;         
		self.Jgmts98_FilingDescription  := ri.LnJJudgments[98].FilingDescription;
		self.Jgmts98_DateLastSeen := ri.LnJJudgments[98].DateLastSeen;
		self.Jgmts98_Defendant    := ri.LnJJudgments[98].Defendant;
		self.Jgmts98_Plaintiff    := ri.LnJJudgments[98].Plaintiff;
		self.Jgmts98_FilingNumber := ri.LnJJudgments[98].FilingNumber    ;
		self.Jgmts98_FilingBook   := ri.LnJJudgments[98].FilingBook      ;
		self.Jgmts98_FilingPage   := ri.LnJJudgments[98].FilingPage;
		self.Jgmts98_Eviction     := ri.LnJJudgments[98].Eviction;
		self.Jgmts98_Agency       := ri.LnJJudgments[98].Agency          ;
		self.Jgmts98_AgencyCounty := ri.LnJJudgments[98].AgencyCounty    ;
		self.Jgmts98_AgencyState  := ri.LnJJudgments[98].AgencyState     ;
		self.Jgmts98_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[98].ConsumerStatementId);
    self.Jgmts98_orig_rmsid       := ri.LnJJudgments[98].orig_rmsid;
		self.Jgmts99_Seq          := ri.LnJJudgments[99].Seq             ;
		self.Jgmts99_DateFiled    := ri.LnJJudgments[99].DateFiled       ;
  self.Jgmts99_JudgmentTypeID := ri.LnJJudgments[99].JudgmentTypeID;
		self.Jgmts99_JudgmentType     := ri.LnJJudgments[99].JudgmentType        ;
		self.Jgmts99_Amount       := ri.LnJJudgments[99].Amount          ;
		self.Jgmts99_ReleaseDate  := ri.LnJJudgments[99].ReleaseDate ;        
		self.Jgmts99_FilingDescription  := ri.LnJJudgments[99].FilingDescription;
		self.Jgmts99_DateLastSeen := ri.LnJJudgments[99].DateLastSeen;
		self.Jgmts99_Defendant    := ri.LnJJudgments[99].Defendant;
		self.Jgmts99_Plaintiff    := ri.LnJJudgments[99].Plaintiff;
		self.Jgmts99_FilingNumber := ri.LnJJudgments[99].FilingNumber    ;
		self.Jgmts99_FilingBook   := ri.LnJJudgments[99].FilingBook      ;
		self.Jgmts99_FilingPage   := ri.LnJJudgments[99].FilingPage;
		self.Jgmts99_Eviction     := ri.LnJJudgments[99].Eviction;
		self.Jgmts99_Agency       := ri.LnJJudgments[99].Agency          ;
		self.Jgmts99_AgencyCounty := ri.LnJJudgments[99].AgencyCounty    ;
		self.Jgmts99_AgencyState  := ri.LnJJudgments[99].AgencyState     ;
		self.Jgmts99_ConsumerStatementId	:= SetCSID(ri.LnJJudgments[99].ConsumerStatementId);
    self.Jgmts99_orig_rmsid       := ri.LnJJudgments[99].orig_rmsid;
				self.Liens1_AgencyID      := ri.LnJliens[1].AgencyID;
		self.Liens2_AgencyID      := ri.LnJliens[2].AgencyID;
		self.Liens3_AgencyID      := ri.LnJliens[3].AgencyID;
		self.Liens4_AgencyID      := ri.LnJliens[4].AgencyID;
		self.Liens5_AgencyID      := ri.LnJliens[5].AgencyID;
		self.Liens6_AgencyID      := ri.LnJliens[6].AgencyID;
		self.Liens7_AgencyID      := ri.LnJliens[7].AgencyID;
		self.Liens8_AgencyID      := ri.LnJliens[8].AgencyID;
		self.Liens9_AgencyID      := ri.LnJliens[9].AgencyID;
		self.Liens10_AgencyID     := ri.LnJliens[10].AgencyID;
		self.Liens11_AgencyID     := ri.LnJliens[11].AgencyID;
		self.Liens12_AgencyID     := ri.LnJliens[12].AgencyID;
		self.Liens13_AgencyID     := ri.LnJliens[13].AgencyID;
		self.Liens14_AgencyID     := ri.LnJliens[14].AgencyID;
		self.Liens15_AgencyID     := ri.LnJliens[15].AgencyID;
		self.Liens16_AgencyID     := ri.LnJliens[16].AgencyID;
		self.Liens17_AgencyID     := ri.LnJliens[17].AgencyID;
		self.Liens18_AgencyID     := ri.LnJliens[18].AgencyID;
		self.Liens19_AgencyID     := ri.LnJliens[19].AgencyID;
		self.Liens20_AgencyID     := ri.LnJliens[20].AgencyID;
		self.Liens21_AgencyID     := ri.LnJliens[21].AgencyID;
		self.Liens22_AgencyID     := ri.LnJliens[22].AgencyID;
		self.Liens23_AgencyID     := ri.LnJliens[23].AgencyID;
		self.Liens24_AgencyID     := ri.LnJliens[24].AgencyID;
		self.Liens25_AgencyID     := ri.LnJliens[25].AgencyID;
		self.Liens26_AgencyID     := ri.LnJliens[26].AgencyID;
		self.Liens27_AgencyID     := ri.LnJliens[27].AgencyID;
		self.Liens28_AgencyID     := ri.LnJliens[28].AgencyID;
		self.Liens29_AgencyID     := ri.LnJliens[29].AgencyID;
		self.Liens30_AgencyID     := ri.LnJliens[30].AgencyID;
		self.Liens31_AgencyID     := ri.LnJliens[31].AgencyID;
		self.Liens32_AgencyID     := ri.LnJliens[32].AgencyID;
		self.Liens33_AgencyID     := ri.LnJliens[33].AgencyID;
		self.Liens34_AgencyID     := ri.LnJliens[34].AgencyID;
		self.Liens35_AgencyID     := ri.LnJliens[35].AgencyID;
		self.Liens36_AgencyID     := ri.LnJliens[36].AgencyID;
		self.Liens37_AgencyID     := ri.LnJliens[37].AgencyID;
		self.Liens38_AgencyID     := ri.LnJliens[38].AgencyID;
		self.Liens39_AgencyID     := ri.LnJliens[39].AgencyID;
		self.Liens40_AgencyID     := ri.LnJliens[40].AgencyID;
		self.Liens41_AgencyID     := ri.LnJliens[41].AgencyID;
		self.Liens42_AgencyID     := ri.LnJliens[42].AgencyID;
		self.Liens43_AgencyID     := ri.LnJliens[43].AgencyID;
		self.Liens44_AgencyID     := ri.LnJliens[44].AgencyID;
		self.Liens45_AgencyID     := ri.LnJliens[45].AgencyID;
		self.Liens46_AgencyID     := ri.LnJliens[46].AgencyID;
		self.Liens47_AgencyID     := ri.LnJliens[47].AgencyID;
		self.Liens48_AgencyID     := ri.LnJliens[48].AgencyID;
		self.Liens49_AgencyID     := ri.LnJliens[49].AgencyID;
		self.Liens50_AgencyID     := ri.LnJliens[50].AgencyID;
		self.Liens51_AgencyID     := ri.LnJliens[51].AgencyID;
		self.Liens52_AgencyID     := ri.LnJliens[52].AgencyID;
		self.Liens53_AgencyID     := ri.LnJliens[53].AgencyID;
		self.Liens54_AgencyID     := ri.LnJliens[54].AgencyID;
		self.Liens55_AgencyID     := ri.LnJliens[55].AgencyID;
		self.Liens56_AgencyID     := ri.LnJliens[56].AgencyID;
		self.Liens57_AgencyID     := ri.LnJliens[57].AgencyID;
		self.Liens58_AgencyID     := ri.LnJliens[58].AgencyID;
		self.Liens59_AgencyID     := ri.LnJliens[59].AgencyID;
		self.Liens60_AgencyID     := ri.LnJliens[60].AgencyID;
		self.Liens61_AgencyID     := ri.LnJliens[61].AgencyID;
		self.Liens62_AgencyID     := ri.LnJliens[62].AgencyID;
		self.Liens63_AgencyID     := ri.LnJliens[63].AgencyID;
		self.Liens64_AgencyID     := ri.LnJliens[64].AgencyID;
		self.Liens65_AgencyID     := ri.LnJliens[65].AgencyID;
		self.Liens66_AgencyID     := ri.LnJliens[66].AgencyID;
		self.Liens67_AgencyID     := ri.LnJliens[67].AgencyID;
		self.Liens68_AgencyID     := ri.LnJliens[68].AgencyID;
		self.Liens69_AgencyID     := ri.LnJliens[69].AgencyID;
		self.Liens70_AgencyID     := ri.LnJliens[70].AgencyID;
		self.Liens71_AgencyID     := ri.LnJliens[71].AgencyID;
		self.Liens72_AgencyID     := ri.LnJliens[72].AgencyID;
		self.Liens73_AgencyID     := ri.LnJliens[73].AgencyID;
		self.Liens74_AgencyID     := ri.LnJliens[74].AgencyID;
		self.Liens75_AgencyID     := ri.LnJliens[75].AgencyID;
		self.Liens76_AgencyID     := ri.LnJliens[76].AgencyID;
		self.Liens77_AgencyID     := ri.LnJliens[77].AgencyID;
		self.Liens78_AgencyID     := ri.LnJliens[78].AgencyID;
		self.Liens79_AgencyID     := ri.LnJliens[79].AgencyID;
		self.Liens80_AgencyID     := ri.LnJliens[80].AgencyID;
		self.Liens81_AgencyID     := ri.LnJliens[81].AgencyID;
		self.Liens82_AgencyID     := ri.LnJliens[82].AgencyID;
		self.Liens83_AgencyID     := ri.LnJliens[83].AgencyID;
		self.Liens84_AgencyID     := ri.LnJliens[84].AgencyID;
		self.Liens85_AgencyID     := ri.LnJliens[85].AgencyID;
		self.Liens86_AgencyID     := ri.LnJliens[86].AgencyID;
		self.Liens87_AgencyID     := ri.LnJliens[87].AgencyID;
		self.Liens88_AgencyID     := ri.LnJliens[88].AgencyID;
		self.Liens89_AgencyID     := ri.LnJliens[89].AgencyID;
		self.Liens90_AgencyID     := ri.LnJliens[90].AgencyID;
		self.Liens91_AgencyID     := ri.LnJliens[91].AgencyID;
		self.Liens92_AgencyID     := ri.LnJliens[92].AgencyID;
		self.Liens93_AgencyID     := ri.LnJliens[93].AgencyID;
		self.Liens94_AgencyID     := ri.LnJliens[94].AgencyID;
		self.Liens95_AgencyID     := ri.LnJliens[95].AgencyID;
		self.Liens96_AgencyID     := ri.LnJliens[96].AgencyID;
		self.Liens97_AgencyID     := ri.LnJliens[97].AgencyID;
		self.Liens98_AgencyID     := ri.LnJliens[98].AgencyID;
		self.Liens99_AgencyID     := ri.LnJliens[99].AgencyID;
		self.Jgmts1_AgencyID      := ri.LnJJudgments[1].AgencyID;
		self.Jgmts2_AgencyID      := ri.LnJJudgments[2].AgencyID;
		self.Jgmts3_AgencyID      := ri.LnJJudgments[3].AgencyID;
		self.Jgmts4_AgencyID      := ri.LnJJudgments[4].AgencyID;
		self.Jgmts5_AgencyID      := ri.LnJJudgments[5].AgencyID;
		self.Jgmts6_AgencyID      := ri.LnJJudgments[6].AgencyID;
		self.Jgmts7_AgencyID      := ri.LnJJudgments[7].AgencyID;
		self.Jgmts8_AgencyID      := ri.LnJJudgments[8].AgencyID;
		self.Jgmts9_AgencyID      := ri.LnJJudgments[9].AgencyID;
		self.Jgmts10_AgencyID     := ri.LnJJudgments[10].AgencyID;
		self.Jgmts11_AgencyID     := ri.LnJJudgments[11].AgencyID;
		self.Jgmts12_AgencyID     := ri.LnJJudgments[12].AgencyID;
		self.Jgmts13_AgencyID     := ri.LnJJudgments[13].AgencyID;
		self.Jgmts14_AgencyID     := ri.LnJJudgments[14].AgencyID;
		self.Jgmts15_AgencyID     := ri.LnJJudgments[15].AgencyID;
		self.Jgmts16_AgencyID     := ri.LnJJudgments[16].AgencyID;
		self.Jgmts17_AgencyID     := ri.LnJJudgments[17].AgencyID;
		self.Jgmts18_AgencyID     := ri.LnJJudgments[18].AgencyID;
		self.Jgmts19_AgencyID     := ri.LnJJudgments[19].AgencyID;
		self.Jgmts20_AgencyID     := ri.LnJJudgments[20].AgencyID;
		self.Jgmts21_AgencyID     := ri.LnJJudgments[21].AgencyID;
		self.Jgmts22_AgencyID     := ri.LnJJudgments[22].AgencyID;
		self.Jgmts23_AgencyID     := ri.LnJJudgments[23].AgencyID;
		self.Jgmts24_AgencyID     := ri.LnJJudgments[24].AgencyID;
		self.Jgmts25_AgencyID     := ri.LnJJudgments[25].AgencyID;
		self.Jgmts26_AgencyID     := ri.LnJJudgments[26].AgencyID;
		self.Jgmts27_AgencyID     := ri.LnJJudgments[27].AgencyID;
		self.Jgmts28_AgencyID     := ri.LnJJudgments[28].AgencyID;
		self.Jgmts29_AgencyID     := ri.LnJJudgments[29].AgencyID;
		self.Jgmts30_AgencyID     := ri.LnJJudgments[30].AgencyID;
		self.Jgmts31_AgencyID     := ri.LnJJudgments[31].AgencyID;
		self.Jgmts32_AgencyID     := ri.LnJJudgments[32].AgencyID;
		self.Jgmts33_AgencyID     := ri.LnJJudgments[33].AgencyID;
		self.Jgmts34_AgencyID     := ri.LnJJudgments[34].AgencyID;
		self.Jgmts35_AgencyID     := ri.LnJJudgments[35].AgencyID;
		self.Jgmts36_AgencyID     := ri.LnJJudgments[36].AgencyID;
		self.Jgmts37_AgencyID     := ri.LnJJudgments[37].AgencyID;
		self.Jgmts38_AgencyID     := ri.LnJJudgments[38].AgencyID;
		self.Jgmts39_AgencyID     := ri.LnJJudgments[39].AgencyID;
		self.Jgmts40_AgencyID     := ri.LnJJudgments[40].AgencyID;
		self.Jgmts41_AgencyID     := ri.LnJJudgments[41].AgencyID;
		self.Jgmts42_AgencyID     := ri.LnJJudgments[42].AgencyID;
		self.Jgmts43_AgencyID     := ri.LnJJudgments[43].AgencyID;
		self.Jgmts44_AgencyID     := ri.LnJJudgments[44].AgencyID;
		self.Jgmts45_AgencyID     := ri.LnJJudgments[45].AgencyID;
		self.Jgmts46_AgencyID     := ri.LnJJudgments[46].AgencyID;
		self.Jgmts47_AgencyID     := ri.LnJJudgments[47].AgencyID;
		self.Jgmts48_AgencyID     := ri.LnJJudgments[48].AgencyID;
		self.Jgmts49_AgencyID     := ri.LnJJudgments[49].AgencyID;
		self.Jgmts50_AgencyID     := ri.LnJJudgments[50].AgencyID;
		self.Jgmts51_AgencyID     := ri.LnJJudgments[51].AgencyID;
		self.Jgmts52_AgencyID     := ri.LnJJudgments[52].AgencyID;
		self.Jgmts53_AgencyID     := ri.LnJJudgments[53].AgencyID;
		self.Jgmts54_AgencyID     := ri.LnJJudgments[54].AgencyID;
		self.Jgmts55_AgencyID     := ri.LnJJudgments[55].AgencyID;
		self.Jgmts56_AgencyID     := ri.LnJJudgments[56].AgencyID;
		self.Jgmts57_AgencyID     := ri.LnJJudgments[57].AgencyID;
		self.Jgmts58_AgencyID     := ri.LnJJudgments[58].AgencyID;
		self.Jgmts59_AgencyID     := ri.LnJJudgments[59].AgencyID;
		self.Jgmts60_AgencyID     := ri.LnJJudgments[60].AgencyID;
		self.Jgmts61_AgencyID     := ri.LnJJudgments[61].AgencyID;
		self.Jgmts62_AgencyID     := ri.LnJJudgments[62].AgencyID;
		self.Jgmts63_AgencyID     := ri.LnJJudgments[63].AgencyID;
		self.Jgmts64_AgencyID     := ri.LnJJudgments[64].AgencyID;
		self.Jgmts65_AgencyID     := ri.LnJJudgments[65].AgencyID;
		self.Jgmts66_AgencyID     := ri.LnJJudgments[66].AgencyID;
		self.Jgmts67_AgencyID     := ri.LnJJudgments[67].AgencyID;
		self.Jgmts68_AgencyID     := ri.LnJJudgments[68].AgencyID;
		self.Jgmts69_AgencyID     := ri.LnJJudgments[69].AgencyID;
		self.Jgmts70_AgencyID     := ri.LnJJudgments[70].AgencyID;
		self.Jgmts71_AgencyID     := ri.LnJJudgments[71].AgencyID;
		self.Jgmts72_AgencyID     := ri.LnJJudgments[72].AgencyID;
		self.Jgmts73_AgencyID     := ri.LnJJudgments[73].AgencyID;
		self.Jgmts74_AgencyID     := ri.LnJJudgments[74].AgencyID;
		self.Jgmts75_AgencyID     := ri.LnJJudgments[75].AgencyID;
		self.Jgmts76_AgencyID     := ri.LnJJudgments[76].AgencyID;
		self.Jgmts77_AgencyID     := ri.LnJJudgments[77].AgencyID;
		self.Jgmts78_AgencyID     := ri.LnJJudgments[78].AgencyID;
		self.Jgmts79_AgencyID     := ri.LnJJudgments[79].AgencyID;
		self.Jgmts80_AgencyID     := ri.LnJJudgments[80].AgencyID;
		self.Jgmts81_AgencyID     := ri.LnJJudgments[81].AgencyID;
		self.Jgmts82_AgencyID     := ri.LnJJudgments[82].AgencyID;
		self.Jgmts83_AgencyID     := ri.LnJJudgments[83].AgencyID;
		self.Jgmts84_AgencyID     := ri.LnJJudgments[84].AgencyID;
		self.Jgmts85_AgencyID     := ri.LnJJudgments[85].AgencyID;
		self.Jgmts86_AgencyID     := ri.LnJJudgments[86].AgencyID;
		self.Jgmts87_AgencyID     := ri.LnJJudgments[87].AgencyID;
		self.Jgmts88_AgencyID     := ri.LnJJudgments[88].AgencyID;
		self.Jgmts89_AgencyID     := ri.LnJJudgments[89].AgencyID;
		self.Jgmts90_AgencyID     := ri.LnJJudgments[90].AgencyID;
		self.Jgmts91_AgencyID     := ri.LnJJudgments[91].AgencyID;
		self.Jgmts92_AgencyID     := ri.LnJJudgments[92].AgencyID;
		self.Jgmts93_AgencyID     := ri.LnJJudgments[93].AgencyID;
		self.Jgmts94_AgencyID     := ri.LnJJudgments[94].AgencyID;
		self.Jgmts95_AgencyID     := ri.LnJJudgments[95].AgencyID;
		self.Jgmts96_AgencyID     := ri.LnJJudgments[96].AgencyID;
		self.Jgmts97_AgencyID     := ri.LnJJudgments[97].AgencyID;
		self.Jgmts98_AgencyID     := ri.LnJJudgments[98].AgencyID;
		self.Jgmts99_AgencyID     := ri.LnJJudgments[99].AgencyID;
		self.Full := ri.report.summary.name.full;
		self.First := ri.report.summary.name.first;
		self.Middle := ri.report.summary.name.middle;
		self.Last := ri.report.summary.name.last;
		self.Suffix := ri.report.summary.name.suffix;
		self.Prefix := ri.report.summary.name.prefix;
		self.StreetNumber := ri.report.summary.address.streetnumber;
		self.StreetPreDirection := ri.report.summary.address.StreetPreDirection;
		self.StreetName := ri.report.summary.address.StreetName;
		self.StreetSuffix := ri.report.summary.address.StreetSuffix;
		self.StreetPostDirection := ri.report.summary.address.StreetPostDirection;
		self.UnitDesignation := ri.report.summary.address.UnitDesignation;
		self.UnitNumber := ri.report.summary.address.UnitNumber;
		self.StreetAddress1 := ri.report.summary.address.StreetAddress1;
		self.StreetAddress2 := ri.report.summary.address.StreetAddress2;
		self.City := ri.report.summary.address.City;
		self.State := ri.report.summary.address.State;
		self.Zip5 := ri.report.summary.address.Zip5;
		self.Zip4 := ri.report.summary.address.Zip4;
		self.County := ri.report.summary.address.County;
		self.PostalCode := ri.report.summary.address.PostalCode;
		self.StateCityZip := ri.report.summary.address.StateCityZip;
		self.SSN := ri.report.summary.SSN;
		self.Phone := ri.report.summary.Phone;
		self.Year := ri.report.summary.DOB.Year;
		self.Month := ri.report.summary.DOB.Month;
		self.Day := ri.report.summary.DOB.Day;
		self.UniqueId := ri.report.summary.UniqueId;
		self.AddressStability := ri.report.summary.AddressStability;
		self.InquiriesRestricted := ri.report.summary.InquiriesRestricted;
		self.SSNMismatch := ri.report.summary.SSNMismatch;
		self.DOBMismatch := ri.report.summary.DOBMismatch;
		self.AddressMismatch := ri.report.summary.AddressMismatch;
		self.PhoneMismatch := ri.report.summary.PhoneMismatch;
		self.UniqueIDMismatch := ri.report.summary.UniqueIDMismatch;
		self := ri;
		self := []; 
end;

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
              c=197	=> 'CheckNegRiskDecTimeNewest',
              c=198	=> 'CheckNegPaidTimeNewest',
              c=199	=> 'CheckCountTotal',
              c=200	=> 'CheckAmountTotal',
              c=201	=> 'CheckAmountTotalSinceNegPaid',
              c=202	=> 'CheckAmountTotal03Month',
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
              c=197	=>  le.CheckNegRiskDecTimeNewest,
              c=198	=>  le.CheckNegPaidTimeNewest,
              c=199	=>  le.CheckCountTotal,
              c=200	=>  le.CheckAmountTotal,
              c=201	=>  le.CheckAmountTotalSinceNegPaid,
              c=202	=>  le.CheckAmountTotal03Month,
                        ''
              );
END;


EXPORT iesp.riskview2.t_RiskView2ModelHRI intoModel(riskview.layouts.layout_riskview5_search_results le, integer c) := TRANSFORM
		
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
			{1, reason1, Risk_Indicators.getHRIDesc(reason1)},
			{2, reason2, Risk_Indicators.getHRIDesc(reason2)},
			{3, reason3, Risk_Indicators.getHRIDesc(reason3)},
			{4, reason4, Risk_Indicators.getHRIDesc(reason4)},
			{5, reason5, Risk_Indicators.getHRIDesc(reason5)}
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