export mac_AddHRIPhone(infile, outfile) := macro
import ut,dx_Gong,codes,risk_indicators;
#uniquename(temp_rec)
%temp_rec% := record
	unsigned4	seq;
	infile;
	boolean disco := false;
	boolean cell := false;
	boolean pager := false;
	boolean sic := false;
	boolean badzip := false;
	boolean changearea := false;
	boolean zipdist := false;
	boolean diffnum := false;
	boolean notfound := false;
	boolean nameaddr := false;
	boolean unlisted := false;
	boolean missing := false;
end;


#uniquename(into_temp)
%temp_rec% %into_temp%(infile L, integer C) := transform
	self.missing := L.phone = '' or length(trim(l.phone)) < 10;
	self.seq := C;
	self := L;
end;

#uniquename(tf)
%tf% := group(project(infile,%into_temp%(LEFT, COUNTER)), seq);

#uniquename(addPhoneRisk1)
%temp_rec% %addPhoneRisk1%(%temp_rec% L, Risk_Indicators.key_phone_table_v2 R) := transform
	zpd := ut.zip_dist(L.zip,R.zip5);
	self.disco := if (R.phone10 = '', L.disco, R.potDisconnect);
	self.zipdist := if (R.phone10 = '', L.zipdist, zpd > 10);
	self.cell := if (R.phone10 = '', L.cell, R.nxx_type in ['01','57','62','04','55','60']);
	self.pager := if (R.phone10 = '', L.pager, R.nxx_type in ['02','52','56','61']);
	self.sic := if (R.phone10 ='', L.sic, r.sic_Code != '');
	self.notfound := if (r.phone10 ='', true, false);
	self.nameaddr := if (r.phone10 = '', L.nameaddr, if (L.lname != R.lname or L.prim_range != R.prim_range
												or L.prim_name != R.prim_name or L.zip != R.zip5, true, false));
	self := L;
end;

#uniquename(roll_risks)
%temp_rec% %roll_risks%(%temp_rec% L, %temp_rec% R) := transform
	self.disco  := L.disco and R.disco;
	self.cell   := L.cell and R.cell;
	self.pager  := L.pager and R.pager;
	self.sic    := L.sic and R.sic;
	self.badzip := L.badzip and R.badzip;
	self.changearea := L.changearea and R.changearea;
	self.zipdist  := L.zipdist and R.zipdist;
	self.diffnum  := L.diffnum and R.diffnum;
	self.notfound := L.notfound and R.notfound;
	self.nameaddr := L.nameaddr and R.nameaddr;
	self.unlisted := false; // not implemented
	self.missing  := false; // none of these are missing, they were filtered
	self := L;
end;

#uniquename(outf1)
%outf1% := rollup(join(%tf%(~missing), Risk_Indicators.key_phone_table_v2, keyed(left.phone = right.phone10),
		%addPhoneRisk1%(LEFT,RIGHT), left outer, KEEP(100), ATMOST(1000)), %roll_risks%(LEFT, RIGHT), true);

#uniquename(addrisk2)
%temp_rec% %AddRisk2%(%temp_rec% L, Risk_indicators.Key_AreaCode_Change R) := transform
	self.changearea := if (R.old_npa != '', true, false);
	self := L;
end;

#uniquename(outf2)
%outf2% := join(%outf1%, risk_indicators.Key_AreaCode_Change,
				keyed(left.phone[1..3] = right.old_npa) and
				keyed(Left.phone[4..6] = right.old_nxx),
				%addRisk2%(LEFT,RIGHT),left outer, KEEP (1));

#uniquename(addRisk3a)
%temp_rec% %addRisk3a%(%temp_rec% L, Risk_Indicators.Key_Telcordia_tpm R) := transform
	self.badzip := R.npa = ''; // No match for this zip code
	self := L;
end;

#uniquename(outf3a)
%outf3a% := join(%outf2%, risk_indicators.Key_Telcordia_tpm,
					keyed(Left.phone[1..3] = right.npa) and
					keyed(left.phone[4..6] = right.nxx) and
					keyed(left.phone[7] = right.tb) AND
					/*keyed*/(left.zip = right.zip), // can't key it yet - key needs rebuilding
					%addRisk3a%(LEFT,RIGHT),left outer,KEEP(1), ATMOST (500));
          // limit will go away when keyed by zip above (stat ~300)

#uniquename(addRisk3)
%temp_rec% %addRisk3%(%temp_rec% L, Risk_Indicators.Key_Telcordia_tpm R) := transform
	self.badzip := IF (R.npa = '', false, L.badzip); // Don't count it as a badzip if there are no matches at all
	self := L;
end;

#uniquename(outf3)
%outf3% := join(%outf3a%, risk_indicators.Key_Telcordia_tpm,
					LEFT.badzip AND
					keyed(Left.phone[1..3] = right.npa) and
					keyed(left.phone[4..6] = right.nxx) and
					keyed(left.phone[7] = right.tb),
					%addRisk3%(LEFT,RIGHT),left outer,KEEP(1));

