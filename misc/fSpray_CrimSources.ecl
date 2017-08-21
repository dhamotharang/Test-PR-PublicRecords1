import		STD, _control;

string srcdir := '/data_999/dempsey/';

//string sfname := VendorSrc_SF_List('').Update_Court_Locations;
//string root := sfname + '::';

files := DATASET([
{'Sources.csv',VendorSrc_SF_List('').AllSources},
{'CrimSources.csv',VendorSrc_SF_List('').CrimSources},
{'CrimOffenses.csv',VendorSrc_SF_List('').CrimOffenses},
{'SO_Main.csv',VendorSrc_SF_List('').SO_Main},
{'SO_Offenses.csv',VendorSrc_SF_List('').SO_Offenses}
], {string fname, string sfname});


sprayFile(string fname, string root) :=
		std.File.SprayVariable(_control.IPAddress.edata12,
							srcdir + fname,
							8192,',','\r\n','"',						// comma delimited
							'thor50_dev',
							root + fname,
							,,,true,false,false
						);
SprayFiles := 
		NOTHOR(APPLY(files, SprayFile(fname, sfname + '::')));

AddToSuperFile := NOTHOR(APPLY(files, Std.File.PromoteSuperFileList([sfname,sfname+'::father'], sfname + '::'+fname, deltail := true)));


EXPORT fSpray_CrimSources := SEQUENTIAL(
		SprayFiles,
		AddToSuperFile
		);
