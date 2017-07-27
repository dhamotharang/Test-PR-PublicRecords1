import AID;

export layout_hunt_ccw	:=
module

	export rHuntCCWIn_layout	:=
	record
		string13	EMIDNumber;
		string2		state_code;
		string2		source_code;
		string8		file_acquired_date;
		string2		use_code;
		string10	prefix_title;
		string30	last_name;
		string30	first_name;
		string30	middle_name;
		string30	maiden_prior;
		string3		suffix;
		string15	votefiller;											//layout chg of of 09/23/11: IDType
		string12	source_voterId;
		string8		DateOfBirth;
		string2		AgeCat;
		string2		HeadHousehold;
		string18	place_of_birth;
		string30	occupation;
		string30	maiden_name;										//layout chg of of 09/23/11: Precinct
		string15	motorVoterId;
		string10	regSource;
		string8		RegDate;
		string2		race;
		string1		gender;
		string2		politicalparty;
		string10	VoterHomePhone;
		string10	VoterWorkPhone;
		string10	VoterOtherPhone;								//layout chg of of 09/23/11: Ward1
		string1		ActiveOrInactive;
		string1		votefiller2;										//layout chg of of 09/23/11: GenderMatches
		string1		active_other;										//layout chg of of 09/23/11: IDCode
		string2		voterStatus;
		string40	ResAddr1;
		string40	ResAddr2;
		string40	Res_city;
		string2		Res_state;
		string9		Res_zip;
		string3		Res_county;
		string40	MailAddr1;
		string40	MailAddr2;
		string40	mail_city;
		string2		mail_state;
		string9		mail_zip;
		string3		mail_county;
		string40	CASSAddr1;										//layout chg of of 09/23/11: PrecinctPartTextDesig
		string40	CASSAddr2;										//layout chg of of 09/23/11: PrecinctPartTextName
		string40	CASS_City;										//layout chg of of 09/23/11: PrecinctTextDesig
		string2		CASS_State;										//layout chg of of 09/23/11: TBD1
		string9		CASS_Zip;											//layout chg of of 09/23/11: SupervisorDistrict
		string3		CASS_County;									//layout chg of of 09/23/11: TimeZones
		string5		towncode;
		string5		districtcode;
		string5		countycode;
		string5		schoolcode;
		string1		cityInOut;
		string20	spec_dist1;										//layout chg of of 09/23/11: District
		string20	spec_dist2;										//layout chg of of 09/23/11: Ward2
		string7		precinct1;										//layout chg of of 09/23/11: CityCountyCouncil
		string7		precinct2;										//layout chg of of 09/23/11: CountyPrecinct
		string7		precinct3;										//layout chg of of 09/23/11: CountyComm
		string7		villagePrecinct;
		string7		schoolPrecinct;								//layout chg of of 09/23/11: SchoolBoard
		string7		ward;													//layout chg of of 09/23/11: Ward3
		string7		precinct_cityTown;
		string7		ANCSMDinDC;										//layout chg of of 09/23/11: TownCityCouncil1
		string4		cityCouncilDist;							//layout chg of of 09/23/11: TownCityCouncil2
		string4		countyCommDist;
		string3		stateHouse;
		string3		stateSenate;
		string3		USHouse;
		string4		elemSchoolDist;
		string4		schoolDist;										//layout chg of of 09/23/11: Regents
		string5		schoolFiller;									//layout chg of of 09/23/11: WaterShed
		string4		CommCollDist;
		string5		dist_filler;									//layout chg of of 09/23/11: Education
		string4		municipal;
		string4		VillageDist;
		string4		PoliceJury;
		string4		PoliceDist;										//layout chg of of 09/23/11: PoliceConstable
		string4		PublicServComm;
		string4		Rescue;
		string4		Fire;
		string4		Sanitary;
		string4		SewerDist;
		string4		WaterDist;
		string4		MosquitoDist;
		string4		TaxDist;
		string4		SupremeCourt;
		string4		JusticeOfPeace;
		string4		JudicialDist;									//layout chg of of 09/23/11: FreeHolder
		string4		SuperiorCtDist;
		string4		AppealsCt;
		string4		CourtFIller;									//layout chg of of 09/23/11: MuniCourt
		string2		ContributorParty;							//layout chg of of 09/23/11: CassAddressType
		string2		RecipientParty;								//layout chg of of 09/23/11: CassDeliveryPoints
		string8		DateOfCont;										//layout chg of of 09/23/11: CarrierRoute
		string7		DollarAmt;										//layout chg of of 09/23/11: BGED
		string3		OfficeContributedTo;					//layout chg of of 09/23/11: FipsGuessCongress
		string7		CumulDollarAmt;								//layout chg of of 09/23/11: Latitude
		string21	ContFiller1;									//layout chg of of 09/23/11: CountySpellCass
		string21	ContFiller2;									//layout chg of of 09/23/11: Census
		string5		ContType;											//layout chg of of 09/23/11: Fips
		string15	ContFiller3;									//layout chg of of 09/23/11: Longitude
		string2		Primary02;
		string2		Special02;
		string2		Other02;
		string2		Special202;
		string2		General02;
		string2		Primary01;
		string2		Special01;
		string2		Other01;
		string2		Special201;
		string2		General01;
		string2		Pres00;
		string2		Primary00;
		string2		Special00;
		string2		Other00;
		string2		Special200;
		string2		General00;
		string2		Primary99;
		string2		Special99;
		string2		Other99;
		string2		Special299;
		string2		General99;
		string2		Primary98;
		string2		Special98;
		string2		Other98;
		string2		Special298;
		string2		General98;
		string2		Primary97;
		string2		Special97;
		string2		Other97;
		string2		Special297;
		string2		General97;
		string2		Pres96;
		string2		Primary96;
		string2		Special96;
		string2		Other96;
		string2		Special296;
		string2		General96;
		string8		LastDateVote;
		string10	HistoryFiller;									//layout chg of of 09/23/11: ChangeDate
		string15	HuntFishPerm;
		string8		DateLicense;
		string2		HomeState;
		string1		Resident;
		string1		NonResident;
		string1		Hunt;
		string1		Fish;
		string1		ComboSuper;
		string1		Sportsman;
		string1		Trap;
		string1		Archery;
		string1		Muzzle;
		string1		Drawing;
		string1		Day1;
		string1		Day3;
		string1		Day7;
		string1		Day14to15;
		string1		DayFiller;
		string1		SeasonAnnual;
		string1		LifeTimePermit;
		string1		LandOwner;
		string1		Family;
		string1		Junior;
		string1		SeniorCitizen;
		string1		CrewMemeber;
		string1		Retarded;											//layout chg of of 09/23/11: Handicap
		string1		Indian;
		string1		Serviceman;
		string1		Disabled;
		string1		LowIncome;
		string3		RegionCounty;
		string1		HuntType;											//layout chg of of 09/23/11: HuntingBlind
		string47	HuntFiller;										//layout chg of of 09/23/11: Location
		string1		Salmon;
		string1		Freshwater;
		string1		Saltwater;
		string1		LakesandResevoirs;
		string1		SetLineFish;
		string1		Trout;
		string1		FallFishing;									//layout chg of of 09/23/11: FoxCoyoteWolf
		string1		Steelhead;
		string1		WhiteJubHerring;
		string1		Sturgeon;											//layout chg of of 09/23/11: Otter
		string1		ShellfishCrab;								//layout chg of of 09/23/11: MusselRoe
		string1		ShellfishLobster;							//layout chg of of 09/23/11: Shellfish
		string1		Deer;
		string1		Bear;
		string1		Elk;
		string1		Moose;
		string1		Buffalo;
		string1		Antelope;
		string1		SikeBull;
		string1		BighornSheep;
		string1		Javelina;
		string1		Cougar;
		string1		Anterless;
		string1		Pheasant;
		string1		Goose;
		string1		Duck;
		string1		Turkey;
		string1		SnowMobile;										//layout chg of of 09/23/11: Subscriber
		string1		BigGame;
		string1		SkiPass;											//layout chg of of 09/23/11: TBD2
		string1		MigratoryBirds;
		string1		SmallGame;
		string1		Sturgeon2;
		string1		Gun;
		string1		Bonus;
		string1		ApplicantLottery;
		string1		OtherBirds;										//layout chg of of 09/23/11: WaterFowl
		string83	huntfill1;										//layout chg of of 09/23/11: email
		string10	BoatIndexNum;									//layout chg of of 09/23/11: ParkLake
		string1		BoatCoOwner;									//layout chg of of 09/23/11: CCWPermitee
		string20	HullIDNum;										//layout chg of of 09/23/11: Judiciary1
		string4		YearMade;											//layout chg of of 09/23/11: PercentVoted
		string20	Model;												//layout chg of of 09/23/11: Township
		string20	Manufacturer;									//layout chg of of 09/23/11: TownCityCouncil3
		string3		Len;													//layout chg of of 09/23/11: TempHuntFish
		string2		HullConstruction;							//layout chg of of 09/23/11: ComboSuperLifetime
		string2		PrimUse;											//layout chg of of 09/23/11: TBD3
		string2		FuelType;											//layout chg of of 09/23/11: TBD4
		string2		Propulsion;										//layout chg of of 09/23/11: TBD5
		string2		ModelType;										//layout chg of of 09/23/11: TBD6
		string8		RegExpiryDate;								//layout chg of of 09/23/11: HuntFishExpireDate
		string10	TitleNum;											//layout chg of of 09/23/11: SchoolDistrict
		string2		StatePrimaryUse;							//layout chg of of 09/23/11: TimesVoted
		string3		TitleStatus;									//layout chg of of 09/23/11: TBD7
		string2		Vessel;												//layout chg of of 09/23/11: TBD8
		string15	SpecialRegistration;					//layout chg of of 09/23/11: Road
		string15	BoatFill1;										//layout chg of of 09/23/11: SchoolName
		string5		BoatFill2;										//layout chg of of 09/23/11: CityDistrict
		string15	BoatFill3;										//layout chg of of 09/23/11: CCWRejectReason
		string15	CCWPermNum;
		string15	CCWWeaponType;
		string8		CCWRegDate;
		string8		CCWExpiryDate;
		string10	CCWPermType;
		string10	CCWFill1;											//layout chg of of 09/23/11: Regional
		string20	CCWFill2;											//layout chg of of 09/23/11: TBD9
		string15	CCWFill3;											//layout chg of of 09/23/11: CircuitCourt
		string15	CCWFill4;											//layout chg of of 09/23/11: JudiciaryMagistrate
		string15	MiscFill1;										//layout chg of of 09/23/11: Chancery
		string15	MiscFIll2;										//layout chg of of 09/23/11: DistrictAttorney
		string15	MiscFill3;										//layout chg of of 09/23/11: Judiciary2
		string15	MiscFill4;										//layout chg of of 09/23/11: BoardEdu
		string15	MiscFill5;										//layout chg of of 09/23/11: LocalityName
		string19	FillerOther1;									//layout chg of of 09/23/11: SourceCounty
		string40	FillerOther2;									//layout chg of of 09/23/11: MailCountry
		string10	FillerOther3;									//layout chg of of 09/23/11: Library
		string10	FillerOther4;									//layout chg of of 09/23/11: REsZipPlusFour
		string10	FillerOther5;									//layout chg of of 09/23/11: Hospital
		string11	FillerOther6;									//layout chg of of 09/23/11: Soil
		string11	FillerOther7;									//layout chg of of 09/23/11: LevyFlood
		string11	FillerOther8;									//layout chg of of 09/23/11: Agriculture
		string11	FillerOther9;									//layout chg of of 09/23/11: Conservancy
		string11	FillerOther10;								//layout chg of of 09/23/11: SoilWater
		string2		EOR;													//layout chg of of 09/23/11: TBD10
		string2		stuff;
	end;

	export rHuntCCWClean_layout	:=
	RECORD
		unsigned4	Append_SeqNum	:=	0;
		unsigned8 persistent_record_id := 0;
		string8		process_date;
		string8   date_first_seen;
		string8   date_last_seen;
		string3		score;
		string9		best_ssn;
		string12	did_out;
		string7   Source;
		string4		file_id;
		string13	vendor_id;
		string2		source_state;
		string2		source_code;
		string8		file_acquired_date;
		string2		_use;
		string10	title_in;
		string30	lname_in;
		string30	fname_in;
		string30	mname_in;
		string30	maiden_prior;
		string3		name_suffix_in;
		string15	votefiller;
		string12	source_voterId;
		string8		dob_str_in;
		string2		ageCat;
		string2		headHousehold;
		string18	place_of_birth;
		string30	occupation;
		string30	maiden_name;
		string15	motorVoterId;
		string10	regSource;
		string8		regDate_in;
		string2		race;
		string1		gender;
		string2		poliparty;
		string10	phone;
		string10	work_phone;
		string10	other_phone;
		string1		active_status;
		string1		votefiller2;
		string1		active_other;
		string2		voterStatus;
		string40	resAddr1;
		string40	resAddr2;
		string40	res_city;
		string2		res_state;
		string9		res_zip;
		string3		res_county;
		string40	mail_addr1;
		string40	mail_addr2;
		string40	mail_city;
		string2		mail_state;
		string9		mail_zip;
		string3		mail_county;
		string40	CASS_Addr1;
		string40	CASS_Addr2;
		string40	CASS_City;
		string2		CASS_State;
		string9		CASS_Zip;
		string3		CASS_County;
		string5		towncode;
		string5		distcode;
		string5		countycode;
		string5		schoolcode;
		string1		cityInOut;
		string20	spec_dist1;
		string20	spec_dist2;
		string7		precinct1;
		string7		precinct2;
		string7		precinct3;
		string7		villagePrecinct;
		string7		schoolPrecinct;
		string7		ward;
		string7		precinct_cityTown;
		string7		ANCSMDinDC;
		string4		cityCouncilDist;
		string4		countyCommDist;
		string3		stateHouse;
		string3		stateSenate;
		string3		USHouse;
		string4		elemSchoolDist;
		string4		schoolDist;
		string5		schoolFiller;
		string4		CommCollDist;
		string5		dist_filler;
		string4		municipal;
		string4		VillageDist;
		string4		PoliceJury;
		string4		PoliceDist;
		string4		PublicServComm;
		string4		Rescue;
		string4		Fire;
		string4		Sanitary;
		string4		SewerDist;
		string4		WaterDist;
		string4		MosquitoDist;
		string4		TaxDist;
		string4		SupremeCourt;
		string4		JusticeOfPeace;
		string4		JudicialDist;
		string4		SuperiorCtDist;
		string4		AppealsCt;
		string4		CourtFIller;
		string2		ContributorParty;
		string2		RecptParty;
		string8		DateOfContr_in;
		string7		DollarAmt;
		string3		OfficeContTo;
		string7		CumulDollarAmt;
		string21	ContFiller1;
		string21	ContFiller2;
		string5		ContType;
		string15	ContFiller3;
		string2		Primary02;
		string2		Special02;
		string2		Other02;
		string2		Special202;
		string2		General02;
		string2		Primary01;
		string2		Special01;
		string2		Other01;
		string2		Special201;
		string2		General01;
		string2		Pres00;
		string2		Primary00;
		string2		Special00;
		string2		Other00;
		string2		Special200;
		string2		General00;
		string2		Primary99;
		string2		Special99;
		string2		Other99;
		string2		Special299;
		string2		General99;
		string2		Primary98;
		string2		Special98;
		string2		Other98;
		string2		Special298;
		string2		General98;
		string2		Primary97;
		string2		Special97;
		string2		Other97;
		string2		Special297;
		string2		General97;
		string2		Pres96;
		string2		Primary96;
		string2		Special96;
		string2		Other96;
		string2		Special296;
		string2		General96;
		string8		LastDayVote_in;
		string10	HistoryFiller;
		string15	HuntFishPerm;
		string8		DateLicense_in;
		string2		HomeState;
		string1		Resident;
		string1		NonResident;
		string1		Hunt;
		string1		Fish;
		string1		ComboSuper;
		string1		Sportsman;
		string1		Trap;
		string1		Archery;
		string1		Muzzle;
		string1		Drawing;
		string1		Day1;
		string1		Day3;
		string1		Day7;
		string1		Day14to15;
		string1		DayFiller;
		string1		SeasonAnnual;
		string1		LifeTimePermit;
		string1		LandOwner;
		string1		Family;
		string1		Junior;
		string1		SeniorCit;
		string1		CrewMemeber;
		string1		Retarded;
		string1		Indian;
		string1		Serviceman;
		string1		Disabled;
		string1		LowIncome;
		string3		RegionCounty;
		string1		Blind;
		string47	HuntFiller;
		string1		Salmon;
		string1		Freshwater;
		string1		Saltwater;
		string1		LakesandResevoirs;
		string1		SetLineFish;
		string1		Trout;
		string1		FallFishing;
		string1		Steelhead;
		string1		WhiteJubHerring;
		string1		Sturgeon;
		string1		ShellfishCrab;
		string1		ShellfishLobster;
		string1		Deer;
		string1		Bear;
		string1		Elk;
		string1		Moose;
		string1		Buffalo;
		string1		Antelope;
		string1		SikeBull;
		string1		Bighorn;
		string1		Javelina;
		string1		Cougar;
		string1		Anterless;
		string1		Pheasant;
		string1		Goose;
		string1		Duck;
		string1		Turkey;
		string1		SnowMobile;
		string1		BigGame;
		string1		SkiPass;
		string1		MigBird;
		string1		SmallGame;
		string1		Sturgeon2;
		string1		Gun;
		string1		Bonus;
		string1		Lottery;
		string1		OtherBirds;
		string83	huntfill1;
		string10	BoatIndexNum;
		string1		BoatCoOwner;
		string20	HullIDNum;
		string4		YearMade;
		string20	Model;
		string20	Manufacturer;
		string3		Lengt;
		string2		HullConstruct;
		string2		PrimUse;
		string2		FuelType;
		string2		Propulsion;
		string2		ModelType;
		string8		RegExpDate_in;
		string10	TitleNum;
		string2		StPrimUse;
		string3		TitleStatus;
		string2		Vessel;
		string15	SpecReg;
		string15	BoatFill1;
		string5		BoatFill2;
		string15	BoatFill3;
		string15	CCWPermNum;
		string15	CCWWeaponType;
		string8		CCWRegDate_in;
		string8		CCWExpDate_in;
		string46	CCWPermType;
		string10	CCWFill1;
		string20	CCWFill2;
		string15	CCWFill3;
		string15	CCWFill4;
		string15	MiscFill1;
		string15	MiscFIll2;
		string15	MiscFill3;
		string15	MiscFill4;
		string15	MiscFill5;
		string19	FillerOther1;
		string40	FillerOther2;
		string10	FillerOther3;
		string10	FillerOther4;
		string10	FillerOther5;
		string11	FillerOther6;
		string11	FillerOther7;
		string11	FillerOther8;
		string11	FillerOther9;
		string11	FillerOther10;
		string2		EOR;
		string2		stuff;
		
		string8 	dob_str;
		string8 	regDate;
		string8 	DateOfContr;
    string8 	LastDayVote;
    string8 	DateLicense;
    string8 	RegExpDate;
    string8 	CCWRegDate;
    string8 	CCWExpDate;
		
		string5		title;
		string20	fname;
		string20	mname;
		string20	lname;
		string5		name_suffix;
		string3		score_on_input;
		string3		cleaner_type;
	end;
	
	export rHuntCCWCleanAddr_layout	:=
	record
		unsigned4	Append_SeqNum	:=	0;
		unsigned8 persistent_record_id := 0;
		string8		process_date;
		string8   date_first_seen;
		string8   date_last_seen;
		string3		score;
		string9		best_ssn;
		string12	did_out;
		string7   Source;
		string4		file_id;
		string13	vendor_id;
		string2		source_state;
		string2		source_code;
		string8		file_acquired_date;
		string2		_use;
		string10	title_in;
		string30	lname_in;
		string30	fname_in;
		string30	mname_in;
		string30	maiden_prior;
		string3		name_suffix_in;
		string15	votefiller;
		string12	source_voterId;
		string8		dob_str_in;
		string2		ageCat;
		string2		headHousehold;
		string18	place_of_birth;
		string30	occupation;
		string30	maiden_name;
		string15	motorVoterId;
		string10	regSource;
		string8		regDate_in;
		string2		race;
		string1		gender;
		string2		poliparty;
		string10	phone;
		string10	work_phone;
		string10	other_phone;
		string1		active_status;
		string1		votefiller2;
		string1		active_other;
		string2		voterStatus;
		string40	resAddr1;
		string40	resAddr2;
		string40	res_city;
		string2		res_state;
		string9		res_zip;
		string3		res_county;
		string40	mail_addr1;
		string40	mail_addr2;
		string40	mail_city;
		string2		mail_state;
		string9		mail_zip;
		string3		mail_county;
		string40	addr_filler1;
		string40	addr_filler2;
		string40	city_filler;
		string2		state_filler;
		string9		zip_filler;
		string3		county_filler;
		string5		towncode;
		string5		distcode;
		string5		countycode;
		string5		schoolcode;
		string1		cityInOut;
		string20	spec_dist1;
		string20	spec_dist2;
		string7		precinct1;
		string7		precinct2;
		string7		precinct3;
		string7		villagePrecinct;
		string7		schoolPrecinct;
		string7		ward;
		string7		precinct_cityTown;
		string7		ANCSMDinDC;
		string4		cityCouncilDist;
		string4		countyCommDist;
		string3		stateHouse;
		string3		stateSenate;
		string3		USHouse;
		string4		elemSchoolDist;
		string4		schoolDist;
		string5		schoolFiller;
		string4		CommCollDist;
		string5		dist_filler;
		string4		municipal;
		string4		VillageDist;
		string4		PoliceJury;
		string4		PoliceDist;
		string4		PublicServComm;
		string4		Rescue;
		string4		Fire;
		string4		Sanitary;
		string4		SewerDist;
		string4		WaterDist;
		string4		MosquitoDist;
		string4		TaxDist;
		string4		SupremeCourt;
		string4		JusticeOfPeace;
		string4		JudicialDist;
		string4		SuperiorCtDist;
		string4		AppealsCt;
		string4		CourtFIller;
		string2		ContributorParty;
		string2		RecptParty;
		string8		DateOfContr_in;
		string7		DollarAmt;
		string3		OfficeContTo;
		string7		CumulDollarAmt;
		string21	ContFiller1;
		string21	ContFiller2;
		string5		ContType;
		string15	ContFiller3;
		string2		Primary02;
		string2		Special02;
		string2		Other02;
		string2		Special202;
		string2		General02;
		string2		Primary01;
		string2		Special01;
		string2		Other01;
		string2		Special201;
		string2		General01;
		string2		Pres00;
		string2		Primary00;
		string2		Special00;
		string2		Other00;
		string2		Special200;
		string2		General00;
		string2		Primary99;
		string2		Special99;
		string2		Other99;
		string2		Special299;
		string2		General99;
		string2		Primary98;
		string2		Special98;
		string2		Other98;
		string2		Special298;
		string2		General98;
		string2		Primary97;
		string2		Special97;
		string2		Other97;
		string2		Special297;
		string2		General97;
		string2		Pres96;
		string2		Primary96;
		string2		Special96;
		string2		Other96;
		string2		Special296;
		string2		General96;
		string8		LastDayVote_in;
		string10	HistoryFiller;
		string15	HuntFishPerm;
		string8		DateLicense_in;
		string2		HomeState;
		string1		Resident;
		string1		NonResident;
		string1		Hunt;
		string1		Fish;
		string1		ComboSuper;
		string1		Sportsman;
		string1		Trap;
		string1		Archery;
		string1		Muzzle;
		string1		Drawing;
		string1		Day1;
		string1		Day3;
		string1		Day7;
		string1		Day14to15;
		string1		DayFiller;
		string1		SeasonAnnual;
		string1		LifeTimePermit;
		string1		LandOwner;
		string1		Family;
		string1		Junior;
		string1		SeniorCit;
		string1		CrewMemeber;
		string1		Retarded;
		string1		Indian;
		string1		Serviceman;
		string1		Disabled;
		string1		LowIncome;
		string3		RegionCounty;
		string1		Blind;
		string47	HuntFiller;
		string1		Salmon;
		string1		Freshwater;
		string1		Saltwater;
		string1		LakesandResevoirs;
		string1		SetLineFish;
		string1		Trout;
		string1		FallFishing;
		string1		Steelhead;
		string1		WhiteJubHerring;
		string1		Sturgeon;
		string1		ShellfishCrab;
		string1		ShellfishLobster;
		string1		Deer;
		string1		Bear;
		string1		Elk;
		string1		Moose;
		string1		Buffalo;
		string1		Antelope;
		string1		SikeBull;
		string1		Bighorn;
		string1		Javelina;
		string1		Cougar;
		string1		Anterless;
		string1		Pheasant;
		string1		Goose;
		string1		Duck;
		string1		Turkey;
		string1		SnowMobile;
		string1		BigGame;
		string1		SkiPass;
		string1		MigBird;
		string1		SmallGame;
		string1		Sturgeon2;
		string1		Gun;
		string1		Bonus;
		string1		Lottery;
		string1		OtherBirds;
		string83	huntfill1;
		string10	BoatIndexNum;
		string1		BoatCoOwner;
		string20	HullIDNum;
		string4		YearMade;
		string20	Model;
		string20	Manufacturer;
		string3		Lengt;
		string2		HullConstruct;
		string2		PrimUse;
		string2		FuelType;
		string2		Propulsion;
		string2		ModelType;
		string8		RegExpDate_in;
		string10	TitleNum;
		string2		StPrimUse;
		string3		TitleStatus;
		string2		Vessel;
		string15	SpecReg;
		string15	BoatFill1;
		string5		BoatFill2;
		string15	BoatFill3;
		string15	CCWPermNum;
		string15	CCWWeaponType;
		string8		CCWRegDate_in;
		string8		CCWExpDate_in;
		string46	CCWPermType;
		string10	CCWFill1;
		string20	CCWFill2;
		string15	CCWFill3;
		string15	CCWFill4;
		string15	MiscFill1;
		string15	MiscFIll2;
		string15	MiscFill3;
		string15	MiscFill4;
		string15	MiscFill5;
		string19	FillerOther1;
		string40	FillerOther2;
		string10	FillerOther3;
		string10	FillerOther4;
		string10	FillerOther5;
		string11	FillerOther6;
		string11	FillerOther7;
		string11	FillerOther8;
		string11	FillerOther9;
		string11	FillerOther10;
		string2		EOR;
		string2		stuff;
		
		string8 	dob_str;
		string8 	regDate;
		string8 	DateOfContr;
    string8 	LastDayVote;
    string8 	DateLicense;
    string8 	RegExpDate;
    string8 	CCWRegDate;
    string8 	CCWExpDate;
		
		string5		title;
		string20	fname;
		string20	mname;
		string20	lname;
		string5		name_suffix;
		string3		score_on_input;
		
		string100	Append_Prep_ResAddress1		:=	'';
		string50	Append_Prep_ResAddress2		:=	'';
		AID.Common.xAID	Append_ResRawAID		:=	0;
		string100	Append_Prep_MailAddress1	:=	'';
		string50	Append_Prep_MailAddress2	:=	'';
		AID.Common.xAID	Append_MailRawAID		:=	0;
		string100	Append_Prep_CASSAddress1	:=	'';
		string50	Append_Prep_CASSAddress2	:=	'';
		AID.Common.xAID	Append_CASSRawAID		:=	0;
		
		string10	AID_ResClean_prim_range		:=	'';
		string2		AID_ResClean_predir				:=	'';
		string28	AID_ResClean_prim_name		:=	'';
		string4		AID_ResClean_addr_suffix	:=	'';
		string2		AID_ResClean_postdir			:=	'';
		string10	AID_ResClean_unit_desig		:=	'';
		string8		AID_ResClean_sec_range		:=	'';
		string25	AID_ResClean_p_city_name	:=	'';
		string25	AID_ResClean_v_city_name	:=	'';
		string2		AID_ResClean_st						:=	'';
		string5		AID_ResClean_zip					:=	'';
		string4		AID_ResClean_zip4					:=	'';
		string4		AID_ResClean_cart					:=	'';
		string1		AID_ResClean_cr_sort_sz		:=	'';
		string4		AID_ResClean_lot					:=	'';
		string1		AID_ResClean_lot_order		:=	'';
		string2		AID_ResClean_dpbc					:=	'';
		string1		AID_ResClean_chk_digit		:=	'';
		string2		AID_ResClean_record_type	:=	'';
		string2		AID_ResClean_ace_fips_st	:=	'';
		string3		AID_ResClean_fipscounty		:=	'';
		string10	AID_ResClean_geo_lat			:=	'';
		string11	AID_ResClean_geo_long			:=	'';
		string4		AID_ResClean_msa					:=	'';
		string7		AID_ResClean_geo_blk			:=	'';
		string1		AID_ResClean_geo_match		:=	'';
		string4		AID_ResClean_err_stat			:=	'';
		
		string10	AID_MailClean_prim_range	:=	'';
		string2		AID_MailClean_predir			:=	'';
		string28	AID_MailClean_prim_name		:=	'';
		string4		AID_MailClean_addr_suffix	:=	'';
		string2		AID_MailClean_postdir			:=	'';
		string10	AID_MailClean_unit_desig	:=	'';
		string8		AID_MailClean_sec_range		:=	'';
		string25	AID_MailClean_p_city_name	:=	'';
		string25	AID_MailClean_v_city_name	:=	'';
		string2		AID_MailClean_st					:=	'';
		string5		AID_MailClean_zip					:=	'';
		string4		AID_MailClean_zip4				:=	'';
		string4		AID_MailClean_cart				:=	'';
		string1		AID_MailClean_cr_sort_sz	:=	'';
		string4		AID_MailClean_lot					:=	'';
		string1		AID_MailClean_lot_order		:=	'';
		string2		AID_MailClean_dpbc				:=	'';
		string1		AID_MailClean_chk_digit		:=	'';
		string2		AID_MailClean_record_type	:=	'';
		string2		AID_MailClean_ace_fips_st	:=	'';
		string3		AID_MailClean_fipscounty	:=	'';
		string10	AID_MailClean_geo_lat			:=	'';
		string11	AID_MailClean_geo_long		:=	'';
		string4		AID_MailClean_msa					:=	'';
		string7		AID_MailClean_geo_blk			:=	'';
		string1		AID_MailClean_geo_match		:=	'';
		string4		AID_MailClean_err_stat		:=	'';
		
		string10	prim_range;
		string2		predir;
		string28	prim_name;
		string4		suffix;
		string2		postdir;
		string10	unit_desig;
		string8		sec_range;
		string25	p_city_name;
		string25	city_name;
		string2		st;
		string5		zip;
		string4		zip4;
		string4		cart;
		string1		cr_sort_sz;
		string4		lot;
		string1		lot_order;
		string2		dpbc;
		string1		chk_digit;
		string2		record_type;
		string2		ace_fips_st;
		string3		county;
		string10	geo_lat;
		string11	geo_long;
		string4		msa;
		string7		geo_blk;
		string1		geo_match;
		string4		err_stat;
		string10	mail_prim_range;
		string2		mail_predir;
		string28	mail_prim_name;
		string4		mail_addr_suffix;
		string2		mail_postdir;
		string10	mail_unit_desig;
		string8		mail_sec_range;
		string25	mail_p_city_name;
		string25	mail_v_city_name;
		string2		mail_st;
		string5		mail_ace_zip;
		string4		mail_zip4;
		string4		mail_cart;
		string1		mail_cr_sort_sz;
		string4		mail_lot;
		string1		mail_lot_order;
		string2		mail_dpbc;
		string1		mail_chk_digit;
		string2		mail_record_type;
		string2		mail_ace_fips_st;
		string3		mail_fipscounty;
		string10	mail_geo_lat;
		string11	mail_geo_long;
		string4		mail_msa;
		string7		mail_geo_blk;
		string1		mail_geo_match;
		string4		mail_err_stat;
		string10	cass_prim_range;
		string2		cass_predir;
		string28	cass_prim_name;
		string4		cass_addr_suffix;
		string2		cass_postdir;
		string10	cass_unit_desig;
		string8		cass_sec_range;
		string25	cass_p_city_name;
		string25	cass_v_city_name;
		string2		cass_st;
		string5		cass_ace_zip;
		string4		cass_zip4;
		string4		cass_cart;
		string1		cass_cr_sort_sz;
		string4		cass_lot;
		string1		cass_lot_order;
		string2		cass_dpbc;
		string1		cass_chk_digit;
		string2		cass_record_type;
		string2		cass_ace_fips_st;
		string3		cass_fipscounty;
		string10	cass_geo_lat;
		string11	cass_geo_long;
		string4		cass_msa;
		string7		cass_geo_blk;
		string1		cass_geo_match;
		string4		cass_err_stat;
	end;
	
end;