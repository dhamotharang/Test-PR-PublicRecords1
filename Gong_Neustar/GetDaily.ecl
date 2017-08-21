EXPORT GetDaily(string dt) := dataset(
				'~thor::in::gong::targus::daily::'+ dt[1..6] +'::DailyFeed_' + dt + '.txt',
						layout_neustar,
						 CSV(
									SEPARATOR('|')
								, TERMINATOR(['\n', '\r\n'])
								, MAXLENGTH(2500)
								)
					);
																											