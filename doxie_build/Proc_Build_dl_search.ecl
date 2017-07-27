dofirst := doxie_build.Proc_Build_DL_Search_Base;

dosecond := doxie_build.Proc_Build_DL_Search_Keys;

export Proc_Build_dl_search := sequential(dofirst, dosecond);