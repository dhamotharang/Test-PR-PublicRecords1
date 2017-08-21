import ut, cnld_remap, ingenix_natlprof;

layout_sanc_DID_slim
	:=
		RECORD
			string12	did;
			string		SANC_UPIN;
			string		SANC_ID;
		END
;

layout_sanc_DID_slim lTransformSlimSancDID(ingenix_natlprof.layout_sanctions_did_file pInput)
	:=
		TRANSFORM
			self.did				:=	pInput.did;
			self.SANC_UPIN	:=	pInput.SANC_UPIN;
			self.SANC_ID		:=	pInput.SANC_ID;
		END
;

pSancDIDSlim		:=	PROJECT(File_Sanctions_Cleaned_DIDed_dates(did != ''), lTransformSlimSancDID(left));
distSancDIDSlim	:=	DISTRIBUTE(pSancDIDSlim, HASH(did));
ddSancDIDSlim		:=	DEDUP(distSancDIDSlim, ALL, LOCAL);

layout_prov_DID_slim
	:=
		RECORD
			string12	did;
			string		UPIN;
			string		ProviderID;
		END
;

layout_prov_DID_slim lTransformSlimProvDID(ingenix_natlprof.Layout_provider_base pInput)
	:=
		TRANSFORM
			self.did					:=	pInput.did;
			self.UPIN					:=	'';
			self.ProviderID		:=	pInput.ProviderID;
		END
;

pProvDIDSlim1			:=	PROJECT(ingenix_natlprof.Basefile_Provider_Did(did != ''), lTransformSlimProvDID(left));
distProvDIDSlim1	:=	DISTRIBUTE(pProvDIDSlim1, HASH(did));
ddProvDIDSlim1		:=	DEDUP(distProvDIDSlim1, ALL, LOCAL);

layout_prov_DID_slim lAddUPINtoProvDIDSlim(ddProvDIDSlim1 pInputL, cnld_remap.Basefile_providerUPIN pInputR)
	:=
		TRANSFORM
			self.UPIN	:=	pInputR.UPIN;
			self			:=	pInputL;
		END
;

pProvDIDSlim
	:=
		JOIN(ddProvDIDSlim1, cnld_remap.Basefile_providerUPIN,
			left.ProviderID = right.ProviderID,
  		lAddUPINtoProvDIDSlim(LEFT, RIGHT),
   		MANY, LEFT OUTER, LOCAL
   	)
;

distProvDIDSlim	:=	DISTRIBUTE(pProvDIDSlim, HASH(did));
ddProvDIDSlim		:=	DEDUP(distProvDIDSlim, ALL, LOCAL);

layout_prov_sanc_DID_lkp
	:=
		RECORD
			string12	did;
			string		ProviderID;
			string		UPIN;
			string		SANC_ID;
			string		SANC_UPIN;
		END
;

layout_prov_sanc_DID_lkp	lJoinProvSlimToSancSlim(ddProvDIDSlim pInputL, ddSancDIDSlim pInputR)
	:=
		TRANSFORM
			self.did				:=	pInputL.did;
			self.ProviderID	:=	pInputL.ProviderID;
			self.UPIN				:=	pInputL.UPIN;
			self.SANC_ID		:=	pInputR.SANC_ID;
			self.SANC_UPIN	:=	pInputR.SANC_UPIN;
		END
;

join_prov_sanc_DID_lkp
	:=
		JOIN(ddProvDIDSlim, ddSancDIDSlim,
			left.did = right.did,
  		lJoinProvSlimToSancSlim(LEFT, RIGHT),
   		MANY, LEFT OUTER, LOCAL
   	)
;

prov_sanc_DID_lkp	:=	DEDUP(join_prov_sanc_DID_lkp, ALL);

// export proc_create_prov_sanc_DID_lkp := distProvDIDSlim;

export proc_create_prov_sanc_DID_lkp := prov_sanc_DID_lkp
	:PERSIST('~thor_200::ingenix::in::prov_sanc_DID_lkp');