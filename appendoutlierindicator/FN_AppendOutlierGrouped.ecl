/**
 * Find outliers in grouped numeric data using the Interquartile Deviation
 * (IDQ) method.  Records with outlier values are tagged as minor or major and
 * their absolute deviation from the mean are appended.
 *
 * Groups must contain at least five non-NULL data value records in order to
 * detect outliers.  If a group contains less than five records then none of
 * them will be marked as outliers.
 *
 * @param inFile                    The dataset to process; REQUIRED.
 * @param valueField                The name of the field containing the value
 *                                  to analyze; this is not a string; REQUIRED.
 * @param groupingFieldsStr         A string containing a list of comma-delimited
 *                                  fields to group the results within; REQUIRED.
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
 *                                  median value of the group (will show zero
 *                                  for non-outliers).
 */

EXPORT FN_AppendOutlierGrouped
    (
        inFile,
        valueField,
        groupingFieldsStr,
        appendPrefix = '\'\'',
        nullValue = '',
        minorOutlierMultiplier = 1.5,
        majorOutlierMultiplier = 3.0
    ) := FUNCTIONMACRO

    // Useful items for later
    LOCAL myGroupingFieldsStr := TRIM(groupingFieldsStr, ALL);
    LOCAL leftGroupingFieldsStr := REGEXREPLACE('(^|,)', myGroupingFieldsStr, '$1LEFT.');
    LOCAL ValueField_t := TYPEOF(inFile.valueField);

    // Remove null value records, if any
    LOCAL myData := #IF(#TEXT(nullValue) != '') inFile(valueField != (ValueField_t)nullValue) #ELSE inFile #END;
    LOCAL nullData := #IF(#TEXT(nullValue) != '') inFile(valueField = (ValueField_t)nullValue) #ELSE DATASET([], RECORDOF(inFile)) #END;

    #UNIQUENAME(recid)
    #UNIQUENAME(hashValue)
    LOCAL DataRec := RECORD
        UNSIGNED6   %recid%;
        UNSIGNED8   %hashValue%;
        RECORDOF(myData);
    END;

    // Assign a hash value for the group fields
    LOCAL myDataPlusHash := PROJECT
        (
            myData,
            TRANSFORM
                (
                    DataRec,
                    SELF.%hashValue% := HASH64(#EXPAND(leftGroupingFieldsStr)),
                    SELF := LEFT,
                    SELF := []
                )
        );

    // Distribute the data based on the hash
    LOCAL distributedData := DISTRIBUTE(myDataPlusHash, %hashValue%);

    // Create a reduced dataset that contains only the unique values and the
    // number of times those values appear
    groupedCards := TABLE
        (
            distributedData,
            {
                %hashValue%,
                valueField,
                UNSIGNED6   cnt := COUNT(GROUP),
                UNSIGNED6   valueEndPos := 0
            },
            %hashValue%, valueField,
            LOCAL
        );

    // Determine the position of the last record in the original dataset that
    // contains a particular value within the group
    groupedCards2 := ITERATE
        (
            SORT(groupedCards, %hashValue%, valueField, LOCAL),
            TRANSFORM
                (
                    RECORDOF(LEFT),
                    SELF.valueEndPos := IF(LEFT.%hashValue% = RIGHT.%hashValue%, LEFT.valueEndPos + RIGHT.cnt, RIGHT.cnt),
                    SELF := RIGHT
                ),
            LOCAL
        );

    // Find the number of records in each group
    LOCAL groupRecCountsTemp := TABLE
        (
            groupedCards2,
            {
                %hashValue%,
                UNSIGNED2   recCount := MAX(GROUP, valueEndPos)
            },
            %hashValue%,
            LOCAL
        );

    // Distribute the result based on the hash of the group fields so we can
    // use local operations later
    LOCAL groupRecCounts := DISTRIBUTE(groupRecCountsTemp(recCount >= 5), %hashValue%);

    // Build a quartile info record
    LOCAL GroupInfoRec := RECORD
        RECORDOF(groupRecCounts);
        UNSIGNED4       q1Pos1;
        UNSIGNED4       q1Pos2;
        ValueField_t    q1Value1;
        ValueField_t    q1Value2;
        REAL4           q1Value;
        UNSIGNED4       q2Pos1;
        UNSIGNED4       q2Pos2;
        ValueField_t    q2Value1;
        ValueField_t    q2Value2;
        REAL4           q2Value;
        UNSIGNED4       q3Pos1;
        UNSIGNED4       q3Pos2;
        ValueField_t    q3Value1;
        ValueField_t    q3Value2;
        REAL4           q3Value;
        REAL4           innerFenceMin;
        REAL4           innerFenceMax;
        REAL4           outerFenceMin;
        REAL4           outerFenceMax;
    END;

    // Compute the quartile positions in each group
    LOCAL groupInfo := PROJECT
        (
            groupRecCounts,
            TRANSFORM
                (
                    GroupInfoRec,

                    wholeHasEvenNumberOfElements := (LEFT.recCount % 2) = 0;
                    SELF.q2Pos1 := LEFT.recCount DIV 2 + IF(wholeHasEvenNumberOfElements, 0, 1);
                    SELF.q2Pos2 := IF(wholeHasEvenNumberOfElements, SELF.q2Pos1 + 1, SELF.q2Pos1);

                    q1NumRecs := SELF.q2Pos1;
                    q1HasEvenNumberOfElements := (q1NumRecs % 2) = 0;
                    SELF.q1Pos1 := q1NumRecs DIV 2 + IF(q1HasEvenNumberOfElements, 0, 1);
                    SELF.q1Pos2 := IF(q1HasEvenNumberOfElements, SELF.q1Pos1 + 1, SELF.q1Pos1);

                    q3NumRecs := LEFT.recCount - SELF.q2Pos2 + 1;
                    q3HasEvenNumberOfElements := (q3NumRecs % 2) = 0;
                    SELF.q3Pos1 := q3NumRecs DIV 2 + IF(q3HasEvenNumberOfElements, 0, 1) + SELF.q2Pos2 - 1;
                    SELF.q3Pos2 := IF(q3HasEvenNumberOfElements, SELF.q3Pos1 + 1, SELF.q3Pos1);

                    SELF := LEFT;
                    SELF := [];
                ),
            LOCAL
        );

    LOCAL sequencedData := SORT(groupedCards2, %hashValue%, valueEndPos, LOCAL);

    // Extract values of quartile positions
    LOCAL j10 := JOIN
        (
            groupInfo,
            sequencedData,
            LEFT.%hashValue% = RIGHT.%hashValue% AND RIGHT.valueEndPos >= LEFT.q1Pos1,
            TRANSFORM
                (
                    GroupInfoRec,
                    SELF.q1Value1 := RIGHT.valueField,
                    SELF := LEFT
                ),
            LOCAL, NOSORT, KEEP(1)
        );

    LOCAL j20 := JOIN
        (
            j10,
            sequencedData,
            LEFT.%hashValue% = RIGHT.%hashValue% AND RIGHT.valueEndPos >= LEFT.q1Pos2,
            TRANSFORM
                (
                    GroupInfoRec,
                    SELF.q1Value2 := RIGHT.valueField,
                    SELF := LEFT
                ),
            LOCAL, NOSORT, KEEP(1)
        );

    LOCAL j30 := JOIN
        (
            j20,
            sequencedData,
            LEFT.%hashValue% = RIGHT.%hashValue% AND RIGHT.valueEndPos >= LEFT.q2Pos1,
            TRANSFORM
                (
                    GroupInfoRec,
                    SELF.q2Value1 := RIGHT.valueField,
                    SELF := LEFT
                ),
            LOCAL, NOSORT, KEEP(1)
        );

    LOCAL j40 := JOIN
        (
            j30,
            sequencedData,
            LEFT.%hashValue% = RIGHT.%hashValue% AND RIGHT.valueEndPos >= LEFT.q2Pos2,
            TRANSFORM
                (
                    GroupInfoRec,
                    SELF.q2Value2 := RIGHT.valueField,
                    SELF := LEFT
                ),
            LOCAL, NOSORT, KEEP(1)
        );

    LOCAL j50 := JOIN
        (
            j40,
            sequencedData,
            LEFT.%hashValue% = RIGHT.%hashValue% AND RIGHT.valueEndPos >= LEFT.q3Pos1,
            TRANSFORM
                (
                    GroupInfoRec,
                    SELF.q3Value1 := RIGHT.valueField,
                    SELF := LEFT
                ),
            LOCAL, NOSORT, KEEP(1)
        );

    LOCAL j60 := JOIN
        (
            j50,
            sequencedData,
            LEFT.%hashValue% = RIGHT.%hashValue% AND RIGHT.valueEndPos >= LEFT.q3Pos2,
            TRANSFORM
                (
                    GroupInfoRec,
                    SELF.q3Value2 := RIGHT.valueField,
                    SELF := LEFT
                ),
            LOCAL, NOSORT, KEEP(1)
        );

    // Compute quartile boundary values, interquartile ranges and fence values
    LOCAL finalGroupInfo := PROJECT
        (
            j60,
            TRANSFORM
                (
                    GroupInfoRec,

                    SELF.q1Value := AVE(LEFT.q1Value1, LEFT.q1Value2);
                    SELF.q2Value := AVE(LEFT.q2Value1, LEFT.q2Value2);
                    SELF.q3Value := AVE(LEFT.q3Value1, LEFT.q3Value2);

                    interquartileRange := SELF.q3Value - SELF.q1Value;

                    SELF.innerFenceMin := SELF.q1Value - (interquartileRange * minorOutlierMultiplier);
                    SELF.innerFenceMax := SELF.q3Value + (interquartileRange * minorOutlierMultiplier);
                    SELF.outerFenceMin := SELF.q1Value - (interquartileRange * majorOutlierMultiplier);
                    SELF.outerFenceMax := SELF.q3Value + (interquartileRange * majorOutlierMultiplier);

                    SELF := LEFT;
                ),
            LOCAL
        );

    // Create the output dataset with appended fields
    LOCAL ResultRec := RECORD
        RECORDOF(inFile);
        STRING2     #EXPAND(appendPrefix + 'OutlierType');
        REAL        #EXPAND(appendPrefix + 'OutlierDiff');
    END;

    LOCAL resultDS := JOIN
        (
            distributedData,
            finalGroupInfo,
            LEFT.%hashValue% = RIGHT.%hashValue%,
            TRANSFORM
                (
                    ResultRec,
                    SELF.#EXPAND(appendPrefix + 'OutlierType') := MAP
                        (
                            #IF(#TEXT(nullValue) != '')
                                LEFT.valueField = (ValueField_t)nullValue   =>  '',     // Null Value
                            #END
                            RIGHT.%hashValue% = 0                           =>  '',     // No group info
                            LEFT.valueField <= RIGHT.outerFenceMin          =>  'ML',   // Major outlier
                            LEFT.valueField >= RIGHT.outerFenceMax          =>  'MH',   // Major outlier
                            LEFT.valueField <= RIGHT.innerFenceMin          =>  'ml',   // Minor outlier
                            LEFT.valueField >= RIGHT.innerFenceMax          =>  'mh',   // Minor outlier
                            ''
                        ),
                    SELF.#EXPAND(appendPrefix + 'OutlierDiff') := IF
                        (
                            SELF.#EXPAND(appendPrefix + 'OutlierType') != '',
                            ABS((REAL)LEFT.valueField - (REAL)RIGHT.q2Value),
                            0
                        ),
                    SELF := LEFT
                ),
            LOCAL, LEFT OUTER
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

    RETURN resultDS + nullDS;
ENDMACRO;
