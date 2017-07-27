import AutoKeyI;

export AutoKey_IDs := module
	export params := interface(AutoKeyI.AutoKeyStandardFetchBaseInterface)
		export boolean workHard := true;
		export boolean noFail := false;
		export boolean isdeepDive := false;
	end;
end;