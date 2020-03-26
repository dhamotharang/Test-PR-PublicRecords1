import _control, std;
EXPORT Spray(string8 version) := function

//bugatti_hdr_20170321_output.dat
//bugatti_stats_20170321_output.dat
//srcdir := '/data/projects/cortera/data/'+version+'/';
srcdir := '/data/projects/cortera/tradeline/data/'+version+'/';

root := '~thor::cortera::in::';
ip :=  IF(_control.ThisEnvironment.Name='Dataland', _control.IPAddress.bctlpedata12, _control.IPAddress.bctlpedata10 ) ;
clusta := IF(_control.ThisEnvironment.Name='Dataland','thor400_sta01','thor400_44');


sprayfile(string filename) := 

		STD.File.SprayVariable(ip,
							srcdir + filename,
							8192,'|',,,
							clusta,
							root + Std.Str.tolowercase(filename),
							,,,true,false,true
						);


return
	SEQUENTIAL(
		PARALLEL(
			sprayfile('bugatti_incr_' + version + '_output.dat'),
			sprayfile('bugatti_delete_' + version + '_output.dat')
			),
		Cortera_Tradeline.Promote().PromoteAdds(root+'bugatti_incr_' + version + '_output.dat'),
		Cortera_Tradeline.Promote().PromoteDels(root+'bugatti_delete_' + version + '_output.dat')
	);
end;
