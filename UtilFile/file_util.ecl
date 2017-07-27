export file_util := module
//file for keys has DID but no rawid and nameflag
export full_did := dataset('~thor_data400::base::utility_DID', UtilFile.Layout_DID_Out, flat);
//file has rawid and nameflag but no DID
export full_base := dataset('~thor_data400::base::utility_file', UtilFile.layout_util.base, flat);

end;

