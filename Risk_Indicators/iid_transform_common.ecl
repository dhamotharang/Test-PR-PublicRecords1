import risk_indicators;

// to speed up the IID query, we can put a few of the unique projects into the same project
// this function will calculate the socsverlevel, validate_dl and set the coaalertflag 
export iid_transform_common(grouped dataset(risk_indicators.Layout_Output) commonstart, UNSIGNED8 BSOptions) := function


risk_indicators.layout_output set_nas_coa(risk_indicators.layout_output le) := transform

	nlrSSN_count := (integer)le.header_summary.eq_ssn_nlr +
									(integer)le.header_summary.en_ssn_nlr +
									(integer)le.header_summary.tn_ssn_nlr;
									
	nlrSSN	:=	nlrSSN_count >= le.socscount and 
						(BSOptions & risk_indicators.iid_constants.BSOptions.IsInstantIDv1) > 0;	// if SSN is NLR on bureaus, then don't verify the ssn for CIID/FlexID
	
	ssnNoVer := le.socscount=0 OR (le.socscount>0 and nlrSSN);

	self.socsverlevel := map(le.firstcount=0 and le.lastcount=0 and le.addrcount=0 and (le.socscount>0 and ~nlrSSN) => 1,
							le.firstcount>0 and le.lastcount>0 and le.addrcount=0 and ssnNoVer => 2,
							le.firstcount>0 and le.lastcount=0 and le.addrcount>0 and ssnNoVer => 3,
							le.firstcount>0 and le.lastcount=0 and le.addrcount=0 and (le.socscount>0 and ~nlrSSN) => 4,
							le.firstcount=0 and le.lastcount>0 and le.addrcount>0 and ssnNoVer => 5,
							le.firstcount=0 and le.lastcount=0 and le.addrcount>0 and (le.socscount>0 and ~nlrSSN) => 6,
							le.firstcount=0 and le.lastcount>0 and le.addrcount=0 and (le.socscount>0 and ~nlrSSN) => 7,
							le.firstcount>0 and le.lastcount>0 and le.addrcount>0 and ssnNoVer => 8,
							le.firstcount>0 and le.lastcount>0 and le.addrcount=0 and (le.socscount>0 and ~nlrSSN) => 9,
							le.firstcount>0 and le.lastcount=0 and le.addrcount>0 and (le.socscount>0 and ~nlrSSN) => 10,
							le.firstcount=0 and le.lastcount>0 and le.addrcount>0 and (le.socscount>0 and ~nlrSSN) => 11,
							le.firstcount>0 and le.lastcount>0 and le.addrcount>0 and (le.socscount>0 and ~nlrSSN) => 12,
							le.did=0 and le.ssnexists and le.pullidflag='' => 1,  // no did but hit on social and not on pullid file
							0);
	
	self.socscount := if(nlrSSN, 0, le.socscount);
	self.versocs := if(nlrSSN, '', le.versocs);
	self.socsscore := if(nlrSSN, 0, le.socsscore);
	
	self.drlcvalflag := MAP(le.dl_number='' => '99',  // this flag needs to get converted upon completion, 
					    (Stringlib.StringFilterOut(le.dl_number,'0')='') OR (stringlib.StringFilterOut(le.dl_number,'9')='') OR (le.dl_number='NONE') => '13',
					    risk_indicators.Validate_DL(le.dl_state, le.dl_number, le.fname, le.lname, le.dob, le.dlMatch, le.dlsocsvalflag, le.dlsocsdobflag));
	self.drlcsoundx := MAP(self.drlcvalflag = '99' => ' ',
					   self.drlcvalflag = '0' => '0',
					   self.drlcvalflag IN ['2','4','9','11'] => '1',
					   ' ');
	self.drlcfirst := MAP(self.drlcvalflag = '99' => ' ',
					  self.drlcvalflag = '0' => '0',
					  self.drlcvalflag IN ['2','9'] => '1',
					  ' ');
	self.drlcmiddle := MAP(self.drlcvalflag = '99' => ' ',
					   self.drlcvalflag = '0' => '0',
					   self.drlcvalflag IN ['10','11'] => '1',
					   ' ');
	self.drlclast := MAP(self.drlcvalflag = '99' => ' ',
					 self.drlcvalflag = '0' => '0',
					 self.drlcvalflag IN ['4','7'] => '1',
					 ' ');
	self.drlcsocs := MAP(self.drlcvalflag = '99' => ' ',
					 self.drlcvalflag = '0' => '0',
					 self.drlcvalflag in ['3'] => '1',
					 ' ');
	self.drlcdob := MAP(self.drlcvalflag = '99' => ' ',
					self.drlcvalflag = '0' => '0',
					self.drlcvalflag = '5' => '1',
					' ');
	self.drlcgender := '3';

	coa_alert := le.score>90 AND le.addrscore < iid_constants.min_addrscore;
	self.coaalertflag := coa_alert;
	self.coafirst := IF(coa_alert,le.verfirst,'');
	self.coalast := IF(coa_alert,le.verlast,'');
	self.coaprim_range := IF(coa_alert,le.verprim_range,'');
	self.coapredir := IF(coa_alert,le.verpredir,'');
	self.coaprim_name := IF(coa_alert,le.verprim_name,'');
	self.coasuffix := IF(coa_alert,le.versuffix,'');
	self.coapostdir := IF(coa_alert,le.verpostdir,'');
	self.coaunit_desig := IF(coa_alert,le.verunit_desig,'');
	self.coasec_range := IF(coa_alert,le.versec_range,'');
	self.coacity := IF(coa_alert,le.vercity,'');
	self.coastate := IF(coa_alert,le.verstate,'');
	self.coazip := IF(coa_alert,le.verzip,'');
	
	self := le;
end;
coa_flags := project(commonstart,set_nas_coa(left));

return coa_flags;

end;