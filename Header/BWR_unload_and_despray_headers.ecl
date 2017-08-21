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



Destinationpath1	:=	'/danny_vol/';
Destinationpath2	:=	'/eq_hdrs_temp/header_to_alpharetta_temp/';

DestinationIP1	:=	_Control.IPAddress.edata11;
DestinationIP2	:=	_Control.IPAddress.edata12;

bSource	:=	'~thor_data400::base::bushead::unload';
hSource	:=	'~thor_data400::base::header::unload';

myfilestodespray1:=dataset(	[
						{bSource+'01',pDestinationIP,Destinationpath+'bhunload01'}
						,{bSource+'02',pDestinationIP,Destinationpath+'bhunload02'}
						,{bSource+'03',pDestinationIP,Destinationpath+'bhunload03'}
						,{bSource+'04',pDestinationIP,Destinationpath+'bhunload04'}
						,{bSource+'05',pDestinationIP,Destinationpath+'bhunload05'}
						,{bSource+'06',pDestinationIP,Destinationpath+'bhunload06'}
						,{bSource+'07',pDestinationIP,Destinationpath+'bhunload07'}
						,{bSource+'08',pDestinationIP,Destinationpath+'bhunload08'}
						,{bSource+'09',pDestinationIP,Destinationpath+'bhunload09'}
						,{bSource+'10',pDestinationIP,Destinationpath+'bhunload10'}
						,{hSource+'01',pDestinationIP,Destinationpath+'hunload01'}
						,{hSource+'02',pDestinationIP,Destinationpath+'hunload02'}
						,{hSource+'03',pDestinationIP,Destinationpath+'hunload03'}
						,{hSource+'04',pDestinationIP,Destinationpath+'hunload04'}
						,{hSource+'05',pDestinationIP,Destinationpath+'hunload05'}
						,{hSource+'06',pDestinationIP,Destinationpath+'hunload06'}
						,{hSource+'07',pDestinationIP,Destinationpath+'hunload07'}
						,{hSource+'08',pDestinationIP,Destinationpath+'hunload08'}
						,{hSource+'09',pDestinationIP,Destinationpath+'hunload09'}
						,{hSource+'10',pDestinationIP,Destinationpath+'hunload10'}
						,{hSource+'11',pDestinationIP,Destinationpath+'hunload11'}
						,{hSource+'12',pDestinationIP,Destinationpath+'hunload12'}
						,{hSource+'13',pDestinationIP,Destinationpath+'hunload13'}
						,{hSource+'14',pDestinationIP,Destinationpath+'hunload14'}
						,{hSource+'15',pDestinationIP,Destinationpath+'hunload15'}
						,{hSource+'16',pDestinationIP,Destinationpath+'hunload16'}
						,{hSource+'17',pDestinationIP,Destinationpath+'hunload17'}
						,{hSource+'18',pDestinationIP,Destinationpath+'hunload18'}
						,{hSource+'19',pDestinationIP,Destinationpath+'hunload19'}
						,{hSource+'20',pDestinationIP,Destinationpath+'hunload20'}

						],	versioncontrol.Layout_DKCs.Input);

 versioncontrol.fDesprayFiles(myfilestodespray1,,,'DesprayListInfo',true);




myfilestodespray2:=dataset(	[
						{hSource+'21',pDestinationIP,Destinationpath+'hunload21'}
						,{hSource+'22',pDestinationIP,Destinationpath+'hunload22'}
						,{hSource+'23',pDestinationIP,Destinationpath+'hunload23'}
						,{hSource+'24',pDestinationIP,Destinationpath+'hunload24'}
						,{hSource+'25',pDestinationIP,Destinationpath+'hunload25'}
						,{hSource+'26',pDestinationIP,Destinationpath+'hunload26'}
						,{hSource+'27',pDestinationIP,Destinationpath+'hunload27'}
						,{hSource+'28',pDestinationIP,Destinationpath+'hunload28'}
						,{hSource+'29',pDestinationIP,Destinationpath+'hunload29'}
						,{hSource+'30',pDestinationIP,Destinationpath+'hunload30'}
						,{hSource+'31',pDestinationIP,Destinationpath+'hunload31'}
						,{hSource+'32',pDestinationIP,Destinationpath+'hunload32'}
						,{hSource+'33',pDestinationIP,Destinationpath+'hunload33'}
						,{hSource+'34',pDestinationIP,Destinationpath+'hunload34'}
						,{hSource+'35',pDestinationIP,Destinationpath+'hunload35'}
						,{hSource+'36',pDestinationIP,Destinationpath+'hunload36'}
						,{hSource+'37',pDestinationIP,Destinationpath+'hunload37'}
						,{hSource+'38',pDestinationIP,Destinationpath+'hunload38'}
						,{hSource+'39',pDestinationIP,Destinationpath+'hunload39'}
						,{hSource+'40',pDestinationIP,Destinationpath+'hunload40'}

						],	versioncontrol.Layout_DKCs.Input);

 versioncontrol.fDesprayFiles(myfilestodespray2,,,'DesprayListInfo',true);