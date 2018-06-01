/**
Most common US surnames from 2000 census
**/
import	Data_Services, _Control;
dataland := '~thor400_88::';	//		'~thor40_241::;	//'~thor200_144::';
cluster :=  map(Thorlib.Daliservers() in LogsThor => Data_Services.foreign_prod + 'thor_data400::',
									     _Control.ThisEnvironment.name='Dataland' => dataland,
											 '~thor_data400::');
											 
bname := 'base::nid::censussurnames';
fname := cluster + bname;

CensusLayout := RECORD
	string20	name;
	integer4	rank;
	integer4	count;
	decimal8_2	prop100k;
	decimal8_2	cum_prop100k;
	decimal4_2	pctwhite;
	decimal4_2	pctblack;
	decimal4_2	pctapi;
	decimal4_2	pctaian;
	decimal4_2	pct2prace;
	decimal4_2	pcthispanic;
END;

export CensusSurnames := DATASET(fname, CensusLayout, CSV(heading(1)));
