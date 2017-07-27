export Constants	:=
module
	export	string		CSVFilesIP				:=	'bctlpedata11.risk.regn.net';
	export	string		CSVFilesBaseDir		:=	'::data::prct::infiles::';
	export	string		CSVFilesBaseName	:=	'~file::' + CSVFilesIP + CSVFilesBaseDir;
	export	string		XMLFilesIP				:=	'bctlpedata11.risk.regn.net';
	export	string		XMLFilesBaseDir		:=	'::data::prct::infiles::special::';
	export	string		XMLFilesBaseName	:=	'~file::' + XMLFilesIP + XMLFilesBaseDir;
	export	string		NewDataBaseDir		:=	'::data::prct::infiles::newdata::';
	export	string		NewDataFilesBaseName	:=	'~file::' + CSVFilesIP + NewDataBaseDir;
	export	string		MidexFilesBaseDir		:=	'::data::prct::infiles::midex::';
	export	string		MidexFilesBaseName	:=	'~file::' + CSVFilesIP + MidexFilesBaseDir;
end;