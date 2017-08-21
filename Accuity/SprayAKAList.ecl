import _control;

src := '/data/stub_cleaning/accuity/akalist/FullAccuityAKAlog.csv';

dest := '~thor::bridger::akalist';

export SprayAKAList := 	FileServices.SprayVariable(_control.IPAddress.bctlpedata10,
							src,
							65000,
							,,'"',
							'thor400_44',
							dest,
							,,,true,true,false
						);