#workunit('name', 'Build Yellow Pages Out File ' + yellowpages.YellowPages_Build_Date);

// Output YellowPages File
YellowPages.Layout_YellowPages_Out FormatYPOutput(YellowPages.Layout_YellowPages_Base L) := TRANSFORM
SELF.bdid := IF(L.bdid <> 0, INTFORMAT(L.bdid, 12, 1), '');
SELF := L;
END;

YellowPages_Out := PROJECT(YellowPages.File_YellowPages_Base, FormatYPOutput(LEFT));

OUTPUT(YellowPages_Out,,'OUT::YellowPages_' + YellowPages.YellowPages_Build_Date, OVERWRITE);