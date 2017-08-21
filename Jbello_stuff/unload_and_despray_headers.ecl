dHeaderPersist    :=    Business_Header.File_Business_Header : persist('~thor::temp::jbello::bushead_unload_local');
mHeaderUnload(pWhich)
 :=
  macro
    output(sample(dHeaderPersist, 10, pWhich),,'~thor_data400::base::bushead::unload' + intformat(pWhich,2,1),__compressed__,overwrite);
  endmacro
 ;

mHeaderUnload( 1);
mHeaderUnload( 2);
mHeaderUnload( 3);
mHeaderUnload( 4);
mHeaderUnload( 5);
mHeaderUnload( 6);
mHeaderUnload( 7);
mHeaderUnload( 8);
mHeaderUnload( 9);
mHeaderUnload(10);


dHeaderPersist    :=    header.File_Headers : persist('~thor::temp::jbello::header_unload_local');
mHeaderUnload(pWhich)
 :=
  macro
    output(sample(dHeaderPersist, 40, pWhich),,'~thor_data400::base::header::unload' + intformat(pWhich,2,1),__compressed__,overwrite);
  endmacro
 ;

mHeaderUnload( 1);
mHeaderUnload( 2);
mHeaderUnload( 3);
mHeaderUnload( 4);
mHeaderUnload( 5);
mHeaderUnload( 6);
mHeaderUnload( 7);
mHeaderUnload( 8);
mHeaderUnload( 9);
mHeaderUnload(10);
mHeaderUnload(11);
mHeaderUnload(12);
mHeaderUnload(13);
mHeaderUnload(14);
mHeaderUnload(15);
mHeaderUnload(16);
mHeaderUnload(17);
mHeaderUnload(18);
mHeaderUnload(19);
mHeaderUnload(20);
mHeaderUnload(21);
mHeaderUnload(22);
mHeaderUnload(23);
mHeaderUnload(24);
mHeaderUnload(25);
mHeaderUnload(26);
mHeaderUnload(27);
mHeaderUnload(28);
mHeaderUnload(29);
mHeaderUnload(30);
mHeaderUnload(31);
mHeaderUnload(32);
mHeaderUnload(33);
mHeaderUnload(34);
mHeaderUnload(35);
mHeaderUnload(36);
mHeaderUnload(37);
mHeaderUnload(38);
mHeaderUnload(39);
mHeaderUnload(40);



// Destinationpath	:=	'/danny_vol/';
// pDestinationIP	:=	_Control.IPAddress.edata11;

// Source	:=	'~thor_data400::base::bushead::unload';

// myfilestodespray:=dataset(	[
						// {Source+'01',pDestinationIP,Destinationpath+'bhunload01'}
						// ,{Source+'02',pDestinationIP,Destinationpath+'bhunload02'}
						// ,{Source+'03',pDestinationIP,Destinationpath+'bhunload03'}
						// {Source+'04',pDestinationIP,Destinationpath+'bhunload04'}
						// ,{Source+'05',pDestinationIP,Destinationpath+'bhunload05'}
						// ,{Source+'06',pDestinationIP,Destinationpath+'bhunload06'}
						// ,{Source+'07',pDestinationIP,Destinationpath+'bhunload07'}
						// ,{Source+'08',pDestinationIP,Destinationpath+'bhunload08'}
						// ,{Source+'09',pDestinationIP,Destinationpath+'bhunload09'}
						// ,{Source+'10',pDestinationIP,Destinationpath+'bhunload10'}

						// ],	versioncontrol.Layout_DKCs.Input);

 // versioncontrol.fDesprayFiles(myfilestodespray,,,'DesprayListInfo',true);

// Destinationpath	:=	'/danny_vol/';
// pDestinationIP	:=	_Control.IPAddress.edata11;

// Source	:=	'~thor_data400::base::header::unload';

