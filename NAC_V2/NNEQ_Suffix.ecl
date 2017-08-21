import ut;
string FixGen(string suffix) :=
		CASE(suffix,
			'JR' => 'JR',
			'JR,' => 'JR',
			'SR' => 'SR',
			'I' => 'SR',
			'II' => 'JR',
			'II,' => 'JR',
			'III' => 'III',
			'IV' => 'IV',
			'IIII' => 'IV',
			'V' => 'V',
			'1ST' => 'SR',
			'2N' => 'JR',
			'2ND' => 'II',
			'ND' => 'II',
			'3RD' => 'III',
			'RD' => 'III',
			'3 I' => 'III',
			'4TH' => 'IV',
			'5TH' => 'V',
			'');

EXPORT NNEQ_Suffix(string5 a, string5 b) := ut.NNEQ(FixGen(a), FixGen(b));
