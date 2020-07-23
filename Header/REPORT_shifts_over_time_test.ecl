import STD;
import $.REPORT_shifts_over_time as r; 

EXPORT REPORT_shifts_over_time_test() := FUNCTION

    seq := sequential(
        output(r.count_per_dt_first_seen, ALL, named('count_per_dt_first_seen')),

        output(r.count_per_dt_seen_last, ALL, named('count_per_dt_seen_last')),

        output(r.count_per_dt_vendor_first, ALL, named('count_per_dt_vendor_first')),

        output(r.count_per_dt_vendor_last, ALL, named('count_per_dt_vendor_last')),

        output(r.seen_counts_per_src, ALL, named('seen_counts_per_src')),

        output(r.all_seen_counts, ALL, named('all_seen_counts')),

        output(r.vendor_reported_counts_per_src, ALL, named('vendor_reported_counts_per_src')),

        output(r.all_vendor_reported_counts, ALL, named('all_vendor_reported_counts'))
    )
     : success(STD.System.Email.SendEmail(
            'veronica.aldous@lexisnexisrisk.com,gabriel.marcan@lexisnexisrisk.com',
            'REPORT_shifts_over_time success',
            'this build was a success ' + WORKUNIT)), // adds workunit here instead of success text
          failure(STD.System.Email.SendEmail(
            'veronica.aldous@lexisnexisrisk.com,gabriel.marcan@lexisnexisrisk.com',
            'REPORT_shifts_over_time failure',
            'this build fails ' + WORKUNIT)); // adds workunit here instead of failure text


         

    return seq;

END; 