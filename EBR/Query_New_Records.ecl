File_0010_base_header := dataset('~thor_data400::base::ebr_0010_header',EBR.layout_0010_header_base,flat);
File_0010_base_header_father := dataset('~thor_data400::base::ebr_0010_header_father',EBR.layout_0010_header_base,flat);

File_dist_hdr := distribute(File_0010_base_header,HASH32(bdid));
File_dist_hdr_father := distribute(File_0010_base_header_father,HASH32(bdid));


EBR.layout_0010_header_base tlayout_0010_base(File_0010_base_header le,File_0010_base_header_father re) := transform

self := le;

end;

myheader := join(File_dist_hdr,File_dist_hdr_father,LEFT.bdid=RIGHT.bdid,tlayout_0010_base(LEFT,RIGHT),LEFT ONLY,local);

File_5610_demographic_data := dataset('~thor_data400::base::ebr_5610_demographic_data',EBR.Layout_5610_demographic_data_Base,flat);
File_5610_demographic_data_father := dataset('~thor_data400::base::ebr_5610_demographic_data_father',EBR.Layout_5610_demographic_data_Base,flat);

File_dist_demo := distribute(File_5610_demographic_data,HASH32(bdid));
File_dist_demo_father := distribute(File_5610_demographic_data_father,HASH32(bdid));


EBR.Layout_5610_demographic_data_Base tlayout_5610_base(File_5610_demographic_data le,File_5610_demographic_data_father re) := transform

self := le;

end;

mydemo := join(File_dist_demo,File_dist_demo_father,LEFT.bdid=RIGHT.bdid,tlayout_5610_base(LEFT,RIGHT),LEFT ONLY,local);



do1 := output(topn(myheader(bdid != 0), 100, -(unsigned4)date_last_seen), named('EbrHeaderSampleRecsForQA'));
do2 := output(topn(mydemo(bdid != 0), 100, -(unsigned4)date_last_seen), named('EbrDemographicSampleRecsForQA'));


export Query_New_Records := sequential(do1, do2);