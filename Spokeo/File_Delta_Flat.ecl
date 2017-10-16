lfn := '~thor::spokeo::delta::2017JanAndMay';
EXPORT File_Delta_Flat := DATASET(lfn, spokeo.Layout_delta, THOR);
