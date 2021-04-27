IMPORT dx_official_records;

EXPORT Constants := MODULE

  EXPORT ak_root := dx_official_records.names().ak_prefix;
  EXPORT ak_dataset := DATASET([], dx_official_records.layouts.ak_rec);
  EXPORT ak_skipSet := ['P','Q','S','F'];
  EXPORT ak_typeStr := '\'AK\'';

  EXPORT MAX_RECS_ON_JOIN := 10000;

END;
