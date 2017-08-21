import dops,lib_fileservices;
EXPORT CompareKeyCount(string filedate) := function
	ds := sort(nothor(fileservices.logicalfilelist('*key*override*'+filedate+'*')),name);

	
	dopsds :=  sort(dops.GetKeyRecordCount('fcra_overridekeys','b','f','p') + dops.GetKeyRecordCount('overridekeys','b','n','p'),logicalkey);
	
	
	typeof(dopsds) replacetemplateds(dopsds l) := transform
		self.logicalkey := regexreplace('overridekeys_date',regexreplace('fcra_overridekeys_date',stringlib.StringToLowerCase(l.logicalkey),filedate),filedate);
		self := l;
	end;
	
	replacedds := project(dopsds,replacetemplateds(left));
	
	string_rec := record
		string logicalkey;
		integer new_record_count;
		integer prod_record_count;
		integer difference := 0;
	end;
	

	
	string_rec get_count(ds l, replacedds r) := transform
		self.logicalkey := if (l.name <> '', l.name, r.logicalkey);
		self.new_record_count := if (l.name <> '', (integer)l.rowcount,-1);
		self.prod_record_count := if (r.logicalkey <> '', (integer)r.recordcount,-1);
		
	end;
	
	getkeycounts := join(ds,replacedds,
												trim(left.name,left,right) = trim(right.logicalkey, left,right),
												get_count(left,right),
													full outer);
	
	string_rec getdiff(getkeycounts l) := transform
		self.difference := l.new_record_count - l.prod_record_count;
		self := l;
	end;
	
	getdiffs := project(getkeycounts,getdiff(left)) : independent;
	
	linestring := RECORD
			STRING300000 line; 
		END;

		headerRec := DATASET([{'filename'}], linestring);

		linestring converttoline (getdiffs L) := TRANSFORM
				SELF.line         := L.logicalkey;
		END;
		
		singlelinerecord := PROJECT (getdiffs(difference < 0), converttoline(LEFT));
		
		
		myrec := RECORD
			UNSIGNED  code0; 
			STRING300000 line; 
		END;

		myrec ref(singlelinerecord l) := TRANSFORM 
			SELF.code0 := 0; 
			SELF       := l; 
		END;

		inputs := PROJECT(headerRec+singlelinerecord, ref(LEFT))(line <> 'filename');

		MyRec rollupForm (myrec L, myrec R) := TRANSFORM
			SELF.line := TRIM(L.line, left, right) + '\n' + TRIM(R.line, LEFT, RIGHT); 
			SELF      := L;
		END;

		XtabOut := ROLLUP(inputs, rollupForm(LEFT,RIGHT), CODE0);
	
			return sequential(
								output(getdiffs),
								if (count(getdiffs(difference < 0)) > 0,
							fileservices.sendemail('Anantha.Venkatachalam@lexisnexis.com, RISBCTQualityAssurance@lexisnexis.com, Darren.Knowles@lexisnexis.com, Charlene.Ros@lexisnexis.com, Tamika.edman@lexisnexis.com',
							'ALERT: Override Keys count dropped ' + filedate,
			'Following keys have a drop in count, please verify: \n\nVersions compared: ' + filedate + ' vs PROD-VERSION \n\n' + trim(XtabOut[1].line,left,right)),
			output('No record count drop')
			));
end;