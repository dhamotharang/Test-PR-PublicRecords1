/**
 * Tests whether the year is a leap year in the Gregorian calendar.
 *
 * @param year          The year (0-9999).
 * @return              True if the year is a leap year.
 */
IMPORT STD; 
EXPORT LeapYear(INTEGER2 year) := Std.Date.IsLeapYear(year) :DEPRECATED('Use Std.Date.IsLeapYear Instead') ;