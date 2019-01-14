/**
 * Find outliers in numeric data using the Interquartile Deviation (IDQ) method.
 * Records with outlier values are tagged as minor or major and their absolute
 * deviation from the mean are appended.
 *
 * @param pInfile                   The dataset to process; REQUIRED.
 * @param pValueField               The name of the field containing the value
 *                                  to analyze; this is not a string; REQUIRED.
 * @param pAppendPrefix             A string specifying a prefix to add to the
 *                                  appended 'RecID' field; OPTIONAL, defaults to
 *                                  an empty string.
 * @param pNullValue                A value that represents a NULL in pValueField,
 *                                  indicating that this function should skip
 *                                  records containing that value; OPTIONAL,
 *                                  defaults to nothing (meaning that there are no
 *                                  NULL values).
 * @param pGroupingFieldsStr        A string containing a list of comma-delimited
 *                                  fields to group the results within; OPTIONAL,
 *                                  defaults to an empty string.
 * @param pMinorOutlierMultiplier   The value to multiply against the interquartile
 *                                  range to calculate the lower and higher
 *                                  acceptable boundaries for a minor outlier;
 *                                  OPTIONAL, defaults to 1.5.
 * @param pMajorOutlierMultiplier   The value to multiply against the interquartile
 *                                  range to calculate the lower and higher
 *                                  acceptable boundaries for a major outlier;
 *                                  OPTIONAL, defaults to 3.0.
 *
 * @return                          The original input dataset with two fields
 *                                  appended:  An indicator showing if the
 *                                  value in that record is a major outlier ('M'),
 *                                  a minor outlier ('m'), or not an outlier ('');
 *                                  and a field showing the absolute value of the
 *                                  difference between the given value and the
 *                                  median value of the dataset or group (will
 *                                  show zero for non-outliers).
 */

EXPORT FN_AppendOutlierInfo
    (
        pInfile,
        pValueField,
        pAppendPrefix = '\'\'',
        pNullValue = '',
        pGroupingFieldsStr = '\'\'',
        pMinorOutlierMultiplier = 1.5,
        pMajorOutlierMultiplier = 3.0
    ) := FUNCTIONMACRO

    IMPORT AppendOutlierIndicator;

    LOCAL hasGrouping := (TRIM(pGroupingFieldsStr, ALL) != '');

    LOCAL ResultRec := RECORD
        RECORDOF(pInfile);
        STRING2     #EXPAND(pAppendPrefix + 'OutlierType');
        REAL4       #EXPAND(pAppendPrefix + 'OutlierDiff');
    END;

    // Call one of the other functions to perform the actual work; note
    // that determining which method to call is performed at compile time,
    // not run time
    LOCAL functionResult := #IF(hasGrouping)
            AppendOutlierIndicator.FN_AppendOutlierGrouped
                (
                    pInfile,
                    pValueField,
                    pGroupingFieldsStr
                    #IF(#TEXT(pAppendPrefix) != '') , appendPrefix := pAppendPrefix #END
                    #IF(#TEXT(pNullValue) != '') , nullValue := pNullValue #END
                    #IF(#TEXT(pMinorOutlierMultiplier) != '') , minorOutlierMultiplier := pMinorOutlierMultiplier #END
                    #IF(#TEXT(pMajorOutlierMultiplier) != '') , majorOutlierMultiplier := pMajorOutlierMultiplier #END
                );
        #ELSE
            AppendOutlierIndicator.FN_AppendOutlierUngrouped
                (
                    pInfile,
                    pValueField
                    #IF(#TEXT(pAppendPrefix) != '') , appendPrefix := pAppendPrefix #END
                    #IF(#TEXT(pNullValue) != '') , nullValue := pNullValue #END
                    #IF(#TEXT(pMinorOutlierMultiplier) != '') , minorOutlierMultiplier := pMinorOutlierMultiplier #END
                    #IF(#TEXT(pMajorOutlierMultiplier) != '') , majorOutlierMultiplier := pMajorOutlierMultiplier #END
                );
        #END

    // Make sure the results are in a common, known format
    LOCAL result := PROJECT
        (
            functionResult,
            TRANSFORM
                (
                    ResultRec,
                    SELF := LEFT
                ),
            LOCAL
        );

    RETURN result;
ENDMACRO;
