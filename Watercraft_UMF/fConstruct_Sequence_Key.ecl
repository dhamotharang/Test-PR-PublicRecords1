import Lib_StringLib;

export string fConstruct_Sequence_Key(string pGroupKeyIn)
 := if(trim(Lib_StringLib.StringLib.StringFilter(pGroupKeyIn[24..31],'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ')) <> '',
	   trim(Lib_StringLib.StringLib.StringFilter(pGroupKeyIn[24..31],'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ')),
	   '00000001'
	  )
 ;