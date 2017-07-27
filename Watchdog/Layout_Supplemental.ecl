EXPORT Layout_Supplemental :=	MODULE

	EXPORT	gender_layout	:=	RECORD
		STRING10	gender	:=	'';
		UNSIGNED4	date		:=	0;
		STRING2		source	:=	'';
	END;

	EXPORT	hair_color_layout	:=	RECORD
		STRING40	hair_color	:=	'';
		UNSIGNED4	date				:=	0;
		STRING2		source			:=	'';
	END;

	EXPORT	eye_color_layout	:=	RECORD
		STRING40	eye_color	:=	'';
		UNSIGNED4	date			:=	0;
		STRING2		source		:=	'';
	END;

	EXPORT	height_layout	:=	RECORD
		STRING3		height	:=	'';
		UNSIGNED4	date		:=	0;
		STRING2		source	:=	'';
	END;

	EXPORT	weight_layout	:=	RECORD
		STRING3		weight	:=	'';
		UNSIGNED4	date		:=	0;
		STRING2		source	:=	'';
	END;

	EXPORT	race_layout	:=	RECORD
		STRING30	race		:=	'';
		UNSIGNED4	date		:=	0;
		STRING2		source	:=	'';
		UNSIGNED2	total		:=	0;
	END;

// Scars, Marks and Tattoos
	EXPORT	SMT_layout	:=	RECORD
		QSTRING250	SMT			:=	'';
		UNSIGNED4		date		:=	0;
		STRING2			source	:=	'';
	END;
	
	EXPORT	Base	:=	RECORD
		STRING8			process_date		:=	'';
		UNSIGNED6		did							:=	0;
    DATASET(gender_layout)			gender;
    DATASET(hair_color_layout)	hair_color;
    DATASET(eye_color_layout)		eye_color;
    DATASET(height_layout)			height;
    DATASET(weight_layout)			weight;
    DATASET(race_layout)				race;
    DATASET(SMT_layout)					SMT;
  END;	

	EXPORT Raw := RECORD
		STRING8			process_date		:=	'';
		UNSIGNED6		did							:=	0;
		STRING9			accident_nbr		:=	'';
		STRING10		gender					:=	'';
		UNSIGNED4		dt_gender				:=	0;
		STRING2			src_gender			:=	'';
		STRING40		hair_color			:=	'';
		UNSIGNED4		dt_hair_color		:=	0;
		STRING2			src_hair_color	:=	'';
		STRING40		eye_color				:=	'';
		UNSIGNED4		dt_eye_color		:=	0;
		STRING2			src_eye_color		:=	'';
		STRING3			height					:=	'';
		UNSIGNED4		dt_height				:=	0;
		STRING2			src_height			:=	'';
		STRING3			weight					:=	'';
		UNSIGNED4		dt_weight				:=	0;
		STRING2			src_weight			:=	'';
		STRING30		race						:=	'';
		UNSIGNED4		dt_race					:=	0;
		STRING2			src_race				:=	'';
		QSTRING250	SMT							:=	'';
		UNSIGNED4		dt_SMT					:=	0;
		STRING2			src_SMT					:=	'';
	END;

END;