#uniquename(addRisk4)
%temp_rec% %addRisk4%(%temp_rec% L, string10 rphone10) := transform
	self.diffnum := Rphone10=''; // this phone not found at that address
	self := L;
end;

#uniquename(outf4)
%outf4% := join(%outf3%,dx_Gong.key_address_current(), keyed(left.prim_name = right.prim_name) and
								  keyed(left.st = right.st) and
								  keyed(left.zip = right.z5) and
								  keyed(left.prim_range = right.prim_range) and
								  keyed(left.sec_range = right.sec_range) and
								  keyed(left.predir = right.predir) AND
									left.phone = right.phone10,
							%addRisk4%(LEFT,RIGHT.phone10),left outer, keep(1), ATMOST (ut.limits. PHONE_PER_ADDRESS));

#uniquename(addRisk5)
%temp_rec% %addRisk5%(%temp_rec% L, string5 rz5) := transform
	self.diffnum := IF(Rz5='', false, L.diffnum);
	self := L;
end;

//problem down here is that we are currently saying
//is it missing from either?
//should be saying
//is it missing from both?

#uniquename(outf5)
%outf5% := join(%outf4%,dx_Gong.key_address_current(),
									LEFT.diffnum AND
									keyed(left.prim_name = right.prim_name) and
								  keyed(left.st = right.st) and
								  keyed(left.zip = right.z5) and
								  keyed(left.prim_range = right.prim_range) and
								  keyed(left.sec_range = right.sec_range) and
								  keyed(left.predir = right.predir) and
									right.phone10 != '',
							%addRisk5%(LEFT,RIGHT.z5),left outer, keep(1), ATMOST (ut.limits. PHONE_PER_ADDRESS));

/*
code='0007' => 'The input phone number may be disconnected.',
code='0009' => 'The input phone number is a pager number.',
code='0010' => 'The input phone number is a mobile number.',
code='0015' => 'The input phone number matches a transient commercial or institutional address.',
code='0016' => 'The input phone number and input zip code combination is invalid.',
code='0044' => 'The input phone area code is changing.',
code='0049' => 'The input phone and address are geographically distant (greater than 10 miles).',
code='0064' => 'The input address returns a different phone number.',
code='0073' => 'The input Telephone Number is not found in the public record databases.',
code='0074' => 'The input phone number is associated with a different name and address.',
code='0075' => 'The input name and address are associated with an unlisted/non-published phone number.',
code='0080' => 'The input phone was missing or incomplete.',
*/
#uniquename(assign_codes)
typeof(infile) %assign_codes%(%temp_rec% L) := transform
	self.HRI_Phone := choosen(
					if(L.disco,DATASET([{'0007',codes.VARIOUS_HRI_FILES.HRI_CODE('0007')}],Risk_Indicators.Layout_Desc)) +
					if(L.cell,DATASET([{'0010',codes.VARIOUS_HRI_FILES.HRI_CODE('0010')}],Risk_Indicators.Layout_Desc)) +
					if(L.pager,DATASET([{'0009',codes.VARIOUS_HRI_FILES.HRI_CODE('0009')}],Risk_Indicators.Layout_Desc)) +
					if(L.sic,DATASET([{'0015',codes.VARIOUS_HRI_FILES.HRI_CODE('0015')}],Risk_Indicators.Layout_Desc)) +
					if(L.badzip,DATASET([{'0016',codes.VARIOUS_HRI_FILES.HRI_CODE('0016')}],Risk_Indicators.Layout_Desc)) +
					if(L.changearea,DATASET([{'0044',codes.VARIOUS_HRI_FILES.HRI_CODE('0044')}],Risk_Indicators.Layout_Desc)) +
					if(L.zipdist,DATASET([{'0049',codes.VARIOUS_HRI_FILES.HRI_CODE('0049')}],Risk_Indicators.Layout_Desc)) +
					if(L.diffnum,DATASET([{'0064',codes.VARIOUS_HRI_FILES.HRI_CODE('0064')}],Risk_Indicators.Layout_Desc)) +
					if(L.notfound,DATASET([{'0073',codes.VARIOUS_HRI_FILES.HRI_CODE('0073')}],Risk_Indicators.Layout_Desc)) +
					if(L.nameaddr,DATASET([{'0074',codes.VARIOUS_HRI_FILES.HRI_CODE('0074')}],Risk_Indicators.Layout_Desc)),
					// if(L.missing,DATASET([{'0080',codes.VARIOUS_HRI_FILES.HRI_CODE('0080')}],Risk_Indicators.Layout_Desc)),
					ut.min2(maxHriPer_value,ut.limits.HRI_MAX));
	self := L;
end;


outfile := project(ungroup(%outf5%) + %tf%(missing),%assign_codes%(LEFT));

endmacro;
