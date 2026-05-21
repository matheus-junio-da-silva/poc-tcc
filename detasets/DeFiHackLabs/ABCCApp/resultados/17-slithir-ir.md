# slither --print slithir
```
'solc --version' running
'solc @openzeppelin/contracts=node_modules/@openzeppelin/contracts contracts/ABCCApp.sol --combined-json abi,ast,bin,bin-runtime,srcmap,srcmap-runtime,userdoc,devdoc,hashes --via-ir --optimize --allow-paths .,/home/mat/poc1novo/poc-tcc/detasets/DeFiHackLabs/ABCCApp/contracts' running
INFO:Printers:Contract IUniswapV3
	Function IUniswapV3.exactInputSingle(IUniswapV3.ExactInputSingleParams) (*)
	Function IUniswapV3.exactInput(IUniswapV3.ExactInputParams) (*)
	Function IUniswapV3.slot0() (*)
	Function IUniswapV3.token0() (*)
	Function IUniswapV3.token1() (*)
Contract ABCCApp
	Function Ownable.constructor(address) (*)
		Expression: initialOwner == address(0)
		IRs:
			TMP_0 = CONVERT 0 to address
			TMP_1(bool) = initialOwner == TMP_0
			CONDITION TMP_1
		Expression: revert OwnableInvalidOwner(address)(address(0))
		IRs:
			TMP_2 = CONVERT 0 to address
			TMP_3(None) = SOLIDITY_CALL revert OwnableInvalidOwner(address)(TMP_2)
		Expression: _transferOwnership(initialOwner)
		IRs:
			INTERNAL_CALL, Ownable._transferOwnership(address)(initialOwner)
	Function Ownable.owner() (*)
		Expression: _owner
		IRs:
			RETURN _owner
	Function Ownable._checkOwner() (*)
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
	Function Ownable.renounceOwnership() (*)
		Expression: _transferOwnership(address(0))
		IRs:
			TMP_10 = CONVERT 0 to address
			INTERNAL_CALL, Ownable._transferOwnership(address)(TMP_10)
		Expression: onlyOwner()
		IRs:
			MODIFIER_CALL, Ownable.onlyOwner()()
	Function Ownable.transferOwnership(address) (*)
		Expression: newOwner == address(0)
		IRs:
			TMP_13 = CONVERT 0 to address
			TMP_14(bool) = newOwner == TMP_13
			CONDITION TMP_14
		Expression: revert OwnableInvalidOwner(address)(address(0))
		IRs:
			TMP_15 = CONVERT 0 to address
			TMP_16(None) = SOLIDITY_CALL revert OwnableInvalidOwner(address)(TMP_15)
		Expression: _transferOwnership(newOwner)
		IRs:
			INTERNAL_CALL, Ownable._transferOwnership(address)(newOwner)
		Expression: onlyOwner()
		IRs:
			MODIFIER_CALL, Ownable.onlyOwner()()
	Function Ownable._transferOwnership(address) (*)
		Expression: oldOwner = _owner
		IRs:
			oldOwner(address) := _owner(address)
		Expression: _owner = newOwner
		IRs:
			_owner(address) := newOwner(address)
		Expression: OwnershipTransferred(oldOwner,newOwner)
		IRs:
			Emit OwnershipTransferred(oldOwner,newOwner)
	Function Context._msgSender() (*)
		Expression: msg.sender
		IRs:
			RETURN msg.sender
	Function Context._msgData() (*)
		Expression: msg.data
		IRs:
			RETURN msg.data
	Function Context._contextSuffixLength() (*)
		Expression: 0
		IRs:
			RETURN 0
	Function ABCCApp.constructor() (*)
		Expression: isOperators[msg.sender] = true
		IRs:
			REF_0(bool) -> isOperators[msg.sender]
			REF_0(bool) (->isOperators) := True(bool)
		Expression: Ownable(msg.sender)
		IRs:
			INTERNAL_CALL, Ownable.constructor(address)(msg.sender)
	Function ABCCApp.dashboard(address) (*)
		Expression: data.currUser = users[target]
		IRs:
			REF_1(ABCCApp.User) -> data.currUser
			REF_2(ABCCApp.User) -> users[target]
			REF_1(ABCCApp.User) (->data) := REF_2(ABCCApp.User)
		Expression: target != address(0)
		IRs:
			TMP_21 = CONVERT 0 to address
			TMP_22(bool) = target != TMP_21
			CONDITION TMP_22
		Expression: data.usdtBalance = USDT.balanceOf(target)
		IRs:
			REF_3(uint256) -> data.usdtBalance
			TMP_23(uint256) = HIGH_LEVEL_CALL, dest:USDT(IERC20), function:balanceOf, arguments:['target']  
			REF_3(uint256) (->data) := TMP_23(uint256)
		Expression: data.ddddBalance = DDDD.balanceOf(target)
		IRs:
			REF_5(uint256) -> data.ddddBalance
			TMP_24(uint256) = HIGH_LEVEL_CALL, dest:DDDD(IERC20), function:balanceOf, arguments:['target']  
			REF_5(uint256) (->data) := TMP_24(uint256)
		Expression: (None,staticUSDT,None) = getCanClaimUSDT(target)
		IRs:
			TUPLE_0(uint256,uint256,uint256) = INTERNAL_CALL, ABCCApp.getCanClaimUSDT(address)(target)
			staticUSDT(uint256)= UNPACK TUPLE_0 index: 1 
		Expression: data.powerBalance = data.currUser.remainingUSDT - staticUSDT
		IRs:
			REF_7(uint256) -> data.powerBalance
			REF_8(ABCCApp.User) -> data.currUser
			REF_9(uint256) -> REF_8.remainingUSDT
			TMP_25(uint256) = REF_9 (c)- staticUSDT
			REF_7(uint256) (->data) := TMP_25(uint256)
		Expression: data.currUser.staticUSDT = staticUSDT
		IRs:
			REF_10(ABCCApp.User) -> data.currUser
			REF_11(uint256) -> REF_10.staticUSDT
			REF_11(uint256) (->data) := staticUSDT(uint256)
		Expression: data
		IRs:
			RETURN data
	Function ABCCApp.setPartUSDT(uint256) (*)
		Expression: partUSDT = target
		IRs:
			partUSDT(uint256) := target(uint256)
		Expression: onlyOwner()
		IRs:
			MODIFIER_CALL, Ownable.onlyOwner()()
	Function ABCCApp.setOperator(address,bool) (*)
		Expression: isOperators[target] = flag
		IRs:
			REF_12(bool) -> isOperators[target]
			REF_12(bool) (->isOperators) := flag(bool)
		Expression: onlyOwner()
		IRs:
			MODIFIER_CALL, Ownable.onlyOwner()()
	Function ABCCApp.setVaultAddr(address) (*)
		Expression: vaultAddr = target
		IRs:
			vaultAddr(address) := target(address)
		Expression: onlyOwner()
		IRs:
			MODIFIER_CALL, Ownable.onlyOwner()()
	Function ABCCApp.setEnable(bool) (*)
		Expression: isEnable = flag
		IRs:
			isEnable(bool) := flag(bool)
		Expression: onlyOwner()
		IRs:
			MODIFIER_CALL, Ownable.onlyOwner()()
	Function ABCCApp.getCanClaimUSDT(address) (*)
		Expression: user = users[target]
		IRs:
			REF_13(ABCCApp.User) -> users[target]
			user(ABCCApp.User) := REF_13(ABCCApp.User)
		Expression: user.remainingUSDT == 0
		IRs:
			REF_14(uint256) -> user.remainingUSDT
			TMP_30(bool) = REF_14 == 0
			CONDITION TMP_30
		Expression: (user.dynamicUSDT,0,user.dynamicUSDT)
		IRs:
			REF_15(uint256) -> user.dynamicUSDT
			REF_16(uint256) -> user.dynamicUSDT
			RETURN REF_15,0,REF_16
		Expression: diffSecond = block.timestamp + getFixedDay() - user.lastClaimTime
		IRs:
			TMP_31(uint256) = INTERNAL_CALL, ABCCApp.getFixedDay()()
			TMP_32(uint256) = block.timestamp (c)+ TMP_31
			REF_17(uint256) -> user.lastClaimTime
			TMP_33(uint256) = TMP_32 (c)- REF_17
			diffSecond(uint256) := TMP_33(uint256)
		Expression: diffDay = diffSecond / DAY
		IRs:
			TMP_34(uint256) = diffSecond (c)/ DAY
			diffDay(uint256) := TMP_34(uint256)
		Expression: staticUSDT = diffDay * user.dailyUSDT
		IRs:
			REF_18(uint256) -> user.dailyUSDT
			TMP_35(uint256) = diffDay (c)* REF_18
			staticUSDT(uint256) := TMP_35(uint256)
		Expression: dynamicUSDT = user.dynamicUSDT
		IRs:
			REF_19(uint256) -> user.dynamicUSDT
			dynamicUSDT(uint256) := REF_19(uint256)
		Expression: totalUSDT = staticUSDT + dynamicUSDT
		IRs:
			TMP_36(uint256) = staticUSDT (c)+ dynamicUSDT
			totalUSDT(uint256) := TMP_36(uint256)
		Expression: staticUSDT > user.remainingUSDT
		IRs:
			REF_20(uint256) -> user.remainingUSDT
			TMP_37(bool) = staticUSDT > REF_20
			CONDITION TMP_37
		Expression: staticUSDT = user.remainingUSDT
		IRs:
			REF_21(uint256) -> user.remainingUSDT
			staticUSDT(uint256) := REF_21(uint256)
		Expression: staticUSDT = staticUSDT
		IRs:
			staticUSDT(uint256) := staticUSDT(uint256)
		Expression: (totalUSDT,staticUSDT,dynamicUSDT)
		IRs:
			RETURN totalUSDT,staticUSDT,dynamicUSDT
	Function ABCCApp.deposit(uint256,address) (*)
		Expression: require(bool,string)(isEnable,CLOSED)
		IRs:
			TMP_38(None) = SOLIDITY_CALL require(bool,string)(isEnable,CLOSED)
		Expression: require(bool,string)(number > 0,E0)
		IRs:
			TMP_39(bool) = number > 0
			TMP_40(None) = SOLIDITY_CALL require(bool,string)(TMP_39,E0)
		Expression: user = users[msg.sender]
		IRs:
			REF_22(ABCCApp.User) -> users[msg.sender]
			user(ABCCApp.User) := REF_22(ABCCApp.User)
		Expression: (totalUSDT,None,None) = getCanClaimUSDT(msg.sender)
		IRs:
			TUPLE_1(uint256,uint256,uint256) = INTERNAL_CALL, ABCCApp.getCanClaimUSDT(address)(msg.sender)
			totalUSDT(uint256)= UNPACK TUPLE_1 index: 0 
		Expression: require(bool,string)(totalUSDT == 0,E1)
		IRs:
			TMP_41(bool) = totalUSDT == 0
			TMP_42(None) = SOLIDITY_CALL require(bool,string)(TMP_41,E1)
		Expression: user.joinTime == 0
		IRs:
			REF_23(uint256) -> user.joinTime
			TMP_43(bool) = REF_23 == 0
			CONDITION TMP_43
		Expression: referer == address(0)
		IRs:
			TMP_44 = CONVERT 0 to address
			TMP_45(bool) = referer == TMP_44
			CONDITION TMP_45
		Expression: referer = address(this)
		IRs:
			TMP_46 = CONVERT this to address
			referer(address) := TMP_46(address)
		Expression: require(bool,string)(referer != msg.sender,E2)
		IRs:
			TMP_47(bool) = referer != msg.sender
			TMP_48(None) = SOLIDITY_CALL require(bool,string)(TMP_47,E2)
		Expression: referer != address(this)
		IRs:
			TMP_49 = CONVERT this to address
			TMP_50(bool) = referer != TMP_49
			CONDITION TMP_50
		Expression: require(bool,string)(users[referer].joinTime > 0,E3)
		IRs:
			REF_24(ABCCApp.User) -> users[referer]
			REF_25(uint256) -> REF_24.joinTime
			TMP_51(bool) = REF_25 > 0
			TMP_52(None) = SOLIDITY_CALL require(bool,string)(TMP_51,E3)
		Expression: userDirects[referer].push(DirectReferral({target:msg.sender,timestamp:block.timestamp}))
		IRs:
			REF_26(ABCCApp.DirectReferral[]) -> userDirects[referer]
			TMP_53(ABCCApp.DirectReferral) = new DirectReferral(msg.sender,block.timestamp)
			REF_28 -> LENGTH REF_26
			TMP_55(uint256) := REF_28(uint256)
			TMP_56(uint256) = TMP_55 (c)+ 1
			REF_28(uint256) (->userDirects) := TMP_56(uint256)
			REF_29(ABCCApp.DirectReferral) -> REF_26[TMP_55]
			REF_29(ABCCApp.DirectReferral) (->userDirects) := TMP_53(ABCCApp.DirectReferral)
		Expression: users[referer].activeCount ++
		IRs:
			REF_30(ABCCApp.User) -> users[referer]
			REF_31(uint256) -> REF_30.activeCount
			TMP_57(uint256) := REF_31(uint256)
			REF_31(-> users) = REF_31 (c)+ 1
		Expression: user.referer = referer
		IRs:
			REF_32(address) -> user.referer
			REF_32(address) (->user) := referer(address)
		Expression: user.joinTime = block.timestamp
		IRs:
			REF_33(uint256) -> user.joinTime
			REF_33(uint256) (->user) := block.timestamp(uint256)
		Expression: globalData.totalCount ++
		IRs:
			REF_34(uint256) -> globalData.totalCount
			TMP_58(uint256) := REF_34(uint256)
			REF_34(-> globalData) = REF_34 (c)+ 1
		Expression: payUSDT = number * partUSDT
		IRs:
			TMP_59(uint256) = number (c)* partUSDT
			payUSDT(uint256) := TMP_59(uint256)
		Expression: USDT.transferFrom(msg.sender,address(this),payUSDT)
		IRs:
			TMP_60 = CONVERT this to address
			TMP_61(bool) = HIGH_LEVEL_CALL, dest:USDT(IERC20), function:transferFrom, arguments:['msg.sender', 'TMP_60', 'payUSDT']  
		Expression: USDT.allowance(address(this),address(swapV3Router)) < payUSDT
		IRs:
			TMP_62 = CONVERT this to address
			TMP_63 = CONVERT swapV3Router to address
			TMP_64(uint256) = HIGH_LEVEL_CALL, dest:USDT(IERC20), function:allowance, arguments:['TMP_62', 'TMP_63']  
			TMP_65(bool) = TMP_64 < payUSDT
			CONDITION TMP_65
		Expression: USDT.approve(address(swapV3Router),type()(uint256).max)
		IRs:
			TMP_66 = CONVERT swapV3Router to address
			TMP_68(uint256) := 115792089237316195423570985008687907853269984665640564039457584007913129639935(uint256)
			TMP_69(bool) = HIGH_LEVEL_CALL, dest:USDT(IERC20), function:approve, arguments:['TMP_66', 'TMP_68']  
		Expression: params = IUniswapV3.ExactInputParams({path:abi.encodePacked(address(USDT),uint24(500),address(BNB),uint24(2500),address(DDDD)),recipient:address(this),deadline:block.timestamp + 300,amountIn:payUSDT,amountOutMinimum:0})
		IRs:
			TMP_70 = CONVERT USDT to address
			TMP_71 = CONVERT 500 to uint24
			TMP_72 = CONVERT BNB to address
			TMP_73 = CONVERT 2500 to uint24
			TMP_74 = CONVERT DDDD to address
			TMP_75(bytes) = SOLIDITY_CALL abi.encodePacked()(TMP_70,TMP_71,TMP_72,TMP_73,TMP_74)
			TMP_76 = CONVERT this to address
			TMP_77(uint256) = block.timestamp (c)+ 300
			TMP_78(IUniswapV3.ExactInputParams) = new ExactInputParams(TMP_75,TMP_76,TMP_77,payUSDT,0)
			params(IUniswapV3.ExactInputParams) := TMP_78(IUniswapV3.ExactInputParams)
		Expression: fullDDDD = swapV3Router.exactInput(params)
		IRs:
			TMP_79(uint256) = HIGH_LEVEL_CALL, dest:swapV3Router(IUniswapV3), function:exactInput, arguments:['params']  
			fullDDDD(uint256) := TMP_79(uint256)
		Expression: user.buyedDDDD += fullDDDD
		IRs:
			REF_41(uint256) -> user.buyedDDDD
			REF_41(-> user) = REF_41 (c)+ fullDDDD
		Expression: user.investUSDT += payUSDT
		IRs:
			REF_42(uint256) -> user.investUSDT
			REF_42(-> user) = REF_42 (c)+ payUSDT
		Expression: user.remainingUSDT += payUSDT * 2
		IRs:
			REF_43(uint256) -> user.remainingUSDT
			TMP_80(uint256) = payUSDT (c)* 2
			REF_43(-> user) = REF_43 (c)+ TMP_80
		Expression: user.lastClaimTime = block.timestamp + getFixedDay()
		IRs:
			REF_44(uint256) -> user.lastClaimTime
			TMP_81(uint256) = INTERNAL_CALL, ABCCApp.getFixedDay()()
			TMP_82(uint256) = block.timestamp (c)+ TMP_81
			REF_44(uint256) (->user) := TMP_82(uint256)
		Expression: user.referer != address(0)
		IRs:
			REF_45(address) -> user.referer
			TMP_83 = CONVERT 0 to address
			TMP_84(bool) = REF_45 != TMP_83
			CONDITION TMP_84
		Expression: users[user.referer].directPerf += payUSDT
		IRs:
			REF_46(address) -> user.referer
			REF_47(ABCCApp.User) -> users[REF_46]
			REF_48(uint256) -> REF_47.directPerf
			REF_48(-> users) = REF_48 (c)+ payUSDT
		Expression: globalData.totalBuyDDDD += fullDDDD
		IRs:
			REF_49(uint256) -> globalData.totalBuyDDDD
			REF_49(-> globalData) = REF_49 (c)+ fullDDDD
		Expression: payUSDT > 1000000000000000000000
		IRs:
			TMP_85(bool) = payUSDT > 1000000000000000000000
			CONDITION TMP_85
		Expression: user.dailyUSDT = user.remainingUSDT * 6 / 1000
		IRs:
			REF_50(uint256) -> user.dailyUSDT
			REF_51(uint256) -> user.remainingUSDT
			TMP_86(uint256) = REF_51 (c)* 6
			TMP_87(uint256) = TMP_86 (c)/ 1000
			REF_50(uint256) (->user) := TMP_87(uint256)
		Expression: user.dailyUSDT = user.remainingUSDT * 5 / 1000
		IRs:
			REF_52(uint256) -> user.dailyUSDT
			REF_53(uint256) -> user.remainingUSDT
			TMP_88(uint256) = REF_53 (c)* 5
			TMP_89(uint256) = TMP_88 (c)/ 1000
			REF_52(uint256) (->user) := TMP_89(uint256)
		Expression: OnDeposit(msg.sender,payUSDT)
		IRs:
			Emit OnDeposit(msg.sender,payUSDT)
	Function ABCCApp.claimDDDD() (*)
		Expression: user = users[msg.sender]
		IRs:
			REF_54(ABCCApp.User) -> users[msg.sender]
			user(ABCCApp.User) := REF_54(ABCCApp.User)
		Expression: (totalUSDT,staticUSDT,None) = getCanClaimUSDT(msg.sender)
		IRs:
			TUPLE_2(uint256,uint256,uint256) = INTERNAL_CALL, ABCCApp.getCanClaimUSDT(address)(msg.sender)
			totalUSDT(uint256)= UNPACK TUPLE_2 index: 0 
			staticUSDT(uint256)= UNPACK TUPLE_2 index: 1 
		Expression: require(bool,string)(totalUSDT > 0,E0)
		IRs:
			TMP_91(bool) = totalUSDT > 0
			TMP_92(None) = SOLIDITY_CALL require(bool,string)(TMP_91,E0)
		Expression: user.remainingUSDT -= staticUSDT
		IRs:
			REF_55(uint256) -> user.remainingUSDT
			REF_55(-> user) = REF_55 (c)- staticUSDT
		Expression: user.dynamicUSDT = 0
		IRs:
			REF_56(uint256) -> user.dynamicUSDT
			REF_56(uint256) (->user) := 0(uint256)
		Expression: user.staticUSDT = 0
		IRs:
			REF_57(uint256) -> user.staticUSDT
			REF_57(uint256) (->user) := 0(uint256)
		Expression: user.claimedUSDT += totalUSDT
		IRs:
			REF_58(uint256) -> user.claimedUSDT
			REF_58(-> user) = REF_58 (c)+ totalUSDT
		Expression: user.remainingUSDT == 0 && user.referer != address(0)
		IRs:
			REF_59(uint256) -> user.remainingUSDT
			TMP_93(bool) = REF_59 == 0
			REF_60(address) -> user.referer
			TMP_94 = CONVERT 0 to address
			TMP_95(bool) = REF_60 != TMP_94
			TMP_96(bool) = TMP_93 && TMP_95
			CONDITION TMP_96
		Expression: ddddPrice = getDDDDValueInUSDT(1 * 10 ** 18)
		IRs:
			TMP_97(uint256) = 10 (c)** 18
			TMP_98(uint256) = 1 (c)* TMP_97
			TMP_99(uint256) = INTERNAL_CALL, ABCCApp.getDDDDValueInUSDT(uint256)(TMP_98)
			ddddPrice(uint256) := TMP_99(uint256)
		Expression: ddddAmount = totalUSDT * 1e18 / ddddPrice
		IRs:
			TMP_100(uint256) = totalUSDT (c)* 1000000000000000000
			TMP_101(uint256) = TMP_100 (c)/ ddddPrice
			ddddAmount(uint256) := TMP_101(uint256)
		Expression: claimFee > 0
		IRs:
			TMP_102(bool) = claimFee > 0
			CONDITION TMP_102
		Expression: fee = ddddAmount * claimFee / 100
		IRs:
			TMP_103(uint256) = ddddAmount (c)* claimFee
			TMP_104(uint256) = TMP_103 (c)/ 100
			fee(uint256) := TMP_104(uint256)
		Expression: DDDD.transfer(vaultAddr,fee)
		IRs:
			TMP_105(bool) = HIGH_LEVEL_CALL, dest:DDDD(IERC20), function:transfer, arguments:['vaultAddr', 'fee']  
		Expression: ddddAmount -= fee
		IRs:
			ddddAmount(uint256) = ddddAmount (c)- fee
		Expression: DDDD.transfer(msg.sender,ddddAmount)
		IRs:
			TMP_106(bool) = HIGH_LEVEL_CALL, dest:DDDD(IERC20), function:transfer, arguments:['msg.sender', 'ddddAmount']  
		Expression: user.claimedDDDD += ddddAmount
		IRs:
			REF_63(uint256) -> user.claimedDDDD
			REF_63(-> user) = REF_63 (c)+ ddddAmount
		Expression: user.lastClaimTime = block.timestamp + getFixedDay()
		IRs:
			REF_64(uint256) -> user.lastClaimTime
			TMP_107(uint256) = INTERNAL_CALL, ABCCApp.getFixedDay()()
			TMP_108(uint256) = block.timestamp (c)+ TMP_107
			REF_64(uint256) (->user) := TMP_108(uint256)
		Expression: globalData.claimedDDDD += ddddAmount
		IRs:
			REF_65(uint256) -> globalData.claimedDDDD
			REF_65(-> globalData) = REF_65 (c)+ ddddAmount
		Expression: staticUSDT > 0
		IRs:
			TMP_109(bool) = staticUSDT > 0
			CONDITION TMP_109
		Expression: processReferers(msg.sender,user.referer,staticUSDT)
		IRs:
			REF_66(address) -> user.referer
			INTERNAL_CALL, ABCCApp.processReferers(address,address,uint256)(msg.sender,REF_66,staticUSDT)
		Expression: OnClaimed(msg.sender,ddddAmount)
		IRs:
			Emit OnClaimed(msg.sender,ddddAmount)
		Expression: users[user.referer].activeCount > 1
		IRs:
			REF_67(address) -> user.referer
			REF_68(ABCCApp.User) -> users[REF_67]
			REF_69(uint256) -> REF_68.activeCount
			TMP_112(bool) = REF_69 > 1
			CONDITION TMP_112
		Expression: users[user.referer].activeCount = users[user.referer].activeCount - 1
		IRs:
			REF_70(address) -> user.referer
			REF_71(ABCCApp.User) -> users[REF_70]
			REF_72(uint256) -> REF_71.activeCount
			REF_73(address) -> user.referer
			REF_74(ABCCApp.User) -> users[REF_73]
			REF_75(uint256) -> REF_74.activeCount
			TMP_113(uint256) = REF_75 (c)- 1
			REF_72(uint256) (->users) := TMP_113(uint256)
		Expression: users[user.referer].activeCount = 0
		IRs:
			REF_76(address) -> user.referer
			REF_77(ABCCApp.User) -> users[REF_76]
			REF_78(uint256) -> REF_77.activeCount
			REF_78(uint256) (->users) := 0(uint256)
	Function ABCCApp.processReferers(address,address,uint256) (*)
		Expression: keepUSDT = 0
		IRs:
			keepUSDT(uint256) := 0(uint256)
		Expression: depth = 0
		IRs:
			depth(uint8) := 0(uint256)
		Expression: current != address(this) && current != address(0) && depth < 10
		IRs:
			TMP_114 = CONVERT this to address
			TMP_115(bool) = current != TMP_114
			TMP_116 = CONVERT 0 to address
			TMP_117(bool) = current != TMP_116
			TMP_118(bool) = TMP_115 && TMP_117
			TMP_119(bool) = depth < 10
			TMP_120(bool) = TMP_118 && TMP_119
			CONDITION TMP_120
		Expression: user = users[current]
		IRs:
			REF_79(ABCCApp.User) -> users[current]
			user(ABCCApp.User) := REF_79(ABCCApp.User)
		Expression: incomeUSDT = amountUSDT * REFERER_RATES[depth] / 100
		IRs:
			REF_80(uint256) -> REFERER_RATES[depth]
			TMP_121(uint256) = amountUSDT (c)* REF_80
			TMP_122(uint256) = TMP_121 (c)/ 100
			incomeUSDT(uint256) := TMP_122(uint256)
		Expression: user.remainingUSDT > 0 && user.activeCount > depth
		IRs:
			REF_81(uint256) -> user.remainingUSDT
			TMP_123(bool) = REF_81 > 0
			REF_82(uint256) -> user.activeCount
			TMP_124(bool) = REF_82 > depth
			TMP_125(bool) = TMP_123 && TMP_124
			CONDITION TMP_125
		Expression: user.dynamicUSDT += canUSDT
		IRs:
			REF_83(uint256) -> user.dynamicUSDT
			REF_83(-> user) = REF_83 (c)+ canUSDT
		Expression: user.remainingUSDT -= canUSDT
		IRs:
			REF_84(uint256) -> user.remainingUSDT
			REF_84(-> user) = REF_84 (c)- canUSDT
		Expression: user.remainingUSDT == 0
		IRs:
			REF_85(uint256) -> user.remainingUSDT
			TMP_126(bool) = REF_85 == 0
			CONDITION TMP_126
		Expression: userIncomeRecords[current].push(IncomeRecord({depth:depth,timestamp:block.timestamp,fromUser:sender,amount:canUSDT}))
		IRs:
			REF_86(ABCCApp.IncomeRecord[]) -> userIncomeRecords[current]
			TMP_127(ABCCApp.IncomeRecord) = new IncomeRecord(depth,block.timestamp,sender,canUSDT)
			REF_88 -> LENGTH REF_86
			TMP_129(uint256) := REF_88(uint256)
			TMP_130(uint256) = TMP_129 (c)+ 1
			REF_88(uint256) (->userIncomeRecords) := TMP_130(uint256)
			REF_89(ABCCApp.IncomeRecord) -> REF_86[TMP_129]
			REF_89(ABCCApp.IncomeRecord) (->userIncomeRecords) := TMP_127(ABCCApp.IncomeRecord)
		Expression: incomeUSDT -= canUSDT
		IRs:
			incomeUSDT(uint256) = incomeUSDT (c)- canUSDT
		Expression: keepUSDT += incomeUSDT
		IRs:
			keepUSDT(uint256) = keepUSDT (c)+ incomeUSDT
		Expression: current = user.referer
		IRs:
			REF_90(address) -> user.referer
			current(address) := REF_90(address)
		Expression: depth ++
		IRs:
			TMP_131(uint8) := depth(uint8)
			depth(uint8) = depth (c)+ 1
		Expression: globalData.retainUSDT += keepUSDT
		IRs:
			REF_91(uint256) -> globalData.retainUSDT
			REF_91(-> globalData) = REF_91 (c)+ keepUSDT
		Expression: user.remainingUSDT >= incomeUSDT
		IRs:
			REF_92(uint256) -> user.remainingUSDT
			TMP_132(bool) = REF_92 >= incomeUSDT
			CONDITION TMP_132
		Expression: canUSDT = incomeUSDT
		IRs:
			canUSDT(uint256) := incomeUSDT(uint256)
		Expression: canUSDT = user.remainingUSDT
		IRs:
			REF_93(uint256) -> user.remainingUSDT
			canUSDT(uint256) := REF_93(uint256)
		Expression: users[user.referer].activeCount > 1
		IRs:
			REF_94(address) -> user.referer
			REF_95(ABCCApp.User) -> users[REF_94]
			REF_96(uint256) -> REF_95.activeCount
			TMP_133(bool) = REF_96 > 1
			CONDITION TMP_133
		Expression: users[user.referer].activeCount = users[user.referer].activeCount - 1
		IRs:
			REF_97(address) -> user.referer
			REF_98(ABCCApp.User) -> users[REF_97]
			REF_99(uint256) -> REF_98.activeCount
			REF_100(address) -> user.referer
			REF_101(ABCCApp.User) -> users[REF_100]
			REF_102(uint256) -> REF_101.activeCount
			TMP_134(uint256) = REF_102 (c)- 1
			REF_99(uint256) (->users) := TMP_134(uint256)
		Expression: users[user.referer].activeCount = 0
		IRs:
			REF_103(address) -> user.referer
			REF_104(ABCCApp.User) -> users[REF_103]
			REF_105(uint256) -> REF_104.activeCount
			REF_105(uint256) (->users) := 0(uint256)
	Function ABCCApp.getUserDirects(address,uint256,uint256) (*)
		Expression: referrals = userDirects[_user]
		IRs:
			REF_106(ABCCApp.DirectReferral[]) -> userDirects[_user]
			referrals(ABCCApp.DirectReferral[]) = ['REF_106(ABCCApp.DirectReferral[])']
		Expression: len = referrals.length
		IRs:
			REF_107 -> LENGTH referrals
			len(uint256) := REF_107(uint256)
		Expression: len == 0 || page == 0 || pageSize == 0
		IRs:
			TMP_135(bool) = len == 0
			TMP_136(bool) = page == 0
			TMP_137(bool) = TMP_135 || TMP_136
			TMP_138(bool) = pageSize == 0
			TMP_139(bool) = TMP_137 || TMP_138
			CONDITION TMP_139
		Expression: new ABCCApp.DirectReferralInfo[](0)
		IRs:
			TMP_141(ABCCApp.DirectReferralInfo[])  = new ABCCApp.DirectReferralInfo[](0)
			RETURN TMP_141
		Expression: resultLen = end - start
		IRs:
			TMP_142(uint256) = end (c)- start
			resultLen(uint256) := TMP_142(uint256)
		Expression: result = new ABCCApp.DirectReferralInfo[](resultLen)
		IRs:
			TMP_144(ABCCApp.DirectReferralInfo[])  = new ABCCApp.DirectReferralInfo[](resultLen)
			result(ABCCApp.DirectReferralInfo[]) = ['TMP_144(ABCCApp.DirectReferralInfo[])']
		Expression: i = 0
		IRs:
			i(uint256) := 0(uint256)
		Expression: i < resultLen
		IRs:
			TMP_145(bool) = i < resultLen
			CONDITION TMP_145
		Expression: ref = referrals[end - 1 - i]
		IRs:
			TMP_146(uint256) = end (c)- 1
			TMP_147(uint256) = TMP_146 (c)- i
			REF_108(ABCCApp.DirectReferral) -> referrals[TMP_147]
			ref(ABCCApp.DirectReferral) := REF_108(ABCCApp.DirectReferral)
		Expression: result[i] = DirectReferralInfo({target:ref.target,timestamp:ref.timestamp,totalInvest:users[ref.target].investUSDT,directPerf:users[ref.target].directPerf,remainingUSDT:users[ref.target].remainingUSDT})
		IRs:
			REF_109(ABCCApp.DirectReferralInfo) -> result[i]
			REF_110(address) -> ref.target
			REF_111(uint256) -> ref.timestamp
			REF_112(address) -> ref.target
			REF_113(ABCCApp.User) -> users[REF_112]
			REF_114(uint256) -> REF_113.investUSDT
			REF_115(address) -> ref.target
			REF_116(ABCCApp.User) -> users[REF_115]
			REF_117(uint256) -> REF_116.directPerf
			REF_118(address) -> ref.target
			REF_119(ABCCApp.User) -> users[REF_118]
			REF_120(uint256) -> REF_119.remainingUSDT
			TMP_148(ABCCApp.DirectReferralInfo) = new DirectReferralInfo(REF_110,REF_111,REF_114,REF_117,REF_120)
			REF_109(ABCCApp.DirectReferralInfo) (->result) := TMP_148(ABCCApp.DirectReferralInfo)
		Expression: i ++
		IRs:
			TMP_149(uint256) := i(uint256)
			i(uint256) = i (c)+ 1
		Expression: result
		IRs:
			RETURN result
		Expression: len > page * pageSize
		IRs:
			TMP_150(uint256) = page (c)* pageSize
			TMP_151(bool) = len > TMP_150
			CONDITION TMP_151
		Expression: start = len - page * pageSize
		IRs:
			TMP_152(uint256) = page (c)* pageSize
			TMP_153(uint256) = len (c)- TMP_152
			start(uint256) := TMP_153(uint256)
		Expression: start = 0
		IRs:
			start(uint256) := 0(uint256)
		Expression: len > (page - 1) * pageSize
		IRs:
			TMP_154(uint256) = page (c)- 1
			TMP_155(uint256) = TMP_154 (c)* pageSize
			TMP_156(bool) = len > TMP_155
			CONDITION TMP_156
		Expression: end = len - (page - 1) * pageSize
		IRs:
			TMP_157(uint256) = page (c)- 1
			TMP_158(uint256) = TMP_157 (c)* pageSize
			TMP_159(uint256) = len (c)- TMP_158
			end(uint256) := TMP_159(uint256)
		Expression: end = 0
		IRs:
			end(uint256) := 0(uint256)
	Function ABCCApp.getIncomeRecords(address,uint256,uint256) (*)
		Expression: records = userIncomeRecords[user]
		IRs:
			REF_121(ABCCApp.IncomeRecord[]) -> userIncomeRecords[user]
			records(ABCCApp.IncomeRecord[]) = ['REF_121(ABCCApp.IncomeRecord[])']
		Expression: len = records.length
		IRs:
			REF_122 -> LENGTH records
			len(uint256) := REF_122(uint256)
		Expression: len == 0 || page == 0 || pageSize == 0
		IRs:
			TMP_160(bool) = len == 0
			TMP_161(bool) = page == 0
			TMP_162(bool) = TMP_160 || TMP_161
			TMP_163(bool) = pageSize == 0
			TMP_164(bool) = TMP_162 || TMP_163
			CONDITION TMP_164
		Expression: new ABCCApp.IncomeRecord[](0)
		IRs:
			TMP_166(ABCCApp.IncomeRecord[])  = new ABCCApp.IncomeRecord[](0)
			RETURN TMP_166
		Expression: resultLen = end - start
		IRs:
			TMP_167(uint256) = end (c)- start
			resultLen(uint256) := TMP_167(uint256)
		Expression: result = new ABCCApp.IncomeRecord[](resultLen)
		IRs:
			TMP_169(ABCCApp.IncomeRecord[])  = new ABCCApp.IncomeRecord[](resultLen)
			result(ABCCApp.IncomeRecord[]) = ['TMP_169(ABCCApp.IncomeRecord[])']
		Expression: i = 0
		IRs:
			i(uint256) := 0(uint256)
		Expression: i < resultLen
		IRs:
			TMP_170(bool) = i < resultLen
			CONDITION TMP_170
		Expression: result[i] = records[end - 1 - i]
		IRs:
			REF_123(ABCCApp.IncomeRecord) -> result[i]
			TMP_171(uint256) = end (c)- 1
			TMP_172(uint256) = TMP_171 (c)- i
			REF_124(ABCCApp.IncomeRecord) -> records[TMP_172]
			REF_123(ABCCApp.IncomeRecord) (->result) := REF_124(ABCCApp.IncomeRecord)
		Expression: i ++
		IRs:
			TMP_173(uint256) := i(uint256)
			i(uint256) = i (c)+ 1
		Expression: result
		IRs:
			RETURN result
		Expression: len > page * pageSize
		IRs:
			TMP_174(uint256) = page (c)* pageSize
			TMP_175(bool) = len > TMP_174
			CONDITION TMP_175
		Expression: start = len - page * pageSize
		IRs:
			TMP_176(uint256) = page (c)* pageSize
			TMP_177(uint256) = len (c)- TMP_176
			start(uint256) := TMP_177(uint256)
		Expression: start = 0
		IRs:
			start(uint256) := 0(uint256)
		Expression: len > (page - 1) * pageSize
		IRs:
			TMP_178(uint256) = page (c)- 1
			TMP_179(uint256) = TMP_178 (c)* pageSize
			TMP_180(bool) = len > TMP_179
			CONDITION TMP_180
		Expression: end = len - (page - 1) * pageSize
		IRs:
			TMP_181(uint256) = page (c)- 1
			TMP_182(uint256) = TMP_181 (c)* pageSize
			TMP_183(uint256) = len (c)- TMP_182
			end(uint256) := TMP_183(uint256)
		Expression: end = 0
		IRs:
			end(uint256) := 0(uint256)
	Function ABCCApp.setSettlePrice(uint256,uint256) (*)
		Expression: price == 0
		IRs:
			TMP_184(bool) = price == 0
			CONDITION TMP_184
		Expression: price = getDDDDValueInUSDT(1 * 10 ** 18)
		IRs:
			TMP_185(uint256) = 10 (c)** 18
			TMP_186(uint256) = 1 (c)* TMP_185
			TMP_187(uint256) = INTERNAL_CALL, ABCCApp.getDDDDValueInUSDT(uint256)(TMP_186)
			price(uint256) := TMP_187(uint256)
		Expression: targetTime == 0
		IRs:
			TMP_188(bool) = targetTime == 0
			CONDITION TMP_188
		Expression: targetTime = block.timestamp + getFixedDay()
		IRs:
			TMP_189(uint256) = INTERNAL_CALL, ABCCApp.getFixedDay()()
			TMP_190(uint256) = block.timestamp (c)+ TMP_189
			targetTime(uint256) := TMP_190(uint256)
		Expression: dailyPrices[targetTime / DAY] = price
		IRs:
			TMP_191(uint256) = targetTime (c)/ DAY
			REF_125(uint256) -> dailyPrices[TMP_191]
			REF_125(uint256) (->dailyPrices) := price(uint256)
		Expression: OnSettlePrice(targetTime,targetTime / DAY,price)
		IRs:
			TMP_192(uint256) = targetTime (c)/ DAY
			Emit OnSettlePrice(targetTime,TMP_192,price)
		Expression: onlyOwner()
		IRs:
			MODIFIER_CALL, Ownable.onlyOwner()()
	Function ABCCApp.setLevelRate(uint256,uint256) (*)
		Expression: require(bool,string)(index < REFERER_RATES.length,E0)
		IRs:
			REF_126 -> LENGTH REFERER_RATES
			TMP_195(bool) = index < REF_126
			TMP_196(None) = SOLIDITY_CALL require(bool,string)(TMP_195,E0)
		Expression: require(bool,string)(value < 100,E1)
		IRs:
			TMP_197(bool) = value < 100
			TMP_198(None) = SOLIDITY_CALL require(bool,string)(TMP_197,E1)
		Expression: REFERER_RATES[index] = value
		IRs:
			REF_127(uint256) -> REFERER_RATES[index]
			REF_127(uint256) (->REFERER_RATES) := value(uint256)
		Expression: onlyOwner()
		IRs:
			MODIFIER_CALL, Ownable.onlyOwner()()
	Function ABCCApp.setClaimFee(uint256) (*)
		Expression: require(bool,string)(target < 100,E0)
		IRs:
			TMP_200(bool) = target < 100
			TMP_201(None) = SOLIDITY_CALL require(bool,string)(TMP_200,E0)
		Expression: claimFee = target
		IRs:
			claimFee(uint256) := target(uint256)
		Expression: onlyOwner()
		IRs:
			MODIFIER_CALL, Ownable.onlyOwner()()
	Function ABCCApp.setUserRemainingUSDT(address,uint256) (*)
		Expression: require(bool,string)(users[target].joinTime > 0,E0)
		IRs:
			REF_128(ABCCApp.User) -> users[target]
			REF_129(uint256) -> REF_128.joinTime
			TMP_203(bool) = REF_129 > 0
			TMP_204(None) = SOLIDITY_CALL require(bool,string)(TMP_203,E0)
		Expression: old = users[target].remainingUSDT
		IRs:
			REF_130(ABCCApp.User) -> users[target]
			REF_131(uint256) -> REF_130.remainingUSDT
			old(uint256) := REF_131(uint256)
		Expression: users[target].remainingUSDT = value
		IRs:
			REF_132(ABCCApp.User) -> users[target]
			REF_133(uint256) -> REF_132.remainingUSDT
			REF_133(uint256) (->users) := value(uint256)
		Expression: old > 0
		IRs:
			TMP_205(bool) = old > 0
			CONDITION TMP_205
		Expression: value == 0
		IRs:
			TMP_206(bool) = value == 0
			CONDITION TMP_206
		Expression: users[target].activeCount --
		IRs:
			REF_134(ABCCApp.User) -> users[target]
			REF_135(uint256) -> REF_134.activeCount
			TMP_207(uint256) := REF_135(uint256)
			REF_135(-> users) = REF_135 (c)- 1
		Expression: old == 0
		IRs:
			TMP_208(bool) = old == 0
			CONDITION TMP_208
		Expression: value > 0
		IRs:
			TMP_209(bool) = value > 0
			CONDITION TMP_209
		Expression: users[target].activeCount ++
		IRs:
			REF_136(ABCCApp.User) -> users[target]
			REF_137(uint256) -> REF_136.activeCount
			TMP_210(uint256) := REF_137(uint256)
			REF_137(-> users) = REF_137 (c)+ 1
		Expression: onlyOwner()
		IRs:
			MODIFIER_CALL, Ownable.onlyOwner()()
	Function ABCCApp.getFixedDay() (*)
		Expression: fixedDay * DAY
		IRs:
			TMP_212(uint256) = fixedDay (c)* DAY
			RETURN TMP_212
	Function ABCCApp.addFixedDay(uint256) (*)
		Expression: target == 0
		IRs:
			TMP_213(bool) = target == 0
			CONDITION TMP_213
		Expression: fixedDay = 0
		IRs:
			fixedDay(uint256) := 0(uint256)
		Expression: fixedDay += target
		IRs:
			fixedDay(uint256) = fixedDay (c)+ target
	Function ABCCApp.getDDDDValueInUSDT(uint256) (*)
		Expression: tokenPriceInBNB = getTokenPriceInBNB()
		IRs:
			TMP_214(uint256) = INTERNAL_CALL, ABCCApp.getTokenPriceInBNB()()
			tokenPriceInBNB(uint256) := TMP_214(uint256)
		Expression: bnbPriceInUSDT = getBNBPriceInUSDT()
		IRs:
			TMP_215(uint256) = INTERNAL_CALL, ABCCApp.getBNBPriceInUSDT()()
			bnbPriceInUSDT(uint256) := TMP_215(uint256)
		Expression: valueInUSDT = (amount * tokenPriceInBNB * bnbPriceInUSDT) / (10 ** 18 * 10 ** 18)
		IRs:
			TMP_216(uint256) = amount (c)* tokenPriceInBNB
			TMP_217(uint256) = TMP_216 (c)* bnbPriceInUSDT
			TMP_218(uint256) = 10 (c)** 18
			TMP_219(uint256) = 10 (c)** 18
			TMP_220(uint256) = TMP_218 (c)* TMP_219
			TMP_221(uint256) = TMP_217 (c)/ TMP_220
			valueInUSDT(uint256) := TMP_221(uint256)
		Expression: valueInUSDT
		IRs:
			RETURN valueInUSDT
	Function ABCCApp.getTokenPriceInBNB() (*)
		Expression: tokenBnbPool = IUniswapV3(ddddBNBPool)
		IRs:
			TMP_222 = CONVERT ddddBNBPool to IUniswapV3
			tokenBnbPool(IUniswapV3) := TMP_222(IUniswapV3)
		Expression: (sqrtPriceX96,None,None,None,None,None,None) = tokenBnbPool.slot0()
		IRs:
			TUPLE_3(uint160,int24,uint16,uint16,uint16,uint32,bool) = HIGH_LEVEL_CALL, dest:tokenBnbPool(IUniswapV3), function:slot0, arguments:[]  
			sqrtPriceX96(uint160)= UNPACK TUPLE_3 index: 0 
		Expression: isToken0 = tokenBnbPool.token0() == address(DDDD)
		IRs:
			TMP_223(address) = HIGH_LEVEL_CALL, dest:tokenBnbPool(IUniswapV3), function:token0, arguments:[]  
			TMP_224 = CONVERT DDDD to address
			TMP_225(bool) = TMP_223 == TMP_224
			isToken0(bool) := TMP_225(bool)
		Expression: isToken0
		IRs:
			CONDITION isToken0
		Expression: price = (uint256(sqrtPriceX96) * uint256(sqrtPriceX96) * 10 ** 18) / Q96 / Q96
		IRs:
			TMP_226 = CONVERT sqrtPriceX96 to uint256
			TMP_227 = CONVERT sqrtPriceX96 to uint256
			TMP_228(uint256) = TMP_226 (c)* TMP_227
			TMP_229(uint256) = 10 (c)** 18
			TMP_230(uint256) = TMP_228 (c)* TMP_229
			TMP_231(uint256) = TMP_230 (c)/ Q96
			TMP_232(uint256) = TMP_231 (c)/ Q96
			price(uint256) := TMP_232(uint256)
		Expression: price = (Q96 * Q96 * 10 ** 18) / uint256(sqrtPriceX96) / uint256(sqrtPriceX96)
		IRs:
			TMP_233(uint256) = Q96 (c)* Q96
			TMP_234(uint256) = 10 (c)** 18
			TMP_235(uint256) = TMP_233 (c)* TMP_234
			TMP_236 = CONVERT sqrtPriceX96 to uint256
			TMP_237(uint256) = TMP_235 (c)/ TMP_236
			TMP_238 = CONVERT sqrtPriceX96 to uint256
			TMP_239(uint256) = TMP_237 (c)/ TMP_238
			price(uint256) := TMP_239(uint256)
		Expression: price
		IRs:
			RETURN price
	Function ABCCApp.getBNBPriceInUSDT() (*)
		Expression: bnbUsdtPool = IUniswapV3(bnbUSDTPool)
		IRs:
			TMP_240 = CONVERT bnbUSDTPool to IUniswapV3
			bnbUsdtPool(IUniswapV3) := TMP_240(IUniswapV3)
		Expression: (sqrtPriceX96,None,None,None,None,None,None) = bnbUsdtPool.slot0()
		IRs:
			TUPLE_4(uint160,int24,uint16,uint16,uint16,uint32,bool) = HIGH_LEVEL_CALL, dest:bnbUsdtPool(IUniswapV3), function:slot0, arguments:[]  
			sqrtPriceX96(uint160)= UNPACK TUPLE_4 index: 0 
		Expression: isBNBToken0 = bnbUsdtPool.token0() == address(BNB)
		IRs:
			TMP_241(address) = HIGH_LEVEL_CALL, dest:bnbUsdtPool(IUniswapV3), function:token0, arguments:[]  
			TMP_242 = CONVERT BNB to address
			TMP_243(bool) = TMP_241 == TMP_242
			isBNBToken0(bool) := TMP_243(bool)
		Expression: isBNBToken0
		IRs:
			CONDITION isBNBToken0
		Expression: price = (uint256(sqrtPriceX96) * uint256(sqrtPriceX96) * 10 ** 18) / Q96 / Q96
		IRs:
			TMP_244 = CONVERT sqrtPriceX96 to uint256
			TMP_245 = CONVERT sqrtPriceX96 to uint256
			TMP_246(uint256) = TMP_244 (c)* TMP_245
			TMP_247(uint256) = 10 (c)** 18
			TMP_248(uint256) = TMP_246 (c)* TMP_247
			TMP_249(uint256) = TMP_248 (c)/ Q96
			TMP_250(uint256) = TMP_249 (c)/ Q96
			price(uint256) := TMP_250(uint256)
		Expression: price = (Q96 * Q96 * 10 ** 18) / uint256(sqrtPriceX96) / uint256(sqrtPriceX96)
		IRs:
			TMP_251(uint256) = Q96 (c)* Q96
			TMP_252(uint256) = 10 (c)** 18
			TMP_253(uint256) = TMP_251 (c)* TMP_252
			TMP_254 = CONVERT sqrtPriceX96 to uint256
			TMP_255(uint256) = TMP_253 (c)/ TMP_254
			TMP_256 = CONVERT sqrtPriceX96 to uint256
			TMP_257(uint256) = TMP_255 (c)/ TMP_256
			price(uint256) := TMP_257(uint256)
		Expression: price
		IRs:
			RETURN price
	Function ABCCApp.emergencyFixed(address,address) (*)
		Expression: balance = IERC20(targetContract).balanceOf(address(this))
		IRs:
			TMP_258 = CONVERT targetContract to IERC20
			TMP_259 = CONVERT this to address
			TMP_260(uint256) = HIGH_LEVEL_CALL, dest:TMP_258(IERC20), function:balanceOf, arguments:['TMP_259']  
			balance(uint256) := TMP_260(uint256)
		Expression: balance > 0
		IRs:
			TMP_261(bool) = balance > 0
			CONDITION TMP_261
		Expression: IERC20(targetContract).transfer(recipient,balance)
		IRs:
			TMP_262 = CONVERT targetContract to IERC20
			TMP_263(bool) = HIGH_LEVEL_CALL, dest:TMP_262(IERC20), function:transfer, arguments:['recipient', 'balance']  
		Expression: onlyOwner()
		IRs:
			MODIFIER_CALL, Ownable.onlyOwner()()
	Function ABCCApp.slitherConstructorVariables() (*)
		Expression: USDT = IERC20(0x55d398326f99059fF775485246999027B3197955)
		IRs:
			TMP_265 = CONVERT 489982930986835137684486657990555633941558688085 to IERC20
			USDT(IERC20) := TMP_265(IERC20)
		Expression: DDDD = IERC20(0x422cBee1289AAE4422eDD8fF56F6578701Bb2878)
		IRs:
			TMP_266 = CONVERT 377791251614940615760839320564950829552830720120 to IERC20
			DDDD(IERC20) := TMP_266(IERC20)
		Expression: BNB = IERC20(0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c)
		IRs:
			TMP_267 = CONVERT 1069295261705322660692659746119710186699350608220 to IERC20
			BNB(IERC20) := TMP_267(IERC20)
		Expression: swapV3Router = IUniswapV3(0x1b81D678ffb9C0263b24A97847620C99d213eB14)
		IRs:
			TMP_268 = CONVERT 157038230145845155840551490049332782884243893012 to IUniswapV3
			swapV3Router(IUniswapV3) := TMP_268(IUniswapV3)
		Expression: ddddBNBPool = 0xB7021120a77d68243097BfdE152289DB6d623407
		IRs:
			ddddBNBPool(address) := 1044791404571688500216421393362481768386164569095(address)
		Expression: bnbUSDTPool = 0x36696169C63e42cd08ce11f5deeBbCeBae652050
		IRs:
			bnbUSDTPool(address) := 310635565755227377635089068187821450542677565520(address)
		Expression: vaultAddr = 0xa446DC212f4AaE662e1B5fF8729e99A4eFE7a174
		IRs:
			vaultAddr(address) := 937854714574091404243610287560592265876909564276(address)
		Expression: partUSDT = 100000000000000000000
		IRs:
			partUSDT(uint256) := 100000000000000000000(uint256)
		Expression: claimFee = 5
		IRs:
			claimFee(uint256) := 5(uint256)
		Expression: isEnable = true
		IRs:
			isEnable(bool) := True(bool)
		Expression: fixedDay = 0
		IRs:
			fixedDay(uint256) := 0(uint256)
		Expression: REFERER_RATES = (40,20,5,5,5,5,5,5,5,5)
		IRs:
			REFERER_RATES(uint256[]) = ['40(uint256)', '20(uint256)', '5(uint256)', '5(uint256)', '5(uint256)', '5(uint256)', '5(uint256)', '5(uint256)', '5(uint256)', '5(uint256)']
	Function ABCCApp.slitherConstructorConstantVariables() (*)
		Expression: DAY = 86400
		IRs:
			DAY(uint256) := 86400(uint256)
		Expression: Q96 = 2 ** 96
		IRs:
			TMP_269(uint256) = 2 (c)** 96
			Q96(uint256) := TMP_269(uint256)
	Modifier Ownable.onlyOwner()
		Expression: _checkOwner()
		IRs:
			INTERNAL_CALL, Ownable._checkOwner()()
	Modifier ABCCApp.isOperator()
		Expression: require(bool,string)(isOperators[msg.sender],No Operator)
		IRs:
			REF_144(bool) -> isOperators[msg.sender]
			TMP_271(None) = SOLIDITY_CALL require(bool,string)(REF_144,No Operator)
Contract Ownable
	Function Context._msgSender() (*)
		Expression: msg.sender
		IRs:
			RETURN msg.sender
	Function Context._msgData() (*)
		Expression: msg.data
		IRs:
			RETURN msg.data
	Function Context._contextSuffixLength() (*)
		Expression: 0
		IRs:
			RETURN 0
	Function Ownable.constructor(address) (*)
		Expression: initialOwner == address(0)
		IRs:
			TMP_272 = CONVERT 0 to address
			TMP_273(bool) = initialOwner == TMP_272
			CONDITION TMP_273
		Expression: revert OwnableInvalidOwner(address)(address(0))
		IRs:
			TMP_274 = CONVERT 0 to address
			TMP_275(None) = SOLIDITY_CALL revert OwnableInvalidOwner(address)(TMP_274)
		Expression: _transferOwnership(initialOwner)
		IRs:
			INTERNAL_CALL, Ownable._transferOwnership(address)(initialOwner)
	Function Ownable.owner() (*)
		Expression: _owner
		IRs:
			RETURN _owner
	Function Ownable._checkOwner() (*)
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
	Function Ownable.renounceOwnership() (*)
		Expression: _transferOwnership(address(0))
		IRs:
			TMP_282 = CONVERT 0 to address
			INTERNAL_CALL, Ownable._transferOwnership(address)(TMP_282)
		Expression: onlyOwner()
		IRs:
			MODIFIER_CALL, Ownable.onlyOwner()()
	Function Ownable.transferOwnership(address) (*)
		Expression: newOwner == address(0)
		IRs:
			TMP_285 = CONVERT 0 to address
			TMP_286(bool) = newOwner == TMP_285
			CONDITION TMP_286
		Expression: revert OwnableInvalidOwner(address)(address(0))
		IRs:
			TMP_287 = CONVERT 0 to address
			TMP_288(None) = SOLIDITY_CALL revert OwnableInvalidOwner(address)(TMP_287)
		Expression: _transferOwnership(newOwner)
		IRs:
			INTERNAL_CALL, Ownable._transferOwnership(address)(newOwner)
		Expression: onlyOwner()
		IRs:
			MODIFIER_CALL, Ownable.onlyOwner()()
	Function Ownable._transferOwnership(address) (*)
		Expression: oldOwner = _owner
		IRs:
			oldOwner(address) := _owner(address)
		Expression: _owner = newOwner
		IRs:
			_owner(address) := newOwner(address)
		Expression: OwnershipTransferred(oldOwner,newOwner)
		IRs:
			Emit OwnershipTransferred(oldOwner,newOwner)
	Modifier Ownable.onlyOwner()
		Expression: _checkOwner()
		IRs:
			INTERNAL_CALL, Ownable._checkOwner()()
Contract IERC20
	Function IERC20.totalSupply() (*)
	Function IERC20.balanceOf(address) (*)
	Function IERC20.transfer(address,uint256) (*)
	Function IERC20.allowance(address,address) (*)
	Function IERC20.approve(address,uint256) (*)
	Function IERC20.transferFrom(address,address,uint256) (*)
Contract Context
	Function Context._msgSender() (*)
		Expression: msg.sender
		IRs:
			RETURN msg.sender
	Function Context._msgData() (*)
		Expression: msg.data
		IRs:
			RETURN msg.data
	Function Context._contextSuffixLength() (*)
		Expression: 0
		IRs:
			RETURN 0

INFO:Slither:contracts/ABCCApp.sol analyzed (5 contracts)
```
