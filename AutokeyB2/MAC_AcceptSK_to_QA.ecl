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

RoxieKeyBuild.MAC_SK_Move_v2(fname_in+'Payload','Q',%outuno%,,diffing)
RoxieKeyBuild.MAC_SK_Move_v2(fname_in+'AddressB2','Q',%out1b%,,diffing)
RoxieKeyBuild.MAC_SK_Move_v2(fname_in+'CityStNameB2','Q',%out2b%,,diffing)
RoxieKeyBuild.MAC_SK_Move_v2(fname_in+'NameB2','Q',%out3b%,,diffing)
RoxieKeyBuild.MAC_SK_Move_v2(fname_in+'PhoneB2','Q',%out4b%,,diffing)
RoxieKeyBuild.MAC_SK_Move_v2(fname_in+'FEIN2','Q',%out5b%,,diffing)
RoxieKeyBuild.MAC_SK_Move_v2(fname_in+'StNameB2','Q',%out6b%,,diffing)
RoxieKeyBuild.MAC_SK_Move_v2(fname_in+'ZipB2','Q',%out7b%,,diffing)
RoxieKeyBuild.MAC_SK_Move_v2(fname_in+'NameWords2','Q',%out8b%,,diffing)

Autokey.MAC_AcceptSK_to_QA(fname_in,outregautokey,diffing,accept_skip_set, true)

#uniquename(acceptB)
%acceptB% := parallel(
				  %out1b%,
				  %out2b%,
				  %out3b%,
				  if('Q' in accept_skip_set, 
				     output('AutokeyB2 MOVE: Phone key skipped'),
				     %out4b%),
				  if('F' in accept_skip_set,
				     output('AutokeyB2 MOVE: FEIN key skipped'),
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