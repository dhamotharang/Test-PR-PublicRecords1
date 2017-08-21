import gong, phonesplus, risk_indicators;

export AreaCodeExtract(unsigned8 MyLimit = 0, boolean Top5 = true) := function

/* ------ GENERATE DATA ------- */

////////// Acquire records from Gong and PPlus within zip set. Fileter empty NPAs. Convert Cities by zip. Generate Counts. Distribute.
		fgong := choosen(gong.File_GongBase(phoneno[1..3] between '200' and '999' and z5 in fds_test.zipcodeset), IF(MyLimit<>0,MyLimit,CHOOSEN:ALL));
			trimGong := table(fgong, {string5 zipcode := z5, string3 area_code := phoneno[1..3]});
	
		fpplus := choosen(phonesplus.file_phonesplus_base(cellphone[1..3] between '200' and '999' and zip5 in fds_test.zipcodeset), IF(MyLimit<>0,MyLimit,CHOOSEN:ALL));
			trimPPlus := table(fPPlus, {string5 zipcode := zip5, string3 area_code := cellphone[1..3]});
		
		dsPhones := table(distribute(trimPPlus + trimGong, hash(zipcode, area_code)), 
					{string5 sourcezip := zipcode, area_code, zipcode, string city := (ziplib.ZipToCities(zipcode)+',')[stringlib.stringfind(ziplib.ZipToCities(zipcode)+',', ',', 1)+1..stringlib.stringfind(ziplib.ZipToCities(zipcode)+',', ',', 2)-1], string state := ziplib.ZipToState2(zipcode), unsigned8 cnt := count(group)}, zipcode, area_code, local)
						: persist('persist::fds_test_areacode');

///////// Combine and sort and remove unwanted records	
		dedPhones := sort(distribute(dsPhones, hash(sourcezip)), sourcezip, -cnt, area_code, local);

		Extract_Layout := record
			fds_test.layouts.response.AreaCode_Extract;
			fds_test.layouts.response.ZipCode_Extract;
		end;
		
		top5_results := sort(project(if(top5, dedup(dedPhones, sourcezip, keep(5), local), dedPhones), Extract_Layout), sourcezip, area_code);

///////// OUTPUTS	
results := parallel(
output(dedPhones,,'out::fds::areacode_zipcode::extract_qa', overwrite, __compressed__);
output(choosen(top5_results, 2000), named('Test_Sample_2000recs'));
output(top5_results,,'out::fds::areacode_zipcode::extract', overwrite, csv(separator('|')));
output('', named('STATS'));
output(count(dedup(top5_results, sourcezip, all)), named('unique_zips'));
output(count(dedup(top5_results, area_code, all)), named('unique_area_codes'));
output(table(top5_results, {sourcezip, cnt_npas := count(group)}, sourcezip), named('unique_area_codes_per_zip'), all)
);		
		
return results;
end;