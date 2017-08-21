import	ut
			 ,cnld_remap
			 ,lib_stringlib;
			 
layouts.cmcprof lTransformIngxToCnldCMCPROF(layouts.ProviderSpecialty pInputL, layouts.ProvIDSpecProfCode pInputR)
	:=
		TRANSFORM
			self.GENNUM			:=	'"I' + INTFORMAT((INTEGER)pInputR.ProviderID, 9, 1) + '"';
			self.PROFCODE		:=	'"' + pInputR.PROFCODE + '"';
			self.TERM_DATE	:=	'2900-01-01 00:00:00';
			self.CREATE_DT	:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.PROFSTAT		:=	'""';
			self.DTSTAMP		:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.PROFPK			:=	'""';
		END
;

SpecProfLkp	:=	DATASET('~thor_200::in::ingenix_remap::providspecprofcode', cnld_remap.layouts.ProvIDSpecProfCode, THOR);

CnldCmcprofRecTmp
	:=
		JOIN(files.ProviderSpecialty, SpecProfLkp,
			left.ProviderID = right.ProviderID AND right.ProviderID != '',
  		lTransformIngxToCnldCMCPROF(LEFT, RIGHT),
   		MANY, INNER
   	)
;

CnldCmcprofRec	:=	CnldCmcprofRecTmp(PROFCODE != '""');

export mapping_cmcprof := CnldCmcprofRec;