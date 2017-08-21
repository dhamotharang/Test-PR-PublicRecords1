//* Files - Foreclosure Files;
EXPORT Files := MODULE
IMPORT PRTE2;
EXPORT Foreclosure_Scrambled  := '~prte::ct::foreclosure::csv::scrambled';
EXPORT Foreclosure_Scrambled_DS  := DATASET(Foreclosure_Scrambled,
											prte2.layouts.foreclosure_batch_in,CSV(HEADING(1),QUOTE('"'),MAXLENGTH(32768)));



END;