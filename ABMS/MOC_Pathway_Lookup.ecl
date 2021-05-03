IMPORT ABMS;
EXPORT MOC_Pathway_Lookup := MODULE

	MOCIDTable := RECORD
		string8		MOCpathway_id;
		string100	MOCpathway_name;
		string20	MOCpathway_Sname;
		string8		certificate_id;
		string300	MOC_pathway_board_message;
	END;
	
	Export dsMOCLookup :=
				dataset([ 
									{'1','Focused Practice in Hospital Medicine','HOSP','1040','Physician is participating in MOC in Internal Medicine with a Focused Practice in Hospital Medicine.<br/>'
																																						+'More information is available at '
																																						+'<a href="http://www.abim.org/maintenance-of-certification/moc-requirements/focused-practice-hospital-medicine.aspx" target="_blank">www.abim.org</a>.<br/>'},
									{'2','Designation of Focused Practice in Hospital Medicine','DFPHM','1041','Physician is participating in Family Medicine Certification with a Designation of Focused Practice in Hospital Medicine.<br/>'
																																						+'More information is available at '
																																						+'<a href="https://www.theabfm.org/moc/rfphm.aspx" target="_blank">https://www.theabfm.org/moc/rfphm.aspx</a>.<br/>'},
									{'3','Focused Practice in Clinical Chemistry','FPClinChem','1066',''},
									{'4','Focused Practice in Clinical Microbiology','FPClinMB','1066',''},
									{'5','Focused Practice in Clinical Chemistry','FPClinChem','1068',''},
									{'6','Focused Practice in Clinical Microbiology','FPClinMB','1068',''},
									{'7','Focused Practice in Pedatric and Adolescent Gynecology','FPPAG','1043',''},
									{'8','Focused Practice in Central Nervous System Endovascular Surgery','FPCNSES','1053',''},
									{'9','Focused Practice in Pediatric Neurological Surgery','FPPNS','1053',''},
									{'10','Focused Practice in Neurological Critical Care','FPNCC','1053',''},
									{'11','Focused Practice in Central Nervous System Endovascular Surgery','FPCNSES','1012',''},
									{'12','Focused Practice in Central Nervous System Endovascular Surgery','FPCNSES','1015',''},
									{'13','Focused Practice in Advanced Emergency Medicine Ultrasonography','FPAEMU','1003',''},
									{'14','Focused Practice in Minimally Invasive Gynecologic Surgery','FPMIGS','1043',''}],MOCIDTable);
END;

