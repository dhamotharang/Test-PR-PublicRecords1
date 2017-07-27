import risk_indicators, riskwise, riskwisefcra, ut;

export RVP1503_1_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam) := FUNCTION

  RVP_DEBUG := FALSE;	
	
	#if(RVP_DEBUG)
		layout_debug := record
			integer        sysdate;
			integer         bureau_adl_eq_fseen_pos;
			string        bureau_adl_fseen_eq;
			integer         _bureau_adl_fseen_eq;
			integer        _src_eq_adl_fseen;
			Boolean        ver_src_eq;
			integer         time_at_bureau;
			Boolean         bureau_no_hit;
			Boolean        identity_unknown;
			integer        rvp1503_1_0;                                
			models.layout_modelout;
			risk_indicators.Layout_Boca_Shell clam;
    END;
    layout_debug doModel( clam le ) := TRANSFORM
  #else
    models.layout_modelout doModel( clam le ) := TRANSFORM
  #end	
	
	truedid                          := le.truedid;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;


NULL := -999999999;

sysdate := common.sas_date(if(le.historydate=999999, (string)ut.getdate, (string6)le.historydate+'01'));

bureau_adl_eq_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');

bureau_adl_fseen_eq := if(bureau_adl_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos, ','));

_bureau_adl_fseen_eq := common.sas_date((string)(bureau_adl_fseen_eq));

_src_eq_adl_fseen := min(if(_bureau_adl_fseen_eq = NULL, -NULL, _bureau_adl_fseen_eq), 999999);

time_at_bureau_1 := map(
    not(truedid)               => NULL,
    _src_eq_adl_fseen = 999999 => -1,
                                  if ((sysdate - _src_eq_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_eq_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_eq_adl_fseen) / (365.25 / 12))));

ver_src_eq := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E') > 0;

time_at_bureau := map(
    (integer)ver_src_eq = 0       => 0,
    (integer)time_at_bureau_1 = 0 => 1,
    (integer)time_at_bureau_1 > 0 => time_at_bureau_1,
                            0);

bureau_no_hit :=(integer)ver_src_eq = 0 or time_at_bureau = 0;

identity_unknown := not(truedid);

rvp1503_1_0 := map(
    (integer)identity_unknown = 1 => 0,
    (integer)bureau_no_hit = 1    => 1,
    time_at_bureau < 6   => 2,
    time_at_bureau <= 12 => 3,
    time_at_bureau <= 18 => 4,
                            5);


//Intermediate variables
	#if(RVP_DEBUG)
										self.clam                             := le ;
                    self.sysdate                          := sysdate;
                    self.bureau_adl_eq_fseen_pos          := bureau_adl_eq_fseen_pos;
                    self.bureau_adl_fseen_eq              := bureau_adl_fseen_eq;
                    self._bureau_adl_fseen_eq             := _bureau_adl_fseen_eq;
                    self._src_eq_adl_fseen                := _src_eq_adl_fseen;
                    self.ver_src_eq                       := ver_src_eq;
                    self.time_at_bureau                   := time_at_bureau;
                    self.bureau_no_hit                    := bureau_no_hit;
                    self.identity_unknown                 := identity_unknown;
                    self.rvp1503_1_0                      := rvp1503_1_0;


	#end
	
	
	self.seq := le.seq;
	PrescreenOptOut := risk_indicators.iid_constants.CheckFlag( risk_indicators.iid_constants.IIDFlag.IsPreScreen, le.iid.iid_flags );
	self.score := if( risk_indicators.rcset.isCode95(PreScreenOptOut), '222', (string3)rvp1503_1_0 );
	self.ri := if( risk_indicators.rcset.isCode95(PreScreenOptOut), DATASET([{'95', risk_indicators.getHRIDesc('95')}],risk_indicators.Layout_Desc) );

	END;

	model := project( clam, doModel(left) );

	return model;
END;