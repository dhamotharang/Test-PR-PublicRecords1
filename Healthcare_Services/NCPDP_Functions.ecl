Import AutoStandardI;
EXPORT NCPDP_Functions := MODULE
	shared gm:=AutoStandardI.GlobalModule();
	Export cleanOnlyNumbers (string inStr) := function
		return stringlib.stringfilter(inStr,'0123456789');
	end;
	// Shared calcLicPenalty(String inLicense, String outLicense) := Function
		// hasInandOut := inLicense <> '' and outLicense <> '';
		// inClean := cleanOnlyNumbers(inLicense);
		// inCleanVal := (integer)inClean;
		// outClean := cleanOnlyNumbers(outLicense);
		// outCleanVal := (integer)outClean;
		// compareRaw := if(inLicense=outLicense,true,false);
		// compareClean := if(inClean=outClean,true,false);
		// compareCleanVal := if(inCleanVal=outCleanVal,true,false);
		// CompareCombined := compareRaw or compareClean or compareCleanVal;
		// penaltyVal := map(hasInandOut and CompareCombined => 0,
											// hasInandOut => 2,
											// 0);
		// return penaltyVal;
	// end;
	// Shared calcFeinPenalty(String inFEIN, String outFEIN) := Function
		// hasInandOut := inFEIN <> '' and outFEIN <> '';
		// compareRaw := if(inFEIN=outFEIN,true,false);
		// penaltyVal := map(hasInandOut and compareRaw => 0,
											// hasInandOut => 2,
											// 0);
		// return penaltyVal;
	// end;
	// Shared calcNpiPenalty(String inNPI, String outNPI) := Function
		// hasInandOut := inNPI <> '' and outNPI <> '';
		// compareRaw := if(inNPI=outNPI,true,false);
		// penaltyVal := map(hasInandOut and compareRaw => 0,
											// hasInandOut => 2,
											// 0);
		// return penaltyVal;
	// end;
	// Shared calcDeaPenalty(String inDEA, String outDEA) := Function
		// hasInandOut := inDEA <> '' and outDEA <> '';
		// compareRaw := if(inDEA=outDEA,true,false);
		// penaltyVal := map(hasInandOut and compareRaw => 0,
											// hasInandOut => 2,
											// 0);
		// return penaltyVal;
	// end;
	Export doPenalty (dataset(NCPDP_Layouts.LayoutOutput) outRecs, dataset(NCPDP_Layouts.autokeyInput) input, integer maxPenalty = NCPDP_Constants.defaultPenalty) := function
		//Custom penalty logic
		outRec := NCPDP_Layouts.LayoutOutput;

		outRec xform(outRec l, NCPDP_Layouts.autokeyInput r) := transform
					modCName := MODULE(AutoStandardI.LIBIN.PenaltyI_Biz_Name.full)
						EXPORT allow_wildcard := FALSE;
						EXPORT isPRP := FALSE;
						EXPORT scorethreshold := maxPenalty;
						EXPORT useGlobalScope := FALSE;
						EXPORT county := '';
						EXPORT asisname := '';
						EXPORT cn := '';
						EXPORT company := '';
						EXPORT companyname := r.comp_name;
						EXPORT corpname := '';
						EXPORT nameasis := '';
						EXPORT cname_field := l.legal_business_name;
					END;
					modDBAName := MODULE(AutoStandardI.LIBIN.PenaltyI_Biz_Name.full)
						EXPORT allow_wildcard := FALSE;
						EXPORT isPRP := FALSE;
						EXPORT scorethreshold := maxPenalty;
						EXPORT useGlobalScope := FALSE;
						EXPORT county := '';
						EXPORT asisname := '';
						EXPORT cn := '';
						EXPORT company := '';
						EXPORT companyname := r.comp_name;
						EXPORT corpname := '';
						EXPORT nameasis := '';
						EXPORT cname_field := l.DBA;
					END;
					modLocAddr := MODULE(AutoStandardI.LIBIN.PenaltyI_Addr.full)
						EXPORT allow_wildcard := FALSE;
						EXPORT isPRP := FALSE;
						EXPORT scorethreshold := maxPenalty;
						EXPORT useGlobalScope := FALSE;
						EXPORT county := '';
						EXPORT addr := '';
						EXPORT prim_range := r.prim_range;
						EXPORT primrange := '';
						EXPORT predir := r.predir;
						EXPORT prim_name := r.prim_name;
						EXPORT primname := '';
						EXPORT street_name := '';
						EXPORT suffix := '';
						EXPORT postdir := r.postdir;
						EXPORT sec_range := r.sec_range;
						EXPORT secrange := '';
						EXPORT statecityzip := '';
						EXPORT city := r.p_city_name;
						EXPORT othercity1 := '';
						EXPORT st := r.st;
						EXPORT st_orig := '';
						EXPORT state := '';
						EXPORT otherstate1 := '';
						EXPORT otherstate2 := '';
						EXPORT z5 := r.z5;
						EXPORT zip := '';
						EXPORT mileradius := 0;
						EXPORT zipradius := 0;
						EXPORT prange_field := l.Phys_prim_range;
						EXPORT predir_field := l.Phys_predir;
						EXPORT pname_field := l.Phys_prim_name;
						EXPORT suffix_field := l.Phys_addr_suffix;
						EXPORT postdir_field := l.Phys_postdir;
						EXPORT city_field := l.Phys_p_city_name;
						EXPORT city2_field := '';
						EXPORT state_field := l.Phys_state;
						EXPORT zip_field := l.Phys_zip5;
					END;
					modMailAddr := MODULE(AutoStandardI.LIBIN.PenaltyI_Addr.full)
						EXPORT allow_wildcard := FALSE;
						EXPORT isPRP := FALSE;
						EXPORT scorethreshold := maxPenalty;
						EXPORT useGlobalScope := FALSE;
						EXPORT county := '';
						EXPORT addr := '';
						EXPORT prim_range := r.prim_range;
						EXPORT primrange := '';
						EXPORT predir := r.predir;
						EXPORT prim_name := r.prim_name;
						EXPORT primname := '';
						EXPORT street_name := '';
						EXPORT suffix := '';
						EXPORT postdir := r.postdir;
						EXPORT sec_range := r.sec_range;
						EXPORT secrange := '';
						EXPORT statecityzip := '';
						EXPORT city := r.p_city_name;
						EXPORT othercity1 := '';
						EXPORT st := r.st;
						EXPORT st_orig := '';
						EXPORT state := '';
						EXPORT otherstate1 := '';
						EXPORT otherstate2 := '';
						EXPORT z5 := r.z5;
						EXPORT zip := '';
						EXPORT mileradius := 0;
						EXPORT zipradius := 0;
						EXPORT prange_field := l.Mail_prim_range;
						EXPORT predir_field := l.Mail_predir;
						EXPORT pname_field := l.Mail_prim_name;
						EXPORT suffix_field := l.Mail_addr_suffix;
						EXPORT postdir_field := l.Mail_postdir;
						EXPORT city_field := l.Mail_p_city_name;
						EXPORT city2_field := '';
						EXPORT state_field := l.Mail_state;
						EXPORT zip_field := l.Mail_zip5;
					END;
					cNamePenalty := AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(modCName);
					dbaPenalty := AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(modDBAName);
					locAddrPenalty := AutoStandardI.LIBCALL_PenaltyI_Addr.val(modLocAddr);
					mailAddrPenalty := AutoStandardI.LIBCALL_PenaltyI_Addr.val(modMailAddr);
					minNamePen := if(cNamePenalty<dbaPenalty,cNamePenalty,dbaPenalty);
					minAddrPen := if(locAddrPenalty<mailAddrPenalty,locAddrPenalty,mailAddrPenalty);
					// stlicPen := calcLicPenalty(r.license_state, l.state_license_number);
					// feinPen := calcFeinPenalty(r.FEIN, l.federal_tax_id);
					// npiPen := calcNpiPenalty(r.NPI, l.national_provider_id);
					// deaPen := calcDeaPenalty(r.DEA, l.DEA_registration_id);
					self.compName_penalty := cNamePenalty;
					self.dbaName_penalty := dbaPenalty;
					self.locAddr_penalty := locAddrPenalty;
					self.mailAddr_penalty := mailAddrPenalty;
					// self.lic_penalty := stlicPen+feinPen+npiPen+deaPen;
					self.record_penalty := minNamePen+minAddrPen;//+stlicPen+feinPen+npiPen+deaPen;
					self.isProviderIDMatch := l.isProviderIDMatch or (r.NCPDP_providerid<>'' and l.NCPDP_provider_id = r.NCPDP_providerid);
					// self.isDEAMatch := l.isDEAMatch or (r.dea <>'' and l.dea_registration_id = r.dea);
					// self.isNPI := l.isNPI or (r.npi<>'' and l.national_provider_id = r.npi);
					// self.isFEINMatch := l.isFEINMatch or (r.fein <> '' and l.federal_tax_id = r.fein);
					// self.isLicMatch := l.isLicMatch or (l.state_license_number <> '' and r.license_state <> '' and stlicPen = 0);
					self.isDIDMatch := l.isDIDMatch or (r.did>0 and l.did=r.did);
					self.isBDIDMatch := l.isBDIDMatch or (r.bdid>0 and l.bdid=r.bdid);
					self :=l;
					self:=[];
		end;
		recsWithPenalty := join(outRecs,input,left.acctno=right.acctno,xform(left,right));
		//Not including FEIN because there could be many record that match a taxid and I want the record with the best penalty to come to the top.
		removeOverPenalty := recsWithPenalty(record_penalty<=maxPenalty or isProviderIDMatch or isDEAMatch or isNPI or isLicMatch or isDIDMatch  or isBDIDMatch);		
		sortRecs := sort(removeOverPenalty,acctno,record_penalty);
// Not sure I need a dedup yet.		dedupRecs := dedup(sortRecs, acctno,srcid,src);
		return sortRecs;
	end;
end;
