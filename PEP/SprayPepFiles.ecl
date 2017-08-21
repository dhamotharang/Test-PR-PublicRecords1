import _control, std;
export SprayPepFiles(string versiondate) := FUNCTION


//srcdir := '/hds_3/pep/' + versiondate + '/';
srcdir := '/hds_3/pep/';
edddir := '/hds_3/pep/edd/';

dest := '~thor::in::pep::' + versiondate +'::';
sprayfile(string filename, string rowtag, string list='', string folder = '') := 

		FileServices.SprayXml(_control.IPAddress.edata12,
							srcdir + folder + filename,
							65000,
							rowtag,,
							'thor40_241',
							dest + 
								if(list='','',list + '::') + stringlib.stringtolowercase(filename),
							,,,true,true,false
						);
						
sprayfileTxt(string dir, string filename, string outname) := 

		FileServices.SprayVariable(_control.IPAddress.edata12,
							dir + filename,
							4096,'|',,,
							'thor40_241',
							dest + outname,
							,,,true,true,false
						);
	
sprayfiles := PARALLEL(
					sprayfile('ENTITY.XML','entity','pep', '1020/'),
					sprayfile('ENTITY.XML','entity','usp', '1021/'),
	// due diligence
					sprayfile('ENTITY.XML','entity','eul', '1098/'),
					sprayfile('ENTITY.XML','entity','eua', '1100/'),
					sprayfile('ENTITY.XML','entity','edc', '1102/'),
					sprayfile('ENTITY.XML','entity','ede', '1104/'),
					sprayfile('ENTITY.XML','entity','eda', '1106/'),
					sprayfile('ENTITY.XML','entity','esa', '1108/'),
					sprayfile('ENTITY.XML','entity','edi', '1110/'),
					sprayfile('ENTITY.XML','entity','euk', '1112/'),
// 					sprayfile('SRCCODE.XML','source-code-map','usp','1021/'),
// 					sprayfile('SRCCODE.XML','source-code-map','pep','1020/'),
//					sprayfile('GROUP.XML','group'),
 					sprayfileTxt(srcdir, 'extractsummary.txt', 'extractsummary.txt'),
 					sprayfileTxt(edddir, 'extractsummary.txt', 'eddextractsummary.txt')
				);

sfPepEntity := '~thor::in::accuity::pep::entity'; 
sfUspEntity := '~thor::in::accuity::usp::entity'; 
	// due diligence
sfEULentity	:=	'~thor::in::accuity::eul::entity';
sfEUAentity	:=	'~thor::in::accuity::eua::entity';
sfEDCentity	:=	'~thor::in::accuity::edc::entity';
sfEDEentity	:=	'~thor::in::accuity::ede::entity';
sfEDAentity	:=	'~thor::in::accuity::eda::entity';
sfESAentity	:=	'~thor::in::accuity::esa::entity';
sfEDIentity	:=	'~thor::in::accuity::edi::entity';
sfEUKentity	:=	'~thor::in::accuity::euk::entity';


sfUspSrcCode := '~thor::in::accuity::usp::srccode';
sfPepSrcCode := '~thor::in::accuity::pep::srccode';


sfGroup := '~thor::in::accuity::pep::group'; 
sfPepExtracts := '~thor::in::accuity::pep::extracts';
sfEddExtracts := '~thor::in::accuity::edd::extracts';

