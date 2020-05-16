/*********************************************************************************************
 *********************************************************************************************
    The first four outputs can be used to make

    graph 1 - count of records for each relevant date based on first/last seen
        - count_per_dt_first_seen
        - count_per_dt_seen_last

    graph 2 - count of records for each relevant date based on vendor first/last reported
        - count_per_dt_vendor_first
        - count_per_dt_vendor_last

    - Only records from last 10 years' dates are considered
 ********************************************************************************************
 ********************************************************************************************/

 
EXPORT REPORT_shifts_over_time := module

    // Import the full person header file from prod
    IMPORT data_services,dx_header;

    // import standard library
    IMPORT std;

    // get the current date, finds the date 10 years ago, removes the day part, and stores them as variables
    SHARED todayDate := STD.Date.Today();
    SHARED tenYearsAgo := STD.Date.AdjustDate(todayDate, -10);
    SHARED tenYearsAgoYearMonth := (integer)(tenYearsago / 100);

    // This saves the person header file into the variable unfilteredHDR
    SHARED unfilteredHDR := dataset(data_services.foreign_prod+'thor_data400::base::header_raw::latest_built',dx_header.layout_header,thor)
        :INDEPENDENT; // executes independently of other workflow items and is only executed once

    // Filter by removing all rows that have a 0 in first/last seen or first/last vendor reported
    // and by removing all dates that occurred before 10 years ago from current date
    SHARED HDR_no_zeroes := unfilteredHDR(dt_first_seen != 0 
                        AND dt_last_seen != 0
                        AND dt_vendor_first_reported != 0
                        AND dt_vendor_last_reported != 0);

    SHARED HDR := HDR_no_zeroes(dt_first_seen > tenYearsAgoYearMonth 
                        AND dt_last_seen > tenYearsAgoYearMonth 
                        AND dt_vendor_first_reported > tenYearsAgoYearMonth 
                        AND dt_vendor_last_reported > tenYearsAgoYearMonth);

    // Does a count for every dt_first_seen
    SHARED count_per_dt_first_seen_rec := RECORD
        HDR.dt_first_seen;
        unsigned countSeenFirst := count(group);
    END;

    // cross tab report, groups by dt_first_seen, and it counts the group size
    SHARED unsorted_count_per_dt_first_seen := table(HDR, count_per_dt_first_seen_rec, dt_first_seen);

    // sorts by dt_first_seen
    EXPORT count_per_dt_first_seen := sort(unsorted_count_per_dt_first_seen, dt_first_seen);


    // count of records per dt_last_seen
    SHARED count_per_dt_last_seen_rec := RECORD
        HDR.dt_last_seen;
        unsigned countSeenLast := count(group);
    END;

    // cross-tab report that groups bt dt_last_seen, and it counts the group size
    SHARED unsorted_count_per_dt_seen_last := table(HDR, count_per_dt_last_seen_rec, dt_last_seen);

    // sorts by dt_last_seen
    EXPORT count_per_dt_seen_last := sort(unsorted_count_per_dt_seen_last, dt_last_seen);

    // count of records per dt_vendor_first_reported
    SHARED count_per_dt_vendor_first_rec := RECORD
        HDR.dt_vendor_first_reported;
        unsigned countVendorFirst := count(group);
    END;

    // cross-tab report that groups bt dt_vendor_first_repoted, and it counts the group size
    SHARED unsorted_count_per_dt_vendor_first := table(HDR, count_per_dt_vendor_first_rec, dt_vendor_first_reported);

    // sorted by dt_vendor_first_reported
    EXPORT count_per_dt_vendor_first := sort(unsorted_count_per_dt_vendor_first, dt_vendor_first_reported);


    // count of records per dt_vendor_last_reported
    SHARED count_per_dt_vendor_last_rec := RECORD
        HDR.dt_vendor_last_reported;
        unsigned countVendorLast := count(group);
    END;

    // cross-tab report that groups bt dt_vendor_last_repoted, and it counts the group size
    SHARED unsorted_count_per_dt_vendor_last := table(HDR, count_per_dt_vendor_last_rec, dt_vendor_last_reported);

    // sorts by dt_vendor_last_reported
    EXPORT count_per_dt_vendor_last := sort(unsorted_count_per_dt_vendor_last, dt_vendor_last_reported);


    /*****************************************************************************
    *****************************************************************************
        This part counts the number of records per a set of pre-determined dates
    *****************************************************************************
    *****************************************************************************/

    // This function subtracts 3 months (times the input parameter) from the current date
    // It also removes the days in the date and returns that date
    SHARED unsigned getPreviousDate(integer num3Months) := FUNCTION
        // this subtracts three months times the input parameter
        dateXmonths := STD.Date.AdjustDate(TodayDate, 0, num3Months * -3);
        
        // this gets rid of the days in the date because the dates in the header file don't have days
        datesOnGraph := (unsigned)(dateXmonths/100);
        return datesOnGraph;
    END;

    ////////////////////////////////////////////////////////////////////////////////
    // Calculate all the dates as a set.  This is used by the per src calculations
    ///////////////////////////////////////////////////////////////////////////////

    // This record holds a single date field
    SHARED all_dates_Rec := RECORD
        unsigned8 date; // this is unsigned8 to align with a later record's data types
    END;

    // A dataset with only today's date.  Used as a starting place
    SHARED only_today_date := DATASET(
        [
            // This marks today's date on the graph
            { getPreviousDate(0) }
        ], all_dates_Rec
    );

    // Calculate a previous date and prepend it to existingDates
    // Prepending is done so that the dates go from oldest to newest
    SHARED getPreviousDateForAllDates(dataset(all_dates_Rec) existingDates, unsigned counterValue) := FUNCTION
        previous_date := DATASET(
            [
                { getPreviousDate(counterValue) }
            ], all_dates_Rec
        );

        return previous_date & existingDates;
    END;

    // Get a dataset of today's date plus a set of previous dates
    // I start with only_today_date and iterate 40 times, from 1 to 40 inclusive
    // Each time, I add a new record
    // to the dataset that calculates the previous date
    // For example, counter value of 1 is 3 months ago
    // For example, counter value of 2 is 6 months ago, etc.
    // ROWS(LEFT) = the dataset that is being grown over time
    // COUNTER = the iteration number, 1, 2, 3, etc.
    SHARED all_dates_in_dataset := LOOP(only_today_date, 40, getPreviousDateForAllDates(ROWS(LEFT), COUNTER));

    // Convert the dataset's date field into a set
    // This is so I can do all_dates[1], all_dates[2], etc. later on
    SHARED all_dates := SET(all_dates_in_dataset, date);

    // Get all sources
    

    ////////////////////////////////////////////////////
    ////////////////////////////////////////////////////
    // The following is for first/last seen
    ////////////////////////////////////////////////////
    ////////////////////////////////////////////////////

    ////////////////////////////////////////////
    // Calculates values per src for first/last seen
    ////////////////////////////////////////////

    // Get a count for each date per src.  This assumes the number of intervals is
    // today's date plus 40
    // but it does not assume what those interval dates are
    SHARED unsorted_seen_counts_per_src_Rec := RECORD
        // For a date#, it counts the number of rows where
        //  dt_first_seen <= a predetermined date
        //  AND dt_last_seen >= a predetermined date
        unsigned8 date1 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[1] AND HDR_no_zeroes.dt_last_seen >= all_dates[1]);
        unsigned8 date2 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[2] AND HDR_no_zeroes.dt_last_seen >= all_dates[2]);
        unsigned8 date3 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[3] AND HDR_no_zeroes.dt_last_seen >= all_dates[3]);
        unsigned8 date4 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[4] AND HDR_no_zeroes.dt_last_seen >= all_dates[4]);
        unsigned8 date5 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[5] AND HDR_no_zeroes.dt_last_seen >= all_dates[5]);
        unsigned8 date6 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[6] AND HDR_no_zeroes.dt_last_seen >= all_dates[6]);
        unsigned8 date7 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[7] AND HDR_no_zeroes.dt_last_seen >= all_dates[7]);
        unsigned8 date8 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[8] AND HDR_no_zeroes.dt_last_seen >= all_dates[8]);
        unsigned8 date9 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[9] AND HDR_no_zeroes.dt_last_seen >= all_dates[9]);
        unsigned8 date10 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[10] AND HDR_no_zeroes.dt_last_seen >= all_dates[10]);
        unsigned8 date11 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[11] AND HDR_no_zeroes.dt_last_seen >= all_dates[11]);
        unsigned8 date12 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[12] AND HDR_no_zeroes.dt_last_seen >= all_dates[12]);
        unsigned8 date13 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[13] AND HDR_no_zeroes.dt_last_seen >= all_dates[13]);
        unsigned8 date14 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[14] AND HDR_no_zeroes.dt_last_seen >= all_dates[14]);
        unsigned8 date15 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[15] AND HDR_no_zeroes.dt_last_seen >= all_dates[15]);
        unsigned8 date16 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[16] AND HDR_no_zeroes.dt_last_seen >= all_dates[16]);
        unsigned8 date17 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[17] AND HDR_no_zeroes.dt_last_seen >= all_dates[17]);
        unsigned8 date18 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[18] AND HDR_no_zeroes.dt_last_seen >= all_dates[18]);
        unsigned8 date19 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[19] AND HDR_no_zeroes.dt_last_seen >= all_dates[19]);
        unsigned8 date20 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[20] AND HDR_no_zeroes.dt_last_seen >= all_dates[20]);
        unsigned8 date21 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[21] AND HDR_no_zeroes.dt_last_seen >= all_dates[21]);
        unsigned8 date22 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[22] AND HDR_no_zeroes.dt_last_seen >= all_dates[22]);
        unsigned8 date23 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[23] AND HDR_no_zeroes.dt_last_seen >= all_dates[23]);
        unsigned8 date24 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[24] AND HDR_no_zeroes.dt_last_seen >= all_dates[24]);
        unsigned8 date25 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[25] AND HDR_no_zeroes.dt_last_seen >= all_dates[25]);
        unsigned8 date26 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[26] AND HDR_no_zeroes.dt_last_seen >= all_dates[26]);
        unsigned8 date27 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[27] AND HDR_no_zeroes.dt_last_seen >= all_dates[27]);
        unsigned8 date28 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[28] AND HDR_no_zeroes.dt_last_seen >= all_dates[28]);
        unsigned8 date29 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[29] AND HDR_no_zeroes.dt_last_seen >= all_dates[29]);
        unsigned8 date30 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[30] AND HDR_no_zeroes.dt_last_seen >= all_dates[30]);
        unsigned8 date31 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[31] AND HDR_no_zeroes.dt_last_seen >= all_dates[31]);
        unsigned8 date32 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[32] AND HDR_no_zeroes.dt_last_seen >= all_dates[32]);
        unsigned8 date33 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[33] AND HDR_no_zeroes.dt_last_seen >= all_dates[33]);
        unsigned8 date34 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[34] AND HDR_no_zeroes.dt_last_seen >= all_dates[34]);
        unsigned8 date35 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[35] AND HDR_no_zeroes.dt_last_seen >= all_dates[35]);
        unsigned8 date36 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[36] AND HDR_no_zeroes.dt_last_seen >= all_dates[36]);
        unsigned8 date37 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[37] AND HDR_no_zeroes.dt_last_seen >= all_dates[37]);
        unsigned8 date38 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[38] AND HDR_no_zeroes.dt_last_seen >= all_dates[38]);
        unsigned8 date39 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[39] AND HDR_no_zeroes.dt_last_seen >= all_dates[39]);
        unsigned8 date40 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[40] AND HDR_no_zeroes.dt_last_seen >= all_dates[40]);
        unsigned8 date41 := count(GROUP, HDR_no_zeroes.dt_first_seen <= all_dates[41] AND HDR_no_zeroes.dt_last_seen >= all_dates[41]);
        // this variable length field must come last because the counts are conditional aggregates
        string src := HDR_no_zeroes.src;
    END;

    // Run a cross-tab report, grouped by src, to do the counting
    SHARED unsorted_seen_counts_per_src := TABLE(HDR_no_zeroes, unsorted_seen_counts_per_src_Rec, src);

    // Sort by src
    SHARED sorted_seen_counts_per_src := SORT(unsorted_seen_counts_per_src, src);
    
    // Convert all_dates to a single-record dataset for these counts
    // Can use the existing record because I provide values instead of using default values
    // which are the count function calls
    SHARED all_dates_single_record_for_seen := DATASET(
        [
            { 
                all_dates[1], all_dates[2], all_dates[3], all_dates[4], all_dates[5], all_dates[6], all_dates[7], all_dates[8], all_dates[9], all_dates[10],
                all_dates[11], all_dates[12], all_dates[13], all_dates[14], all_dates[15], all_dates[16], all_dates[17], all_dates[18], all_dates[19], all_dates[20],
                all_dates[21], all_dates[22], all_dates[23], all_dates[24], all_dates[25], all_dates[26], all_dates[27], all_dates[28], all_dates[29], all_dates[30],
                all_dates[31], all_dates[32], all_dates[33], all_dates[34], all_dates[35], all_dates[36], all_dates[37], all_dates[38], all_dates[39], all_dates[40],
                all_dates[41],
                'dates'
            }
        ], unsorted_seen_counts_per_src_Rec
    );

    // Export the seen counts per src.  Prepend the dates for readability
    EXPORT seen_counts_per_src := all_dates_single_record_for_seen & sorted_seen_counts_per_src;
    

    /////////////////////////////////////////////////////
    //  Calculates overall values (no src breakdown) for first/last seen
    /////////////////////////////////////////////////////

    // This is derived from the previous counts for efficiency

    // Use rollup to sum the date columns
    // This function adds all the date-based counts together
    SHARED unsorted_seen_counts_per_src_Rec combineSeenDateValues(
            unsorted_seen_counts_per_src_Rec leftRecord,
            unsorted_seen_counts_per_src_Rec rightRecord) := TRANSFORM

        SELF.date1 := leftRecord.date1 + rightRecord.date1;
        SELF.date2 := leftRecord.date2 + rightRecord.date2;
        SELF.date3 := leftRecord.date3 + rightRecord.date3;
        SELF.date4 := leftRecord.date4 + rightRecord.date4;
        SELF.date5 := leftRecord.date5 + rightRecord.date5;
        SELF.date6 := leftRecord.date6 + rightRecord.date6;
        SELF.date7 := leftRecord.date7 + rightRecord.date7;
        SELF.date8 := leftRecord.date8 + rightRecord.date8;
        SELF.date9 := leftRecord.date9 + rightRecord.date9;
        SELF.date10 := leftRecord.date10 + rightRecord.date10;
        SELF.date11 := leftRecord.date11 + rightRecord.date11;
        SELF.date12 := leftRecord.date12 + rightRecord.date12;
        SELF.date13 := leftRecord.date13 + rightRecord.date13;
        SELF.date14 := leftRecord.date14 + rightRecord.date14;
        SELF.date15 := leftRecord.date15 + rightRecord.date15;
        SELF.date16 := leftRecord.date16 + rightRecord.date16;
        SELF.date17 := leftRecord.date17 + rightRecord.date17;
        SELF.date18 := leftRecord.date18 + rightRecord.date18;
        SELF.date19 := leftRecord.date19 + rightRecord.date19;
        SELF.date20 := leftRecord.date20 + rightRecord.date20;
        SELF.date21 := leftRecord.date21 + rightRecord.date21;
        SELF.date22 := leftRecord.date22 + rightRecord.date22;
        SELF.date23 := leftRecord.date23 + rightRecord.date23;
        SELF.date24 := leftRecord.date24 + rightRecord.date24;
        SELF.date25 := leftRecord.date25 + rightRecord.date25;
        SELF.date26 := leftRecord.date26 + rightRecord.date26;
        SELF.date27 := leftRecord.date27 + rightRecord.date27;
        SELF.date28 := leftRecord.date28 + rightRecord.date28;
        SELF.date29 := leftRecord.date29 + rightRecord.date29;
        SELF.date30 := leftRecord.date30 + rightRecord.date30;
        SELF.date31 := leftRecord.date31 + rightRecord.date31;
        SELF.date32 := leftRecord.date32 + rightRecord.date32;
        SELF.date33 := leftRecord.date33 + rightRecord.date33;
        SELF.date34 := leftRecord.date34 + rightRecord.date34;
        SELF.date35 := leftRecord.date35 + rightRecord.date35;
        SELF.date36 := leftRecord.date36 + rightRecord.date36;
        SELF.date37 := leftRecord.date37 + rightRecord.date37;
        SELF.date38 := leftRecord.date38 + rightRecord.date38;
        SELF.date39 := leftRecord.date39 + rightRecord.date39;
        SELF.date40 := leftRecord.date40 + rightRecord.date40;
        SELF.date41 := leftRecord.date41 + rightRecord.date41;
        SELF.src := 'all_sources';
    END;

    // Use a rollup to combine all the records into a single, summed record.
    // Condition parameter is simply TRUE because all records need to be combined
    SHARED all_seen_only_counts := ROLLUP(sorted_seen_counts_per_src, TRUE, combineSeenDateValues(LEFT, RIGHT));

    // Prepend the results with the dates for readability
    EXPORT all_seen_counts := all_dates_single_record_for_seen & all_seen_only_counts;

    ////////////////////////////////////////////////////
    ////////////////////////////////////////////////////
    // The following is for first/last vendor reported
    ////////////////////////////////////////////////////
    ////////////////////////////////////////////////////

    // Get a count for each date per src.  This assumes the number of intervals is
    // today's date plus 40
    // but it does not assume what those interval dates are
    SHARED unsorted_vendor_reported_counts_per_src_Rec := RECORD
        // For a date#, it counts the number of rows where
        //  dt_vendor_first_reported <= a predetermined date
        //  AND dt_vendor_last_reported >= a predetermined date
        unsigned8 date1 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[1] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[1]);
        unsigned8 date2 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[2] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[2]);
        unsigned8 date3 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[3] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[3]);
        unsigned8 date4 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[4] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[4]);
        unsigned8 date5 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[5] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[5]);
        unsigned8 date6 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[6] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[6]);
        unsigned8 date7 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[7] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[7]);
        unsigned8 date8 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[8] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[8]);
        unsigned8 date9 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[9] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[9]);
        unsigned8 date10 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[10] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[10]);
        unsigned8 date11 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[11] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[11]);
        unsigned8 date12 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[12] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[12]);
        unsigned8 date13 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[13] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[13]);
        unsigned8 date14 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[14] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[14]);
        unsigned8 date15 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[15] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[15]);
        unsigned8 date16 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[16] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[16]);
        unsigned8 date17 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[17] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[17]);
        unsigned8 date18 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[18] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[18]);
        unsigned8 date19 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[19] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[19]);
        unsigned8 date20 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[20] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[20]);
        unsigned8 date21 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[21] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[21]);
        unsigned8 date22 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[22] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[22]);
        unsigned8 date23 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[23] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[23]);
        unsigned8 date24 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[24] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[24]);
        unsigned8 date25 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[25] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[25]);
        unsigned8 date26 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[26] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[26]);
        unsigned8 date27 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[27] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[27]);
        unsigned8 date28 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[28] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[28]);
        unsigned8 date29 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[29] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[29]);
        unsigned8 date30 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[30] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[30]);
        unsigned8 date31 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[31] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[31]);
        unsigned8 date32 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[32] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[32]);
        unsigned8 date33 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[33] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[33]);
        unsigned8 date34 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[34] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[34]);
        unsigned8 date35 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[35] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[35]);
        unsigned8 date36 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[36] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[36]);
        unsigned8 date37 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[37] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[37]);
        unsigned8 date38 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[38] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[38]);
        unsigned8 date39 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[39] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[39]);
        unsigned8 date40 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[40] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[40]);
        unsigned8 date41 := count(GROUP, HDR_no_zeroes.dt_vendor_first_reported <= all_dates[41] AND HDR_no_zeroes.dt_vendor_last_reported >= all_dates[41]);
        // this variable length field must come last because the counts are conditional aggregates
        string src := HDR_no_zeroes.src;
    END;

    // Run a cross-tab report, grouped by src, to do the counting
    SHARED unsorted_vendor_reported_counts_per_src := TABLE(HDR_no_zeroes, unsorted_vendor_reported_counts_per_src_Rec, src);

    // Sort by src
    SHARED sorted_vendor_reported_counts_per_src := SORT(unsorted_vendor_reported_counts_per_src, src);
    
    // Convert all_dates to a single-record dataset for these counts
    // Can use the existing record because I provide values instead of using default values
    // which are the count function calls
    SHARED all_dates_single_record_for_vendor_reported := DATASET(
        [
            { 
                all_dates[1], all_dates[2], all_dates[3], all_dates[4], all_dates[5], all_dates[6], all_dates[7], all_dates[8], all_dates[9], all_dates[10],
                all_dates[11], all_dates[12], all_dates[13], all_dates[14], all_dates[15], all_dates[16], all_dates[17], all_dates[18], all_dates[19], all_dates[20],
                all_dates[21], all_dates[22], all_dates[23], all_dates[24], all_dates[25], all_dates[26], all_dates[27], all_dates[28], all_dates[29], all_dates[30],
                all_dates[31], all_dates[32], all_dates[33], all_dates[34], all_dates[35], all_dates[36], all_dates[37], all_dates[38], all_dates[39], all_dates[40],
                all_dates[41],
                'dates'
            }
        ], unsorted_vendor_reported_counts_per_src_Rec
    );

    // Export the seen counts per src.  Prepend the dates record for readability
    EXPORT vendor_reported_counts_per_src := all_dates_single_record_for_vendor_reported & sorted_vendor_reported_counts_per_src;


    /////////////////////////////////////////////////////
    //  Calculates overall values (no src breakdown) for first/last vendor reported
    /////////////////////////////////////////////////////

    // This is derived from the previous counts for efficiency

    // Use rollup to sum the date columns
    // This function adds all the date-based counts together
    SHARED unsorted_vendor_reported_counts_per_src_Rec combineVendorReportedDateValues(
            unsorted_vendor_reported_counts_per_src_Rec leftRecord,
            unsorted_vendor_reported_counts_per_src_Rec rightRecord) := TRANSFORM

        SELF.date1 := leftRecord.date1 + rightRecord.date1;
        SELF.date2 := leftRecord.date2 + rightRecord.date2;
        SELF.date3 := leftRecord.date3 + rightRecord.date3;
        SELF.date4 := leftRecord.date4 + rightRecord.date4;
        SELF.date5 := leftRecord.date5 + rightRecord.date5;
        SELF.date6 := leftRecord.date6 + rightRecord.date6;
        SELF.date7 := leftRecord.date7 + rightRecord.date7;
        SELF.date8 := leftRecord.date8 + rightRecord.date8;
        SELF.date9 := leftRecord.date9 + rightRecord.date9;
        SELF.date10 := leftRecord.date10 + rightRecord.date10;
        SELF.date11 := leftRecord.date11 + rightRecord.date11;
        SELF.date12 := leftRecord.date12 + rightRecord.date12;
        SELF.date13 := leftRecord.date13 + rightRecord.date13;
        SELF.date14 := leftRecord.date14 + rightRecord.date14;
        SELF.date15 := leftRecord.date15 + rightRecord.date15;
        SELF.date16 := leftRecord.date16 + rightRecord.date16;
        SELF.date17 := leftRecord.date17 + rightRecord.date17;
        SELF.date18 := leftRecord.date18 + rightRecord.date18;
        SELF.date19 := leftRecord.date19 + rightRecord.date19;
        SELF.date20 := leftRecord.date20 + rightRecord.date20;
        SELF.date21 := leftRecord.date21 + rightRecord.date21;
        SELF.date22 := leftRecord.date22 + rightRecord.date22;
        SELF.date23 := leftRecord.date23 + rightRecord.date23;
        SELF.date24 := leftRecord.date24 + rightRecord.date24;
        SELF.date25 := leftRecord.date25 + rightRecord.date25;
        SELF.date26 := leftRecord.date26 + rightRecord.date26;
        SELF.date27 := leftRecord.date27 + rightRecord.date27;
        SELF.date28 := leftRecord.date28 + rightRecord.date28;
        SELF.date29 := leftRecord.date29 + rightRecord.date29;
        SELF.date30 := leftRecord.date30 + rightRecord.date30;
        SELF.date31 := leftRecord.date31 + rightRecord.date31;
        SELF.date32 := leftRecord.date32 + rightRecord.date32;
        SELF.date33 := leftRecord.date33 + rightRecord.date33;
        SELF.date34 := leftRecord.date34 + rightRecord.date34;
        SELF.date35 := leftRecord.date35 + rightRecord.date35;
        SELF.date36 := leftRecord.date36 + rightRecord.date36;
        SELF.date37 := leftRecord.date37 + rightRecord.date37;
        SELF.date38 := leftRecord.date38 + rightRecord.date38;
        SELF.date39 := leftRecord.date39 + rightRecord.date39;
        SELF.date40 := leftRecord.date40 + rightRecord.date40;
        SELF.date41 := leftRecord.date41 + rightRecord.date41;
        SELF.src := 'all_sources';
    END;

    // Use a rollup to combine all the records into a single, summed record.
    // Condition parameter is simply TRUE because all records need to be combined
    SHARED all_vendor_reported_only_counts := ROLLUP(sorted_vendor_reported_counts_per_src, TRUE, combineVendorReportedDateValues(LEFT, RIGHT));

    // Prepend the results with the dates for readability
    EXPORT all_vendor_reported_counts := all_dates_single_record_for_vendor_reported & all_vendor_reported_only_counts;

END;

// POTENTIAL FUTURE WORK
// - Analyze top 5 sources
// - Analyze most interesting sources 
