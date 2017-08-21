export Files09 := MODULE

import _Control;

export	cluster :=  IF(_Control.ThisEnvironment.name='Dataland', '~thor_data50::', '~thor_data400::');

// input files
export File_dems00 := DATASET(cluster + 'in::easi::dems00',EASI.Layout_Dems_00,CSV(HEADING(2),QUOTE('"'),TERMINATOR(['\r\n','\n']),MAXLENGTH(32000)))(GEOGKEY='b');
export File_dems09 := DATASET(cluster + 'in::easi::dems09',EASI.Layout_Dems_09,CSV(HEADING(2),QUOTE('"'),MAXLENGTH(32000)))(GEOGKEY='b');
export File_dems10 := DATASET(cluster + 'in::easi::dems10',EASI.Layout_Dems_09,CSV(HEADING(2),QUOTE('"'),MAXLENGTH(32000)))(GEOGKEY='b');
export File_dems14 := DATASET(cluster + 'in::easi::dems14',EASI.Layout_Dems_14,CSV(HEADING(2),QUOTE('"'),MAXLENGTH(32000)))(GEOGKEY='b');
export File_dems15 := DATASET(cluster + 'in::easi::dems15',EASI.Layout_Dems_14,CSV(HEADING(2),QUOTE('"'),MAXLENGTH(32000)))(GEOGKEY='b');

export File_xtra00 := DATASET(cluster + 'in::easi::xtra00',EASI.Layout_Xtra,CSV(HEADING(2),QUOTE('"'),TERMINATOR(['\r\n','\n']),MAXLENGTH(32000)))(GEOGKEY='b');
export File_xtra10 := DATASET(cluster + 'in::easi::xtra10',EASI.Layout_Xtra,CSV(HEADING(2),QUOTE('"'),TERMINATOR(['\r\n','\n']),MAXLENGTH(32000)))(GEOGKEY='b');
export File_xtra14 := DATASET(cluster + 'in::easi::xtra15',EASI.Layout_Xtra,CSV(HEADING(2),QUOTE('"'),TERMINATOR(['\r\n','\n']),MAXLENGTH(32000)))(GEOGKEY='b');

export File_naics10 := DATASET(cluster + 'in::easi::naics10',EASI.Layout_NAICS_09,CSV(HEADING(2),QUOTE('"'),TERMINATOR(['\r\n','\n']),MAXLENGTH(32000)))(GEOGKEY='b');


// output files
shared filedate:=EASI.Version_Development;
export filename00 := cluster + 'base::easi::'+filedate+'::census_00';
export filename09 := cluster + 'base::easi::'+filedate+'::current_09';
export filename10 := cluster + 'base::easi::'+filedate+'::current_10';
export filename14 := cluster + 'base::easi::'+filedate+'::projected_14';
export filename15 := cluster + 'base::easi::'+filedate+'::projected_15';

shared EASIs := EASI.Layout_Census;	//EASI.Layout_Easi_Census_v2;
export File_data00 := DATASET(filename00, EASIs, THOR);
export File_data09 := DATASET(filename09, EASIs, THOR);
export File_data10 := DATASET(filename10, EASIs, THOR);
export File_data14 := DATASET(filename14, EASIs, THOR);
export File_data15 := DATASET(filename15, EASIs, THOR);


END;