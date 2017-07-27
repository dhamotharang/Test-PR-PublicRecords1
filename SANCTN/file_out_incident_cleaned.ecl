import SANCTN;

export file_out_incident_cleaned := dataset(SANCTN.cluster + 'out::sanctn::incident_cleaned'
                                           ,SANCTN.layout_SANCTN_incident_clean
								           ,thor);