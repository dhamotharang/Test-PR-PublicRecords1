import std, _control;
//srcdir := '/data_999/sanctions/';

//For Variable length file, recSize = 0. For Fixed length file, record size is passed as agrument.						
EXPORT sprayFile(string ipaddr , string subdir, string filename, string separator, string outname, integer recSize = 0) := 
		if(recSize = 0
					,std.File.SprayVariable(ipaddr,
										subdir + '/' + filename,
										8192,separator,,,
										'thor400_44',
										root + outname,
										,,,true,false,false
									 ),
					std.File.SprayFixed(ipaddr,
										subdir + '/' + filename,
										recSize,
										'thor400_44',
										root + outname,
										,,,true,false,false
									)
			);