import dops;

DopsEmail := 'Sudhir.Kasavajjala@lexisnexisrisk.com,Michael.Gould@lexisnexis.com,QualityAssurance@seisint.com,Charles.Salvo@lexisnexisrisk.com,' +
							'RoseMary.Fischman@lexisnexisrisk.com,Haley.Vicchio@lexisnexisrisk.com,Lewis.Hughes@lexisnexisrisk.com';
		
EXPORT UpdateDops(string version) := 
						dops.updateversion('CorteraKeys',version,DopsEmail,,'N');