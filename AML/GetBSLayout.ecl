import doxie, ut, mdr, header, drivers, census_data, Risk_indicators, address, FCRA, riskwise, doxie_files, Utilfile;


export GetBSLayout(grouped DATASET(Risk_indicators.Layout_output) iid,
										boolean IsFCRA = FALSE,
										unsigned1 BSversion = 50
										) := function



// Note: bool flag is set, if corrections exists (not necessarily used) for given record
// looks like it is safe doing here: this transform is used in all exec. paths
Layouts.LayoutAMLShellV2	prepIndivLayout(iid le) := TRANSFORM
	SELF.seq := le.seq;
	SELF.did := le.did;
	SELF.HistoryDate := le.historydate;
	self.relatdegree	:= 	 0	;

  self.fname          := le.fname;  
	self.mname          := le.mname;
	self.lname          := le.lname;

	self.isrelat				:= false;
  self.relation					:= 'self';
	self.title 						:= le.title; 
	self.in_streetAddress  := le.in_streetaddress;
	self.in_city 						:= le.in_city;
	self.in_state 					:= le.in_state;
	self.in_zipCode					:= le.in_zipcode; 
	self.in_country 				:= le.in_country; 
	self.suffix  := le.suffix;
	self.currAddrFirstSeenDt := le.chronodate_first;
	self.ssn  						:= if(trim(le.ssn) <> '', le.ssn, le.bestssn) ;
	self.dob  						:= if((string)le.dob = '', (string)le.verdob, (string)le.dob);	
	self.age  						:= if((string)le.dob <> '', (string)max((integer)le.age, (integer)le.inferred_age), le.age);
	
	self.VoterSrc  := Risk_Indicators.Source_Available.VoterSrcSt(le.st, bsversion, isFCRA ,le.historydate );
	

  self.deceased  := le.decsflag='1';
	self.deceasedDate := le.deceasedDate;
	self.validSSN  := le.socsvalflag in ['0','3'] or (le.socsvalflag = '2' and length(trim(le.ssn))=4);// '3' can be blank ssn
	self.NoSSN  := le.socsvalflag in ['3'];  //if(trim(le.ssn) ='', true, false);
	self.soclhighissue  := (UNSIGNED4)le.soclhighissue;
	self.socllowissue  := (UNSIGNED4)le.socllowissue;
	self.ADLScore  := le.score;
	self.ssns_per_adl := le.ssns_per_adl;               //Total  # of Unique SSN's Found with ADL

	self.adls_per_ssn  := le.adls_per_ssn_seen_18months; //Current # of Unique ADL's Found with SSN
	self.AddrHist1_prim_range	:= 	 le.chronoprim_range;
	self.AddrHist1_predir	:= 	 le.chronopredir;
	self.AddrHist1_prim_name	:= 	 le.chronoprim_name;
	self.AddrHist1_addr_suffix	:= 	le.chronosuffix;
	self.AddrHist1_postdir	:= 	le.chronopostdir;
	self.AddrHist1_unit_desig	:= 	le.chronounit_desig;
	self.AddrHist1_sec_range	:= 	le.chronosec_range;
	self.AddrHist1_city_name	:= 	 le.chronocity;
	self.AddrHist1_st	:= 	 le.chronostate;
	self.AddrHist1_zip5	:= 	le.chronozip;
	self.AddrHist1_county	:= 	le.chronocounty;
	self.AddrHist1_geo_blk	:= 	 le.chronogeo_blk;
	self.AddrHist1_dt_first_seen	:= 	  le.chronodate_first;
	self.AddrHist1_dt_last_seen	:= 	 le.chronodate_last;

	self.AddrHist2_prim_range	:= 	 le.chronoprim_range2;
	self.AddrHist2_predir	:= 	 le.chronopredir2;
	self.AddrHist2_prim_name	:= 	 le.chronoprim_name2;
	self.AddrHist2_addr_suffix	:= 	le.chronosuffix2;
	self.AddrHist2_postdir	:= 	le.chronopostdir2;
	self.AddrHist2_unit_desig	:= 	le.chronounit_desig2;
	self.AddrHist2_sec_range	:= 	le.chronosec_range2;
	self.AddrHist2_city_name	:= 	 le.chronocity2;
	self.AddrHist2_st	:= 	 le.chronostate2;
	self.AddrHist2_zip5	:= 	le.chronozip2;
	self.AddrHist2_county	:= 	le.chronocounty2;
	self.AddrHist2_geo_blk	:= 	 le.chronogeo_blk2;
	self.AddrHist2_dt_first_seen	:= 	  le.chronodate_first2;
	self.AddrHist2_dt_last_seen	:= 	 le.chronodate_last2;
	self.prim_range 			:= if(le.prim_range = '', le.chronoprim_range, le.prim_range);
	self.predir 					:= if(le.predir = '', le.chronopredir ,le.predir);
	self.prim_name 				:= if(le.prim_name  = '', le.chronoprim_name ,le.prim_name);
	self.addr_suffix 			:= if(le.addr_suffix  = '', le.chronosuffix ,le.addr_suffix);
	self.postdir 					:= if(le.postdir  = '', le.chronopostdir ,le.postdir);
	self.unit_desig  			:= if(le.unit_desig  = '', le.chronounit_desig ,le.unit_desig); 
	self.sec_range   			:= if(le.sec_range  = '',le.chronosec_range ,le.sec_range);
	self.city_name  			:= if(le.p_city_name  = '',  le.chronocity ,le.p_city_name);
	self.st  							:= if(le.st  = '', le.chronostate ,le.st);
	self.z5  							:= if(le.z5  = '', le.chronozip,le.z5);
	self.county 					:= if(le.county  = '', le.chronocounty ,le.county);
	self.geo_blk 					:= if(le.geo_blk  = '', le.chronogeo_blk ,le.geo_blk);
	self.addr_type 				:= le.addr_type;
	self.addr_status  		:= le.addr_status;
	self.country  				:= le.country;
	self.IsPrison 				:=  le.isPrison;	
	self.AddrHistory 			:= (le.chronoprim_range <> '' OR le.chronoprim_name <> '') and le.chronozip <> '';
	self.PrevAddrHistory 	:= (le.chronoprim_range2 <> '' OR le.chronoprim_name2 <> '') and le.chronozip2 <> '';
	self.addrs_last36  		:= le.addrs_last36;
	self := le;
	SELF := [];
END;

p := sort(PROJECT(iid, prepIndivLayout(LEFT)), seq);

// output(iid, named('iid'));
// output(p, named('p'));

RETURN P;

END;