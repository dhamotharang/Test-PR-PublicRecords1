EXPORT GetMonthly(string dt) := dataset(
				'~thor::in::gong::targus::full::' + dt,
						Gong_Neustar.layout_neustar,
										CSV(
												SEPARATOR('|')
											, TERMINATOR(['\n', '\r\n'])
											, MAXLENGTH(2500)
											)
								);