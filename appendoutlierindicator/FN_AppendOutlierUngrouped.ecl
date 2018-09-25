/**
 * Find outliers in numeric data using the Interquartile Deviation (IDQ) method.
 * Records with outlier values are tagged as minor or major and their absolute
 * deviation from the mean are appended.
 *
 * The dataset must contain at least five non-NULL data value records in order
 * to detect outliers.  If the dataset contains less than five records then
 * none of them will be marked as outliers.
 *
 * @param inFile                    The dataset to process; REQUIRED.
 * @param valueField                The name of the field containing the value
 *                                  to analyze; this is not a string; REQUIRED.
 * @param appendPrefix              A string specifying a prefix to add to the
 *                                  appended 'RecID' field; OPTIONAL, defaults to
 *                                  an empty string.
 * @param nullValue                 A value that represents a NULL in valueField,
 *                                  indicating that this function should skip
 *                                  records containing that value; OPTIONAL,
 *                                  defaults to nothing (meaning that there are no
 *                                  NULL values).
 * @param minorOutlierMultiplier    The value to multiply against the interquartile
 *                                  range to calculate the lower and higher
 *                                  acceptable boundaries for a minor outlier;
 *                                  OPTIONAL, defaults to 1.5.
 * @param majorOutlierMultiplier    The value to multiply against the interquartile
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
 *                                  median value of the dataset (will show zero
 *                                  for non-outliers).
 */

EXPORT FN_AppendOutlierUngrouped
    (
        inFile,
        valueField,
        appendPrefix = '\'\'',
        nullValue = '',
        minorOutlierMultiplier = 1.5,
        majorOutlierMultiplier = 3.0
    ) := FUNCTIONMACRO

    IMPORT ecl;

    LOCAL ValueField_t := TYPEOF(inFile.valueField);

    // Remove null value records, if any
    LOCAL myData := #IF(#TEXT(nullValue) != '') inFile(valueField != (ValueField_t)nullValue) #ELSE inFile #END;
    LOCAL nullData := #IF(#TEXT(nullValue) != '') inFile(valueField = (ValueField_t)nullValue) #ELSE DATASET([], RECORDOF(inFile)) #END;

    // Sequence the records in sorted order
    #UNIQUENAME(seqPrefix)
    LOCAL sequencedData := ecl.FN_AppendUniqueID(SORT(UNGROUP(myData), valueField), 1, TRUE, %'seqPrefix'%);

    // The total number of records in inFile
    LOCAL wholeNumRecs := MAX(sequencedData, #EXPAND(%'seqPrefix'% + 'RecID'));

    // Compute the median
    LOCAL wholeHasEvenNumberOfElements := (wholeNumRecs % 2) = 0;
    LOCAL q2Pos1 := wholeNumRecs DIV 2 + IF(wholeHasEvenNumberOfElements, 0, 1);
    LOCAL q2Pos2 := IF(wholeHasEvenNumberOfElements, q2Pos1 + 1, q2Pos1);
    LOCAL q2Value1 := sequencedData(#EXPAND(%'seqPrefix'% + 'RecID') = q2Pos1)[1].valueField;
    LOCAL q2Value2 := sequencedData(#EXPAND(%'seqPrefix'% + 'RecID') = q2Pos2)[1].valueField;
    LOCAL q2Value := AVE(q2Value1, q2Value2);

    // Compute the lower quartile
    LOCAL q1NumRecs := q2Pos1;
    LOCAL q1HasEvenNumberOfElements := (q1NumRecs % 2) = 0;
    LOCAL q1Pos1 := q1NumRecs DIV 2 + IF(q1HasEvenNumberOfElements, 0, 1);
    LOCAL q1Pos2 := IF(q1HasEvenNumberOfElements, q1Pos1 + 1, q1Pos1);
    LOCAL q1Value1 := sequencedData(#EXPAND(%'seqPrefix'% + 'RecID') = q1Pos1)[1].valueField;
    LOCAL q1Value2 := sequencedData(#EXPAND(%'seqPrefix'% + 'RecID') = q1Pos2)[1].valueField;
    LOCAL q1Value := AVE(q1Value2, q1Value2);

    // Compute the upper quartile
    LOCAL q3NumRecs := wholeNumRecs - q2Pos2 + 1;
    LOCAL q3HasEvenNumberOfElements := (q3NumRecs % 2) = 0;
    LOCAL q3Pos1 := q3NumRecs DIV 2 + IF(q3HasEvenNumberOfElements, 0, 1) + q2Pos2 - 1;
    LOCAL q3Pos2 := IF(q3HasEvenNumberOfElements, q3Pos1 + 1, q3Pos1);
    LOCAL q3Value1 := sequencedData(#EXPAND(%'seqPrefix'% + 'RecID') = q3Pos1)[1].valueField;
    LOCAL q3Value2 := sequencedData(#EXPAND(%'seqPrefix'% + 'RecID') = q3Pos2)[1].valueField;
    LOCAL q3Value := AVE(q3Value1, q3Value2);

    // Compute the outlier fences
    LOCAL interquartileRange := q3Value - q1Value;
    LOCAL innerFenceMin := q1Value - (interquartileRange * minorOutlierMultiplier);
    LOCAL innerFenceMax := q3Value + (interquartileRange * minorOutlierMultiplier);
    LOCAL outerFenceMin := q1Value - (interquartileRange * majorOutlierMultiplier);
    LOCAL outerFenceMax := q3Value + (interquartileRange * majorOutlierMultiplier);

    // Create the output dataset with appended fields
    LOCAL ResultRec := RECORD
        RECORDOF(inFile);
        STRING2     #EXPAND(appendPrefix + 'OutlierType');
        REAL4       #EXPAND(appendPrefix + 'OutlierDiff');
    END;

    LOCAL resultDS := PROJECT
        (
            inFile,
            TRANSFORM
                (
                    ResultRec,
                    SELF.#EXPAND(appendPrefix + 'OutlierType') := MAP
                        (
                            #IF(#TEXT(nullValue) != '')
                                LEFT.valueField = (ValueField_t)nullValue   =>  '',     // Null Value
                            #END
                            LEFT.valueField <= outerFenceMin                =>  'ML',   // Major outlier
                            LEFT.valueField >= outerFenceMax                =>  'MH',   // Major outlier
                            LEFT.valueField <= innerFenceMin                =>  'ml',   // Minor outlier
                            LEFT.valueField >= innerFenceMax                =>  'mh',   // Minor outlier
                            ''
                        ),
                    SELF.#EXPAND(appendPrefix + 'OutlierDiff') := IF
                        (
                            SELF.#EXPAND(appendPrefix + 'OutlierType') != '',
                            ABS((REAL4)LEFT.valueField - (REAL4)q2Value),
                            0
                        ),
                    SELF := LEFT
                ),
            LOCAL
        );

    LOCAL nullDS := PROJECT
        (
            nullData,
            TRANSFORM
                (
                    ResultRec,
                    SELF := LEFT,
                    SELF := []
                )
        );

    LOCAL finalResult := resultDS + nullDS;

    LOCAL nothingDoneDS := PROJECT
        (
            inFile,
            TRANSFORM
                (
                    ResultRec,
                    SELF := LEFT,
                    SELF := []
                )
        );

    RETURN IF(COUNT(inFile) >= 5, finalResult, nothingDoneDS);
ENDMACRO;
