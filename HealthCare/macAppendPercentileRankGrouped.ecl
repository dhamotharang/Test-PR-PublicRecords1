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

EXPORT macAppendPercentileRankGrouped
    (
        inFile,
        valueField,
        groupingFieldsStr,
        appendPrefix = '\'\'',
        nullValue = ''
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
    #UNIQUENAME(dataValue)
		#UNIQUENAME(freq)
		#UNIQUENAME(cumulativefreq)
		#UNIQUENAME(percentile)
		#UNIQUENAME(recCount)
		
    LOCAL DataRec := RECORD
        UNSIGNED6   %recid%;
        UNSIGNED8   %hashValue%;
        UNSIGNED8   %dataValue%;
				UNSIGNED4		%recCount%;
				UNSIGNED4   %freq%;
				UNSIGNED4   %cumulativefreq%;
				UNSIGNED1   %percentile%;
				RECORDOF(myData);
    END;

    // Assign a hash value for the group fields
    LOCAL myDataPlusHash := PROJECT
        (
            myData,
            TRANSFORM
                (
                    DataRec,
										SELF.%recid% := COUNTER;
                    SELF.%hashValue% := HASH64(#EXPAND(leftGroupingFieldsStr)),
										SELF.%dataValue% := LEFT.valueField;
                    SELF := LEFT,
                    SELF := []
                )
        );

    // Distribute the data based on the hash
    LOCAL distributedData := DISTRIBUTE(myDataPlusHash, %hashValue%);
		
		// Get Frequency Value
		LOCAL frequencyData		:= TABLE (distributedData,{%hashValue%, %dataValue%, freq := COUNT(GROUP)}, %hashValue%, %dataValue%, MERGE);
		
		// Get record count for each group 
		LOCAL recordCountData		:= TABLE (distributedData,{%hashValue%, reccnt := COUNT(GROUP)}, %hashValue%, MERGE);
		
		// Append Frequency count
		LOCAL appendFreqData := JOIN (distributedData, frequencyData, left.%hashValue% = right.%hashValue% and left.%dataValue% = right.%dataValue%, 
																		TRANSFORM(DataRec, SELF.%freq% := RIGHT.freq; SELF := LEFT; SELF := [];), LEFT OUTER, HASH);

		// Append record count 
		LOCAL appendRecCountData := JOIN (appendFreqData, recordCountData, left.%hashValue% = right.%hashValue%, 
																		TRANSFORM(DataRec, SELF.%recCount% := RIGHT.reccnt; SELF := LEFT; SELF := [];), LEFT OUTER, HASH);

		LOCAL sortFreqData := GROUP( DEDUP( SORT (appendRecCountData, %hashValue%, %dataValue%, LOCAL),  %hashValue%, %dataValue%, LOCAL), %hashValue%, LOCAL);
		
		DataRec addPercentile (DataRec L, DataRec R) := TRANSFORM
			SELF.%cumulativefreq% := L.%cumulativefreq% + R.%freq%;
			SELF.%percentile% := ROUND (((SELF.%cumulativefreq%)/R.%recCount%)*100);
			SELF := R;
			SELF := [];
		END;
		
		LOCAL appendPercentileRank := UNGROUP(ITERATE (sortFreqData, addPercentile(LEFT, RIGHT)));
		
    // Create the output dataset with appended fields
    LOCAL ResultRec := RECORD
        RECORDOF(inFile);
        INTEGER2    #EXPAND(appendPrefix + 'Percentile');
        INTEGER8    #EXPAND(appendPrefix + 'PercentileValue');
    END;

    LOCAL resultDS := JOIN
        (
            distributedData,
            appendPercentileRank,
            LEFT.%hashValue% = RIGHT.%hashValue% and 
						LEFT.%dataValue% = RIGHT.%dataValue%,
            TRANSFORM
                (
                    ResultRec,
                    SELF.#EXPAND(appendPrefix + 'Percentile') := RIGHT.%percentile%,
                    SELF.#EXPAND(appendPrefix + 'PercentileValue') := RIGHT.%dataValue%,
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