// For use in index definitions: index name can be defined using these constants;
// may replace (boolean IsFCRA).
EXPORT data_env := MODULE

  EXPORT UNSIGNED1 iNonFCRA := 0;
  EXPORT UNSIGNED1 iFCRA := 1;
  EXPORT UNSIGNED1 iPRCT := 2;
  EXPORT UNSIGNED1 iHIPAA := 4;
  EXPORT BOOLEAN isFCRA(UNSIGNED __env) := __env = iFCRA;
  EXPORT UNSIGNED1 GetEnvFCRA(BOOLEAN isFCRA) := IF(isFCRA, iFCRA, iNonFCRA);

  EXPORT STRING GetString(UNSIGNED __env) := TRIM(CASE(__env,
                                                  iFCRA    => 'fcra',
                                                  iPRCT    => 'prct',
                                                  iHIPAA   => 'hipaa',
                                                  ''));
END;
