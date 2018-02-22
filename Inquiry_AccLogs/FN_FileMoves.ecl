import ut, did_add,data_services, std;

/* ///////////////////////// Case Connect, BatchR3 (ProdR3 Monitoring), Score and Attribute Outcome,
//////////////////////////// Deconfliction (part of case connect), and Inquiry History  
//////////////////////////// 
//////////////////////////// All file move processes are located here. Add them to the build process if environment allows OR put in scheduler.
*/ /////////////////////////

EXPORT FN_FileMoves := MODULE

		SHARED pDate := (STRING8)Std.Date.today() : INDEPENDENT;		

		EXPORT isSunday := ut.weekday((unsigned6)pDate[1..8]) = 'SUNDAY';
		
		SHARED pDateTime := ut.GetTimeDate() : INDEPENDENT;
		
		SHARED FS := fileservices;		
		
		SHARED emails := 'John.Freibaum@lexisnexisrisk.com, Cecelie.Reid@lexisnexisrisk.com, Fernando.Incarnacao@lexisnexisrisk.com, Sudhir.Kasavajjala@lexisnexisrisk.com, Darren.Knowles@lexisnexisrisk.com';

		EXPORT CaseConnect() := FUNCTION

				ProcessedDS := dataset(data_services.foreign_prod + 'thor_data400::in::accurint_acclogs::processed',{string name{maxLength(256)}}, thor);
				ProcessedDsSet := set(ProcessedDS, name);

				logs_in := nothor(fileservices.superfilecontents('~thor100_21::in::accurint_acclogs_cc'))('foreign::10.241.50.45::'+name in ProcessedDsSet);

				fnRemoveFromSupers(string lname) := function
					superswap1 := fileservices.removesuperfile('~thor100_21::in::accurint_acclogs_cc_preprocess', lname);
					superswap2 := fileservices.removesuperfile('~thor100_21::in::accurint_acclogs_cc', lname);
					superswap3 := fileservices.removesuperfile('~thor100_21::in::accurint_acclogs_cc_processed', lname);
					superswap4 := fileservices.addsuperfile('~thor100_21::in::accurint_acclogs_cc_processed', lname);
				return parallel(superswap1, superswap2, superswap3, superswap4);
				end;

		RETURN sequential(
								fileservices.startsuperfiletransaction();
									IF(COUNT(logs_in) > 0, fileservices.clearsuperfile('~thor100_21::in::accurint_acclogs_cc_processed',false));
									nothor(apply(logs_in,  fnRemoveFromSupers('~'+name)));
									nothor(fileservices.addsuperfile('~thor100_21::in::accurint_acclogs_cc', '~thor100_21::in::accurint_acclogs_cc_preprocess',,true));
									nothor(fileservices.clearsuperfile('~thor100_21::in::accurint_acclogs_cc_preprocess'));
								fileservices.finishsuperfiletransaction();
								OUTPUT(NOTHOR(fileservices.superfilecontents('~thor100_21::in::accurint_acclogs_cc_preprocess')), NAMED('Case_Connect_New_Files'))
							);
		END;

		EXPORT Deconfliction() := FUNCTION

				ProcessedDS := dataset(data_services.foreign_prod + 'thor_data400::in::accurint_acclogs::processed',{string name{maxLength(256)}}, thor);
				ProcessedDsSet := set(ProcessedDS, name);

				logs_dc := fileservices.superfilecontents('~thor100_21::in::mbs::deconfliction')('foreign::10.241.50.45::'+name in ProcessedDsSet);

				fnRemoveFromSupersDC(string lname) := function
					superswap1 := fileservices.removesuperfile('~thor100_21::in::mbs::deconfliction', lname);
				return superswap1;
				end;

		RETURN sequential(
									fileservices.startsuperfiletransaction();
										nothor(apply(logs_dc, fnRemoveFromSupersDC('~'+name)));
									fileservices.finishsuperfiletransaction();
									OUTPUT(NOTHOR(fileservices.superfilecontents('~thor100_21::in::mbs::deconfliction')), NAMED('Deconfliction_New_Files'))
							);

		END;

		EXPORT ScoreAndAttributeOutcome() := FUNCTION 

				ProcessedDS_SL := dataset(data_services.foreign_prod + 'thor_data400::out::acclogs_scoring::processed_files',{string name{maxLength(256)}}, thor);
				logs_pre_A := nothor(fileservices.superfilecontents('~thor100_21::in::accurint_acclogs_sl_preprocess'));
				logs_pre_C := nothor(fileservices.superfilecontents('~thor100_21::in::custom_acclogs_sl_preprocess'));
				logs_pre_R := nothor(fileservices.superfilecontents('~thor100_21::in::riskwise_acclogs_sl_preprocess'));


				ProcessedDsSet_SL := set(ProcessedDS_SL, name);
				PreprocessedDsSet_SL := set(logs_pre_A + logs_pre_C + logs_pre_R, name);

				logs_in_A := Nothor(fileservices.superfilecontents('~thor100_21::in::accurint_acclogs_sl')(name in PreprocessedDsSet_SL or 'foreign::10.241.50.45::'+name in ProcessedDsSet_SL));
				logs_in_C := Nothor(fileservices.superfilecontents('~thor100_21::in::custom_acclogs_sl')(name in PreprocessedDsSet_SL or 'foreign::10.241.50.45::'+name in ProcessedDsSet_SL));
				logs_in_R := Nothor(fileservices.superfilecontents('~thor100_21::in::riskwise_acclogs_sl')(name in PreprocessedDsSet_SL or 'foreign::10.241.50.45::'+name in ProcessedDsSet_SL));

				fnRemoveFromSupers_SL(string lname, string sname) := function
					// superswap1 := fileservices.removesuperfile('~thor100_21::in::'+sname+'_preprocess', '~'+lname);
					superswap2 := fileservices.removesuperfile('~thor100_21::in::'+sname, '~'+lname);
				return superswap2;
				end;

		RETURN sequential(
				nothor(apply(logs_in_A, fnRemoveFromSupers_SL(name,'accurint_acclogs_sl')));
				nothor(apply(logs_in_C, fnRemoveFromSupers_SL(name,'custom_acclogs_sl')));
				nothor(apply(logs_in_R, fnRemoveFromSupers_SL(name,'riskwise_acclogs_sl')));
				nothor(fileservices.addsuperfile('~thor100_21::in::riskwise_acclogs_sl', '~thor100_21::in::riskwise_acclogs_sl_preprocess',,true));
				nothor(fileservices.clearsuperfile('~thor100_21::in::riskwise_acclogs_sl_preprocess'));
				nothor(fileservices.addsuperfile('~thor100_21::in::custom_acclogs_sl', '~thor100_21::in::custom_acclogs_sl_preprocess',,true));
				nothor(fileservices.clearsuperfile('~thor100_21::in::custom_acclogs_sl_preprocess'));
				nothor(fileservices.addsuperfile('~thor100_21::in::accurint_acclogs_sl', '~thor100_21::in::accurint_acclogs_sl_preprocess',,true));
				nothor(fileservices.clearsuperfile('~thor100_21::in::accurint_acclogs_sl_preprocess'));
			OUTPUT(NOTHOR(fileservices.superfilecontents('~thor100_21::in::accurint_acclogs_sl_preprocess')), NAMED('AccurintSOA_New_Files'));
			OUTPUT(NOTHOR(fileservices.superfilecontents('~thor100_21::in::custom_acclogs_sl_preprocess')), NAMED('CustomSOA_New_Files'));
			OUTPUT(NOTHOR(fileservices.superfilecontents('~thor100_21::in::riskwise_acclogs_sl_preprocess')), NAMED('RiskwiseSOA_New_Files'))
		);
		END;

		EXPORT WeeklyInquiryHistory() := FUNCTION

				HistoryKeyVersion := did_add.get_EnvVariable('inquiry_build_version','http://roxiethor.sc.seisint.com:9856'); //prod

						f(string v) := stringlib.stringfind(v, '::', 3)+2;
						l(string v) := stringlib.stringfind(v, '::', 4)-1;

				superfilecontents(string source) :=
				fileservices.superfilecontents('~thor100_21::base::'+source+'_acclogs_common')(name[f(name)..l(name)] <= HistoryKeyVersion);

				accurint_removals	:= superfilecontents('accurint');
				banko_removals		:= superfilecontents('banko');
				batch_removals		:= superfilecontents('batch');
				batchr3_removals	:= superfilecontents('batchr3');
				bridger_removals	:= superfilecontents('bridger');
				custom_removals		:= superfilecontents('custom');
				idm_bls_removals	:= superfilecontents('idm_bls');
				riskwise_removals	:= superfilecontents('riskwise');
				
			
				
	     	fnRemovedProcessed(string source, string lname) := function
					inProcessed := count(nothor(fileservices.superfilecontents('~thor100_21::base::'+source+'_acclogs_common')('~'+name = lname))) > 0;
					remove := if(inProcessed, fileservices.removesuperfile('~thor100_21::base::'+source+'_acclogs_common', lname));
					add := if(inProcessed, fileservices.addsuperfile('~thor100_21::base::'+source+'_acclogs_common_father', lname));
				return sequential(remove,add,output(dataset([lname],{string name}),named('CommonSuperRemovals'),extend));
				end;
        
					clearfather() := function
					clearit := parallel(	fileservices.clearsuperfile('~thor100_21::base::accurint_acclogs_common_father', true);
																fileservices.clearsuperfile('~thor100_21::base::banko_acclogs_common_father', true);
																fileservices.clearsuperfile('~thor100_21::base::batch_acclogs_common_father', true);
																fileservices.clearsuperfile('~thor100_21::base::batchr3_acclogs_common_father', true);
																fileservices.clearsuperfile('~thor100_21::base::bridger_acclogs_common_father', true);
																fileservices.clearsuperfile('~thor100_21::base::custom_acclogs_common_father', true);
																fileservices.clearsuperfile('~thor100_21::base::idm_bls_acclogs_common_father', true);
																fileservices.clearsuperfile('~thor100_21::base::riskwise_acclogs_common_father', true));
					DOM := pDate[7..] = '01';
				return if(DOM, clearit, output('No deletes from father today.', named('History_Father_Deletes_on_1st')));
				end;

		RETURN sequential(
			fileservices.startsuperfiletransaction();
				clearfather();
				nothor(OUTPUT(accurint_removals + banko_removals + batch_removals + batchr3_removals + bridger_removals + custom_removals + idm_bls_removals + riskwise_removals, NAMED('CommonSuperRemovalsCandidates')));
				
				nothor(apply(accurint_removals, fnRemovedProcessed('accurint','~'+name)));
				nothor(apply(banko_removals, fnRemovedProcessed('banko','~'+name)));
				nothor(apply(batch_removals, fnRemovedProcessed('batch','~'+name)));
				nothor(apply(batchr3_removals, fnRemovedProcessed('batchr3','~'+name)));
				nothor(apply(bridger_removals, fnRemovedProcessed('bridger','~'+name)));
				nothor(apply(custom_removals, fnRemovedProcessed('custom','~'+name)));
				nothor(apply(idm_bls_removals, fnRemovedProcessed('idm_bls','~'+name)));
				nothor(apply(riskwise_removals, fnRemovedProcessed('riskwise','~'+name)));
				
			fileservices.finishsuperfiletransaction()
		);

		END;

		EXPORT ProdR3Monitoring() := FUNCTION

						datetime := stringlib.stringfilter(pDateTime, '0123456789');

						BatchR3ContentsProd :=nothor( fileservices.superfilecontents(data_services.foreign_R3 + 'thor_10_219::base::account_monitoring::prod::nonfcra::inquirytracking'));

						isempty(string ftype) := 
								count(nothor(fileservices.superfilecontents(data_services.foreign_R3 + 'thor_10_219::base::account_monitoring::prod::nonfcra::inquirytracking'))) > 0;

						Pre_BatchR3FileProd := dataset(data_services.foreign_R3 + 'thor_10_219::base::account_monitoring::prod::nonfcra::inquirytracking', inquiry_acclogs.LAYOUT_ProdR3, thor);

						fnAddFlag(dataset(inquiry_acclogs.LAYOUT_ProdR3) infile, string source) :=  
											project(infile, transform({inquiry_acclogs.LAYOUT_ProdR3, string source},
																										self.source := source;
																										self := left));


						BatchR3FileProd := fnAddFlag(Pre_BatchR3FileProd, 'PROD');

						/* EMAIL ALERT */


						prod := if(count(BatchR3Contentsprod) > 0, 'PROD ', '');

						emailcontents := workunit + ' - ' + prod;
						emailsubject := 'NonFCRA BatchR3 Logs Output (ProdR3 Monitoring) - ' + datetime;

						emailSend := if(count(BatchR3Contentsprod) > 0,
															fileservices.sendemail('John.Freibaum@lexisnexisrisk.com, Cecelie.Reid@lexisnexisrisk.com, Fernando.Incarnacao@lexisnexisrisk.com, Sudhir.Kasavajjala@lexisnexisrisk.com, Darren.Knowles@lexisnexisrisk.com', emailsubject, emailcontents));

						/* PERFORM CALLS */

		RETURN sequential(
						if(isSunday,fileservices.clearsuperfile('~thor100_21::in::BatchR3_acclogs_contents', true));
						if(count(BatchR3ContentsProd) > 0 and ~exists(fileservices.LogicalFileList('thor100_21::in::'+datetime[1..8]+'*_Prod::batchr3',true,false)),
							sequential(
									output(BatchR3FileProd,, '~thor100_21::in::'+datetime+'_Prod::batchr3', overwrite, __compressed__);
									output(BatchR3ContentsProd,,'~thor100_21::base::account_monitoring::inquirytracking_'+datetime+'_Prod_contents',overwrite, __compressed__);
									nothor(fileservices.addsuperfile('~thor100_21::in::BatchR3_acclogs_preprocess', '~thor100_21::in::'+datetime+'_Prod::batchr3'));
									nothor(fileservices.addsuperfile('~thor100_21::in::BatchR3_acclogs_contents','~thor100_21::base::account_monitoring::inquirytracking_'+datetime+'_Prod_contents'))
								),
							OUTPUT('No New Files',NAMED('ProdR3Files'))),
						emailSend);
						
		END;
		
		EXPORT FCRA_ScoreAndAttributeOutcome() := FUNCTION 

				ProcessedDS_SL := dataset(data_services.foreign_prod + 'thor_data400::out::acclogs_scoring::processed_files',{string name{maxLength(256)}}, thor);
				logs_pre_R := nothor(fileservices.superfilecontents('~thor10_231::in::riskwise_acclogs_sl_preprocess'));


				ProcessedDsSet_SL := set(ProcessedDS_SL, name);
				PreprocessedDsSet_SL := set(logs_pre_R, name);

				logs_in_R := fileservices.superfilecontents('~thor10_231::in::riskwise_acclogs_sl')(name in PreprocessedDsSet_SL or 'foreign::10.241.21.34::'+name in ProcessedDsSet_SL);

				fnRemoveFromSupers_SL(string lname, string sname) := function
					superswap2 := nothor(fileservices.removesuperfile('~thor10_231::in::'+sname, '~'+lname));
				return parallel(superswap2);
				end;

		RETURN sequential(
				nothor(apply(logs_in_R, fnRemoveFromSupers_SL(name,'riskwise_acclogs_sl')));
				nothor(fileservices.addsuperfile('~thor10_231::in::riskwise_acclogs_sl', '~thor10_231::in::riskwise_acclogs_sl_preprocess',,true));
				nothor(fileservices.clearsuperfile('~thor10_231::in::riskwise_acclogs_sl_preprocess'));
			OUTPUT(NOTHOR(fileservices.superfilecontents('~thor10_231::in::riskwise_acclogs_sl_preprocess')), NAMED('RiskwiseSOA_New_Files'))
		);
		END;


		EXPORT FCRA_ProdR3Monitoring() := FUNCTION
						
						datetime := stringlib.stringfilter(pDateTime, '0123456789');

						BatchR3ContentsProd := nothor(fileservices.superfilecontents(data_services.foreign_R3 + 'thor_10_219::base::account_monitoring::prod::fcra::inquirytracking'));

						isempty(string ftype) := count(nothor(fileservices.superfilecontents(data_services.foreign_R3 + 'thor_10_219::base::account_monitoring::prod::fcra::inquirytracking'))) > 0;

						Pre_BatchR3FileProd := inquiry_acclogs.Proc_Prod_R3Monitoring.File_Monitoring_FCRA;

						fnAddFlag(dataset(inquiry_acclogs.LAYOUT_ProdR3) infile, string source) := project(infile, transform({inquiry_acclogs.LAYOUT_ProdR3}, self := left));

						BatchR3FileProd := fnAddFlag(Pre_BatchR3FileProd, 'PROD');

						prod := if(count(BatchR3Contentsprod) > 0, 'PROD ', '');

						/* EMAIL ALERT */

						emailcontents := nothor(workunit) + ' - ' + prod;
						emailsubject := 'BatchR3 Logs Output - ' + datetime;

						emailSend := if(count(BatchR3Contentsprod) > 0, fileservices.sendemail('John.Freibaum@lexisnexisrisk.com, Cecelie.Reid@lexisnexisrisk.com, Fernando.Incarnacao@lexisnexisrisk.com, Sudhir.Kasavajjala@lexisnexisrisk.com, Darren.Knowles@lexisnexisrisk.com', emailsubject, emailcontents));

						/* PERFORM CALLS */

		RETURN sequential(
						if(isSunday,fileservices.clearsuperfile('~thor10_231::in::batchr3_acclogs_contents', true));
						if(count(BatchR3ContentsProd) > 0 and ~exists(fileservices.LogicalFileList('thor10_231::in::'+datetime[1..8]+'*_Prod::batchr3',true,false)),
							sequential(
								output(choosen(BatchR3ContentsProd,100), named('BatchR3Prod_Superfile_Contents')),
									output(BatchR3FileProd,, '~thor10_231::in::'+datetime+'_Prod::batchr3', overwrite, __compressed__);
									output(BatchR3ContentsProd,,'~thor10_231::base::account_monitoring::inquirytracking_'+datetime+'_Prod_contents');
								fileservices.addsuperfile('~thor10_231::in::prodr3_acclogs_preprocess', '~thor10_231::in::'+datetime+'_Prod::batchr3');
								fileservices.addsuperfile('~thor10_231::in::batchr3_acclogs_contents','~thor10_231::base::account_monitoring::inquirytracking_'+datetime+'_Prod_contents')
							),
							OUTPUT('No New Files',NAMED('ProdR3Files'))),
						emailSend);
						
		END;
		
		EXPORT R3Monitoring(boolean isFCRA = false) := FUNCTION
				
						datetime 	:= stringlib.stringfilter(pDateTime, '0123456789');
						prefix := if(isFCRA, '~thor10_231', '~thor100_21');
						
						baseR3_SF := data_services.foreign_R3 + 'thor_10_219::base::account_monitoring::prod::' + if(isFCRA, 'fcra', 'nonfcra') + '::inquirytracking';
						baseR3_SF_Content := nothor(FS.superfilecontents(baseR3_SF));

						dsNonFcraR3 	:= dataset(baseR3_SF, inquiry_acclogs.LAYOUT_ProdR3, thor);
						dsFcraR3 				:= inquiry_acclogs.Proc_Prod_R3Monitoring.File_Monitoring_FCRA;
						
						dsR3 := if(isFCRA
																	,project(dsFcraR3, transform({inquiry_acclogs.LAYOUT_ProdR3, string source}, self.source := 'PROD', self := left;))
																	,project(dsNonFcraR3, transform({inquiry_acclogs.LAYOUT_ProdR3, string source}, self.source := 'PROD', self := left;))
																);

						emailcontents := workunit + ' - ' + if(count(baseR3_SF_Content) > 0, 'PROD', '');
						emailsubject  := if(isFCRA, 'FCRA ', 'NonFCRA ') + 'BatchR3 Logs Output (ProdR3 Monitoring) - ' + datetime;
						
						R3_in := prefix + '::in::'+datetime+'_Prod::batchr3';
						R3_Contents_in := prefix + '::base::account_monitoring::inquirytracking_'+datetime+'_Prod_contents';
						
						R3_Content_SF_name := prefix + '::in::BatchR3_acclogs_contents';
						
		RETURN sequential(
						if(isSunday,FS.clearsuperfile(R3_Content_SF_name, true));
						if(count(baseR3_SF_Content) > 0 and ~exists(FS.LogicalFileList(prefix + '::in::'+datetime[1..8]+'*_Prod::batchr3',true,false)),
							sequential(
									output(dsR3,, R3_in, overwrite, __compressed__),
									output(baseR3_SF_Content,,R3_Contents_in,overwrite, __compressed__),
									if(isFCRA
										,nothor(FS.addsuperfile(prefix + '::in::prodr3_acclogs_preprocess', R3_in))
										,nothor(FS.addsuperfile(prefix + '::in::BatchR3_acclogs_preprocess', R3_in))
										),
									nothor(FS.addsuperfile(R3_Content_SF_name, R3_Contents_in)),
									FS.sendemail(emails, emailsubject, emailcontents)
								),
							OUTPUT('No New Files',NAMED('ProdR3Files'))							
							));
						
	END;


END;