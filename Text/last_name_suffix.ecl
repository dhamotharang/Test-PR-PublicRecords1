PATTERN suffix1 := ['Junior', 'JUNIOR',
					'Senior', 'SENIOR',
					'Esquire', 'ESQUIRE',
					'Second', 'SECOND',
					'Third', 'THIRD', 
					'Fourth', 'FOURTH',
					'Fifth', 'FIFTH',
					'CPA', 'C.P.A.', 
					'D.O.','DO', 
					'MD', 'M.D'];

PATTERN suffix2 := ['Jr', 'JR', 
					'Sr', 'SR', 
					'Esq', 'ESQ', 
					'PhD', 'PHD'];

PATTERN suffix3 := ['2nd', '2ND', 
					'3rd', '3RD'];

PATTERN suffix4 := PATTERN('[4-9]') opt('TH' | 'th');

export PATTERN last_name_suffix := 
	suffix1 | suffix2 opt('.') | suffix3 | suffix4 | roman_numeral;