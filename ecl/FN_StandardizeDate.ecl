/**
 * Given a dataset with a date saved in a field, convert the date to the
 * standard format of YYYYMMDD and append it in a new field to the dataset.
 * You may optionally provide the name of the new field; if you don't provide
 * one then its name will be the same as the original date field name with a
 * "_yyyymmdd" suffix appended (e.g. given that the date field is named
 * "birthday" then the appended field will be named "birthday_yyyymmdd" unless
 * a different name was provided).  An additional field will be appended
 * indicating whether the date was valid and parsed OK or not
 * ("birthday_parsed_valid").  The new dataset is returned.
 *
 * @note This code requires HPCC 5.2.0 or later.
 *
 * @param inFile        The dataset to process; REQUIRED.
 * @param dateField     The name of the field containing the date to parse;
 *                      this is not a string; REQUIRED.
 * @param dateFormat    A string containing the expected format of the date
 *                      field; REQUIRED; supported patterns within the string:
 *                          YYYY    (four-digit year)
 *                          YY      (two-digit year)
 *                          MM      (one- or two-digit month, 1 - 12)
 *                          MONTH   (full name of month)
 *                          MON     (three-letter month abbreviation)
 *                          DD      (one- or two-digit day, 1 - last day of month)
 * @param outDateField  The field in which the parsed and rewritten date should
 *                      be placed; this is not a string; OPTIONAL, defaults to
 *                      <dateField>_yyyymmdd.
 *
 * @return              The modified dataset.
 */

EXPORT FN_StandardizeDate(inFile, dateField, dateFormat, outDateField = '') := FUNCTIONMACRO
    IMPORT Std;

    // Rewrite pattern to be compatible with Std.Date function
    LOCAL format1 := REGEXREPLACE('YYYY', Std.Str.ToUpperCase(dateFormat), '%Y');
    LOCAL format2 := REGEXREPLACE('YY', format1, '%y');
    LOCAL format3 := REGEXREPLACE('MM', format2, '%m');
    LOCAL format4 := REGEXREPLACE('DD', format3, '%d');
    LOCAL format5 := REGEXREPLACE('MONTH', format4, '%B');
    LOCAL format6 := REGEXREPLACE('MON', format5, '%b');
    LOCAL format := format6;

    LOCAL hasDay := Std.Str.Contains(format, '%d', FALSE);

    LOCAL okFieldName := IF(#TEXT(outDateField) != '', #TEXT(outDateField), #TEXT(dateField)) + '_parsed_valid';
    LOCAL outFieldName := IF(#TEXT(outDateField) != '', #TEXT(outDateField), #TEXT(dateField) + '_yyyymmdd');

    LOCAL OutLayout := RECORD
        RECORDOF(inFile);
        BOOLEAN     #EXPAND(okFieldName);
        UNSIGNED4   #EXPAND(outFieldName);
    END;

    LOCAL OutLayout MakeOutLayout(RECORDOF(inFile) l) := TRANSFORM
        theDate := Std.Date.FromStringToDate((STRING)l.dateField, format);
        dateIsValid := Std.Date.IsValidDate(theDate) OR (~hasDay AND Std.Date.IsValidDate(theDate + 1));

        SELF.#EXPAND(okFieldName) := dateIsValid;
        SELF.#EXPAND(outFieldName) := IF(dateIsValid, theDate, 0);
        SELF := l;
    END;

    LOCAL outFile := PROJECT(inFile, MakeOutLayout(LEFT));

    RETURN outFile;
ENDMACRO;

/*

Example usage:

DataRec := RECORD
    STRING      date1;
    STRING      date2;
END;

ds := DATASET
    (
        [
            {'February 17, 1965', '2/17/65'},
            {'June 2, 1961', '6/1/61'}
        ],
        DataRec
    );

r10 := FN_StandardizeDate(ds, date1, 'MONTH DD, YYYY');
OUTPUT(r10, NAMED('MONTH_DD_YYYY'));

r20 := FN_StandardizeDate(ds, date2, 'MM/DD/YY', standardized_date);
OUTPUT(r20, NAMED('MM_DD_YY'));

*/
