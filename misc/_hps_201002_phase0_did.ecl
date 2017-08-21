import did_add, Header_Slimsort, ut, Address, WatchDog, didville,mdr,header;


string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    '19'+ intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),2,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

layout_in := record
	string last_NAME;
	string first_NAME;
	string JOBCODE_DESCR;
	string BIRTH_DATE;
	end;
	
hps_in := dataset('~thor_200::temp::austin_tx_input_list_20100409',layout_in,csv(separator('\t')));

layout_clean := record
	layout_in;
	//
	string2 src:='';
	//
	string5 title:='';
	string20 fname:='';
	string20 mname:='';
	string20 lname:='';
	string5	 suffix:='';
	string3 score:='';
	//
	string8 clean_dob:= '';
	string2 st:='TX';
	string5 zip5 := '';
	//
	unsigned6 did:=0;
	string9 ssn:='';
	//
	end;
layout_clean to_clean(hps_in l) := transform
	//
	clean_name:= Address.CleanPersonLFM73(trim(l.last_name)+' '+trim(l.first_name));
	self.title := clean_name[1..5];
	self.fname := clean_name[6..25];
	self.mname := clean_name[26..45];
	self.lname := clean_name[46..65];
	self.suffix := clean_name[66..70];
	self.score := clean_name[71..73];
	//
	self.clean_dob := fSlashedMDYtoCYMD(l.BIRTH_DATE);
	//
	self := l;
	end;
hps_clean := project(hps_in,to_clean(left));


matchset :=['D'];

DID_Add.MAC_Match_Flex(hps_clean,matchset,
	'', //ssn
	clean_dob,
	fname,mname,lname,suffix,
	'','','',zip5,st,
	'',	//phone
	did,
	layout_clean,
	false,score, 
	90,outfile,
	true,src)

hps_with_did := outfile;

// output(count(hps_in),named('input_count'));
// output(count(hps_clean),named('after_clean'));
// output(count(hps_with_did),named('after_did'));

export _hps_201002_phase0_did := hps_with_did : persist('~thor::temp::misc._hps_201002_phase0_did');
