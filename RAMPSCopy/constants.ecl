import _Control,lib_stringlib;
// destenv = '' for prod copy; = 'dr' for dr copy
EXPORT constants(string destenv) := module
	export dslistfile := 'ramps::in::indexes::list'; // file is created manually from rampscopy.updaterampsdsfile
	export filestocopyds := dataset('~'+dslistfile
															,rampscopy.layouts.filestocopy
															,thor
															,opt);
															
	export roxieip := _Control.RoxieEnv.prod_batch_neutral;

	export rampsfile := 'ramps::in::transfer::filelist'+destenv;

	export rampsfileds := dataset('~'+rampsfile,rampscopy.layouts.filestocopy,thor,opt);
	
	export boca := module	
		export srcesp := 'prod_esp.br.seisint.com';
		export srcdali := 'prod_dali.br.seisint.com';
		export srcclusters := [//'thor400_20'
																										//	,'thor400_30'
																											//,'thor400_31_store'
																											'thor400_60'
																											,'hthor__eclagent'
																											,'thor400_44'];
		export port := '8010';
		export nonfcra := module
			export roxieprodesp := '10.173.109.101';
			export roxieprodtarget := 'roxie_109';
			export roxiecertesp := '10.173.101.101';
			export roxiecerttarget := 'roxie_cert_pull';
		end;
	end;

	export ramps := module
		export dstesp := map(
															stringlib.StringToUpperCase(destenv) = 'DR' => 'ramps_dr_esp.risk.regn.net',
															stringlib.StringToUpperCase(destenv) = 'QA' => '10.241.100.157',
															stringlib.StringToUpperCase(destenv) = 'DEV' => '10.241.100.159',
															'ramps_prod_esp.risk.regn.net'
														);
		export dstdali := map(
															stringlib.StringToUpperCase(destenv) = 'DR' => '10.194.100.151',
															stringlib.StringToUpperCase(destenv) = 'QA' => '10.241.100.157',
															stringlib.StringToUpperCase(destenv) = 'DEV' => '10.241.100.159',
															'10.173.10.151'
														);
		export dstcluster := map
															(
																	stringlib.StringToUpperCase(destenv) = 'QA' => 'thor100_100cert',
																	stringlib.StringToUpperCase(destenv) = 'DEV' => 'thor100_100dev',
																'thor200_100'
																);
		export port := '8010';
	end;
	
	export rToEmail := 'Anantha.Venkatachalam@lexisnexis.com';
	
	export rFromEmail := 'bocaroxiepackageteam@lexisnexis.com';

end;