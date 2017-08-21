/*This function returns the number of milliseconds since 1900.  Since it depends on 
 *lib_date.DaysSince1900 it is accurate from 1900 through Feb 28, 2100.  This is due
 *to a shortcut in the leap year part of lib_date.DaysSince1900.  An INTEGER6 will 
 *store up to ~8900 years (10800 A.D.) so that should not be a limiting factor.
 *
 *INPUTS:
 *Year A.D. (1900-2099)
 *Month 1-12
 *Day 1-last_day_of_month
 *Hour 0-23
 *Minutes 0-59
 *Seconds 0-59
 *Milliseconds 0-999
 *
 *OUTPUT:
 *INTEGER6 representing milliseconds since 1 Jan 1900 00:00:00.000
 *
 *CAVEATS:
 *no bounds checking
 *lib_date.DaysSince1900 thinks 2100, 2200, etc. are leap years
*/

import lib_date;

export INTEGER6 milliseconds_since_1900(integer2 year, integer1 month, integer1 day, 
		integer1 hours, integer1 minutes, integer1 seconds, integer2 milliseconds) :=
  lib_date.DaysSince1900(year, month, day) * 86400000 + hours * 3600000 + minutes * 60000 + seconds * 1000 + milliseconds;