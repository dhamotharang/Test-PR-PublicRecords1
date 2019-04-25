
import FraudDefenseNetwork, advfiles;
IMPORT AutokeyB2, Vikram;
import autokey, ut, nid, doxie;
import keyvalidation, fdn_qa;
 
 fdnDS := distribute(dataset(ut.foreign_prod + 'thor_data400::base::fdn::qa::main', FraudDefenseNetwork.Layouts.base.main, thor), random());
 idx_fdnDID := FraudDefenseNetwork.Keys().main.did.qa;
 idx_fdnEmail := FraudDefenseNetwork.Keys().main.email.qa;
 idx_fdnIP := FraudDefenseNetwork.Keys().main.ip.qa;
 
summaryDS := KeyValidation.validateKeysMacro('did', 'Key', 'Basefile', '20151029', fdnDS, idx_fdnDID, 'left.record_id=right.record_id and left.did = right.did')
+ KeyValidation.validateKeysMacro('email', 'Key', 'Basefile', '20151029', fdnDS, idx_fdnEmail, 'left.record_id=right.record_id')
+ KeyValidation.validateKeysMacro('ip', 'Autokey', 'Basefile', '20151029', fdnDS, idx_fdnIP, 'left.record_id=right.record_id');

outputSummary := output(summaryDS, , '~qa::fdn::keyValidation::summary::' +buildVersion+'', CSV(heading(single), quote('"')), overwrite);						
despraySummary := std.file.despray('~qa::fdn::keyValidation::summary::' +buildVersion+'', '10.48.72.34', 'C:\\KeyValidation\\FDN\\Results\\dropzone\\summary.csv',,,,true);

// outputSummary;

	string out_file_layout := '';
	outfile := dataset('~qa::fdn::keyValidation::summary::' +buildVersion+'' , typeof(out_file_layout));
  no_of_records := count(outfile);	
	
	myrec := record, maxlength(9999999) 
		unsigned code0; 
		unsigned code1;
		string line;
	end;

	myrec ref(outfile l, integer c) := transform 
		self.code0 := c; 
		self.code1 := c + 1 ;
		self .line := if(c=1, 'WorkUnit ID:' + workunit + '\n' + l.line, l.line); 
	end;

	outputs := project(outfile, ref(left, counter));

	MyRec Xform(myrec L,myrec R) := TRANSFORM
		SELF.line := trim(L.line, left, right) + '\n' + trim(R.line, left, right); 
		self := l;
	END;

	XtabOut := iterate(outputs,Xform(left,right));			
	
emailSummary := fileservices.SendEmailAttachText('vikram.pareddy@lexisnexis.com',	
			'keyval_summary_' +buildVersion+'' ,
			'FDN Key validation Summary',
			XtabOut[no_of_records].line ,
			'text/plain; charset=ISO-8859-3', 
			'keyval_summary_' +buildVersion+'.csv',
			,
			,
			'vikram.pareddy@lexisnexis.com'
		);
	sequential(outputSummary, despraySummary, emailSummary);

// 'distribute(dataset(ut.foreign_prod + \'thor_data400::base::fdn::qa::main\', FraudDefenseNetwork.Layouts.base.main, thor), random())',
 // 'left.record_id=right.record_id and left.did = right.did'

// (keyName, buildVersion, keyFile, parentFile, joinCondition
// FDNInputDSLayout := record
  // string50 keyName;
	// string100 keyFile;
	// string50 keyType;
	// string50 parentType;
	// string8 buildVersion;
	// string200 parentFile;
	// string200 joinCondition;
// end;

// FDNInputDS := dataset([{'did','FraudDefenseNetwork.Keys().main.did.qa', 'Autokey', 'Payload Autokey','20151029',
// 'distribute(dataset(ut.foreign_prod + \'thor_data400::base::fdn::qa::main\', FraudDefenseNetwork.Layouts.base.main, thor), random())',
 // 'left.record_id=right.record_id and left.did = right.did'}], FDNInputDSLayout);
 
 
 // summaryLayout callKeyValidatorsForInputDS(FDNInputDS l) := transform 
   // self := KeyValidation.validateKeysMacro(l.keyName, l.keyType, l.parentType, l.buildVersion, l.keyFile, l.parentFile, l.joinCondition);
	 
 // end;

// project(FDNInputDS, callKeyValidatorsForInputDS(left));

export callKeyValidators := '';