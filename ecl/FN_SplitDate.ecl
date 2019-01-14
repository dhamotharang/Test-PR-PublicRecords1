/**
 * Given a dataset with a date saved in a field, break the date out to
 * its component parts (year, month, day).  The component values are appended
 * to the original dataset as additional fields.  The additional fields are
 * named with the original field's name as a prefix followed by a suffix
 * describing the value (e.g. given that the date field is named "birthday"
 * then the appended fields will be named "birthday_year", "birthday_month",
 * and "birthday_day".  An additional field will be appended indicating whether
 * the date was valid and parsed OK or not ("birthday_parsed_valid").
 * The new dataset is returned.
 *
 * This code requires HPCC 5.2.0 or later.
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
 *
 * @return              The modified dataset.
 */

EXPORT FN_SplitDate(inFile, dateField, dateFormat, Prefix) := FUNCTIONMACRO
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

    LOCAL OutLayout := RECORD
        RECORDOF(inFile);
        BOOLEAN         #EXPAND(Prefix + 'ParsedValid');
        INTEGER2        #EXPAND(Prefix + 'Year');
        UNSIGNED1       #EXPAND(Prefix + 'Month');
        UNSIGNED1       #EXPAND(Prefix + 'Day');
    END;

    LOCAL OutLayout MakeOutLayout(RECORDOF(inFile) l) := TRANSFORM
        theDate := Std.Date.FromStringToDate((STRING)l.dateField, format);
        dateIsValid := Std.Date.IsValidDate(theDate) OR (~hasDay AND Std.Date.IsValidDate(theDate + 1));

        SELF.#EXPAND(Prefix + 'ParsedValid') := dateIsValid;
        SELF.#EXPAND(Prefix + 'Year') := IF(dateIsValid, Std.Date.Year(theDate), 0);
        SELF.#EXPAND(Prefix + 'Month') := IF(dateIsValid, Std.Date.Month(theDate), 0);
        SELF.#EXPAND(Prefix + 'Day') := IF(dateIsValid, Std.Date.Day(theDate), 0);
        SELF := l;
    END;

    LOCAL outFile := PROJECT(inFile, MakeOutLayout(LEFT));

    RETURN outFile;
ENDMACRO;

/*

Example usage:

DateRec := RECORD
    STRING      myDate;
END;

ds := DATASET
    (
        [
            {'1965-02-17'},
            {'1961-06-02'}
        ],
        DateRec
    );

r10 := FN_SplitDate(ds, myDate, 'YYYY-MM-DD');

r10;

*/
