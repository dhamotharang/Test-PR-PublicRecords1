import bipv2;

EXPORT Blanks := module

	export GetBlanks(ds) := functionmacro
		// keep isBlank in sync with FilterBlanks function
		local isBlank := ds.cnp_name = '' AND ds.company_name = '' AND ds.ingest_status = 'Old';
		return ds(isBlank);
	endmacro;

	export FilterBlanks(ds) := functionmacro
		// keep isBlank in sync with GetBlanks function
		local isBlank := ds.cnp_name = '' AND ds.company_name = '' AND ds.ingest_status = 'Old';
		return ds(not(isBlank));
	endmacro;

	export BlankOut(dataset(BIPV2.CommonBase.layout) ds) := function
		fieldsToKeep := {
			ds.ingest_status,
			ds.rcid,
			ds.dotid,
			ds.proxid,
			ds.lgid3,
			ds.seleid,
			ds.orgid,
			ds.ultid,
			ds.empid,
			ds.powid,
			ds.parent_proxid,
			ds.sele_proxid,
			ds.org_proxid,
			ds.ultimate_proxid,
			ds.is_sele_level,
			ds.is_org_level,
			ds.is_ult_level,
			ds.levels_from_top,
			ds.nodes_below,
			ds.nodes_total,
			ds.has_lgid,
		};

		fieldsToBlank := recordof(ds) - fieldsToKeep;
		blankRow := row(transform(fieldsToBlank, self := []));

		return if(exists(ds(ingest_status != 'Old')),
		          error(recordof(ds), 'You can only blank out records with ingest_status = Old'),
		          project(ds, transform(recordof(left), self := blankRow, self := left)));

	end;

end;