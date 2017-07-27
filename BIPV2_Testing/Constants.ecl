EXPORT Constants := 
MODULE;

	EXPORT SC := //ShortCycle
	MODULE
		Export LFPrefx := '~thor_data400::bipv2.shortcycle.';
	
		EXPORT DSNames :=
		MODULE
		
			export prop := ['Real Property','Property'];
			export dnbfein := ['DNB_FEIN'];
			export accu := ['Accutrend'];
			export lnca := ['LNCA'];
			export fbn := ['Fictitious Business','FBN'];
			export ebr := ['EBR'];
			export dbdmi := ['D&B'];
			export bk := ['Bankruptcy'];
			export ucc := ['UCC'];
			export mvr := ['MVR'];
			export lj := ['Judgement','Liens'];
			export corp := ['Corp SOS','Corp'];
			export air := ['Aircraft'];
			export fran := ['Frandata'];
			export gong := ['Gong'];
			export wc := ['Watercraft'];
			export yp := ['Yellow Pages'];

			export alls := prop+dnbfein+accu+lnca+fbn+ebr+dbdmi+bk+ucc+mvr+lj+corp+air+fran+gong+wc+yp;
		
		END;//DSNames

		EXPORT Settings :=
		MODULE

			export UseQAData :=
			TRUE;
			// FALSE;//this uses the Test data in BIPV2_Testing.ShortCycleDataTest

			shared DefaultDo := 
			TRUE;
			// FALSE;

			export DoAL := 
			// DefaultDo;
			// NOT DefaultDo;
			FALSE; //its really slowing down thor at the moment

			export DoProp := 
			DefaultDo;
			// NOT DefaultDo;

			export DoMVR :=
			// DefaultDo;
			// NOT DefaultDo;
			FALSE;//bug 143023 

			export DoUCC := 
			DefaultDo;

			export DoCorp := 
			DefaultDo;

			export DoLJ := 
			DefaultDo;

			export DoBK := 
			DefaultDo;
			// not DefaultDo;

			export DoDBDMI := 
			DefaultDo;

			export DoEBR :=
			 DefaultDo;

			export DoFBN := 
			DefaultDo;

			export DoAccu := 
			DefaultDo;

			export DoDNBFEIN := 
			DefaultDo;

		END;//Settings

	END;//ShortCycle

END;//Constants