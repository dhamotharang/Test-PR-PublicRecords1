export Constants := MODULE

// A-australia, G-germany, I-ireland, N-norway, S-sweden
export fnm := [	/*Australia*/	'01922100','01932100','01942100','01952100',
								/*Germany*/		'02012100','02022100','02032100','02042100',
								/*Ireland*/		'02052100','01771003',
								/*Norway*/		'01651002','01661002','01671002','01681002',
								/*Sweden*/		'02132100','02142100','02152100'];	// match
export fnp := [	/*Australia*/	'01924100','01934100','01944100','01954100',
								/*Germany*/		'02014100','02024100','02034100','02044100',
								/*Ireland*/		'02054100','01771004',
								/*Sweden*/		'02134100','02134112','02134115','02144100','02144112','02144115','02154100','02154112','02154115'];	// partial match


export lnm := [	/*Australia*/	'01922101','01932101','01942101','01952101',
								/*Germany*/		'02012101','02022101','02032101','02042101',
								/*Ireland*/		'02052101','01771002',
								/*Norway*/		'01651001','01661001','01671001','01681001',
								/*Sweden*/		'02132101','02142101','02152101'];
export lnp := [	/*Australia*/	'01924101','01934101','01944101','01954101',
								/*Ireland*/		'02054101',
								/*Sweden*/		'02134101','02144101','02154101'];

export addrm := [	/*Australia*/	'01922260','01932260','01942260','01952260',
									/*Germany*/		'02012260','02022260','02032260','02042260',
									/*Ireland*/		'02052260','01771001','02062260',
									/*Norway*/		'01651211','01661211','01671211','01681211',
									/*Sweden*/		'02132260','02142260','02152260'];
export addrp := [	/*Australia*/	'01924260','01934260','01944260','01954260',
									/*Ireland*/		'02054260','01774001','02064260',
									/*Sweden*/		'02134260','02144260','02154260'];

export landm := [	/*Australia*/	'01922150','01932150','01942150',
									/*Germany*/		'02012150','02022150','02032150',
									/*Ireland*/		'01771006',
									/*Norway*/		'01671013'];	
export landp := [	/*Australia*/	'01924150','01934150','01944150',
									/*Germany*/		'02014150','02024150','02034150',
									/*Norway*/		'01674011','01674012'];

export mobilem := [	/*Australia*/	'01952150',
										/*Germany*/		'02042150',
										/*Norway*/		'01681013'];	
export mobilep := [	/*Australia*/	'01954150',
										/*Germany*/		'02044150',
										/*Norway*/		'01684011','01684012'];

export DOBm := [/*Norway*/	'01651009','01661009',
								/*Sweden*/	'02132111','02142111','02152111'];
export DOBp := [/*Sweden*/	'02134111','02144111','02154111'];

export idm := [/*Sweden*/	'02152120'];
export idp := [/*Sweden*/	'02154120'];

export timeout := 30; // specified in requirements (may be excessive?)
export retries := 0;

export dppa := '0';
export glb := '8';

// permisible use acknowledgements 
// Use 3166 ISO Country Numeric values
export puaUK := 826; 

export match := 'match';
export nomatch := 'no-match';
export missing := 'missing';
export partial := '';

export setCit := ['NI','DL','ER','PD','ND','MRZ'];
export setCom := ['UD','CD','MD'];

export GBCountries := ['Australia','Germany','Norway','Sweden'];
export UCCountries := ['China','Japan']; // for these countries we do not want to lower case the inputs

END;