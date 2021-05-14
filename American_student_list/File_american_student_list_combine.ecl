﻿﻿// DF-27611 Concatenates ASL and OKC data
IMPORT OKC_Student_List;
file_asl := American_student_list.File_american_student_DID_PH_Suppressed_v2;
file_okc := OKC_Student_List.Map_To_ASL_Base;

EXPORT File_american_student_list_combine :=	file_asl((unsigned8)did<>0) + file_okc(did<>0);
