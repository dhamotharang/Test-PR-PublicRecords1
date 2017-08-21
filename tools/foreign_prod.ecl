import ut;
export foreign_prod := if(Tools._Constants.IsDataland
													,ut.foreign_prod
													,'~'
												);
