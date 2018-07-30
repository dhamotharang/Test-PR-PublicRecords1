IMPORT PRTE2_Liens_Ins;

FilesMain := PRTE2_Liens_Ins.Files;


EXPORT Files := MODULE

			// Just used this waiting for code migration of new layout, not checking in Layouts_Old, sandbox only.
			EXPORT Main_IN_DS_Prod_OLD			:= DATASET(FilesMain.Main_IN_Name_Prod, Layouts_OLD.BaseMain_in_raw, THOR);
			EXPORT Party_IN_DS_Prod_OLD			:= DATASET(FilesMain.Party_IN_Name_Prod, Layouts_OLD.BaseParty_in, THOR);
			EXPORT Main_DS_Prod_OLD					:= DATASET(FilesMain.Main_Name_Prod, Layouts_OLD.Boca_main_base, THOR);
			EXPORT Party_Base_DS_Prod_OLD		:= DATASET(FilesMain.Party_Name_Prod, Layouts_OLD.Boca_party_base, THOR);


END;