
import LiensV2_preprocess;

export Filenames(integer cnt = 0) :=
module
	//////////////////////////////////////////////////////////////////
	// -- Declaration of Value Types
	//////////////////////////////////////////////////////////////////
	
	
	export federalupdate	:= thor_cluster + 'in::liensv2::nyf::federal' ;
	export okclienupdate	:= thor_cluster + 'in::liensv2::hgn::okclien' ;
	export ServAbsupdate	:= thor_cluster + 'in::liensv2::sab::ServAbs' ;
	export BusDtorupdate	:= thor_cluster + 'in::liensv2::caf::BusDtor' ;
	export BusSecpupdate	:= thor_cluster + 'in::liensv2::caf::BusSecp' ;
    export filingsupdate	:= thor_cluster + 'in::liensv2::caf::filings' ;
	export PerDtorupdate	:= thor_cluster + 'in::liensv2::caf::PerDtor' ;
	export PerSecpupdate	:= thor_cluster + 'in::liensv2::caf::PerSecp' ;
	export chgfilgupdate	:= thor_cluster + 'in::liensv2::caf::chgfilg' ;
	export judgmtsupdate	:= thor_cluster + 'in::liensv2::nyc::judgmts' ;
	export crdattyupdate    := thor_cluster + 'in::liensv2::sup::crdatty' ;
    export credtorupdate    := thor_cluster + 'in::liensv2::sup::credtor' ;
    export detattyupdate    := thor_cluster + 'in::liensv2::sup::detatty' ;
    export debtornupdate    := thor_cluster + 'in::liensv2::sup::debtorn' ;
    export judmentupdate    := thor_cluster + 'in::liensv2::sup::judment' ;
    export subjdmtupdate    := thor_cluster + 'in::liensv2::sup::subjdmt' ;
    export remarksupdate    := thor_cluster + 'in::liensv2::sup::remarks' ;
		export hgn := LiensV2_preprocess.root+'hgn';
	
/*	shared layout_superfiles := 
	record
		string superfile;
	end;

	export input_superfiles := DATASET([(federalupdate),
	                                    (ServAbsupdate),
										(BusDtorupdate),
										(BusSecpupdate),
										(okclienupdate),
										(filingsupdate),
										(PerDtorupdate),
										(PerSecpupdate),
										(chgfilgupdate),
										(judgmtsupdate)] , layout_superfiles);*/


end;


		