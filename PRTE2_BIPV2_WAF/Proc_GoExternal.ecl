EXPORT Proc_GoExternal := PARALLEL(Keys(File_BizHead).BuildAll,Process_Biz_Layouts.BuildAll,Key_BizHead_.BuildAll,specificities(File_BizHead).BuildBOWFields);
