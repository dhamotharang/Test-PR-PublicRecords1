export Constants := MODULE

export timeout := 30; // specified in requirements (may be excessive?)
export retries := 0;

export dppa := '0';
export glb := '8';

// permisible use acknowledgements 
// Use 3166 ISO Country Numeric values
export puaAUS := 036;
export puaAUT := 040;
export puaCAN := 124;
export puaCHE := 756;
export puaDEU := 276;
export puaGBR := 826;
export puaNLD := 528;
export puaSGP := 702;
export puaZAF := 710;

export puaBatch := 999;

export match := 'match';
export nomatch := 'no-match';
export missing := 'missing';
export partial := 'partial';

export setCit := ['NI','DL','ER','PD','ND','MRZ'];
export setCom := ['UD','CD','MD'];

export UCCountries := ['China','Japan']; // for these countries we do not want to lower case the inputs
export GDCCountries := ['Australia',
												'Austria',
												'Canada',
												'China',
												'Germany',
												'Japan',
												'Ireland',
												'Hong Kong',
												'Luxembourg',
												'Mexico',
												'Netherlands',
												'New Zealand',
												'Singapore',
												'South Africa',
												'Switzerland',
												'United Kingdom'];

END;