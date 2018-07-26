IMPORT tools;

EXPORT _Dataset(BOOLEAN	pUseOtherEnvironment = FALSE) :=
					tools.Constants(	pDatasetName									:=	'OKC_Probate',
																						pUseOtherEnvironment	:=	pUseOtherEnvironment,
																						pGroupname											:=	'44',
																						pMaxRecordSize							:=	8192,
																						pIsTesting											:=	Tools._Constants.IsDataland
																				);