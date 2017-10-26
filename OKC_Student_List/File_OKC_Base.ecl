IMPORT OKC_Student_List;

EXPORT File_OKC_Base := DATASET(OKC_Student_List.thor_cluster + 'base::okc_student_list',OKC_Student_List.Layout_Base.base,THOR,OPT);