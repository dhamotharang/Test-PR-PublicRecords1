IMPORT $;

//Used this index method to carry the maxlength.
dsNPI := DATASET([], $.Layouts.NPI);
EXPORT KEY_NPI := INDEX(dsNPI,
                        {$.Layouts.NPI_KEYED}, 
                        {$.Layouts.NPI_PAYLOAD},
                        $.Names.i_NPI_SF
                        );