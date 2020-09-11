IMPORT CanadianPhones, CanadianPhones_V2, Data_Services, doxie;

dcwpwfdid := CanadianPhones_V2.file_cwp_with_fdid(did<>0);

lcwpdid := RECORD
  UNSIGNED6 did;
  UNSIGNED6 fdid;
  UNSIGNED4 global_sid;
  UNSIGNED8 record_sid;
END;

dcwpdid := PROJECT(dcwpwfdid,lcwpdid);

EXPORT key_did := INDEX(dcwpdid,{did},{dcwpdid},
  Data_Services.Data_location.Prefix('CP_Ver2')+'thor_data400::key::canadianwp_v2::did_' + doxie.Version_SuperKey);
