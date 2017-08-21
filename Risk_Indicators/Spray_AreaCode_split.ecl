/*Note - Spray format command:
Risk_Indicators.Spray_AreaCode_split(VersionDate)
*/
IMPORT std, _control, Risk_Indicators;

EXPORT Spray_AreaCode_split(string filedate) := FUNCTION

	fSprayFile(string filename) := std.File.SprayFixed(_control.IPAddress.bctlpedata11,
																'/data/gong/gong/telcordia/area_code_split_changes/spray/'+filedate+'/'+filename,
																30,'thor50_dev',
																'~thor_data400::in::areacode_split::'+filedate+'::'+filename,
																,,,true,false,false);													
	
	List := STD.File.RemoteDirectory( _control.IPAddress.bctlpedata11, '/data/gong/gong/telcordia/area_code_split_changes/spray/' + filedate);
	List2 := SORT(List(REGEXFIND('[0-9]{4}[A-Z]{1}[0-9]{3}[.][0-9]{3}', name)),name);//: GLOBAL(FEW);

	SprayFiles := NOTHOR(APPLY(GLOBAL(List2,FEW), fSprayFile(name)));
	
	fAddSuper(string subname) :=	Std.File.AddSuperFile('~thor_data400::in::areacode_split', '~thor_data400::in::areacode_split::'+filedate+'::'+subname);
	ClearSuper	:= Std.File.ClearSuperFile('~thor_data400::in::areacode_split', false);																																		
	AddToSuperFile := NOTHOR(APPLY(GLOBAL(List2,FEW), fAddSuper(name)));
	
	RETURN SEQUENTIAL(OUTPUT(List2, named('files')),
										SprayFiles,
										ClearSuper,
										Std.File.StartSuperFileTransaction( ),
										AddToSuperFile,
										Std.File.FinishSuperFileTransaction( ));
END;