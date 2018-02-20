import Corp2, DNB_dmi, YellowPages, Busreg, Edgar, Vickers, infousa, ut, versioncontrol,paw, dnb_feinv2,mdr, std;

use_prod 	:= versioncontrol._Flags.IsDataland;
layYpBase 	:= YellowPages.Layout_YellowPages_Base_V2_Bip;

export BH_BDID_SIC(

	 string																						pBhVersion						= 'qa'
	,dataset(Corp2.Layout_Corporate_Direct_Corp_Base) pCorpFile							= Corp2.Files(,,use_prod).Base.Corp.QA
	,dataset(dnb_dmi.Layouts.Base.CompaniesForBIP2	) pDNB_Base							= DNB_dmi.Files().base.companies.qa
	,dataset(layYpBase															) pYellowpages_Base			= YellowPages.Files(,use_prod).base.qa
	,dataset(BusReg.Layout_BusReg_Company						) pBusregCompany_Base 	= BusReg.File_BusReg_Company
	,dataset(Layout_Business_Header_Base						) pBusinessHeader_Base	= Business_Header.Files(pBhVersion, use_prod).Base.Business_Headers.new
	,dataset(Edgar.Layout_Edgar_Company							) pEdgar_Base						= Edgar.File_Edgar_Company_Base
	,dataset(Vickers.Layout_Insider_Security_In			) pVickersSecurity_Base = Vickers.File_Insider_Security_In
	,dataset(Vickers.layout_13d13g_base							) pVickers13D13G_Base		= Vickers.File_13d13g_Base
	,dataset(InfoUSA.Layout_ABIUS_Company_Base			) pInfousaAbius_Base		= InfoUSA.File_ABIUS_Company_Base
	,dataset(DNB_FEINv2.layout_DNB_fein_base_main		) pDNB_FEINV2_Base			= DNB_FEINV2.File_DNB_Fein_base_main
	,boolean																					pShouldFilter					= true
	,boolean																					pShouldPersist				= true
	,string																						pPersistname					= persistnames().BHBDIDSIC
	,boolean																					pUseDatasets					= false
	,dataset(corp2.Layout_Corporate_Direct_Corp_Base)	pInactiveCorps 				= paw.fCorpInactives()
	
	
) := 
function


mac_sic_test(sic) := macro
map(length(trim(sic)) = 3 => '0' + trim(sic) + '0000',
    length(trim(sic)) = 4 => trim(sic) + '0000',
    length(trim(sic)) = 5 => trim(sic) + '000',
    length(trim(sic)) = 6 => trim(sic) + '00',
    sic)
endmacro;

// Extract SIC codes from Corporate Information
Layout_SIC_Code_Internal SICFromCorp(Corp2.Layout_Corporate_Direct_Corp_Base l) := transform
self.source := 'C';
self.sic_code := mac_sic_test(l.corp_sic_code);
self := l;
end;

corp_sic_init := project(pCorpFile(bdid <> 0, corp_sic_code <> ''), SICFromCorp(left));
corp_sic_dedup := dedup(corp_sic_init, all);

// Extract SIC codes from Dun & Bradstreet
Layout_SIC_Code_Internal SICFromDNB(DNB_dmi.Layouts.Base.CompaniesForBIP2 l, unsigned1 cnt) := transform
self.source := 'D';
self.dt_last_seen := (unsigned6)l.date_last_seen;
self.sic_code := choose(cnt,
mac_sic_test(l.rawfields.sic1a),
mac_sic_test(l.rawfields.sic1b),
mac_sic_test(l.rawfields.sic1c),
mac_sic_test(l.rawfields.sic1d),
mac_sic_test(l.rawfields.sic2),
mac_sic_test(l.rawfields.sic2a),
mac_sic_test(l.rawfields.sic2b),
mac_sic_test(l.rawfields.sic2c),
mac_sic_test(l.rawfields.sic2d),
mac_sic_test(l.rawfields.sic3),
mac_sic_test(l.rawfields.sic3a),
mac_sic_test(l.rawfields.sic3b),
mac_sic_test(l.rawfields.sic3c),
mac_sic_test(l.rawfields.sic3d),
mac_sic_test(l.rawfields.sic4),
mac_sic_test(l.rawfields.sic4a),
mac_sic_test(l.rawfields.sic4b),
mac_sic_test(l.rawfields.sic4c),
mac_sic_test(l.rawfields.sic4d),
mac_sic_test(l.rawfields.sic5),
mac_sic_test(l.rawfields.sic5a),
mac_sic_test(l.rawfields.sic5b),
mac_sic_test(l.rawfields.sic5c),
mac_sic_test(l.rawfields.sic5d),
mac_sic_test(l.rawfields.sic6),
mac_sic_test(l.rawfields.sic6a),
mac_sic_test(l.rawfields.sic6b),
mac_sic_test(l.rawfields.sic6c),
mac_sic_test(l.rawfields.sic6d),
'');           
self := l;
end;

