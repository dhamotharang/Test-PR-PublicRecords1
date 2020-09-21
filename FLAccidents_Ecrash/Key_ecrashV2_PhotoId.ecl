IMPORT STD;

ds_PhotoBase := Files.Base.PhotoBase;

ds_SupplementalBase := Files.Base.Supplemental(TRIM(Report_Type_Id, LEFT, RIGHT) IN ['A','DE'] OR
                                               STD.Str.ToUpperCase(TRIM(Vendor_Code, LEFT, RIGHT)) = 'CMPD');
d_SupplementalBase := DISTRIBUTE(ds_SupplementalBase, HASH32(Super_Report_Id));
ds_SuperReport := DEDUP(SORT(d_SupplementalBase, Super_Report_Id, Report_Id, LOCAL), Super_Report_Id, Report_Id, LOCAL);

Layout_Keys_eCrash.PhotoId trans_PhotoSuperReport(ds_PhotoBase l, ds_SuperReport r):= TRANSFORM
	SELF.Super_Report_Id := r.Super_Report_Id;
	SELF.Document_ID := l.Document_ID;
	SELF.Report_Type := l.Report_Type;
	SELF.Incident_ID := l.Incident_ID;
	SELF.Document_Hash_Key := l.Document_Hash_Key;
	SELF.Date_Created := l.Date_Created;
	SELF.Is_Deleted := l.Is_Deleted;
	SELF.Page_Count := l.Page_Count;
	SELF.Extension := l.Extension;
	SELF.Report_Source := l.Report_Source;
	SELF := l;
	SELF := [];
END;
ds_PhotoSuperCmbnd	:= JOIN(ds_PhotoBase, ds_SuperReport,
														TRIM(LEFT.Incident_Id, LEFT, RIGHT) = TRIM(RIGHT.Incident_Id, LEFT, RIGHT),
														trans_PhotoSuperReport(LEFT, RIGHT), HASH);

EXPORT Key_ecrashV2_PhotoId := INDEX(ds_PhotoSuperCmbnd,
                                     {Super_Report_Id, Document_id, Report_Type},
							                       {ds_PhotoSuperCmbnd},
							                       Files_eCrash.FILE_KEY_PHOTO_ID_SF);
																		
																		