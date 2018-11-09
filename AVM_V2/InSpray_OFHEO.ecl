import	lib_fileservices,_control;

export	InSpray_OFHEO(string	pVersionDate,string filename,string quarter,string year)	:=
function
	vSourceIP					:=	_control.IPAddress.bctlpedata10;
	vSourcePath				:=	'/data/thor_back5/fares/faresV2/ofheo/in';
	vTargetGrp				:=	'thor400_44';
	vFilePrefix				:=	'~thor_data400::in::avm_ofheo'	;
	vtargetfile       := vFilePrefix	+	'_' + year + '_' + quarter;
	
	sprayofheo			:=	FileServices.sprayvariable(	vSourceIP,
																									vSourcePath	+	'/' + pVersionDate + '/' + filename, , , , ,
																									vTargetGrp,
																									vtargetfile ,
																									,,,true,true,false
																								);
	
add2super := sequential(	fileservices.startsuperfiletransaction(),
                          fileservices.clearsuperfile('~thor_data400::in::avm_ofheo'),
													fileservices.addsuperfile('~thor_data400::in::avm_ofheo',vtargetfile);
													fileservices.finishsuperfiletransaction());
													
outspray := Sequential(sprayofheo,add2super);

return outspray;
end;
													