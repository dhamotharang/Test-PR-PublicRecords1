import risk_indicators, riskwise, riskwisefcra, ut, std, riskview;

export RVC1412_1_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clamPre, BOOLEAN isCalifornia = FALSE, BOOLEAN isFCRA = TRUE) := FUNCTION
  
	msa_bocashell := RECORD
		risk_indicators.Layout_Boca_Shell;
		string50 msa;
	end;

	clam := join(clamPre, Models.Key_MSA_Zip_Lookup(isFCRA), KEYED(left.shell_input.z5 = right.zip), 
							  TRANSFORM(msa_bocashell, self.msa:= right.msa, self:=left),
								left outer, keep(1));	
	
  RVC_DEBUG := FALSE;

	#if(RVC_DEBUG)
layout_debug := record
REAL            sysdate;
REAL            iv_de001_eviction_recency;
REAL            iv_ms001_ssns_per_adl;
REAL            iv_in001_estimated_income;
STRING          iv_ed001_college_ind;
STRING          iv_nap_status;
REAL            iv_inp_addr_source_count;
REAL            iv_addrs_10yr;
STRING          iv_add_apt;
REAL            iv_max_ids_per_sfd_addr;
REAL            iv_inq_highriskcredit_recency;
REAL            iv_paw_dead_business_count;
REAL            iv_paw_active_phone_count;
REAL            _infutor_first_seen;
REAL            iv_mos_since_infutor_first_seen;
REAL            iv_non_derog_count;
STRING            iv_criminal_x_felony;
STRING            _msa;
STRING           _msa_group;
REAL            subscore0;
REAL            subscore1;
REAL            subscore2;
REAL            subscore3;
REAL            subscore4;
REAL            subscore5;
REAL            subscore6;
REAL            subscore7;
REAL            subscore8;
REAL            subscore9;
REAL            subscore10;
REAL            subscore11;
REAL            subscore12;
REAL            subscore13;
REAL            subscore14;
REAL            rawscore;
REAL            lnoddsscore;
REAL            probscore;
REAL            base;
REAL            pts;
REAL            odds;
BOOLEAN         ssn_deceased;
BOOLEAN         iv_riskview_222s;
REAL            rvc1412_1_0;
BOOLEAN         glrc07;
BOOLEAN         glrc25;
BOOLEAN         glrc36;
BOOLEAN         glrc97;
BOOLEAN         glrc9d;
BOOLEAN         glrc9i;
BOOLEAN         glrc9k;
BOOLEAN         glrc9m;
BOOLEAN         glrc9p;
BOOLEAN         glrc9r;
BOOLEAN         glrcev;
BOOLEAN         glrcms;
REAL            glrcbl;
REAL            rcvalue07_1;
REAL            rcvalue07;
REAL            rcvalue25_1;
REAL            rcvalue25;
REAL            rcvalue36_1;
REAL            rcvalue36_2;
REAL            rcvalue36;
REAL            rcvalue97_1;
REAL            rcvalue97;
REAL            rcvalue9d_1;
REAL            rcvalue9d;
REAL            rcvalue9i_1;
REAL            rcvalue9i;
REAL            rcvalue9k_1;
REAL            rcvalue9k;
REAL            rcvalue9m_1;
REAL            rcvalue9m;
REAL            rcvalue9p_1;
REAL            rcvalue9p;
REAL            rcvalue9r_1;
REAL            rcvalue9r;
REAL            rcvalueev_1;
REAL            rcvalueev;
REAL            rcvaluems_1;
REAL            rcvaluems;
REAL            rcvaluebl_1;
REAL            rcvaluebl_2;
REAL            rcvaluebl;
STRING             rc1;
STRING             rc4;
STRING            rc2;
STRING            rc3;
STRING            rc5;
String MSA_NAME                         ;
			models.layout_modelout;
			risk_indicators.Layout_Boca_Shell clam;
    END;
    layout_debug doModel( clam le ) := TRANSFORM
  #else
    models.layout_modelout doModel( clam le ) := TRANSFORM
  #end
	msa_name                         := le.msa;
	truedid                          := le.truedid;
	out_unit_desig                   := le.shell_input.unit_desig;
	out_st                           := le.shell_input.st;
	out_sec_range                    := le.shell_input.sec_range;
	out_addr_type                    := le.shell_input.addr_type;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	nap_status                       := le.iid.nap_status;
	rc_decsflag                      := le.iid.decsflag;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_bansflag                      := le.iid.bansflag;
	combo_dobscore                   := le.iid.combo_dobscore;
	ver_sources                      := le.header_summary.ver_sources;
	addrpop                          := le.input_validation.address;
	hphnpop                          := le.input_validation.homephone;
	age                              := le.name_verification.age;
	add1_source_count                := le.address_verification.input_address_information.source_count;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_pop                         := le.addrpop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_sold_total              := le.address_verification.sold.property_total;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	unique_addr_count                := le.address_history_summary.unique_addr_cnt;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	adls_per_addr                    := le.velocity_counters.adls_per_addr;
	ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
	inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
	inq_highriskcredit_count01       := le.acc_logs.highriskcredit.count01;
	inq_highriskcredit_count03       := le.acc_logs.highriskcredit.count03;
	inq_highriskcredit_count06       := le.acc_logs.highriskcredit.count06;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_highriskcredit_count24       := le.acc_logs.highriskcredit.count24;
	paw_dead_business_count          := le.employment.dead_business_ct;
	paw_active_phone_count           := le.employment.business_active_phone_ct;
	infutor_first_seen               := le.infutor_phone.infutor_date_first_seen;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_eviction_count90            := le.bjl.eviction_count90;
	attr_eviction_count180           := le.bjl.eviction_count180;
	attr_eviction_count12            := le.bjl.eviction_count12;
	attr_eviction_count24            := le.bjl.eviction_count24;
	attr_eviction_count36            := le.bjl.eviction_count36;
	attr_eviction_count60            := le.bjl.eviction_count60;
	attr_num_nonderogs               := le.source_verification.num_nonderogs;
	bankrupt                         := le.bjl.bankrupt;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	ams_class                        := le.student.class;
	ams_college_code                 := le.student.college_code;
	ams_college_type                 := le.student.college_type;
	ams_income_level_code            := le.student.income_level_code;
	ams_file_type                    := le.student.file_type2;
	ams_college_tier                 := le.student.college_tier;
	ams_college_major                := le.student.college_major;
	estimated_income                 := le.estimated_income;




