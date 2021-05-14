IMPORT CanadianPhones, Data_Services, doxie;

dcwpwfdid := CanadianPhones.file_cwp_with_fdid(did<>0);

lcwpdid := RECORD
  UNSIGNED6 did;
  UNSIGNED6 fdid;
  UNSIGNED4 global_sid;
  UNSIGNED8 record_sid;
END;

dcwpdid := PROJECT(dcwpwfdid,lcwpdid);

EXPORT key_did := INDEX(dcwpdid,{did},{dcwpdid},
  Data_Services.Data_location.Prefix('CWP')+'thor_data400::key::canadianwp_did_' + doxie.Version_SuperKey);
