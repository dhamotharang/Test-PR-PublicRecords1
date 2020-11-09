IMPORT Business_Credit, BusinessCredit_Services, STD;

/* 
See RABS-226 for more details
   As of October 1, 2020, SBFE is changing the definition of the past_due_aging_amount_bucket_# buckets (1-7) 
   This module will convert the fields from payments past due into days past due.
Scoring is using the following payment frequency definitions for the nonstandard payment frequencies.
   Business Services is coding using the same definitions:
   In short, this is how things would look:
   Payment interval = 'S'       : 90 days
   Payment interval = 'SF'      : 90 days
   Payment interval = 'IL'      : 30 days
   Payment interval = 'IM'      : 30 days
   Note: if we receive a payment interval that is ‘’ (blank), we assume it to be monthly as well, as of today (8/21/2020). 
SBFE Payment Frequency Values with associated days:
  A = Annually (365)                   M = Monthly	(30)          BW = Bi-Weekly(14)        
  SA = Semiannually (182)              'blank' (30)               W  = Weekly (7)
  Q  = Quarterly	 (90)	               SM = Semi-Monthly	(30)    D  = Daily (1)   	
  S  = Seasonal-Non-Agricultural (90)  IL = Irregular - less often than monthly (30)
  SF = Seasonal - Agricultural (90)    IM = Irregular - more often than monthly (30)
  BM = Bi-Monthly	(60)     	                                      SP = Single Payment (1)
*/