NULL := -999999999;


BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

sysdate := common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));

iv_de001_eviction_recency := map(
    not(truedid)                                                => NULL,
    attr_eviction_count90 >0                                    => 3,
    attr_eviction_count180 >0                                   => 6,
    attr_eviction_count12 >0                                    => 12,
    (boolean)attr_eviction_count24 and attr_eviction_count >= 2 => 24,
    attr_eviction_count24 >0                                    => 25,
    (boolean)attr_eviction_count36 and attr_eviction_count >= 2 => 36,
    attr_eviction_count36 >0                                    => 37,
    (boolean)attr_eviction_count60 and attr_eviction_count >= 2 => 60,
    attr_eviction_count60 >0                                    => 61,
    attr_eviction_count >= 2                                    => 98,
    attr_eviction_count >= 1                                    => 99,
                                                                   0);

iv_ms001_ssns_per_adl := map(
    not(truedid)     => NULL,
    ssns_per_adl = 0 => 1,
                        ssns_per_adl);

iv_in001_estimated_income := if(not(truedid), NULL, estimated_income);

iv_ed001_college_ind := map(
    not(truedid)                                                                                                                                                          => ' ',
    not(ams_college_code = '') or not(ams_college_type = '') or (not ams_college_tier= '' and (integer)ams_college_tier >= 0) or not(ams_college_major = '') or (ams_file_type in ['H', 'C', 'A'])       => '1',
    ams_file_type = 'M'                                                                                                                                                   => '0',
    not(ams_class =  '' ) or not(ams_income_level_code = '' )                                                                                                             => '1',
                                                                                                                                                                             '0');

iv_nap_status := if(not(hphnpop or addrpop), ' ', nap_status);

iv_inp_addr_source_count := if(not(add1_pop), NULL, add1_source_count);

iv_addrs_10yr := map(
    not(truedid)          => NULL,
    unique_addr_count = 0 => -1,
                             addrs_10yr);

iv_add_apt := if(StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or not(out_unit_desig = '') or not(out_sec_range = ''), '1', '0');

iv_max_ids_per_sfd_addr := map(
    not(add1_pop)    => NULL,
    iv_add_apt = '1' => -1,
                        max(adls_per_addr, ssns_per_addr));

iv_inq_highriskcredit_recency := map(
    not(truedid)                  => NULL,
    inq_highRiskCredit_count01 >0 => 1,
    inq_highRiskCredit_count03 >0 => 3,
    inq_highRiskCredit_count06 >0 => 6,
    inq_highRiskCredit_count12 >0 => 12,
    inq_highRiskCredit_count24 >0 => 24,
    inq_highRiskCredit_count   >0 => 99,
                                  0);

iv_paw_dead_business_count := if(not(truedid), NULL, paw_dead_business_count);

iv_paw_active_phone_count := if(not(truedid), NULL, paw_active_phone_count);

_infutor_first_seen := common.sas_date((string)(infutor_first_seen));

iv_mos_since_infutor_first_seen := map(
    not(hphnpop)                    => NULL,
    not(_infutor_first_seen = NULL) => if ((sysdate - _infutor_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _infutor_first_seen) / (365.25 / 12)), roundup((sysdate - _infutor_first_seen) / (365.25 / 12))),
                                       -1);

iv_non_derog_count := if(not(truedid), NULL, attr_num_nonderogs);

iv_criminal_x_felony := if(not(truedid), '   ', trim((STRING)min(if(criminal_count = NULL, -NULL, criminal_count), 3), LEFT, RIGHT) + '-'+ trim((STRING)min(if(felony_count = NULL, -NULL, felony_count), 3), LEFT, RIGHT));

