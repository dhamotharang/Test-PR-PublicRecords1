import  UCCV2,RoxieKeyBuild,ut,autokey,doxie;

KeyName       := cluster.cluster_out+'Key::ucc::';
string fXlateUnprintable(string pInput, BOOLEAN tf=FALSE)	:=IF(tf,'',stringlib.StringToUpperCase(regexreplace('[^\\x20-\\x7F]',pInput,'')));

Layout_UCC_Common.Layout_Party tProject(UCCV2.File_UCC_Party_Base_AID pInput)
              := Transform
			        tf                      :=regexfind('SHOWN ',pInput.orig_address1) and regexfind('ADDRESS',pInput.orig_address1);
					tfc                     :=regexfind('( SHOWN +)$|(SHOWN)\\) +$',pInput.orig_city) ;
			       
			        SELF.Orig_name			:=fXlateUnprintable(pInput.Orig_name);
					SELF.Orig_lname			:=fXlateUnprintable(pInput.Orig_lname);
					SELF.Orig_fname			:=fXlateUnprintable(pInput.Orig_fname);
					SELF.Orig_mname			:=fXlateUnprintable(pInput.Orig_mname);
					SELF.Orig_suffix		:=fXlateUnprintable(pInput.Orig_suffix);
					SELF.duns_number		:=fXlateUnprintable(pInput.duns_number);
					SELF.hq_duns_number		:=fXlateUnprintable(pInput.hq_duns_number);
					SELF.ssn				:=fXlateUnprintable(pInput.ssn);
					SELF.fein				:=fXlateUnprintable(pInput.fein);
					SELF.Incorp_state		:=fXlateUnprintable(pInput.Incorp_state);
					SELF.corp_number		:=fXlateUnprintable(pInput.corp_number);
					SELF.corp_type			:=fXlateUnprintable(pInput.corp_type);
					SELF.Orig_address1		:=fXlateUnprintable(pInput.Orig_address1,tf);
					SELF.Orig_address2		:=fXlateUnprintable(pInput.Orig_address2);
					SELF.Orig_city			:=fXlateUnprintable(pInput.Orig_city,tfc);
					SELF.Orig_state			:=fXlateUnprintable(pInput.Orig_state);
					SELF.Orig_zip5			:=fXlateUnprintable(pInput.Orig_zip5);
					SELF.Orig_zip4			:=fXlateUnprintable(pInput.Orig_zip4);
					SELF.Orig_country		:=fXlateUnprintable(pInput.Orig_country);
					SELF.Orig_province		:=fXlateUnprintable(pInput.Orig_province);
					SELF.Orig_postal_code	:=fXlateUnprintable(pInput.Orig_postal_code);
					SELF.foreign_indc		:=fXlateUnprintable(pInput.foreign_indc);
					SELF.Party_type			:=fXlateUnprintable(pInput.Party_type);
					SELF.title				:=fXlateUnprintable(pInput.title);
					SELF.fname				:=fXlateUnprintable(pInput.fname);
					SELF.mname				:=fXlateUnprintable(pInput.mname);
					SELF.lname				:=fXlateUnprintable(pInput.lname);
					SELF.name_suffix		:=fXlateUnprintable(pInput.name_suffix);
					SELF.name_score			:=fXlateUnprintable(pInput.name_score);
					SELF.company_name		:=fXlateUnprintable(pInput.company_name);
					SELF.prim_range			:=fXlateUnprintable(pInput.prim_range,tf);
					SELF.predir				:=fXlateUnprintable(pInput.predir,tf);
					SELF.prim_name			:=fXlateUnprintable(pInput.prim_name,tf);
					SELF.p_city_name		:=fXlateUnprintable(pInput.p_city_name,tfc);
					SELF.v_city_name		:=fXlateUnprintable(pInput.v_city_name,tfc);
					SELF.bdid						:=pInput.BID; 
					SELF.bdid_score 		:=pInput.BID_SCORE;
					SELF								:=pInput;
				 end;
				 
dpartyBase 	  := dedup(project(UCCV2.File_UCC_Party_Base_AID,tproject(left)),all);
dDist         := distribute(dpartyBase,hash(tmsid,rmsid,fname,lname,mname,prim_name,prim_range,company_name,party_type)); 
dSort         := sort(dedup(sort(dDist, tmsid,rmsid,fname,lname,mname,prim_name,prim_range,company_name,party_type,local),
                       tmsid,fname,lname,mname,prim_name,prim_range,company_name),tmsid,rmsid);


export Key_rmsid_party_bid := INDEX(dSort ,{tmsid,rmsid},{dSort},KeyName +'party_Rmsid_BID' + Doxie.Version_SuperKey);