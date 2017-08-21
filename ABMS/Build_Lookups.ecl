EXPORT Build_Lookups(DATASET(Layouts.Base.Cert) pBaseCert = Files().Base.Cert.QA) := FUNCTION

	Layouts.Lookups.Specialty xform(Layouts.Base.Cert L) := TRANSFORM
		self.specialty        := L.board_web_desc;
		self.sub_specialty_id := L.cert_id;
		self.sub_specialty    := L.cert_name;
	END;

	Specialty_dedup := DEDUP(SORT(PROJECT(pBaseCert, xform(LEFT)), RECORD), RECORD);
		
	Specialty_recs :=
	  SEQUENTIAL(OUTPUT(Specialty_dedup, , PersistNames.LookupSpecialty, OVERWRITE, __COMPRESSED__));

	RETURN Specialty_recs;

END;