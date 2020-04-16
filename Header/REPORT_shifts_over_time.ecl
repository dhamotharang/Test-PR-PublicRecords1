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

    // This marks today's date on the graph
    SHARED todayDateNoDays := getPreviousDate(0);

    // record for the below datasets
    SHARED date_and_count_Rec := RECORD
        unsigned date;
        unsigned count_of_records_per_date;
    END; 

    ////////////////////////////////////////////////////
    // The following is for first/last seen
    ////////////////////////////////////////////////////

    // For first/last seen, calculates the number of records where 
    //      dt_first_seen <= a predetermined date
    //      AND dt_last_seen >= a predetermined date
    SHARED unsigned getCountOnDateForSeen(unsigned noDays) := FUNCTION
        count_of_records_per_date := count(HDR_no_zeroes(dt_first_seen <= noDays AND dt_last_seen >= noDays));
        return count_of_records_per_date; 
    END;

    // This dataset contains the date as one field and the count as another field
    SHARED seen_count_for_today := DATASET(
        [
            // Today's date and the count of records on today's date
            { todayDateNoDays, getCountOnDateForSeen(todayDateNoDays) }
        ], date_and_count_Rec
    );

    // This function takes a dataset with dates and counts as the first parameter
    // and a number representing a counter value as the second parameter
    // It returns the first dataset with an extra row added that represents the results
    // (date and count) for a new date
    SHARED addDateAndCountRecordForSeen(DATASET(date_and_count_Rec) existingRecords, unsigned counterValue) := FUNCTION
        // Gets a previous date based on the counter value provided as a parameter
        newRecordDate := getPreviousDate(counterValue); // example: counterValue = 4, returns 201904
        
        // Gets a record count based on the newRecordDate
        newRecordCount := getCountOnDateForSeen(newRecordDate); // example: newRecordDate = 201904, returns 12345

        // This is a dataset that adds a new date and a new count of records
        newRecord := DATASET([
            { newRecordDate, newRecordCount }
        ], date_and_count_Rec);

        // This combines newRecord and the existingRecords dataset in one dataset and returns it
        return existingRecords & newRecord;
    END;

    // I start with seen_count_for_today and iterate 40 times, from 1 to 40 inclusive
    // Each time, I add a new record
    // to the dataset that counts the number of records in 3 month intervals.
    // For example, counter value of 1 counts the number of records 3 months ago
    // For example, counter value of 2 counts the number of records 6 months ago, etc.
    // ROWS(LEFT) = the dataset that is being grown over time
    // COUNTER = the iteration number, 1, 2, 3, etc.
    SHARED unsorted_all_seen_counts := LOOP(seen_count_for_today, 40, addDateAndCountRecordForSeen(ROWS(LEFT), COUNTER));

    // sort by date
    EXPORT all_seen_counts := sort(unsorted_all_seen_counts, date);

    ////////////////////////////////////////////////////
    // The following is for first/last vendor reported
    ////////////////////////////////////////////////////

    // For first/last vendor reported, calculates the number of records where 
    //      dt_vendor_first_reported <= a predetermined date
    //      AND dt_vendor_last_reported >= a predetermined date
    SHARED unsigned getCountOnDateForVendorReported(unsigned noDays) := FUNCTION
        count_of_records_per_date := count(HDR_no_zeroes(dt_vendor_first_reported <= noDays AND dt_vendor_last_reported >= noDays));
        return count_of_records_per_date; 
    END;

    // This dataset contains the date as one field and the count as another field
    SHARED vendor_reported_count_for_today := DATASET(
        [
            // Today's date and the count of records on today's date
            { todayDateNoDays, getCountOnDateForVendorReported(todayDateNoDays) }
        ], date_and_count_Rec
    );

    // This function takes a dataset with dates and counts as the first parameter
    // and a number representing a counter value as the second parameter
    // It returns the first dataset with an extra row added that represents the results
    // (date and count) for a new date
    SHARED addDateAndCountRecordForVendorReported(DATASET(date_and_count_Rec) existingRecords, unsigned counterValue) := FUNCTION
        // Gets a previous date based on the counter value provided as a parameter
        newRecordDate := getPreviousDate(counterValue); // example: counterValue = 4, returns 201904
        
        // Gets a record count based on the newRecordDate
        newRecordCount := getCountOnDateForVendorReported(newRecordDate); // example: newRecordDate = 201904, returns 12345

        // This is a dataset that adds a new date and a new count of records
        newRecord := DATASET([
            { newRecordDate, newRecordCount }
        ], date_and_count_Rec);

        // This combines newRecord and the existingRecords dataset in one dataset and returns it
        return existingRecords & newRecord;
    END;

    // I start with vendor_reported_count_for_today and iterate 40 times, from 1 to 40 inclusive
    // Each time, I add a new record
    // to the dataset that counts the number of records in 3 month intervals.
    // For example, counter value of 1 counts the number of records 3 months ago
    // For example, counter value of 2 counts the number of records 6 months ago, etc.
    // ROWS(LEFT) = the dataset that is being grown over time
    // COUNTER = the iteration number, 1, 2, 3, etc.
    SHARED unsorted_all_vendor_reported_counts := LOOP(vendor_reported_count_for_today, 40, addDateAndCountRecordForVendorReported(ROWS(LEFT), COUNTER));

    // sort by date
    EXPORT all_vendor_reported_counts := sort(unsorted_all_vendor_reported_counts, date);



END;