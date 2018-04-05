/*--SOAP--
<message name="ComprehensiveReport" wuTimeout="300000">
<part name="IncludeEquifaxAcctDecisioning" type="xsd:boolean"/>
	
 </message>
*/
/*--INFO-- This service searches all available datafiles for fcra-compliant entries.*/

export Comprehensive_Report_Service := MACRO
IMPORT  AutoStandardI, CriminalRecords_Services, doxie, doxie_crs, 
        EquifaxDecisioning, FFD, Gateway, iesp, Royalty, suppress, WSInput;

WSInput.MAC_FCRA_Comprehensive_Report_Service();

#stored('IncludeAllDIDRecords','1');
#constant('ReportReq',true);
#constant('useOnlyBestDID',true);
#constant('IsCRS', true);

// a rather questionable way to exclude business header search in bankruptcy V3
#constant('NoDeepDive', true);

// use remote header data, apply fcra-filtering; note, party type must be blanked on FCRA-side!
boolean IsFCRA := true;
BOOLEAN EquifaxDecisioningRequested := FALSE : STORED('IncludeEquifaxAcctDecisioning');
input_params := AutoStandardI.GlobalModule(isFCRA);
doxie.MAC_Selection_Declare();

// SOAPCALL to a neutral side to get LexId
gateways := Gateway.Configuration.Get();
cr_neutral := doxie.Get_remote_header (gateways, IsFCRA);
remote_header := project (cr_neutral (errors.code = 0), transform (doxie.layout_central_header, SELF := Left))[1];
remote_header_err := project (cr_neutral (errors.code != 0), transform (doxie.layout_exceptions, SELF := Left));
dids := project (remote_header.best_information_children, doxie.layout_references);
did_fcra := dids[1].did;

application_type_value := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(isFCRA),AutoStandardI.InterfaceTranslator.application_type_val.params));

// FFD - BEGIN				 
integer8 inFFDMask := FFD.FFDMask.Get(inApplicationType:=application_type_value);
boolean ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDMask);

// get person context
in_pc := dataset([{FFD.Constants.SingleSearchAcctno, (unsigned)did_fcra}], FFD.Layouts.DidBatch);
pc_recs := FFD.FetchPersonContext(in_pc, gateways)(ShowConsumerStatements OR (RecordType = FFD.Constants.RecordType.DR));
slim_pc_recs := FFD.SlimPersonContext(pc_recs);

// FFD - END

boolean verify_did := false : stored ('VerifyUniqueID');
// NB: this call may throw an error if DID found cannot be verified against input criteria
ds_header := doxie.central_header (dids, IsFCRA, verify_did, false, slim_pc_recs, inFFDMask); // only one row at most

fcra_subj_only := false : stored ('ApplyNonsubjectRestrictions');
boolean isCollections := application_type_value IN AutoStandardI.Constants.COLLECTION_TYPES;
nss_default := if(fcra_subj_only or isCollections, Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription, Suppress.Constants.NonSubjectSuppression.doNothing);
nss := ut.GetNonSubjectSuppression(nss_default);

cent := doxie.central_records (IsFCRA, '', ds_header, nss, slim_pc_recs, inFFDMask); //party-type=''

// get DIDs calculated on a neutral side (same as in central records)
besr := normalize (choosen (cent, 1), left.best_information_children, transform(right));

eq_act_dec_rec := 
  EquifaxDecisioning.getAttributes(besr, 
                                   gateways,
                                   EquifaxDecisioningRequested, 
                                   input_params.DataPermissionMask
                                  );

tempmod := module(project(AutoStandardI.GlobalModule(IsFCRA),CriminalRecords_Services.IParam.report,opt))
  export string14 did := (string) dids[1].did;
  export string25 doc_number := '';
  export string60 offender_key := '';
  export boolean  IncludeAllCriminalRecords := true;
  export boolean  IncludeSexualOffenses := false;
  export integer8 FFDOptionsMask := inFFDMask;
  export boolean  SkipPersonContextCall := true;
end;
crmr := CriminalRecords_Services.ReportService_Records.val(tempmod, IsFCRA, pc_recs);
docr2 := IF (Include_CriminalRecords_val, crmr[1].CriminalRecords);

so_rec := doxie.SexOffender_Search_Records(besr, isFCRA, slim_pc_recs, inFFDMask);
soff := if(Include_SexualOffenses_val, dedup(sort(so_rec,seisint_primary_key),seisint_primary_key));

doxie_crs.layout_report_fcra patch(doxie.layout_central_records l) := transform
  self.DOC2_children         := global (docr2);
  self.sex_offenses_children := global(soff);
  self.Eq_Decisioning_Attr   := eq_act_dec_rec[1];
  self := l;
  self := []; //vehicles, images
end;

all_records := project (cent, patch(left));
consumer_statements := if(ShowConsumerStatements and exists(all_records), FFD.prepareConsumerStatements(pc_recs), FFD.Constants.BlankConsumerStatements); 

outputErrors := output (remote_header_err, NAMED('exception'), EXTEND);

// 'FARES' fcra-props are filtered out by definition; (no royalties).
royalties := IF(EquifaxDecisioningRequested, Royalty.RoyaltyEqDecisioning.GetOnlineRoyalties(eq_act_dec_rec));

DO_ALL := parallel(
  output (all_records,named('CRS_result')),
  output (consumer_statements,named('ConsumerStatements')),
  output (royalties,named('RoyaltySet')),
  outputErrors);
DO_ALL;

ENDMACRO;
 // Comprehensive_Report_Service ();