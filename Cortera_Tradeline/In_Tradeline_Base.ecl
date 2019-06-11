b := $.Files.Base;
EXPORT In_Tradeline_Base := 
					$.proc_delete_records($.Files.Dels, b);
