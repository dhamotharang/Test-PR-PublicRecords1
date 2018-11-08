/**
* WordBagsEqual returns TRUE if consecutive corresponding words in wb1 and wb2 are 
* the same; numeric expanssions are ignored
* wb1 and wb2 MUST be in form nnnn WORD nn WORD nn
*/
EXPORT BOOLEAN WordBagsEqual(StrType wb1, StrType wb2) := 
#IF (UnicodeCfg.UseUnicode)
			Fn_WordBagsEqual_Uni(wb1,wb2);
#ELSE
			Fn_WordBagsEqual_Str(wb1,wb2);
#END