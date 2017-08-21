/*
	ut.friendlyBytes - formats large file sizes for readability

	We often deal with large file sizes -- large enough that it's a pain to carefully
	count the digits to make sense of how big the file really is.  This function returns
  a string quickly summarizing a file's size using the most appropriate byte unit prefix.

	Max size representable in integer8 is 9.22 EB (9223372036854775807 B)

	Max size representable in unsigned8 is 18.44 EB -- ostensibly that should be the
	input type we're using, but the unsigned8->real8 conversion apparently uses integer8
	as an intermediate type, which produces incorrect results for larger unsigned8 numbers.
*/

export string10 friendlyBytes(integer8 size, boolean useBinary=false) := function

	// SI
	KB	:= power(10,3);		// kilobyte
	MB	:= power(10,6);		// megabyte
	GB	:= power(10,9);		// gigabyte
	TB	:= power(10,12);	// terabyte
	PB	:= power(10,15);	// petabyte
	EB	:= power(10,18);	// exabyte
	
	// IEEE 1541-2002
	KiB	:= power(2,10);		// kibibyte
	MiB	:= power(2,20);		// mebibyte
	GiB	:= power(2,30);		// gibibyte
	TiB	:= power(2,40);		// tebibyte
	PiB	:= power(2,50);		// pebibyte
	EiB	:= power(2,60);		// exbibyte
	
	si := map(
		(real)size>=EB => trim(realformat(size/EB, 6, 2), left) + ' EB',
		(real)size>=PB => trim(realformat(size/PB, 6, 2), left) + ' PB',
		(real)size>=TB => trim(realformat(size/TB, 6, 2), left) + ' TB',
		(real)size>=GB => trim(realformat(size/GB, 6, 2), left) + ' GB',
		(real)size>=MB => trim(realformat(size/MB, 6, 2), left) + ' MB',
		(real)size>=KB => trim(realformat(size/KB, 6, 2), left) + ' KB',
		(string)size + ' B'
	);
	
	ieee := map(
		(real)size>=EiB => trim(realformat(size/EiB, 6, 2), left) + ' EiB',
		(real)size>=PiB => trim(realformat(size/PiB, 6, 2), left) + ' PiB',
		(real)size>=TiB => trim(realformat(size/TiB, 6, 2), left) + ' TiB',
		(real)size>=GiB => trim(realformat(size/GiB, 6, 2), left) + ' GiB',
		(real)size>=MiB => trim(realformat(size/MiB, 6, 2), left) + ' MiB',
		(real)size>=KiB => trim(realformat(size/KiB, 6, 2), left) + ' KiB',
		(string)size + ' B'
	);
	
	return if(useBinary, ieee, si);
	
end;

/*
Demo...

ds_in := dataset([
	{1},
	{12},
	{123},
	{1234},
	{12345},
	{123456},
	{1234567},
	{12345678},
	{123456789},
	{1234567890},
	{12345678901},
	{123456789012},
	{1234567890123},
	{12345678901234},
	{123456789012345},
	{1234567890123456},
	{12345678901234567},
	{123456789012345678},
	{1234567890123456789},
	{9223372036854775807} // 2^63-1 is the max of an integer8
	], {integer8 size, string10 si:='', string10 ieee:=''});
ds_out := project(ds_in, transform(recordof(ds_in),
	self.size := left.size,
	self.si := ut.friendlyBytes(left.size),
	self.ieee := ut.friendlyBytes(left.size,true)));
output(ds_out);
*/