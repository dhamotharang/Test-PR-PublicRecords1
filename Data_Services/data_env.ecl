﻿﻿// For use in index definitions: index name can be defined using these constants;
// may replace (boolean IsFCRA).
EXPORT data_env := MODULE

  EXPORT UNSIGNED1 iNonFCRA := 0;
  EXPORT UNSIGNED1 iFCRA := 1;
  EXPORT UNSIGNED1 iPRCT := 2;

  EXPORT STRING GetString(UNSIGNED __env) := CASE(__env,
                                                  iNonFCRA => 'non-fcra',
                                                  iFCRA    => 'fcra',
                                                  iPRCT    => 'prct',
                                                  '');
END;