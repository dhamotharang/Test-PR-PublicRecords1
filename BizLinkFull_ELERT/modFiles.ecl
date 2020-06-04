
IMPORT STD AS pkgSTD;
IMPORT BipV2;

EXPORT modFiles(STRING sInPrefix = '') := MODULE 
  //Superfiles
  EXPORT dSamples := DATASET(BizLinkFull_ELERT.modFilenames(sInPrefix).kSamplesSF.current,BizLinkFull_ELERT.modLayouts.lSampleLayout,THOR);
  EXPORT dOrigResults := DATASET(BizLinkFull_ELERT.modFilenames(sInPrefix).kOrigRunResultsSF.current,BizLinkFull_ELERT.modLayouts.lSampleLayout,THOR);
  EXPORT dNewResults := DATASET(BizLinkFull_ELERT.modFilenames(sInPrefix).kNewRunResultsSF.current,BizLinkFull_ELERT.modLayouts.lSampleLayout,THOR);
  EXPORT dStats := DATASET(BizLinkFull_ELERT.modFilenames(sInPrefix).kStatsSF.current,BizLinkFull_ELERT.modLayouts.lStatsRec,THOR);
	
  //Change names here to match your data and headers. -ZRS 4/8/2019    
  //Sources

	SHARED rec_api := record
		string acctno;
		string APi_Account_Number;
		string APi_Company_Name;
		string Taxid;
		string LN_seleid;
		string LN_best_fein;
		string LN_fein_var1;
		string LN_fein_var2;
		string LN_fein_var3;
		string LN_fein_var4;
		string LN_fein_var5;
		string LN_fein_var6;
		string LN_fein_var7;
		string LN_fein_var8;
		string LN_fein_var9;
		string LN_did;
		string prim_range_cln;
		string predir_cln;
		string prim_name_cln;
		string suffix_cln;
		string postdir_cln;
		string unit_desig_cln;
		string sec_range_cln;
		string p_city_name_cln;
		string st_cln;
		string z5_cln;
		string z4_cln;
		string cleanPhone;
		string cleanSSN;
		string LN_ssn;
		string name_first_cln;
		string name_middle_cln;
		string name_last_cln;
		string name_suffix_cln;
	end;

    shared sampleDataInputLayout := record
        unsigned6 proxid;
        unsigned6 seleid;
        unsigned6 orgid;
        unsigned6 ultid;
        unsigned6 empid;
        unsigned6 powid;
        unsigned6 dotid;
        unsigned6 parent_proxid;
        unsigned6 sele_proxid;
        unsigned6 org_proxid;
        unsigned6 ultimate_proxid;
        boolean has_lgid;
        string120 company_name;
        string5 title;
        string20 fname;
        string20 mname;
        string20 lname;
        string5 name_suffix;
        string1 iscontact;
        string9 contact_ssn;
        string60 contact_email;
        string10 prim_range;
        string2 predir;
        string28 prim_name;
        string4 addr_suffix;
        string2 postdir;
        string10 unit_desig;
        string8 sec_range;
        string25 p_city_name;
        string25 v_city_name;
        string2 st;
        string5 zip;
        string4 zip4;
        string3 fips_county;
        string2 source;
        unsigned4 dt_first_seen;
        unsigned4 dt_last_seen;
        unsigned4 dt_vendor_last_reported;
        unsigned6 company_bdid;
        string9 company_fein;
        string9 active_duns_number;
        string10 company_phone;
        string1 phone_type;
        string80 company_url;
        string8 company_sic_code1;
        string50 company_status_derived;
        string34 vl_id;
        unsigned8 source_record_id;
        string100 source_docid;
        unsigned6 contact_did;
        string30 contact_email_domain;
        string50 contact_job_title_derived;
        string4 err_stat;
        boolean is_sele_level;
        boolean is_org_level;
        boolean is_ult_level;
        unsigned6 rcid;
        string1 address_type_derived;
    END;

	EXPORT fGetBase(unsigned iBuildDate=0, DATASET(modLayouts.profileRec) dProfile, boolean bUseForeign=false, iNumSamples=10000) := FUNCTION
        prefix := if(bUseForeign, '~foreign::prod_dali.br.seisint.com::', '~');
        iTimeStamp := IF(iBuildDate<>0,iBuildDate,(UNSIGNED)(StringLib.StringFilterOut(pkgSTD.Date.SecondsToString(pkgSTD.Date.CurrentSeconds(FALSE), '%F%H%M%S%u'), '-')[1..14])) : GLOBAL;
    
        // USING THE ACTUAL FILENAME SO WE ALWAYS USE A LOCAL COPY FOR THIS. ONLY PAIN COMES FROM PULLING IT REMOTELY!!
		// dHeaderSources := PROJECT(BIPV2.CommonBase.ds_built, TRANSFORM(BIPV2.CommonBase.Layout, SELF:=LEFT, SELF:=[]));
		dHeaderSources := PROJECT(dataset('~thor_data400::bipv2::internal_linking::built', BIPV2.CommonBase_mod.Layout, thor), TRANSFORM(BIPV2.CommonBase.Layout, SELF:=LEFT, SELF:=[]));
        
        headerClean := BIPV2.CommonBase.clean(dHeaderSources);//removes ghost records, same filter as ds_clean file which is not copied in dataland

        dTopBusinessRead := DATASET(prefix + 'thor::bipheader::qa::topBusiness', sampleDataInputLayout, THOR);
		dTopBusiness := PROJECT(dTopBusinessRead,
		                        TRANSFORM(BIzLinkFull_ELERT.modLayouts.lSrcLayout, 
                                          self.src_category := left.source,
                                          self.rid := left.rcid,
                                          self.city := left.p_city_name,
                                          self.state := left.st,
                                          self.zip5 := left.zip,
                                          self.phone10 := left.company_phone,
                                          self.fein := left.company_fein,
                                          self.url := left.company_url,
                                          self.email := left.contact_email,
                                          self.contact_fname := left.fname,
                                          self.contact_mname := left.mname,
                                          self.contact_lname := left.lname,
                                          self.sic_code := left.company_sic_code1,
                                          SELF := LEFT))(company_name != '' or contact_ssn != '' or prim_name != '' or phone10 != '' or city != '' or fein != '');
        macSourceSampler(dProfile(description = 'Inquiry'), dTopBusiness, topBusinessOut, false, iNumSamples);
		 
	    // inds :=   dataset(prefix + 'bip::prod::batch_jobs::apitoprocessbip.txt', rec_api, csv(heading(1), separator(','), quote('"'), terminator('\r\n')));
	    inds :=   dataset('~bip::prod::batch_jobs::apitoprocessbip.txt', rec_api, csv(heading(1), separator(','), quote('"'), terminator('\r\n')));
		dBatch := PROJECT(inDs, 
                          TRANSFORM(modLayouts.lSrcLayout, 
									SELF.company_name := trim(LEFT.name_first_cln,left,right) + if(trim(LEFT.name_middle_cln,left,right) = '', '', ' ' + trim(LEFT.name_middle_cln,left,right)) + if(trim(LEFT.name_last_cln,left,right) = '', '', ' ' + trim(LEFT.name_last_cln,left,right));
									SELF.prim_range := LEFT.prim_range_cln;
									SELF.prim_name := LEFT.prim_name_cln;
									SELF.zip5 := LEFT.z5_cln;
									SELF.sec_range := LEFT.sec_range_cln;
									SELF.city := LEFT.p_city_name_cln;
									SELF.state := LEFT.st_cln;
									SELF.phone10 := LEFT.cleanphone;
									SELF.fein := if(left.ln_best_fein = '', left.ln_fein_var1, left.ln_best_fein);
									SELF.URL := '';
									SELF.Email := '';
									SELF.Contact_fname := '';
									SELF.Contact_mname := '';
									SELF.Contact_lname := '';
									SELF.zip_radius_miles := 0;
									SELF.sic_code := '';
									SELF.contact_ssn := LEFT.cleanssn;
									SELF.contact_did := (unsigned)LEFT.ln_did;
									SELF.SRC_CATEGORY:='B#';
									SELF :=[]))(company_name != '' or contact_ssn != '' or prim_name != '' or phone10 != '' or city != '' or fein != '');                                
        macSourceSampler(dProfile(description = 'Batch'), dBatch, batchOut, false, iNumSamples);

        dPreFillRead := DATASET(prefix + 'thor::bipheader::qa::prefill_inquiries', sampleDataInputLayout, THOR);
		dPreFill := PROJECT(dPreFillRead,
		                    TRANSFORM(BIzLinkFull_ELERT.modLayouts.lSrcLayout, 
                                      self.src_category := left.source,
                                      self.rid := left.rcid,
                                      self.city := left.p_city_name,
                                      self.state := left.st,
                                      self.zip5 := left.zip,
                                      self.phone10 := left.company_phone,
                                      self.fein := left.company_fein,
                                      self.url := left.company_url,
                                      self.email := left.contact_email,
                                      self.contact_fname := left.fname,
                                      self.contact_mname := left.mname,
                                      self.contact_lname := left.lname,
                                      self.sic_code := left.company_sic_code1,
                                      SELF := LEFT))(company_name != '' or contact_ssn != '' or prim_name != '' or phone10 != '' or city != '' or fein != '');
        macSourceSampler(dProfile(description = 'Inquiry'), dPreFill, preFillOut, false, iNumSamples);
		 
        dSAOTData := project(DATASET('~thor::bipheader::qa::saotDataSample', sampleDataInputLayout, THOR),
                             transform(bizlinkfull_elert.modLayouts.lSrcLayout,
                                       self.src_category := left.source,
                                       self.rid := left.rcid,
                                       self.city := left.p_city_name,
                                       self.state := left.st,
                                       self.zip5 := left.zip,
                                       self.phone10 := left.company_phone,
                                       self.fein := left.company_fein,
                                       self.url := left.company_url,
                                       self.email := left.contact_email,
                                       self.contact_fname := left.fname,
                                       self.contact_mname := left.mname,
                                       self.contact_lname := left.lname,
                                       self.sic_code := left.company_sic_code1,
                                       self := left))(company_name != '' or contact_ssn != '' or prim_name != '' or phone10 != '' or city != '' or fein != '');//src := 'T1','T2','T3','T4','T5'
        macSourceSampler(dProfile(description = 'Inquiry'), dSAOTData, saotOut, false, iNumSamples);

		headerBase := project(headerClean,
                              TRANSFORM(modLayouts.lSrcLayout, 
			                            SELF.SRC_CATEGORY := LEFT.SOURCE;
							  		    SELF.RID     := LEFT.RCID;
							  		    SELF.FEIN    := LEFT.COMPANY_FEIN;
							  		    SELF.PHONE10 := LEFT.COMPANY_PHONE;
							  		    SELF.URL     := LEFT.COMPANY_URL;
							  		    SELF.EMAIL   := LEFT.CONTACT_EMAIL;
							  		    SELF.SIC_CODE := LEFT.COMPANY_SIC_CODE1;
							  		    SELF.CONTACT_LNAME := LEFT.LNAME;
							  		    SELF.CONTACT_FNAME := LEFT.FNAME;
							  		    SELF.CONTACT_MNAME := LEFT.MNAME;
							  		    SELF.CITY    := LEFT.P_CITY_NAME;
							  		    SELF.STATE   := LEFT.ST;
							  		    SELF.ZIP5    := LEFT.ZIP;
							  		    SELF         := LEFT;))(company_name != '' or contact_ssn != '' or prim_name != '' or phone10 != '' or city != '' or fein != '');
        macSourceSampler(dProfile(description = 'Header'), headerBase, headerOut, false, iNumSamples);

        externalSamples := BIzLinkFull_ELERT.ExternalBuildSample.captureData(50000, bUseForeign)(company_name != '' or contact_ssn != '' or prim_name != '' or phone10 != '' or city != '' or fein != '');
        macSourceSampler(dProfile(description = 'External'), externalSamples, extSampleOut, false, iNumSamples);

        fullBase := headerOut
				  + topBusinessOut 
				  + saotOut
				  + preFillOut 	
				  + batchOut
				  + extSampleOut;
                  
		return fullBase;
		END;
END;
