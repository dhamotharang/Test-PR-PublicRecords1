import header, ut, mdr;

export fn_HeaderKeyDiff(string oldDSName = '',
												dataset(header.layout_header_v2) oldDS = dataset('[]', header.layout_header_v2, thor)) := function

poldHeader := if(oldDSName = '', 
									fileservices.SuperFileContents('~thor_data400::base::header_father')[1].name,
									'~' + oldDSName);

pnewHeader := fileservices.SuperFileContents('~thor_data400::base::header_prod')[1].name;
oldheader := poldHeader[stringlib.stringfind(poldHeader, '::', 2) + 2..];
newheader := pnewHeader[stringlib.stringfind(pnewHeader, '::', 2) + 2..];

/////files for comparison

dSource := if(count(oldDS) = 0,
						project(dataset('~' + poldHeader, recordof(header.File_Headers),thor), transform(recordof(header.File_Headers), self := left)),
						project(oldDS, transform(recordof(header.File_Headers), self := left)));
	dSourceReady	:=	sort(distribute(dSource,hash(rid)),rid,local);
	
dTarget	:=	dataset('~' + pnewHeader, recordof(header.File_Headers),thor);
	dTargetReady	:=	sort(distribute(dTarget,hash(rid)),rid,local);

/////generate indexes

kCommon	:=	index(dSourceReady,{rid},{dSourceReady},'~thor_data400::key::header::full_payload::source');
kSource	:=	index(kCommon,'~thor_data400::key::header::full_payload::'+oldheader);
kTarget	:=	index(kCommon,'~thor_data400::key::header::full_payload::'+newheader);
zBuildSource	:=	buildindex(dSourceReady,{rid},{dSourceReady},'~thor_data400::key::header::full_payload::'+oldheader,sorted,distributed, overwrite);
zBuildTarget	:=	buildindex(dTargetReady(src not in mdr.sourceTools.set_Probation),{rid},{dTargetReady},'~thor_data400::key::header::full_payload::'+newheader,sorted,distributed, overwrite);
zBuildDiff		:=	keydiff(kSource,kTarget,'~thor_data400::keydiff::header::'+oldheader+'::'+newHeader, overwrite);

////// ROTATE superfiles
	
swap_super_diff := 
  FileServices.PromoteSuperFileList(['~thor_data400::keydiff::header_delta','~thor_data400::keydiff::header_delta_delete'],'~thor_data400::keydiff::header::'+oldheader+'::'+newheader);
swap_super_keys1 := 
  FileServices.PromoteSuperFileList(['~thor_data400::key::header_delta::source'],'~thor_data400::key::header::full_payload::'+oldheader);
swap_super_keys2 := 
  FileServices.PromoteSuperFileList(['~thor_data400::key::header_delta::target'],'~thor_data400::key::header::full_payload::'+newheader);

newKeyDiff := FileServices.LogicalFileList()(regexfind('thor_data400::keydiff::header::.*'+newheader, name))[1].name;

bldKeyDiff := sequential(
  parallel(
	if(~fileservices.fileexists('~thor_data400::key::header::full_payload::'+oldheader), 
		sequential(zBuildSource, swap_super_keys1),
		sequential(output('Source Key Exists'), swap_super_keys1)),
	if(~fileservices.fileexists('~thor_data400::key::header::full_payload::'+newheader),
		sequential(zBuildTarget, swap_super_keys2),
		output('Target Key Exists')),
	if(newKeyDiff = '' and ut.IsNewProdHeaderVersion('hdr_avb','header_file_version'),
		sequential(zBuildDiff, swap_super_diff),
		output('KeyDiff Exists'))));

////// OUTPUTS

good2go := ut.IsNewProdHeaderVersion('hdr_avb','header_file_version') : independent;
returndata := 
if(~good2go,
		output('No New Header', named('_')), 
sequential(
	output(newheader, named('Prod_Logical_Name'))
	,bldKeyDiff
	,ut.PostDID_HeaderVer_Update('hdr_avb','header_file_version')
	,header_avb.stat.build_file
	,fileservices.sendemail('cguyton@seisint.com', 'Header Delta Complete: ' + newheader, oldheader+' to '+ newheader+ ' - '+thorlib.wuid()))) 
						  : failure(fileservices.sendemail('cguyton@seisint.com,manish.shah@lexisnexis.com,jose.bello@lexisnexis.com', 'Header Delta Failed ' + thorlib.wuid(), thorlib.wuid()));
	
return returndata;
end;