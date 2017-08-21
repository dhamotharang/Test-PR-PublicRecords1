#OPTION('multiplePersistInstances',FALSE);
IMPORT business_headerV2, ut;

EXPORT As_Business_Linking := Workers_Compensation.fAs_Business_Linking(DATASET(_Dataset().thor_cluster_files + 'base::' + _Dataset().name + '_keybuild::built',
                                                                        Workers_Compensation.layouts.Keybuild, THOR))
      : PERSIST(Persistnames.AsBusinessLinking);
