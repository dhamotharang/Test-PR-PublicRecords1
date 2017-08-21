import		STD, _control;

// string srcdir := '/data_999/CourtLocations/';
string srcdir := '/data/hds_180/vendor_source/data/';

string sfname := VendorSrc_SF_List('').Update_Court_Locations;
string root := sfname + '::';

sprayFile(string fname) :=
		std.File.SprayVariable(_control.IPAddress.bctlpedata10,
							srcdir + fname,
							8192,'|','\r\n',,						// pipe delimited, no quote character
							'thor400_44',
							root + fname,
							,,,true,false,false
						);


EXPORT fSpray_CourtLocation_File(string fname) := SEQUENTIAL(
		sprayFile(fname),
		//Std.File.CreateSuperFile(sfname),
		Std.File.PromoteSuperFileList([sfname,sfname+'::father'], root+fname, deltail := true)
		);
