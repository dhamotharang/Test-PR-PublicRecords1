/**
 * Returns Age for Dates in format of YYYYMMDD
 **/
EXPORT getage(STRING8 dob) := ut.Age((UNSIGNED)dob) :DEPRECATED('Use ut.Age Instead'); 