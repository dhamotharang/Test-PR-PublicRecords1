import MXD_Common;

MXD_Common.Layouts_Salt_Ingest.Base_Slim trfToSaltLayout(MXD_MXDocket.Layouts_build.base pInput)	:=	TRANSFORM
		lastname 						:=(string)UnicodeLib.UnicodeFindReplace(pInput.lastname,u'Ã‘',u'N');
		unparsedname 				:= (string)UnicodeLib.UnicodeFindReplace(pInput.full_name,u'Ã‘',u'N');
		cleanunparsedname 	:=if (TRANSFER(unparsedname[1],unsigned1) > 32, unparsedname, '');
		cleanorgname 				:= if (pInput.partyType!=1,(string)mxd_Common.FN_NormOrgData((unicode)pInput.orgName),cleanunparsedname);
											
		unparsed 						:=TRIM(pInput.firstname)=u'' and TRIM(pInput.lastname)=u'' and TRIM(pInput.matronymic)=u''
																and TRIM(pInput.full_name) != u'';
														
		SELF.rec_type 			:= mxd_Common.Layouts.SourceType.DOCKET;
		SELF.party_id 			:= (integer)pInput.partyNumber;
		SELF.orig_rec_id 		:= pInput.rec_id;	//carry the orignial rec_id for later										
		SELF.rec_id 				:= pInput.person_id;	//rec id is not unique person identifier--multiple people per record										
		SELF.firstname 			:= (string)UnicodeLib.UnicodeFindReplace(pInput.firstname,u'Ã‘',u'N');
		SELF.middlename1		:= (string)UnicodeLib.UnicodeFindReplace(pInput.middlename1,u'Ã‘',u'N');
		SELF.middlename2		:= (string)UnicodeLib.UnicodeFindReplace(pInput.middlename2,u'Ã‘',u'N');
		SELF.middlename3		:= (string)UnicodeLib.UnicodeFindReplace(pInput.middlename3,u'Ã‘',u'N');
		SELF.middlename4		:= (string)UnicodeLib.UnicodeFindReplace(pInput.middlename4,u'Ã‘',u'N');
		SELF.middlename5		:= (string)UnicodeLib.UnicodeFindReplace(pInput.middlename5,u'Ã‘',u'N');
		SELF.lastname				:= if (unparsed,cleanorgname,lastname);
		SELF.matronymic			:= (string)UnicodeLib.UnicodeFindReplace(pInput.matronymic,u'Ã‘',u'N');
		SELF.not_parsed			:= IF(unparsed, 'T', 'F');
		SELF.is_org					:= IF(pInput.partyType!=1, 'T', 'F');
		self.geography 			:= StringLib.StringCleanSpaces(TRIM((string)UnicodeLib.UnicodeFindReplace(pInput.geography,u'Ã‘',u'N'),LEFT,RIGHT));
		self.court 					:= StringLib.StringCleanSpaces(TRIM((string)UnicodeLib.UnicodeFindReplace(pInput.court,u'Ã‘',u'N'),LEFT,RIGHT));
		self.caption 				:= StringLib.StringCleanSpaces(TRIM((string)UnicodeLib.UnicodeFindReplace(pInput.caption,u'Ã‘',u'N'),LEFT,RIGHT));
		self.nature 				:= StringLib.StringCleanSpaces(TRIM((string)UnicodeLib.UnicodeFindReplace(pInput.nature,u'Ã‘',u'N'),LEFT,RIGHT));
		self.comment 				:= StringLib.StringCleanSpaces(TRIM((string)UnicodeLib.UnicodeFindReplace(pInput.comment,u'Ã‘',u'N'),LEFT,RIGHT));		
		self								:=	pInput;
end;
	
export FileSaltIngest := 	Project(MXD_MXDocket.FilesBase.Base, trfToSaltLayout(left));