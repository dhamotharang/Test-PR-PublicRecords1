import STD;

// crate superfile, add old reports to super file and change archive to auto-load to superfile
// load reports super file with raw file name in layout

report_file_name := LN_PropertyV2_Fast.Files_Vendor_Rpts.taxreport_frs_reporting_fname; //arhive sf
//report_file_name := LN_PropertyV2_Fast.Files_Vendor_Rpts.taxreport_frs_fname; // active sf

layout_frs_taxreport	:=	RECORD
	STRING	State;
	STRING	County;
	STRING	FIPS;
	STRING	CERTDate;
	STRING	Edition;
	STRING	FileName;
	STRING	Total;
	STRING	MaxRecordingDate;
	STRING	MaxSaleDate;
	STRING	MaxOfTaxYear;
	STRING	MaxOfAssessedYear;
	STRING	__filename	{VIRTUAL(logicalfilename)};
	string  raw_file_name := '';
END;
fares_assessment_reports := distribute(
				DATASET(report_file_name,layout_frs_taxreport, csv(HEADING(1),separator(',')))
			, hash64(fips));
//output(fares_assessment_reports);
EXPORT fn_get_frs_assessment_cert_date
				(dataset(recordof(LN_PropertyV2_Fast.Layout_prep_assessment)) inFrsAssr) := function				
				// project to expected raw file name
				layout_frs_taxreport create_expected_raw_file_name (layout_frs_taxreport L) := TRANSFORM
				
// thor_data400::in::property::raw::frs::taxreports::20150122
// thor_data400::in::property::raw::frs::assessment::20150122
				
						temp := STD.Str.FindReplace(L.__filename,'taxreports','assessment');
						SELF.raw_file_name := STD.Str.FindReplace(temp,'::csv','');
						
						SELF := L;
				END;
				cert_loader := project(fares_assessment_reports,create_expected_raw_file_name(LEFT));
				
				reFormat_cert_date(string original) := function

						dt := trim(original);
						month := regexreplace('^([^/]*)/([^/]*)/([^/]*)$',dt,'\\1');
						day :=		regexreplace('^([^/]*)/([^/]*)/([^/]*)$',dt,'\\2');
						year := regexreplace('^([^/]*)/([^/]*)/([^/]*)$',dt,'\\3');
						return year + if(length(month)=1,'0','')+month + if(length(day)=1,'0','')+day;
						
				END;
				
				// join to fares assessment based on raw file name and fips and assign certification date
				inFrsAssr applyCertDate(inFrsAssr LL, cert_loader RR) := TRANSFORM

							SELF.certification_date 	:= if(trim(LL.certification_date)=''
																						,reFormat_cert_date(RR.CERTDate)
																						,LL.certification_date);
							SELF.edition_number 			:= trim(RR.Edition)[2..];
							SELF.assessed_value_year 	:= RR.maxofassessedyear; // DF-12954
							SELF := LL;
				END;
				#WARNING('Data integrity consideration: Fares Edition number is 3 digits in report, while our mapped edition_number is string2');
				RETURN join(distribute(inFrsAssr,hash64(fips_code,raw_file_name))
												,distribute(cert_loader,hash64(fips,raw_file_name)),
												 trim(LEFT.raw_file_name) = trim(RIGHT.raw_file_name) 
														    AND trim(LEFT.fips_code) = trim(RIGHT.fips)
												 ,applyCertDate(LEFT,RIGHT),local, LEFT OUTER, keep(1) // (we have multiple files per county sometimes
													)
										//output(choosen(cert_loader,1000),named('cert_loader')))
																;
END;
/*
f := '~thor_data400::prep::property_fast::20150130::assessment';
rfn := 'thor_data400::in::property::raw::frs::assessment::20141106'; //dummy raw_file_name
prep11 := dataset(f,LN_PropertyV2_Fast.Layout_prep_assessment,thor)(ln_fares_id[1..2]='RA');
prep12 := choosen(prep11,1000);
prep1  := project(prep12,transform(recordof(prep12),SELF.raw_file_name := rfn,SELF := LEFT));

output(choosen(sort(prep1					 											  ,ln_fares_id),1000),named('before'));
zz := fn_get_frs_assessment_cert_date(prep1);
output(choosen(sort(zz,ln_fares_id),1000),named('after'));
output(zz(certification_date<>''));
*/