// myfilestodespray:=dataset(	[
						// {Source+'01',pDestinationIP,Destinationpath+'hunload01'}
						// ,{Source+'02',pDestinationIP,Destinationpath+'hunload02'}
						// {Source+'03',pDestinationIP,Destinationpath+'hunload03'}
						// ,{Source+'04',pDestinationIP,Destinationpath+'hunload04'}
						// ,{Source+'05',pDestinationIP,Destinationpath+'hunload05'}
						// ,{Source+'06',pDestinationIP,Destinationpath+'hunload06'}
						// ,{Source+'07',pDestinationIP,Destinationpath+'hunload07'}
						// ,{Source+'08',pDestinationIP,Destinationpath+'hunload08'}
						// ,{Source+'09',pDestinationIP,Destinationpath+'hunload09'}
						// ,{Source+'10',pDestinationIP,Destinationpath+'hunload10'}
						// ,{Source+'11',pDestinationIP,Destinationpath+'hunload11'}
						// ,{Source+'12',pDestinationIP,Destinationpath+'hunload12'}
						// ,{Source+'13',pDestinationIP,Destinationpath+'hunload13'}
						// ,{Source+'14',pDestinationIP,Destinationpath+'hunload14'}
						// ,{Source+'15',pDestinationIP,Destinationpath+'hunload15'}
						// ,{Source+'16',pDestinationIP,Destinationpath+'hunload16'}
						// ,{Source+'17',pDestinationIP,Destinationpath+'hunload17'}
						// ,{Source+'18',pDestinationIP,Destinationpath+'hunload18'}
						// ,{Source+'19',pDestinationIP,Destinationpath+'hunload19'}
						// ,{Source+'20',pDestinationIP,Destinationpath+'hunload20'}

						// ],	versioncontrol.Layout_DKCs.Input);

 // versioncontrol.fDesprayFiles(myfilestodespray,,,'DesprayListInfo',true);


Destinationpath	:=	'/eq_hdrs_temp/header_to_alpharetta_temp/';
pDestinationIP	:=	_Control.IPAddress.edata12;

Source	:=	'~thor_data400::base::header::unload';

myfilestodespray:=dataset(	[
						{Source+'21',pDestinationIP,Destinationpath+'hunload21'}
						,{Source+'22',pDestinationIP,Destinationpath+'hunload22'}
						,{Source+'23',pDestinationIP,Destinationpath+'hunload23'}
						,{Source+'24',pDestinationIP,Destinationpath+'hunload24'}
						,{Source+'25',pDestinationIP,Destinationpath+'hunload25'}
						,{Source+'26',pDestinationIP,Destinationpath+'hunload26'}
						,{Source+'27',pDestinationIP,Destinationpath+'hunload27'}
						,{Source+'28',pDestinationIP,Destinationpath+'hunload28'}
						,{Source+'29',pDestinationIP,Destinationpath+'hunload29'}
						,{Source+'30',pDestinationIP,Destinationpath+'hunload30'}
						// ,{Source+'31',pDestinationIP,Destinationpath+'hunload31'}
						// ,{Source+'32',pDestinationIP,Destinationpath+'hunload32'}
						// ,{Source+'33',pDestinationIP,Destinationpath+'hunload33'}
						// ,{Source+'34',pDestinationIP,Destinationpath+'hunload34'}
						// ,{Source+'35',pDestinationIP,Destinationpath+'hunload35'}
						// ,{Source+'36',pDestinationIP,Destinationpath+'hunload36'}
						// ,{Source+'37',pDestinationIP,Destinationpath+'hunload37'}
						// ,{Source+'38',pDestinationIP,Destinationpath+'hunload38'}
						// ,{Source+'39',pDestinationIP,Destinationpath+'hunload39'}
						// ,{Source+'40',pDestinationIP,Destinationpath+'hunload40'}

						],	versioncontrol.Layout_DKCs.Input);

 versioncontrol.fDesprayFiles(myfilestodespray,,,'DesprayListInfo',true);


