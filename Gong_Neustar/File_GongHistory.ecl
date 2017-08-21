import ut;
//lfn := '~thor_data400::base::neustar::gong_hitory';
//lfn := ut.foreign_prod + '~thor::gong::neustar::history::temp';
//lfn := ut.foreign_prod + '~thor::gong::neustar::history::20140531';
//lfn := ut.foreign_prod + '~thor::gong::neustar::history::20140618';
//lfn := ut.foreign_prod + '~thor::gong::neustar::history::20140630';
//lfn := ut.foreign_prod + '~thor::gong::neustar::history::20140630';
//lfn := ut.foreign_prod + '~thor::gong::neustar::history::20140731';
//lfn := ut.foreign_prod + '~thor::gong::neustar::history::20140924';
//lfn := '~thor::gong::neustar::history::20141210';
//lfn := ut.foreign_prod + '~thor::gong::neustar::history::20150107';
//lfn := '~thor::gong::neustar::history::20150107::relink';
//lfn := ut.foreign_dataland + 'thor::gong::neustar::history::20150201::full';
lfn := Gong_Neustar.Constants.sfHistory;
EXPORT File_GongHistory := DATASET(lfn, Layout_History, THOR);

