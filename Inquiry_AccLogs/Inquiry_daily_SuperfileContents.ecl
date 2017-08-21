Export 
Inquiry_daily_SuperfileContents(boolean fcra = false) := function

	pPrefix	:= if(~fcra, '~thor100_21','~thor10_231');
	
	return sequential(
					output(sort(nothor(fileservices.superfilecontents(pPrefix + '::in::accurint_acclogs_preprocess')),name),named('accurint_acclogs_preprocess')),
					output(sort(nothor(fileservices.superfilecontents(pPrefix + '::in::banko_acclogs_preprocess')),name),named('banko_acclogs_preprocess')),
					output(sort(nothor(fileservices.superfilecontents(pPrefix + '::in::batch_acclogs_preprocess')),name),named('batch_acclogs_preprocess')),
					output(sort(nothor(fileservices.superfilecontents(pPrefix + '::in::batchr3_acclogs_preprocess')),name),named('batchr3_acclogs_preprocess')),
					output(sort(nothor(fileservices.superfilecontents(pPrefix + '::in::custom_acclogs_preprocess')),name),named('custom_acclogs_preprocess')),
					output(sort(nothor(fileservices.superfilecontents(pPrefix + '::in::idm_bls_acclogs_preprocess')),name),named('idm_bls_acclogs_preprocess')),
					output(sort(nothor(fileservices.superfilecontents(pPrefix + '::in::riskwise_acclogs_preprocess')),name),named('riskwise_acclogs_preprocess')),
					output(sort(nothor(fileservices.superfilecontents(pPrefix + '::in::sba_acclogs_preprocess')),name),named('sba_acclogs_preprocess')),

					output(sort(nothor(fileservices.superfilecontents(pPrefix + '::in::accurint_acclogs')),name),named('accurint_acclogs')),
					output(sort(nothor(fileservices.superfilecontents(pPrefix + '::in::banko_acclogs')),name),named('banko_acclogs')),
					output(sort(nothor(fileservices.superfilecontents(pPrefix + '::in::batch_acclogs')),name),named('batch_acclogs')),
					output(sort(nothor(fileservices.superfilecontents(pPrefix + '::in::batchr3_acclogs')),name),named('batchr3_acclogs')),
					output(sort(nothor(fileservices.superfilecontents(pPrefix + '::in::custom_acclogs')),name),named('custom_acclogs')),
					output(sort(nothor(fileservices.superfilecontents(pPrefix + '::in::idm_bls_acclogs')),name),named('idm_bls_acclogs')),
					output(sort(nothor(fileservices.superfilecontents(pPrefix + '::in::riskwise_acclogs')),name),named('riskwise_acclogs')),
					output(sort(nothor(fileservices.superfilecontents(pPrefix + '::in::sba_acclogs')),name),named('sba_acclogs')),
			);

end;