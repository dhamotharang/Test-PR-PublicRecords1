/**
* NormDate
*
* Convert various date formats to YYYYMMDD
*
* @param		d		Input date in a variety of formats (see code below for a list)
* @return 			Output date as YYYYMMDD
*/

export unsigned NormDate(unsigned d) := map(
	d>13000000 => d,																						// YYYYMMDD
	d>01000000 => (d%10000)*10000 + (d/10000),									// MMDDYYYY
	d>00130000 => d * 100,																			// YYYYMM
	d>00010000 => (d%10000)*10000 + ((unsigned)(d/10000))*100,	// MMYYYY
	d>00001000 => d * 10000,																		// YYYY
	0
);

/*
* demo code for dates spanning 1/1/1800 - 12/31/2200

ds_in := dataset([
	{18000101},	{22001231},	// YYYYMMDD
	{01011800},	{12312200},	// MMDDYYYY
	{180001},		{220012},		// YYYYMM
	{011800},		{122200},		// MMYYYY
	{1800},			{2200}			// YYYY
	],{unsigned d});
ds_out := project(ds_in, transform({unsigned d1; unsigned d2;}, self.d1:=left.d, self.d2:=ut.NormDate(left.d1)));
output(sort(ds_out,d2));

*/