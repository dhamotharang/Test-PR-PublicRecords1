OUTPUT(CHOOSEN(DriversVTSA.DL_Source.dHistoryDataMatrix,10000),named('Matrix'));
OUTPUT(CHOOSEN(DriversVTSA.DL_Source.dHistoryDataFlTx,10000),named('FlTx'));

OUTPUT(DriversVTSA.DL_History.DL,, '~thor400_92::out::scankdl::dl', OVERWRITE);
OUTPUT(COUNT(DriversVTSA.DL_History.DL));