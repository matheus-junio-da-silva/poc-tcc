# slither --print slithir-ssa
```
'solc --version' running
'solc @openzeppelin/contracts=node_modules/@openzeppelin/contracts contracts/ABCCApp.sol --combined-json abi,ast,bin,bin-runtime,srcmap,srcmap-runtime,userdoc,devdoc,hashes --via-ir --optimize --allow-paths .,/home/mat/poc1novo/poc-tcc/detasets/DeFiHackLabs/ABCCApp/contracts' running
INFO:Printers:Contract IUniswapV3
	Function IUniswapV3.exactInputSingle(IUniswapV3.ExactInputSingleParams)
	Function IUniswapV3.exactInput(IUniswapV3.ExactInputParams)
	Function IUniswapV3.slot0()
	Function IUniswapV3.token0()
	Function IUniswapV3.token1()
Contract ABCCApp
	Function Ownable.constructor(address)
		Expression: initialOwner == address(0)
		IRs:
			TMP_0 = CONVERT 0 to address
			TMP_1(bool) = initialOwner_1 == TMP_0
			CONDITION TMP_1
		Expression: revert OwnableInvalidOwner(address)(address(0))
		IRs:
			TMP_2 = CONVERT 0 to address
			TMP_3(None) = SOLIDITY_CALL revert OwnableInvalidOwner(address)(TMP_2)
		Expression: _transferOwnership(initialOwner)
		IRs:
			INTERNAL_CALL, Ownable._transferOwnership(address)(initialOwner_1)
	Function Ownable.owner()
		IRs:
			_owner_1(address) := ϕ(['_owner_0', '_owner_3'])
		Expression: _owner
		IRs:
			RETURN _owner_1
	Function Ownable._checkOwner()
		Expression: owner() != _msgSender()
		IRs:
			TMP_5(address) = INTERNAL_CALL, Ownable.owner()()
			TMP_6(address) = INTERNAL_CALL, Context._msgSender()()
			TMP_7(bool) = TMP_5 != TMP_6
			CONDITION TMP_7
		Expression: revert OwnableUnauthorizedAccount(address)(_msgSender())
		IRs:
			TMP_8(address) = INTERNAL_CALL, Context._msgSender()()
			TMP_9(None) = SOLIDITY_CALL revert OwnableUnauthorizedAccount(address)(TMP_8)
	Function Ownable.renounceOwnership()
		Expression: _transferOwnership(address(0))
		IRs:
			TMP_10 = CONVERT 0 to address
			INTERNAL_CALL, Ownable._transferOwnership(address)(TMP_10)
		Expression: onlyOwner()
		IRs:
			MODIFIER_CALL, Ownable.onlyOwner()()
	Function Ownable.transferOwnership(address)
		Expression: newOwner == address(0)
		IRs:
			TMP_13 = CONVERT 0 to address
			TMP_14(bool) = newOwner_1 == TMP_13
			CONDITION TMP_14
		Expression: revert OwnableInvalidOwner(address)(address(0))
		IRs:
			TMP_15 = CONVERT 0 to address
			TMP_16(None) = SOLIDITY_CALL revert OwnableInvalidOwner(address)(TMP_15)
		Expression: _transferOwnership(newOwner)
		IRs:
			INTERNAL_CALL, Ownable._transferOwnership(address)(newOwner_1)
		Expression: onlyOwner()
		IRs:
			MODIFIER_CALL, Ownable.onlyOwner()()
	Function Ownable._transferOwnership(address)
		IRs:
			newOwner_1(address) := ϕ(['TMP_10', 'initialOwner_1', 'newOwner_1'])
			_owner_2(address) := ϕ(['_owner_0', '_owner_3'])
		Expression: oldOwner = _owner
		IRs:
			oldOwner_1(address) := _owner_2(address)
		Expression: _owner = newOwner
		IRs:
			_owner_3(address) := newOwner_1(address)
		Expression: OwnershipTransferred(oldOwner,newOwner)
		IRs:
			Emit OwnershipTransferred(oldOwner_1,newOwner_1)
	Function Context._msgSender()
		Expression: msg.sender
		IRs:
			RETURN msg.sender
	Function Context._msgData()
		Expression: msg.data
		IRs:
			RETURN msg.data
	Function Context._contextSuffixLength()
		Expression: 0
		IRs:
			RETURN 0
	Function ABCCApp.constructor()
		Expression: isOperators[msg.sender] = true
		IRs:
			REF_0(bool) -> isOperators_0[msg.sender]
			isOperators_1(mapping(address => bool)) := ϕ(['isOperators_0'])
			REF_0(bool) (->isOperators_1) := True(bool)
		Expression: Ownable(msg.sender)
		IRs:
			INTERNAL_CALL, Ownable.constructor(address)(msg.sender)
	Function ABCCApp.dashboard(address)
		IRs:
			USDT_1(IERC20) := ϕ(['USDT_6', 'USDT_2', 'USDT_0', 'USDT_7'])
			DDDD_1(IERC20) := ϕ(['DDDD_7', 'DDDD_8', 'DDDD_13', 'DDDD_0', 'DDDD_16', 'DDDD_3'])
			users_1(mapping(address => ABCCApp.User)) := ϕ(['users_17', 'users_42', 'users_0', 'users_37', 'users_34', 'users_2', 'users_16', 'users_31', 'users_40', 'users_1', 'users_30', 'users_36', 'users_44'])
		Expression: data.currUser = users[target]
		IRs:
			REF_1(ABCCApp.User) -> data_0.currUser
			REF_2(ABCCApp.User) -> users_1[target_1]
			data_1(ABCCApp.DashboardData) := ϕ(['data_0'])
			REF_1(ABCCApp.User) (->data_1) := REF_2(ABCCApp.User)
		Expression: target != address(0)
		IRs:
			TMP_21 = CONVERT 0 to address
			TMP_22(bool) = target_1 != TMP_21
			CONDITION TMP_22
		Expression: data.usdtBalance = USDT.balanceOf(target)
		IRs:
			REF_3(uint256) -> data_1.usdtBalance
			TMP_23(uint256) = HIGH_LEVEL_CALL, dest:USDT_1(IERC20), function:balanceOf, arguments:['target_1']  
			USDT_2(IERC20) := ϕ(['USDT_6', 'USDT_2', 'USDT_1', 'USDT_7'])
			DDDD_2(IERC20) := ϕ(['DDDD_7', 'DDDD_1', 'DDDD_8', 'DDDD_13', 'DDDD_16', 'DDDD_3'])
			data_2(ABCCApp.DashboardData) := ϕ(['data_1'])
			REF_3(uint256) (->data_2) := TMP_23(uint256)
		Expression: data.ddddBalance = DDDD.balanceOf(target)
		IRs:
			REF_5(uint256) -> data_2.ddddBalance
			TMP_24(uint256) = HIGH_LEVEL_CALL, dest:DDDD_2(IERC20), function:balanceOf, arguments:['target_1']  
			DDDD_3(IERC20) := ϕ(['DDDD_2', 'DDDD_7', 'DDDD_8', 'DDDD_13', 'DDDD_16', 'DDDD_3'])
			data_3(ABCCApp.DashboardData) := ϕ(['data_2'])
			REF_5(uint256) (->data_3) := TMP_24(uint256)
		Expression: (None,staticUSDT,None) = getCanClaimUSDT(target)
		IRs:
			TUPLE_0(uint256,uint256,uint256) = INTERNAL_CALL, ABCCApp.getCanClaimUSDT(address)(target_1)
			staticUSDT_1(uint256)= UNPACK TUPLE_0 index: 1 
		Expression: data.powerBalance = data.currUser.remainingUSDT - staticUSDT
		IRs:
			REF_7(uint256) -> data_3.powerBalance
			REF_8(ABCCApp.User) -> data_3.currUser
			REF_9(uint256) -> REF_8.remainingUSDT
			TMP_25(uint256) = REF_9 (c)- staticUSDT_1
			data_4(ABCCApp.DashboardData) := ϕ(['data_3'])
			REF_7(uint256) (->data_4) := TMP_25(uint256)
		Expression: data.currUser.staticUSDT = staticUSDT
		IRs:
			REF_10(ABCCApp.User) -> data_4.currUser
			REF_11(uint256) -> REF_10.staticUSDT
			data_5(ABCCApp.DashboardData) := ϕ(['data_4'])
			REF_11(uint256) (->data_5) := staticUSDT_1(uint256)
		IRs:
			data_6(ABCCApp.DashboardData) := ϕ(['data_5', 'data_1'])
		Expression: data
		IRs:
			RETURN data_6
	Function ABCCApp.setPartUSDT(uint256)
		Expression: partUSDT = target
		IRs:
			partUSDT_1(uint256) := target_1(uint256)
		Expression: onlyOwner()
		IRs:
			MODIFIER_CALL, Ownable.onlyOwner()()
	Function ABCCApp.setOperator(address,bool)
		Expression: isOperators[target] = flag
		IRs:
			REF_12(bool) -> isOperators_1[target_1]
			isOperators_2(mapping(address => bool)) := ϕ(['isOperators_1'])
			REF_12(bool) (->isOperators_2) := flag_1(bool)
		Expression: onlyOwner()
		IRs:
			MODIFIER_CALL, Ownable.onlyOwner()()
	Function ABCCApp.setVaultAddr(address)
		Expression: vaultAddr = target
		IRs:
			vaultAddr_1(address) := target_1(address)
		Expression: onlyOwner()
		IRs:
			MODIFIER_CALL, Ownable.onlyOwner()()
	Function ABCCApp.setEnable(bool)
		Expression: isEnable = flag
		IRs:
			isEnable_1(bool) := flag_1(bool)
		Expression: onlyOwner()
		IRs:
			MODIFIER_CALL, Ownable.onlyOwner()()
	Function ABCCApp.getCanClaimUSDT(address)
		IRs:
			target_1(address) := ϕ(['msg.sender', 'target_1'])
			DAY_1(uint256) := ϕ(['DAY_6', 'DAY_0', 'DAY_4', 'DAY_5', 'DAY_2'])
			users_2(mapping(address => ABCCApp.User)) := ϕ(['users_17', 'users_42', 'users_0', 'users_37', 'users_34', 'users_2', 'users_16', 'users_31', 'users_40', 'users_1', 'users_30', 'users_36', 'users_44'])
		Expression: user = users[target]
		IRs:
			REF_13(ABCCApp.User) -> users_2[target_1]
			user_1(ABCCApp.User) := REF_13(ABCCApp.User)
		Expression: user.remainingUSDT == 0
		IRs:
			REF_14(uint256) -> user_1.remainingUSDT
			TMP_30(bool) = REF_14 == 0
			CONDITION TMP_30
		Expression: (user.dynamicUSDT,0,user.dynamicUSDT)
		IRs:
			REF_15(uint256) -> user_1.dynamicUSDT
			REF_16(uint256) -> user_1.dynamicUSDT
			RETURN REF_15,0,REF_16
		Expression: diffSecond = block.timestamp + getFixedDay() - user.lastClaimTime
		IRs:
			TMP_31(uint256) = INTERNAL_CALL, ABCCApp.getFixedDay()()
			TMP_32(uint256) = block.timestamp (c)+ TMP_31
			REF_17(uint256) -> user_1.lastClaimTime
			TMP_33(uint256) = TMP_32 (c)- REF_17
			diffSecond_1(uint256) := TMP_33(uint256)
		Expression: diffDay = diffSecond / DAY
		IRs:
			TMP_34(uint256) = diffSecond_1 (c)/ DAY_2
			diffDay_1(uint256) := TMP_34(uint256)
		Expression: staticUSDT = diffDay * user.dailyUSDT
		IRs:
			REF_18(uint256) -> user_1.dailyUSDT
			TMP_35(uint256) = diffDay_1 (c)* REF_18
			staticUSDT_1(uint256) := TMP_35(uint256)
		Expression: dynamicUSDT = user.dynamicUSDT
		IRs:
			REF_19(uint256) -> user_1.dynamicUSDT
			dynamicUSDT_1(uint256) := REF_19(uint256)
		Expression: totalUSDT = staticUSDT + dynamicUSDT
		IRs:
			TMP_36(uint256) = staticUSDT_4 (c)+ dynamicUSDT_1
			totalUSDT_1(uint256) := TMP_36(uint256)
		Expression: staticUSDT > user.remainingUSDT
		IRs:
			REF_20(uint256) -> user_1.remainingUSDT
			TMP_37(bool) = staticUSDT_1 > REF_20
			CONDITION TMP_37
		Expression: staticUSDT = user.remainingUSDT
		IRs:
			REF_21(uint256) -> user_1.remainingUSDT
			staticUSDT_3(uint256) := REF_21(uint256)
		Expression: staticUSDT = staticUSDT
		IRs:
			staticUSDT_2(uint256) := staticUSDT_1(uint256)
		IRs:
			staticUSDT_4(uint256) := ϕ(['staticUSDT_2', 'staticUSDT_3'])
		Expression: (totalUSDT,staticUSDT,dynamicUSDT)
		IRs:
			RETURN totalUSDT_1,staticUSDT_4,dynamicUSDT_1
	Function ABCCApp.deposit(uint256,address)
		IRs:
			USDT_3(IERC20) := ϕ(['USDT_6', 'USDT_2', 'USDT_0', 'USDT_7'])
			DDDD_4(IERC20) := ϕ(['DDDD_7', 'DDDD_8', 'DDDD_13', 'DDDD_0', 'DDDD_16', 'DDDD_3'])
			BNB_1(IERC20) := ϕ(['BNB_0', 'BNB_8', 'BNB_5', 'BNB_4'])
			swapV3Router_1(IUniswapV3) := ϕ(['swapV3Router_6', 'swapV3Router_0'])
			partUSDT_2(uint256) := ϕ(['partUSDT_1', 'partUSDT_3', 'partUSDT_0'])
			isEnable_2(bool) := ϕ(['isEnable_1', 'isEnable_0'])
			users_3(mapping(address => ABCCApp.User)) := ϕ(['users_17', 'users_42', 'users_0', 'users_37', 'users_34', 'users_2', 'users_16', 'users_31', 'users_40', 'users_1', 'users_30', 'users_36', 'users_44'])
			userDirects_1(mapping(address => ABCCApp.DirectReferral[])) := ϕ(['userDirects_0', 'userDirects_5', 'userDirects_2', 'userDirects_4'])
			globalData_1(ABCCApp.GlobalData) := ϕ(['globalData_0', 'globalData_18', 'globalData_9', 'globalData_16'])
		Expression: require(bool,string)(isEnable,CLOSED)
		IRs:
			TMP_38(None) = SOLIDITY_CALL require(bool,string)(isEnable_2,CLOSED)
		Expression: require(bool,string)(number > 0,E0)
		IRs:
			TMP_39(bool) = number_1 > 0
			TMP_40(None) = SOLIDITY_CALL require(bool,string)(TMP_39,E0)
		Expression: user = users[msg.sender]
		IRs:
			REF_22(ABCCApp.User) -> users_3[msg.sender]
			user_1 (-> ['users'])(ABCCApp.User) := REF_22(ABCCApp.User)
		Expression: (totalUSDT,None,None) = getCanClaimUSDT(msg.sender)
		IRs:
			TUPLE_1(uint256,uint256,uint256) = INTERNAL_CALL, ABCCApp.getCanClaimUSDT(address)(msg.sender)
			users_4(mapping(address => ABCCApp.User)) := ϕ(['users_2'])
			totalUSDT_1(uint256)= UNPACK TUPLE_1 index: 0 
		Expression: require(bool,string)(totalUSDT == 0,E1)
		IRs:
			TMP_41(bool) = totalUSDT_1 == 0
			TMP_42(None) = SOLIDITY_CALL require(bool,string)(TMP_41,E1)
		Expression: user.joinTime == 0
		IRs:
			REF_23(uint256) -> user_1 (-> ['users']).joinTime
			TMP_43(bool) = REF_23 == 0
			CONDITION TMP_43
		Expression: referer == address(0)
		IRs:
			TMP_44 = CONVERT 0 to address
			TMP_45(bool) = referer_1 == TMP_44
			CONDITION TMP_45
		Expression: referer = address(this)
		IRs:
			TMP_46 = CONVERT this to address
			referer_2(address) := TMP_46(address)
		IRs:
			referer_3(address) := ϕ(['referer_2', 'referer_1'])
		Expression: require(bool,string)(referer != msg.sender,E2)
		IRs:
			TMP_47(bool) = referer_3 != msg.sender
			TMP_48(None) = SOLIDITY_CALL require(bool,string)(TMP_47,E2)
		Expression: referer != address(this)
		IRs:
			TMP_49 = CONVERT this to address
			TMP_50(bool) = referer_3 != TMP_49
			CONDITION TMP_50
		Expression: require(bool,string)(users[referer].joinTime > 0,E3)
		IRs:
			REF_24(ABCCApp.User) -> users_4[referer_3]
			REF_25(uint256) -> REF_24.joinTime
			TMP_51(bool) = REF_25 > 0
			TMP_52(None) = SOLIDITY_CALL require(bool,string)(TMP_51,E3)
		Expression: userDirects[referer].push(DirectReferral({target:msg.sender,timestamp:block.timestamp}))
		IRs:
			REF_26(ABCCApp.DirectReferral[]) -> userDirects_2[referer_3]
			TMP_53(ABCCApp.DirectReferral) = new DirectReferral(msg.sender,block.timestamp)
			REF_28 -> LENGTH REF_26
			TMP_55(uint256) := REF_28(uint256)
			TMP_56(uint256) = TMP_55 (c)+ 1
			userDirects_3(mapping(address => ABCCApp.DirectReferral[])) := ϕ(['userDirects_2'])
			REF_28(uint256) (->userDirects_4) := TMP_56(uint256)
			REF_29(ABCCApp.DirectReferral) -> REF_26[TMP_55]
			userDirects_4(mapping(address => ABCCApp.DirectReferral[])) := ϕ(['userDirects_3'])
			REF_29(ABCCApp.DirectReferral) (->userDirects_4) := TMP_53(ABCCApp.DirectReferral)
		Expression: users[referer].activeCount ++
		IRs:
			REF_30(ABCCApp.User) -> users_4[referer_3]
			REF_31(uint256) -> REF_30.activeCount
			TMP_57(uint256) := REF_31(uint256)
			users_5(mapping(address => ABCCApp.User)) := ϕ(['users_4'])
			REF_31(-> users_5) = REF_31 (c)+ 1
		Expression: user.referer = referer
		IRs:
			REF_32(address) -> user_1 (-> ['users']).referer
			user_2 (-> ['users'])(ABCCApp.User) := ϕ(["user_1 (-> ['users'])"])
			REF_32(address) (->user_2 (-> ['users'])) := referer_3(address)
			users_18(mapping(address => ABCCApp.User)) := ϕ(["user_2 (-> ['users'])"])
		Expression: user.joinTime = block.timestamp
		IRs:
			REF_33(uint256) -> user_2 (-> ['users']).joinTime
			user_3 (-> ['users'])(ABCCApp.User) := ϕ(["user_2 (-> ['users'])"])
			REF_33(uint256) (->user_3 (-> ['users'])) := block.timestamp(uint256)
			users_19(mapping(address => ABCCApp.User)) := ϕ(["user_3 (-> ['users'])"])
		Expression: globalData.totalCount ++
		IRs:
			REF_34(uint256) -> globalData_2.totalCount
			TMP_58(uint256) := REF_34(uint256)
			globalData_3(ABCCApp.GlobalData) := ϕ(['globalData_2'])
			REF_34(-> globalData_3) = REF_34 (c)+ 1
		IRs:
			user_4 (-> ['users'])(ABCCApp.User) := ϕ(["user_1 (-> ['users'])", "user_3 (-> ['users'])"])
		Expression: payUSDT = number * partUSDT
		IRs:
			TMP_59(uint256) = number_1 (c)* partUSDT_3
			payUSDT_1(uint256) := TMP_59(uint256)
		Expression: USDT.transferFrom(msg.sender,address(this),payUSDT)
		IRs:
			TMP_60 = CONVERT this to address
			TMP_61(bool) = HIGH_LEVEL_CALL, dest:USDT_4(IERC20), function:transferFrom, arguments:['msg.sender', 'TMP_60', 'payUSDT_1']  
			USDT_5(IERC20) := ϕ(['USDT_6', 'USDT_2', 'USDT_7', 'USDT_4'])
			DDDD_6(IERC20) := ϕ(['DDDD_5', 'DDDD_7', 'DDDD_8', 'DDDD_13', 'DDDD_16', 'DDDD_3'])
			BNB_3(IERC20) := ϕ(['BNB_2', 'BNB_8', 'BNB_5', 'BNB_4'])
			swapV3Router_3(IUniswapV3) := ϕ(['swapV3Router_6', 'swapV3Router_2'])
			users_6(mapping(address => ABCCApp.User)) := ϕ(['users_17', 'users_42', 'users_37', 'users_34', 'users_2', 'users_16', 'users_31', 'users_40', 'users_1', 'users_30', 'users_36', 'users_44', 'users_5'])
			globalData_4(ABCCApp.GlobalData) := ϕ(['globalData_3', 'globalData_18', 'globalData_9', 'globalData_16'])
		Expression: USDT.allowance(address(this),address(swapV3Router)) < payUSDT
		IRs:
			TMP_62 = CONVERT this to address
			TMP_63 = CONVERT swapV3Router_3 to address
			TMP_64(uint256) = HIGH_LEVEL_CALL, dest:USDT_5(IERC20), function:allowance, arguments:['TMP_62', 'TMP_63']  
			USDT_6(IERC20) := ϕ(['USDT_6', 'USDT_2', 'USDT_5', 'USDT_7'])
			DDDD_7(IERC20) := ϕ(['DDDD_7', 'DDDD_6', 'DDDD_8', 'DDDD_13', 'DDDD_16', 'DDDD_3'])
			BNB_4(IERC20) := ϕ(['BNB_8', 'BNB_5', 'BNB_4', 'BNB_3'])
			swapV3Router_4(IUniswapV3) := ϕ(['swapV3Router_6', 'swapV3Router_3'])
			users_7(mapping(address => ABCCApp.User)) := ϕ(['users_17', 'users_42', 'users_37', 'users_34', 'users_2', 'users_16', 'users_31', 'users_40', 'users_1', 'users_30', 'users_36', 'users_6', 'users_44'])
			globalData_5(ABCCApp.GlobalData) := ϕ(['globalData_4', 'globalData_18', 'globalData_9', 'globalData_16'])
			TMP_65(bool) = TMP_64 < payUSDT_1
			CONDITION TMP_65
		Expression: USDT.approve(address(swapV3Router),type()(uint256).max)
		IRs:
			TMP_66 = CONVERT swapV3Router_4 to address
			TMP_68(uint256) := 115792089237316195423570985008687907853269984665640564039457584007913129639935(uint256)
			TMP_69(bool) = HIGH_LEVEL_CALL, dest:USDT_6(IERC20), function:approve, arguments:['TMP_66', 'TMP_68']  
			USDT_7(IERC20) := ϕ(['USDT_6', 'USDT_2', 'USDT_7'])
			DDDD_8(IERC20) := ϕ(['DDDD_7', 'DDDD_8', 'DDDD_13', 'DDDD_16', 'DDDD_3'])
			BNB_5(IERC20) := ϕ(['BNB_8', 'BNB_5', 'BNB_4'])
			swapV3Router_5(IUniswapV3) := ϕ(['swapV3Router_6', 'swapV3Router_4'])
			users_8(mapping(address => ABCCApp.User)) := ϕ(['users_17', 'users_42', 'users_37', 'users_34', 'users_2', 'users_16', 'users_31', 'users_40', 'users_1', 'users_30', 'users_36', 'users_7', 'users_44'])
			globalData_6(ABCCApp.GlobalData) := ϕ(['globalData_5', 'globalData_18', 'globalData_9', 'globalData_16'])
		Expression: params = IUniswapV3.ExactInputParams({path:abi.encodePacked(address(USDT),uint24(500),address(BNB),uint24(2500),address(DDDD)),recipient:address(this),deadline:block.timestamp + 300,amountIn:payUSDT,amountOutMinimum:0})
		IRs:
			TMP_70 = CONVERT USDT_7 to address
			TMP_71 = CONVERT 500 to uint24
			TMP_72 = CONVERT BNB_5 to address
			TMP_73 = CONVERT 2500 to uint24
			TMP_74 = CONVERT DDDD_8 to address
			TMP_75(bytes) = SOLIDITY_CALL abi.encodePacked()(TMP_70,TMP_71,TMP_72,TMP_73,TMP_74)
			TMP_76 = CONVERT this to address
			TMP_77(uint256) = block.timestamp (c)+ 300
			TMP_78(IUniswapV3.ExactInputParams) = new ExactInputParams(TMP_75,TMP_76,TMP_77,payUSDT_1,0)
			params_1(IUniswapV3.ExactInputParams) := TMP_78(IUniswapV3.ExactInputParams)
		Expression: fullDDDD = swapV3Router.exactInput(params)
		IRs:
			TMP_79(uint256) = HIGH_LEVEL_CALL, dest:swapV3Router_5(IUniswapV3), function:exactInput, arguments:['params_1']  
			swapV3Router_6(IUniswapV3) := ϕ(['swapV3Router_6', 'swapV3Router_5'])
			users_9(mapping(address => ABCCApp.User)) := ϕ(['users_17', 'users_42', 'users_8', 'users_37', 'users_34', 'users_2', 'users_16', 'users_31', 'users_40', 'users_1', 'users_30', 'users_36', 'users_44'])
			globalData_7(ABCCApp.GlobalData) := ϕ(['globalData_6', 'globalData_18', 'globalData_9', 'globalData_16'])
			fullDDDD_1(uint256) := TMP_79(uint256)
		Expression: user.buyedDDDD += fullDDDD
		IRs:
			REF_41(uint256) -> user_4 (-> ['users']).buyedDDDD
			user_5 (-> ['users'])(ABCCApp.User) := ϕ(["user_4 (-> ['users'])"])
			REF_41(-> user_5 (-> ['users'])) = REF_41 (c)+ fullDDDD_1
			users_12(mapping(address => ABCCApp.User)) := ϕ(["user_5 (-> ['users'])"])
		Expression: user.investUSDT += payUSDT
		IRs:
			REF_42(uint256) -> user_5 (-> ['users']).investUSDT
			user_6 (-> ['users'])(ABCCApp.User) := ϕ(["user_5 (-> ['users'])"])
			REF_42(-> user_6 (-> ['users'])) = REF_42 (c)+ payUSDT_1
			users_13(mapping(address => ABCCApp.User)) := ϕ(["user_6 (-> ['users'])"])
		Expression: user.remainingUSDT += payUSDT * 2
		IRs:
			REF_43(uint256) -> user_6 (-> ['users']).remainingUSDT
			TMP_80(uint256) = payUSDT_1 (c)* 2
			user_7 (-> ['users'])(ABCCApp.User) := ϕ(["user_6 (-> ['users'])"])
			REF_43(-> user_7 (-> ['users'])) = REF_43 (c)+ TMP_80
			users_14(mapping(address => ABCCApp.User)) := ϕ(["user_7 (-> ['users'])"])
		Expression: user.lastClaimTime = block.timestamp + getFixedDay()
		IRs:
			REF_44(uint256) -> user_7 (-> ['users']).lastClaimTime
			TMP_81(uint256) = INTERNAL_CALL, ABCCApp.getFixedDay()()
			TMP_82(uint256) = block.timestamp (c)+ TMP_81
			user_8 (-> ['users'])(ABCCApp.User) := ϕ(["user_7 (-> ['users'])"])
			REF_44(uint256) (->user_8 (-> ['users'])) := TMP_82(uint256)
			users_15(mapping(address => ABCCApp.User)) := ϕ(["user_8 (-> ['users'])"])
		Expression: user.referer != address(0)
		IRs:
			REF_45(address) -> user_8 (-> ['users']).referer
			TMP_83 = CONVERT 0 to address
			TMP_84(bool) = REF_45 != TMP_83
			CONDITION TMP_84
		Expression: users[user.referer].directPerf += payUSDT
		IRs:
			REF_46(address) -> user_8 (-> ['users']).referer
			REF_47(ABCCApp.User) -> users_10[REF_46]
			REF_48(uint256) -> REF_47.directPerf
			users_11(mapping(address => ABCCApp.User)) := ϕ(['users_10'])
			REF_48(-> users_11) = REF_48 (c)+ payUSDT_1
		Expression: globalData.totalBuyDDDD += fullDDDD
		IRs:
			REF_49(uint256) -> globalData_8.totalBuyDDDD
			globalData_9(ABCCApp.GlobalData) := ϕ(['globalData_8'])
			REF_49(-> globalData_9) = REF_49 (c)+ fullDDDD_1
		Expression: payUSDT > 1000000000000000000000
		IRs:
			TMP_85(bool) = payUSDT_1 > 1000000000000000000000
			CONDITION TMP_85
		Expression: user.dailyUSDT = user.remainingUSDT * 6 / 1000
		IRs:
			REF_50(uint256) -> user_8 (-> ['users']).dailyUSDT
			REF_51(uint256) -> user_8 (-> ['users']).remainingUSDT
			TMP_86(uint256) = REF_51 (c)* 6
			TMP_87(uint256) = TMP_86 (c)/ 1000
			user_9 (-> ['users'])(ABCCApp.User) := ϕ(["user_8 (-> ['users'])"])
			REF_50(uint256) (->user_9 (-> ['users'])) := TMP_87(uint256)
			users_16(mapping(address => ABCCApp.User)) := ϕ(["user_9 (-> ['users'])"])
		Expression: user.dailyUSDT = user.remainingUSDT * 5 / 1000
		IRs:
			REF_52(uint256) -> user_8 (-> ['users']).dailyUSDT
			REF_53(uint256) -> user_8 (-> ['users']).remainingUSDT
			TMP_88(uint256) = REF_53 (c)* 5
			TMP_89(uint256) = TMP_88 (c)/ 1000
			user_10 (-> ['users'])(ABCCApp.User) := ϕ(["user_8 (-> ['users'])"])
			REF_52(uint256) (->user_10 (-> ['users'])) := TMP_89(uint256)
			users_17(mapping(address => ABCCApp.User)) := ϕ(["user_10 (-> ['users'])"])
		Expression: OnDeposit(msg.sender,payUSDT)
		IRs:
			Emit OnDeposit(msg.sender,payUSDT_1)
	Function ABCCApp.claimDDDD()
		IRs:
			DDDD_9(IERC20) := ϕ(['DDDD_7', 'DDDD_8', 'DDDD_13', 'DDDD_0', 'DDDD_16', 'DDDD_3'])
			vaultAddr_2(address) := ϕ(['vaultAddr_0', 'vaultAddr_5', 'vaultAddr_4', 'vaultAddr_1'])
			claimFee_1(uint256) := ϕ(['claimFee_0', 'claimFee_4', 'claimFee_3'])
			users_20(mapping(address => ABCCApp.User)) := ϕ(['users_17', 'users_42', 'users_0', 'users_37', 'users_34', 'users_2', 'users_16', 'users_31', 'users_40', 'users_1', 'users_30', 'users_36', 'users_44'])
			globalData_10(ABCCApp.GlobalData) := ϕ(['globalData_0', 'globalData_18', 'globalData_9', 'globalData_16'])
		Expression: user = users[msg.sender]
		IRs:
			REF_54(ABCCApp.User) -> users_20[msg.sender]
			user_1 (-> ['users'])(ABCCApp.User) := REF_54(ABCCApp.User)
		Expression: (totalUSDT,staticUSDT,None) = getCanClaimUSDT(msg.sender)
		IRs:
			TUPLE_2(uint256,uint256,uint256) = INTERNAL_CALL, ABCCApp.getCanClaimUSDT(address)(msg.sender)
			users_21(mapping(address => ABCCApp.User)) := ϕ(['users_2'])
			totalUSDT_1(uint256)= UNPACK TUPLE_2 index: 0 
			staticUSDT_1(uint256)= UNPACK TUPLE_2 index: 1 
		Expression: require(bool,string)(totalUSDT > 0,E0)
		IRs:
			TMP_91(bool) = totalUSDT_1 > 0
			TMP_92(None) = SOLIDITY_CALL require(bool,string)(TMP_91,E0)
		Expression: user.remainingUSDT -= staticUSDT
		IRs:
			REF_55(uint256) -> user_1 (-> ['users']).remainingUSDT
			user_2 (-> ['users'])(ABCCApp.User) := ϕ(["user_1 (-> ['users'])"])
			REF_55(-> user_2 (-> ['users'])) = REF_55 (c)- staticUSDT_1
			users_25(mapping(address => ABCCApp.User)) := ϕ(["user_2 (-> ['users'])"])
		Expression: user.dynamicUSDT = 0
		IRs:
			REF_56(uint256) -> user_2 (-> ['users']).dynamicUSDT
			user_3 (-> ['users'])(ABCCApp.User) := ϕ(["user_2 (-> ['users'])"])
			REF_56(uint256) (->user_3 (-> ['users'])) := 0(uint256)
			users_26(mapping(address => ABCCApp.User)) := ϕ(["user_3 (-> ['users'])"])
		Expression: user.staticUSDT = 0
		IRs:
			REF_57(uint256) -> user_3 (-> ['users']).staticUSDT
			user_4 (-> ['users'])(ABCCApp.User) := ϕ(["user_3 (-> ['users'])"])
			REF_57(uint256) (->user_4 (-> ['users'])) := 0(uint256)
			users_27(mapping(address => ABCCApp.User)) := ϕ(["user_4 (-> ['users'])"])
		Expression: user.claimedUSDT += totalUSDT
		IRs:
			REF_58(uint256) -> user_4 (-> ['users']).claimedUSDT
			user_5 (-> ['users'])(ABCCApp.User) := ϕ(["user_4 (-> ['users'])"])
			REF_58(-> user_5 (-> ['users'])) = REF_58 (c)+ totalUSDT_1
			users_28(mapping(address => ABCCApp.User)) := ϕ(["user_5 (-> ['users'])"])
		Expression: user.remainingUSDT == 0 && user.referer != address(0)
		IRs:
			REF_59(uint256) -> user_5 (-> ['users']).remainingUSDT
			TMP_93(bool) = REF_59 == 0
			REF_60(address) -> user_5 (-> ['users']).referer
			TMP_94 = CONVERT 0 to address
			TMP_95(bool) = REF_60 != TMP_94
			TMP_96(bool) = TMP_93 && TMP_95
			CONDITION TMP_96
		Expression: ddddPrice = getDDDDValueInUSDT(1 * 10 ** 18)
		IRs:
			TMP_97(uint256) = 10 (c)** 18
			TMP_98(uint256) = 1 (c)* TMP_97
			TMP_99(uint256) = INTERNAL_CALL, ABCCApp.getDDDDValueInUSDT(uint256)(TMP_98)
			ddddPrice_1(uint256) := TMP_99(uint256)
		Expression: ddddAmount = totalUSDT * 1e18 / ddddPrice
		IRs:
			TMP_100(uint256) = totalUSDT_1 (c)* 1000000000000000000
			TMP_101(uint256) = TMP_100 (c)/ ddddPrice_1
			ddddAmount_1(uint256) := TMP_101(uint256)
		Expression: claimFee > 0
		IRs:
			TMP_102(bool) = claimFee_3 > 0
			CONDITION TMP_102
		Expression: fee = ddddAmount * claimFee / 100
		IRs:
			TMP_103(uint256) = ddddAmount_1 (c)* claimFee_3
			TMP_104(uint256) = TMP_103 (c)/ 100
			fee_1(uint256) := TMP_104(uint256)
		Expression: DDDD.transfer(vaultAddr,fee)
		IRs:
			TMP_105(bool) = HIGH_LEVEL_CALL, dest:DDDD_11(IERC20), function:transfer, arguments:['vaultAddr_4', 'fee_1']  
			DDDD_12(IERC20) := ϕ(['DDDD_7', 'DDDD_11', 'DDDD_8', 'DDDD_13', 'DDDD_16', 'DDDD_3'])
			vaultAddr_5(address) := ϕ(['vaultAddr_5', 'vaultAddr_4', 'vaultAddr_1'])
			globalData_13(ABCCApp.GlobalData) := ϕ(['globalData_12', 'globalData_18', 'globalData_9', 'globalData_16'])
		Expression: ddddAmount -= fee
		IRs:
			ddddAmount_2(uint256) = ddddAmount_1 (c)- fee_1
		IRs:
			ddddAmount_3(uint256) := ϕ(['ddddAmount_1', 'ddddAmount_2'])
		Expression: DDDD.transfer(msg.sender,ddddAmount)
		IRs:
			TMP_106(bool) = HIGH_LEVEL_CALL, dest:DDDD_12(IERC20), function:transfer, arguments:['msg.sender', 'ddddAmount_3']  
			DDDD_13(IERC20) := ϕ(['DDDD_7', 'DDDD_12', 'DDDD_8', 'DDDD_13', 'DDDD_16', 'DDDD_3'])
			globalData_14(ABCCApp.GlobalData) := ϕ(['globalData_13', 'globalData_18', 'globalData_9', 'globalData_16'])
		Expression: user.claimedDDDD += ddddAmount
		IRs:
			REF_63(uint256) -> user_5 (-> ['users']).claimedDDDD
			user_6 (-> ['users'])(ABCCApp.User) := ϕ(["user_5 (-> ['users'])"])
			REF_63(-> user_6 (-> ['users'])) = REF_63 (c)+ ddddAmount_3
			users_29(mapping(address => ABCCApp.User)) := ϕ(["user_6 (-> ['users'])"])
		Expression: user.lastClaimTime = block.timestamp + getFixedDay()
		IRs:
			REF_64(uint256) -> user_6 (-> ['users']).lastClaimTime
			TMP_107(uint256) = INTERNAL_CALL, ABCCApp.getFixedDay()()
			TMP_108(uint256) = block.timestamp (c)+ TMP_107
			user_7 (-> ['users'])(ABCCApp.User) := ϕ(["user_6 (-> ['users'])"])
			REF_64(uint256) (->user_7 (-> ['users'])) := TMP_108(uint256)
			users_30(mapping(address => ABCCApp.User)) := ϕ(["user_7 (-> ['users'])"])
		Expression: globalData.claimedDDDD += ddddAmount
		IRs:
			REF_65(uint256) -> globalData_15.claimedDDDD
			globalData_16(ABCCApp.GlobalData) := ϕ(['globalData_15'])
			REF_65(-> globalData_16) = REF_65 (c)+ ddddAmount_3
		Expression: staticUSDT > 0
		IRs:
			TMP_109(bool) = staticUSDT_1 > 0
			CONDITION TMP_109
		Expression: processReferers(msg.sender,user.referer,staticUSDT)
		IRs:
			REF_66(address) -> user_7 (-> ['users']).referer
			INTERNAL_CALL, ABCCApp.processReferers(address,address,uint256)(msg.sender,REF_66,staticUSDT_1)
		Expression: OnClaimed(msg.sender,ddddAmount)
		IRs:
			Emit OnClaimed(msg.sender,ddddAmount_3)
		Expression: users[user.referer].activeCount > 1
		IRs:
			REF_67(address) -> user_5 (-> ['users']).referer
			REF_68(ABCCApp.User) -> users_21[REF_67]
			REF_69(uint256) -> REF_68.activeCount
			TMP_112(bool) = REF_69 > 1
			CONDITION TMP_112
		Expression: users[user.referer].activeCount = users[user.referer].activeCount - 1
		IRs:
			REF_70(address) -> user_5 (-> ['users']).referer
			REF_71(ABCCApp.User) -> users_21[REF_70]
			REF_72(uint256) -> REF_71.activeCount
			REF_73(address) -> user_5 (-> ['users']).referer
			REF_74(ABCCApp.User) -> users_21[REF_73]
			REF_75(uint256) -> REF_74.activeCount
			TMP_113(uint256) = REF_75 (c)- 1
			users_22(mapping(address => ABCCApp.User)) := ϕ(['users_21'])
			REF_72(uint256) (->users_22) := TMP_113(uint256)
		Expression: users[user.referer].activeCount = 0
		IRs:
			REF_76(address) -> user_5 (-> ['users']).referer
			REF_77(ABCCApp.User) -> users_21[REF_76]
			REF_78(uint256) -> REF_77.activeCount
			users_23(mapping(address => ABCCApp.User)) := ϕ(['users_21'])
			REF_78(uint256) (->users_23) := 0(uint256)
		IRs:
			users_24(mapping(address => ABCCApp.User)) := ϕ(['users_22', 'users_23'])
	Function ABCCApp.processReferers(address,address,uint256)
		IRs:
			sender_1(address) := ϕ(['msg.sender'])
			current_1(address) := ϕ(['REF_66'])
			amountUSDT_1(uint256) := ϕ(['staticUSDT_1'])
			REFERER_RATES_1(uint256[]) := ϕ(['REFERER_RATES_0', 'REFERER_RATES_4', 'REFERER_RATES_1'])
			users_31(mapping(address => ABCCApp.User)) := ϕ(['users_17', 'users_42', 'users_0', 'users_37', 'users_34', 'users_2', 'users_16', 'users_31', 'users_40', 'users_1', 'users_30', 'users_36', 'users_44'])
			userIncomeRecords_1(mapping(address => ABCCApp.IncomeRecord[])) := ϕ(['userIncomeRecords_3', 'userIncomeRecords_4', 'userIncomeRecords_0'])
			globalData_17(ABCCApp.GlobalData) := ϕ(['globalData_0', 'globalData_18', 'globalData_9', 'globalData_16'])
		Expression: keepUSDT = 0
		IRs:
			keepUSDT_1(uint256) := 0(uint256)
		Expression: depth = 0
		IRs:
			depth_1(uint8) := 0(uint256)
		Expression: current != address(this) && current != address(0) && depth < 10
		IRs:
			current_2(address) := ϕ(['current_1', 'current_3'])
			keepUSDT_2(uint256) := ϕ(['keepUSDT_1', 'keepUSDT_3'])
			depth_2(uint8) := ϕ(['depth_3', 'depth_1'])
			TMP_114 = CONVERT this to address
			TMP_115(bool) = current_2 != TMP_114
			TMP_116 = CONVERT 0 to address
			TMP_117(bool) = current_2 != TMP_116
			TMP_118(bool) = TMP_115 && TMP_117
			TMP_119(bool) = depth_2 < 10
			TMP_120(bool) = TMP_118 && TMP_119
			CONDITION TMP_120
		Expression: user = users[current]
		IRs:
			REF_79(ABCCApp.User) -> users_31[current_2]
			user_1 (-> ['users'])(ABCCApp.User) := REF_79(ABCCApp.User)
		Expression: incomeUSDT = amountUSDT * REFERER_RATES[depth] / 100
		IRs:
			REF_80(uint256) -> REFERER_RATES_1[depth_2]
			TMP_121(uint256) = amountUSDT_1 (c)* REF_80
			TMP_122(uint256) = TMP_121 (c)/ 100
			incomeUSDT_1(uint256) := TMP_122(uint256)
		Expression: user.remainingUSDT > 0 && user.activeCount > depth
		IRs:
			REF_81(uint256) -> user_1 (-> ['users']).remainingUSDT
			TMP_123(bool) = REF_81 > 0
			REF_82(uint256) -> user_1 (-> ['users']).activeCount
			TMP_124(bool) = REF_82 > depth_2
			TMP_125(bool) = TMP_123 && TMP_124
			CONDITION TMP_125
		Expression: user.dynamicUSDT += canUSDT
		IRs:
			REF_83(uint256) -> user_1 (-> ['users']).dynamicUSDT
			user_2 (-> ['users'])(ABCCApp.User) := ϕ(["user_1 (-> ['users'])"])
			REF_83(-> user_2 (-> ['users'])) = REF_83 (c)+ canUSDT_3
			users_35(mapping(address => ABCCApp.User)) := ϕ(["user_2 (-> ['users'])"])
		Expression: user.remainingUSDT -= canUSDT
		IRs:
			REF_84(uint256) -> user_2 (-> ['users']).remainingUSDT
			user_3 (-> ['users'])(ABCCApp.User) := ϕ(["user_2 (-> ['users'])"])
			REF_84(-> user_3 (-> ['users'])) = REF_84 (c)- canUSDT_3
			users_36(mapping(address => ABCCApp.User)) := ϕ(["user_3 (-> ['users'])"])
		Expression: user.remainingUSDT == 0
		IRs:
			REF_85(uint256) -> user_3 (-> ['users']).remainingUSDT
			TMP_126(bool) = REF_85 == 0
			CONDITION TMP_126
		Expression: userIncomeRecords[current].push(IncomeRecord({depth:depth,timestamp:block.timestamp,fromUser:sender,amount:canUSDT}))
		IRs:
			REF_86(ABCCApp.IncomeRecord[]) -> userIncomeRecords_1[current_2]
			TMP_127(ABCCApp.IncomeRecord) = new IncomeRecord(depth_2,block.timestamp,sender_1,canUSDT_3)
			REF_88 -> LENGTH REF_86
			TMP_129(uint256) := REF_88(uint256)
			TMP_130(uint256) = TMP_129 (c)+ 1
			userIncomeRecords_2(mapping(address => ABCCApp.IncomeRecord[])) := ϕ(['userIncomeRecords_1'])
			REF_88(uint256) (->userIncomeRecords_3) := TMP_130(uint256)
			REF_89(ABCCApp.IncomeRecord) -> REF_86[TMP_129]
			userIncomeRecords_3(mapping(address => ABCCApp.IncomeRecord[])) := ϕ(['userIncomeRecords_2'])
			REF_89(ABCCApp.IncomeRecord) (->userIncomeRecords_3) := TMP_127(ABCCApp.IncomeRecord)
		Expression: incomeUSDT -= canUSDT
		IRs:
			incomeUSDT_2(uint256) = incomeUSDT_1 (c)- canUSDT_3
		IRs:
			user_4 (-> ['users'])(ABCCApp.User) := ϕ(["user_3 (-> ['users'])", "user_1 (-> ['users'])"])
			incomeUSDT_3(uint256) := ϕ(['incomeUSDT_2', 'incomeUSDT_1'])
		Expression: keepUSDT += incomeUSDT
		IRs:
			keepUSDT_3(uint256) = keepUSDT_2 (c)+ incomeUSDT_3
		Expression: current = user.referer
		IRs:
			REF_90(address) -> user_4 (-> ['users']).referer
			current_3(address) := REF_90(address)
		Expression: depth ++
		IRs:
			TMP_131(uint8) := depth_2(uint8)
			depth_3(uint8) = depth_2 (c)+ 1
		Expression: globalData.retainUSDT += keepUSDT
		IRs:
			REF_91(uint256) -> globalData_17.retainUSDT
			globalData_18(ABCCApp.GlobalData) := ϕ(['globalData_17'])
			REF_91(-> globalData_18) = REF_91 (c)+ keepUSDT_2
		Expression: user.remainingUSDT >= incomeUSDT
		IRs:
			REF_92(uint256) -> user_1 (-> ['users']).remainingUSDT
			TMP_132(bool) = REF_92 >= incomeUSDT_1
			CONDITION TMP_132
		Expression: canUSDT = incomeUSDT
		IRs:
			canUSDT_2(uint256) := incomeUSDT_1(uint256)
		Expression: canUSDT = user.remainingUSDT
		IRs:
			REF_93(uint256) -> user_1 (-> ['users']).remainingUSDT
			canUSDT_1(uint256) := REF_93(uint256)
		IRs:
			canUSDT_3(uint256) := ϕ(['canUSDT_1', 'canUSDT_2'])
		Expression: users[user.referer].activeCount > 1
		IRs:
			REF_94(address) -> user_3 (-> ['users']).referer
			REF_95(ABCCApp.User) -> users_31[REF_94]
			REF_96(uint256) -> REF_95.activeCount
			TMP_133(bool) = REF_96 > 1
			CONDITION TMP_133
		Expression: users[user.referer].activeCount = users[user.referer].activeCount - 1
		IRs:
			REF_97(address) -> user_3 (-> ['users']).referer
			REF_98(ABCCApp.User) -> users_31[REF_97]
			REF_99(uint256) -> REF_98.activeCount
			REF_100(address) -> user_3 (-> ['users']).referer
			REF_101(ABCCApp.User) -> users_31[REF_100]
			REF_102(uint256) -> REF_101.activeCount
			TMP_134(uint256) = REF_102 (c)- 1
			users_32(mapping(address => ABCCApp.User)) := ϕ(['users_31'])
			REF_99(uint256) (->users_32) := TMP_134(uint256)
		Expression: users[user.referer].activeCount = 0
		IRs:
			REF_103(address) -> user_3 (-> ['users']).referer
			REF_104(ABCCApp.User) -> users_31[REF_103]
			REF_105(uint256) -> REF_104.activeCount
			users_33(mapping(address => ABCCApp.User)) := ϕ(['users_31'])
			REF_105(uint256) (->users_33) := 0(uint256)
		IRs:
			users_34(mapping(address => ABCCApp.User)) := ϕ(['users_32', 'users_33'])
	Function ABCCApp.getUserDirects(address,uint256,uint256)
		IRs:
			users_37(mapping(address => ABCCApp.User)) := ϕ(['users_17', 'users_42', 'users_0', 'users_37', 'users_34', 'users_2', 'users_16', 'users_31', 'users_40', 'users_1', 'users_30', 'users_36', 'users_44'])
			userDirects_5(mapping(address => ABCCApp.DirectReferral[])) := ϕ(['userDirects_0', 'userDirects_5', 'userDirects_2', 'userDirects_4'])
		Expression: referrals = userDirects[_user]
		IRs:
			REF_106(ABCCApp.DirectReferral[]) -> userDirects_5[_user_1]
			referrals_1(ABCCApp.DirectReferral[]) = ['REF_106(ABCCApp.DirectReferral[])']
		Expression: len = referrals.length
		IRs:
			REF_107 -> LENGTH referrals_1
			len_1(uint256) := REF_107(uint256)
		Expression: len == 0 || page == 0 || pageSize == 0
		IRs:
			TMP_135(bool) = len_1 == 0
			TMP_136(bool) = page_1 == 0
			TMP_137(bool) = TMP_135 || TMP_136
			TMP_138(bool) = pageSize_1 == 0
			TMP_139(bool) = TMP_137 || TMP_138
			CONDITION TMP_139
		Expression: new ABCCApp.DirectReferralInfo[](0)
		IRs:
			TMP_141(ABCCApp.DirectReferralInfo[])  = new ABCCApp.DirectReferralInfo[](0)
			RETURN TMP_141
		Expression: resultLen = end - start
		IRs:
			TMP_142(uint256) = end_3 (c)- start_3
			resultLen_1(uint256) := TMP_142(uint256)
		Expression: result = new ABCCApp.DirectReferralInfo[](resultLen)
		IRs:
			TMP_144(ABCCApp.DirectReferralInfo[])  = new ABCCApp.DirectReferralInfo[](resultLen_1)
			result_1(ABCCApp.DirectReferralInfo[]) = ['TMP_144(ABCCApp.DirectReferralInfo[])']
		Expression: i = 0
		IRs:
			i_1(uint256) := 0(uint256)
		Expression: i < resultLen
		IRs:
			i_2(uint256) := ϕ(['i_3', 'i_1'])
			TMP_145(bool) = i_2 < resultLen_1
			CONDITION TMP_145
		Expression: ref = referrals[end - 1 - i]
		IRs:
			TMP_146(uint256) = end_3 (c)- 1
			TMP_147(uint256) = TMP_146 (c)- i_2
			REF_108(ABCCApp.DirectReferral) -> referrals_1[TMP_147]
			ref_1(ABCCApp.DirectReferral) := REF_108(ABCCApp.DirectReferral)
		Expression: result[i] = DirectReferralInfo({target:ref.target,timestamp:ref.timestamp,totalInvest:users[ref.target].investUSDT,directPerf:users[ref.target].directPerf,remainingUSDT:users[ref.target].remainingUSDT})
		IRs:
			REF_109(ABCCApp.DirectReferralInfo) -> result_1[i_2]
			REF_110(address) -> ref_1.target
			REF_111(uint256) -> ref_1.timestamp
			REF_112(address) -> ref_1.target
			REF_113(ABCCApp.User) -> users_37[REF_112]
			REF_114(uint256) -> REF_113.investUSDT
			REF_115(address) -> ref_1.target
			REF_116(ABCCApp.User) -> users_37[REF_115]
			REF_117(uint256) -> REF_116.directPerf
			REF_118(address) -> ref_1.target
			REF_119(ABCCApp.User) -> users_37[REF_118]
			REF_120(uint256) -> REF_119.remainingUSDT
			TMP_148(ABCCApp.DirectReferralInfo) = new DirectReferralInfo(REF_110,REF_111,REF_114,REF_117,REF_120)
			result_2(ABCCApp.DirectReferralInfo[]) := ϕ(['result_1'])
			REF_109(ABCCApp.DirectReferralInfo) (->result_2) := TMP_148(ABCCApp.DirectReferralInfo)
		Expression: i ++
		IRs:
			TMP_149(uint256) := i_2(uint256)
			i_3(uint256) = i_2 (c)+ 1
		Expression: result
		IRs:
			RETURN result_1
		Expression: len > page * pageSize
		IRs:
			TMP_150(uint256) = page_1 (c)* pageSize_1
			TMP_151(bool) = len_1 > TMP_150
			CONDITION TMP_151
		Expression: start = len - page * pageSize
		IRs:
			TMP_152(uint256) = page_1 (c)* pageSize_1
			TMP_153(uint256) = len_1 (c)- TMP_152
			start_2(uint256) := TMP_153(uint256)
		Expression: start = 0
		IRs:
			start_1(uint256) := 0(uint256)
		IRs:
			start_3(uint256) := ϕ(['start_1', 'start_2'])
		Expression: len > (page - 1) * pageSize
		IRs:
			TMP_154(uint256) = page_1 (c)- 1
			TMP_155(uint256) = TMP_154 (c)* pageSize_1
			TMP_156(bool) = len_1 > TMP_155
			CONDITION TMP_156
		Expression: end = len - (page - 1) * pageSize
		IRs:
			TMP_157(uint256) = page_1 (c)- 1
			TMP_158(uint256) = TMP_157 (c)* pageSize_1
			TMP_159(uint256) = len_1 (c)- TMP_158
			end_2(uint256) := TMP_159(uint256)
		Expression: end = 0
		IRs:
			end_1(uint256) := 0(uint256)
		IRs:
			end_3(uint256) := ϕ(['end_1', 'end_2'])
	Function ABCCApp.getIncomeRecords(address,uint256,uint256)
		IRs:
			userIncomeRecords_4(mapping(address => ABCCApp.IncomeRecord[])) := ϕ(['userIncomeRecords_3', 'userIncomeRecords_4', 'userIncomeRecords_0'])
		Expression: records = userIncomeRecords[user]
		IRs:
			REF_121(ABCCApp.IncomeRecord[]) -> userIncomeRecords_4[user_1]
			records_1(ABCCApp.IncomeRecord[]) = ['REF_121(ABCCApp.IncomeRecord[])']
		Expression: len = records.length
		IRs:
			REF_122 -> LENGTH records_1
			len_1(uint256) := REF_122(uint256)
		Expression: len == 0 || page == 0 || pageSize == 0
		IRs:
			TMP_160(bool) = len_1 == 0
			TMP_161(bool) = page_1 == 0
			TMP_162(bool) = TMP_160 || TMP_161
			TMP_163(bool) = pageSize_1 == 0
			TMP_164(bool) = TMP_162 || TMP_163
			CONDITION TMP_164
		Expression: new ABCCApp.IncomeRecord[](0)
		IRs:
			TMP_166(ABCCApp.IncomeRecord[])  = new ABCCApp.IncomeRecord[](0)
			RETURN TMP_166
		Expression: resultLen = end - start
		IRs:
			TMP_167(uint256) = end_3 (c)- start_3
			resultLen_1(uint256) := TMP_167(uint256)
		Expression: result = new ABCCApp.IncomeRecord[](resultLen)
		IRs:
			TMP_169(ABCCApp.IncomeRecord[])  = new ABCCApp.IncomeRecord[](resultLen_1)
			result_1(ABCCApp.IncomeRecord[]) = ['TMP_169(ABCCApp.IncomeRecord[])']
		Expression: i = 0
		IRs:
			i_1(uint256) := 0(uint256)
		Expression: i < resultLen
		IRs:
			result_2(ABCCApp.IncomeRecord[]) := ϕ(['result_3', 'result_1'])
			i_2(uint256) := ϕ(['i_1', 'i_3'])
			TMP_170(bool) = i_2 < resultLen_1
			CONDITION TMP_170
		Expression: result[i] = records[end - 1 - i]
		IRs:
			REF_123(ABCCApp.IncomeRecord) -> result_2[i_2]
			TMP_171(uint256) = end_3 (c)- 1
			TMP_172(uint256) = TMP_171 (c)- i_2
			REF_124(ABCCApp.IncomeRecord) -> records_1[TMP_172]
			result_3(ABCCApp.IncomeRecord[]) := ϕ(['result_2'])
			REF_123(ABCCApp.IncomeRecord) (->result_3) := REF_124(ABCCApp.IncomeRecord)
		Expression: i ++
		IRs:
			TMP_173(uint256) := i_2(uint256)
			i_3(uint256) = i_2 (c)+ 1
		Expression: result
		IRs:
			RETURN result_2
		Expression: len > page * pageSize
		IRs:
			TMP_174(uint256) = page_1 (c)* pageSize_1
			TMP_175(bool) = len_1 > TMP_174
			CONDITION TMP_175
		Expression: start = len - page * pageSize
		IRs:
			TMP_176(uint256) = page_1 (c)* pageSize_1
			TMP_177(uint256) = len_1 (c)- TMP_176
			start_1(uint256) := TMP_177(uint256)
		Expression: start = 0
		IRs:
			start_2(uint256) := 0(uint256)
		IRs:
			start_3(uint256) := ϕ(['start_1', 'start_2'])
		Expression: len > (page - 1) * pageSize
		IRs:
			TMP_178(uint256) = page_1 (c)- 1
			TMP_179(uint256) = TMP_178 (c)* pageSize_1
			TMP_180(bool) = len_1 > TMP_179
			CONDITION TMP_180
		Expression: end = len - (page - 1) * pageSize
		IRs:
			TMP_181(uint256) = page_1 (c)- 1
			TMP_182(uint256) = TMP_181 (c)* pageSize_1
			TMP_183(uint256) = len_1 (c)- TMP_182
			end_2(uint256) := TMP_183(uint256)
		Expression: end = 0
		IRs:
			end_1(uint256) := 0(uint256)
		IRs:
			end_3(uint256) := ϕ(['end_1', 'end_2'])
	Function ABCCApp.setSettlePrice(uint256,uint256)
		IRs:
			DAY_3(uint256) := ϕ(['DAY_6', 'DAY_0', 'DAY_4', 'DAY_5', 'DAY_2'])
		Expression: price == 0
		IRs:
			TMP_184(bool) = price_1 == 0
			CONDITION TMP_184
		Expression: price = getDDDDValueInUSDT(1 * 10 ** 18)
		IRs:
			TMP_185(uint256) = 10 (c)** 18
			TMP_186(uint256) = 1 (c)* TMP_185
			TMP_187(uint256) = INTERNAL_CALL, ABCCApp.getDDDDValueInUSDT(uint256)(TMP_186)
			price_2(uint256) := TMP_187(uint256)
		IRs:
			price_3(uint256) := ϕ(['price_1', 'price_2'])
		Expression: targetTime == 0
		IRs:
			TMP_188(bool) = targetTime_1 == 0
			CONDITION TMP_188
		Expression: targetTime = block.timestamp + getFixedDay()
		IRs:
			TMP_189(uint256) = INTERNAL_CALL, ABCCApp.getFixedDay()()
			TMP_190(uint256) = block.timestamp (c)+ TMP_189
			targetTime_2(uint256) := TMP_190(uint256)
		IRs:
			targetTime_3(uint256) := ϕ(['targetTime_2', 'targetTime_1'])
		Expression: dailyPrices[targetTime / DAY] = price
		IRs:
			TMP_191(uint256) = targetTime_3 (c)/ DAY_6
			REF_125(uint256) -> dailyPrices_0[TMP_191]
			dailyPrices_1(mapping(uint256 => uint256)) := ϕ(['dailyPrices_0'])
			REF_125(uint256) (->dailyPrices_1) := price_3(uint256)
		Expression: OnSettlePrice(targetTime,targetTime / DAY,price)
		IRs:
			TMP_192(uint256) = targetTime_3 (c)/ DAY_6
			Emit OnSettlePrice(targetTime_3,TMP_192,price_3)
		Expression: onlyOwner()
		IRs:
			MODIFIER_CALL, Ownable.onlyOwner()()
	Function ABCCApp.setLevelRate(uint256,uint256)
		IRs:
			REFERER_RATES_2(uint256[]) := ϕ(['REFERER_RATES_0', 'REFERER_RATES_4', 'REFERER_RATES_1'])
		Expression: require(bool,string)(index < REFERER_RATES.length,E0)
		IRs:
			REF_126 -> LENGTH REFERER_RATES_3
			TMP_195(bool) = index_1 < REF_126
			TMP_196(None) = SOLIDITY_CALL require(bool,string)(TMP_195,E0)
		Expression: require(bool,string)(value < 100,E1)
		IRs:
			TMP_197(bool) = value_1 < 100
			TMP_198(None) = SOLIDITY_CALL require(bool,string)(TMP_197,E1)
		Expression: REFERER_RATES[index] = value
		IRs:
			REF_127(uint256) -> REFERER_RATES_3[index_1]
			REFERER_RATES_4(uint256[]) := ϕ(['REFERER_RATES_3'])
			REF_127(uint256) (->REFERER_RATES_4) := value_1(uint256)
		Expression: onlyOwner()
		IRs:
			MODIFIER_CALL, Ownable.onlyOwner()()
	Function ABCCApp.setClaimFee(uint256)
		Expression: require(bool,string)(target < 100,E0)
		IRs:
			TMP_200(bool) = target_1 < 100
			TMP_201(None) = SOLIDITY_CALL require(bool,string)(TMP_200,E0)
		Expression: claimFee = target
		IRs:
			claimFee_4(uint256) := target_1(uint256)
		Expression: onlyOwner()
		IRs:
			MODIFIER_CALL, Ownable.onlyOwner()()
	Function ABCCApp.setUserRemainingUSDT(address,uint256)
		IRs:
			users_38(mapping(address => ABCCApp.User)) := ϕ(['users_17', 'users_42', 'users_0', 'users_37', 'users_34', 'users_2', 'users_16', 'users_31', 'users_40', 'users_1', 'users_30', 'users_36', 'users_44'])
		Expression: require(bool,string)(users[target].joinTime > 0,E0)
		IRs:
			REF_128(ABCCApp.User) -> users_39[target_1]
			REF_129(uint256) -> REF_128.joinTime
			TMP_203(bool) = REF_129 > 0
			TMP_204(None) = SOLIDITY_CALL require(bool,string)(TMP_203,E0)
		Expression: old = users[target].remainingUSDT
		IRs:
			REF_130(ABCCApp.User) -> users_39[target_1]
			REF_131(uint256) -> REF_130.remainingUSDT
			old_1(uint256) := REF_131(uint256)
		Expression: users[target].remainingUSDT = value
		IRs:
			REF_132(ABCCApp.User) -> users_39[target_1]
			REF_133(uint256) -> REF_132.remainingUSDT
			users_40(mapping(address => ABCCApp.User)) := ϕ(['users_39'])
			REF_133(uint256) (->users_40) := value_1(uint256)
		Expression: old > 0
		IRs:
			TMP_205(bool) = old_1 > 0
			CONDITION TMP_205
		Expression: value == 0
		IRs:
			TMP_206(bool) = value_1 == 0
			CONDITION TMP_206
		Expression: users[target].activeCount --
		IRs:
			REF_134(ABCCApp.User) -> users_40[target_1]
			REF_135(uint256) -> REF_134.activeCount
			TMP_207(uint256) := REF_135(uint256)
			users_41(mapping(address => ABCCApp.User)) := ϕ(['users_40'])
			REF_135(-> users_41) = REF_135 (c)- 1
		IRs:
			users_42(mapping(address => ABCCApp.User)) := ϕ(['users_40', 'users_41'])
		Expression: old == 0
		IRs:
			TMP_208(bool) = old_1 == 0
			CONDITION TMP_208
		Expression: value > 0
		IRs:
			TMP_209(bool) = value_1 > 0
			CONDITION TMP_209
		Expression: users[target].activeCount ++
		IRs:
			REF_136(ABCCApp.User) -> users_40[target_1]
			REF_137(uint256) -> REF_136.activeCount
			TMP_210(uint256) := REF_137(uint256)
			users_43(mapping(address => ABCCApp.User)) := ϕ(['users_40'])
			REF_137(-> users_43) = REF_137 (c)+ 1
		IRs:
			users_44(mapping(address => ABCCApp.User)) := ϕ(['users_40', 'users_43'])
		Expression: onlyOwner()
		IRs:
			MODIFIER_CALL, Ownable.onlyOwner()()
	Function ABCCApp.getFixedDay()
		IRs:
			DAY_7(uint256) := ϕ(['DAY_6', 'DAY_0', 'DAY_4', 'DAY_5', 'DAY_2'])
			fixedDay_1(uint256) := ϕ(['fixedDay_4', 'fixedDay_0'])
		Expression: fixedDay * DAY
		IRs:
			TMP_212(uint256) = fixedDay_1 (c)* DAY_7
			RETURN TMP_212
	Function ABCCApp.addFixedDay(uint256)
		Expression: target == 0
		IRs:
			TMP_213(bool) = target_1 == 0
			CONDITION TMP_213
		Expression: fixedDay = 0
		IRs:
			fixedDay_3(uint256) := 0(uint256)
		Expression: fixedDay += target
		IRs:
			fixedDay_2(uint256) = fixedDay_1 (c)+ target_1
		IRs:
			fixedDay_4(uint256) := ϕ(['fixedDay_2', 'fixedDay_3'])
	Function ABCCApp.getDDDDValueInUSDT(uint256)
		IRs:
			amount_1(uint256) := ϕ(['TMP_98', 'TMP_186'])
		Expression: tokenPriceInBNB = getTokenPriceInBNB()
		IRs:
			TMP_214(uint256) = INTERNAL_CALL, ABCCApp.getTokenPriceInBNB()()
			tokenPriceInBNB_1(uint256) := TMP_214(uint256)
		Expression: bnbPriceInUSDT = getBNBPriceInUSDT()
		IRs:
			TMP_215(uint256) = INTERNAL_CALL, ABCCApp.getBNBPriceInUSDT()()
			bnbPriceInUSDT_1(uint256) := TMP_215(uint256)
		Expression: valueInUSDT = (amount * tokenPriceInBNB * bnbPriceInUSDT) / (10 ** 18 * 10 ** 18)
		IRs:
			TMP_216(uint256) = amount_1 (c)* tokenPriceInBNB_1
			TMP_217(uint256) = TMP_216 (c)* bnbPriceInUSDT_1
			TMP_218(uint256) = 10 (c)** 18
			TMP_219(uint256) = 10 (c)** 18
			TMP_220(uint256) = TMP_218 (c)* TMP_219
			TMP_221(uint256) = TMP_217 (c)/ TMP_220
			valueInUSDT_1(uint256) := TMP_221(uint256)
		Expression: valueInUSDT
		IRs:
			RETURN valueInUSDT_1
	Function ABCCApp.getTokenPriceInBNB()
		IRs:
			DDDD_14(IERC20) := ϕ(['DDDD_7', 'DDDD_8', 'DDDD_13', 'DDDD_0', 'DDDD_16', 'DDDD_3'])
			ddddBNBPool_1(address) := ϕ(['ddddBNBPool_0'])
			Q96_1(uint256) := ϕ(['Q96_3', 'Q96_0', 'Q96_6'])
		Expression: tokenBnbPool = IUniswapV3(ddddBNBPool)
		IRs:
			TMP_222 = CONVERT ddddBNBPool_1 to IUniswapV3
			tokenBnbPool_1(IUniswapV3) := TMP_222(IUniswapV3)
		Expression: (sqrtPriceX96,None,None,None,None,None,None) = tokenBnbPool.slot0()
		IRs:
			TUPLE_3(uint160,int24,uint16,uint16,uint16,uint32,bool) = HIGH_LEVEL_CALL, dest:tokenBnbPool_1(IUniswapV3), function:slot0, arguments:[]  
			DDDD_15(IERC20) := ϕ(['DDDD_14', 'DDDD_7', 'DDDD_8', 'DDDD_13', 'DDDD_16', 'DDDD_3'])
			Q96_2(uint256) := ϕ(['Q96_3', 'Q96_6', 'Q96_1'])
			sqrtPriceX96_1(uint160)= UNPACK TUPLE_3 index: 0 
		Expression: isToken0 = tokenBnbPool.token0() == address(DDDD)
		IRs:
			TMP_223(address) = HIGH_LEVEL_CALL, dest:tokenBnbPool_1(IUniswapV3), function:token0, arguments:[]  
			DDDD_16(IERC20) := ϕ(['DDDD_15', 'DDDD_7', 'DDDD_8', 'DDDD_13', 'DDDD_16', 'DDDD_3'])
			Q96_3(uint256) := ϕ(['Q96_3', 'Q96_6', 'Q96_2'])
			TMP_224 = CONVERT DDDD_16 to address
			TMP_225(bool) = TMP_223 == TMP_224
			isToken0_1(bool) := TMP_225(bool)
		Expression: isToken0
		IRs:
			CONDITION isToken0_1
		Expression: price = (uint256(sqrtPriceX96) * uint256(sqrtPriceX96) * 10 ** 18) / Q96 / Q96
		IRs:
			TMP_226 = CONVERT sqrtPriceX96_1 to uint256
			TMP_227 = CONVERT sqrtPriceX96_1 to uint256
			TMP_228(uint256) = TMP_226 (c)* TMP_227
			TMP_229(uint256) = 10 (c)** 18
			TMP_230(uint256) = TMP_228 (c)* TMP_229
			TMP_231(uint256) = TMP_230 (c)/ Q96_3
			TMP_232(uint256) = TMP_231 (c)/ Q96_3
			price_2(uint256) := TMP_232(uint256)
		Expression: price = (Q96 * Q96 * 10 ** 18) / uint256(sqrtPriceX96) / uint256(sqrtPriceX96)
		IRs:
			TMP_233(uint256) = Q96_3 (c)* Q96_3
			TMP_234(uint256) = 10 (c)** 18
			TMP_235(uint256) = TMP_233 (c)* TMP_234
			TMP_236 = CONVERT sqrtPriceX96_1 to uint256
			TMP_237(uint256) = TMP_235 (c)/ TMP_236
			TMP_238 = CONVERT sqrtPriceX96_1 to uint256
			TMP_239(uint256) = TMP_237 (c)/ TMP_238
			price_1(uint256) := TMP_239(uint256)
		IRs:
			price_3(uint256) := ϕ(['price_1', 'price_2'])
		Expression: price
		IRs:
			RETURN price_3
	Function ABCCApp.getBNBPriceInUSDT()
		IRs:
			BNB_6(IERC20) := ϕ(['BNB_0', 'BNB_8', 'BNB_5', 'BNB_4'])
			bnbUSDTPool_1(address) := ϕ(['bnbUSDTPool_0'])
			Q96_4(uint256) := ϕ(['Q96_3', 'Q96_0', 'Q96_6'])
		Expression: bnbUsdtPool = IUniswapV3(bnbUSDTPool)
		IRs:
			TMP_240 = CONVERT bnbUSDTPool_1 to IUniswapV3
			bnbUsdtPool_1(IUniswapV3) := TMP_240(IUniswapV3)
		Expression: (sqrtPriceX96,None,None,None,None,None,None) = bnbUsdtPool.slot0()
		IRs:
			TUPLE_4(uint160,int24,uint16,uint16,uint16,uint32,bool) = HIGH_LEVEL_CALL, dest:bnbUsdtPool_1(IUniswapV3), function:slot0, arguments:[]  
			BNB_7(IERC20) := ϕ(['BNB_8', 'BNB_5', 'BNB_6', 'BNB_4'])
			Q96_5(uint256) := ϕ(['Q96_3', 'Q96_6', 'Q96_4'])
			sqrtPriceX96_1(uint160)= UNPACK TUPLE_4 index: 0 
		Expression: isBNBToken0 = bnbUsdtPool.token0() == address(BNB)
		IRs:
			TMP_241(address) = HIGH_LEVEL_CALL, dest:bnbUsdtPool_1(IUniswapV3), function:token0, arguments:[]  
			BNB_8(IERC20) := ϕ(['BNB_7', 'BNB_8', 'BNB_5', 'BNB_4'])
			Q96_6(uint256) := ϕ(['Q96_3', 'Q96_6', 'Q96_5'])
			TMP_242 = CONVERT BNB_8 to address
			TMP_243(bool) = TMP_241 == TMP_242
			isBNBToken0_1(bool) := TMP_243(bool)
		Expression: isBNBToken0
		IRs:
			CONDITION isBNBToken0_1
		Expression: price = (uint256(sqrtPriceX96) * uint256(sqrtPriceX96) * 10 ** 18) / Q96 / Q96
		IRs:
			TMP_244 = CONVERT sqrtPriceX96_1 to uint256
			TMP_245 = CONVERT sqrtPriceX96_1 to uint256
			TMP_246(uint256) = TMP_244 (c)* TMP_245
			TMP_247(uint256) = 10 (c)** 18
			TMP_248(uint256) = TMP_246 (c)* TMP_247
			TMP_249(uint256) = TMP_248 (c)/ Q96_6
			TMP_250(uint256) = TMP_249 (c)/ Q96_6
			price_2(uint256) := TMP_250(uint256)
		Expression: price = (Q96 * Q96 * 10 ** 18) / uint256(sqrtPriceX96) / uint256(sqrtPriceX96)
		IRs:
			TMP_251(uint256) = Q96_6 (c)* Q96_6
			TMP_252(uint256) = 10 (c)** 18
			TMP_253(uint256) = TMP_251 (c)* TMP_252
			TMP_254 = CONVERT sqrtPriceX96_1 to uint256
			TMP_255(uint256) = TMP_253 (c)/ TMP_254
			TMP_256 = CONVERT sqrtPriceX96_1 to uint256
			TMP_257(uint256) = TMP_255 (c)/ TMP_256
			price_1(uint256) := TMP_257(uint256)
		IRs:
			price_3(uint256) := ϕ(['price_1', 'price_2'])
		Expression: price
		IRs:
			RETURN price_3
	Function ABCCApp.emergencyFixed(address,address)
		Expression: balance = IERC20(targetContract).balanceOf(address(this))
		IRs:
			TMP_258 = CONVERT targetContract_1 to IERC20
			TMP_259 = CONVERT this to address
			TMP_260(uint256) = HIGH_LEVEL_CALL, dest:TMP_258(IERC20), function:balanceOf, arguments:['TMP_259']  
			balance_1(uint256) := TMP_260(uint256)
		Expression: balance > 0
		IRs:
			TMP_261(bool) = balance_1 > 0
			CONDITION TMP_261
		Expression: IERC20(targetContract).transfer(recipient,balance)
		IRs:
			TMP_262 = CONVERT targetContract_1 to IERC20
			TMP_263(bool) = HIGH_LEVEL_CALL, dest:TMP_262(IERC20), function:transfer, arguments:['recipient_1', 'balance_1']  
		Expression: onlyOwner()
		IRs:
			MODIFIER_CALL, Ownable.onlyOwner()()
	Function ABCCApp.slitherConstructorVariables()
		Expression: USDT = IERC20(0x55d398326f99059fF775485246999027B3197955)
		Expression: DDDD = IERC20(0x422cBee1289AAE4422eDD8fF56F6578701Bb2878)
		Expression: BNB = IERC20(0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c)
		Expression: swapV3Router = IUniswapV3(0x1b81D678ffb9C0263b24A97847620C99d213eB14)
		Expression: ddddBNBPool = 0xB7021120a77d68243097BfdE152289DB6d623407
		Expression: bnbUSDTPool = 0x36696169C63e42cd08ce11f5deeBbCeBae652050
		Expression: vaultAddr = 0xa446DC212f4AaE662e1B5fF8729e99A4eFE7a174
		Expression: partUSDT = 100000000000000000000
		Expression: claimFee = 5
		Expression: isEnable = true
		Expression: fixedDay = 0
		Expression: REFERER_RATES = (40,20,5,5,5,5,5,5,5,5)
	Function ABCCApp.slitherConstructorConstantVariables()
		Expression: DAY = 86400
		Expression: Q96 = 2 ** 96
	Modifier Ownable.onlyOwner()
ENTRY_POINT
EXPRESSION _checkOwner()
		Expression: _checkOwner()
		IRs:
			INTERNAL_CALL, Ownable._checkOwner()()
_
	Modifier ABCCApp.isOperator()
ENTRY_POINT
		IRs:
			isOperators_3(mapping(address => bool)) := ϕ(['isOperators_1', 'isOperators_2', 'isOperators_3', 'isOperators_0'])
EXPRESSION require(bool,string)(isOperators[msg.sender],No Operator)
		Expression: require(bool,string)(isOperators[msg.sender],No Operator)
		IRs:
			REF_144(bool) -> isOperators_3[msg.sender]
			TMP_271(None) = SOLIDITY_CALL require(bool,string)(REF_144,No Operator)
_
Contract Ownable
	Function Context._msgSender()
		Expression: msg.sender
		IRs:
			RETURN msg.sender
	Function Context._msgData()
		Expression: msg.data
		IRs:
			RETURN msg.data
	Function Context._contextSuffixLength()
		Expression: 0
		IRs:
			RETURN 0
	Function Ownable.constructor(address)
		IRs:
			initialOwner_1(address) := ϕ(['msg.sender'])
		Expression: initialOwner == address(0)
		IRs:
			TMP_272 = CONVERT 0 to address
			TMP_273(bool) = initialOwner_1 == TMP_272
			CONDITION TMP_273
		Expression: revert OwnableInvalidOwner(address)(address(0))
		IRs:
			TMP_274 = CONVERT 0 to address
			TMP_275(None) = SOLIDITY_CALL revert OwnableInvalidOwner(address)(TMP_274)
		Expression: _transferOwnership(initialOwner)
		IRs:
			INTERNAL_CALL, Ownable._transferOwnership(address)(initialOwner_1)
	Function Ownable.owner()
		IRs:
			_owner_1(address) := ϕ(['_owner_3', '_owner_0'])
		Expression: _owner
		IRs:
			RETURN _owner_1
	Function Ownable._checkOwner()
		Expression: owner() != _msgSender()
		IRs:
			TMP_277(address) = INTERNAL_CALL, Ownable.owner()()
			TMP_278(address) = INTERNAL_CALL, Context._msgSender()()
			TMP_279(bool) = TMP_277 != TMP_278
			CONDITION TMP_279
		Expression: revert OwnableUnauthorizedAccount(address)(_msgSender())
		IRs:
			TMP_280(address) = INTERNAL_CALL, Context._msgSender()()
			TMP_281(None) = SOLIDITY_CALL revert OwnableUnauthorizedAccount(address)(TMP_280)
	Function Ownable.renounceOwnership()
		Expression: _transferOwnership(address(0))
		IRs:
			TMP_282 = CONVERT 0 to address
			INTERNAL_CALL, Ownable._transferOwnership(address)(TMP_282)
		Expression: onlyOwner()
		IRs:
			MODIFIER_CALL, Ownable.onlyOwner()()
	Function Ownable.transferOwnership(address)
		Expression: newOwner == address(0)
		IRs:
			TMP_285 = CONVERT 0 to address
			TMP_286(bool) = newOwner_1 == TMP_285
			CONDITION TMP_286
		Expression: revert OwnableInvalidOwner(address)(address(0))
		IRs:
			TMP_287 = CONVERT 0 to address
			TMP_288(None) = SOLIDITY_CALL revert OwnableInvalidOwner(address)(TMP_287)
		Expression: _transferOwnership(newOwner)
		IRs:
			INTERNAL_CALL, Ownable._transferOwnership(address)(newOwner_1)
		Expression: onlyOwner()
		IRs:
			MODIFIER_CALL, Ownable.onlyOwner()()
	Function Ownable._transferOwnership(address)
		IRs:
			newOwner_1(address) := ϕ(['initialOwner_1', 'newOwner_1', 'TMP_282'])
			_owner_2(address) := ϕ(['_owner_3', '_owner_0'])
		Expression: oldOwner = _owner
		IRs:
			oldOwner_1(address) := _owner_2(address)
		Expression: _owner = newOwner
		IRs:
			_owner_3(address) := newOwner_1(address)
		Expression: OwnershipTransferred(oldOwner,newOwner)
		IRs:
			Emit OwnershipTransferred(oldOwner_1,newOwner_1)
	Modifier Ownable.onlyOwner()
ENTRY_POINT
EXPRESSION _checkOwner()
		Expression: _checkOwner()
		IRs:
			INTERNAL_CALL, Ownable._checkOwner()()
_
Contract IERC20
	Function IERC20.totalSupply()
	Function IERC20.balanceOf(address)
	Function IERC20.transfer(address,uint256)
	Function IERC20.allowance(address,address)
	Function IERC20.approve(address,uint256)
	Function IERC20.transferFrom(address,address,uint256)
Contract Context
	Function Context._msgSender()
		Expression: msg.sender
		IRs:
			RETURN msg.sender
	Function Context._msgData()
		Expression: msg.data
		IRs:
			RETURN msg.data
	Function Context._contextSuffixLength()
		Expression: 0
		IRs:
			RETURN 0

INFO:Slither:contracts/ABCCApp.sol analyzed (5 contracts)
```
