EXPORT fConvert_13d13g(string filedate) := module
import lib_StringLib,_control;





string          sourceLZ              := '/data/prod_data_build_10/production_data/business_headers/vickers/in/';

infilelist := FileServices.RemoteDirectory(_control.IPAddress.bctlpedata11,sourceLZ,'Seisint13D13G6yr*fixed');

string8 fdate := infilelist[1].name[25..32] ;

d13d13g_Remote 	:= 	dataset('~file::'+_control.IPAddress.bctlpedata11+'::data::prod_data_build_10::production_data::business_headers::vickers::in::^Seisint13^D13^G6yr^Rpt.txt.'+fdate+'.fixed', Vickers.Layouts_raw.r13d13g, thor) ( trim(form_id) <> 'formId');
	
	string					Insider13d13gLF				:=	'~thor_data400::in::vickers::'+filedate+'::13d13g_raw';
  string					Insider13d13gSF				:=	'~thor_data400::in::vickers::13d13g_raw';


export d13g13g_thor	:=	Sequential( if ( FileServices.FindSuperFileSubName( Insider13d13gSF , Insider13d13gLF) <> 0, FileServices.ClearSuperfile( Insider13d13gSF)),
                                   output( project(distribute(d13d13g_Remote,skew(0.1)), Vickers.Layouts_raw.Layout_13D13G  ),,'~thor_data400::in::vickers::'+filedate+'::13d13g_raw',overwrite),
																	 FileServices.StartSuperFileTransaction( ),
		                                   if ( NOT FileServices.SuperFileExists( Insider13d13gSF),FileServices.CreateSuperfile(Insider13d13gSF)),
																			 if (  FileServices.SuperFileExists( Insider13d13gSF),FileServices.ClearSuperfile( Insider13d13gSF)),
																			 FileServices.AddSuperfile( Insider13d13gSF,Insider13d13gLF),
																			 FileServices.FinishSuperFileTransaction( )
																		);

end;

