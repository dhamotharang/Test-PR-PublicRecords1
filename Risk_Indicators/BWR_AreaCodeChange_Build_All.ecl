import Risk_Indicators, ut, _Control, std;

//READ ME////READ ME////READ ME////READ ME////READ ME////READ ME////READ ME////READ ME////READ ME////READ ME////READ ME//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Update Frequency: Quarterly Full Append;
// Step 1:  FTP data from:\\tapeload02b\k\metadata\telcordia\area_cd_split_xchange -- To:(edata11:):/gong/gong/telcordia
// Step 2:  Run Abinitio graph edata11: /gong/gong/telcordia/choose_historic_files.mp (all applicable files from all directories will be concatenated)
// Step 3:  Copy output telcordia_asced.d00 to edata12: /thor_back5/local_data/areacode_change/'Enter Receiving File Date Here'
// Step 4:  Change name from telcordia_asced.d00 to areacode_change.d00
// Step 5:  Copy areacode_change.def from previous dated directory into your current directory
// Step 6:  ihdr areacode_change
// Step 7:  keybuild areacode_change
// Step 8:  cd ..
// Step 9:  delete old links -- rm areacode_change*
// Step 10: create new links -- ln -s 'Enter Receiving File Date Here'/* .
// Step 11: ssh rigel -l hozed, <enter password>
// Step 12: localdist -d areacode_change
// Step 13: Execute BWR_AreaCodeChange_Build_All
// As of June of 2016, above steps are no longer applicable. Build has been converted from AbInitio to ECL
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Actions: Spray Input Files, SuperFile Moves, Build keys, Pull QA Samples
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
EXPORT BWR_AreaCodeChange_Build_All(string filedate) := FUNCTION

//filedate := 'Enter Receiving File Date Here'; //Changed this to an input parameter for ease of running process.
vsDate	:= ut.GetDate;

RETURN sequential(Risk_Indicators.spray_AreaCode_split(filedate)
									,Risk_Indicators.Process_AreaCode_Change(filedate)
									,Risk_Indicators.proc_build_AreaCodeChange_keys(vsDate)
									,Risk_Indicators.proc_build_AreaCodeChange_FCRAkeys(vsDate)
									,Risk_Indicators.sample_AreaCode_Change
									);
END;

