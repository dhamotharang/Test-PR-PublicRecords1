pre_tx := dataset(Drivers.Cluster + 'in::drvlic_tx_full_200211',layout_tx_raw,flat,unsorted);

layout_tx_raw rigit(layout_tx_raw l) := transform
	self.process_date := '20021004'; //this ensures that updated addresses (from sep) will not be marked as history
	self := l;
end;

export File_Tx_Raw := project(pre_tx, rigit(left));