IMPORT Debt_Settlement, data_services;

EXPORT CC_In_Debt_Settlement := project(Debt_Settlement.Files().InputCC.Sprayed
																				,transform(Scrubs_Debt_Settlement.CC_Layout_Debt_Settlement
																				,self.idnum := left.id; self := left));