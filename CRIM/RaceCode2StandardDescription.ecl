import Lib_stringlib;

export RaceCode2StandardDescription (STRING RaceCode) :=
	CASE(stringlib.stringtouppercase(RaceCode),
			'W'  => 'White',
			'WH'  => 'White',
			'B'  => 'Black',
			'BL' => 'Black',
			'H'  => 'Hispanic',
			'HI' => 'Hispanic',
			'A'  => 'Asian',
			//'O'  => 'Asian',
			//'OR' => 'Asian',
			'I'  => 'Indian',
			'IN' => 'Indian',
			''   =>'',
			''
			);