_msa := map(
    MSA_NAME = 'LOS ANGELES-LONG BEACH-SANTAANA, CA'          => MSA_NAME,
    MSA_NAME = 'HOUSTON-SUGAR LAND-BAYTOWN,TX'                => MSA_NAME,
    MSA_NAME = 'CHICAGO-NAPERVILLE-JOLIET, IL-IN-WI'          => MSA_NAME,
    MSA_NAME = 'DALLAS-FORT WORTH-ARLINGTON,TX'               => MSA_NAME,
    MSA_NAME = 'MIAMI-FORT LAUDERDALE-POMPANO BEACH, FL'      => MSA_NAME,
    MSA_NAME = 'SAN FRANCISCO-OAKLAND-FREMONT, CA'            => MSA_NAME,
    MSA_NAME = 'NEW YORK-NORTHERN NEW JERSEY'                 => MSA_NAME,
    MSA_NAME = 'ATLANTA-SANDY SPRINGS-MARIETTA, GA'           => MSA_NAME,
    MSA_NAME = 'DETROIT-WARREN-LIVONIA, MI'                   => MSA_NAME,
    MSA_NAME = 'SAN DIEGO-CARLSBAD-SAN MARCOS, CA'            => MSA_NAME,
    MSA_NAME = 'INDIANAPOLIS-CARMEL, IN'                      => MSA_NAME,
    MSA_NAME = 'SACRAMENTO-ARDEN-ARCADE-ROSEVILLE, CA'        => MSA_NAME,
    MSA_NAME = 'ST. LOUIS, MO-IL'                             => MSA_NAME,
    MSA_NAME = 'SD NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'SAN JOSE-SUNNYVALE-SANTACLARA, CA'            => MSA_NAME,
    MSA_NAME = 'TX NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'MILWAUKEE-WAUKESHA-WEST ALLIS, WI'            => MSA_NAME,
    MSA_NAME = 'SAN ANTONIO, TX'                              => MSA_NAME,
    MSA_NAME = 'RIVERSIDE-SAN BERNARDINO-ONTARIO, CA'         => MSA_NAME,
    MSA_NAME = 'CLEVELAND-ELYRIA-MENTOR,OH'                   => MSA_NAME,
    MSA_NAME = 'AUSTIN-ROUND ROCK, TX'                        => MSA_NAME,
    MSA_NAME = 'COLUMBUS, OH'                                 => MSA_NAME,
    MSA_NAME = 'KANSAS CITY, MO-KS'                           => MSA_NAME,
    MSA_NAME = 'FRESNO, CA'                                   => MSA_NAME,
    MSA_NAME = 'BAKERSFIELD, CA'                              => MSA_NAME,
    MSA_NAME = 'MS NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'MEMPHIS, TN-AR-MS'                            => MSA_NAME,
    MSA_NAME = 'BOSTON-CAMBRIDGE-QUINCY,MA-NH'                => MSA_NAME,
    MSA_NAME = 'HARTFORD-WEST HARTFORD-EASTHARTFORD, CT'      => MSA_NAME,
    MSA_NAME = 'WASHINGTON-ARLINGTON-ALEXANDRIA, DC-VA-MD-WV' => MSA_NAME,
    MSA_NAME = 'ORLANDO-KISSIMMEE, FL'                        => MSA_NAME,
    MSA_NAME = 'NEW HAVEN-MILFORD, CT'                        => MSA_NAME,
    MSA_NAME = 'OK NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'JACKSONVILLE, FL'                             => MSA_NAME,
    MSA_NAME = 'BIRMINGHAM-HOOVER, AL'                        => MSA_NAME,
    MSA_NAME = 'OKLAHOMA CITY, OK'                            => MSA_NAME,
    MSA_NAME = 'NEW ORLEANS-METAIRIE-KENNER,LA'               => MSA_NAME,
    MSA_NAME = 'PHILADELPHIA-CAMDEN-WILMINGTON, PA-NJ-DE-MD'  => MSA_NAME,
    MSA_NAME = 'LA NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'CHARLOTTE-GASTONIA-CONCORD,NC-SC'             => MSA_NAME,
    MSA_NAME = 'EL PASO, TX'                                  => MSA_NAME,
    MSA_NAME = 'CA NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'AR NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'STOCKTON, CA'                                 => MSA_NAME,
    MSA_NAME = 'MCALLEN-EDINBURG-MISSION,TX'                  => MSA_NAME,
    MSA_NAME = 'SAN JUAN-CAGUAS-GUAYNABO,PR'                  => MSA_NAME,
    MSA_NAME = 'NASHVILLE-DAVIDSON-MURFREESBORO-FRANKLIN, TN' => MSA_NAME,
    MSA_NAME = 'VISALIA-PORTERVILLE, CA'                      => MSA_NAME,
    MSA_NAME = 'MO NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'LOUISVILLE/JEFFERSON COUNTY,KY-IN'            => MSA_NAME,
    MSA_NAME = 'MT NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'LITTLE ROCK-NORTH LITTLEROCK-CONWAY, AR'      => MSA_NAME,
    MSA_NAME = 'BATON ROUGE, LA'                              => MSA_NAME,
    MSA_NAME = 'BRIDGEPORT-STAMFORD-NORWALK,CT'               => MSA_NAME,
    MSA_NAME = 'KY NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'SEATTLE-TACOMA-BELLEVUE,WA'                   => MSA_NAME,
    MSA_NAME = 'GRAND RAPIDS-WYOMING, MI'                     => MSA_NAME,
    MSA_NAME = 'MODESTO, CA'                                  => MSA_NAME,
    MSA_NAME = 'NC NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'MI NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'GA NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'SALINAS, CA'                                  => MSA_NAME,
    MSA_NAME = 'RENO-SPARKS, NV'                              => MSA_NAME,
    MSA_NAME = 'TULSA, OK'                                    => MSA_NAME,
    MSA_NAME = 'RALEIGH-CARY, NC'                             => MSA_NAME,
    MSA_NAME = 'CO NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'TN NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'KS NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'AL NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'WICHITA, KS'                                  => MSA_NAME,
    MSA_NAME = 'SANTA ROSA-PETALUMA, CA'                      => MSA_NAME,
    MSA_NAME = 'JACKSON, MS'                                  => MSA_NAME,
    MSA_NAME = 'DAYTON, OH'                                   => MSA_NAME,
    MSA_NAME = 'OH NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'PROVIDENCE-NEW BEDFORD-FALLRIVER, RI-MA'      => MSA_NAME,
    MSA_NAME = 'ND NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'IN NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'AKRON, OH'                                    => MSA_NAME,
    MSA_NAME = 'VALLEJO-FAIRFIELD, CA'                        => MSA_NAME,
    MSA_NAME = 'COLUMBIA, SC'                                 => MSA_NAME,
    MSA_NAME = 'PHOENIX-MESA-SCOTTSDALE,AZ'                   => MSA_NAME,
    MSA_NAME = 'BROWNSVILLE-HARLINGEN, TX'                    => MSA_NAME,
    MSA_NAME = 'GREENVILLE-MAULDIN-EASLEY, SC'                => MSA_NAME,
    MSA_NAME = 'BEAUMONT-PORT ARTHUR, TX'                     => MSA_NAME,
    MSA_NAME = 'FARMINGTON, NM'                               => MSA_NAME,
    MSA_NAME = 'PORTLAND-VANCOUVER-BEAVERTON, OR-WA'          => MSA_NAME,
    MSA_NAME = 'PORT ST. LUCIE, FL'                           => MSA_NAME,
    MSA_NAME = 'TOLEDO, OH'                                   => MSA_NAME,
    MSA_NAME = 'MERCED, CA'                                   => MSA_NAME,
    MSA_NAME = 'SPRINGFIELD, MO'                              => MSA_NAME,
    MSA_NAME = 'FL NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'SANTA CRUZ-WATSONVILLE, CA'                   => MSA_NAME,
                                                                 'STATE: ' + out_st);

