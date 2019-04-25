#Workunit('name', 'Personal Score Tracker');


IMPORT Scoring_Project_Macros; 

Inline_Lay := {INTEGER3 AccountNumber, string firstname, string lastname, string streetaddress, string city, string state, string zip, string ssn, string dateofbirth, String homephone};
Inline_ds := dataset([
											{1, 'Benjamin', 'Karnatz', '1207 Beaver Creek Rd', 'Alpharetta', 'GA', '30022', '468214366', '19861202', '5073636085'},
											{2, 'Nathan', 'Koubsky', '4457 115th Ave', 'Clear Lake', 'MN', '55319', '472132596', '19821110', ''}
											// {3, 'Randall', 'Niemeyer', '1409 24th Ave N', 'Saint Cloud', 'MN', '56303', '480864994', '19590723', '3206548143'},
											// {4, 'Bridgett', 'Braaten', '428 28th Ave N', 'Saint Cloud', 'MN', '56303', '471237256', '19910308', ''},
											// {5, 'Vishesh', 'Dosaj', '13085 Morris Rd Apt 6105', 'Alpharetta', 'GA', '30004', '715760766', '19890426', ''}
												], Inline_Lay);

Layout := RECORD
Scoring_Project_Macros.Regression.global_layout;
Scoring_Project_Macros.Regression.pii_layout;
Scoring_Project_Macros.Regression.runtime_layout;
END;


Layout AppendLay(Inline_ds le) := Transform
self.AccountNumber := le.AccountNumber;
self.firstname := le.firstname;
self.lastname := le.lastname;
self.streetaddress := le.streetaddress;
self.city := le.city;
self.state := le.state;
self.zip := le.zip;
self.ssn := le.ssn;
self.dateofbirth := le.dateofbirth;
self.homephone := le.homephone;
Self := [];
END;



Trans_ds :=  Project(Inline_ds, AppendLay(LEFT));

output(Trans_ds, , '~ScoringQA::IN::Personal_Score_Tracker', thor, compressed, overwrite);
