/**
 * Tests whether a date is valid, both by range-checking the year and by
 * validating each of the other individual components.
 **/
IMPORT STD;
EXPORT ValidDate (STRING8 InDate) := STD.DATE.IsValidDate((UNSIGNED4) InDate) :DEPRECATED('Use STD.DATE.IsValidDate Instead'); 