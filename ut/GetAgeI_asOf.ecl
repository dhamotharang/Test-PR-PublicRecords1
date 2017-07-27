/**
 * Returns Age for Dates in format of YYYYMMDD
 **/
EXPORT GetAgeI_asOf(UNSIGNED8 dob, UNSIGNED8 asOfDate) := ut.Age(dob,asOfDate):DEPRECATED('Use ut.Age Instead');   
