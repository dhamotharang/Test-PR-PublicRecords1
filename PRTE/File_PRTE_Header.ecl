import header;

payload := PRTE.Get_Header_Base.payload;

export File_PRTE_Header:=project(payload,header.Layout_Header);