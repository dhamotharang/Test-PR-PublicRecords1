import ut, Drivers;

export File_DL_TX_Update2 :=	dataset(Drivers.Cluster + 'in::drvlic_tx_update2',	DriversV2.Layouts_DL_TX_Update.Layout_DL_TX_Update2,thor);
// export File_DL_TX_Update2 :=	dataset(ut.foreign_prod+'thor_200::in::drvlic_tx_update2',	DriversV2.Layouts_DL_TX_Update.Layout_DL_TX_Update2,thor);

