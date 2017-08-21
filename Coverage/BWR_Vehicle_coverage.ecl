// Background:

// We receive vehicle data from Experian and DMV each month.  While the data is for a given month, it
// often contains some records (stragglers) with dates outside the load designated month.  So, a file
// for the month of June would often contain some records with dates outside of June or even outside
// of the load year.  This condition causes noise when trying to determine coverage.

// How it works:

// This report attempts to look at a state and source individually and determine in
// what year and month the existing data shows a concentration of records to reasonably demark the
// beginning and ending coverage dates.  That is, it is not an exact determination as it is subjective
// and in order to achieve greater precision, rules for each state and source would have to be drawn.
// It is the best reasonable approximation.  Furthermore, since averages are employed in order to
// determine a reasonable start and end date, beginning coverage dates may vary year over year.

// How it determines which year and month demarks the beginning coverage for that state and that source:

// Using the record count per month, it looks for the first 6 consecutive months that have a record
// count ratio of that month to the average of that year as greater or equals a month threshold of .25
// in a year where the total count of records for each of the subsequent 8 years have not dropped
// or climbed by more than 100% year over year.

// How it determines which year and month demarks the ending coverage for that state and that source:

// Using the record count per month, it looks for the last month that has a record
// count ratio of that month to the average of that year as greater or equals a month threshold of .25.

rerun:=true;
debug:=true;

Coverage.MAC_veh_coverage(
						rerun		// if true, it uses persisted files created in previous run
						,debug		// if true, it creates persisted files for each step for debuging
						,best_cov_rep
						,r2			// report for aid in debuging
						,r3			// report for aid in debuging
						);
output(best_cov_rep);