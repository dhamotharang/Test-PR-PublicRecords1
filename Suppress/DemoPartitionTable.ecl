//a lookup table to store the demo customer name, and customer DID range

export DemoPartitionTable := 
dataset([{'IRS & FIDELITY-FENFIS', 999900000000, 999999999999},
				 {'ZOOT', 1, 1515}],
         {string20 CustomerName, unsigned6 didLow, unsigned6 didHigh});