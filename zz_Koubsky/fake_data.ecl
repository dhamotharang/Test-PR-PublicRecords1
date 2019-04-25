import Scoring_Project;

EXPORT fake_data := module

		export infile_baseline := '~nkoubsky::in::fake_ds_baseline';
		export infile_modified := '~nkoubsky::in::fake_ds_modified';
		
		export dummy_lay := record
				string Acct_no;
				string str_0;
				string str_10;
				string str_25;
				string str_95;
				integer int_0;
				integer int_10;
				integer int_25;
				integer int_95;
				boolean bool_0;
				boolean bool_10;
				boolean bool_25;
				boolean bool_95;
		end;


		// export ds_dummy_baseline := function
				// return dataset(infile_baseline, dummy_lay, csv(heading(single), quote('"')));
		// end;
		
		// export ds_dummy_modified := function
				// return dataset(infile_modified, dummy_lay, csv(heading(single), quote('"')));
		// end;

		
		export bocashell_baseline := '~scoringqa::out::fcra::bocashell_41_historydate_999999_cert_20141202_1';
		export bocashell_modified := '~scoringqa::out::fcra::bocashell_41_historydate_999999_cert_20141203_1';
		
		// ds_curr := dataset('~scoringqa::out::fcra::bocashell_41_historydate_999999_cert_' + dt + '_1', Scoring_Project.BocaShell_Regular_Layout, thor);
		
		export bocashell_lay := record
				Scoring_Project.BocaShell_Regular_Layout;
		end;

end;