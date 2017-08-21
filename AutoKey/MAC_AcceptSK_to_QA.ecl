export MAC_AcceptSK_to_QA(fname_in,outaction,diffing='false',
                          accept_skip_set='[]',
						  useAllLookups = 'false') :=
MACRO

#uniquename(out1);
#uniquename(out2);
#uniquename(out3);
#uniquename(out4);
#uniquename(out4_2);
#uniquename(out5);
#uniquename(out5_2);
#uniquename(out6);
#uniquename(out7);
#uniquename(out8);

RoxieKeyBuild.MAC_SK_Move_v2(fname_in+'Address','Q',%out1%,,diffing)
RoxieKeyBuild.MAC_SK_Move_v2(fname_in+'CityStName','Q',%out2%,,diffing)
RoxieKeyBuild.MAC_SK_Move_v2(fname_in+'Name','Q',%out3%,,diffing)
RoxieKeyBuild.MAC_SK_Move_v2(fname_in+'Phone','Q',%out4%,,diffing)
RoxieKeyBuild.MAC_SK_Move_v2(fname_in+'Phone2','Q',%out4_2%,,diffing)
RoxieKeyBuild.MAC_SK_Move_v2(fname_in+'SSN','Q',%out5%,,diffing)
RoxieKeyBuild.MAC_SK_Move_v2(fname_in+'SSN2','Q',%out5_2%,,diffing)
RoxieKeyBuild.MAC_SK_Move_v2(fname_in+'StName','Q',%out6%,,diffing)
RoxieKeyBuild.MAC_SK_Move_v2(fname_in+'Zip','Q',%out7%,,diffing)
RoxieKeyBuild.MAC_SK_Move_v2(fname_in+'ZipPRLName','Q',%out8%,,diffing)


outaction := if('C' in accept_skip_set,output('AUTOKEY MOVE: All Contact keys skipped'),
             parallel(%out1%,
                      %out2%,
				  %out3%,
				  if('P' in accept_skip_set, 
				     output('AUTOKEY MOVE: Phone key skipped'),
				     if(useAllLookups, %out4_2%, %out4%)),
				  if('S' in accept_skip_set,
				     output('AUTOKEY MOVE: SSN key skipped'),
				     if(useAllLookups, %out5_2%, %out5%)),
				  %out6%,
				  %out7%,
					if('-' in accept_skip_set, %out8%)
					));

ENDMACRO;