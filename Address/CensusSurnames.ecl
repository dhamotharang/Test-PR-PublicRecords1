/**
Most common US surnames from 2000 census
**/
import	ut, _Control, Data_Services;
cluster :=  IF(Thorlib.Daliservers()='10.173.231.12:7070',data_services.data_location.prefix() + '~thor_data400::',IF(_Control.ThisEnvironment.name='Dataland', '~thor400_88::','~thor_data400::'));
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
