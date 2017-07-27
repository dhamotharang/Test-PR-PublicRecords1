string120 icn := '' : stored('input_CompanyName');
string25 ic := '' : stored('input_City');
string2 is := '' : stored('input_State');
string5 iz := '' : stored('input_Zip');
unsigned2 imr := 0 : stored('input_MileRadis');

export input_records := 
	dataset(
		[{icn,
		  ic,
		  is,
		  iz,
		  imr}],
		{string120 CompanyName,
		 string25 City,
		 string2 State,
		 string5 Zip,
		 unsigned2 Radius});
