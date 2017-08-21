export MAC_AcceptSK_to_QA(fname_in,outaction,diffing='false',
                          accept_skip_set='[]') :=
MACRO

#uniquename(out1);
#uniquename(out2);
#uniquename(out3);
#uniquename(out4);
#uniquename(out5);
#uniquename(out6);
#uniquename(out7);

ut.MAC_SK_Move_v2(fname_in+'address','Q',%out1%,,diffing)
ut.MAC_SK_Move_v2(fname_in+'citystname','Q',%out2%,,diffing)
ut.MAC_SK_Move_v2(fname_in+'name','Q',%out3%,,diffing)
ut.MAC_SK_Move_v2(fname_in+'phone','Q',%out4%,,diffing)
ut.MAC_SK_Move_v2(fname_in+'ssn','Q',%out5%,,diffing)
ut.MAC_SK_Move_v2(fname_in+'stname','Q',%out6%,,diffing)
ut.MAC_SK_Move_v2(fname_in+'zip','Q',%out7%,,diffing)


outaction := parallel(%out1%,
                      %out2%,
				  %out3%,
				  if('P' in accept_skip_set, 
				     output('AUTOKEY MOVE: Phone key skipped'),
				     %out4%),
				  if('S' in accept_skip_set,
				     output('AUTOKEY MOVE: SSN key skipped'),
				     %out5%),
				  %out6%,
				  %out7%);

ENDMACRO;