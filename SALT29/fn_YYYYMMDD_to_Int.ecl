// This does leave some 'holes' that do not really exist - but that is fine for our purposes
// The numbers are monotonically increasing - and without huge gaps
export fn_YYYYMMDD_to_Int(UNSIGNED4 yyyymmdd) :=  (UNSIGNED3)((yyyymmdd DIV 10000 * 12 + (yyyymmdd DIV 100) % 100) * 31 + yyyymmdd % 100 - 1);
