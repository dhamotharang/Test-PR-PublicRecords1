import ut;
string FixGen(string suffix) :=
		CASE(suffix,
			'JR' => 'JR',
			'JR,' => 'JR',
			'SR' => 'SR',
			'JNR' => 'JR',
			'SNR' => 'SR',
			'I' => 'SR',
			'II' => 'JR',
			'II,' => 'JR',
			'III' => 'III',
			'IV' => 'IV',
			'IIII' => 'IV',
			'V' => 'V',
			'VI' => 'VI',
			'VII' => 'VII',
			'');

EXPORT NNEQ_Suffix(string5 a, string5 b) := ut.NNEQ(FixGen(a), FixGen(b));
