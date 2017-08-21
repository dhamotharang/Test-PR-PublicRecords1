import did_add;
import riskwise;
import ADV;


	  deathMasterLayout := RECORD
		string8 process_date;
		string2 source_state;
		string3 certificate_vol_no;
		string4 certificate_vol_year;
		string28 publication;
		string44 decedent_name;
		string93 decedent_race;
		string69 decedent_origin;
		string12 decedent_sex;
		string34 decedent_age;
		string26 education;
		string74 occupation;
		string62 where_worked;
		string289 cause;
		string9 ssn;
		string8 dob;
		string8 dod;
		string35 birthplace;
		string38 marital_status;
		string44 father;
		string44 mother;
		string8 filed_date;
		string4 year;
		string77 county_residence;
		string23 county_death;
		string76 address;
		string7 autopsy;
		string44 autopsy_findings;
		string4 primary_cause_of_death;
		string50 underlying_cause_of_death;
		string3 med_exam;
		string6 est_lic_no;
		string22 disposition;
		string8 disposition_date;
		string9 work_injury;
		string8 injury_date;
		string23 injury_type;
		string50 injury_location;
		string7 surg_performed;
		string8 surgery_date;
		string120 hospital_status;
		string14 pregnancy;
		string70 facility_death;
		string6 embalmer_lic_no;
		string21 death_type;
		string5 time_death;
		string12 birth_cert;
		string31 certifier;
		string20 cert_number;
		string4 birth_vol_year;
		string5 local_file_no;
		string39 vdi;
		string28 cite_id;
		string5 file_id;
		string8 date_last_trans;
		string1 amendment_code;
		string2 amendment_year;
		string10 _on_lexis;
		string9 _fs_profile;
		string3 us_armed_forces;
		string49 place_of_death;
		string16 state_death_id;
		string1 state_death_flag;
		string5 title;
		string20 fname;
		string20 mname;
		string20 lname;
		string5 name_suffix;
		string3 name_score;
		string10 prim_range;
		string2 predir;
		string28 prim_name;
		string4 addr_suffix;
		string2 postdir;
		string10 unit_desig;
		string8 sec_range;
		string25 p_city_name;
		string25 v_city_name;
		string2 state;
		string5 zip5;
		string4 zip4;
		string4 cart;
		string1 cr_sort_sz;
		string4 lot;
		string1 lot_order;
		string2 dpbc;
		string1 chk_digit;
		string2 rec_type;
		string2 fips_state;
		string3 fips_county;
		string10 geo_lat;
		string11 geo_long;
		string4 msa;
		string7 geo_blk;
		string1 geo_match;
		string4 err_stat;
		unsigned8 rawaid;
		string76 orig_address1;
		string76 orig_address2;
		string16 statefn;
		string1 lf;
		unsigned8 scrubsbits1;
		unsigned8 scrubsbits2;
		unsigned8 scrubsbits3;
	END;

	  completeDeathMasterData := dataset('~thor_data400::base::death_master_supplemental_ssa',deathMasterLayout, thor);
		
	 	build_name := 'DeathMaster_Build_Version';
    soapcall_builddate := did_add.get_EnvVariable(build_name, riskwise.shortcuts.QA_neutral_roxieIP);
		
		BuildVersion := ADV.CurrentBuildVersions.File(datasetname='DeathMasterSsaKeys' and envment='Q' and location = 'B' and cluster = 'N')[1].buildversion;

	  newData := completeDeathMasterData(process_date=BuildVersion[1..8]);
	
	  caNewDMData := newData(source_state='CA');
	  caNewDMDataCount := count(caNewDMData);
	
	  txNewDMData := newData(source_state='TX');
	  txNewDMDataCount := count(txNewDMData);
	
	  kyNewDMData := newData(source_state='KY');
	  kyNewDMDataCount := count(kyNewDMData);
	
	  flNewDMData := newData(source_state='FL');
	  flNewDMDataCount := count(flNewDMData);
	
	  gaNewDMData := newData(source_state='GA');
	  gaNewDMDataCount := count(gaNewDMData);
	
	  ncNewDMData := newData(source_state='NC');
	  ncNewDMDataCount := count(ncNewDMData);
	
	  ctNewDMData := newData(source_state='CT');
	  ctNewDMDataCount := count(ctNewDMData);
	
	  mnNewDMData := newData(source_state='MN');
	  mnNewDMDataCount := count(mnNewDMData);
	
	  miNewDMData := newData(source_state='MI');
	  miNewDMDataCount := count(miNewDMData);
	
	  maNewDMData := newData(source_state='MA');
	  maNewDMDataCount := count(maNewDMData);
	
	  ohNewDMData := newData(source_state='OH');
	  ohNewDMDataCount := count(ohNewDMData);
	
	  nvNewDMData := newData(source_state='NV');
	  nvNewDMDataCount := count(nvNewDMData);
	
	  meNewDMData := newData(source_state='ME');
	  meNewDMDataCount := count(meNewDMData);
	
	  vaNewDMData := newData(source_state='VA');
	  vaNewDMDataCount := count(vaNewDMData);
	
	  mtNewDMData := newData(source_state='MT');
	  mtNewDMDataCount := count(mtNewDMData);
	
	  newDataCount := count(newData);
	  newStateDataCount := caNewDMDataCount + txNewDMDataCount + kyNewDMDataCount + flNewDMDataCount + gaNewDMDataCount + ncNewDMDataCount + ctNewDMDataCount 
														+ mnNewDMDataCount + miNewDMDataCount + maNewDMDataCount + ohNewDMDataCount + nvNewDMDataCount + meNewDMDataCount + vaNewDMDataCount + mtNewDMDataCount;

	  totalSampleSize := 50000;
	  thresholdSize := 1000;
		
	  caSampleSize := (caNewDMDataCount/newStateDataCount) * totalSampleSize;
	  txSampleSize := (txNewDMDataCount/newStateDataCount) * totalSampleSize;
	  kySampleSize := (kyNewDMDataCount/newStateDataCount) * totalSampleSize;
	  flSampleSize := (flNewDMDataCount/newStateDataCount) * totalSampleSize;
	  gaSampleSize := (gaNewDMDataCount/newStateDataCount) * totalSampleSize;
	  ncSampleSize := (ncNewDMDataCount/newStateDataCount) * totalSampleSize;
	  ctSampleSize := (ctNewDMDataCount/newStateDataCount) * totalSampleSize;
	  mnSampleSize := (mnNewDMDataCount/newStateDataCount) * totalSampleSize;
	  miSampleSize := (miNewDMDataCount/newStateDataCount) * totalSampleSize;
	  maSampleSize := (maNewDMDataCount/newStateDataCount) * totalSampleSize;
	  ohSampleSize := (ohNewDMDataCount/newStateDataCount) * totalSampleSize;
	  nvSampleSize := (nvNewDMDataCount/newStateDataCount) * totalSampleSize;
	  meSampleSize := (meNewDMDataCount/newStateDataCount) * totalSampleSize;
	  vaSampleSize := (vaNewDMDataCount/newStateDataCount) * totalSampleSize;
	  mtSampleSize := (mtNewDMDataCount/newStateDataCount) * totalSampleSize;
		
	  caSample := choosen(caNewDMData, map(caNewDMDataCount<thresholdSize=>caNewDMDataCount, caSampleSize));
	  txSample := choosen(txNewDMData, map(txNewDMDataCount<thresholdSize=>txNewDMDataCount, txSampleSize));
	  kySample := choosen(kyNewDMData, map(kyNewDMDataCount<thresholdSize=>kyNewDMDataCount, kySampleSize));
	  flSample := choosen(flNewDMData, map(flNewDMDataCount<thresholdSize=>flNewDMDataCount, flSampleSize));
	  gaSample := choosen(gaNewDMData, map(gaNewDMDataCount<thresholdSize=>gaNewDMDataCount, gaSampleSize));
	  ncSample := choosen(ncNewDMData, map(ncNewDMDataCount<thresholdSize=>ncNewDMDataCount, ncSampleSize));
	  ctSample := choosen(ctNewDMData, map(ctNewDMDataCount<thresholdSize=>ctNewDMDataCount, ctSampleSize));
	  mnSample := choosen(mnNewDMData, map(mnNewDMDataCount<thresholdSize=>mnNewDMDataCount, mnSampleSize));
	  miSample := choosen(miNewDMData, map(miNewDMDataCount<thresholdSize=>miNewDMDataCount, miSampleSize));
	  maSample := choosen(maNewDMData, map(maNewDMDataCount<thresholdSize=>maNewDMDataCount, maSampleSize));
	  ohSample := choosen(ohNewDMData, map(ohNewDMDataCount<thresholdSize=>ohNewDMDataCount, ohSampleSize));
	  nvSample := choosen(nvNewDMData, map(nvNewDMDataCount<thresholdSize=>nvNewDMDataCount, nvSampleSize));
	  meSample := choosen(meNewDMData, map(meNewDMDataCount<thresholdSize=>meNewDMDataCount, meSampleSize));
	  vaSample := choosen(vaNewDMData, map(vaNewDMDataCount<thresholdSize=>vaNewDMDataCount, vaSampleSize));
	  mtSample := choosen(mtNewDMData, map(mtNewDMDataCount<thresholdSize=>mtNewDMDataCount, mtSampleSize));
		
	  sampleSize := count(caSample) + count(txSample) + count(kySample) + count(flSample)+ count(gaSample) + count(ncSample) + count(ctSample) + count(mnSample)
										 + count(miSample) + count(maSample) + count(ohSample) + count(nvSample) + count(meSample) + count(vaSample) + count(mtSample);
																					
    dmStateWiseSample := caSample + txSample + kySample + flSample + gaSample + ncSample + ctSample + mnSample + miSample + maSample + ohSample
														+ nvSample + meSample + vaSample + mtSample;
														
output(	dmStateWiseSample,,'~ADV::DeathMasterStateWiseSample_' + BuildVersion, thor, overwrite);													

// EXPORT DeathMasterSample := 'todo';