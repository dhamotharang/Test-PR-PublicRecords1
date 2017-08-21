import header, ut, mdr, InsuranceHeader_Preprocess;

//////////////////***************************************************/////////////////////////////////////////////////////////////
////////////////// Either enter the logical file names as a parameter without the ~ or let it find the names in the superfiles
////////////////// Files must stay in same logical name format to pick up the correct suffix with only 2 sets of colons - 
//////////////////		Ex: thor_data400::base::header_raw_w20111019-234634
//////////////////***************************************************/////////////////////////////////////////////////////////////

export fn_HeaderRawKeyDiff(string pFatherLogicalName = '', string pProdLogicalName = '') := function

//////find superfiles' logical names
pnewHeader 	:= fileservices.SuperFileContents('~thor_data400::base::header_raw')[1].name;
poldHeader1 := fileservices.SuperFileContents('~thor_data400::base::header_raw_prod')[1].name;
poldHeader2 := fileservices.SuperFileContents('~thor_data400::base::header_raw_father')[1].name;
poldHeader 	:= map(pnewHeader <> poldHeader1 => poldHeader1, 
									 pnewHeader <> poldHeader2 => poldHeader2,
									 pnewHeader);

//////obtain suffix to name keydiff and keys
oldheader := if(pFatherLogicalName <> '', pFatherLogicalName, poldHeader)[stringlib.stringfind(poldHeader, '::', 2) + 2..];
// oldheader := 'header_raw_w20120727-081713';
newheader := if(pProdLogicalName <> '', pProdLogicalName, pnewHeader)[stringlib.stringfind(poldHeader, '::', 2) + 2..];

/////generate indexes
	dTarget			:=	dataset('~' + pnewHeader, recordof(header.File_Headers),thor);
dTargetReady	:=	sort(distribute(dTarget,hash(rid)),rid,local);

	dSource			:=	project(dataset('~' + poldHeader, recordof(header.File_Headers), thor), recordof(dTarget));
	// dSource 		:=	dataset('~' + poldHeader, recordof(dTarget), thor);
dSourceReady	:=	sort(distribute(dSource,hash(rid)),rid,local);
	
	kCommon			:=	index(dTargetReady,{rid},{dTargetReady},'~thor_data400::key::header_raw::source');
kSource				:=	index(kCommon,'~thor_data400::key::header::raw::'+oldheader);
kTarget				:=	index(kCommon,'~thor_data400::key::header::raw::'+newheader);

zBuildSource	:=	buildindex(dSourceReady,{rid},{dSourceReady},'~thor_data400::key::header::raw::'+oldheader,sorted,distributed, overwrite);
zBuildTarget	:=	buildindex(dTargetReady(src<>'AY'),{rid},{dTargetReady},'~thor_data400::key::header::raw::'+newheader,sorted,distributed, overwrite);
zBuildDiff		:=	keydiff(kSource,kTarget,'~thor_data400::keydiff::header_raw::'+oldheader+'::'+newHeader, overwrite);

//////swap superfiles
swap_super_keys1 := 
  FileServices.PromoteSuperFileList(['~thor_data400::key::header_raw::source'],'~thor_data400::key::header::raw::'+oldheader);
swap_super_keys2 := 
  FileServices.PromoteSuperFileList(['~thor_data400::key::header_raw::target'],'~thor_data400::key::header::raw::'+newheader);
swap_super_diff := 
  FileServices.PromoteSuperFileList(['~thor_data400::keydiff::header_raw_delta','~thor_data400::keydiff::header_raw_delta_delete'],'~thor_data400::keydiff::header_raw::'+oldheader+'::'+newheader);

keydiff_available := fileservices.fileexists('~thor_data400::keydiff::header_raw::'+oldheader+'::'+newHeader) : independent;

// success_email(string update_status) := InsuranceHeader_Preprocess.mod_email.SendSuccessEmail(InsuranceHeader_Preprocess.mod_email.emaillist, 'Raw Boca Header AVB', update_status);
success_email(string update_status) := fileservices.sendemail('cecelie.reid@lexisnexis.com,'+InsuranceHeader_Preprocess.mod_email.emaillist, 'Raw Boca Header AVB', update_status +workunit);

bldKeyDiff := sequential(
	if(~keydiff_available and 
		 ~fileservices.fileexists('~thor_data400::key::header::raw::'+oldheader), 
				sequential(zBuildSource, swap_super_keys1, success_email('Raw Boca Prod Source Key Available ')), 
				output(oldheader + ' Raw Source Key Exists')),

	if(~keydiff_available and
		 ~fileservices.fileexists('~thor_data400::key::header::raw::'+newheader),
				sequential(zBuildTarget, swap_super_keys2, success_email('Raw Boca Prod Target Key Available ')), 
				output(newheader + ' Raw Target Key Exists')),

	if(~keydiff_available,
				sequential(zBuildDiff, swap_super_diff, success_email('Raw Boca Prod Keydiff Available '),
									 Header_AVB.Stat(true).Build_file, success_email('Raw Boca Prod Stats Available ')), 
				output(oldheader + ' to ' + newheader + ' Raw KeyDiff Exists'))
		);

////// OUTPUTS

returndata := if(pNewHeader <> pOldHeader, bldKeyDiff, output('New and Old Match. Raw in transition. No Build.'))
							  // : failure(InsuranceHeader_Preprocess.mod_email.SendFailureEmail(InsuranceHeader_Preprocess.mod_email.emaillist, 'Boca Raw Header AVB', 'RAW Boca Header Delta Failed\n' +failmessage));
							  : failure(fileservices.sendemail('cecelie.reid@lexisnexis.com', 'Raw Boca Header AVB Fail', workunit + ' - ' + failmessage))
							    ;
	
return returndata;
end;