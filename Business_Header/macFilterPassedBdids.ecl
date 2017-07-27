export macFilterPassedBdids(pDataset, pBdidField, pBdidsToFilter, pOutput) :=
macro

	pOutput := join(pDataset,
                              pBdidsToFilter,
							left.pBdidField = right.bdid,
           				transform(recordof(pDataset), self := left),
				          hash,
						  left only);

	

endmacro;