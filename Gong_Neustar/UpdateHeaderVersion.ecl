IMPORT _Control, header;
roxieip := if (_Control.ThisEnvironment.Name = 'Dataland',
									_Control.RoxieEnv.certvip,
									_Control.RoxieEnv.prod_batch_neutral);

EXPORT UpdateHeaderVersion := 
			if (RelinkGong,
				SEQUENTIAL(
					header.PostDID_HeaderVer_Update('gong_history','header_build_version',roxieip),
					header.PostDID_HeaderVer_Update('gong_history','bheader_build_version',roxieip),
					header.PostDID_HeaderVer_Update('gong_lss_master','header_build_version',roxieip),
					header.PostDID_HeaderVer_Update('gong_lss_master','bheader_build_version',roxieip),
						output('Full re-DID')),
						output('Daily DID')
			);