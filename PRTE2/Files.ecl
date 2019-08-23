//* Files - Foreclosure Files, Linkids;
EXPORT Files := MODULE
IMPORT PRTE2;

// LCAIN300 - I should be able to remove this as I remove the dead code here which is now in PRTE2_Foreclosures
EXPORT Foreclosure_Scrambled  := '~prte::ct::foreclosure::csv::scrambled';
EXPORT Foreclosure_Scrambled_DS  := DATASET(Foreclosure_Scrambled,
											prte2.layouts.foreclosure_batch_in,CSV(HEADING(1),QUOTE('"'),MAXLENGTH(32768)));

Export Linkids:=DATASET(prte2.constants.Linkids, prte2.Layouts.Norm, FLAT );

Export lnpr_IN := DATASET(prte2.constants.lnpr_in, prte2.Layouts.Linkid_Rec, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );

export global_sid	:= dataset(prte2.Constants.prefix + 'in::ccpa_global', prte2.Layouts.ccpa_global_sid, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) ); 

Export lnpr_DBA_IN:= DATASET(prte2.constants.lnpr_dba_in, prte2.Layouts.DBA_In_Rec, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );

Export Linkids_DBA:=DATASET(prte2.constants.DBA_Linkids, prte2.Layouts.DBA_Norm, FLAT );
END;