dnb_sic_init := normalize(pDNB_Base(bdid <> 0), 30, SICFromDNB(left, counter));
dnb_sic_dedup := dedup(dnb_sic_init(sic_code <> ''), all);


// Extract SIC codes from Yellow Pages
Layout_SIC_Code_Internal SICFromYP(layYpBase l) := transform
self.source := 'Y';
self.sic_code := mac_sic_test(l.sic_code);
self.dt_last_seen := (unsigned4)l.pub_date;
self := l;
end;

yp_sic_init := project(pYellowpages_Base(bdid <> 0, sic_code <> ''), SICFromYP(left));
yp_sic_dedup := dedup(yp_sic_init, all);


// Extract SIC Codes from Business Registrations
Layout_SIC_Code_Internal SICFromBusreg(Busreg.Layout_BusReg_Company l) := transform
self.source := 'BR';
self.sic_code := l.sic + '0000';
self.dt_last_seen := (unsigned4)l.dt_last_seen;
self := l;
end;

busreg_sic_init := project(pBusregCompany_Base(bdid <> 0, sic <> ''), SICFromBusreg(left));
busreg_sic_dedup := dedup(busreg_sic_init, all);


layout_cik := record
unsigned6 bdid;
string20 cikcode;
end;

layout_cik CIKfromBH(Business_Header.Layout_Business_Header_Base l) := transform
self.cikcode := l.source_group;
self := l;
end;

edgar_cik_init := project(pBusinessHeader_Base(mdr.sourcetools.sourceisEdgar(source)), CIKFromBH(left));
edgar_cik_dist := distribute(edgar_cik_init, hash(cikcode));
edgar_base_dist := distribute(pEdgar_Base(sicCode <> ''), hash(cikcode));

Layout_SIC_Code_Internal SICFromEdgar(Edgar.Layout_Edgar_Company l, layout_cik r) := transform
self.source := 'E';
self.sic_code := mac_sic_test(l.sicCode);
self.bdid := r.bdid;
self.dt_last_seen := 20050425;
end;

edgar_sic_init := join(edgar_base_dist,
                       edgar_cik_dist,
					   left.cikcode = right.cikcode,
                       SICFromEdgar(left, right),
					   local);
					   
edgar_sic_dedup := dedup(edgar_sic_init,all);

	///////////////////////////////////////////////////////////////////
	// Extract SIC Codes from Vickers Data
	///////////////////////////////////////////////////////////////////

	// -- Get business header vicker records, dedup on bdid, cusip
	layout_cusip := record
	unsigned6 bdid;
	string15 cusip;
	end;

	layout_cusip CusipfromBH(Business_Header.Layout_Business_Header_Base l) := transform
	self.cusip := l.vendor_id[1..(Stringlib.StringFind(l.vendor_id, ',', 1) - 1)];
	self := l;
	end;

	vickers_cusip_init := project(pBusinessHeader_Base(source = 'V', vendor_id <> ''), CusipfromBH(left));
	vickers_cusip_dedup := dedup(vickers_cusip_init, all);
	vickers_cusip_dist := distribute(vickers_cusip_dedup, hash(cusip));

	// -- Get vickers Insider Security records, dedup on cusip, sic_code
	layout_vickers_temp := record
	string15 cusip;
	string8  sic_code;
	unsigned6 dt_last_seen;
	end;

	layout_vickers_temp InitVickers(Vickers.Layout_Insider_Security_In l,Vickers.layout_13d13g_base r) := transform
	self.sic_code := trim(l.sic_code) + '0000';
	self.dt_last_seen := (unsigned4)r.upd_date;
	self := l;
	end;

	vickers_init := join(pVickersSecurity_Base(cusip <> '', sic_code <> '')
											,pVickers13D13G_Base(cusip <> '')
											,left.cusip = right.cusip
											,InitVickers(left,right)
											,local
											);
	vickers_dedup := dedup(vickers_init(length(trim(sic_code)) = 8), all);
	vickers_dist := distribute(vickers_dedup, hash(cusip));

	// -- Join Vickers Insider Security to business header vickers records on cusip, get bdid, then dedup
	Layout_SIC_Code_Internal SICFromVickers(layout_vickers_temp l, layout_cusip r) := transform
	self.source := 'V';
	self.sic_code := l.sic_code;
	self.bdid := r.bdid;
	self.dt_last_seen := l.dt_last_seen;
	end;

	vickers_sic_init := join(vickers_dist,
													 vickers_cusip_dist,
								 left.cusip = right.cusip,
													 SICFromVickers(left, right),
								 local);
							 
	vickers_sic_dedup := dedup(sort(vickers_sic_init, source,sic_code, bdid,-dt_last_seen), source,sic_code, bdid,all);

