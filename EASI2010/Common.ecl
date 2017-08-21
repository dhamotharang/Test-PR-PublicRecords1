import EASI;
export Common := MODULE

// Files restricted to geogkey='b'
//   in original EASI layout

export filenameCensus := cluster + 'base::easi::census';
export filenameCurrent := cluster + 'base::easi::current';
export filenameProjected := cluster + 'base::easi::projected';
export filenameLegacy := cluster + 'base::easi::legacy';

//shared EASIs := Layout_legacy;
export File_Census := DATASET(filenameCensus, Layouts.Layout_Census, THOR);		// 2010 census
export File_Current := DATASET(filenameCurrent, Layouts.Layout_Current_yr, THOR);	// current year estimates
export File_Projected := DATASET(filenameProjected, Layouts.Layout_Projection, THOR); // 5 year projection

export File_Legacy := DATASET(filenameLegacy, Layout2000, THOR);	// 2000 layout

END;