_msa_group := map(
    (_msa in ['AL NONMETROPOLITAN AREA', 'AR NONMETROPOLITAN AREA', 'GA NONMETROPOLITAN AREA', 'KY NONMETROPOLITAN AREA', 'LA NONMETROPOLITAN AREA', 'MS NONMETROPOLITAN AREA', 'NC NONMETROPOLITAN AREA', 'STATE: LA', 'TN NONMETROPOLITAN AREA'])                                      => 'A ',
    (_msa in ['BATON ROUGE, LA', 'JACKSON, MS', 'NEW ORLEANS-METAIRIE-KENNER,LA', 'STATE: AL', 'STATE: MS'])                                                                                                                                                                             => 'B ',
    (_msa in ['BEAUMONT-PORT ARTHUR, TX', 'BROWNSVILLE-HARLINGEN, TX', 'DALLAS-FORT WORTH-ARLINGTON,TX', 'EL PASO, TX', 'HOUSTON-SUGAR LAND-BAYTOWN,TX', 'MCALLEN-EDINBURG-MISSION,TX', 'SAN ANTONIO, TX', 'TX NONMETROPOLITAN AREA'])                                                   => 'C ',
    (_msa in ['AKRON, OH', 'CLEVELAND-ELYRIA-MENTOR,OH', 'OH NONMETROPOLITAN AREA', 'STATE: OH', 'TOLEDO, OH'])                                                                                                                                                                          => 'D ',
    (_msa in ['AUSTIN-ROUND ROCK, TX'])                                                                                                                                                                                                                                                  => 'E ',
    (_msa in ['ATLANTA-SANDY SPRINGS-MARIETTA, GA', 'BIRMINGHAM-HOOVER, AL', 'STATE: GA'])                                                                                                                                                                                               => 'F ',
    (_msa in ['COLUMBUS, OH', 'DAYTON, OH'])                                                                                                                                                                                                                                             => 'G ',
    (_msa in ['BAKERSFIELD, CA', 'CA NONMETROPOLITAN AREA', 'FRESNO, CA', 'MERCED, CA', 'SACRAMENTO-ARDEN-ARCADE-ROSEVILLE, CA', 'SD NONMETROPOLITAN AREA', 'STOCKTON, CA', 'VALLEJO-FAIRFIELD, CA', 'VISALIA-PORTERVILLE, CA'])                                                         => 'H ',
    (_msa in ['BOSTON-CAMBRIDGE-QUINCY,MA-NH', 'NEW YORK-NORTHERN NEW JERSEY', 'PHILADELPHIA-CAMDEN-WILMINGTON, PA-NJ-DE-MD', 'STATE: NJ', 'STATE: NY', 'STATE: PA', 'STATE: VI', 'WASHINGTON-ARLINGTON-ALEXANDRIA, DC-VA-MD-WV'])                                                       => 'I ',
    (_msa in ['BRIDGEPORT-STAMFORD-NORWALK,CT', 'HARTFORD-WEST HARTFORD-EASTHARTFORD, CT', 'NEW HAVEN-MILFORD, CT', 'PROVIDENCE-NEW BEDFORD-FALLRIVER, RI-MA', 'STATE: CT'])                                                                                                             => 'J ',
    (_msa in ['CHARLOTTE-GASTONIA-CONCORD,NC-SC', 'COLUMBIA, SC', 'GREENVILLE-MAULDIN-EASLEY, SC', 'LOUISVILLE/JEFFERSON COUNTY,KY-IN', 'MEMPHIS, TN-AR-MS', 'RALEIGH-CARY, NC', 'STATE: KY', 'STATE: NC', 'STATE: SC', 'STATE: TN', 'STATE: WV'])                                       => 'K ',
    (_msa in ['CHICAGO-NAPERVILLE-JOLIET, IL-IN-WI'])                                                                                                                                                                                                                                    => 'L ',
    (_msa in ['CO NONMETROPOLITAN AREA', 'FARMINGTON, NM', 'MT NONMETROPOLITAN AREA', 'ND NONMETROPOLITAN AREA', 'STATE: CO', 'STATE: ID', 'STATE: MT', 'STATE: ND', 'STATE: SD', 'STATE: UT', 'STATE: WY'])                                                                             => 'M ',
    (_msa in ['DETROIT-WARREN-LIVONIA, MI', 'MILWAUKEE-WAUKESHA-WEST ALLIS, WI'])                                                                                                                                                                                                        => 'N ',
    (_msa in ['FL NONMETROPOLITAN AREA', 'JACKSONVILLE, FL', 'ORLANDO-KISSIMMEE, FL', 'PORT ST. LUCIE, FL', 'STATE: FL'])                                                                                                                                                                => 'O ',
    (_msa in ['GRAND RAPIDS-WYOMING, MI', 'MI NONMETROPOLITAN AREA', 'STATE: IA', 'STATE: MI', 'STATE: MN', 'STATE: WI'])                                                                                                                                                                => 'P ',
    (_msa in ['IN NONMETROPOLITAN AREA', 'INDIANAPOLIS-CARMEL, IN', 'STATE: IN'])                                                                                                                                                                                                        => 'Q ',
    (_msa in ['KANSAS CITY, MO-KS', 'KS NONMETROPOLITAN AREA', 'LITTLE ROCK-NORTH LITTLEROCK-CONWAY, AR', 'MO NONMETROPOLITAN AREA', 'OK NONMETROPOLITAN AREA', 'OKLAHOMA CITY, OK', 'SPRINGFIELD, MO', 'STATE: KS', 'STATE: NE', 'STATE: OK', 'STATE: TX', 'TULSA, OK', 'WICHITA, KS']) => 'R ',
    (_msa in ['LOS ANGELES-LONG BEACH-SANTAANA, CA', 'MODESTO, CA', 'RIVERSIDE-SAN BERNARDINO-ONTARIO, CA', 'SAN DIEGO-CARLSBAD-SAN MARCOS, CA', 'STATE:', 'STATE: HI'])                                                                                                                 => 'S ',
    (_msa in ['MIAMI-FORT LAUDERDALE-POMPANO BEACH, FL'])                                                                                                                                                                                                                                => 'T ',
    (_msa in ['NASHVILLE-DAVIDSON-MURFREESBORO-FRANKLIN, TN'])                                                                                                                                                                                                                           => 'U ',
    (_msa in ['PHOENIX-MESA-SCOTTSDALE,AZ', 'STATE: AZ', 'STATE: NM', 'STATE: NV'])                                                                                                                                                                                                      => 'V ',
    (_msa in ['PORTLAND-VANCOUVER-BEAVERTON, OR-WA', 'SEATTLE-TACOMA-BELLEVUE,WA', 'STATE: OR', 'STATE: WA'])                                                                                                                                                                            => 'W ',
    (_msa in ['RENO-SPARKS, NV', 'SALINAS, CA', 'SAN FRANCISCO-OAKLAND-FREMONT, CA', 'SAN JOSE-SUNNYVALE-SANTACLARA, CA', 'SANTA CRUZ-WATSONVILLE, CA', 'SANTA ROSA-PETALUMA, CA', 'STATE: CA'])                                                                                         => 'X ',
    (_msa in ['SAN JUAN-CAGUAS-GUAYNABO,PR', 'STATE: GU', 'STATE: PR'])                                                                                                                                                                                                                  => 'Y ',
    (_msa in ['ST. LOUIS, MO-IL', 'STATE: IL', 'STATE: MO'])                                                                                                                                                                                                                             => 'Z ',
    (_msa in ['STATE: AK', 'STATE: AP', 'STATE: AR'])                                                                                                                                                                                                                                    => 'AA',
    ( _msa in ['STATE: DE','STATE: MA','STATE: MD','STATE: ME','STATE: NH','STATE: VA','STATE: VT'])                                                                                                                                                                                     => 'AB',
																																																																																																																																													 '');

