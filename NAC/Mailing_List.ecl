EXPORT Mailing_List(string st) := module
	shared Dev_list1a := 'Jose.Bello@lexisnexis.com'
										+',Charles.Pettola@lexisnexis.com'
										+',Tony.Kirk@lexisnexis.com'
										+',Charles.Salvo@lexisnexis.com'
										//+',Jennifer.paganacci@lexisnexis.com'
										//+',Bonita.Rakestraw@lnssi.com'
										;
	shared Dev_list1 := 'Jose.Bello@lexisnexis.com'
										+',Charles.Pettola@lexisnexis.com'
										+',Tony.Kirk@lexisnexis.com'
										+',Charles.Salvo@lexisnexis.com'
										+',ris-glonoc@risk.lexisnexis.com'
										//+',Jennifer.paganacci@lexisnexis.com'
										//+',Bonita.Rakestraw@lnssi.com'
										;
	shared Dev_list2 := 'Jose.Bello@lexisnexis.com'
										+',Charles.Pettola@lexisnexis.com'
										+',Tony.Kirk@lexisnexis.com'
										+',Charles.Salvo@lexisnexis.com'
										+',LNDataQA@lexisnexis.com'
										//+',Jennifer.paganacci@lexisnexis.com'
										//+',Bonita.Rakestraw@lnssi.com'
										;
	shared Dev_list := 'Jose.Bello@lexisnexis.com'
										+',Charles.Pettola@lexisnexis.com'
										+',Tony.Kirk@lexisnexis.com'
										+',Charles.Salvo@lexisnexis.com'
										+',Cesar.Gonzalez@lexisnexis.com'
										+',nacprojectsupport@lnssi.com'
										+',seth.hall@lnssi.com'
										+',Jennifer.paganacci@lexisnexis.com'
										;
	shared DOPS_list := 'Jose.Bello@lexisnexis.com'
										+',Charles.Pettola@lexisnexis.com'
										+',Tony.Kirk@lexisnexis.com'
										+',Charles.Salvo@lexisnexis.com'
										+',LNDataQA@lexisnexis.com'
										//+',Jennifer.paganacci@lexisnexis.com'
										//+',Bonita.Rakestraw@lnssi.com'
										;
	shared AL_list := Dev_list
										+',madhu.pusarla@dhr.alabama.gov'
										+',lorenzo.braxter@dhr.alabama.gov'
										+',robert.allgood@dhr.alabama.gov'
										+',aaron.biggers@dhr.alabama.gov'
										+',brandon.early@dhr.alabama.gov'
										+',johnnie.cox@dhr.alabama.gov'
										+',valerie.davis@dhr.alabama.gov'
										+',madhu.pusarla@dhr.alabama.gov'
										;
	shared FL_list := Dev_list
										+',lynn_rossow@dcf.state.fl.us'
										+',brenda_gilbert@dcf.state.fl.us'
										+',barbara_roglieri@dcf.state.fl.us'
										+',vijay_muniswami@dcf.state.fl.us '
										;
	shared GA_list := Dev_list
										+',aharrison@dhr.state.ga.us'
										+',yadavenp@dhr.state.ga.us'
										//+',ssfrederick@dhr.state.ga.us'
										+',wobradley@dhr.state.ga.us'
										+',Kimberlin.Donald@dhs.ga.gov'
										+',Latonya.James@dhs.ga.gov'
										+',sonya.ward@dhs.ga.gov'
										;
	shared LA_list := Dev_list
										+',michael.a.morris@la.gov'
										+',michael.dronet@la.gov'
										;
	shared MS_list := Dev_list
										+',joel.savell@mdhs.ms.gov'
										+',karen.powell@mdhs.ms.gov'
										;

	shared fn_mail_recipiant(string recipiant) := function
		return		map(
									recipiant='Validation' =>
										map (
													st = 'AL' => Dev_list
													,st = 'FL' => Dev_list
													,st = 'GA' => Dev_list
													,st = 'LA' => Dev_list
													,st = 'MS' => Dev_list
													,Dev_list
													)
									,recipiant='Alert' =>
											map (
													st = 'AL' => AL_list
													,st = 'FL' => FL_list
													,st = 'GA' => GA_list
													,st = 'LA' => LA_list
													,st = 'MS' => MS_list
													,DOPS_list
													)
									,recipiant='Drupal' =>
											map (
													st = 'AL' => AL_list
													,st = 'FL' => FL_list
													,st = 'GA' => GA_list
													,st = 'LA' => LA_list
													,st = 'MS' => MS_list
													,DOPS_list
													)
									,recipiant='Dev1' => Dev_list1
									,recipiant='Dev1a' => Dev_list1a
									,DOPS_list
									)
									;
	end;

	export Validation := fn_mail_recipiant('Validation');
	export Drupal     := fn_mail_recipiant('Drupal');
	export Alert      := fn_mail_recipiant('Alert');
	export BocaOps    := fn_mail_recipiant('BocaOps');
	export Dev1a      := fn_mail_recipiant('Dev1a');
	export Dev1       := fn_mail_recipiant('Dev1');
	export Dev2       := fn_mail_recipiant('Dev2');

end;