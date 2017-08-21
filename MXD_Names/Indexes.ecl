export Indexes := MODULE

	// Index of synonyms.

	EXPORT MXNameStatsHashIdx := INDEX(Datasets.dsMXNameStatsFpos,
								{name_part_hash,fpos},
								{ name_part_text, probable_gender, probable_name_part,
								firstname_cnt,middlename_cnt,lastname_cnt,fem_cnt,male_cnt, cnt},
								Filenames.F_MXNameStatsHashIDX);
		
	EXPORT MXNameStatsTextIdx := INDEX(Datasets.dsMXNameStatsFpos,
								{name_part_text,probable_name_part, fpos},
								{ name_part_hash, probable_gender,
								firstname_cnt,middlename_cnt,lastname_cnt,fem_cnt,male_cnt, cnt},
								Filenames.F_MXNameStatsTextIDX);

		export IDX_NameHash(STRING filename, DATASET(Layouts.L_NameHash_Fpos) ds) := 
				INDEX(ds,
						{name_part_type,
						name_part_hash,						
						person_uid,
						isSynonym,
						isMetaphone,
								fpos},
							filename, DISTRIBUTED);
END;