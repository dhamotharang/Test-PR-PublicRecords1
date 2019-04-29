// This will filter a set of records, returning only those allowable for direct marketing (based
//  on the source value).
// Commonnly used codes_file_name's include:
//  [ 'CORP_SOURCES', 'PROPERTY_SOURCES', 'UCC_SOURCES', 'VEHICLE_SOURCES', 'WATERCRAFT_SOURCES' ]
// Common src_type values:
//  [ 'SCODE', 'SRCST', 'JURIS' ]
// By default, filter_empty_srcs filters out records with blank sources (to be on the safe side)
// -------------------------------------------------------------------------------------
EXPORT fmac_filterDirectMarketing(recs_in, codes_file_name, src_type = '', src_field = 'source', 
  filter_empty_srcs = 'TRUE') := FUNCTIONMACRO

  IMPORT Codes;

  LOCAL recs_filt := JOIN(recs_in(TRIM(src_field) <> ''), Codes.Key_Codes_V3, 
    KEYED(RIGHT.file_name = codes_file_name) AND 
    KEYED(RIGHT.field_name = 'DIRECTMARKETING') AND 
    KEYED(RIGHT.field_name2 = src_type) AND
    KEYED(TRIM(LEFT.src_field) = RIGHT.code),
    TRANSFORM(LEFT), LIMIT(0), KEEP(1));

  LOCAL recs_empty := recs_in(TRIM(src_field) = '');

  RETURN IF (filter_empty_srcs, recs_filt, (recs_filt + recs_empty));

ENDMACRO;
	