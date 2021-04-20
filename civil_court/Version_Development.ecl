IMPORT STD;

dev_ver := DATASET(
	'~thor_data400::civil_court::current_development_version',
	{STRING version},
	FLAT,
	LOOKUP
);

EXPORT Version_Development := dev_ver[1].version;
