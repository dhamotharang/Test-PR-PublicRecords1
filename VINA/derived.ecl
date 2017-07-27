IMPORT ut;
EXPORT Derived := MODULE

	EXPORT parseAlpha(STRING input) := FUNCTION
		DS := DATASET([{input}],{STRING35 line});
		PATTERN pttrn := PATTERN('[[:alpha:]]+');
		results := PARSE(DS,line,pttrn,TRANSFORM({STRING35 strng},SELF.strng:=MATCHTEXT(pttrn)),SCAN);
		RETURN results[1].strng;
	END;

	EXPORT parseDecimal(STRING input) := FUNCTION
		DS := DATASET([{input}],{STRING35 line});
		PATTERN pttrn := PATTERN('[[:digit:]]+') '.' PATTERN('[[:digit:]]+');
		results := PARSE(DS,line,pttrn,TRANSFORM({STRING35 strng},SELF.strng:=MATCHTEXT(pttrn)),SCAN);
		RETURN results[1].strng;
	END;

	EXPORT parseAlphaNumeric(STRING input) := FUNCTION
		DS := DATASET([{input}],{STRING35 line});
		PATTERN pttrn := PATTERN('[[:alnum:]]+');
		results := PARSE(DS,line,pttrn,TRANSFORM({STRING35 strng},SELF.strng:=MATCHTEXT(pttrn)),SCAN);
		RETURN results[1].strng;
	END;

	EXPORT parseAlphaNumeric2(STRING input) := FUNCTION
		DS := DATASET([{input}],{STRING35 line});
		PATTERN pttrn := PATTERN('[[:alnum:]]+') PATTERN('[[:space:]|[:punct:]]+') PATTERN('[[:alnum:]]+');
		results := PARSE(DS,line,pttrn,TRANSFORM({STRING35 strng},SELF.strng:=MATCHTEXT(pttrn)),SCAN);
		RETURN results[1].strng;
	END;

	EXPORT parseAlphaNumeric3(STRING input) := FUNCTION
		DS := DATASET([{input}],{STRING35 line});
		PATTERN pttrn := PATTERN('[[:alnum:]]+') PATTERN('[[:space:]|[:punct:]]+') PATTERN('[[:alnum:]]+') PATTERN('[[:space:]|[:punct:]]+') PATTERN('[[:alnum:]]+');
		results := PARSE(DS,line,pttrn,TRANSFORM({STRING35 strng},SELF.strng:=MATCHTEXT(pttrn)),SCAN);
		RETURN results[1].strng;
	END;

	EXPORT parseAlphaDigit(STRING input) := FUNCTION
		DS := DATASET([{input}],{STRING35 line});
		PATTERN pttrn := PATTERN('[[:alpha:]]+') PATTERN('[[:punct:]]*') PATTERN('[[:alpha:]]*') PATTERN('[[:digit:]]+');
		results := PARSE(DS,line,pttrn,TRANSFORM({STRING35 strng},SELF.strng:=MATCHTEXT(pttrn)),SCAN,MAX);
		RETURN results[1].strng;
	END;

	EXPORT parseDigit(STRING input) := FUNCTION
		DS := DATASET([{input}],{STRING35 line});
		PATTERN pttrn := PATTERN('[[:digit:]]+');
		results := PARSE(DS,line,pttrn,TRANSFORM({STRING35 strng},SELF.strng:=MATCHTEXT(pttrn)),SCAN,MAX);
		RETURN results[1].strng;
	END;

	SHARED ACURA     := ['ACUR'];
	SHARED LEXUS     := ['LEXS'];
	SHARED HARLEY    := ['HD'];
	SHARED HUMMER    := ['HUMM'];
	SHARED SATURN    := ['STRN'];
	SHARED CYCLES    := ['BMW','HOND','KAWK','SUZI','YAMA'];
	SHARED SERIES    := ['ATK','BMW','DUCA','FERR','KTM','MERZ','PORS'];
	SHARED DONTPARSE := ['AIH','AMIN','AMTC','AZU','BCIB','BGCH','BLUB','CAGI','CCC','CHA','CPIU','CRN','DEER','DERB','DINA','EAGI',
								'ELDO','FEAT','FEDL','FLEX','FWD','GEM','GIAA','GIL','GMBH','HEND','HINO','ICCO','KALM','KOV','NAB','NEOP','PETR',
								'PIAG','SPTN','SSI','STST','TERX','THMS','TMC','TVR','UTIM','VCTY','VESP','WINN','YUGO','ZEL','ZONG'];

	SHARED pfx := {STRING25 prefix};
	makePrefix := RECORD
		STRING4 make;
		DATASET(pfx) prefixes {MAXCOUNT(16)};
	END;
	
	ALFA := DATASET([{'ALFA',[{'8C'},{'GTV'}]}],makePrefix);
	AMER := DATASET([{'AMER',[{'GRAND'}]}],makePrefix);
	APRI := DATASET([{'APRI',[{'CAPO'},{'ETV'},{'RALLY'},{'RS'},{'RST'},{'SL'}]}],makePrefix);
	ASTO := DATASET([{'ASTO',[{'V8'},{'V12'}]}],makePrefix);
	AUDI := DATASET([{'AUDI',[{'NEW'}]}],makePrefix);
	AUTO := DATASET([{'AUTO',[{'C'}]}],makePrefix);
	BENT := DATASET([{'BENT',[{'CONTINENTAL'}]}],makePrefix);
	BMW  := DATASET([{'BMW' ,[{'M'}]}],makePrefix);
	BUEL := DATASET([{'BUEL',[{'M2L'},{'RS'}]}],makePrefix);
	BUIC := DATASET([{'BUIC',[{'PARK'}]}],makePrefix);

	CANA := DATASET([{'CANA',[{'DS'}]}],makePrefix);
	CADI := DATASET([{'CADI',[{'60'},{'COMMERCIAL'},{'PROFESSIONAL'}]}],makePrefix);
	CHEV := DATASET([{'CHEV',[{'B'},{'C'},{'EL'},{'G'},{'MONTE'},{'T'}]}],makePrefix);
	CHRY := DATASET([{'CHRY',[{'E'},{'FIFTH'},{'GRAND'},{'NEW'},{'PT'},{'T'},{'TOWN'}]}],makePrefix);
	DODG := DATASET([{'DODG',[{'D'},{'GRAND'},{'MINI'},{'RAM'},{'ST'},{'W'}]}],makePrefix);
	FORD := DATASET([{'FORD',[{'BRONCO'},{'CAB'},{'CLUB'},{'CROWN'},{'FIVE'},{'HIGH'},{'LIGHT'},{'LOW'},{'MEDIUM'}]}],makePrefix);
	FRHT := DATASET([{'FRHT',[{'M'},{'M2'},{'MED'},{'V'},{'X'}]}],makePrefix);
	GMC  := DATASET([{'GMC' ,[{'B'},{'C'},{'G'},{'T'},{'VALUE'}]}],makePrefix);
	HOND := DATASET([{'HOND',[{'CR'},{'EV'}]}],makePrefix);
	HUSQ := DATASET([{'HUSQ',[{'SMS'},{'WR'}]}],makePrefix);

	HYUN := DATASET([{'HYUN',[{'SANTA'}]}],makePrefix);
	INTL := DATASET([{'INTL',[{'1000'},{'2000'},{'3000'},{'3200'},{'4000'},{'7000'},{'7700'},{'8000'},{'9000'},{'9100'},{'CO'},{'METRO'},{'S'},{'X'}]}],makePrefix);
	ISU  := DATASET([{'ISU' ,[{'CONV'},{'H'},{'I'},{'KS'},{'NORMAL'},{'REG'},{'SPACE'}]}],makePrefix);
	JAGU := DATASET([{'JAGU',[{'EXECUTIVE'},{'S'},{'SUPER'},{'VANDEN'},{'X'}]}],makePrefix);
	JEEP := DATASET([{'JEEP',[{'GRAND'}]}],makePrefix);
	KIA  := DATASET([{'KIA' ,[{'NEW'}]}],makePrefix);
	KW   := DATASET([{'KW'  ,[{'OFF'}]}],makePrefix);
	LINC := DATASET([{'LINC',[{'MARK'},{'T'},{'TOWN'}]}],makePrefix);
	LNDR := DATASET([{'LNDR',[{'DISCOVERY'},{'RANGE'}]}],makePrefix);
	MASE := DATASET([{'MASE',[{'138'}]}],makePrefix);

	MAZD := DATASET([{'MAZD',[{'CX'},{'MX'}]}],makePrefix);
	MERC := DATASET([{'MERC',[{'GRAND'}]}],makePrefix);
	MERZ := DATASET([{'MERZ',[{'B'},{'S'}]}],makePrefix);
	MITS := DATASET([{'MITS',[{'3000'},{'I'},{'SP'},{'SPACE'}]}],makePrefix);
	NISS := DATASET([{'NISS',[{'GT'},{'KING'},{'LONG'},{'X'}]}],makePrefix);
	OLDS := DATASET([{'OLDS',[{'88'},{'98'},{'CUTLASS'},{'DELTA'}]}],makePrefix);
	OSHK := DATASET([{'OSHK',[{'M'},{'FF'},{'FORWARD'},{'HIGH'},{'JOHN'},{'LOW'},{'S'},{'T'},{'V'},{'X'}]}],makePrefix);
	PLYM := DATASET([{'PLYM',[{'GRAN'},{'GRAND'}]}],makePrefix);
	POL  := DATASET([{'POL' ,[{'ALL'},{'BIG'},{'EV'},{'GEN'},{'TRAIL'},{'X2'}]}],makePrefix);
	PONT := DATASET([{'PONT',[{'GRAND'},{'T'},{'TRANS'}]}],makePrefix);

	RENA := DATASET([{'RENA',[{'LE'}]}],makePrefix);
	RMR  := DATASET([{'RMR' ,[{'RAISED'},{'STRAIGHT'}]}],makePrefix);
	SAA  := DATASET([{'SAA' ,[{'9'}]}],makePrefix);
	ROL  := DATASET([{'ROL' ,[{'FLYING'},{'PARK'},{'SILVER'}]}],makePrefix);
	SUZI := DATASET([{'SUZI',[{'DR'},{'GRAND'}]}],makePrefix);
	TOYT := DATASET([{'TOYT',[{'1'},{'3'},{'COMMERCIAL'},{'FJ'},{'LONG'},{'SHORT'},{'STANDARD'},{'STD'},{'EXTRA'}]}],makePrefix);
	TRUM := DATASET([{'TRUM',[{'ROCKET'},{'ROCKETT'},{'STREET'},{'SPEED'},{'SUPER'}]}],makePrefix);
	VAN  := DATASET([{'VAN' ,[{'COMMUTER'},{'TRANSIT'},{'URBAN'}]}],makePrefix);
	VOLK := DATASET([{'VOLK',[{'CITY'},{'NEW'}]}],makePrefix);
	WHGM := DATASET([{'WHGM',[{'HIGH'},{'LOW'}]}],makePrefix);

	WHIT := DATASET([{'WHIT',[{'HIGH'},{'LOW'},{'ROAD'}]}],makePrefix);
	WSTR := DATASET([{'WSTR',[{'HIGH'}]}],makePrefix);

	SHARED makePrefixes :=
		ALFA+AMER+APRI+ASTO+AUDI+AUTO+BENT+BMW +BUEL+BUIC+
		CANA+CADI+CHEV+CHRY+DODG+FORD+FRHT+GMC +HOND+HUSQ+
		HYUN+INTL+ISU +JAGU+JEEP+KIA +KW  +LINC+LNDR+MASE+
		MAZD+MERC+MERZ+MITS+NISS+OLDS+OSHK+PLYM+POL +PONT+
		RENA+RMR +SAA +ROL +SUZI+TOYT+TRUM+VAN +VOLK+WHGM+
		WHIT+WSTR;
	SHARED HASPREFIX := SET(makePrefixes,make);

	SHARED cds := RECORD
		STRING6  code;
		STRING1  oper; // 3-alphaNum3 S-subsitute
		STRING25 model;
	END; 
	makeSeries := RECORD
		STRING4 make;
		DATASET(cds) series {MAXCOUNT(16)};
	END;

	B3NT := DATASET([{'BENT',[{'CFS','3',''},// CONTINENTAL FLYING SPUR
														{'FPS','3',''} // CONTINENTAL FLYING SPUR
														]}],makeSeries);
	BU3L := DATASET([{'BUEL',[{'BXM','S','LIGHTNING'},
														{'LXB','S','XB12SS'},
														{'LXC','S','XB12SS'}
														]}],makeSeries);
	CAD1 := DATASET([{'CADI',[{'HF6','S','CTS'} // CTS HI FEATURE
														]}],makeSeries);
	CH3V := DATASET([{'CHEV',[{'HICH30','',''} // HI CUBE VAN G30
														]}],makeSeries);
	D0DG := DATASET([{'DODG',[{'CARGCW','S','GRAND CARAVAN'},
														{'CARGHR','S','GRAND CARAVAN'}
														]}],makeSeries);
	FIAT := DATASET([{'FIAT',[{'X19','',''}
														]}],makeSeries);
	F0RD := DATASET([{'FORD',[{'CSL','S','CROWN VICTORIA'},
														{'CSX','S','CROWN VICTORIA'},
														{'CSQ','S','CROWN VICTORIA'},
														{'CVP','S','CROWN VICTORIA'},
														{'C/S','S','LTD'},
														{'CTVCMC','',''},// E SUPER DUTY
														{'CTVRVC','',''},// E SUPER DUTY RV
														{'COFFSD','',''},// F SUPER DUTY
														{'CLCCSD','',''},// F SUPER DUTY F590
														{'DRWF/5','',''} // MH STRIPPED CHASSIS
														]}],makeSeries);
	GMC2 := DATASET([{'GMC' ,[{'HCVGHC','',''} // HI-CUBE VAN G3500
														]}],makeSeries);
	H0ND := DATASET([{'HOND',[{'ACTACE','3',''},// ACCORD CROSS TOUR
														{'ACTACL','3',''} // ACCORD CROSS TOUR
														]}],makeSeries);
	HYND := DATASET([{'HYUN' ,[{'VRZVRZ','S','VERACRUZ'}
														]}],makeSeries);
	L1NC := DATASET([{'LINC' ,[{'CDS','S','CONTINENTAL'}
														]}],makeSeries);
	P0RS := DATASET([{'PORS' ,[{'BBR','S','BOXSTER'}
														]}],makeSeries);
	RMR2 := DATASET([{'RMR' ,[{'RDRAES','',''} // A/E STACKED RAIL
														]}],makeSeries);
	SU8A := DATASET([{'SUBA',[{'LO3','S','LEGACY'},
														{'OXL','S','LEGACY'},
														{'30R','S','LEGACY'},
														{'TRI3H6','S','TRIBECA'},
														{'FORFSP','S','FORESTER'},
														{'FORFSX','S','FORESTER'}
														]}],makeSeries);
	T0YT := DATASET([{'TOYT',[{'HPCCL6','3',''},// 1/2 TON
														{'HPCCLB','3',''},// 1/2 TON
														{'HPCC5D','3',''},// 1/2 TON
														{'HPCCR6','3',''},// 1/2 TON
														{'HTPXLX','3',''},// 1/2 TON
														{'3/4R44','3',''},// 3/4 TON
														{'HTPR3D','',''}, // DELUXE 1/2 TON
														{'PCCR4D','',''}, // DELUXE 1/2 TON
														{'CHGCHG','S','HIGHLANDER'},
														{'PHGMED','S','HIGHLANDER'},
														{'CHGCH5','S','HIGHLANDER'},
														{'XCBR5T','S','STD BED'}
														]}],makeSeries);
	V0LK := DATASET([{'VOLK',[{'LTH','S','NEW BEETLE'},
														{'LUX','S','NEW BEETLE'},
														{'CBE','S','NEW BEETLE'},
														{'OP1','S','NEW JETTA'},
														{'4ML','S','PASSAT'},
														{'4MS','S','PASSAT'}
														]}],makeSeries);

	SHARED makeSeriesCodes := B3NT+BU3L+CAD1+CH3V+D0DG+FIAT+F0RD+GMC2+H0ND+HYND+L1NC+P0RS+RMR2+SU8A+T0YT+V0LK;
	SHARED HASOUTLIER := SET(makeSeriesCodes,make);

	EXPORT layout_derived_model := RECORD
		RECORDOF(VINA.key_vin) AND NOT [l_vin1,l_vin2,l_vin3,l_vin4,l_vin5,l_vin6,l_vin7,l_vin8,l_vin9,l_vin10,l_vin11,l_vin12,l_vin13,l_vin14,l_vin15,l_vin16,l_vin17];
		STRING6  derived_model_code;
		STRING25 derived_model;
	END;

	SHARED deriveModel(STRING4 makCode,STRING1 vehTyp,STRING35 seriesName,STRING6 seriesCode) := FUNCTION
		makePrfx := NORMALIZE(makePrefixes(make=makCode),LEFT.prefixes,TRANSFORM(pfx,SELF:=RIGHT));
		PREFIXES := SET(makePrfx,prefix);
		seriesCd := NORMALIZE(makeSeriesCodes(make=makCode),LEFT.series,TRANSFORM(cds,SELF:=RIGHT));
		OUTLIERS := SET(seriesCd,code);
		makSrsCd := seriesCd(code=seriesCode)[1];
		
		mdlAlpha   := parseAlpha(seriesName);
		mdlDecimal := parseDecimal(seriesName);
		mdlAlfNum1 := parseAlphaNumeric(seriesName);
		mdlAlfNum2 := parseAlphaNumeric2(seriesName);
		mdlAlfDgt  := parseAlphaDigit(seriesName);
		mdlDigit   := parseDigit(seriesName);

		BOOLEAN isDigit := ut.isNumeric(seriesName[1]);
		BOOLEAN isFirst := StringLib.StringFind(seriesName,mdlAlfDgt,1)=1;

		derivedModel := MAP(
			makCode IN DONTPARSE => seriesName,
			makCode IN HASOUTLIER AND
				seriesCode IN OUTLIERS => MAP(
					makSrsCd.oper='3' => parseAlphaNumeric3(seriesName),
					makSrsCd.oper='S' => makSrsCd.model,
					seriesName),
			vehTyp IN ['M'] AND
			makCode IN CYCLES => MAP(
				isFirst AND	mdlAlfDgt !='' => mdlAlfDgt,
				mdlAlfNum1),
			makCode IN HARLEY => MAP(
				mdlAlfNum1[1]='F' => mdlAlfNum1[1..3],
				mdlAlfNum1[1]='V' => mdlAlfNum1[1..4],
				mdlAlfNum1[1]='X' AND mdlAlfDgt != '' => mdlAlfDgt,
				seriesName),
			makCode IN SERIES => MAP(
				isDigit AND mdlDigit!='' => mdlDigit,
				makCode IN HASPREFIX AND
				mdlAlfNum1 IN PREFIXES => mdlAlfNum2,
				mdlAlfNum1!='' => mdlAlfNum1,
				seriesName),
			makCode IN ACURA => MAP(
				mdlDecimal!='' => TRIM(mdlDecimal)+' '+mdlAlpha,
				mdlAlfNum1!='' => mdlAlfNum1,
				seriesName),
			makCode IN LEXUS => MAP(
				mdlAlfDgt!='' => mdlAlfDgt,
				mdlDigit!='' => TRIM(mdlAlfNum1)+mdlDigit,
			seriesName),
			makCode IN HUMMER => MAP(
				mdlAlfDgt!='' => mdlAlfDgt,
				seriesName),
			makCode IN SATURN => MAP(
				mdlAlpha!='' => mdlAlpha,
				seriesName),
			makCode IN HASPREFIX  AND
				mdlAlfNum1 IN PREFIXES AND
				mdlAlfNum2!='' => mdlAlfNum2,
			mdlAlfNum1!='' => mdlAlfNum1,
			seriesName);

		RETURN derivedModel;
	END;

	EXPORT Models(DATASET(RECORDOF(VINA.key_vin)) vinaRecs) := FUNCTION

		layout_derived_model addDerivedModel(RECORDOF(VINA.key_vin) L) := TRANSFORM
			SELF.derived_model_code := '';
			SELF.Derived_Model := deriveModel(L.make_abbreviation,L.vehicle_type,L.series_name,L.series_abbreviation);
			SELF := L;
		END;

		tmpRecs := PROJECT(vinaRecs(vehicle_type!='C'),addDerivedModel(LEFT),PREFETCH(32,PARALLEL));

		makTypModRec := RECORD
			tmpRecs.make_abbreviation;
			tmpRecs.derived_model;
			UNSIGNED8 total := COUNT(GROUP);
		END;

		makTypModCodRec := RECORD
			tmpRecs.make_abbreviation;
			tmpRecs.derived_model;
			tmpRecs.series_abbreviation;
			UNSIGNED8 total := COUNT(GROUP);
		END;

		childRec := RECORD
			tmpRecs.series_abbreviation;
		END;
		
		parentRec := RECORD(makTypModRec)
			DATASET(childRec) codes {MAXCOUNT(64)};
		END;

		parentRec getModelCodes(parentRec L,DATASET(makTypModCodRec) R) := TRANSFORM
			SELF.codes := CHOOSEN(DEDUP(SORT(PROJECT(R,childRec),RECORD),RECORD),64);
			SELF := L;
		END;

		modelCodes := DENORMALIZE(PROJECT(
			TABLE(tmpRecs,makTypModRec,make_abbreviation,derived_model,FEW),TRANSFORM(parentRec,SELF:=LEFT,SELF:=[])),
			TABLE(tmpRecs,makTypModCodRec,make_abbreviation,derived_model,series_abbreviation,FEW),
			LEFT.make_abbreviation=RIGHT.make_abbreviation AND LEFT.derived_model=RIGHT.derived_model,
			GROUP,getModelCodes(LEFT,ROWS(RIGHT)));

		layout_derived_model addDerivedModelCode(layout_derived_model L) := TRANSFORM
			model := L.derived_model;
			ndx := modelCodes(make_abbreviation=L.make_abbreviation AND derived_model=L.derived_model)[1];
			codes := SET(ndx.codes,series_abbreviation);
			SELF.derived_model_code := MAP(
				model IN codes => model,
				model[1..3] IN codes => model[1..3],
				MIN(codes));
			SELF := L;
		END;
			
		RETURN PROJECT(tmpRecs,addDerivedModelCode(LEFT),PREFETCH(32,PARALLEL));
	END;

END;