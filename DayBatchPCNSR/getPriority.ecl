export getPriority(STRING10 matchCode,STRING20 search) := 
	MAP(//Map priorities for USPAGE_FL137Z
			search = 'USPAGE_FL137Z' AND matchCode IN ['FL137Z'] => 1,
			search = 'USPAGE_FL137Z' AND matchCode IN ['FL13Z','FL3Z'] => 2,
			search = 'USPAGE_FL137Z' AND matchCode IN ['L137Z'] => 3,
			search = 'USPAGE_FL137Z' AND matchCode IN ['L13Z','L3Z'] => 4,
			search = 'USPAGE_FL137Z' AND matchCode IN ['F137Z'] => 5,
			search = 'USPAGE_FL137Z' AND matchCode IN ['F13Z'] => 6,
			search = 'USPAGE_FL137Z' AND matchCode IN ['137Z'] => 7,
			search = 'USPAGE_FL137Z' => 8,
			//Map priorities for USPAGE_FL13Z
			search = 'USPAGE_FL13Z' AND matchCode IN ['FL137Z','FL13Z','FL3Z'] => 1,
			search = 'USPAGE_FL13Z' AND matchCode IN ['L137Z','L13Z','L3Z'] => 2,
			search = 'USPAGE_FL13Z' => 3,
			//Map priorities for AC2B
			search = 'AC2B' AND matchCode IN ['F137Z','137Z'] => 1,
			search = 'AC2B' AND matchCode IN ['L13Z','13Z'] => 2,
			search = 'AC2B' => 3,
			//Map Priorities for AC4A
			search = 'AC4A' AND matchCode IN ['FLP'] => 1,
			search = 'AC4A' AND matchCode IN ['LP'] => 2,
			search = 'AC4A' => 3,
			//Map all other priorities
			matchCode = 'FL137Z' => 1,
			matchCode = 'FL13Z' => 2,
			matchCode = 'L137Z' => 3,
			matchCode = 'L13Z' => 4,
			matchCode = 'F137Z' => 5,
			matchCode = 'F13Z' => 6,
			matchCode = '137Z' => 7,
			matchCode = '13Z' => 8,
			9
			);