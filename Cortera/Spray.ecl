import _control, std;
EXPORT Spray(string8 version) := function

//bugatti_hdr_20170321_output.dat
//bugatti_stats_20170321_output.dat
srcdir := '/data/projects/cortera/data/'+version+'/';

root := '~thor::cortera::in::';
ip := _control.IPAddress.bctlpedata10;

sprayfile(string filename) := 

		STD.File.SprayVariable(ip,
							srcdir + filename,
							8192,'|',,,
							'thor400_44',
							root + Std.Str.tolowercase(filename),
							,,,true,false,true
						);


return
PARALLEL(
			sprayfile('bugatti_hdr_' + version + '_output.dat'),
			sprayfile('bugatti_stats_' + version + '_output.dat')
			);
end;