subscore0 := map(
    (_msa_group in [' '])                          => 0.000000,
    (_msa_group in ['C', 'E', 'O', 'T'])           => -0.849899,
    (_msa_group in ['H', 'S', 'V', 'W', 'X', 'Y']) => -0.399828,
    (_msa_group in ['F', 'J', 'K', 'L'])           => -0.204329,
    (_msa_group in ['AB', 'I'])                    => 0.042107,
    (_msa_group in ['A', 'AA', 'B', 'R', 'U'])     => 0.094297,
    (_msa_group in ['D', 'G'])                     => 0.163432,
    (_msa_group in ['M', 'N', 'P', 'Q', 'Z'])      => 0.479797,
                                                      0.000000);

subscore1 := map(
    NULL < iv_addrs_10yr AND iv_addrs_10yr < 0 => 0.000000,
    0 <= iv_addrs_10yr AND iv_addrs_10yr < 1   => 0.296522,
    1 <= iv_addrs_10yr AND iv_addrs_10yr < 2   => 0.121202,
    2 <= iv_addrs_10yr AND iv_addrs_10yr < 4   => -0.003695,
    4 <= iv_addrs_10yr AND iv_addrs_10yr < 6   => -0.089710,
    6 <= iv_addrs_10yr                         => -0.190306,
                                                  0.000000);

subscore2 := map(
    NULL < iv_non_derog_count AND iv_non_derog_count < 2 => -0.252553,
    2 <= iv_non_derog_count AND iv_non_derog_count < 3   => -0.076578,
    3 <= iv_non_derog_count AND iv_non_derog_count < 4   => 0.048493,
    4 <= iv_non_derog_count                              => 0.094535,
                                                            -0.000000);

subscore3 := map(
    NULL < iv_inp_addr_source_count AND iv_inp_addr_source_count < 2 => -0.130476,
    2 <= iv_inp_addr_source_count AND iv_inp_addr_source_count < 3   => -0.028669,
    3 <= iv_inp_addr_source_count AND iv_inp_addr_source_count < 4   => 0.020001,
    4 <= iv_inp_addr_source_count AND iv_inp_addr_source_count < 5   => 0.117117,
    5 <= iv_inp_addr_source_count                                    => 0.128695,
                                                                        -0.000000);

