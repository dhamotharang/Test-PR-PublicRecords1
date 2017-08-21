import doxie, Prte2_Business_Header;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
f := Prte2_Business_Header.FEIN_Table;
#ELSE
f := Business_Risk.FEIN_Table;
#END;

export key_fein_table := index(f,{fein},{f},'~thor_data400::key::fein_table_'+doxie.Version_SuperKey);

