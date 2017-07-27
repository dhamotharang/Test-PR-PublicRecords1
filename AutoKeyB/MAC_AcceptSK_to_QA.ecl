export MAC_AcceptSK_to_QA(fname_in,outaction,diffing='false',
                          accept_skip_set='[]') :=
MACRO

#uniquename(outuno);
#uniquename(out1b);
#uniquename(out2b);
#uniquename(out3b);
#uniquename(out4b);
#uniquename(out5b);
#uniquename(out6b);
#uniquename(out7b);
#uniquename(out8b);

ut.MAC_SK_Move_v2(fname_in+'Payload','Q',%outuno%,,diffing)
ut.MAC_SK_Move_v2(fname_in+'AddressB','Q',%out1b%,,diffing)
ut.MAC_SK_Move_v2(fname_in+'CityStNameB','Q',%out2b%,,diffing)
ut.MAC_SK_Move_v2(fname_in+'NameB','Q',%out3b%,,diffing)
ut.MAC_SK_Move_v2(fname_in+'PhoneB','Q',%out4b%,,diffing)
ut.MAC_SK_Move_v2(fname_in+'FEIN','Q',%out5b%,,diffing)
ut.MAC_SK_Move_v2(fname_in+'StNameB','Q',%out6b%,,diffing)
ut.MAC_SK_Move_v2(fname_in+'ZipB','Q',%out7b%,,diffing)
ut.MAC_SK_Move_v2(fname_in+'NameWords','Q',%out8b%,,diffing)

Autokey.MAC_AcceptSK_to_QA(fname_in,outregautokey,diffing,accept_skip_set)

#uniquename(acceptB)
%acceptB% := parallel(
				  %out1b%,
				  %out2b%,
				  %out3b%,
				  if('Q' in accept_skip_set, 
				     output('AUTOKEYB MOVE: Phone key skipped'),
				     %out4b%),
				  if('F' in accept_skip_set,
				     output('AUTOKEYB MOVE: FEIN key skipped'),
				     %out5b%),
				  %out6b%,
				  %out7b%,
				  %out8b%);

outaction := parallel(
				  outregautokey,
				  %outuno%,
				  if('B' not in accept_skip_set, %acceptB% )
);

ENDMACRO;