subscore4 := map(
    NULL < iv_paw_dead_business_count AND iv_paw_dead_business_count < 1 => 0.022072,
    1 <= iv_paw_dead_business_count AND iv_paw_dead_business_count < 2   => -0.303861,
    2 <= iv_paw_dead_business_count                                      => -0.493280,
                                                                            0.000000);

subscore5 := map(
    NULL < iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr < 0 => -0.104837,
    0 <= iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr < 8   => 0.114582,
    8 <= iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr < 19  => 0.013726,
    19 <= iv_max_ids_per_sfd_addr                                  => -0.056431,
                                                                      -0.000000);

subscore6 := map(
    NULL < iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 2 => 0.037412,
    2 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 3   => -0.076303,
    3 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 4   => -0.212061,
    4 <= iv_ms001_ssns_per_adl                                 => -0.339102,
                                                                  0.000000);

subscore7 := map(
    (iv_ed001_college_ind in [' ']) => -0.000000,
    (iv_ed001_college_ind in ['0']) => -0.018751,
    (iv_ed001_college_ind in ['1']) => 0.290535,
                                       -0.000000);

subscore8 := map(
    (iv_nap_status in [' ']) => -0.000000,
    (iv_nap_status in ['C']) => 0.036285,
    (iv_nap_status in ['D']) => -0.190362,
                                -0.000000);

subscore9 := map(
    (iv_criminal_x_felony in [' '])                                      => -0.000000,
    (iv_criminal_x_felony in ['0-0'])                                    => 0.009383,
    (iv_criminal_x_felony in ['1-2', '1-1', '1-3', '2-2', '2-3', '3-3']) => -0.855999,
    (iv_criminal_x_felony in ['2-0', '1-0', '3-0'])                      => -0.293378,
                                                                            -0.000000);

subscore10 := map(
    NULL < iv_in001_estimated_income AND iv_in001_estimated_income < 19999   => 0.000000,
    19999 <= iv_in001_estimated_income AND iv_in001_estimated_income < 22000 => -0.232993,
    22000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 24000 => -0.086397,
    24000 <= iv_in001_estimated_income                                       => 0.021321,
                                                                                0.000000);

subscore11 := map(
    NULL < iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 1 => 0.016167,
    1 <= iv_inq_highriskcredit_recency                                         => -0.192753,
                                                                                  0.000000);

subscore12 := map(
    NULL < iv_de001_eviction_recency AND iv_de001_eviction_recency < 3 => 0.010201,
    3 <= iv_de001_eviction_recency                                     => -0.237561,
                                                                          0.000000);

subscore13 := map(
    NULL < iv_mos_since_infutor_first_seen AND iv_mos_since_infutor_first_seen < 0 => 0.058496,
    0 <= iv_mos_since_infutor_first_seen AND iv_mos_since_infutor_first_seen < 30  => -0.067664,
    30 <= iv_mos_since_infutor_first_seen                                          => 0.009262,
                                                                                      0.000000);

subscore14 := map(
    NULL < iv_paw_active_phone_count AND iv_paw_active_phone_count < 1 => -0.005623,
    1 <= iv_paw_active_phone_count                                     => 0.250006,
                                                                          0.000000);

rawscore := subscore0 +
    subscore1 +
    subscore2 +
    subscore3 +
    subscore4 +
    subscore5 +
    subscore6 +
    subscore7 +
    subscore8 +
    subscore9 +
    subscore10 +
    subscore11 +
    subscore12 +
    subscore13 +
    subscore14;

lnoddsscore := rawscore + -1.166311;

probscore := exp(lnoddsscore) / (1 + exp(lnoddsscore));

base := 700;

pts := 40;

odds := 0.238 / (1 - 0.238);

ssn_deceased := rc_decsflag = '1' or (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') > 0;

iv_riskview_222s := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);