CreateSuperfiles := SEQUENTIAL(
		if (NOT STD.File.SuperFileExists(sfPepEntity),
				STD.File.CreateSuperFile(sfPepEntity));
		if (NOT STD.File.SuperFileExists(sfUspEntity),
				STD.File.CreateSuperFile(sfUspEntity));
		if (NOT STD.File.SuperFileExists(sfEULentity),
				STD.File.CreateSuperFile(sfEULentity));
		if (NOT STD.File.SuperFileExists(sfEUAentity),
				STD.File.CreateSuperFile(sfEUAentity));
		if (NOT STD.File.SuperFileExists(sfEDCentity),
				STD.File.CreateSuperFile(sfEDCentity));
		if (NOT STD.File.SuperFileExists(sfEDEentity),
				STD.File.CreateSuperFile(sfEDEentity));
		if (NOT STD.File.SuperFileExists(sfEDAentity),
				STD.File.CreateSuperFile(sfEDAentity));
		if (NOT STD.File.SuperFileExists(sfESAentity),
				STD.File.CreateSuperFile(sfESAentity));
		if (NOT STD.File.SuperFileExists(sfEDIentity),
				STD.File.CreateSuperFile(sfEDIentity));
		if (NOT STD.File.SuperFileExists(sfEUKentity),
				STD.File.CreateSuperFile(sfEUKentity));
/*		if (NOT STD.File.SuperFileExists(sfPepSrcCode),
				STD.File.CreateSuperFile(sfPepSrcCode));
		if (NOT STD.File.SuperFileExists(sfUspSrcCode),
				STD.File.CreateSuperFile(sfUspSrcCode));
		if (NOT STD.File.SuperFileExists(sfGroup),
				STD.File.CreateSuperFile(sfGroup));
*/
		if (NOT STD.File.SuperFileExists(sfPepExtracts),
				STD.File.CreateSuperFile(sfPepExtracts));
		if (NOT STD.File.SuperFileExists(sfEddExtracts),
				STD.File.CreateSuperFile(sfEddExtracts));
);


getFilename(string filename, string list='') := dest + 
							if(list<>'',list + '::','') + stringlib.stringtolowercase(filename);

return SEQUENTIAL(
	CreateSuperfiles,
	FileServices.StartSuperFileTransaction( ),
		FileServices.ClearSuperFile(sfPepEntity, false),
		FileServices.ClearSuperFile(sfUspEntity, false),
	// due diligence
		FileServices.ClearSuperFile(sfEULentity, false),
		FileServices.ClearSuperFile(sfEUAentity, false),
		FileServices.ClearSuperFile(sfEDCentity, false),
		FileServices.ClearSuperFile(sfEDEentity, false),
		FileServices.ClearSuperFile(sfEDAentity, false),
		FileServices.ClearSuperFile(sfESAentity, false),
		FileServices.ClearSuperFile(sfEDIentity, false),
		FileServices.ClearSuperFile(sfEUKentity, false),
	// extracts
		FileServices.ClearSuperFile(sfPepExtracts, false),
		FileServices.ClearSuperFile(sfEddExtracts, false),
//		FileServices.ClearSuperFile(sfPepSrcCode, false),
//		FileServices.ClearSuperFile(sfUspSrcCode, false),
//		FileServices.ClearSuperFile(sfGroup, false),
	FileServices.FinishSuperFileTransaction( )
	sprayfiles,
	FileServices.StartSuperFileTransaction( ),
		FileServices.AddSuperFile(sfPepEntity, getFilename('entity.xml','pep')),
		FileServices.AddSuperFile(sfUspEntity, getFilename('entity.xml','usp')),
		FileServices.AddSuperFile(sfEULentity, getFilename('entity.xml','eul')),
		FileServices.AddSuperFile(sfEUAentity, getFilename('entity.xml','eua')),
		FileServices.AddSuperFile(sfEDCentity, getFilename('entity.xml','edc')),
		FileServices.AddSuperFile(sfEDEentity, getFilename('entity.xml','ede')),
		FileServices.AddSuperFile(sfEDAentity, getFilename('entity.xml','eda')),
		FileServices.AddSuperFile(sfESAentity, getFilename('entity.xml','esa')),
		FileServices.AddSuperFile(sfEDIentity, getFilename('entity.xml','edi')),
		FileServices.AddSuperFile(sfEUKentity, getFilename('entity.xml','euk')),
	// due diligence
//		FileServices.AddSuperFile(sfUspSrcCode, getFilename('srccode.xml','usp')),
//		FileServices.AddSuperFile(sfPepSrcCode, getFilename('srccode.xml','pep')),
//		FileServices.AddSuperFile(sfGroup, getFilename('group.xml')),
		FileServices.AddSuperFile(sfPepExtracts, getFilename('extractsummary.txt')),
		FileServices.AddSuperFile(sfEddExtracts, getFilename('eddextractsummary.txt')),
	FileServices.FinishSuperFileTransaction( )
	);

END;
