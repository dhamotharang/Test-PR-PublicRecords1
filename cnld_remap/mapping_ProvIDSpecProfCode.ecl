import	ut
			 ,cnld_remap
			 ,lib_stringlib;

layouts.ProvIDSpecProfCode lProviderIDtoCodeLkp(layouts.ProviderSpecialty pInput)
	:=
		TRANSFORM
			self.ProviderID				:=	pInput.ProviderID;
			self.SpecialtyGroupID	:=	'';
			self.SpecialtyID			:=	pInput.SpecialtyID;
			self.SPEC_CODE				:=	'';
			self.PROFCODE					:=	'';
		END
;

pCnldProvIDSpecProfCodeRec1		:=	PROJECT(files.ProviderSpecialty, lProviderIDtoCodeLkp(left));

layouts.ProvIDSpecProfCode lSpecialtyGroupIDtoCodeLkp(pCnldProvIDSpecProfCodeRec1 pInputL, files.Specialty pInputR)
	:=
		TRANSFORM
			self.SpecialtyGroupID	:=	pInputR.SpecialtyGroupID;
			self									:=	pInputL;
		END
;

CnldProvIDSpecProfCodeRec2
	:=
		JOIN(pCnldProvIDSpecProfCodeRec1,  files.Specialty,
			left.SpecialtyID = right.SpecialtyID,
  		lSpecialtyGroupIDtoCodeLkp(LEFT, RIGHT),
   		MANY LOOKUP, LEFT OUTER
   	)
;

layouts.ProvIDSpecProfCode lSpecProftoCodeLkp(CnldProvIDSpecProfCodeRec2 pInputL, files.SpecialtyToProfCode pInputR)
	:=
		TRANSFORM
			self.SPEC_CODE	:=	pInputR.SpecCode;
			self.PROFCODE		:=	pInputR.PossibleProfession;
			self						:=	pInputL;
		END
;

CnldProvIDSpecProfCodeRec3
	:=
		JOIN(CnldProvIDSpecProfCodeRec2,  files.SpecialtyToProfCode,
			left.SpecialtyID = right.SpecialtyID AND left.SpecialtyGroupID = right.SpecialtyGroupID,
  		lSpecProftoCodeLkp(LEFT, RIGHT),
   		MANY LOOKUP, LEFT OUTER
   	)
;

SpecProfLkp	:=	OUTPUT(CnldProvIDSpecProfCodeRec3,, '~thor_200::in::ingenix_remap::providspecprofcode', OVERWRITE);
export mapping_ProvIDSpecProfCode := SpecProfLkp;