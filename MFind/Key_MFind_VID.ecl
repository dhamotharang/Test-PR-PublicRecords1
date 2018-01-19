import doxie, Data_Services;

MFind.Layout_Clean_MFind propervid(Mfind.Layout_Clean_Mfind l):=transform
self.trim_vid := trim(l.trim_vid,all);
self := l;
END;


get_recs := project(MFind.File_MFind_Clean(trim_Vid != ''),propervid(left));


Mfind_dist   := distribute(get_recs, hash(trim_vid));
Mfind_sort   := sort(Mfind_dist,trim_vid, local);

export Key_MFind_VID := index(Mfind_sort,{trim_Vid},{Mfind_sort},
Data_Services.Data_location.Prefix()+'thor_data400::key::mfind::VID_'+ doxie.Version_SuperKey);