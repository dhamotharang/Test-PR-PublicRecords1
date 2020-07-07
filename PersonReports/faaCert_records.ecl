IMPORT iesp, doxie, FaaV2_PilotServices, fcra, FFD, PersonReports;

// Shared structure in bpsreport was extended with descriptions' fields, 
// although descriptions were already returned for AssetReport in "_Type" and "Level" fields;
// it was decided to blank these descriptions fields for AssetReport
// (became apparent only when moving comp report to ESDL mode).

// Thus, although Bps and Asset reports share the same structure, the semantics of the fields is different.
// Hence, I had to provide two stand-alone outputs.

EXPORT faacert_records (
  dataset (doxie.layout_references) dids,
  PersonReports.IParam.faacerts in_params = module (PersonReports.IParam.faacerts) end,
  boolean IsFCRA = false,
  dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
  dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim
) := MODULE

  shared bps_pilots := FaaV2_PilotServices.Raw.getBpsReportByDID (dids, in_params.application_type, isFCRA, flagfile, slim_pc_recs, in_params.FFDOptionsMask);
  EXPORT bps_view := sort(bps_pilots, -DateCertifiedMedical.year, -DateCertifiedMedical.month);

  iesp.bpsreport_fcra.t_FcraFAACertificate GetCertificate (iesp.bpsreport_fcra.t_FcraFAACertificate L) := transform
    Self._Type := L.TypeDesc;
    Self.Level := L.LevelDesc;
    Self.TypeDesc := '';
    Self.LevelDesc := '';
    Self := L;
  end;
  iesp.bpsreport_fcra.t_FcraBpsFAACertification GetAssetReportView (iesp.bpsreport_fcra.t_FcraBpsFAACertification L) := transform
     Self.Certificates := project (L.Certificates, GetCertificate (Left));
     Self := L;
  end;
  recs := project (bps_pilots, GetAssetReportView (Left));
  EXPORT assetreport_view  := sort(recs, -DateCertifiedMedical.year, -DateCertifiedMedical.month);

END;