rvc1412_1_0 := map(
    ssn_deceased     => 200,
    iv_riskview_222s => 222,
                        min(if(max(round(pts * (lnoddsscore - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(pts * (lnoddsscore - ln(odds)) / ln(2) + base), 501)), 900));


rc5_3 := '';

glrc07 := (integer)hphnpop = 1 and (integer)addrpop = 1 and nap_status = 'D';

glrc25 := (integer)add1_pop = 1 and add1_source_count < 3;

glrc36 := attr_num_nonderogs < 3 or paw_active_phone_count = 0;

glrc97 := criminal_count > 0;

glrc9d := addrs_10yr > 1;

glrc9i := age < 35 and iv_ed001_college_ind = '0';

glrc9k := iv_add_apt = '1';

glrc9m := estimated_income <= 24000;

glrc9p := inq_highRiskCredit_count > 0;

glrc9r := 0 <= iv_mos_since_infutor_first_seen AND iv_mos_since_infutor_first_seen < 30;

glrcev := attr_eviction_count > 0;

glrcms := ssns_per_adl > 2;

glrcbl := 0;

rcvalue07_1 := (integer)glrc07 * (0.036285 - subscore8);

rcvalue07 := if(max(rcvalue07_1) = NULL, NULL, sum(if(rcvalue07_1 = NULL, 0, rcvalue07_1)));

rcvalue25_1 := (integer)glrc25 * (0.128695 - subscore3);

rcvalue25 := if(max(rcvalue25_1) = NULL, NULL, sum(if(rcvalue25_1 = NULL, 0, rcvalue25_1)));

rcvalue36_1 := (integer)glrc36 * (0.094535 - subscore2);

rcvalue36_2 := (integer)glrc36 * (0.250006 - subscore14);

rcvalue36 := if(max(rcvalue36_1, rcvalue36_2) = NULL, NULL, sum(if(rcvalue36_1 = NULL, 0, rcvalue36_1), if(rcvalue36_2 = NULL, 0, rcvalue36_2)));

rcvalue97_1 := (integer)glrc97 * (0.009383 - subscore9);

rcvalue97 := if(max(rcvalue97_1) = NULL, NULL, sum(if(rcvalue97_1 = NULL, 0, rcvalue97_1)));

rcvalue9d_1 := (integer)glrc9d * (0.296522 - subscore1);

rcvalue9d := if(max(rcvalue9d_1) = NULL, NULL, sum(if(rcvalue9d_1 = NULL, 0, rcvalue9d_1)));

rcvalue9i_1 := (integer)glrc9i * (0.290535 - subscore7);

rcvalue9i := if(max(rcvalue9i_1) = NULL, NULL, sum(if(rcvalue9i_1 = NULL, 0, rcvalue9i_1)));

rcvalue9k_1 := (integer)glrc9k * (0.114582 - subscore5);

rcvalue9k := if(max(rcvalue9k_1) = NULL, NULL, sum(if(rcvalue9k_1 = NULL, 0, rcvalue9k_1)));

rcvalue9m_1 := (integer)glrc9m * (0.021321 - subscore10);

rcvalue9m := if(max(rcvalue9m_1) = NULL, NULL, sum(if(rcvalue9m_1 = NULL, 0, rcvalue9m_1)));

rcvalue9p_1 := (integer)glrc9p * (0.016167 - subscore11);

rcvalue9p := if(max(rcvalue9p_1) = NULL, NULL, sum(if(rcvalue9p_1 = NULL, 0, rcvalue9p_1)));

rcvalue9r_1 := (integer)glrc9r * (0.058496 - subscore13);

rcvalue9r := if(max(rcvalue9r_1) = NULL, NULL, sum(if(rcvalue9r_1 = NULL, 0, rcvalue9r_1)));

rcvalueev_1 := (integer)glrcev * (0.010201 - subscore12);

rcvalueev := if(max(rcvalueev_1) = NULL, NULL, sum(if(rcvalueev_1 = NULL, 0, rcvalueev_1)));

rcvaluems_1 := (integer)glrcms * (0.037412 - subscore6);

rcvaluems := if(max(rcvaluems_1) = NULL, NULL, sum(if(rcvaluems_1 = NULL, 0, rcvaluems_1)));

rcvaluebl_1 := glrcbl * (0.479797 - subscore0);

rcvaluebl_2 := glrcbl * (0.022072 - subscore4);

rcvaluebl := if(max(rcvaluebl_1, rcvaluebl_2) = NULL, NULL, sum(if(rcvaluebl_1 = NULL, 0, rcvaluebl_1), if(rcvaluebl_2 = NULL, 0, rcvaluebl_2)));

//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};

rc_dataset := DATASET([
    {'07', RCValue07},
    {'25', RCValue25},
    {'36', RCValue36},
    {'97', RCValue97},
    {'9D', RCValue9D},
    {'9I', RCValue9I},
    {'9K', RCValue9K},
    {'9M', RCValue9M},
    {'9P', RCValue9P},
    {'9R', RCValue9R},
    {'EV', RCValueEV},
    {'MS', RCValueMS},
    {'BL', RCValueBL}
    ], ds_layout)(value > 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Only select reason codes when their associated value is > 0.
// I'll leave the implementation details to the Engineers.
//*************************************************************************************//

rc_dataset_sorted := sort(rc_dataset, -rc_dataset.value);


		rcs_top4 := CHOOSEN(SORT(rc_dataset, -value), 4); // Take the top four reason codes
		rcs_top := if(count(rcs_top4(rc != ''))=0, DATASET([{'36', NULL}], ds_layout), rcs_top4);
		
		rcs_9p := rcs_top & if(glrc9p and (count(rcs_top4(rc='9P')) =0) AND inq_highRiskCredit_count12 > 0, ROW({'9P', NULL}, ds_layout));

		rcs_override := MAP(
												rvc1412_1_0 = 200 => DATASET([{'02', NULL}], ds_layout),
												rvc1412_1_0 = 222 => DATASET([{'9X', NULL}], ds_layout),
												rvc1412_1_0 = 900 => DATASET([{'  ', NULL}], ds_layout),
												(500 < RVC1412_1_0) and (RVC1412_1_0 <= 720) and 
													(rcs_9p[1].rc!='36') and (rcs_9p[1].rc!='') and (rcs_9p[2].rc='') => DATASET([{rcs_9p[1].rc, NULL}, {'36', NULL}], ds_layout),
												(500 < RVC1412_1_0) and (RVC1412_1_0 <= 720) and 
													(rcs_9p[1].rc='36') and  (rcs_9p[2].rc='') => DATASET([{rcs_9p[1].rc, NULL}, {'9E', NULL}], ds_layout),
												rcs_9p
											);	
		
		riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
		
		rcs_final := PROJECT(rcs_override, TRANSFORM(Risk_Indicators.Layout_Desc,
					SELF.hri := LEFT.rc,
					SELF.desc := Risk_Indicators.getHRIDesc(LEFT.rc)
				));

		inCalif := isCalifornia AND (
					(integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
					+(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
					+(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;
				
		ri := MAP(
							riTemp[1].hri <> '00' => riTemp,
							inCalif => DATASET([{'35', Risk_Indicators.getHRIDesc('35')}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc),
							rcs_final
							);
						
		zeros := DATASET([{'00',''}, {'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc);
		
		reasons := CHOOSEN(ri & zeros, 5); // Keep up to 5 reason codes



	#if(RVC_DEBUG)
		self.clam															:= le;
		self.sysdate                          := sysdate;                                 
self.iv_de001_eviction_recency        := iv_de001_eviction_recency;               
self.iv_ms001_ssns_per_adl            := iv_ms001_ssns_per_adl;                   
self.iv_in001_estimated_income        := iv_in001_estimated_income;               
self.iv_ed001_college_ind             := iv_ed001_college_ind;                    
self.iv_nap_status                    := iv_nap_status;                           
self.iv_inp_addr_source_count         := iv_inp_addr_source_count;                
self.iv_addrs_10yr                    := iv_addrs_10yr;                           
self.iv_add_apt                       := iv_add_apt;                              
self.iv_max_ids_per_sfd_addr          := iv_max_ids_per_sfd_addr;                 
self.iv_inq_highriskcredit_recency    := iv_inq_highriskcredit_recency;           
self.iv_paw_dead_business_count       := iv_paw_dead_business_count;              
self.iv_paw_active_phone_count        := iv_paw_active_phone_count;               
self._infutor_first_seen              := _infutor_first_seen;                     
self.iv_mos_since_infutor_first_seen  := iv_mos_since_infutor_first_seen;         
self.iv_non_derog_count               := iv_non_derog_count;                      
self.iv_criminal_x_felony             := iv_criminal_x_felony;                    
self._msa                             := _msa;                                    
self._msa_group                       := _msa_group;                              
self.subscore0                        := subscore0;                               
self.subscore1                        := subscore1;                               
self.subscore2                        := subscore2;                               
self.subscore3                        := subscore3;                               
self.subscore4                        := subscore4;                               
self.subscore5                        := subscore5;                               
self.subscore6                        := subscore6;                               
self.subscore7                        := subscore7;                               
self.subscore8                        := subscore8;                               
self.subscore9                        := subscore9;                               
self.subscore10                       := subscore10;                              
self.subscore11                       := subscore11;                              
self.subscore12                       := subscore12;                              
self.subscore13                       := subscore13;                              
self.subscore14                       := subscore14;                              
self.rawscore                         := rawscore;                                
self.lnoddsscore                      := lnoddsscore;                             
self.probscore                        := probscore;                               
self.base                             := base;                                    
self.pts                              := pts;                                     
self.odds                             := odds;                                    
self.ssn_deceased                     := ssn_deceased;                            
self.iv_riskview_222s                 := iv_riskview_222s;                        
self.rvc1412_1_0                      := rvc1412_1_0;                             
self.glrc07                           := glrc07;                                  
self.glrc25                           := glrc25;                                  
self.glrc36                           := glrc36;                                  
self.glrc97                           := glrc97;                                  
self.glrc9d                           := glrc9d;                                  
self.glrc9i                           := glrc9i;                                  
self.glrc9k                           := glrc9k;                                  
self.glrc9m                           := glrc9m;                                  
self.glrc9p                           := glrc9p;                                  
self.glrc9r                           := glrc9r;                                  
self.glrcev                           := glrcev;                                  
self.glrcms                           := glrcms;                                  
self.glrcbl                           := glrcbl;                                  
self.rcvalue07_1                      := rcvalue07_1;                             
self.rcvalue07                        := rcvalue07;                               
self.rcvalue25_1                      := rcvalue25_1;                             
self.rcvalue25                        := rcvalue25;                               
self.rcvalue36_1                      := rcvalue36_1;                             
self.rcvalue36_2                      := rcvalue36_2;                             
self.rcvalue36                        := rcvalue36;                               
self.rcvalue97_1                      := rcvalue97_1;                             
self.rcvalue97                        := rcvalue97;                               
self.rcvalue9d_1                      := rcvalue9d_1;                             
self.rcvalue9d                        := rcvalue9d;                               
self.rcvalue9i_1                      := rcvalue9i_1;                             
self.rcvalue9i                        := rcvalue9i;                               
self.rcvalue9k_1                      := rcvalue9k_1;                             
self.rcvalue9k                        := rcvalue9k;                               
self.rcvalue9m_1                      := rcvalue9m_1;                             
self.rcvalue9m                        := rcvalue9m;                               
self.rcvalue9p_1                      := rcvalue9p_1;                             
self.rcvalue9p                        := rcvalue9p;                               
self.rcvalue9r_1                      := rcvalue9r_1;                             
self.rcvalue9r                        := rcvalue9r;                               
self.rcvalueev_1                      := rcvalueev_1;                             
self.rcvalueev                        := rcvalueev;                               
self.rcvaluems_1                      := rcvaluems_1;                             
self.rcvaluems                        := rcvaluems;                               
self.rcvaluebl_1                      := rcvaluebl_1;                             
self.rcvaluebl_2                      := rcvaluebl_2;                             
self.rcvaluebl                        := rcvaluebl;                               
self.rc1                              := rcs_override[1].rc;
self.rc2                              := rcs_override[2].rc;
self.rc3                              := rcs_override[3].rc;
self.rc4                              := rcs_override[4].rc;
self.rc5                              := rcs_override[5].rc;
self.MSA_NAME                         := MSA_NAME;
                                    
                                                                                  

		#end
		SELF.ri := PROJECT(reasons, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := if(LEFT.hri='', '00', left.hri),
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		self.seq := le.seq;
		self.score := if(reasons[1].hri IN ['91','92','93','94'],(STRING3)((INTEGER)reasons[1].hri + 10),(string3)rvc1412_1_0);
END;

		model := project( clam, doModel(left) );

		return model;

END;
