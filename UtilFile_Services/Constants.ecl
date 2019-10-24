IMPORT AutoKeyI;

EXPORT Constants := MODULE

  EXPORT MAX_ADDR_RECS := 10;
  EXPORT MAX_DID_RECS := 100;

  // error codes
  EXPORT NO_RECORDS := AutoKeyI.errorcodes._codes.NO_RECORDS; // 10
  EXPORT INSUFFICIENT_INPUT := AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT; // 301

  // address types
  EXPORT BILL := 'B';
  EXPORT SRVC := 'S';

  // Doxie.Util_records line 66
  EXPORT Util_Category_Desc(STRING code) := MAP(
      code IN ['1','C','E','G','O','P','W'] => 'INFRASTRUCTURE',
      code IN ['2','A','D','F','H','I','L','N','S','U','V','X'] => 'CONVENIENCE',
      code IN ['3','Z'] => 'MISCELLANEOUS',
      '');

END;
