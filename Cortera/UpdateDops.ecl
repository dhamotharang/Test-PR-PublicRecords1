import dops;

<<<<<<< HEAD
DopsEmail := 'Sudhir.Kasavajjala@lexisnexisrisk.com,Michael.Gould@lexisnexis.com,QualityAssurance@seisint.com,Charles.Salvo@lexisnexisrisk.com,' +
							'RoseMary.Fischman@lexisnexisrisk.com,Haley.Vicchio@lexisnexisrisk.com,Lewis.Hughes@lexisnexisrisk.com';
		
=======
DopsEmail := 'Sudhir.Kasavajjala@lexisnexisrisk.com,Michael.Gould@lexisnexis.com,QualityAssurance@seisint.com,Charles.Salvo@lexisnexisrisk.com,Donald.Lingle@lexisnexisrisk.com';

>>>>>>> abcb186a450a13b6fbf11fda99c1f8596608e39e
EXPORT UpdateDops(string version) := 
						dops.updateversion('CorteraKeys',version,DopsEmail,,'N');