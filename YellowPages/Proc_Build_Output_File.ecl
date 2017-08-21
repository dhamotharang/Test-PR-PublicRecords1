import ut;

YellowPages.Layout_YellowPages_Out FormatYPOutput(YellowPages.Layout_YellowPages_Base_V2 L) := 
TRANSFORM
	SELF.bdid	:= IF(L.bdid <> 0, INTFORMAT(L.bdid, 12, 1), '');
	SELF		:= L;
END;

YellowPages_Out := PROJECT(Files.Base.QA, FormatYPOutput(LEFT));

ut.MAC_SF_Build_standard(YellowPages_Out,	Filenames.Out.Template,	Build_Out,	YellowPages_Build_Date, false);

export Proc_Build_Output_File := Build_Out;