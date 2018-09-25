// W:\Projects\Header\15-05a_BuildAssistScripts\Build_assist.fix_header_raw_sf.header.ecl
// W20161010-113356, W20161011-095045, W20161011-095106

/*      |b05   a05||b04   a04||b03  a03 |b02  a02 fb01  a01 |b12  a12 |b11   f11 |b10   a10 |b09   a09 |b08  a08  |b07  a07 |b06  a06 |b05  a05 |b04  a04 |b03  a03           b02  a02           b01  a01           b12  a12           b11  a11          b10  a10          b09  a09          b08  a08          b03  a03          b02  a02          b01  a01          b1    a1  
gfather |0221 0320||0130 0221|1227 0130|1121 1227|1025 1121|0925 1025|0828 0925|0725  0828|0628  0725|0522  0628|0430 0522 |0321 0430|0223 0321|0123 0223|1220 0123|1122 1220          1024 1122          0920 1024          0825 0920         0725 0825         0620 0725         0525 0620         1221 0125         1124 1221         1026 1124         0526  0622
father  |0320 0423||0221 0320|0130 0221|1227 0130|1121 1227|1025 1121|0925 1025|0828  0925|0725  0828|0628  0725|0522 0628 |0430 0522|0321 0430|0223 0321|0123 0223|1220 0123          1122 1220          1024 1122          0920 1024         0825 0920         0725 0825         0620 0725         0125 0223         1221 0125         1124 1221         0622  0720
prod    |0423 0423||0320 0320|0221 0221|0130 0130|1227 1227|1121 1121|1025 1025|0925  0925|0828  0828|0725  0725|0628 0628 |0628*0522|0430 0430|0321 0321|0223 0223|0123 0123          1220 1220          1122 1122          1024 1024         0920 0920         0825 0825         0725 0725         0223 0223         0125 0125         1221 1221         0720  0720
raw     |0522 0522||0423 0423|0320 0320|0221 0221|0130 0130|1227 1227|1121 1121|1025  1025|0925  0925|0828  0828|0725 0725 |0628 0628|0522 0522|0430 0430|0321 0321|0223 0223          0123 0123          1220 1220          1122 1122         1024 1024         0920 0920         0825 0825         0321 0321         0223 0223         0125 0125         0720  0825
built   |0522 ----||0423 ----|0320 ----|0221 ----|0130 ----|1227 ----|1121 ----|1025  ----|0925  ----|0828  ----|0725 ---- |0628 ----|0522 ----|0430 ----|0321 blnk|0223 blnk          0123 blnk          1220 blnk          1122 blnk         1024 blnk         0920 blnk         0825 blnk         0321 blnk         0223 blnk         0125 blnk         0720  blnk
built1  |---- ----||---- ----|---  ----|---- ----|0221 ----|---  ----|---- ----|----  ----|----  ----|----  ----|---- ---- |---- ----|---- ----|---  ----|blnk blnk|blnk blnk          blnk blnk          blnk blnk         blnk blnk         blnk blnk         blnk blnk         blnk blnk         blnk blnk         blnk blnk         0825  blnk

b06* - should have been 0522. Not sure why 628 moved in. Probably due to building 628 before move.

*/
import header;
#workunit('name','PersonHeader: '+header.version_build+' - Adjust_header_raw_superfiles'); 
step := 				 'Adjust_header_raw_superfiles';
#stored ('buildname', 'PersonHeader'   ); 
#stored ('version'  , header.version_build); 
#stored ('emailList', 'gabriel.marcan@lexisnexis.com,debendra.kumar@lexisnexis.com'    ); 

rw := '~thor_data400::base::header_raw';

get_version(string superFileName) := function
		FileName:=fileservices.GetSuperFileSubName(superFileName,1);
		return regexfind('2[0-9]{7}.*', FileName,0);
end;

ogfv := get_version('~thor_data400::base::header_raw_grandfather');
oftv := get_version('~thor_data400::base::header_raw_father');
oprv := get_version('~thor_data400::base::header_raw_prod');
orwv := get_version('~thor_data400::base::header_raw');

supers := dataset([ {rw+'_grandfather',oftv},{rw+'_father',oprv},
										{rw+'_prod'				,oprv},{rw					,orwv},
									  {rw+'_built'			,''	 },{rw+'_built1',''	 }
								],{string sname, string after_change});

report_before := apply(supers,output(dataset([{sname,fileservices.SuperFileContents(sname),after_change}],
																			{string supername, dataset({string name}) subfiles, string after_change}),named('Before'),extend));

report_after := apply(supers,output(dataset([{sname,fileservices.SuperFileContents(sname)}],
																			{string supername, dataset({string name}) subfiles}),named('After'),extend));

run := sequential( 
	header.LogBuild.single('Started :'+step)
	,report_before
	,fileservices.removesuperfile(rw+'_grandfather',rw+'_'+ogfv   ) /**/ ,fileservices.   addsuperfile(rw+'_grandfather',rw+'_'+oftv   )
	,fileservices.removesuperfile(rw+'_father'     ,rw+'_'+oftv   ) /**/ ,fileservices.   addsuperfile(rw+'_father'     ,rw+'_'+oprv   )
	// REVIEW, DO NOT JUST UNCOMMENT ,fileservices.removesuperfile(rw+''            ,rw+'_xxxxxxxx') /**/ ,fileservices.   addsuperfile(rw+''            ,rw+'_xxxxxxxx')
	,fileservices.removesuperfile(rw+'_built'      ,rw+'_'+orwv   )
	,fileservices.clearsuperfile(rw+'_built1')
	,fileservices.clearsuperfile(rw+'_built2')
	// REVIEW, DO NOT JUST UNCOMMENT ,fileservices.removesuperfile(rw+'_built1'     ,rw+'_xxxxxxxx')
	,report_after
	,header.LogBuild.single('Completed :'+step)
);

// report_before; // first run the _report_before.       Once satisfied, run "run" on header build account
run; 					// first run the _report_before.       Once satisfied, run "run" on header build account

// RUN ON HTHOR

// Previous Runs
// ---------------
// 20180821 W20180823-211441
// 20180724 W20180730-095736
// 20180626 W20180709-105536
// 20180423 http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180513-111252#/stub/Summary
// 20180320 http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180403-123957#/stub/Summary
// 20180221 W20180312-125034
// 20180130 W20180222-145001 
// W20180124-113342 20171227
// W20171211-141646 20171121
// W20171115-083301 20171025
// W20171019-082141 20170925
// W20170925-104726 20170828
// W20170816-105424 20170725
// W20170719-160701 20170628 (manually adjusted)
// W20170622-095352 20170522
// W20170515-092629 20170430
// W20170404-135343 20170321
// W20170309-135544 b02  a02
// W20170130-125250 b01  a01
// W20170103-142802 b12  a12
// W20161201-125531 b11  a11
// W20161103-114722 b10  a10