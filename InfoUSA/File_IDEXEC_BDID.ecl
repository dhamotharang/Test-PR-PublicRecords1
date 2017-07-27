bdid_layout := record
 unsigned6 bdid;
 InfoUSA.Layout_Cleaned_IDEXEC_file;
end;

export File_IDEXEC_BDID := dataset('~thor_data400::base::infousa_idexec_bdid',bdid_layout,flat);