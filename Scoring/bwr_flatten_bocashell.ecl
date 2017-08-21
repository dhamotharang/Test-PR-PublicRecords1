x := RECORD
	STRING30 AccountNumber;
	//risk_indicators.Layout_Boca_Shell;
	risk_indicators.Layout_BocaShell_Flat;
	STRING100 errorcode;
END;

f := dataset('~thor_data50::out::bocashell_test_scroxie', x, csv(quote('"')));
ox := record
	x;
	string1 lf;
end;

ox addLineFeed(f le) := transform
	self.lf := '\n';
	self := le;
end;

final := project(f, addLineFeed(left));
output(final,, '~jorge::out::bocashell_sample_flat', overwrite);
	