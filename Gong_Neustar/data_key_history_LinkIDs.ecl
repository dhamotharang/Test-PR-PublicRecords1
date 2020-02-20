IMPORT dx_Gong, BIPV2;

  Base := $.File_History_Full_Prepped_for_Keys;

  BIPV2.IDmacros.xf_xLinkIDsToKeyIDs(Base, BasePlusIds);

EXPORT data_key_history_LinkIds := PROJECT(BasePlusIds(UltID > 0), dx_Gong.key_history_LinkIds.key_rec);