// For its internal calculations, UCCv2_Services scales the penalty by
// a factor of 100, and then scales it back before delivering the data to
// the downstream systems.  This was done to add a finer grain of penalties
// to be used for sorting purposes, without changing the externally-known
// penalty scale to something unfamiliar.

export uccPenalty := module

	export scale := 100;
	
	export large := 100 * scale; // repreents a "large penalty", i.e. a bad match

end;