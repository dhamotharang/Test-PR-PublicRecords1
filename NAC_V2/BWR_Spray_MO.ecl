dir := '/data_build_4/nac/_workspace/poc/mo';
ip := _control.IPAddress.edata10;
target := IF(_control.ThisEnvironment.Name ='Dataland', 'thor400_dev01','thor400_20');				
root := '~nac::in::mo::';

dsFileList:=nothor(STD.File.RemoteDirectory(ip, dir));

sprayAFile(string filename) := 
		std.File.SprayVariable(_control.IPAddress.edata10,
							dir + '/' + filename,
							8192,'|',,'\t',						// pipe delimited, no quote character
							target,
							root + Std.Str.FindReplace(
												Std.Str.ToLowerCase(filename), '.txt', ''),
							,,,true,false,true
						);
SprayFiles := 
		APPLY(dsFileList, SprayAFile( name));



doit := SEQUENTIAL
(	
	OUTPUT(dsFileList, named('files')),
	sprayFiles
);

doit;

