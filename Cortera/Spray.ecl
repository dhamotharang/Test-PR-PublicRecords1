import _control, std;

//bugatti_hdr_20170321_output.dat
//bugatti_stats_20170321_output.dat
srcdir := '/data/projects/cortera/';

root := '~thor::cortera::in::';
ip := _control.IPAddress.bctlpedata12;

sprayfile(string filename) := 

		STD.File.SprayVariable(ip,
							srcdir + filename,
							8192,'|',,,
							'thor400_20',
							root + Std.Str.tolowercase(filename),
							,,,true,false,true
						);


EXPORT Spray(string8 version) := PARALLEL(
			sprayfile('bugatti_hdr_' + version + '_output.dat'),
			sprayfile('bugatti_stats_' + version + '_output.dat')
			);