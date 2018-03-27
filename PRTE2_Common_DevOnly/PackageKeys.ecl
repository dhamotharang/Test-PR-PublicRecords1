IMPORT dops,ut;

EXPORT PackageKeys := MODULE

		EXPORT PackageKeysLayout := RECORD
				string actualkeyname := '';
				string lkeyname := '';
				string onthor := 'N';
		END;
		
		// This returns a list of all package keys and showing if they exist, it does not filter any 
		EXPORT GetPackageKeys(string dsname,string buildversion,string envment = 'N',string boolKeys='N') := FUNCTION
			string replacestring := dsname + '_DATE';
			ds := dops.GetRoxieKeys(dsname,'B',envment,boolKeys);
			
			PackageKeysLayout prct_recs(ds l) := TRANSFORM
				getbuildversion := regexreplace(replacestring,l.logicalkey,buildversion);
				clustertoreplace := ut.Words(getbuildversion,1,1,':');
				newlkeyname := regexreplace(clustertoreplace,getbuildversion,'prte');
				self.actualkeyname := l.logicalkey;
				self.lkeyname := newlkeyname;
				self.onthor := if (fileservices.fileexists('~'+newlkeyname),'Y','N');
			END;
			
			missing_prct := nothor(project(global(ds,few),prct_recs(left)));
			
			RETURN missing_prct;
			
		END;

END;