EXPORT convertPastDueAmounts() :=
  MODULE
    
    // since there are so many numbers, I'm choosing for readability to not create any constants.
    // NOTE: Since monthly is by far the most used interval, leaving the check for those variations up front  
    //       so we can immediately jump out of the map for approx 97% of the cases.
    SHARED getPymtInterval (STRING pmtInt) :=
    FUNCTION
      pmtIntUC := STD.str.ToUpperCase(pmtInt);
      RETURN
      MAP(pmtIntUC = 'M' OR  // monthly
          pmtIntUC = '' OR   // blank has been defined by product as monthly as well as the next two
          pmtIntUC = 'IM' OR // Irregular - more often than monthly
          pmtIntUC = 'IL' OR // Irregular - less often than monthly 
          pmtIntUC = 'SP'    // Single Payment - Scoring handles SP as a monthly payment
            => 30,
          pmtIntUC = 'A'     // annual
            => 365,
          pmtIntUC = 'SA'    // semi-annual
            => 182,
          pmtIntUC = 'Q' OR  // quartly
          pmtIntUC = 'S' OR  // Seasonal-Non-Agricultural 
          pmtIntUC = 'SF'    // Seasonal - Agricultural 
            => 90,
          pmtIntUC = 'BM'   //  Bi-Monthly 
            => 60,
          pmtIntUC = 'SM'   // Semi-Monthly 
            => 15,
          pmtIntUC = 'BW'   // Bi-Weekly
            => 14,
          pmtIntUC = 'W'    // Weekly
            => 7,
          pmtIntUC = 'D'    // Daily
            => 1,         
               30);   // making the default = 30 for cases where the payment interval is either new and not coded 
                      // for, blank or it's an unknown/fat fingered code. Buckets in these instances will remain as input.
    END;
    
    SHARED getHighestDaysBucket(UNSIGNED daysDelinquentIn) := 
      IF(daysDelinquentIn % 30 = 0,
         daysDelinquentIn DIV 30,
         (daysDelinquentIn DIV 30) + 1 );

    SHARED gethighestPaymentBucket(UNSIGNED daysDelinquentIn, UNSIGNED pmtIntDaysIn) := 
      IF(daysDelinquentIn %  pmtIntDaysIn = 0,
         daysDelinquentIn DIV pmtIntDaysIn,
         (daysDelinquentIn DIV pmtIntDaysIn) + 1);
         
    // IntervalDaysDelinquent calculates the number of days past due within each bucket
    // for example: BiMonthly, if the result is 3, then each of the new "paymentIntervals" is considered three days overdue. 
    // A bi-monthly payment interval the first bucket coming in would be considered 3 days late and would convert into 
    // bucket 1 (1-30) days late.  For the second bucket, this would be 63 days late and would convert inot bucket 3 (61-90)
    // days late, etc.
    // Think if this value as the pivotal point for determining which "days" past due bucket to use when a 
    // payment interval does NOT end with the with the monthly number (ie: 30, 60, 90...)
    // NOTE: For payment intervals less than 30, the following calculation is only used when the 
    // account is 30 or more days old.  Otherwise the highestDaysBucket is 1 and this calculation is 
    // not needed. (it's not accurate either)
    // For BiWeekly (14 day interval) and Weekly (7 day interval), a decision was made by product to consider 
    // four weeks a "month". Knowing and accepting the conversion would not be 100% accurate. 
    // BiWeekly - the first two buckets convert to bucket 1 (1-30 days)
    SHARED getIntervalDaysDelinquent(UNSIGNED dayDel, UNSIGNED HiPmtBuck, UNSIGNED pmtIntDays) := dayDel - ((HiPmtBuck - 1) * pmtIntDays);
       
    
    EXPORT checkConversionNeeded (RECORDOF(Business_Credit.key_tradeline()) rw_in, STRING LayoutChangeDate) := 
      getPymtInterval (rw_in.payment_interval) != 30 AND
      (UNSIGNED)rw_in.process_date >= (UNSIGNED)LayoutChangeDate AND
      (TRIM(rw_in.Past_Due_Aging_Amount_Bucket_1, LEFT, RIGHT) != '' OR   // If any bucket has even a zero, all buckets need to
       TRIM(rw_in.Past_Due_Aging_Amount_Bucket_2, LEFT, RIGHT) != '' OR   // be converted. Only all blank buckets are not converted (unless the previous two conditions apply)
       TRIM(rw_in.Past_Due_Aging_Amount_Bucket_3, LEFT, RIGHT) != '' OR   // (unless either of the previous two conditions are FALSE)
       TRIM(rw_in.Past_Due_Aging_Amount_Bucket_4, LEFT, RIGHT) != '' OR 
       TRIM(rw_in.Past_Due_Aging_Amount_Bucket_5, LEFT, RIGHT) != '' OR 
       TRIM(rw_in.Past_Due_Aging_Amount_Bucket_6, LEFT, RIGHT) != '' OR 
       TRIM(rw_in.Past_Due_Aging_Amount_Bucket_7, LEFT, RIGHT) != ''    );
    
    EXPORT convertBucket1(RECORDOF(Business_Credit.key_tradeline()) rw_in) := FUNCTION
      daysDelinquent := (UNSIGNED) rw_in.DBT_V5;
      highestDaysBucket := getHighestDaysBucket(daysDelinquent);        
      pmtIntervalDays := getPymtInterval(rw_in.payment_interval);
      highestPaymentBucket := gethighestPaymentBucket(daysDelinquent,pmtIntervalDays);
      IntervalDaysDelinquent := getIntervalDaysDelinquent(daysDelinquent,highestPaymentBucket,pmtIntervalDays);

      RETURN MAP(pmtIntervalDays >= 60 AND 
                 (highestDaysBucket = 1 OR
                  IntervalDaysDelinquent <= 30)  
                   => rw_in.Past_Due_Aging_Amount_Bucket_1,
                 pmtIntervalDays = 15 OR
                 pmtIntervalDays = 14
                   => IF((TRIM(rw_in.Past_Due_Aging_Amount_Bucket_1, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_2, LEFT, RIGHT) = ''),
                         '',
                         (STRING12)((INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_1 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_2)),
                 pmtIntervalDays = 7
                   => IF((TRIM(rw_in.Past_Due_Aging_Amount_Bucket_1, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_2, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_3, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_4, LEFT, RIGHT) = '' ),
                         '',
                         (STRING12)((INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_1 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_2 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_3 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_4)),
                 pmtIntervalDays = 1 AND
                 highestDaysBucket  > 1 
                   => IF((TRIM(rw_in.Past_Due_Aging_Amount_Bucket_1, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_2, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_3, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_4, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_5, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_6, LEFT, RIGHT) = '' ),
                         '',        
                         (STRING12)((INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_1 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_2 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_3 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_4 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_5 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_6)),
                 pmtIntervalDays = 1 AND
                 highestDaysBucket = 1
                   => IF((TRIM(rw_in.Past_Due_Aging_Amount_Bucket_1, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_2, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_3, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_4, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_5, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_6, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_7, LEFT, RIGHT) = '' ),
                         '',
                         (STRING12)((INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_1 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_2 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_3 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_4 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_5 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_6 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_7)),
                        '' 
                );
          END; 

    EXPORT convertBucket2(RECORDOF(Business_Credit.key_tradeline()) rw_in) := FUNCTION
      daysDelinquent := (UNSIGNED) rw_in.DBT_V5;
      highestDaysBucket := getHighestDaysBucket(daysDelinquent);        
      pmtIntervalDays := getPymtInterval (rw_in.payment_interval);
      highestPaymentBucket := gethighestPaymentBucket(daysDelinquent,pmtIntervalDays);
      IntervalDaysDelinquent := getIntervalDaysDelinquent(daysDelinquent,highestPaymentBucket,pmtIntervalDays);

      RETURN MAP(pmtIntervalDays >= 60 AND 
                 (highestDaysBucket = 2 OR
                  (IntervalDaysDelinquent > 30 AND
                   IntervalDaysDelinquent <= 60)) 
                   => rw_in.Past_Due_Aging_Amount_Bucket_1,
                 pmtIntervalDays = 15 OR
                 pmtIntervalDays = 14
                   => IF((TRIM(rw_in.Past_Due_Aging_Amount_Bucket_3, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_4, LEFT, RIGHT) = '' ),
                         '',
                         (STRING12)((INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_3 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_4)),
                 pmtIntervalDays = 7  AND daysDelinquent < 61
                   => IF((TRIM(rw_in.Past_Due_Aging_Amount_Bucket_5, LEFT, RIGHT) = '' AND 
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_6, LEFT, RIGHT) = '' AND 
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_7, LEFT, RIGHT) = '' ), 
                         '',       
                         (STRING12)((INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_5 + 
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_6 + 
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_7)), 
                 pmtIntervalDays = 7 
                   => IF((TRIM(rw_in.Past_Due_Aging_Amount_Bucket_5, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_6, LEFT, RIGHT) = '' ),
                          '',       
                          (STRING12)((INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_5 +
                                     (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_6)),
                 pmtIntervalDays = 1 AND
                 daysDelinquent > 30 AND
                 daysDelinquent <= 60
                   => rw_in.Past_Due_Aging_Amount_Bucket_7,
                      ''
                );
      END;

    EXPORT convertBucket3(RECORDOF(Business_Credit.key_tradeline()) rw_in) := FUNCTION
      daysDelinquent := (UNSIGNED) rw_in.DBT_V5;
      highestDaysBucket := getHighestDaysBucket(daysDelinquent);
      pmtIntervalDays := getPymtInterval (rw_in.payment_interval);
      highestPaymentBucket := gethighestPaymentBucket(daysDelinquent,pmtIntervalDays);
      // get the "original" number of days late (for when an account is more than one year old)
      yrOneDaysLate := daysDelinquent % 365;
      IntervalDaysDelinquent := getIntervalDaysDelinquent(daysDelinquent,highestPaymentBucket,pmtIntervalDays);
      RETURN MAP(pmtIntervalDays > 60 AND 
                 (highestDaysBucket = 3 OR
                  (IntervalDaysDelinquent > 60 AND
                   IntervalDaysDelinquent <= 90)) 
                   => rw_in.Past_Due_Aging_Amount_Bucket_1,
                 pmtIntervalDays = 60 AND 
                 IntervalDaysDelinquent <= 30 
                   => rw_in.Past_Due_Aging_Amount_Bucket_2,
                 pmtIntervalDays = 14 AND
                 daysDelinquent > 84 AND
                 daysDelinquent <= 90
                   => IF((TRIM(rw_in.Past_Due_Aging_Amount_Bucket_5, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_6, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_7, LEFT, RIGHT) = '' ),
                         '',       
                         (STRING12)((INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_5 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_6 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_7)),
                 pmtIntervalDays = 15 OR
                 pmtIntervalDays = 14 
                   => IF((TRIM(rw_in.Past_Due_Aging_Amount_Bucket_5, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_6, LEFT, RIGHT) = '' ),
                          '',       
                          (STRING12)((INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_5 +
                                     (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_6)),
                 (pmtIntervalDays = 7 OR
                  pmtIntervalDays = 1) AND
                 highestDaysBucket = 3
                   => rw_in.Past_Due_Aging_Amount_Bucket_7,
                        ''
                );
      END;

    EXPORT convertBucket4(RECORDOF(Business_Credit.key_tradeline()) rw_in) := FUNCTION
      daysDelinquent := (UNSIGNED) rw_in.DBT_V5;
      highestDaysBucket := getHighestDaysBucket(daysDelinquent);
      pmtIntervalDays := getPymtInterval (rw_in.payment_interval);
      highestPaymentBucket := gethighestPaymentBucket(daysDelinquent,pmtIntervalDays);
      IntervalDaysDelinquent := getIntervalDaysDelinquent(daysDelinquent,highestPaymentBucket,pmtIntervalDays);
      RETURN MAP(pmtIntervalDays > 90 AND 
                 (highestDaysBucket = 4 OR
                  (IntervalDaysDelinquent > 90 AND
                   IntervalDaysDelinquent <= 120)) 
                   => rw_in.Past_Due_Aging_Amount_Bucket_1,
                 (pmtIntervalDays = 90 AND 
                  IntervalDaysDelinquent <= 30) OR
                 (pmtIntervalDays = 60 AND 
                  IntervalDaysDelinquent > 30)
                   => rw_in.Past_Due_Aging_Amount_Bucket_2,
                 // The following check is for an error condition in the SBFE data.  
                 // Where bucket 7 is populated in the input, but shouldn't be because
                 // the daysDelinquent is less than the definition for payment interval 
                 // /bucket seven.
                 (pmtIntervalDays = 14 AND
                  daysDelinquent < 85) OR
                 (pmtIntervalDays = 15 AND
                  daysDelinquent < 91)
                   => rw_in.Past_Due_Aging_Amount_Bucket_7, 
                 (pmtIntervalDays = 15 OR
                  pmtIntervalDays = 14 OR
                  pmtIntervalDays = 7 OR
                  pmtIntervalDays = 1) AND
                 highestDaysBucket = 4
                   =>  rw_in.Past_Due_Aging_Amount_Bucket_7,
                        ''
                );
      END;

    EXPORT convertBucket5(RECORDOF(Business_Credit.key_tradeline()) rw_in) := FUNCTION
      daysDelinquent := (UNSIGNED) rw_in.DBT_V5;
      highestDaysBucket := getHighestDaysBucket(daysDelinquent);
      pmtIntervalDays := getPymtInterval (rw_in.payment_interval);
      highestPaymentBucket := gethighestPaymentBucket(daysDelinquent,pmtIntervalDays);
      // get the "original" number of days late (for when an account is more than one year old)
      yrOneDaysLate := daysDelinquent % 365;
      IntervalDaysDelinquent := getIntervalDaysDelinquent(daysDelinquent,highestPaymentBucket,pmtIntervalDays);
      RETURN MAP((
                  pmtIntervalDays > 182 AND 
                  highestDaysBucket = 5 
                  ) OR
                 (
                  pmtIntervalDays = 182 AND 
                 ((yrOneDaysLate > 120 AND
                   yrOneDaysLate <= 150) OR
                  (yrOneDaysLate > 182 AND
                   IntervalDaysDelinquent > 120 AND
                   IntervalDaysDelinquent <= 150))
                 )
                  => rw_in.Past_Due_Aging_Amount_Bucket_1,
                 pmtIntervalDays = 90 AND
                 IntervalDaysDelinquent > 30 AND
                 IntervalDaysDelinquent <= 60
                   => rw_in.Past_Due_Aging_Amount_Bucket_2,
                 pmtIntervalDays = 60 AND 
                 IntervalDaysDelinquent <= 30 
                   => rw_in.Past_Due_Aging_Amount_Bucket_3,
                 (pmtIntervalDays = 15 OR
                  pmtIntervalDays = 14 OR
                  pmtIntervalDays = 7 OR
                  pmtIntervalDays = 1) AND
                 highestDaysBucket = 5
                    =>  rw_in.Past_Due_Aging_Amount_Bucket_7,
                        ''
                );
      END;

    EXPORT convertBucket6(RECORDOF(Business_Credit.key_tradeline()) rw_in) := FUNCTION
      daysDelinquent := (UNSIGNED) rw_in.DBT_V5;
      highestDaysBucket := getHighestDaysBucket(daysDelinquent);
      pmtIntervalDays := getPymtInterval (rw_in.payment_interval);
      highestPaymentBucket := gethighestPaymentBucket(daysDelinquent,pmtIntervalDays);
      IntervalDaysDelinquent := getIntervalDaysDelinquent(daysDelinquent,highestPaymentBucket,pmtIntervalDays);
      RETURN MAP((
                  pmtIntervalDays = 365 AND 
                  (highestDaysBucket = 6 OR
                   (daysDelinquent > 365 AND
                    IntervalDaysDelinquent > 150 AND
                    IntervalDaysDelinquent <= 180))
                 ) OR
                ( 
                  pmtIntervalDays = 182 AND
                  IntervalDaysDelinquent > 150 AND  // remaining days in pmt bucket 1 that falls in days bucket 6
                  IntervalDaysDelinquent < 181 
                )
                   => rw_in.Past_Due_Aging_Amount_Bucket_1,
                  pmtIntervalDays = 90 AND
                 ((daysDelinquent > 150 AND
                  daysDelinquent <= 180) OR
                 (IntervalDaysDelinquent > 60 AND
                  IntervalDaysDelinquent <= 90))
                   => rw_in.Past_Due_Aging_Amount_Bucket_2,
                 pmtIntervalDays = 60 AND 
                 IntervalDaysDelinquent > 30 
                   => rw_in.Past_Due_Aging_Amount_Bucket_3,
                 (pmtIntervalDays = 15 OR
                  pmtIntervalDays = 14 OR
                  pmtIntervalDays = 7 OR
                  pmtIntervalDays = 1) AND
                 highestDaysBucket = 6
                   =>  rw_in.Past_Due_Aging_Amount_Bucket_7,
                       ''
                );
      END;

    EXPORT convertBucket7(RECORDOF(Business_Credit.key_tradeline()) rw_in) := FUNCTION
      daysDelinquent := (UNSIGNED) rw_in.DBT_V5;
      highestDaysBucket := getHighestDaysBucket(daysDelinquent);
      pmtIntervalDays := getPymtInterval (rw_in.payment_interval);
      highestPaymentBucket := gethighestPaymentBucket(daysDelinquent,pmtIntervalDays);
      IntervalDaysDelinquent := getIntervalDaysDelinquent(daysDelinquent,highestPaymentBucket,pmtIntervalDays);
      RETURN MAP(pmtIntervalDays = 365 AND 
                 ((daysDelinquent > 180 AND
                   daysDelinquent <= 365) OR
                  (daysDelinquent > 365 AND
                   IntervalDaysDelinquent > 180))
                   => IF((TRIM(rw_in.Past_Due_Aging_Amount_Bucket_1, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_2, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_3, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_4, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_5, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_6, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_7, LEFT, RIGHT) = '' ),
                         '',
                         (STRING12)((INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_1 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_2 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_3 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_4 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_5 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_6 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_7)),
                 pmtIntervalDays = 365
                   => IF((TRIM(rw_in.Past_Due_Aging_Amount_Bucket_2, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_3, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_4, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_5, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_6, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_7, LEFT, RIGHT) = '' ),
                         '',
                         (STRING12)((INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_2 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_3 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_4 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_5 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_6 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_7)),
                 pmtIntervalDays = 182 AND
                 IntervalDaysDelinquent > 180 
                   => IF((TRIM(rw_in.Past_Due_Aging_Amount_Bucket_1, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_2, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_3, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_4, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_5, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_6, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_7, LEFT, RIGHT) = '' ),
                         '',
                         (STRING12)((INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_1 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_2 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_3 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_4 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_5 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_6 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_7)),
                 pmtIntervalDays = 182 AND
                 IntervalDaysDelinquent <= 180
                   => IF((TRIM(rw_in.Past_Due_Aging_Amount_Bucket_2, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_3, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_4, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_5, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_6, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_7, LEFT, RIGHT) = '' ),
                         '',
                         (STRING12)((INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_2 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_3 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_4 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_5 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_6 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_7)),
                 pmtIntervalDays = 90 
                   => IF((TRIM(rw_in.Past_Due_Aging_Amount_Bucket_3, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_4, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_5, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_6, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_7, LEFT, RIGHT) = '' ),
                         '',
                         (STRING12)((INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_3 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_4 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_5 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_6 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_7)),
                 pmtIntervalDays = 60
                   => IF((TRIM(rw_in.Past_Due_Aging_Amount_Bucket_4, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_5, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_6, LEFT, RIGHT) = '' AND
                          TRIM(rw_in.Past_Due_Aging_Amount_Bucket_7, LEFT, RIGHT) = '' ),
                         '',
                         (STRING12)((INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_4 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_5 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_6 +
                                    (INTEGER)rw_in.Past_Due_Aging_Amount_Bucket_7)),
                 (pmtIntervalDays = 15 OR
                  pmtIntervalDays = 14 OR
                  pmtIntervalDays = 7  OR
                  pmtIntervalDays = 1) AND
                 highestDaysBucket > 6 
                   =>  rw_in.Past_Due_Aging_Amount_Bucket_7,
                      ''
                );
      END;
  END;
          
        

    



