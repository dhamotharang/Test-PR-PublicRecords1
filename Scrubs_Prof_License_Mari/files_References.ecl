IMPORT	Prof_License_Mari,	ut;
EXPORT	files_References	:=	MODULE

					MARIcmvDispTypeIn		:=	Prof_License_Mari.files_References.MARIcmvDispType;
	EXPORT	MARIcmvDispType			:=	PROJECT(MARIcmvDispTypeIn,TRANSFORM(RECORDOF(LEFT),SELF.disp_desc:=ut.fnTrim2Upper(LEFT.disp_desc);SELF:=LEFT));
					MARIcmvLicStatusIn	:=	Prof_License_Mari.files_References.MARIcmvLicStatus;
	EXPORT	MARIcmvLicStatus		:=	PROJECT(MARIcmvLicStatusIn,TRANSFORM(RECORDOF(LEFT),SELF.status_desc:=ut.fnTrim2Upper(LEFT.status_desc);SELF:=LEFT));
END;
