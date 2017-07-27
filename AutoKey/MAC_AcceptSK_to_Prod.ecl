export MAC_AcceptSK_to_Prod(fname_in,outaction,diffing='false',
                            accept_skip_set='[]') :=
MACRO

#uniquename(out1);
#uniquename(out2);
#uniquename(out3);
#uniquename(out4);
#uniquename(out5);
#uniquename(out6);
#uniquename(out7);

ut.MAC_SK_Move_v2(fname_in+'Address','P',%out1%,,diffing)
ut.MAC_SK_Move_v2(fname_in+'CityStName','P',%out2%,,diffing)
ut.MAC_SK_Move_v2(fname_in+'Name','P',%out3%,,diffing)
ut.MAC_SK_Move_v2(fname_in+'Phone','P',%out4%,,diffing)
ut.MAC_SK_Move_v2(fname_in+'SSN','P',%out5%,,diffing)
ut.MAC_SK_Move_v2(fname_in+'StName','P',%out6%,,diffing)
ut.MAC_SK_Move_v2(fname_in+'Zip','P',%out7%,,diffing)


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