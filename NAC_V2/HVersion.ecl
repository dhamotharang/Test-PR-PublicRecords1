/*
Maintain most recent header version
When a new header has been created, then the base file needs to be relinked

*/
import Std, did_add;
EXPORT HVersion := MODULE

	shared rVersion := RECORD
		string8		headerVersion;
		unsigned4	updated;
	END;

	export string	sf := '~nac::uber::hversion';
	
	export	dHVersion := dataset(sf, rVersion, thor, opt);

	export string8 ProdVer := did_add.get_EnvVariable('header_build_version')[1..8];
  export string8 lastUpdate := IF(EXISTS(dHVersion), dHVersion[1].headerVersion, '');

	export boolean NewHeader := ProdVer <> lastUpdate;
	
	lfn := sf + '_' + workunit;
	export updateVersion := 
						IF(NOT Std.File.FileExists(lfn),
							ORDERED(
								OUTPUT(DATASET([{ProdVer, Std.Date.Today()}], rVersion),,lfn),
								Std.File.PromoteSuperfileList([sf,sf+'_father'], lfn, true)
							)
						);

END;