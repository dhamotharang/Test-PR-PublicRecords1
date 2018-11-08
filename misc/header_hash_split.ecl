import ut,_control,misc,vehlic,header_slimsort;

// build base for header hash and vinashrunk : check vina is needed? 

build_base := header_slimsort.proc_make_hashes;

// Split and despray 

despray(STRING file, string DestinationIP, string destination) := IF(FileServices.FileExists(file),
		fileservices.despray(file,DestinationIP,destination,,,,TRUE), 
		OUTPUT('File "' + file + '" does not exist, so no despray performed'));

DestinationIP_PA       := '10.173.84.223'; // PA_DISTRIX_LZ - /d$/import/distrix/ \n

// PA
// D:\import\Distrix
// OH
// C:\dropzone\Distrix
Basefile      		:= '~thor_data400::base::headers_hashes_';
Basefilev         := '~thor_data400::out::vinashrunk';
punixPA           := '/mnt/disk1/distrix/';


layout_header_hash := record
unsigned8	hash_val;
unsigned6 	did;
end;

ds := dataset('~thor_data400::base::header_hashes', layout_header_hash, flat);

p0:= output(ds(did % 10 =0),,Basefile + 'p0', overwrite,compressed);
p1:= output(ds(did % 10 =1),,Basefile + 'p1', overwrite,compressed);
p2:= output(ds(did % 10 =2),,Basefile + 'p2', overwrite,compressed);
p3:= output(ds(did % 10 =3),,Basefile + 'p3', overwrite,compressed);
p4:= output(ds(did % 10 =4),,Basefile + 'p4', overwrite,compressed);
p5:= output(ds(did % 10 =5),,Basefile + 'p5', overwrite,compressed);
p6:= output(ds(did % 10 =6),,Basefile + 'p6', overwrite,compressed);
p7:= output(ds(did % 10 =7),,Basefile + 'p7', overwrite,compressed);
p8:= output(ds(did % 10 =8),,Basefile + 'p8', overwrite,compressed);
p9:= output(ds(did % 10 =9),,Basefile + 'p9', overwrite,compressed);

header_split := parallel(p0,p1,p2,p3,p4,p5,p6,p7,p8,p9);

f0b  := despray(Basefile + 'p0', DestinationIP_PA,punixPA+'headers_hashes_p0.d00');
f1b  := despray(Basefile + 'p1', DestinationIP_PA,punixPA+'headers_hashes_p1.d00');
f2b  := despray(Basefile + 'p2', DestinationIP_PA,punixPA+'headers_hashes_p2.d00');
f3b  := despray(Basefile + 'p3', DestinationIP_PA,punixPA+'headers_hashes_p3.d00');
f4b  := despray(Basefile + 'p4', DestinationIP_PA,punixPA+'headers_hashes_p4.d00');
f5b  := despray(Basefile + 'p5', DestinationIP_PA,punixPA+'headers_hashes_p5.d00');
f6b  := despray(Basefile + 'p6', DestinationIP_PA,punixPA+'headers_hashes_p6.d00');
f7b  := despray(Basefile + 'p7', DestinationIP_PA,punixPA+'headers_hashes_p7.d00');
f8b  := despray(Basefile + 'p8', DestinationIP_PA,punixPA+'headers_hashes_p8.d00');
f9b  := despray(Basefile + 'p9', DestinationIP_PA,punixPA+'headers_hashes_p9.d00');
fvb  := despray(Basefilev      , DestinationIP_PA,punixPA+'vinashrunk.d00'); 

send_email:= fileservices.SendEmail(
																		'jose.bello@lexisnexisrisk.com'
																			+',Brian.knowles@lexisnexisrisk.com'
																			+',Roger.Smith@lexisnexisrisk.com'
																			+',Christopher.Brodeur@lexisnexisrisk.com'
																			+',gabriel.marcan@lexisnexisrisk.com'
																		,'Header hash and vina files available'
																		,'Header hash and vina files available at:\n'
																			+'10.173.84.223 - PA_DISTRIX_LZ - /c$/distrix/\n'
																		);

send_bad_email := FileServices.sendemail('gabriel.marcan@lexisnexisrisk.com;debendra.kumar@lexisnexisrisk.com', 'Header hashes build failed', failmessage,'');

export header_hash_split := sequential(
																			build_base,header_split,
																			parallel(f0b,f1b,f2b,f3b,f4b,f5b,f6b,f7b,f8b,f9b,fvb)
																			) :success(send_email), failure(send_bad_email);