///////////////////////////////////////////////////////////////////
// Extract SIC codes from INFOUSA
///////////////////////////////////////////////////////////////////
Layout_SIC_Code_Internal SICFromINFOUSACOMPANY(infousa.Layout_ABIUS_Company_Base l, unsigned1 cnt) := transform
	self.source := 'IA';
	self.sic_code := choose(cnt, 	mac_sic_test(l.PRIMARY_SIC),
							mac_sic_test(l.SECONDARY_SIC_1),
							mac_sic_test(l.SECONDARY_SIC_2),
							mac_sic_test(l.SECONDARY_SIC_3),
							mac_sic_test(l.SECONDARY_SIC_4),
						'');
	self.dt_last_seen := ((UNSIGNED4)L.DATE_ADDED) * 100;
	self := l;
end;

iacompany_sic_init := normalize(pInfousaAbius_Base(bdid <> 0), 5, SICFromINFOUSACOMPANY(left, counter));
iacompany_sic_dedup := dedup(sort(iacompany_sic_init(sic_code <> ''), source,sic_code, bdid,-dt_last_seen), source,sic_code, bdid, all);

///////////////////////////////////////////////////////////////////
// Extract SIC codes from DNB_FEINV2
///////////////////////////////////////////////////////////////////
Layout_SIC_Code_Internal SICFromDnb_FeinV2(DNB_FEINv2.layout_DNB_fein_base_main l) := transform
self.source := 'DN';
self.sic_code := mac_sic_test(l.sic_code);
self.bdid := (unsigned6) l.bdid;
self.dt_last_seen := (unsigned4) l.date_last_seen;
self := l;
end;

dnb_feinv2_sic_init := project(pDNB_FEINV2_Base((integer) bdid <> 0, sic_code <> ''), SICFromDnb_FeinV2(left));
dnb_feinv2_sic_dedup := dedup(dnb_feinv2_sic_init, all);

/////////////////////////////////////////////////////////////////
//removed dnb sic codes for permissioning reasons
sic_combined := corp_sic_dedup + dnb_sic_dedup + yp_sic_dedup + busreg_sic_dedup + edgar_sic_dedup + vickers_sic_dedup + iacompany_sic_dedup + dnb_feinv2_sic_dedup;
sic_filtered := Business_Header.Filters.BHBDIDSIC(sic_combined,pInactiveCorps,pBhVersion);

	sic_filtered2				:= if(pShouldFilter = true, sic_filtered, sic_combined)(bdid <> 0, length(trim(sic_code)) = 8) ;
	eight_years_ago 		:= (unsigned4)((string)((unsigned)((STRING8)Std.Date.Today())[1..4] - 8) + ((STRING8)Std.Date.Today())[5..]);
	sic_deduped					:= dedup(sort(sic_filtered2, source,sic_code, bdid,-dt_last_seen), source,sic_code, bdid,all)(dt_last_seen > eight_years_ago);
	
	sic_proj						:= project(sic_deduped, transform(layout_sic_code, self := left));
	sic_proj_persisted 	:= sic_proj : persist(pPersistname);
	returnresult				:= if(pShouldPersist,sic_proj_persisted,sic_proj);
	

	return if(pUseDatasets
						,dataset(pPersistname,Layout_SIC_Code,flat)
						,returnresult
				);

end;