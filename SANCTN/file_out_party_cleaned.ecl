import SANCTN,ut;

 export file_out_party_cleaned := dataset(SANCTN.cluster + 'out::sanctn::party_cleaned'
                                        ,SANCTN.layout_SANCTN_party_clean
								        ,thor);
												
