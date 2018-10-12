CleanDate HIPIE Plugin

This plugin standardizes a date value to YYYYMMDD (UNSIGNED4) format.  HPCC 5.2
or later is required.

INCOMING DATA NOTES

* Only one date field is processed at a time.  If you need to convert multiple
  fields, use this plugin multiple times in your composition.

* The source date value's format must be specified using a pattern.  Valid
  pattern components are:
        YYYY    (four-digit year)
        YY      (two-digit year)
        MM      (one- or two-digit month, 1 - 12)
        MONTH   (full name of month)
        MON     (three-letter month abbreviation)
        DD      (one- or two-digit day, 1 - last day of month)

* Example patterns for February 28, 2015 (which all result in 20150228):

        February 28, 2015       MONTH DD, YYYY
        Feb. 28, 2015           MON. DD, YYYY
        02/28/2015              MM/DD/YYYY
        02/28/15                MM/DD/YY
        2/28/15                 MM/DD/YY

* The 'day' portion of the date can be missing (all result in 20150200):

        February 2015           MONTH YYYY
        Feb. 2015               MON. YYYY
        02/2015                 MM/YYYY

APPENDED ATTRIBUTE NOTES

* The following attributes are appended:

- Date:  The parsed date value in YYYYMMDD format.  This is an UNSIGNED4 field.
  Dates that fail to parse will have a zero in this field.

- DateParsedValid:  Boolean indicating if the incoming value was correctly
  parsed into a valid date.  Note that a FALSE here could mean that the
  incoming date value is invalid or that the parsing failed.
