IMPORT $;

//Used this index method to carry the maxlength.
dsBANKACCOUNT := DATASET([], $.Layouts.BANKACCOUNT);
EXPORT Key_BANKACCOUNT := INDEX(dsBANKACCOUNT,
                             {$.Layouts.BANKACCOUNT_KEYED}, 
                             {$.Layouts.BANKACCOUNT_PAYLOAD},
                             $.Names.i_BANKACCOUNT_SF
                             );