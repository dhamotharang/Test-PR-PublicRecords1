IMPORT $;

//Used this index method to carry the maxlength.
dsAMOUNTPAID := DATASET([], $.Layouts.AMOUNTPAID);
EXPORT Key_AMOUNTPAID := INDEX(dsAMOUNTPAID,
                             {$.Layouts.AMOUNTPAID_KEYED}, 
                             {$.Layouts.AMOUNTPAID_PAYLOAD},
                             $.Names.i_AMOUNTPAID_SF
                             );
