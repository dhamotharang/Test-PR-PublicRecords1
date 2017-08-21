export mac_hash_slimsort(arg1,arg2=' ',arg3 = ' ',
		arg4 = ' ',arg5 = ' ',arg6 = ' ',arg7 = ' ' ,
		arg8 = ' ',arg9 = ' ',arg10 = ' ') := macro

hash64(
trim((string)arg1)+ trim((string)arg2)+
trim((string)arg3)+ trim((string)arg4)+
trim((string)arg5)+ trim((string)arg6)+
trim((string)arg7)+ trim((string)arg8)+
trim((string)arg9)+ trim((string)arg10)
)


endmacro;