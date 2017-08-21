//lfn := '~thor::spokeo::processed';
//lfn := '~thor::spokeo::processed::w20170403-141258';
//lfn := '~thor::spokeo::processed::w20170511-082738';
lfn := '~thor::spokeo::processed::w20170523-151012';


EXPORT File_Processed := dataset(lfn, Spokeo.Layout_Temp, thor);
