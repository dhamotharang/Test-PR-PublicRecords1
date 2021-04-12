// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO--
    InView Business Report.
*/

export InViewReportService := MACRO
#CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
#CONSTANT('TwoPartySearch', FALSE);

#onwarning(4207, ignore);

#option ('globalAutoHoist', false);
#option ('spotCSE', false);
#stored('useSupergroup',true);
#stored('useLevels',true);
#stored('isDayBR',true);
#stored('IncludeMultipleSecured',true);
#stored('ReturnRolledDebtors',true);
#constant('ExcludeBlankAddresses', true);
#constant('IncludeParentCompany', false);
#constant('SSNMask', 'ALL');
// #constant('UseGIDnotBDID', true);
#stored('LnBranded', true);   // needed in some attrs?

// only need v2 content
#constant('BankruptcyVersion',2);
#constant('JudgmentLienVersion',2);
#constant('VehicleVersion',2);
#constant('PropertyVersion',2);
#constant('UccVersion',2);

doxie_cbrs.mac_Selection_Declare();

rpt := InView_Services.InViewReport_records;

dnb_table := normalize(rpt, left.dnb,transform(right));
dnb_royalties := Royalty.RoyaltyDNB.GetOnlineRoyalties(dnb_table);

// dataset(iesp.gateway_inviewreport.t_InviewReportResponse) rpt.EquifaxBusinessReport
efx_table := normalize(rpt, left.EquifaxBusinessReport, transform(right));
inv_royalties := Royalty.RoyaltyInview.GetOnlineRoyalties(efx_table, Include_BusinessCreditRisk,  Include_BusinessFailureRiskLevel, Include_CustomBCIR);

royalties := dataset([], Royalty.Layouts.Royalty) +
	IF(Include_EquifaxBus_val, inv_royalties) +
	IF(Include_DunBradstreetRecords_val, dnb_royalties);

output(rpt, named('InViewReport'));
output(royalties, named('RoyaltySet'));

ENDMACRO;
