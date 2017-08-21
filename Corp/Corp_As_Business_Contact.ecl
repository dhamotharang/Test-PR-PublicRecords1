#OPTION('multiplePersistInstances',FALSE);
export Corp_As_Business_Contact := fCorp_As_Business_Contact(File_Corp_Base(Filters.As_Business.Corp_Base), File_Corp_Cont_Base(Filters.As_Business.Corp_Cont))
                 : persist(Thor_cluster + 'persist::Corp::Corp_As_Business_Contact');